# -*- coding: utf-8 -*-
# operation
# 2099/12/31を修正する時は　2100/01/01の修正も
module Operation
	extend self
	###schsの追加
	def proc_add_update_table_from_nditm  child,paerent  ### id processreqsのid
		opeitm  = proc_get_opeitms_rec(child["nditm_itm_id_nditm"],child["nditm_loca_id_nditm"],nil,nil)
		ControlField.fields_update paerent do |command_c,para|
				command_c[:sio_viewname] =  "r_"+ chil_opeitm["prdpurshp"]+"schs" 
				command_c["id"]=""
				para["opeitms_id"] = opeitm["opeitms_id"]
				para["duration"] =  opeitm["duration"]
				para["pare_qty"] = 0
				paerent.each do |key,val|
					if key =~ /^opeitm_loca_id/
						para["locas_id"] = val
					end	
					if key =~ /processseq_pare$/
						para["processseq_pare"] = val
					end	
					if key =~ /starttime/
						para["parent_starttime"] = val
					end	
					if key =~ /chrg_id/
						para["chrgs_id"] = val
					end	
					if key =~ /_qty$/
						para["pare_qty"] = val
					end
				end	
				para["parenum"] = child["nditm_parenum"]
				para["chilnum"] = child["nditm_chilnum"]
		end	
	end	
	###schsの修正
	def fields_update_from_pare_source trngantt
		strsql = %Q% select * from r_#{trngantt["orgtblname"]} where id = #{trngantt["orgtblid"]}
		%
		src = ActiveRecord::Base.connection.select_one(strsql)
		strsql = %Q% select * from r_#{trngantt["paretblname"]} where id = #{trngantt["paretblid"]}
		%
		parent = ActiveRecord::Base.connection.select_one(strsql)
		ControlField.fields_update  parent do |command_c,para|
			command_c[:sio_viewname] =  "r_"+trngantt["orgtblname"] 
			command_c["id"] = trngantt["orgtblid"]
			src.each do |key,val|
				if key =~ /opeitm_id/
					para["opeitms_id"] = val
				end
				if key =~ /opeitm_duration/
					para["duration"] = val
				end
				command_c[key] = val
			end	
			@pare_qty = 0
			parent.each do |key,val|
				if key =~ /^opeitm_loca_id/
					para["locas_id"] = val
				end	
				if key =~ /processseq_pare$/
					para["processseq_pare"] = val
				end		
				if key =~ /starttime/
					para["parent_starttime"] = val
				end		
				if key =~ /chrg_id/
					para["chrgs_id"] = val
				end	
				if key =~ /_qty$/
					para["pare_qty"] = val
				end	
			end	
			para["parenum"] = trngantt["parenum"]
			para["chilnum"] = trngantt["chilnum"]
		end
	end
	def proc_get_opeitms_rec itms_id,locas_id,processseq = nil,priority = nil  ###
		strsql = %Q& select * from opeitms where itms_id = #{itms_id} #{if locas_id then " and locas_id = " + locas_id.to_s else "" end}
		           and processseq = #{processseq ||= 999}
				   #{if priority then " and priority = " + priority.to_s else "" end}
				   and expiredate > current_date  order by  priority desc &
		rec = ActiveRecord::Base.connection.select_one(strsql)
        if rec
	        rec
		  else
            Rails.logger.debug "error class logic err proc_get_opeitms_rec itms_id = #{itms_id} ,locas_id = #{locas_id}, processseq = #{processseq ||= 999} ,
					priority = = #{priority ||= 999} ,expiredate > #{Date.today}"
            raise
        end
	end
	def proc_trn_org   paretblname,paretblid,orgtblname,orgtblid
		strsql = "select * from trngannts where  paretblname = '#{paretblname}' and paretblid =  #{paretblid ||=0 } and
												 orgtblname = '#{orgtblname} and orgtblid = #{orgtblid} "
		trn = ActiveRecord::Base.connection.select_one(strsql)
		if  (paretblname.nil? or paretblname == orgtblname)  and (paretblid.nil? or  paretblid == orgtblid)
			if trn
			else
				create_trn_init( orgtblname,orgtblid) do
					strsql = "select * from #{orgtblname} where id = #{orgtblid} "
					rec = ActiveRecord::Base.connection.select_one(strsql)
				end	
			end	
		else
			if trn
			else
				create_trn_init( orgtblname,orgtblid) do
					rec = {"qty"=>0,"qty_stk"=>0		
					}
				end	
				create_trn_alloc( paretblname,paretblid,orgtblname,orgtblid)
			end	
		end
	end
	def create_trn_init orgtblname,orgtblid
		strsql = "select shuffle_flg from opeitms where id = #{rec["opeitms"]} "
		shuffle_flg = ActiveRecord::Base.connection.select_value(strsql)
		trngantts_id = proc_get_nextval("trngantts_seq")
		yield
		strsql = %Q%
		insert into trngantts(id,key,orgtblname,orgtblid,paretblname,paretblid,
								mlevel,
								shuffle_flg,
								parenum,chilnum,
								qty,qty_stk,
								consumunitqty,consumminqty,consumchgoverq,
								created_at,updated_at,
								update_ip,persons_id_upd,contents,remark)
						values(#{trngantts_id},'00000','#{orgtblname}',#{orgtblid},'#{orgtblname}',#{orgtblid},
								0,
								'#{shuffle_flg}',
								1,1,
								#{if rec["qty"] then  rec["qty"] else 0 end},#{if rec["qty_stk"] then  rec["qty_stk"] else 0 end},
								0,0,0,
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								'',#{@sio_user_code},
								'0')
		%
		ActiveRecord::Base.connection.insert(strsql)

	end	
	def create_trn_alloc paretblname,paretblid,orgtblname,orgtblid
		strsql = "select * from #{orgtblname} where id = #{orgtblid} "
		rec = ActiveRecord::Base.connection.select_one(strsql)
		delm = orgtblname[0..2]
		strsql = "select shuffle_flg from opeitms where id = #{rec["opeitms_id_#{delm}"]} "
		shuffle_flg = ActiveRecord::Base.connection.select_value(strsql)
		strsql = "select * from #{paretblname} where id = #{paretblid} "
		pare = ActiveRecord::Base.connection.select_one(strsql)
		strsql = %Q% select * from nditms where opeitms_id = #{rec["opeitms_id_#{delm}"]} 
											and %
		trngantts_id = proc_get_nextval("trngantts_seq")
		strsql = %Q%
		insert into trngantts(id,key,paretblname,paretblid,paretblname,paretblid,
								mlevel,
								shuffle_flg,
								parenum,chilnum,
								qty,qty_stk,
								consumunitqty,consumminqty,consumchgoverq,
								created_at,updated_at,
								update_ip,persons_id_upd,contents,remark)
						values(#{trngantts_id},'00000','#{paretblname}',#{paretblid},'#{orgtblname}',#{orgtblid},
								0,
								'#{shuffle_flg}',
								1,#{rec["qty"]/(if pare["qty"]==0 then 1 else pare["qty"] end ) }
								#{if rec["qty"] then  rec["qty"] else 0 end},#{if rec["qty_stk"] then  rec["qty_stk"] else 0 end},
								xxxxxxxxxx,xxxxxxxxxxxx,xx,
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								'',#{@sio_user_code},
								'0')
		%
		ActiveRecord::Base.connection.insert(strsql)

	end	 
	def err_proc req
		yield   
		req["updated_at"] = Time.now
		RorBlkctl.proc_tbl_edit_arel   "processreqs",req," id = #{req["id"]} "   
	end
	def update_trngantt child
	  child["updated_at"] = Time.now
	  RorBlkctl.proc_tbl_edit_arel   "trngantts",child," id = #{chil["id"]} "   
	end 
	def roc_chg_free_trn  child,save_child_qty
	end	   
end   ##module