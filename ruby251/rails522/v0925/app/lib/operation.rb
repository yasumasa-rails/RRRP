# -*- coding: utf-8 -*-
# operation
# 2099/12/31を修正する時は　2100/01/01の修正も
module Operation
	extend self
	def proc_create_table_from_nditm   opeitms_id,operation,tblname,tblid,id   ### id processreqsのid
		parent_strsql = %Q%
		select * from r_#{tblname} where id = #{tblid} 
		%
		parent = ActiveRecord::Base.connection.select_one(parent_strsql)

		@command_c ={}
		@command_c[:screenCode] = "r_#{tblname}"

		strsql = %Q%
		select * from r_nditms where nditm_expiredate > current_date and nditm_opeitm_id = #{opeitms_id} 
		%
		ActiveRecord::Base.connection.select_all(strsql).each do |part|
			chil_opeitm = proc_get_opeitms_rec part["nditm_itm_id_nditm"],nil,part["nditm_processseq"],nil
			@chil_tblname = chil_opeitm["prdpurshp"]+operation.chop
			chil_strsql =  %Q%
			select pobject_code_fld from tblfields where expiredate > current_date and 
							id in (select id from r_tblfields where pobject_code_tbl = '#{@chil_tblname}s' order by seqno
			%
			ActiveRecord::Base.connection.select_values(chil_strsql).each do |fd|
				fd.each do |field|
					case field
					when "id"  ###追加または更新の判断
						field_tblid tblname
					when "confirm"
						field_confirm
					when "opeitms_id"
						field_opeitms_id part["itms_id_nditm"],part["processseq_nditm"]
					when "locas_id_to"
						field_locas_id_to parent["opeitm_loca_id"]
					when "processseq_pare"
						field_processseq_pare opeitm["opeitm_processseq"]
					when "isudate"
						field_isudate 
					when "start_time"  ###稼働日計算
						field_starttime_duedate parent["#{tblname.chop}_starttime"],part["duration"]
					when "chrgs_id"
						field_chrgs_id parent["#{tblname.chop}_chrg_id"]
					when "qty"
						field_qty_qty_case parent["#{tblname.chop}_qty"],part["parenum"],part["chilnum"],part["consumunitqty"]
					when "price"  ###保留
						field_price_amt_tax_contract_price 
					when "sno"
						field_sno
					when "cno"
						field_cno
					when "gno"
						field_gno
					when "prjnos_id"
						field_prjnos_id parent["#{tblname.chop}_prjno_id"]
					when "consumtype"  ###proc_create_table_from_nditmの時は常にopeitmsから
						field_consumtype_consumauto opeitm["opeitm_consumtype"],opeitm["opeitm_consumauto"]
					when "autocreate_ord"
						field_autocreate_ord_autoord_p opeitm["opeitm_autocreate_ord"],opeitm["opeitm_autoord_p"]
					when "autocreate_inst"
						field_autocreate_inst_autoinst_p opeitm["opeitm_autocreate_inst"],opeitm["opeitm_autoinst_p"]
					when "autocreate_act"
						field_autocreate_act_autoact_p opeitm["opeitm_autocreate_act"],opeitm["opeitm_autoact_p"]
					when "expiredate"
						field_expiredate
					end	
				end
			end	
			@command_c =  RorBlkctl.init_from_screen current_api_user,@command_c
			RorBlkctl.proc_update_table(@command_c,1)
		end		
	end	 
	def	field_tblid
		if @command_c["id"] == ""
			@command_c[:sio_classname] = "_add_update_grid_line_data"
	 	else         
			@command_c[:sio_classname] = "_edit_update_grid_line_data"
	 	end   
		@command_c["id"] = ""
		@command_c["#{@chil_tblname}_id"] = @command_c["id"]
	end	
	def field_confirm
		@command_c["#{@chil_tblname}_confirm"]
	end	
	def field_opeitms_id itms_id,processseq
		opeitm_id =  proc_get_opeitms_rec itms_id,nil,processseq ,999
		@command_c["#{@chil_tblname}_opeitm_id"] = opeitm_id
	end
	def field_locas_id_to locas_id
		@command_c["#{@chil_tblname}_loca_id_to"] = locas_id
	end 	
	def field_processseq_pare processseq_pare
		@command_c["#{@chil_tblname}_processseq_pare"] = processseq_pare
	end	
	def field_isudate
		@command_c["#{@chil_tblname}_isudate"] = Time.now
	end	 
	def field_starttime_duedate parent_starttime,duration
		@command_c["#{@chil_tblname}_duedate"] = parent_starttime - 1*24*60*60
		@command_c["#{@chil_tblname}_starttime"] =  @command_c["#{@chil_tblname}_duedate"] - duration*24*60*60
	end
	def field_chrgs_id chrgs_id
		@command_c["#{@chil_tblname}_charg_id"] = chrgs_id
	end	

	def field_qty_qty_case pare_qty,parenum,chilnum,consumunitqty
		@command_c["#{@chil_tblname}_qty"] = pare_qty * chilnum / parenum
		if consumunitqty > @command_c["#{@chil_tblname}_qty"]
			@command_c["#{tblnamechop}_qty"] = consumunitqty
		end	
	end	
	
	def field_price_amt_tax_contract_price 
		@command_c["#{@chil_tblname}_price"] = 0
		@command_c["#{@chil_tblname}_amt"] = 0
		@command_c["#{@chil_tblname}_tax"] = 0
	end
	def field_sno
		@command_c["#{@chil_tblname}_sno"] = snolist["#{@chil_tblname}s"] +　format('%05d', @command_c["id"])
	end
	def snolist
		{"purschs"=>"PS","purords"=>"PO","purinsts"=>"PI","puracts"=>"PA","purrets"=>"PR",
			"prdschs"=>"MS","prdords"=>"MO","prdinsts"=>"PR","puracts"=>"MA","prdrets"=>"MR",
			"shpschs"=>"SS","shpords"=>"SO","shpinsts"=>"SR","shpacts"=>"SA","shprets"=>"SR"}
	end
	def field_cno
		@command_c["#{@chil_tblname}_cno"] = format('%07d', @command_c["id"])
	end

	def field_gno
		@command_c["#{@chil_tblname}_cno"] = format('%07d', @command_c["id"])
	end	

	def field_prjnos_id prjnos_id
		@command_c["#{@chil_tblname}_prjno_id"] = prjnos_id
	end	

	def field_consumtype_consumauto consumtype,consumauto 
		@command_c["#{@chil_tblname}_consumtype"] = consumtype
		@command_c["#{@chil_tblname}_consumauto"] = consumauto
	end

	def field_autocreate_ord_autoord_p opeitm_autocreate_ord,opeitm_autoord_p
		@command_c["#{tblnamechop}_autocreate_ord"] = autocreate_ord
		@command_c["#{tblnamechop}_autoord_p"] = autoord_p
	end	

	def field_autocreate_inst_autoinst_p opeitm_autocreate_inst,opeitm_autoinst_p
		@command_c["#{tblnamechop}_autocreate_inst"] = autocreate_inst
		@command_c["#{tblnamechop}_autoinst_p"] = autoinst_p
	end		

	def field_autocreate_inst_autoinst_p opeitm_autocreate_act,opeitm_autoact_p
		@command_c["#{tblnamechop}_autocreate_act"] = autocreate_act
		@command_c["#{tblnamechop}_autoact_p"] = autoact_p
		
	def field_expiredate
		@command_c["#{@chil_tblname}_expiredate"] = "2099/12/31"
	end	

	def proc_get_opeitms_rec itms_id,locas_id,processseq = nil,priority = nil  ###
		strsql = %Q& select * from opeitms where itms_id = #{itms_id} #{if locas_id then " and locas_id = " + locas_id.to_s else "" end}
		           and processseq = #{processseq ||= 999}
				   #{if priority then " and priority = " + priority.to_s else "" end}
				   and expiredate > current_date &
		rec = ActiveRecord::Base.connection.select_one(strsql)
        if rec
	        rec
		  else
            Rails.logger.debug "error class logic err proc_get_opeitms_rec itms_id = #{itms_id} ,locas_id = #{locas_id}, processseq = #{processseq ||= 999} ,
					priority = = #{priority ||= 999} ,expiredate > #{Date.today}"
            raise
        end
  end 
end   ##module Ror_blk
