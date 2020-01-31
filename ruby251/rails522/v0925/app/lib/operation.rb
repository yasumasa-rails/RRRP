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
				para["locas_id_fm"] = child["locas_id_fm"].to_f
				para["consumunitqty"] = child["consumunitqty"].to_f
				para["consumminqty"] = child["consumminqty"].to_f
				para["shelfnos_id_to"] = opeitm["shelfnos_id"].to_f
				para["locas_id"] = opeitm["locas_id"].to_f  ###発注の時の作業場所
		end
		return command_r,opeitm
	end

	###schsの修正  未使用
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
		strsql = %Q& select * from opeitms where itms_id = #{itms_id} 
					#{if locas_id then " and locas_id = " + locas_id.to_s else "" end}
				   and expiredate > current_date  order by  priority desc &
		rec = ActiveRecord::Base.connection.select_one(strsql)
        if rec
			strsql = %Q& select * from opeitms where itms_id = #{itms_id} 
						#{if locas_id then " and locas_id = " + locas_id.to_s else "" end}
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
		segment = []
		srctbl = reqparams["tbldata"]
		if srctbl["qty"] then symqty = "qty" else symqty = "qty_stk" end
		strsql = %Q% select * from trngantts where tblname = '#{tblname}' and tblid = #{tblid}
					  order by duedate desc for update
		%
		recs = ActiveRecord::Base.connection.select_all(strsql)
		if recs.empty?  ###trngantts 追加
			if tblid.to_i == reqparams["paretblid"].to_i and tblname == reqparams["paretblname"]
				trngantts_id = init_trngantts_add_detail(tblname,tblid,reqparams)	###新規本体を作成
			else
				trngantts_id = child_trngantts(tblname,tblid,reqparams)
			end	
			reqparams["trngantts_id"] =  trngantts_id
			if (reqparams["orgtblname"] != tblname or   reqparams["orgtblid"] != tblid) and
					tblname =~ /schs$/ and reqparams["orgtblname"] =~ /ords$/
				schstbl_allocto_freetbl  tblname,tblid,reqparams
			end
			case tblname   ###次の動作を確定
			when /prdschs|purschs|custschs|custords/
				segment  << "mkschs"   ###構成展開
				reqparams["paretblname"] = tblname
				reqparams["paretblid"] = tblid 
				processreqs_id = RorBlkctl.proc_processreqs_add tblname,tblid,reqparams,segment
			when /prdords|purords/
				reqparams["paretblname"] = tblname
				reqparams["paretblid"] = tblid	
				segment  << "mkschs"
				segment  << "mkshpschs"   ###出庫 
				processreqs_id = RorBlkctl.proc_processreqs_add tblname,tblid,reqparams,segment		
			when /insts$/
			when /acts$/
				segment  << "consume_child_parts"
				processreqs_id = RorBlkctl.proc_processreqs_add tblname,tblid,reqparams,segment
			else
				processreqs_id = nil
			end
			processreqs_ids << processreqs_id
		else ###trngantts 変更
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
					segment <<  "parealloc"  ###親への不足数対応
					segment <<  "childalloc"  ###親への不足数対応
					if tblname =~  /prdords|purords/
						segment << "mkshpschs"  ###出庫データ作成
					end
					processreqs_ids << RorBlkctl.proc_processreqs_add(rec["tblname"],rec["tblid"],reqparams,segment)
				else
					allocqty  = allocqty.to_f - rec[symqty].to_f   ###余剰分　
					srctblqty = srctblqty - rec[symqty].to_f 
				end
				strsql = %Q% update trngantts set shelfnos_id_fm = #{srctbl["shelfnos_id_to"]}
									where id = #{rec["id"]}
				%
				ActiveRecord::Base.connection.update(strsql)
			end
			if srctblqty > 0  ###FREEの追加
				processreqs_ids << proc_trngantt_add_freeqty(recs[0],srctblqty,reqparams)
			end
		end
		raise if segment.size > 5
		return processreqs_ids
	end

	def init_trngantts_add_detail   tblname,tblid,reqparams
		srctbl = reqparams["tbldata"]
		orgtblname = reqparams["orgtblname"]
		orgtblid = reqparams["orgtblid"]
		paretblname = reqparams["paretblname"]
		paretblid = reqparams["paretblid"]
		child = (reqparams["child"]||={})    ###本体単独の時　child=nil
		qty = 	if srctbl["qty"] 
					srctbl["qty"]
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
		case tblname
		when /^custschs/
			srctbl["shelfnos_id_to"] = opeitm["shelfnos_id"]  ###shelfnos_id_fm:親がこの子部品をどこからとってくるか
			srctbl["starttime"] = (srctbl["duedate"].to_date - 1).strftime("%Y-%m-%d %H:%M:%S")
		end
		trngantts_id = RorBlkctl.proc_get_nextval("trngantts_seq")
		strsql = %Q%	insert into trngantts(id,key,
								orgtblname,orgtblid,paretblname,paretblid,tblname,tblid,
								mlevel,
								shuffle_flg,
								parenum,chilnum,
								qty,qty_stk,
								itms_id,processseq,shelfnos_id_fm,prjnos_id,
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
								#{opeitm["itms_id"]},#{opeitm["processseq"]},#{srctbl["shelfnos_id_to"]},#{srctbl["prjnos_id"]},
								#{pare_opeitm["opeitm_itm_id"]},#{pare_opeitm["opeitm_processseq"]},#{pare_opeitm["opeitm_loca_id"]},
								#{pare_opeitm["#{paretblname.chop}_qty"]||=0},#{pare_opeitm["#{paretblname.chop}_qty_stk"]||=0},
								#{child["consumunitqty"]||=0},#{child["consumminqty"]||=0},#{child["consumchgoverqty"]||=0},
								to_timestamp('#{srctbl["starttime"]}','yyyy-mm-dd hh24:mi:ss'),
								to_timestamp('#{srctbl["duedate"]}','yyyy-mm-dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','0','2099/12/31','220')
		%
		ActiveRecord::Base.connection.insert(strsql) 
		return  trngantts_id
	end

	def add_alloc_and_trn free,trn
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
								itms_id,processseq,shelfnos_id_fm,prjnos_id,
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
								#{trn["itms_id"]},#{trn["processseq"]},#{trn["shelfnos_id_fm"]},#{trn["prjnos_id"]},
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
		segment = []
		strsql = %Q% select * from trngantts where tblname = '#{rec["tblname"]}' and tblid = #{rec["tblid"]}
						and paretblname = '#{rec["tblname"]}'  and paretblid =  #{rec["tblid"]}
						and orgtblname = '#{rec["tblname"]}' and orgtblid = #{rec["tblid"]}
						%
		orgrec = ActiveRecord::Base.connection.select_one(strsql)
		orgrec[symqty] = orgrec[symqty] + srctbl[symqty.to_sym]	
		strsql = %Q%update trngantts set #{symqty} = #{orgrec[symqty]},starttime = #{srctbl["starttime"]},duedate = #{srctbl["duedate"]}
					where id = #{orgrec["id"]}% 		
		ActiveRecord::Base.connection.update(strsql)
		segment  << "childalloc"  ###子-->親が増えたので子供の増　親のfreeを親の親に引き当てる。
		segment  << "parealloc"  ###子-->親が増えたので子供の増　親のfreeを親の親に引き当てる。

		processreqs_id = RorBlkctl.proc_processreqs_add rec["tblname"],rec["tblid"],reqparams,segment
		return processreqs_id
	end

	def schstbl_allocto_freetbl  tblname,tblid,reqparams
		srctbl = reqparams["tbldata"]
		opeitm = reqparams["opeitm"]
		strsql = %Q$ select '01' priority,* from trngantts where itms_id = #{opeitm["itms_id"]} and shelfnos_id_fm = #{srctbl["shelfnos_id_to"]}
									and processseq = #{opeitm["processseq"]} and prjnos_id = #{srctbl["prjnos_id"]}
									and qty > 0  and tblname = orgtblname and tblid = orgtblid
									and (tblname like '%ords' or tblname like '%insts' or tblname like '%acts')
									and duedate <= to_date('#{srctbl["duedate"]}','yyyy/mm/dd')
					union				
					 select '02' priority,* from trngantts where itms_id = #{opeitm["itms_id"]} and shelfnos_id_fm = #{srctbl["shelfnos_id_to"]}
									and processseq = #{opeitm["processseq"]} and prjnos_id = #{srctbl["prjnos_id"]}
									and qty_stk > 0  and tblname = orgtblname and tblid = orgtblid
					union				
					 select '03' priority,* from trngantts where itms_id = #{opeitm["itms_id"]} and shelfnos_id_fm = #{srctbl["shelfnos_id_to"]}
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
					add_alloc_and_trn free,trn
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
					add_alloc_and_trn free,trn
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
						add_alloc_and_trn free,trn
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
						add_alloc_and_trn free,trn
						srctbl["qty"] =  srctbl["qty"].to_f  -  free["qty"].to_f
						strsql = %Q% update #{trn["tblname"]} set qty = #{srctbl["qty"]} ,remark  = 'change qty #{srctbl["qty"]}  to 0' 
											where id = #{trn["tblid"]} % 
					end
				end	
			end	
		end
	end	

	def child_trngantts  tblname,tblid,reqparams
		strsql = %Q% select * from trngantts where key = '#{reqparams["orgtrnganttkey"]}' and 
						 orgtblname ='#{reqparams["orgtblname"]}' and 
						 orgtblid = #{reqparams["orgtblid"]}
		%
		rec = ActiveRecord::Base.connection.select_one(strsql)
		srctbl = reqparams["tbldata"]
		trngantts_id = RorBlkctl.proc_get_nextval("trngantts_seq")
		child = reqparams["child"] ##子供の情報
		opeitm = reqparams["opeitm"] ##子供の情報
		pare_opeitm = Operation.proc_get_opeitms_rec rec["itms_id"],nil,rec["processseq"],priority = nil
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
								itms_id,processseq,shelfnos_id_fm,prjnos_id,
								itms_id_pare,processseq_pare,locas_id_pare,
								consumunitqty,consumminqty,consumchgoverqty,
								duedate,
								starttime,
								created_at,
								updated_at,
								expiredate,update_ip,persons_id_upd,remark)
						values(#{trngantts_id},'#{reqparams["trnganttkey"]}',
								'#{reqparams["orgtblname"]}',#{reqparams["orgtblid"]},
								'#{rec["tblname"]}',#{rec["tblid"]},
								'#{tblname}',#{tblid},
								'#{rec["mlevel"].to_i+1}',
								'#{rec["shuffle_flg"]}',
								#{child["parenum"]},#{child["chilnum"]},
								#{rec["qty"]},#{rec["qty_stk"]},
								#{srctbl["qty"]||=0},#{srctbl["qty_stk"]||=0},
								#{opeitm["itms_id"]},#{opeitm["processseq"]},#{opeitm["shelfnos_id"]},#{srctbl["prjnos_id"]},
								#{rec["itms_id"]},#{rec["processseq"]},#{pare_opeitm["locas_id"]},
								#{child["consumunitqty"]},#{child["consumminqty"]},#{child["consumchgoverqty"]},
								to_timestamp('#{rec["starttime"].to_date-1}','yyyy-mm-dd hh24:mi:ss'),
								to_timestamp('#{rec["starttime"].to_date-1-child["duration"].to_i}','yyyy-mm-dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								'2099/12/31',' ','0','399')
		%
		ActiveRecord::Base.connection.insert(strsql) 
		return  trngantts_id
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
			##when /_shelfno_id_to/
			##	@para["shelfno_id_to"] = val
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
			when  /opeitm_packqty/
				@para["packqty"] = val.to_f
			##when  /shelfno_loca_id_shelfno_to/
			##	@para["parent_locas_id"] = val.to_f
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
				when "opeitms_id"
						field_opeitms_id fd
				when "suppliers_id"
						field_suppliers_id
				when "locas_id_to"
						field_locas_id_to
				when "shelfnos_id_to"
						field_shelfnos_id_to
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
					if @command_c["#{@tblnamechop}_cno"].nil? or @command_c["#{@tblnamechop}_cno"] == ""
						@command_c["#{@tblnamechop}_cno"]  = field_cno @command_c["id"]
					end
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

	def field_suppliers_id 
		strsql = %Q%select  id from suppliers where locas_id_supplier = #{@para["locas_id"]}
		%
		id = ActiveRecord::Base.connection.select_value(strsql)
		if id.nil? ###supplier_code = dummy は必須
			strsql = %Q%select  id from suppliers 
					where locas_id_supplier = (select id from locas where code = 'dummy')
			%
			id = ActiveRecord::Base.connection.select_value(strsql)
		end	
		@command_c["#{@tblnamechop}_supplier_id"] = id ##
	end 

	def field_shelfnos_id_to 
		@command_c["#{@tblnamechop}_shelfno_id_to"] = @para["shelfnos_id_to"] ##
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
			add_alloc_and_trn reqparams,rec
		end
	end	

	def chngtbl_update_pare reqparams,rec,newqty  ###trnはchngtblで修正済
		strsql = %Q% select * from trngantts where orgtblname  = '#{rec["orgtblname"]}' and orgtblid  = '#{rec["orgtblid"]}' 
						and paretblname  = '#{rec["paretblname"]}' and paretblid  = '#{rec["paretblid"]}' 
		%
		srcs = ActiveRecord::Base.connection.select_all(strsql)
		srcs.each do |src|
			strsql = %Q% update trngantts set qty_pare = #{rec["qty_pare"]} where id = #{src["id"]}
			%
			ActiveRecord::Base.connection.update(strsql)
			src["paretblname"] = reqparams["paretblname"]
			src["paretblid"] = reqparams["paretblid"]
			src["qty_pare"] = newqty
			add_alloc_and_trn src,src
		end
	end	
	
	def proc_consume_child_parts rec
		###子部品の消費
		###金型の返却
		###使用装置の解放
	end

	def proc_mkshpschs recs
	end

	def proc_stkinouts(tblname,tblid,command_r,trngantts_id)
		inout = {}
		case tblname
		###  stk
		###  out
		when /^pur|^insp/  ###shelfnos_id = 0は必須
			case tblname ###purschs-->opeitm_loca_id 
				when /purschs/
					strsql = %Q% select id from shelfnos where locas_id_shelfno  = #{command_r["opeitm_loca_id"]}
					%
				when /^pur/
					strsql = %Q% select id from shelfnos where locas_id_shelfno  = #{command_r["supplier_loca_id_supplier"]}
					%
				when /^insp/
					id = command_r[tblname.chop+"_shelfno_id_to"] 
			end
			id = ActiveRecord::Base.connection.select_value(strsql)
			id ||= 0 
			inout["shelfnos_id_out"] = id 
			inout["shelfnos_id_in"] = command_r[tblname.chop+"_shelfno_id_to"] 
			inout["inoutflg"] = ""
			inout["processseq"] = command_r["opeitm_processseq"]
			case tblname
				when /schs$|ords$|inst$/
					inout["starttime"]  = (Date.strptime(command_r[tblname.chop+"_duedate"],'%Y-%m-%d') - 1).to_s
				when /dlvs$/
					inout["starttime"]  = command_r[tblname.chop+"_depdate"]
				when /acts$/
					if command_r["puract_sno_purdlv"] == ""
						inout["starttime"]  = (Date.strptime(command_r[tblname.chop+"_rcptdate"],'%Y-%m-%d') - 1).to_s
					end
			end
		when /^prd/   ###commencementdate 作業開始
			case tblname ###purschs-->opeitm_loca_id 
				when /schs$/
					strsql = %Q% select id from shelfnos where locas_id_shelfno  = #{command_r["opeitm_loca_id"]}
					%
				else
					strsql = %Q% select id from shelfnos where locas_id_shelfno  = #{command_r["workplace_loca_id_workplace"]}
					%
			end
			id = ActiveRecord::Base.connection.select_value(strsql) 
			id ||= 0
			inout["shelfnos_id_out"] = id
			inout["inoutflg"] = ""
			case tblname
				when /schs$|ords$/
					inout["starttime"]  = command_r[tblname.chop+"_duedate"] 
				when /insts$/
					inout["starttime"]  = command_r[tblname.chop+"_commencementdate"]
				when /acts$/
					inout["starttime"]  = command_r[tblname.chop+"_cmpldate"]
			end
			inout["processseq"] = command_r["opeitm_processseq"]
		when /^shp/
			inout["shelfnos_id_out"] = command_r["trngantt_shelfno_id_fm_shp"] 
			inout["inoutflg"] = ""
			inout["starttime"]  = command_r[tblname.chop+"_depdate"]
			inout["processseq"] = command_r["trngantt_processseq_shp"]
		end
		inout["qty_stk"] = (command_r[tblname.chop+"_qty_stk"]||=  0)
		inout["qty"] = (command_r[tblname.chop+"_qty"]||=  0)
		inout["expiredate"] = command_r[tblname.chop+"_expiredate"]
		inout["packno"] = if tblname =~ /acts$/ then packno_set(command_r) else "dummy" end
		inout["lotno"] = if tblname =~ /acts$/ then lotno_set(command_r) else "dummy" end
		inout["trngantts_id"] = trngantts_id
		inout["processseq"] = command_r["opeitm_processseq"]
		inout["itms_id"] = command_r["opeitm_itm_id"]
		inout["stktaking_proc"] = command_r["opeitm_stktaking_proc"]
		inout["prjnos_id"] = command_r[tblname.chop+"_prjno_id"]
		##
		if tblname == "puracts" and !command_r["puract_sno_purdlv"].nil? and command_r["puract_sno_purdlv"] != ""
			### stk-in purdlvを使用
		else	
			mk_outstks_rec inout,command_r["opeitm_stktaking_proc"]
		end
		###  stk
		###  in
		inout["shelfnos_id_in"] = command_r[tblname.chop+"_shelfno_id_to"]
		case tblname
		when /^pur|^insp/
			case tblname
				when /schs$|ords$|inst$/
					inout["starttime"]  = command_r[tblname.chop+"_duedate"]
				when /acts$/
					inout["starttime"]  = command_r[tblname.chop+"_rcptdate"]
				when /dlvs$/
					inout["starttime"]  =  (Date.strptime(command_r[tblname.chop+"_depdate"],'%Y-%m-%d')  + 1).to_s
			end
		when /^prd/
			case tblname
				when /schs$|ords$/
					inout["starttime"]  = command_r[tblname.chop+"_duedate"] 
				when /insts$/
					inout["starttime"]  = command_r[tblname.chop+"_commencementdate"]
				when /acts$/
					inout["starttime"]  = command_r[tblname.chop+"_cmpldate"]
			end
		when /^shp/
			inout["starttime"]  = command_r[tblname.chop+"_duedate"]
		end
		mk_instks_rec inout,command_r["opeitm_stktaking_proc"]
	end

	def proc_amtinouts(tblname,tblid,command_r,trngantts_id)	###未完成
		###  amt
		###  out
		inout = {}
		case tblname
		when /^pur/
			###purschs-->opeitm_loca_id    amtはlocas_id
			inout["locas_id_out"] = command_r["payment_loca_id_payment"]
			inout["locas_id_in"] = command_r["supplier_loca_id_supplier"]
			inout["starttime"]  = (command_r[tblname.chop+"_depdate"]||=command_r[tblname.chop+"_duedate"])
			inout["crrs_id"] = command_r[tblname.chop+"_crr_id_pur"]
		when /^insp/
			###purschs-->opeitm_loca_id 
			inout["locas_id_out"] = command_r["payment_loca_id_payment"]
			inout["locas_id_in"] = command_r["supplier_loca_id_supplier"]
			inout["starttime"]  = (command_r[tblname.chop+"_depdate"]||=command_r[tblname.chop+"_duedate"])
			inout["crrs_id"] = command_r[tblname.chop+"_crr_id_insp"]
		when /^prd/   
			inout["locas_id_out"] = command_r["opeitm_loca_id"] 
			inout["locas_id_in"] = command_r[tblname.chop+"_loca_id_to"]
			inout["starttime"]  = (command_r[tblname.chop+"commencementdate"]||=command_r[tblname.chop+"_starttime"])
		when /^shp/
			inout["locas_id_out"] = command_r["trngantt_loca_id_fm_shp"] 
			inout["starttime"]  = command_r[tblname.chop+"_depdate"]
		when /^pay/
			inout["locas_id_out"] = command_r["payact_loca_id_payment"]
		when /^bill/
			inout["locas_id_in"] = command_r["billact_loca_id_payment"]
		end
		inout["trngantts_id"] = trngantts_id
		inout["amt"] = command_r[tblname.chop+"_amt"]
		mk_outamts_rec inout
		###  amt
		###  in
		case tblname
		when /^bill|^pay/
		when /^prd/
		when /^shp/
		end
		mk_inamts_rec inout
	end

	def packno_set command_r
		"dummy"
	end
	
	def lotno_set command_r
		"dummy"
	end

	def mk_outstks_rec inout,opeitm_stktaking_proc
		outstks_id = RorBlkctl.proc_get_nextval("outstks_seq")
		strsql = %Q%
		insert into outstks(id,trngantts_id,shelfnos_id_out,
								starttime,
								qty,
								qty_stk,
								lotno,packno,inoutflg,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{outstks_id},#{inout["trngantts_id"]},#{inout["shelfnos_id_out"]},
								'#{inout["starttime"]}',
								#{inout["qty"]},
								#{inout["qty_stk"]},
								'#{inout["lotno"]}','#{inout["packno"]}','#{inout["inoutflg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','#{@sio_user_code||=0}','#{inout["expiredate"]}','')
		%
		ActiveRecord::Base.connection.insert(strsql) 
		if opeitm_stktaking_proc == "1"
			proc_lotstkhists "out", inout
		end
	end

	def mk_instks_rec inout,opeitm_stktaking_proc
		instks_id = RorBlkctl.proc_get_nextval("instks_seq")
		strsql = %Q%
		insert into instks(id,trngantts_id,shelfnos_id_in,
								starttime,
								qty,qty_stk,
								lotno,packno,inoutflg,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{instks_id},#{inout["trngantts_id"]},#{inout["shelfnos_id_in"]},
								'#{inout["starttime"]}',
								#{inout["qty"]},
								#{inout["qty_stk"]},
								'#{inout["lotno"]}','#{inout["packno"]}','#{inout["inoutflg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','#{@sio_user_code||=0}','#{inout["expiredate"]}','')
		%
		ActiveRecord::Base.connection.insert(strsql) 
		if opeitm_stktaking_proc == "1"
			proc_lotstkhists "in", inout
		end
	end

	def mk_outamts_rec inout
		outamts_id = RorBlkctl.proc_get_nextval("outamts_seq")
		strsql = %Q%
		insert into outamts(id,trngantts_id,locas_id_out,crrs_id,
								starttime,
								amt,
								inoutflg,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{outamts_id},#{inout["trngantts_id"]},#{inout["locas_id_out"]},#{inout["crrs_id"]},
								'#{inout["starttime"]}',
								#{inout["amt"]},
								'#{inout["inoutflg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','#{@sio_user_code||=0}','2099/12/31','')
		%
		ActiveRecord::Base.connection.insert(strsql) 
	end

	def mk_inamts_rec inout
		inamts_id = RorBlkctl.proc_get_nextval("inamts_seq")
		strsql = %Q%
		insert into inatms(id,trngantts_id,locas_id_in,crrs_id,
								starttime,
								amt,
								inoutflg,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{inamts_id},#{inout["trngantts_id"]},#{inout["locas_id_in"]},#{inout["crrs_id"]},
								'#{inout["starttime"]}',
								#{inout["amt"]},
								'#{inout["inoutflg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ',#{@sio_user_code||=0},'2099/12/31','')
		%
		ActiveRecord::Base.connection.insert(strsql) 
	end

	def proc_lotstkhists kubun,inout
		shelfnos_id = if kubun == "out" then inout["shelfnos_id_out"] else  inout["shelfnos_id_in"] end
		qty_stk = 	 if kubun == "out" then inout["qty_stk"].to_f*(-1)  else  inout["qty_stk"].to_f end
		qty = 	if kubun == "out" then inout["qty"].to_f*(-1)  else  inout["qty"].to_f end
		strsql = %Q% select * from lotstkhists
						where itms_id = #{inout["itms_id"]} and  lotno = '#{inout["lotno"]}' and 
								processseq = #{inout["processseq"]} and
								packno = '#{inout["packno"]}' and  shelfnos_id = #{shelfnos_id} and
								prjnos_id = #{inout["prjnos_id"]} 
		%
		rec = ActiveRecord::Base.connection.select_one(strsql)
		if rec
			strsql = %Q% update lotstkhists set starttime = '#{inout["starttime"]}',persons_id_upd = #{@sio_user_code||=0},
												qty_stk = #{rec["qty_stk"].to_f - qty_stk},qty = #{rec["qty"].to_f - qty}
							where id = #{rec["id"]}					
			%
			ActiveRecord::Base.connection.update(strsql) 
		else
			lotstkhists_seq = RorBlkctl.proc_get_nextval("lotstkhists_seq")
			strsql = %Q%
			insert into lotstkhists(id,
									itms_id,shelfnos_id,
									prjnos_id,
									starttime,processseq,
									lotno,packno,
									qty_stk,qty,
									stktaking_proc,
									created_at,
									updated_at,
									update_ip,persons_id_upd,expiredate,remark)
							values(#{lotstkhists_seq},
									#{inout["itms_id"]},#{shelfnos_id},
									#{inout["prjnos_id"]},
									'#{inout["starttime"]}',#{inout["processseq"]},
									'#{inout["lotno"]}','#{inout["packno"]}',
									#{qty_stk},#{qty},
									'#{inout["stktaking_proc"]}',
									to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
									to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
									' ',#{@sio_user_code||=0},'#{inout["expiredate"]}','')
			%
			ActiveRecord::Base.connection.insert(strsql) 
		end
	end	

	def proc_createtable fmtbl,totbl,command,email
		strsql = %Q% select pobject_code_sfd from  func_get_screenfield_grpname('#{email}','r_#{totbl}')
		%
		torecs = ActiveRecord::Base.connection.select_values(strsql) 
		command_c = {}
		prevlink = {}
		command.each do |key,val|
			newkey = key.to_s
				newkey = newkey.sub(fmtbl.chop,totbl.chop)
				if torecs.index(newkey)
					command_c[newkey] = command[key]
					if newkey =~ /^#{totbl.chop}/ and  newkey =~ /_sno$|_cno$|_gno$/ 
						command_c[newkey] = command[key] = ""
					else
						if newkey =~ /^#{totbl.chop}/ and  newkey =~ /_sno_|_cno_|_gno_/
							if !val.nil? and val != "" 
								prevlink[newkey] = val
							end
						end
					end
				end	
		end
		case fmtbl
			when "purords"
				case totbl
					when "inspords"
						command_c["inspord_reason_id"] = "0" 
						command_c["inspord_sno_purord"] = command["purord_sno"]
						command_c = update_table command_c,totbl do
							"_add_proc_createtable_data"
						end
					when "payschs"
						command_c["paysch_payment_id_pay"] = command["supplier_payment_id"] 
						command_c["paysch_itm_id"] = command["opeitm_itm_id"] 
						command_c = update_table command_c,totbl do
							"_add_proc_createtable_data"
						end
				end	
			when "puracts"	
				case totbl
					when "inspinsts"
						command_c["inspinst_reason_id"] = "0" 
						command_c["inspinst_sno_purord"] = command["puract_sno_purord"]
						command_c["inspinst_sno_puract"] = command["puract_sno"]
						command_c = update_table command_c,totbl do
							"_add_proc_createtable_data"
						end
					when "payords"
						command_c["payord_payment_id_pay"] = command["supplier_payment_id"] 
						command_c["payord_itm_id"] = command["opeitm_itm_id"] 
						command_c = update_table command_c,totbl do
							"_add_proc_createtable_data"
						end
				end
		end
	end	

	def update_table command_c,totbl
		command_c[:sio_code] = command_c[:sio_viewname]=  "r_" + totbl
		command_c[:sio_message_contents] = nil
		command_c[:sio_recordcount] = 1
		command_c[:sio_result_f] =   "0"  
		command_c[:sio_classname] = yield
		command_c = RorBlkctl.proc_update_table command_c,1
		return command_c
	end

	def proc_prev_trngantts_update xno,prevtbl,val,qty,qty_stk,stktaking_proc
		strsql = %Q% select a.id, a.qty, a.qty_stk from trngantts a,#{prevtbl} b
							where tblname = '#{prevtbl}' and tblid =  b.id and b.#{xno} = '#{val}'  
							order by a.duedate
					%
		recs = ActiveRecord::Base.connection.select_all(strsql) 
		qty = qty.to_f
		qty_stk = qty_stk.to_f
		recs.each do |rec|
			if qty > rec["qty"].to_f 
				qty = qty - rec["qty"].to_f 
				rec["qty"] = 0
			else
				rec["qty"] = rec["qty"].to_f - qty
				qty = 0 
			end
			if qty_stk > rec["qty_stk"].to_f 
				qty_stk = qty_stk - rec["qty_stk"].to_f 
				rec["qty_stk"] = 0
			else
				rec["qty_stk"] = rec["qty_stk"].to_f - qty_stk
				qty_stk = 0 
			end

			strsql = %Q% update  trngantts set qty = #{qty} ,qty_stk = #{qty_stk}
							where id = #{rec["id"]}
				%
			ActiveRecord::Base.connection.update(strsql)

			strsql = %Q% update  instks set qty = #{qty} ,qty_stk = #{qty_stk}
							where trngantts_id = #{rec["id"]}
				%
			ActiveRecord::Base.connection.update(strsql)
			strsql = %Q% select * from  r_instks 	where instk_trngantt_id = #{rec["id"]}
				%
			r_inout = ActiveRecord::Base.connection.select_one(strsql)
			inout = rinout_to_inout "instk",r_inout
			inout["stktaking_proc"] = stktaking_proc
			proc_lotstkhists "in",inout

			strsql = %Q% update  outstks set qty = #{qty} ,qty_stk = #{qty_stk}
							where trngantts_id = #{rec["id"]}
				%
			ActiveRecord::Base.connection.update(strsql)
			strsql = %Q% select * from  r_outstks 	where outstk_trngantt_id = #{rec["id"]}
				%
			r_inout = ActiveRecord::Base.connection.select_one(strsql)
			inout = rinout_to_inout "outstk",r_inout
			inout["stktaking_proc"] = stktaking_proc
			proc_lotstkhists "out",inout
		end
	end

	def rinout_to_inout stk,r_inout
			inout = {}
			inout["shelfnos_id_out"] = r_inout["outstk_shelfno_id_out"]
			inout["shelfnos_id_in"] = r_inout["instk_shelfno_id_in"]
			inout["qty_stk"] = r_inout["#{stk}_qty_stk"]
			inout["qty"] = r_inout["#{stk}_qty"]
			inout["itms_id"] = r_inout["trngantt_itm_id"]
			inout["lotno"] = r_inout["#{stk}_lotno"]
			inout["processseq"] = r_inout["trngantt_processseq"]
			inout["packno"] =  r_inout["#{stk}_packno"]
			inout["prjnos_id"] = r_inout["trngantt_prjno_id"]
			inout["starttime"] = r_inout["#{stk}_starttime"]
			return inout
	end
end   ##module