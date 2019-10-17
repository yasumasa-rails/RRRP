  
# -*- coding: utf-8 -*-
module ControlFields
### prd,pur,ots,shp ・・・schs,ords,insts,acts,retsのレコード作成　	
	extend self	
	def fields_update parent
		@command_c = {}
		@para = {}
		yield @command_c,@para
		@command_c[:sio_message_contents] = nil
		@command_c[:sio_recordcount] = 1
		@command_c[:sio_result_f] =   "0"  

		@tblnamechop = @command_c[:sio_code].split("_")[1].chop

		@command_c[:sio_code] =  @command_c[:sio_viewname] if @command_c[:sio_code].nil?

		strsql =  %Q%
		select pobject_code_fld from r_tblfields where tblfield_expiredate > current_date and 
						id in (select id from r_tblfields where pobject_code_tbl = '#{@command_c[:sio_code].split("_")[1]}')
						 order by tblfield_seqno
		%
		ActiveRecord::Base.connection.select_values(strsql).each do |fd|
			case fd
				when "id"  ###追加または更新の判断
						field_tblid
				when "confirm"
						field_confirm
				when /opeitms_id/
						field_opeitms_id fd
				when "locas_id_to"
						field_locas_id_to
				when "processseq_pare"
						field_processseq_pare
				when "isudate"
						if @command_c[:sio_classname] == "_add_update_grid_line_data"
							field_isudate 
						end
				when "start_time"  ###稼働日計算
						field_starttime_duedate
				when "chrgs_id"
						field_chrgs_id 
				when "qty"
						field_qty_qty_case 
				when "qty_stk"
						field_qty_stk 
				when "price"  ###保留
						field_price_amt_tax_contract_price 
				when "sno"
						field_sno
				when "cno"
						field_cno
				when "gno"
						field_gno
				when "prjnos_id"
						field_prjnos_id
				when "consumtype"  ###proc_create_table_from_nditmの時は常にopeitmsから
						field_consumtype_consumauto 
				when "autocreate_ord"
						field_autocreate_ord_autoord_p 
				when "autocreate_inst"
						field_autocreate_inst 
				when "autocreate_act"
						field_autocreate_act 
				when "expiredate"
						field_expiredate
			end	
		end		
		command_r = RorBlkctl.proc_update_table(@command_c,1,@tblnamechop+"s",parent["id"],parent)
		return command_r
	end	 

	def	field_tblid
		if @command_c["id"] == ""
			@command_c[:sio_classname] = "_add_update_grid_line_data"
			@command_c["id"] =  RorBlkctl.proc_get_nextval("#{@tblnamechop}s_seq")
	 	else         
			@command_c[:sio_classname] = "_edit_update_grid_line_data"
	 	end   
		@command_c["#{@tblnamechop}_id"] = @command_c["id"]
	end	

	def field_confirm
		@command_c["#{@tblnamechop}_confirm"] = false if @command_c["#{@tblnamechop}_confirm"].nil? or  @command_c["#{@tblnamechop}_confirm"] == ""
	end	

	def field_opeitms_id fd
		key = @tblnamechop + "_" + fd.sub("s_id","_id")
		@command_c[key] = @para["opeitms_id"]  ###  変更はないはず
	end

	def field_locas_id_to 
		@command_c["#{@tblnamechop}_loca_id_to"] = @para["locas_id"] #####変更されるかも
	end 

	def field_processseq_pare 
		@command_c["#{@tblnamechop}_processseq_pare"] = @para["processseq_pare"] 
	end	

	def field_isudate
		@command_c["#{@tblnamechop}_isudate"] = Time.now if @command_c["#{@tblnamechop}_isudate"].nil? or @command_c["#{@tblnamechop}_isudate"] == ""
	end	 

	def field_starttime_duedate 
		@command_c["#{@tblnamechop}_duedate"] = @para["parent_starttime"] - 1*24*60*60 
		@command_c["#{@tblnamechop}_starttime"] =  @command_c["#{@tblnamechop}_duedate"] - @para["duration"]*24*60*60 
	end

	def field_chrgs_id 
		@command_c["#{@tblnamechop}_chrg_id"] = @para["chrgs_id"] if @command_c["#{@tblnamechop}_chrg_id"].nil? or  @command_c["#{@tblnamechop}_chrg_id"] == ""
	end	

	def field_qty_qty_case 
		@command_c["#{@tblnamechop}_qty"] = @para["pare_qty"] * @para["chilnum"] / @para["parenum"]
		@command_c["#{@tblnamechop}_qty_case"] = @command_c["#{@tblnamechop}_qty"]
		if @para["consumunitqty"] > 0
			rlst = (@command_c["#{@tblnamechop}_qty"] /  @para["consumunitqty"]).ceil
			@command_c["#{tblnamechop}_qty_case"] = @para["consumunitqty"] * rlst
		end	
		if @para["consumminqty"] > @command_c["#{@tblnamechop}_qty"]
			@command_c["#{tblnamechop}_qty"] = @para["consumminqty"]
		end	
	end	

	def field_qty_stk 
		@command_c["#{@tblnamechop}_qty_stk"] = @para["pare_qty"] * @para["chilnum"] / @para["parenum"]
		if @consumminqty > @command_c["#{@tblnamechop}_qty_stk"]
			@command_c["#{tblnamechop}_qty_stk"] = @para["consumunitqty"]
		end	
	end	

	def field_price_amt_tax_contract_price 
		@command_c["#{@tblnamechop}_price"] = 0 if @command_c["#{@tblnamechop}_price"].nil?
		@command_c["#{@tblnamechop}_amt"] = 0 if @command_c["#{@tblnamechop}_amt"].nil?
		@command_c["#{@tblnamechop}_tax"] = 0 if @command_c["#{@tblnamechop}_tax"].nil?
	end

	def field_sno
		@command_c["#{@tblnamechop}_sno"] = snolist["#{@tblnamechop}s"] + format('%05d', @command_c["id"]) if @command_c["#{@tblnamechop}_sno"].nil? or  @command_c["#{@tblnamechop}_sno"] == ""
	end

	def snolist
		{"purschs"=>"PS","purords"=>"PO","purinsts"=>"PI","puracts"=>"PA","purrets"=>"PR",
			"prdschs"=>"MS","prdords"=>"MO","prdinsts"=>"MI","prdacts"=>"MA","prdrets"=>"MR",
			"otsschs"=>"TS","otsords"=>"TO","otsinsts"=>"TI","otsacts"=>"TA","otsrets"=>"TR",
			"shpschs"=>"SS","shpords"=>"SO","shpinsts"=>"SR","shpacts"=>"SA","shprets"=>"SR"}
	end

	def field_cno
		@command_c["#{@tblnamechop}_cno"] = format('%07d', @command_c["id"]) if @command_c["#{@tblnamechop}_cno"].nil? or  @command_c["#{@tblnamechop}_cno"] == ""
	end

	def field_gno
		@command_c["#{@tblnamechop}_gno"] = format('%07d', @command_c["id"]) if @command_c["#{@tblnamechop}_gno"].nil? or @command_c["#{@tblnamechop}_gno"] == ""
	end	

	def field_prjnos_id 
		@command_c["#{@tblnamechop}_prjno_id"] = @para["prjnos_id"]
	end	

	def field_consumtype_consumauto
		@command_c["#{@tblnamechop}_consumtype"] = @para["consumtype"] if @command_c["#{@tblnamechop}_consumtype"].nil? or  @command_c["#{@tblnamechop}_consumtype"] == ""
		@command_c["#{@tblnamechop}_consumauto"] = @para["consumauto"] if @command_c["#{@tblnamechop}_consumauto"].nil? or  @command_c["#{@tblnamechop}_consumauto"] == ""
	end

	def field_autocreate_ord_autoord_p opeitm_autocreate_ord,opeitm_autoord_p
		if @command_c["#{@tblnamechop}_autocreate_ord"].nil? or  @command_c["#{@tblnamechop}_autocreate_ord"] == "" 
			@command_c["#{@tblnamechop}_autocreate_ord"] = @para["autocreate_ord"] 
			@command_c["#{@tblnamechop}_autoord_p"] = @para["autoord_p"] 
		end
	end	

	def field_autocreate_inst 
		@command_c["#{@tblnamechop}_autocreate_inst"] = @para["autocreate_inst"] if @command_c["#{@tblnamechop}_autocreate_inst"].nil? or  @command_c["#{@tblnamechop}_autocreate_inst"] == ""
	end		

	def field_autocreate_act 
		@command_c["#{@tblnamechop}_autocreate_act"] = @para["autocreate_act"] if @command_c["#{@tblnamechop}_autocreate_act"].nil? or  @command_c["#{@tblnamechop}_autocreate_act"] == ""
	end	
		
	def field_expiredate
		@command_c["#{@tblnamechop}_expiredate"] = "2099/12/31" if @command_c["#{@tblnamechop}_expiredate"].nil? or @command_c["#{@tblnamechop}_expiredate"] == ""
	end	

end   ##module