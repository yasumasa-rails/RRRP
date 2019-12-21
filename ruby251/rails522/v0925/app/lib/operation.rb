# -*- coding: utf-8 -*-
# operation
# 2099/12/31を修正する時は　2100/01/01の修正も
module Operation
	extend self

	###schsの追加	paretblname =~ /schs$|ords$/の時呼ばれる 
	def proc_add_update_table_from_nditm  child,parent ### id processreqsのid child-->nditms  parent ===> r_prd,pur XXXs
		opeitm  = proc_get_opeitms_rec(child["itms_id_nditm"],nil,child["processseq_nditm"],nil)
		command_r = fields_update parent do |command_c,para|
				command_c[:sio_viewname] =  "r_"+ opeitm["prdpurshp"]+"schs" 
				command_c["id"]=""
				para["opeitms_id"] = opeitm["id"]
				para["duration"] =  opeitm["duration"].to_f
				para["parenum"] = child["parenum"].to_f
				para["chilnum"] = child["chilnum"].to_f
				para["consumunitqty"] = child["consumunitqty"].to_f
				para["consumminqty"] = child["consumminqty"].to_f
				para["locas_id_fm"] = child["locas_id_fm"].to_f
		end
		return command_r,opeitm
	end

	###schsの修正
	def fields_update_from_pare_source trngantt
		strsql = %Q% select * from r_#{trngantt["orgtblname"]} where id = #{trngantt["orgtblid"]}
		%
		src = ActiveRecord::Base.connection.select_one(strsql)
		strsql = %Q% select * from r_#{trngantt["paretblname"]} where id = #{trngantt["paretblid"]}
		%
		parent = ActiveRecord::Base.connection.select_one(strsql)
		fields_update  parent do |command_c,para|
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
			@parent_qty = 0
			para["parenum"] = trngantt["parenum"]
			para["chilnum"] = trngantt["chilnum"]
		end
	end
	
	def proc_get_opeitms_rec itms_id,locas_id,processseq = nil,priority = nil  ###
		strsql = %Q& select * from opeitms where itms_id = #{itms_id} #{if locas_id then " and locas_id = " + locas_id.to_s else "" end}
				   and expiredate > current_date  order by  priority desc &
		rec = ActiveRecord::Base.connection.select_one(strsql)
        if rec
			strsql = %Q& select * from opeitms where itms_id = #{itms_id} #{if locas_id then " and locas_id = " + locas_id.to_s else "" end}
					   #{if processseq then " and processseq = " + processseq.to_s else "" end}
					   #{if priority then " and priority = " + priority.to_s else "" end}
					   and expiredate > current_date  order by  priority desc &
			newrec = ActiveRecord::Base.connection.select_one(strsql)
			if newrec
				return newrec
			else
				return rec
			end	
		else
			  return nil
        end
	end

	def proc_trngantts tblname,tblid,reqparams
		processreqs_ids = []
		srctbl = reqparams["tbldata"]
		if srctbl["qty"] then symqty = "qty" else symqty = "qty_stk" end
		strsql = %Q% select * from trngantts where tblname = '#{tblname}' and tblid = #{tblid}
					  order by duedate desc for update
		%
		recs = ActiveRecord::Base.connection.select_all(strsql)
		if recs.empty?  ###trngantts 追加
			if tblid.to_i == reqparams["paretblid"] and tblname == reqparams["paretblname"]
				reqparams  = proc_init_trngantts(tblname,tblid,reqparams)	###新規本体を作成
			else
				reqparams = proc_child_trngantts  tblname,tblid,reqparams
				if (reqparams["orgtblname"] != tblname or   reqparams["orgtblid"] != srctbl["id"]) and
					tblname =~ /schs$/ and reqparams["paretblname"] =~ /ords$/
					proc_schstbl_allocto_freetbl  tblname,tblid,reqparams
				end
			end
			case tblname
			when /prdschs|purschs/
				reqparams["segment"]  = ["mkschs"]
				processreqs_id = RorBlkctl.proc_processreqs_add tblname,tblid,reqparams
			when /prdords|purords/
				reqparams["segment"]  = ["mkschs","mkshpschs"]
				processreqs_id = RorBlkctl.proc_processreqs_add tblname,tblid,reqparams			
			when /insts$/
				reqparams["segment"]  = ["chng_trngantts_tbl"]
				processreqs_id = RorBlkctl.proc_processreqs_add tblname,tblid,reqparams
			when /acts$/
				reqparams["segment"]  = ["chng_trngantts_tbl","consume_child_parts","lotstkhists"]
				processreqs_id = RorBlkctl.proc_processreqs_add tblname,tblid,reqparams
			else
				processreqs_id = nil
			end
			processreqs_ids << processreqs_id
		else　###trngantts 変更
			strsql = "select * from alloctbls where srctblname = '#{tblname}' and  srctblid = #{tblid} and 
						destblname = '#{tblname}' and destblid = #{tblid}"
			alloc = ActiveRecord::Base.connection.select_one(strsql)
			srctblqty = srctbl[symqty].to_f 
			recs.each do |rec|
				if srctblqty < rec[symqty].to_f      ###子供への必要数が不足したとき
					rec[symqty] =  srctblqty
					srctblqty  = 0
					strsql = %Q% updadte  trngantts set #{symqty} = #{rec[symqty]} where id = #{rec["id"]}
					%
					ActiveRecord::Base.connection.update(strsql)
					reqparams["paretblname"] = rec["paretblname"]
					reqparams["paretblid"] = rec["paretblid"]
					reqparems["segment"] = ["parealloc","childalloc"]  ###親への不足数対応
					if tblname =~  /prdords|purords/
						reqparems["segment"] << "mkshpschs"
					end
					processreqs_ids << RorBlkctl.proc_processreqs_add(rec["tblname"],rec["tblid"],reqparams)
				else
					allocqty  = allocqty.to_f - rec[symqty].to_f   ###余剰分　
					srctblqty = srctblqty - rec[symqty].to_f 
				end
				strsql = %Q% update trngantts set locas_id_fm = #{srctbl["locas_id_to"]}
									where id = #{rec["id"]}
				%
				ActiveRecord::Base.connection.update(strsql)
			end
			alloc[symqty] = srctbl[symqty]	
			strsql = %Q%update alloctbls set #{symqty} = #{alloc[symqty]} where id = #{alloc["id"]}% 		
			ActiveRecord::Base.connection.update(strsql)
			if srctblqty > 0  ###FREEの追加
				processreqs_ids << proc_trngantt_add_freeqty(recs[0],srctblqty,reqparams)
			end
		end
		return processreqs_ids
	end

	def proc_init_trngantts  tblname,tblid,orgreqparams
		reqparams = orgreqparams.dup
		reqparams["orgtblname"] = tblname
		reqparams["orgtblid"] = tblid
		reqparams["paretblname"] = tblname
		reqparams["paretblid"] = tblid
		reqparams = proc_add_trngantts(tblname,tblid,reqparams)
		srctbl = reqparams["tbldata"]
		alloctbls_id = RorBlkctl.proc_get_nextval("alloctbls_seq")
		qty = if srctbl["qty"] 
					if  tblname = reqparams["paretblname"] and tblid = reqparams["paretblid"]
						srctbl["qty_case"] 
					else 
						srctbl["qty"]
					end
				else
					0
				end
		qty_stk = 	if srctbl["qty_stk"] 
						srctbl["qty_stk"]
					else 
						0
					end
		strsql = %Q%	insert into alloctbls(id,srctblname,srctblid,destblname,destblid,
								qty,qty_stk,
								created_at,updated_at,
								update_ip,persons_id_upd)
						values(#{alloctbls_id},'#{tblname}',#{tblid},'#{tblname}',#{tblid},
								#{qty},#{qty_stk},
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','0')
		%
		ActiveRecord::Base.connection.insert(strsql)
		return reqparams
	end	

	def proc_add_trngantts   tblname,tblid,reqparams
		srctbl = reqparams["tbldata"]
		orgtblname = reqparams["orgtblname"]
		orgtblid = reqparams["orgtblid"]
		paretblname = reqparams["paretblname"]
		paretblid = reqparams["paretblid"]
		child = (reqparams["child"]||={})    ###本体単独の時　child=nil
		qty = 	if srctbl["qty"] 
					if  tblname = paretblname and tblid = paretblid
						srctbl["qty_case"] 
					else 
						srctbl["qty"]
					end
				else
					0
				end
		qty_stk = 	if srctbl["qty_stk"] 
						srctbl["qty_stk"]
					else 
						0
					end
		strsql = "select * from opeitms where id = #{srctbl["opeitms_id"]} "  ###trnganttsテーブルの対象テーブルにはopeitms_idを必ず含む
		opeitm = ActiveRecord::Base.connection.select_one(strsql)
		strsql = "select * from r_#{paretblname} where id = #{paretblid} "
		pare_opeitm = ActiveRecord::Base.connection.select_one(strsql)
		trngantts_id = RorBlkctl.proc_get_nextval("trngantts_seq")
		strsql = %Q%	insert into trngantts(id,key,
								orgtblname,orgtblid,paretblname,paretblid,tblname,tblid,
								mlevel,
								shuffle_flg,
								parenum,chilnum,
								qty,qty_stk,
								itms_id,processseq,locas_id_fm,prjnos_id,
								itms_id_pare,processseq_pare,locas_id_pare,
								qty_pare,qty_stk_pare,
								consumunitqty,consumminqty,consumchgoverqty,
								starttime,
								duedate,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{trngantts_id},'#{reqparams["trnganttskey"]||="00000"}',
								'#{orgtblname}',#{orgtblid},'#{paretblname}',#{paretblid},'#{tblname}',#{tblid},
								0,
								'#{opeitm["shuffle_flg"]||="0"}',
								1,1,
								#{qty},#{qty_stk},
								#{opeitm["itms_id"]},#{opeitm["processseq"]},#{srctbl["locas_id_to"]},#{srctbl["prjnos_id"]},
								#{pare_opeitm["opeitm_itm_id"]},#{pare_opeitm["opeitm_processseq"]},#{pare_opeitm["#{paretblname.chop}_loca_id_to"]},
								#{pare_opeitm["#{paretblname.chop}_qty"]||=0},#{pare_opeitm["#{paretblname.chop}_qty_stk"]||=0},
								#{child["consumunitqty"]||=0},#{child["consumminqty"]||=0},#{child["consumchgoverqty"]||=0},
								to_timestamp('#{srctbl["starttime"]}','yyyy-mm-dd hh24:mi:ss'),
								to_timestamp('#{srctbl["duedate"]}','yyyy-mm-dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','0','2099/12/31','220')
		%
		ActiveRecord::Base.connection.insert(strsql) 
		reqparams["trngantts_id"] = trngantts_id
		return reqparams
	end

	def proc_add_alloc_trn free,trn
		trngantts_id = RorBlkctl.proc_get_nextval("trngantts_seq")
		strsql = %Q%
		insert into trngantts(id,key,
								orgtblname,orgtblid,paretblname,paretblid,
								tblname,tblid,
								mlevel,
								shuffle_flg,
								parenum,chilnum,
								qty,qty_stk,
								qty_pare,qty_stk_pare,
								itms_id,processseq,locas_id_fm,prjnos_id,
								itms_id_pare,processseq_pare,locas_id_pare,
								consumunitqty,consumminqty,consumchgoverqty,
								starttime,
								duedate,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{trngantts_id},'#{trn["key"]}',
								'#{trn["orgtblname"]}',#{trn["orgtblid"]},'#{trn["paretblname"]}',#{trn["paretblid"]},
								'#{free["tblname"]}',#{free["tblid"]},
								'#{trn["mlevel"]}',
								'#{trn["shuffle_flg"]}',
								#{trn["parenum"]},#{trn["chilnum"]},
								#{free["qty"]},#{free["qty_stk"]},
								#{trn["qty"]},#{trn["qty_stk"]},
								#{trn["itms_id"]},#{trn["processseq"]},#{trn["locas_id_fm"]},#{trn["prjnos_id"]},
								#{trn["itms_id_pare"]},#{trn["processseq_pare"]},#{trn["locas_id_pare"]},
								#{trn["consumunitqty"]},#{trn["consumminqty"]},#{trn["consumchgoverqty"]},
								to_timestamp('#{trn["starttime"]}','yyyy-mm-dd hh24:mi:ss'),
								to_timestamp('#{trn["duedate"]}','yyyy-mm-dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','0','2099/12/31','258')
		%
		ActiveRecord::Base.connection.insert(strsql) 
		return trngantts_id
	end

	def proc_trngantt_add_freeqty rec,symqty,reqparams
		srctbl = reqparams["tbldata"]
		strsql = %Q% select * from trngantts where tblname = '#{rec["tblname"]}' and tblid = #{rec["tblid"]}
						and paretblname = '#{rec["tblname"]}'  and paretblid =  #{rec["tblid"]}
						and orgtblname = '#{rec["tblname"]}' and orgtblid = #{rec["tblid"]}
						%
		orgrec = ActiveRecord::Base.connection.select_one(strsql)
		orgrec[symqty] = orgrec[symqty] + srctbl[symqty.to_sym]	
		strsql = %Q%update trngantts set #{symqty} = #{orgrec[symqty]},starttime = #{srctbl["starttime"]},duedate = #{srctbl["duedate"]}
					where id = #{orgrec["id"]}% 		
		ActiveRecord::Base.connection.update(strsql)
		reqparams["segment"]  = ["childalloc","parealloc"]  ###子-->親が増えたので子供の増　親のfreeを親の親に引き当てる。

		processreqs_id = RorBlkctl.proc_processreqs_add rec["tblname"],rec["tblid"],reqparams
		return processreqs_id
	end

	def proc_schstbl_allocto_freetbl  tblname,tblid,reqparams
		srctbl = reqparams["tbldata"]
		opeitm = reqparams["opeitm"]
		strsql = %Q$ select '01' priority,* from trngantts where itms_id = #{opeitm["itms_id"]} and locas_id_fm = #{srctbl["locas_id_to"]}
									and processseq = #{opeitm["processseq"]} and prjnos_id = #{srctbl["prjnos_id"]}
									and qty > 0  and tblname = orgtblname and tblid = orgtblid
									and (tblname like '%ords' or tblname like '%insts' or tblname like '%acts')
									and duedate <= to_date('#{srctbl["duedate"]}','yyyy/mm/dd')
					union				
					 select '02' priority,* from trngantts where itms_id = #{opeitm["itms_id"]} and locas_id_fm = #{srctbl["locas_id_to"]}
									and processseq = #{opeitm["processseq"]} and prjnos_id = #{srctbl["prjnos_id"]}
									and qty_stk > 0  and tblname = orgtblname and tblid = orgtblid
					union				
					 select '03' priority,* from trngantts where itms_id = #{opeitm["itms_id"]} and locas_id_fm = #{srctbl["locas_id_to"]}
									and processseq = #{opeitm["processseq"]} and prjnos_id = #{srctbl["prjnos_id"]}
									and qty > 0  and tblname = orgtblname and tblid = orgtblid
									and (tblname like '%ords' or tblname like '%insts' or tblname like '%acts')
									and duedate > to_date('#{srctbl["duedate"]}','yyyy/mm/dd')
					order by priority,duedate
		$
		frees = ActiveRecord::Base.connection.select_all(strsql)
		strsql = %Q% select * from trngantts where id = #{reqparams["trngantts_id"]} %
		trn =  ActiveRecord::Base.connection.select_one(strsql)
		frees.each do |free|
			if free["qty"].to_f > 0
				if free["qty"].to_f >= trn["qty"].to_f
					strsql = %Q% update trngantts set qty = #{free["qty"].to_f - trn["qty"].to_f} ,remark = '308' where id = #{free["id"]}%
					ActiveRecord::Base.connection.update(strsql)
					strsql = %Q% update trngantts set qty = 0 ,remark = '311' where id = #{reqparams["trngantts_id"]}%
					ActiveRecord::Base.connection.update(strsql)
					trn["qty_stk"] = 0
					free["qty"] = trn["qty"]
					proc_add_alloc_trn free,trn
					strsql = %Q% update #{trn["tblname"]} set qty = 0,remark  = 'change qty #{srctbl["qty"]}  to 0' where id = #{trn["tblid"]} % 
					ActiveRecord::Base.connection.update(strsql)
					break
				else
					strsql = %Q% update trngantts set qty = 0,remark = '316' where id = #{free["id"]}%
					ActiveRecord::Base.connection.update(strsql)
					strsql = %Q% update trngantts set qty = #{trn["qty"].to_f - free["qty"].to_f},remark = '318' where id = #{reqparams["trngantts_id"]}%
					ActiveRecord::Base.connection.update(strsql)
					trn["qty"] =  free["qty"]
					trn["qty_stk"] = 0
					proc_add_alloc_trn free,trn
					srctbl["qty"] =  srctbl["qty"].to_f  -  free["qty"].to_f
					strsql = %Q% update #{trn["tblname"]} set qty = #{srctbl["qty"]} ,remark  = 'change qty #{srctbl["qty"]}  to 0' 
										where id = #{trn["tblid"]} % 
					ActiveRecord::Base.connection.update(strsql)
				end
			else
				if free["qty_stk"] > 0
					if free["qty_stk"] >= trn["qty"]
						strsql = %Q% update trngantts set qty = #{free["qty_stk"].to_f - trn["qty"].to_f},remark = '328'  where id = #{free["id"]}%
						ActiveRecord::Base.connection.update(strsql)
						strsql = %Q% update trngantts set qty = 0 where id = #{reqparams["trngantts_id"]}%
						ActiveRecord::Base.connection.update(strsql)
						free["qty_stk"] = trn["qty"]
						free["qty"] = 0
						proc_add_alloc_trn free,trn
						strsql = %Q% update #{trn["tblname"]} set qty = 0,remark  = 'change qty #{srctbl["qty"]}  to 0' where id = #{trn["tblid"]} % 
						ActiveRecord::Base.connection.update(strsql)
						break
					else
						strsql = %Q% update trngantts set qty_stk = 0 where id = #{free["id"]}%
						ActiveRecord::Base.connection.update(strsql)
						strsql = %Q% update trngantts set qty = #{trn["qty"].to_f - free["qty_stk"].to_f},remark = '338'  where id = #{reqparams["trngantts_id"]}%
						ActiveRecord::Base.connection.update(strsql)
						###free["qty_stk"] =  free["qty_stk"]
						free["qty"] = 0
						proc_add_alloc_trn free,trn
						srctbl["qty"] =  srctbl["qty"].to_f  -  free["qty"].to_f
						strsql = %Q% update #{trn["tblname"]} set qty = #{srctbl["qty"]} ,remark  = 'change qty #{srctbl["qty"]}  to 0' 
											where id = #{trn["tblid"]} % 
					end
				end	
			end	
		end
	end	

	def proc_child_trngantts  tblname,tblid,reqparams
		strsql = %Q% select * from trngantts where id = #{reqparams["trngantts_id"]} 
		%
		rec = ActiveRecord::Base.connection.select_one(strsql)
		srctbl = reqparams["tbldata"]
		trngantts_id = RorBlkctl.proc_get_nextval("trngantts_seq")
		child = reqparams["child"]
		opeitm = reqparams["opeitm"]
		strsql = %Q%
		insert into trngantts(id,key,
								orgtblname,orgtblid,
								paretblname,paretblid,
								tblname,tblid,
								mlevel,
								shuffle_flg,
								parenum,chilnum,
								qty_pare,qty_stk_pare,
								qty,qty_stk,
								itms_id,processseq,locas_id_fm,prjnos_id,
								itms_id_pare,processseq_pare,locas_id_pare,
								consumunitqty,consumminqty,consumchgoverqty,
								duedate,
								starttime,
								created_at,
								updated_at,
								expiredate,update_ip,persons_id_upd,remark)
						values(#{trngantts_id},'#{reqparams["trnganttkey"]}',
								'#{rec["orgtblname"]}',#{rec["orgtblid"]},
								'#{rec["tblname"]}',#{rec["tblid"]},
								'#{tblname}',#{tblid},
								'#{rec["mlevel"].to_i+1}',
								'#{rec["shuffle_flg"]}',
								#{child["parenum"]},#{child["chilnum"]},
								#{rec["qty"]},#{rec["qty_stk"]},
								#{srctbl["qty"]||=0},#{srctbl["qty_stk"]||=0},
								#{opeitm["itms_id"]},#{opeitm["processseq"]},#{srctbl["locas_id_to"]},#{srctbl["prjnos_id"]},
								#{rec["itms_id"]},#{rec["processseq"]},#{rec["locas_id_fm"]},
								#{child["consumunitqty"]},#{child["consumminqty"]},#{child["consumchgoverqty"]},
								to_timestamp('#{rec["starttime"].to_date-1}','yyyy-mm-dd hh24:mi:ss'),
								to_timestamp('#{rec["starttime"].to_date-1-child["duration"].to_i}','yyyy-mm-dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								'2099/12/31',' ','0','399')
		%
		ActiveRecord::Base.connection.insert(strsql) 
		reqparams["trngantts_id"] = trngantts_id
		return reqparams
	end
	
### prd,pur,shp ・・・schs,ords,insts,acts,retsのレコード作成　	
	def fields_update parent
		@command_c = {}
		@para = {}
		yield @command_c,@para
		parent.each do |key,val|
			case key
			when /^opeitm_loca_id/
				@para["parent_locas_id"] = val
			when	/opeitm_processseq$/
				@para["parent_processseq"] = val
			when /starttime/
				@para["parent_starttime"] = val.to_date
			when  /_chrg_id/
				@para["chrgs_id"] = val
			when /_qty$/
				@para["parent_qty"] = val.to_f
			when  /_prjno_id/
				@para["parent_prjno_id"] = val
			when  /opeitm_packqty/
				@para["packqty"] = val.to_f
			when  /loca_id_to/
				@para["parent_locas_id"] = val.to_f
			end
		end	
		@command_c[:sio_message_contents] = nil
		@command_c[:sio_recordcount] = 1
		@command_c[:sio_result_f] =   "0"  

		@tblnamechop = @command_c[:sio_viewname].split("_")[1].chop
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
				when "starttime"  ###稼働日計算
						field_starttime
				when "duedate"  ###稼働日計算
						field_duedate
				when "chrgs_id"
						field_chrgs_id 
				when "qty"
						field_qty 
				when "qty_case"
						field_qty_case 
				when "qty_stk"
						field_qty_stk 
				when "price"  ###保留
						field_price_amt_tax_contract_price 
				when "sno"  ###tblfield_seqnoはidの後であること。
					@command_c["#{@tblnamechop}_sno"]  = field_sno(@tblnamechop,@command_c["id"])
				when "cno"
					@command_c["#{@tblnamechop}_cno"]  = field_cno @command_c["id"]
				when "gno"
					@command_c["#{@tblnamechop}_gno"]   = field_gno @command_c["id"]
				when "prjnos_id"
						field_prjnos_id
				when "consumtype"  ###proc_create_table_from_nditmの時は常にopeitmsから
						field_consumtype
				when "consumauto"  ###
						field_consumauto
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
		return @command_c
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
		@command_c["#{@tblnamechop}_loca_id_to"] = @para["locas_id_fm"] ##
	end 

	def field_processseq_pare 
		@command_c["#{@tblnamechop}_processseq_pare"] = @para["parent_processseq"] 
	end	

	def field_isudate
		@command_c["#{@tblnamechop}_isudate"] = Time.now if @command_c["#{@tblnamechop}_isudate"].nil? or @command_c["#{@tblnamechop}_isudate"] == ""
	end	 

	def field_starttime
		@command_c["#{@tblnamechop}_starttime"] =  @command_c["#{@tblnamechop}_duedate"].to_date - @para["duration"]
	end

	def field_duedate 
		@command_c["#{@tblnamechop}_toduedate"] = @command_c["#{@tblnamechop}_duedate"] = @para["parent_starttime"].to_date - 1
	end

	def field_chrgs_id 
		@command_c["#{@tblnamechop}_chrg_id"] = @para["chrgs_id"] if @command_c["#{@tblnamechop}_chrg_id"].nil? or  @command_c["#{@tblnamechop}_chrg_id"] == ""
	end	

	def field_qty 
		@command_c["#{@tblnamechop}_qty"] = @para["parent_qty"] * @para["chilnum"] / @para["parenum"]
		#consumunitqty等については親に合わせて計算する。
		#if @para["consumunitqty"] > 0
		#	rlst = (@command_c["#{@tblnamechop}_qty"] /  @para["consumunitqty"]).ceil
		#	@command_c["#{tblnamechop}_qty"] = @para["consumunitqty"] * rlst   ###消費単位
		#end	
		#if @para["consumminqty"] > @command_c["#{@tblnamechop}_qty"]
		#	@command_c["#{tblnamechop}_qty"] = @para["consumminqty"]  ###最小消費数
		#end	
	end	

	def field_qty_case 
		if @para["packqty"] > 0
			rlst = ( @command_c["#{@tblnamechop}_qty"] /  @para["packqty"]).ceil
			@command_c["#{@tblnamechop}_qty_case"] = @para["packqty"] *  rlst  ###購入数又は作成数
		else
			@command_c["#{@tblnamechop}_qty_case"] = @command_c["#{@tblnamechop}_qty"] 
		end	
	end	

	def field_qty_stk 
		@command_c["#{@tblnamechop}_qty_stk"] = @para["parent_qty"] * @para["chilnum"] / @para["parenum"]
		if @consumminqty > @command_c["#{@tblnamechop}_qty_stk"]
			@command_c["#{tblnamechop}_qty_stk"] = @para["consumunitqty"]
		end	
	end	

	def field_price_amt_tax_contract_price 
		@command_c["#{@tblnamechop}_price"] = 0 if @command_c["#{@tblnamechop}_price"].nil?
		@command_c["#{@tblnamechop}_amt"] = 0 if @command_c["#{@tblnamechop}_amt"].nil?
		@command_c["#{@tblnamechop}_tax"] = 0 if @command_c["#{@tblnamechop}_tax"].nil?
	end

	def field_sno(tblnamechop,id)
		ControlFields.snolist["#{tblnamechop}s"] + format('%05d', id) 
	end


	def field_cno id 
		 format('%07d', id)
	end

	def field_gno id
		 format('%07d', id) 
	end	

	def field_prjnos_id 
		@command_c["#{@tblnamechop}_prjno_id"] = @para["parent_prjno_id"] 
	end	

	def field_consumtype
		@command_c["#{@tblnamechop}_consumtype"] = @para["consumtype"] if @command_c["#{@tblnamechop}_consumtype"].nil? or  @command_c["#{@tblnamechop}_consumtype"] == ""
	end

	def field_consumauto
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

	def proc_chng_trngantts_tbl roottbl,rootid,tblname,tblid,reqparams
		srctbl = reqparams["tbldata"]
		reqparams["tblname"] = roottbl
		reqparams["tblid"] = rootid
		reqparams["paretblname"] = tblname
		reqparams["paretblid"] = tblid
		save_qty = srctbl["qty"]
		strsql = %Q%select 01 seq,a.* from trngantts a
						where orgtblid != #{rootid} and  paretblid != #{rootid} and  tblid = #{rootid} 
					union
						select 02 seq,a.* from trngantts a
							where orgtblid != #{rootid} and  paretblid = #{rootid} and  tblid = #{rootid} 
					union
						select 03 seq,a.* from trngantts a
							where orgtblid = #{rootid} and  paretblid = #{rootid} and  tblid = #{rootid} 
					order by seq,starttime		
		%
		recs =  ActiveRecord::Base.connection.select_all(strsql)
		recs.each do |rec|
			if srctbl["qty"] >= rec["qty"]
				srctbl["qty"] = srctbl["qty"] -  rec["qty"]
				newqty = rec["qty"]
				rec["qty"] = 0
				chngtbl_update reqparams,rec,newqty
			else	
				rec["qty"] = rec["qty"] - srctbl["qty"]
				chngtbl_update reqparams,rec,srctbl["qty"]
				srctbl["qty"] = 0
			end
			break if srctbl["qty"]  <= 0
		end
		strsql = %Q% update trngantts set qty = #{srctbl["qty"]} where id = #{reqparams["trngantts_id"]}
		%
		ActiveRecord::Base.connection.update(strsql)
		strsql = %Q%select 10 seq,a.* from trngantts a
						where orgtblid != #{rootid} and  paretblid = #{rootid} and  tblid != #{rootid} 
						order by orgtblname,orgtblid,starttime
		%
		recs =  ActiveRecord::Base.connection.select_all(strsql)
		srctbl["qty"] = save_qty
		save_org_trn_id = 0
		recs.each do |rec|
			if save_org_trn_id != rec["orgtblid"] or 
				if srctbl["qty"] >= rec["qty_pare"]
					srctbl["qty"] = srctbl["qty"] -  rec["qty_pare"]
					newqty = rec["qty_pare"]
					rec["qty_pare"] = 0
					chngtbl_update_pare reqparams,rec,newqty
				else	
					rec["qty_pare"] = rec["qty_pare"] - srctbl["qty"]
					newqty = srctbl["qty"]
					srctbl["qty"] = 0
					chngtbl_update_pare reqparams,rec,newqty
				end
				save_pare_trn_id = rec["paretblid"]
			end	
		end
	end

	def chngtbl_update reqparams,rec,newqty
		strsql = %Q% update trngantts set qty = #{rec["qty"]} where id = #{rec["id"]}
		%
		ActiveRecord::Base.connection.update(strsql)
		if req["seq"] == "01" or req["seq"] == "02" 
			if req["seq"] == "02"
				rec["paretblname"]  = reqparams["tblname"]
				rec["paretblid"]  = reqparams["tblid"]
				rec["qty_pare"] = newqty
			end
			reqparams["qty"] = newqty
			reqparams["qty_qty"] = 0
			proc_add_alloc_trn reqparams,rec
		end
	end	

	def chngtbl_update_pare reqparams,rec,newqty  ###trnはchngtblで修正済
		strsql = %Q% select * from trngantts where orgtblname  = '#{rec["orgtblname"]}' and orgtblid  = '#{rec["orgtblid"]}' 
						and paretblname  = '#{rec["paretblname"]}' and paretblid  = '#{rec["paretblid"]}' 
		%
		srcs = ActiveRecord::Base.connection.select_All(strsql)
		srcs.each do |src|
			strsql = %Q% update trngantts set qty_pare = #{rec["qty_pare"]} where id = #{src["id"]}
			%
			ActiveRecord::Base.connection.update(strsql)
			src["paretblname"] = reqparams["paretblname"]
			src["paretblid"] = reqparams["paretblid"]
			src["qty_pare"] = newqty
			proc_add_alloc_trn src,src
		end
	end	
	
	def proc_consume_child_parts rec
		###子部品の消費
		###金型の返却
		###使用装置の解放
	end

	def proc_mkshpschs recs
	end

	def proc_inouts(tblname,tblid,command_r,trngantts_id)
		inout = {}
		case tblname
		###  stk
		###  out
		when /^pur/
			###purschs-->opeitm_loca_id 
			inout["locas_id_out"] = (command_r["supplier_loca_id_supplier"]||=command_r["opeitm_loca_id"])
			inout["inoutflg"] = ""
			inout["starttime"]  = command_r[tblname.chop+"_depdate"]
		when /^prd/
			inout["locas_id_out"] = command_r["opeitm_loca_id"] 
			inout["locas_id_in"] = command_r[tblname.chop+"_loca_id_to"]
			inout["packno"] = if tblname == "puracts" then packno_set(command_r) else "dummy" end
			inout["inoutflg"] = ""
			inout["starttime"]  = (command_r[[tblname.chop+"commencementdate"]||=command_r[tblname.chop+"_starttime"])
		when /^shp/
			inout["locas_id_out"] = command_r["trngantt_loca_id_fm_shp"] 
			inout["inoutflg"] = ""
			inout["starttime"]  = command_r[tblname.chop+"_depdate"]
		end
		inout["qty_stk"] = (command_r[tblname.chop+"_qty_stk"]||=  command_r[tblname.chop+"_qty"])
		inout["packno"] = if tblname =~ /acts/ then packno_set(command_r) else "dummy" end
		inout["trngantts_id"] = trngantts_id
		mk_outstks_rec inout
		###  stk
		###  in
		case tblname
		when /^pur/
			inout["locas_id_in"] = command_r[tblname.chop+"_loca_id_to"]
			inout["starttime"]  =  (command_r[tblname.chop+"_rcptdate"]||=command_r[tblname.chop+"_duedate"])
		when /^prd/
			inout["locas_id_in"] = command_r[tblname.chop+"_loca_id_to"]
			inout["starttime"]  = (command_r[[tblname.chop+"commencementdate"]||=command_r[tblname.chop+"_starttime"])
		when /^shp/
			inout["locas_id_in"] = command_r["trngantt_loca_id_pare_shp"]
			inout["starttime"]  = command_r[tblname.chop+"_duedate"]
		end
		mk_instks_rec inout
		###  amt
		###  out
		case tblname
		when /^pur/
			inout["locas_id_out"] = command_r["payment_loca_id_payment"]
			inout["crrs_id"] = command_r["supplier_crr_id_supplier"]
			inout["amt"] = command_r[tblname.chop+"_amt"]
		when /^prd/
			inout["amt"] = 0
			inout["crrs_id"] = 0
		when /^shp/
			inout["crrs_id"] = command_r[tblname.chop+"_crr_id"]
			inout["amt"] = command_r[tblname.chop+"_amt"]
		end
		mk_outamts_rec inout
		###  amt
		###  in
		case tblname
		when /^pur/
			inout["locas_id_out"] = (command_r["supplier_loca_id_supplier"]||=command_r["opeitm_loca_id"])
		when /^prd/
		when /^shp/
		end
		mk_outamts_rec inout
	end
	def packno_set command_r
		dummy
	end

	def mk_outstks_rec inout
		outstks_id = RorBlkctl.proc_get_nextval("outstks_seq")
		strsql = %Q%
		insert into outstks(id,trngantts_id,locas_id_out,
								starttime,
								qty_stk,
								lotno,packno,inoutflg,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{outstks_id},'#{inout["trngantts_id"]}','#{inout["locas_id_out"]}',
								'#{inout["starttime"]}',
								'#{inout["qty_stk"]},
								'#{inout["lotno"]}','#{inout["packno"]}','#{inout["inoutflg"]}',
								'#{trn["shuffle_flg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','#{@sio_user_code||=0}','2099/12/31','')
		%
		ActiveRecord::Base.connection.insert(strsql) 
	end

	def mk_instks_rec inout
		instks_id = RorBlkctl.proc_get_nextval("instks_seq")
		strsql = %Q%
		insert into outstks(id,trngantts_id,locas_id_in,
								starttime,
								qty_stk,
								lotno,packno,inoutflg,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{outstks_id},'#{inout["trngantts_id"]}','#{inout["locas_id_in"]}',
								'#{inout["starttime"]}',
								'#{inout["qty_stk"]},
								'#{inout["lotno"]}','#{inout["packno"]}','#{inout["inoutflg"]}',
								'#{trn["shuffle_flg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','#{@sio_user_code||=0}','2099/12/31','')
		%
		ActiveRecord::Base.connection.insert(strsql) 
	end

	def mk_outamts_rec inout
		outamts_id = RorBlkctl.proc_get_nextval("outamts_seq")
		strsql = %Q%
		insert into outstks(id,trngantts_id,locas_id_out,crrs_id,
								starttime,
								amt,
								inoutflg,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{outstks_id},'#{inout["trngantts_id"]}','#{inout["locas_id_out"]}','#{inout["crrs_id"]}',
								'#{inout["starttime"]}',
								'#{inout["amt"]},
								'#{inout["inoutflg"]}',
								'#{trn["shuffle_flg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','#{@sio_user_code||=0}','2099/12/31','')
		%
		ActiveRecord::Base.connection.insert(strsql) 
	end

	def mk_inamts_rec inout
		inamts_id = RorBlkctl.proc_get_nextval("inamts_seq")
		strsql = %Q%
		insert into outstks(id,trngantts_id,locas_id_in,crrs_id,
								starttime,
								amt,
								inoutflg,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{outstks_id},'#{inout["trngantts_id"]}','#{inout["locas_id_in"]}','#{inout["crrs_id"]}',
								'#{inout["starttime"]}',
								'#{inout["amt"]},
								'#{inout["inoutflg"]}',
								'#{trn["shuffle_flg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','#{@sio_user_code||=0}','2099/12/31','')
		%
		ActiveRecord::Base.connection.insert(strsql) 
	end

	def proc_lotstkhists trngantts_id
		strsql = %Q% select starttime,locas_id_out,null locas_id_in,lotno,packno,qty_stk from outstks
							where trngantts_id = #{trngantts_id}
					union
					 select starttime,null locas_id_out,locas_id_in,lotno,packno,qty_stk from instks
							where trngantts_id = #{trngantts_id}
		%
		recs = ActiveRecord::Base.connection.select_all(strsql) 
	end	

end   ##module