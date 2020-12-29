# -*- coding: utf-8 -*-
# operation
# 2099/12/31を修正する時は　2100/01/01の修正も
module Operation
	extend self
	
	def proc_get_opeitms_rec itms_id,locas_id,processseq = nil,priority = nil  ###
		strsql = %Q& select * from opeitms where itms_id = #{itms_id} 
					#{if locas_id then " and locas_id = " + locas_id.to_s else "" end}
				   #{if processseq then " and processseq = " + processseq.to_s else "" end}
				   #{if priority then " and priority = " + priority.to_s else "" end}
				   and expiredate > current_date  order by  priority desc &
		newrec = ActiveRecord::Base.connection.select_one(strsql)
		if newrec
			return newrec
		else
			return nil
        end
	end

	def init_trngantts_add_detail   tblname,tblid,paretblname,paretblid,reqparams
		trn = {}
		if reqparams["orgtblname"] == "mkords"   ###mkordsはtreeの親ではない。
			trn["remark"] = "by mkords "
		else
			trn["remark"] = ""
		end		###initの時org=pare=tbl
		orgtblname = paretblname  ###prd,purの作成依頼元
		orgtblid = paretblid
		tbldata = reqparams["tbldata"]
		child = (reqparams["child"]||={})    ###本体単独の時　child=nil
		qty = 	if tbldata["qty"] 
					tbldata["qty"]
				else
					0
				end
		qty_stk = 	if tbldata["qty_stk"] 
						tbldata["qty_stk"]
					else 
						0
					end
		strsql = "select * from opeitms where id = #{tbldata["opeitms_id"]} "  ###trnganttsテーブルの対象テーブルにはopeitms_idを必ず含む
		opeitm = ActiveRecord::Base.connection.select_one(strsql)
		reqparams["opeitm"] = opeitm

		strsql = "select * from r_#{paretblname} where id = #{paretblid} "
		pare_tbl = ActiveRecord::Base.connection.select_one(strsql)
		case tblname
			when /^prdschs|^purschs/
				trn["locas_id"] = pare_tbl["opeitm_loca_id"]
			when /^prdords/
				trn["locas_id"] = pare_tbl["workplace_loca_id_workplace"]
			when /^prdinsts/
				tbldata["starttime"] = tbldata["duedate"] = tbldata["replydate"]
				trn["locas_id"] = pare_tbl["workplace_loca_id_workplace"]
			when /^prdacts/
				tbldata["starttime"] = tbldata["duedate"] = tbldata["cmpldate"]
				trn["locas_id"] = pare_tbl["workplace_loca_id_workplace"]
			when /^purords|^inspords/
				trn["locas_id"] = pare_tbl["supplier_loca_id_supplier"]
			when /^purinsts|^inspinsts/
				tbldata["starttime"] = tbldata["duedate"] = tbldata["replydate"]
				trn["locas_id"] = pare_tbl["supplier_loca_id_supplier"]
			when /^puracts|^inpsacts/
				tbldata["starttime"] = tbldata["duedate"] = tbldata["rcptdate"]
				trn["locas_id"] = pare_tbl["supplier_loca_id_supplier"]
			when /^custschs/
				tbldata["shelfnos_id_to"] = opeitm["shelfnos_id"]  ###shelfnos_id_fm:親がこの子部品をどこからとってくるか
				tbldata["starttime"] = (tbldata["duedate"].to_date - 1).strftime("%Y-%m-%d %H:%M:%S")
				trn["locas_id"] = opeitm["locas_id"]
			when /^custords/
				tbldata["shelfnos_id_to"] = opeitm["shelfnos_id"]  ###shelfnos_id_fm:親がこの子部品をどこからとってくるか
				tbldata["starttime"] = (tbldata["duedate"].to_date - 1).strftime("%Y-%m-%d %H:%M:%S")
				trn["locas_id"] = opeitm["locas_id"]
		end

		trn["key"] = reqparams["trnganttkey"] = "00000"
		trn["orgtblname"] = orgtblname
		trn["orgtblid"] = orgtblid
		trn["paretblname"] = paretblname
		trn["paretblid"] = paretblid
		trn["tblname"] = tblname
		trn["tblid"] = tblid
		trn["mlevel"] = 0
		trn["shuffle_flg"] = (opeitm["shuffle_flg"]||="0")
		trn["parenum"] = trn["chilnum"] = 1
		trn["qty"] = qty
		trn["qty_bal"] =  (tbldata["qty_bal"]||=0) 
		trn["qty_stk"]  = qty_stk
		trn["qty_alloc"]  = 0
		trn["qty_linkto_alloctbl"] = 0
		trn["qty_pare"] = (pare_tbl["#{paretblname.chop}_qty"]||=0)
		trn["qty_pare_alloc"] = 0
		trn["qty_stk_pare"] = (pare_tbl["#{paretblname.chop}_qty_stk"]||=0)
		trn["qty_pare_bal"] = (pare_tbl["#{paretblname.chop}_qty_bal"]||=0)
		trn["itms_id"] = opeitm["itms_id"]
		trn["processseq"] = opeitm["processseq"] 
		trn["shelfnos_id_fm"] = opeitm["shelfnos_id"] 
		trn["prjnos_id"] = tbldata["prjnos_id"]
		trn["itms_id_pare"]  = pare_tbl["opeitm_itm_id"] 
		trn["processseq_pare"]  = pare_tbl["opeitm_processseq"] 
		trn["locas_id_pare"] = pare_tbl["opeitm_loca_id"]
		trn["consumtype"] = child["consumtype"]
		trn["consumunitqty"] = (child["consumunitqty"]||=0) 
		trn["consumminqty"]  = (child["consumminqty"]||=0) 
		trn["consumchgoverqty"] = (child["consumchgoverqty"]||=0)
		trn["starttime"] = tbldata["starttime"]
		trn["duedate"] = trn["duedate_org"] = tbldata["duedate"]
		trngantts_id = RorBlkctl.proc_get_nextval("trngantts_seq")
		trn["trngantts_id"] = trn["id"] = trngantts_id
		###trn["autocreate_ord"]を追加
		trn["remark"] << "110"
		insert_trngantt trn

		alloc = {}  ###alloctbls　 ###instks,outstks作成用
		fields = {}
		fields[:alloctbls_id] = alloc["id"] = RorBlkctl.proc_get_nextval("alloctbls_seq")
		alloc["srctblname"] = fields[:srctblname] = tblname
		alloc["srctblid"] = fields[:srctblid] = tblid
		if 	trn["tblname"] =~ /purschs|prdschs/ 
			alloc["qty"] = fields[:qty] = trn["qty"].to_f - trn["qty_bal"].to_f  ### 必要数のみ
		else
			alloc["qty"] = fields[:qty] = trn["qty"].to_f
		end	
		alloc["qty_stk"] =  fields[:qty_stk] = trn["qty_stk"]
		alloc["qty_linkto_alloctbl"] = fields[:qty_linkto_alloctbl] = 0
		alloc["qty_alloc"] = fields[:qty_alloc] = 0
		alloc["trngantts_id"] = fields[:trngantts_id] = trngantts_id
		alloc["remark"] = "97"
		insert_alloctbls alloc
		
		strsql = %Q%select * from r_#{tblname} where id = #{tblid}
		%
		command_r = ActiveRecord::Base.connection.select_one(strsql)
		fields[:inoutflg] = tblname[0..2]
		add_stkinouts(fields,command_r,"add")  ###tblname,tblid,command_r,alloctbls_id

		if tblname =~ /purords|prdords/
			reqparams["trngantts_id"] = trngantts_id
			free = trn.dup
			free["free_trngantts_id"] = trn["id"] 
			free["free_alloctbls_id"] = alloc["id"] 
			free_ordtbl_to_alloc free,reqparams,tblname
		end
		return  trngantts_id,reqparams
	end

	def child_trngantts  tblname,tblid,reqparams
		strsql = %Q% select * from trngantts where key = '#{reqparams["orgtrnganttkey"]}' and 
					orgtblname = '#{reqparams["orgtblname"]}' and orgtblid = #{reqparams["orgtblid"]}
		%
		pare = ActiveRecord::Base.connection.select_one(strsql)
		### keyはorgtblname,orgtblid,key,tblname,tblidであるがorgtblname,orgtblid,keyで検索
		###  員数等はorgtblname,orgtblid,keyで同一であること。
		tbldata = reqparams["tbldata"]
		child = reqparams["child"] ##nditmd 子供の情報
		pare_opeitm = proc_get_opeitms_rec pare["itms_id"],nil,pare["processseq"],priority = nil
		child_opeitm = proc_get_opeitms_rec child["itms_id_nditm"],nil,child["processseq_nditm"],priority = nil

		trn = {}
		trn["key"] = reqparams["trnganttkey"]
		trn["orgtblname"] = reqparams["orgtblname"]
		trn["orgtblid"] = reqparams["orgtblid"]
		trn["paretblname"] = pare["tblname"]
		trn["paretblid"] = pare["tblid"]
		trn["tblname"] = tblname
		trn["tblid"] = tblid
		trn["mlevel"] = pare["mlevel"].to_i+1
		trn["shuffle_flg"] = pare["shuffle_flg"]
		trn["parenum"] = child["parenum"]
		trn["chilnum"] = child["chilnum"]
		trn["qty_pare"] = (pare["qty"]||=0)
		trn["qty_pare_alloc"] = pare["qty_alloc"]
		trn["qty_pare_bal"] = (pare["qty_bal"]||=0)
		trn["qty_stk_pare"]  = (pare["qty_stk"]||=0)
		trn["qty"] = (tbldata["qty"]||=0)
		pare_qty_alloc_bal = trn["qty_pare"].to_f - (pare["qty_alloc"].to_f + pare["qty_linkto_alloctbl"].to_f) 
		pare_packqty = if (pare_opeitm["packqty"]||="0") == "0"
							1
						else
							pare_opeitm["packqty"].to_f
						end
		pare_packqty = if pare_packqty == 0 then 1 else	pare_packqty end
		pare_qty_alloc_bal = (pare_qty_alloc_bal/pare_packqty).ceil*pare_packqty
		qty_alloc_bal  = pare_qty_alloc_bal * child["chilnum"].to_f / child["parenum"].to_f
		packqty = if (child_opeitm["packqty"]||="0") == "0" 
					1
				 else
					 child_opeitm["packqty"].to_f
				 end 
		packqty = if  packqty == 0 then 1 else 	packqty end	
		qty_alloc_bal = ((qty_alloc_bal/packqty).ceil )*packqty
		trn["qty_alloc"] = trn["qty"].to_f -  qty_alloc_bal
		trn["qty_stk"] = (tbldata["qty_stk"]||=0)
		trn["qty_bal"] = (tbldata["qty_bal"]||=0)
		### parenum chilnum
		trn["qty_linkto_alloctbl"] = 0
		trn["itms_id"] = child["itms_id_nditm"]
		trn["processseq"] = child["processseq_nditm"]
		trn["shelfnos_id_fm"] = child_opeitm["shelfnos_id"] 
		trn["prjnos_id"] = tbldata["prjnos_id"]
		trn["locas_id"] = child_opeitm["locas_id"]  ###
		trn["itms_id_pare"]  = pare["itms_id"]
		trn["processseq_pare"]  = pare["processseq"]
		trn["locas_id_pare"] = pare_opeitm["locas_id"]
		trn["consumtype"] = child["consumtype"]
		trn["consumunitqty"] = child["consumunitqty"] 
		trn["consumminqty"]  = child["consumminqty"] 
		trn["consumchgoverqty"] = child["consumchgoverqty"]
		trn["starttime"] = pare["starttime"].to_date-1
		trn["duedate"] = trn["starttime"].to_date-child["duration"].to_i
		trn["duedate_org"] = trn["duedate"]
		trngantts_id = RorBlkctl.proc_get_nextval("trngantts_seq")
		trn["trngantts_id"] = trngantts_id
		trn["remark"] = "770"
		insert_trngantt trn

		 ###親の引き当て処理追加要		

		alloc = {}  ###instks,outstks作成用
		fields = {}
		fields[:alloctbls_id] = alloc["id"] = RorBlkctl.proc_get_nextval("alloctbls_seq")
		alloc["srctblname"] = fields[:srctblname] = tblname
		alloc["srctblid"] = fields[:srctblid] = tblid
		alloc["qty"] = fields[:qty] = trn["qty"].to_f
		alloc["qty_stk"] =  fields[:qty_stk] = trn["qty_stk"]
		alloc["qty_alloc"] = fields[:qty_alloc] = trn["qty_alloc"]  ###親の引き当て処理追加後変更要
		alloc["qty_linkto_alloctbl"] = fields[:qty_linkto_alloctbl] = 0
		alloc["remark"] = "610"
		alloc["trngantts_id"]  = fields[:trngantts_id] =  trngantts_id 
		insert_alloctbls alloc

		strsql = %Q%select * from r_#{tblname} where id = #{tblid}
		%
		command_r = ActiveRecord::Base.connection.select_one(strsql)
		fields[:inoutflg] = tblname[0..2]
		add_stkinouts(fields,command_r,"add")  ###tblname,tblid,command_r,alloctbls_id
		
		 ###元がordsの時のみ子のschsをords等に引き当てる。
		if reqparams["orgtblname"] =~ /ords$/ 
			reqparams["trngantts_id"] = trn["id"] = trngantts_id
			###新規登録なのでqty_linkto_alloctbl=0
			###親が新規登録後引き当る可能性があるのでqty_alloc != 0
			required_sch_qty = trn["qty"].to_f - trn["qty_alloc"].to_f - trn["qty_bal"].to_f
			sch_alloc = schstbl_alloc_to_freetbl(tblname,tblid,reqparams,trn,required_sch_qty)
			# if sch_alloc[:qty_linkto_alloctbl] >= required_sch_qty and trn["qty_bal"].to_f > 0
			# 	strsql = %Q%update alloctbls set qty = #{alloc["qty"] -  trn["qty_bal"].to_f }
			# 				where id = #{alloc["id"]}
			# 	%
			# 	ActiveRecord::Base.connection.update(strsql)
			# end	
		end
		return trngantts_id,reqparams
	end

	def add_alloc_and_trn free,sch,add_free_qty,sourceline ###free:free_trngantts    sch:custords等のtrngantts  
		###
		if free["qty_stk"].to_f > 0
			add_free_qty_stk = add_free_qty
			add_free_qty = 0
		else
			add_free_qty_stk = 0
		end	
		strsql = %Q&update trngantts set
						updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'), 
						qty_linkto_alloctbl = #{sch["sch_qty_linkto_alloctbl"].to_f + add_free_qty },		
						qty_stk = #{sch["sch_qty_stk"].to_f + add_free_qty_stk}, ---	qty_linkto_alloctblの在庫内訳数変更		
						remark = '242 <-- #{sourceline[0..100]}' where id = #{sch["id"]}
						&  ###qty_stk free以外の時はqty_linkto_alloctblのstk内訳
		ActiveRecord::Base.connection.update(strsql)  ###trnの引き当て数変更
		###
		#### free のxxxordsのalloctblsの変更
		###
		strsql = %Q%select * from r_#{free["orgtblname"]} where id = #{free["orgtblid"]}
		%
		command_r = ActiveRecord::Base.connection.select_one(strsql)  ###tblname,tblid,command_r,alloctbls_id
		### free引き当て可能数の減 qtyは変更数をセット
		fields = {:trngantts_id=>free["id"],:srctblname=>free["tblname"],:srctblid=>free["tblid"],
					:qty=> -(add_free_qty )  ,:qty_stk=> -add_free_qty_stk , ###qty_XXX増減数
					:remark=>"161 <-- #{sourceline[0..100]} ",
					:inoutflg =>free["orgtblname"][0..2] ,
					:qty_linkto_alloctbl=>0 ,
					:qty_alloc=>0} 
					 ###追加の数量，親からの引当数(qty_alloc)=0 
		### 引き当て可能数の減
		rec = add_update_alloctbls fields,command_r   ###➀ trngantts:alloctbls=1:1
		###
		#### free to alloc 
		###
		### free trnganttsに引き当っている内訳(alloctbls)を作成	
		fields = {:trngantts_id=>sch["id"],:srctblname=>free["tblname"],:srctblid=>free["tblid"],
					:remark=>" 280 <--#{sourceline[0..100]} ",
					:inoutflg =>free["orgtblname"][0..2] ,
					:qty_linkto_alloctbl=>0,:qty_alloc=>0,
					:qty=>add_free_qty ,:qty_stk=>add_free_qty_stk}
		###
		ord_alloc = add_update_alloctbls fields,command_r     ###➁trngantts:alloctbls=1:n
		###
		#### sch のalloctblsの変更
		###
		strsql = %Q%select * from r_#{sch["tblname"]} where id = #{sch["tblid"]}
		%
		command_r = ActiveRecord::Base.connection.select_one(strsql)
		### 既に登録済のはず
		fields = {:trngantts_id=>sch["id"],:srctblname=>sch["tblname"],:srctblid=>sch["tblid"],
				:remark=>" 295 <---#{sourceline[0..100]}",
				:qty=>0,:qty_stk=>0,:qty_alloc=>0,   ###qty,qty_stk,qty_alloc変化なし
				:inoutflg =>free["orgtblname"][0..2] ,
				:qty_linkto_alloctbl=>add_free_qty } 
		###　引当済数の追加
		sch_alloc = add_update_alloctbls fields ,command_r    ###➂		###trngantts:alloctbls=1:1
		#### free to alloc
		###
		return sch_alloc
	end

	def add_update_alloctbls fields,command_r ###fieldsのqtyには増減分をセット
		###freeのin-out数変更
		srctblname = fields[:srctblname]
		srctblid = fields[:srctblid]
		strsql = %Q%select  id,qty,qty_stk,qty_linkto_alloctbl,qty_alloc,remark from alloctbls 
				where srctblname = '#{srctblname}' and srctblid = #{srctblid} 
				and trngantts_id = #{fields[:trngantts_id]} 
			%
		rec = ActiveRecord::Base.connection.select_one(strsql)
		if rec 
			fields[:alloctbls_id] = rec["id"]
			if fields[:qty_linkto_alloctbl].nil?
				qty_linkto_alloctbl = rec["qty_linkto_alloctbl"].to_f
			else
				qty_linkto_alloctbl = fields[:qty_linkto_alloctbl].to_f + rec["qty_linkto_alloctbl"].to_f
			end
			if fields[:qty_alloc].nil?
				fields[:qty_alloc] = rec["qty_alloc"].to_f
			else
				fields[:qty_alloc] = fields[:qty_alloc].to_f + rec["qty_alloc"].to_f
			end
			if fields[:qty].nil?
				fields[:qty] = rec["qty"].to_f
			else
				fields[:qty] = fields[:qty].to_f + rec["qty"].to_f
			end
			if fields[:qty_stk].nil?
				fields[:qty_stk] = rec["qty_stk"].to_f
			else
				fields[:qty_stk] = fields[:qty_stk].to_f + rec["qty_stk"].to_f
			end
			if fields[:srctblname] =~ /schs$/ ###packqtyによって丸められたqty調整。丸まった数は不要。
				strsql = %Q%select  sum(qty_linkto_alloctbl) qty_linkto_alloctbl from alloctbls 
							where srctblname = '#{srctblname}' and srctblid = #{srctblid} 
							group by srctblname,srctblid
				%
				sum_link_qty = ActiveRecord::Base.connection.select_value(strsql)
				sum_link_qty = sum_link_qty.to_f + fields[:qty_linkto_alloctbl].to_f
				if command_r["#{srctblname.chop}_qty"].to_f - sum_link_qty.to_f <= command_r["#{srctblname.chop}_qty_bal"].to_f
					fields[:qty] = sum_link_qty
				end	
				fields[:qty_linkto_alloctbl] = 	qty_linkto_alloctbl
			else
				fields[:qty_linkto_alloctbl] = 	qty_linkto_alloctbl
			end	
			strsql = %Q&update alloctbls set 
						updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						qty_linkto_alloctbl = #{qty_linkto_alloctbl},
						qty_alloc = #{fields[:qty_alloc]},qty = #{fields[:qty]},qty_stk = #{fields[:qty_stk]},
						remark = '336 <--#{(fields[:remark]+rec["remark"])[0..100]}' where id = #{rec["id"]}
						&
			ActiveRecord::Base.connection.update(strsql)
			add_stkinouts(fields,command_r,"update")  ###rec["id"]:alloctbls_id
		else
			rec = {}
			rec["id"] = fields[:alloctbls_id] = RorBlkctl.proc_get_nextval("alloctbls_seq")
			rec["srctblname"] = fields[:srctblname]
			rec["srctblid"] = fields[:srctblid]
			rec["trngantts_id"] = fields[:trngantts_id]
			rec["qty_stk"] =  (fields[:qty_stk]||=0)
			rec["qty"] = (fields[:qty]||=0)
			rec["qty_linkto_alloctbl"] = (fields[:qty_linkto_alloctbl]||=0)
			rec["qty_alloc"] = (fields[:qty_alloc]||=0)
			rec["remark"] = "350 <-- #{fields[:remark][0..100]}"
			insert_alloctbls rec
			add_stkinouts(fields,command_r,"add")  ###rec["id"]:alloctbls_id
		end
		return fields
	end	

	def proc_consume_child_parts rec,act_qty,tblname,tblid  ###親がactsの時 rec:trngantts,packqty 
		strsql = %Q%select * from outstks where alloctbls_id = #{rec["alloc_id"]} 
											and inoutflg = 'con'
		%	###  xxxORDSの消費量変更
		consume_qty = consume_qty1 = act_qty / rec["parenum"].to_f * rec["chilnum"].to_f
		ActiveRecord::Base.connection.select_all(strsql).each do |outstk| 
			stkinout = {}
			stkinout["alloctbls_id"] = rec["alloc_id"]
			stkinout["shelfnos_id_out"] = outstk["shelfnos_id_out"]
			stkinout["starttime"] = outstk["starttime"]
			stkinout["qty_sch"] = stkinout["qty"] = 0
			stkinout["inoutflg"] = 'con'
			stkinout["expiredate"] = outstk["expiredate"]
			stkinout["remark"] = "248 proc_consume_child_parts "
			strsql =%Q%select * from lotstkhists where itms_id = #{rec["itms_id"]} and processseq = #{rec["processseq"]} 
									and	shelfnos_id = #{outstk["shelfnos_id_out"]}
									and prjnos_id in(select func_get_prjno_id('#{tblname}',#{tblid}))
									and (qty_sch + qty + qty_stk) > 0
									order by prjnos_id desc
			%
			ActiveRecord::Base.connection.select_all(strsql).each do |lot|
				stkinout["lotno"] = lot["lotno"]
				stkinout["packno"] = lot["packno"] 
				stkinout["qty_stk"] = 0
				if lot["qty_stk"].to_f >= consume_qty   ###xxxordsの消費を削除
					stkinout["qty_stk"] = consume_qty
					consume_qty = 0
				else  ###qty,qty_sch,qty_stkのいずれ一つのみ>0
					stkinout["qty_stk"]  =  lot["qty_stk"].to_f 
					consume_qty = consume_qty - lot["qty_stk"].to_f 
					if lot["qty"].to_f >= consume_qty   ###xxxordsの消費を削除
						stkinout["qty_stk"] = consume_qty + stkinout["qty_stk"]
						consume_qty = 0
					else  ###qty,qty_sch,qty_stkのいずれ一つのみ>0
						stkinout["qty_stk"]  =  lot["qty"].to_f  + stkinout["qty_stk"]
						consume_qty = consume_qty - lot["qty"].to_f 
						if  lot["qty_sch"].to_f >= consume_qty 
							stkinout["qty_stk"] = consume_qty + stkinout["qty_stk"]
							consume_qty = 0
						else	
							stkinout["qty_stk"] = lot["qty_sch"].to_f + stkinout["qty_stk"]
							consume_qty = consume_qty - lot["qty_sch"].to_f	
						end				
					end	
				end
				outstks_id = RorBlkctl.proc_get_nextval("outstks_seq")
				ActiveRecord::Base.connection.insert(outstk_strsql(stkinout,outstks_id))
				break  if  consume_qty <= 0
			end	 
			if consume_qty > 0
				stkinout["lotno"] = ""
				stkinout["packno"] = if rec["packqty"].to_f == 0 then "" else "packno" end
				stkinout["qty_stk"] = consume_qty
				outstks_id = RorBlkctl.proc_get_nextval("outstks_seq")
				ActiveRecord::Base.connection.insert(outstk_strsql(stkinout,outstks_id))
			end
			### schs,ordsの消費削除
			if outstk["qty_stk"].to_f >= consume_qty1   ###xxxordsの消費を削除
				outstk["qty_stk"] = outstk["qty_stk"].to_f - consume_qty1
				consume_qty1 = 0
			else  ###qty,qty_sch,qty_stkのいずれ一つのみ>0
				consume_qty1 = consume_qty1 -  outstk["qty_stk"].to_f
				outstk["qty_stk"] = 0
				if  outstk["qty"].to_f >= consume_qty1   ###xxxordsの消費を削除
					outstk["qty"] =  outstk["qty"].to_f - consume_qty1
					consume_qty1 = 0
				else 
					consume_qty1 = consume_qty1 -  outstk["qty"].to_f
					outstk["qty"] = 0
					if outstk["qty_sch"].to_f  >=  consume_qty1 
						outstk["qty_sch"] =  outstk["qty_sch"].to_f - consume_qty1
						consume_qty1 = 0
					else
						consume_qty1 = consume_qty1 - outstk["qty_sch"].to_f
						outstk["qty_sch"] = 0
					end
				end		
			end
			strsql = %Q%update outstks set qty_stk = #{outstk["qty_stk"]},qty = #{outstk["qty"]} ,
						qty_sch = #{outstk["qty_sch"]},	remark = '304 proc_consume_child_parts',
						updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss')
						where id =#{outstk["id"]}
			%
			ActiveRecord::Base.connection.update(strsql)
			break  if  consume_qty1 <= 0
		end	
	end

	def insert_trngantt trn
		strsql = %Q&
		insert into trngantts(id,key,
							orgtblname,orgtblid,paretblname,paretblid,
							tblname,tblid,
							mlevel,
							shuffle_flg,
							parenum,chilnum,
							qty,qty_stk,qty_bal,
							qty_alloc,qty_linkto_alloctbl,
							qty_pare,qty_stk_pare,qty_pare_alloc,qty_pare_bal,
							itms_id,processseq,shelfnos_id_fm,prjnos_id,locas_id,
							itms_id_pare,processseq_pare,locas_id_pare,
							consumtype,consumunitqty,consumminqty,consumchgoverqty,
							starttime,
							duedate,
							duedate_org,
							created_at,
							updated_at,
							update_ip,persons_id_upd,expiredate,remark)
			values(#{trn["trngantts_id"]},'#{trn["key"]}',
						'#{trn["orgtblname"]}',#{trn["orgtblid"]},'#{trn["paretblname"]}',#{trn["paretblid"]},
						'#{trn["tblname"]}',#{trn["tblid"]},
						'#{trn["mlevel"]}',
						'#{trn["shuffle_flg"]}',
						#{trn["parenum"]},#{trn["chilnum"]},
						#{trn["qty"]},#{trn["qty_stk"]},#{trn["qty_bal"]},
						#{trn["qty_alloc"]},#{trn["qty_linkto_alloctbl"]},
						#{trn["qty_pare"]},#{trn["qty_stk_pare"]},#{trn["qty_pare_alloc"]},#{trn["qty_pare_bal"]},
						#{trn["itms_id"]},#{trn["processseq"]},#{trn["shelfnos_id_fm"]},#{trn["prjnos_id"]},#{trn["locas_id"]},
						#{trn["itms_id_pare"]},#{trn["processseq_pare"]},#{trn["locas_id_pare"]},
						'#{trn["consumtype"]}',#{trn["consumunitqty"]},#{trn["consumminqty"]},#{trn["consumchgoverqty"]},
						to_timestamp('#{trn["starttime"]}','yyyy/mm/dd hh24:mi:ss'),
						to_timestamp('#{trn["duedate"]}','yyyy/mm/dd hh24:mi:ss'),
						to_timestamp('#{trn["duedate_org"]}','yyyy/mm/dd hh24:mi:ss'),
						to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						' ','0','2099/12/31','#{trn["remark"]}')
		&
		ActiveRecord::Base.connection.insert(strsql)
		return
	end

	def insert_alloctbls trn
		strsql = %Q&
		insert into alloctbls(id,
							srctblname,srctblid,
							trngantts_id,
							qty,qty_stk,
							qty_linkto_alloctbl,
							qty_alloc,
							created_at,
							updated_at,
							update_ip,persons_id_upd,expiredate,remark)
					values(#{trn["id"]},
							'#{trn["srctblname"]}',#{trn["srctblid"]},
							#{trn["trngantts_id"]},
							#{trn["qty"]},#{trn["qty_stk"]},
							#{trn["qty_linkto_alloctbl"]},
							#{trn["qty_alloc"]},
							to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
							to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
							' ','0','2099/12/31','#{trn["remark"]}')
		&
		ActiveRecord::Base.connection.insert(strsql)
		return
	end

	def schstbl_alloc_to_freetbl  tblname,tblid,reqparams,sch,required_sch_qty
		   ###qty 発注又は製造まとめ数　在庫があるときは qty - qty_bal が必要数になる。未対応 
		tbldata = reqparams["tbldata"]
		opeitm = reqparams["opeitm"]
		###freeを探す　xxxordsのみ引き当てる。
		strsql = %Q%select locas_id_shelfno from shelfnos where id = #{opeitm["shelfnos_id"]}
		%
		locas_id_shelfno =  ActiveRecord::Base.connection.select_value(strsql)

		strsql = %Q&select   ---  free
					case
					when a.qty_stk >  a.qty_alloc
						then '02' 
					when  a.duedate <= to_date('#{tbldata["duedate"]}','yyyy-mm-/dd')
						then '01'	
					else
						'03' end  priority,
					to_number(to_char(duedate,'yyyymmdd'),'99999999')*-1 due,
					case 
						when b.qty - b.qty_linkto_alloctbl >= b.qty - b.qty_alloc then
							b.qty - b.qty_linkto_alloctbl
						else
							b.qty - b.qty_alloc
						end	 qty,
					a.qty_alloc qty_alloc,
					a.qty_linkto_alloctbl qty_linkto_alloctbl,
					a.qty_pare_alloc qty_pare_alloc,a.itms_id,a.prjnos_id,a.shelfnos_id_fm,
					a.id id,a.orgtblname orgtblname,a.orgtblid orgtblid,a.tblname tblname,a.tblid tblid			
					from trngantts a
					inner join alloctbls b on a.id = b.trngantts_id and a.orgtblname = b.srctblname and a.orgtblid = b.srctblid
					inner join shelfnos c on a.shelfnos_id_fm = c.id
					where a.prjnos_id =  #{tbldata["prjnos_id"]}
						and a.orgtblname = a.paretblname and a.paretblname = a.tblname
						and a.orgtblid = a.paretblid  and a.paretblid = a.tblid
						and  a.itms_id = #{opeitm["itms_id"]} and a.processseq = #{opeitm["processseq"]}
						and c.locas_id_shelfno = #{locas_id_shelfno}
						and (a.tblname like 'prd%' or a.tblname like 'pur%' or a.tblname = 'lotstkhists')
						--- freeの在庫は　trnganttsでorgtblname=paretblname=tblname="lotstkhists"
						and (b.qty - b.qty_linkto_alloctbl) >  0 
						and (b.qty - b.qty_alloc) >  0 
						 --- free trnではfree["qty_alloc"].to_f==0 
						order by priority,due
						for update
					& ### xxxacts等を登録するときは必ずxxxordsを前に登録すること。
		required_sch_qty_stk = 0  ###ベースのtrngantsのqty_stkはzero 
		sch_alloc = {:qty_linkto_alloctbl =>0}
		ActiveRecord::Base.connection.select_all(strsql).each do |free|   ### free trnではfree["qty_alloc"].to_f==0 
			bal_free_qty = free["qty"].to_f 
			bal_free_qty_stk = free["qty_stk"].to_f 
			if bal_free_qty >= required_sch_qty
				###add_alloc_and_trn free_rec,sch_rec,free_qty, qty_stk
				sch_alloc = add_alloc_and_trn free,sch,required_sch_qty,"558"  ###引きあたったalloc作成
				bal_free_qty -= required_sch_qty
			else
				if bal_free_qty_stk >= required_sch_qty
					sch_alloc = add_alloc_and_trn free,sch,required_sch_qty,"562" ###引きあたったalloc作成
					bal_free_qty_stk -= required_sch_qty
				else
					if bal_free_qty > 0
						sch_alloc = add_alloc_and_trn free,sch,bal_free_qty,"566" ###引きあたったalloc作成
						bal_free_qty = 0
					else
						if bal_free_qty_stk > 0
							sch_alloc = add_alloc_and_trn free,sch,bal_free_qty_stk,"570" ###引きあたったalloc作成
							bal_free_qty_stk = 0
						else
							p"error 567"
						end		
					end	
				end	
			end  ### 
		end
		
		###freeのxxxordsテーブルに引きあたった子部品を引き当て済にする。
		###  prdords,purordsでは直下のみ展開
		return sch_alloc
	end	

	def alloc_strsql tbldata,opeitm,locas_id_shelfno,sch_sno  ###free ords等に引き当るschを探す
		%Q&
		select a.id id,'01' priority,to_number(to_char(duedate,'yyyymmdd'),'99999999')*-1 due,d.id alloc_id,
		case 
		when d.qty - d.qty_alloc >=  d.qty -  d.qty_linkto_alloctbl then
			d.qty - d.qty_alloc
		else 
			d.qty - d.qty_linkto_alloctbl end required_sch_qty,
		d.qty,d.qty_alloc qty_alloc,d.qty_linkto_alloctbl qty_linkto_alloctbl,a.qty_bal qty_bal,
		a.qty sch_qty,a.qty_alloc sch_qty_alloc,a.qty_linkto_alloctbl sch_qty_linkto_alloctbl,
		a.qty_pare_alloc sch_qty_pare_alloc,
		a.orgtblname orgtblname,a.orgtblid orgtblid,a.tblname tblname,a.tblid tblid,
		a.itms_id,a.processseq,a.qty_bal,o.packqty,a.expiredate,a.remark sch_remark,		
		a.qty_pare sch_qty_pare,a.parenum,a.chilnum#{sch_sno}
		from trngantts a  --- schでは　trn:alloc= 1:1
		inner join shelfnos c on  a.shelfnos_id_fm = c.id
		inner join alloctbls d on  a.id = d.trngantts_id
		inner join opeitms o on  a.itms_id = o.itms_id and a.processseq = o.processseq and a.locas_id = o.locas_id
		#{yield}
		where a.prjnos_id =  #{tbldata["prjnos_id"]} and a.orgtblname like '%ords'  --- topがordsのみ対象
			and  a.paretblid != a.tblid and a.tblname like '%schs'
			and  a.itms_id = #{opeitm["itms_id"]} and a.processseq = #{opeitm["processseq"]}
			and c.locas_id_shelfno = #{locas_id_shelfno}
			and a.tblname = d.srctblname and a.tblid = d.srctblid
			and (d.qty - d.qty_alloc ) > 0  ---
			and (d.qty - d.qty_linkto_alloctbl) > 0  ---
		order by priority,duedate,a.id for update of a,d ---d.qty_linkto_alloctbl insts,actsに既に移行済
		&
	end
	
	### free purords又はprdords
	def free_ordtbl_to_alloc  free,reqparams,tblname 
		 ###freeで登録されたordを引き当てる。free:trngantts-->orgtblid=paretblid=tblid
		tbldata = reqparams["tbldata"]
		opeitm = reqparams["opeitm"]
		srctblname = tblname.gsub("ord","sch")
		strsql = %Q%select locas_id_shelfno from shelfnos where id = #{opeitm["shelfnos_id"]}
		%  ### free trn org=pare=tbl では qty - qty_linkto_alloctblがfree残数
		locas_id_shelfno =  ActiveRecord::Base.connection.select_value(strsql)
		case reqparams["segment"]  
		when "trngantts"
			sch_sno = (tbldata[%Q%sno_#{srctblname.chop}%]||="")
			if sch_sno == ""
				strsql = alloc_strsql tbldata,opeitm,locas_id_shelfno,sch_sno do 
					if reqparams["mkords_id"]   ###ords作成バッチを利用した時
						%Q%inner join schofmkords mkord on 
									a.id = mkord.trngantts_id and a.itms_id = mkord.itms_id and
									a.processseq = mkord.processseq and
									mkord.mkords_id = #{reqparams["mkords_id"]} %
					else ###ords単独で入力した時
						""
					end
				end
			else   ###xxxordsでxxxschsのsnoを指定したとき
				sch_sno = ",sch.sno,sch.cno"
				strsql = alloc_strsql tbldata,opeitm,locas_id_shelfno,sch_sno do
					if reqparams["mkords_id"]
						%Q%inner join #{srctblname} sch on "
								sch.sno = '#{tbldata["sno_#{srctblname.chop}"]}' 
							inner join schofmkords mkord on 
								a.id = mkord.trngantts_id and a.itms_id = mkord.itms_id  and
								a.processseq = mkord.processseq and
								mkord.mkords_id = #{reqparams["mkords_id"]} %
					else
						%Q%inner join #{srctblname} sch on "
								sch.sno = '#{tbldata["sno_#{srctblname.chop}"]}' %
					end				 
				end
			end
		else	
			Rails.logger.debug" error segment:#{reqparams["segment"]} \n reqparams: #{reqparams} "
			Rails.logger.debug" error free: #{free} "
		end
		ActiveRecord::Base.connection.select_all(strsql).each do |sch|  ###freeを求めているschsを検索
			###freeのtrngantts freeのqtyとfreeのqty_stkはレコードが分かれる。
			bal_free_qty = free["qty"].to_f 
			bal_free_qty_stk = free["qty_stk"].to_f ### free_recのqty_allocはzero ,新規のためqty_linkto_alloctblはzero 
			required_sch_qty =  sch["required_sch_qty"].to_f
			if bal_free_qty >= required_sch_qty 
				fields = add_alloc_and_trn free,sch, required_sch_qty,"662" ###freeに引きあたったalloc作成
				qty_linkto_alloctbl = required_sch_qty
				bal_free_qty -= required_sch_qty
				bal_free_qty_stk = 0
			else	
				if bal_free_qty_stk >= required_sch_qty 
					fields = add_alloc_and_trn free,sch, required_sch_qty,"667" ###freeに引きあたったalloc作成
					qty_linkto_alloctbl = required_sch_qty
					bal_free_qty_stk -= required_sch_qty
					bal_free_qty = 0
				else
					if bal_free_qty > 0 
						fields = add_alloc_and_trn free,sch, bal_free_qty,"672" ###freeに引きあたったalloc作成
						qty_linkto_alloctbl = bal_free_qty
						bal_free_qty = 0
						bal_free_qty_stk = 0
					else
						if bal_free_qty_stk > 0
							fields = add_alloc_and_trn free,sch, bal_free_qty_stk,"676" ###freeに引きあたったalloc作成
							qty_linkto_alloctbl = bal_free_qty_stk
							bal_free_qty_stk = 0
							bal_free_qty = 0
						end
					end
				end
				###
			end
			free_ordtbl_to_alloc_child sch,fields  ###freeのxxxordsテーブルを他のオーだのもとにあるxxxschsに引き当てる。
			break if bal_free_qty <= 0 and  bal_free_qty_stk <= 0 
		end
		return
	end	

	def add_update_srctbl srctblname,srctblid,tbl   ###sno,cnoでの前の状態との関係
		strsql = %Q% select id,qty_src from srctbls where srctblid = #{srctblid} and srctblname = '#{srctblname}'
							and tblname = '#{tbl[:tblname]}' and tblid = #{tbl[:id]}
				%
		rec = ActiveRecord::Base.connection.select_one(strsql)
		if rec
				strsql = %Q% update srctbls set  
								updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								qty_src = #{tbl[:qty_linkto_alloctbl].to_f + rec["qty_src"].to_f} 
								where id = #{rec["id"]}					
				%
				ActiveRecord::Base.connection.update(strsql) 
		else
				srctbls_seq = RorBlkctl.proc_get_nextval("srctbls_seq")
				sno_sym = ("sno_" + srctblname.chop).to_sym 
				cno_sym = ("cno_" + srctblname.chop).to_sym 
				strsql = %Q%insert into srctbls(id,
						srctblname,sno,cno,srctblid,
						tblname,tblid,qty_src,
						created_at,
						updated_at,
						update_ip,persons_id_upd,expiredate,remark)
					values(#{srctbls_seq},
						'#{srctblname}','#{tbl[sno_sym]}','#{tbl[cno_sym]}',#{srctblid}, 
						'#{tbl[:tblname]}',#{tbl[:id]},#{tbl[:qty_linkto_alloctbl]} , 
						to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						' ',0,'#{tbl[:expiredate]}','')
				%
				ActiveRecord::Base.connection.insert(strsql) 
		end
	end
	###下位の構成の引き当てられる数の変更	上位部品が引き当てられたので下位部品を開放しｆｒｅｅに戻す。
	def free_ordtbl_to_alloc_child sch,fields    ###日付変更の対応が未だ
		###alloctblsはfree_ordtbl_to_allocで更新済
		strsql = %Q%select t.*,o.packqty from trngantts t
							inner join opeitms o on t.itms_id = o.itms_id and t.processseq = o.processseq 
							where orgtblname = '#{sch["orgtblname"]}' and orgtblid = #{sch["orgtblid"]}
							and  paretblname = '#{sch["tblname"]}' and paretblid = #{sch["tblid"]}
							and o.priority = 999   ---opeitmsでpriority=999は必須
							---and (qty - qty_alloc ) > 0 
							for update
		%
		gfields = fields.dup ##gfields:fieldsの子供
		ActiveRecord::Base.connection.select_all(strsql).each do |child| ###下位構成の引き当てなおし
			gfields[:qty] = child["qty"].to_f 
			gfields[:qty_linkto_alloctbl] = child["qty_linkto_alloctbl"].to_f 
			qty_alloc_pare = fields[:qty_alloc] + fields[:qty_linkto_alloctbl]
			gfields[:qty_alloc] =  qty_alloc_pare * child["chilnum"].to_f / child["parenum"].to_f
			### 下位構成に変化がないときはskip
			next if gfields[:qty_alloc] == child["qty_alloc"].to_f 
			if child["qty"].to_f > gfields[:qty_alloc]
				gfields[:qty_alloc] 
			else
				gfields[:qty_alloc]  = child["qty"].to_f 
			end
			strsql = %Q&update trngantts set 
			  				updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
			  				qty_alloc = #{gfields[:qty_alloc]},
			  				remark = '756' where  id = #{child["id"]}&
			ActiveRecord::Base.connection.update(strsql)
			strsql = %Q& select a.id alloc_id,b.id trn_id,a.qty_linkto_alloctbl,a.qty_alloc,
								a.srctblname,a.srctblid,a.trngantts_id,
								(a.qty - a.qty_linkto_alloctbl - a.qty_alloc ) qty_alloc_bal, 
								case 
								when a.srctblname   like '%schs' then '1'
								when a.srctblname   like '%ords' then '2'
								when a.srctblname   like '%insts' then '3'
								when a.srctblname   like '%acts' then '4'
								else '5' end priority,
								case 
									when a.srctblname   like '%schs' then '1'
									else '2' end kubun,
								a.qty,a.qty_stk,b.orgtblname,b.tblname,b.orgtblid,b.tblid,b.qty_bal  from alloctbls  a 
										inner join trngantts b  on  a.trngantts_id = b.id
										where a.trngantts_id = #{child["id"]}
										and (a.qty - a.qty_linkto_alloctbl ) > 0
										order by kubun,priority,b.tblid,a.srctblname,a.srctblid
										&
			###他の親で手配済数	
			kubun = ""
			qty_alloc = 0 
			ActiveRecord::Base.connection.select_all(strsql).each do |over|		
				if kubun != over["kubun"]
					kubun = over["kubun"]
					if child["qty_bal"].to_f >= child["qty"].to_f - gfields[:qty_alloc] 
						qty_alloc = child["qty"].to_f
					else	
						qty_alloc = gfields[:qty_alloc] 
					end
				end
				old_qty = over["qty"].to_f  ###freeのords,insts,acts,lotstkhistsに引き当っている数
				old_qty_alloc = over["qty_alloc"].to_f  ###freeのords,insts,acts,lotstkhistsに引き当っている数
				old_qty_linkto_alloctbl = over["qty_linkto_alloctbl"].to_f  ###freeのords,insts,acts,lotstkhistsに引き当っている数
				strsql = %Q% select * from r_#{over["srctblname"]} where id = #{over["srctblid"]} %
				command_r = ActiveRecord::Base.connection.select_one(strsql)
				if qty_alloc - old_qty_alloc - old_qty_linkto_alloctbl > 0
					if  qty_alloc > old_qty_alloc
						if over["qty_alloc_bal"].to_f  <= qty_alloc - old_qty_alloc  ###qty_alloc_bal ordsにも親からの引き当てでもない。
							over["qty_alloc"] = over["qty_alloc_bal"].to_f ###今回の引き当った分
							qty_alloc = qty_alloc - old_qty_alloc - over["qty_alloc_bal"].to_f
						else
							over["qty_alloc"] = qty_alloc   - old_qty_alloc ###今回の引き当った分
							qty_alloc = 0
						end   ###over["qty_linkto_alloctbl"] 次の状態へ移動した数
					else
						over["qty_alloc"]  = qty_alloc - old_qty_alloc
						qty_alloc = 0
					end		
				else
					if qty_alloc >= old_qty_alloc 
						qty_alloc -= old_qty_alloc 
						next
					else
						over["qty_alloc"]  = qty_alloc 
						qty_alloc = 0
					end	
				end	
				alloc_fields ={:trngantts_id=>over["trngantts_id"],:srctblname=>over["srctblname"],:srctblid=>over["srctblid"],
										:qty_alloc=>over["qty_alloc"] ,
										:remark=>" 816 <--- " }
				gfields = add_update_alloctbls alloc_fields,command_r  ###不要になったschsにlinkしている数量の変更
				###フリーへの戻し
				if over["kubun"] == "2" ### xxxschsの時はfreeへの戻しはない。
					strsql = %Q%select a.trngantts_id from alloctbls a 
										inner join trngantts b on a.trngantts_id = b.id   
							where b.orgtblname = b.paretblname and b.paretblname = b.tblname
							and  b.orgtblid = b.paretblid and b.paretblid = b.tblid
							and  a.srctblname = '#{over["srctblname"]}' and a.srctblid = #{over["srctblid"]}
				  		%  ### free alloctblsは一件のみ
					free_trngantts_id = ActiveRecord::Base.connection.select_value(strsql)
					alloc_fields ={:trngantts_id=>free_trngantts_id,
										:srctblname=>over["srctblname"],:srctblid=>over["srctblid"],
										:qty_alloc=>0,:qty_bal=>0,:qty_stk=>0,
										:qty=>over["qty_alloc"].to_f ,:remark=>" 829<--- "
									}
					add_update_alloctbls alloc_fields,command_r  ###freeの数量変更
				end
			end	
			###親からの構成引継ぎなのでaslloctblsとのリンクはない。
			###本体の子の構成は親からの引き当ての継続　直接ordsには引きあたらない。
			##gfields[:qty_pare] = fields[:qty_pare]
			gfields[:qty_pare_alloc] = fields[:qty_alloc]
			free_ordtbl_to_alloc_child child,gfields   ###
		end
	end	

	###shpschs,shpords用
	def proc_create_shp req,email,pare_loca_id,parent,shelfnos_id_to 
		###shpschs shpordsの時   shpinstsはmkshpinstsで対応
		command_c = {}
		tblnamechop = "shp#{yield}"
		command_c[:sio_code] =  command_c[:sio_viewname] =  "r_#{tblnamechop}s"
		command_c[:sio_message_contents] = nil
		command_c[:sio_recordcount] = 1
		command_c[:sio_result_f] =   "0"  
		command_c[:sio_classname] = "#{tblnamechop}_add_"
		strsql = %Q% select pobject_code_sfd from  func_get_screenfield_grpname('#{email}','r_#{tblnamechop}s')
				%
		fields = ActiveRecord::Base.connection.select_values(strsql) 
		opeitm_id = {}
		strsql = %Q& select ord.* from r_#{req["tblname"]} ord	where ord.id = #{req["tblid"]}
			&
		ActiveRecord::Base.connection.select_one(strsql).each do |key,val|
				if key == "id" 
					command_c[key] = ""
					command_c["#{tblnamechop}_id"] = "" 
				else
					if fields.index(key)
						command_c[key] = val
					else
						if fields.index(key.sub("#{req["tblname"].chop}","#{tblnamechop}"))
							command_c[key.sub("#{req["tblname"].chop}","#{tblnamechop}")] = val
						else
							case key.to_s
							when "opeitm_itm_id"
								command_c["#{tblnamechop}_itm_id"] = val
							when "opeitm_processseq"
								command_c["#{tblnamechop}_processseq"] = val
							end
						end
					end
				end
		end
		command_c["#{tblnamechop}_isudate"] = Time.now 
		command_c["#{tblnamechop}_packno"] = ""  ###shpschs,shpordsの時は何もセットしない。
		command_c["#{tblnamechop}_lotno"] = "" 
		command_c["#{tblnamechop}_shelfno_id_fm"] = shelfnos_id_to
		command_c["#{tblnamechop}_loca_id_to"] = pare_loca_id
		command_c["#{tblnamechop}_depdate"] = parent["#{req["paretblname"].chop}_starttime"]
		command_c["#{tblnamechop}_gno"] = parent["#{req["paretblname"].chop}_sno"] 
		command_c["#{tblnamechop}_transport_id"] = 0 
		command_c["#{tblnamechop}_paretblname"] = req["paretblname"] 
		command_c["#{tblnamechop}_paretblid"] = req["paretblid"]
		if req["paretblname"] =~ /^pur/   ###tblname= 'feepayment'--->有償支給
			strsql =%Q&select * from pricemsts where tblname= 'feepayment' and expiredate >= current_date
								and itms_id = #{command_c["#{tblnamechop}_itm_id"]} 
								and processseq = #{command_c["#{tblnamechop}_processseq"]}
								and (locas_id = #{pare_loca_id} or locas_id = (select id from locas where code = 'dummy' ))
								order by expiredate limit 1
			& 
			rec = ActiveRecord::Base.connection.select_one(strsql)
			if rec
				###日付、数量による再設定
			else
				command_c["#{tblnamechop}_price"] = 0 	
				command_c["#{tblnamechop}_amt"] = 0 	
				command_c["#{tblnamechop}_tax"] = 0 	
				command_c["#{tblnamechop}_crr_id"] = 0 	
			end
		else
			command_c["#{tblnamechop}_price"] = 0 	
			command_c["#{tblnamechop}_amt"] = 0 	
			command_c["#{tblnamechop}_tax"] = 0 	
			command_c["#{tblnamechop}_crr_id"] = 0 	
		end	
		stkinout = {}
		opeitm = proc_get_opeitms_rec(command_c[tblnamechop+"_itm_id"],nil,command_c[tblnamechop+"_processseq"],nil)
		packqty = command_c["opeitm_packqty"] = opeitm["packqty"].to_f

		stkinout["expiredate"] = command_c[tblnamechop+"_expiredate"]
		stkinout["lotno"] =  ""   ###shpschs,shpordsの時は何もセットしない。
		stkinout["packno"] =  if packqty == 0 then "" else "packno" end
		stkinout["alloctbls_id"] = req["alloc_id"]
		stkinout["processseq"] = command_c[tblnamechop+"_processseq"]
		stkinout["itms_id"] = command_c[tblnamechop+"_itm_id"]
		stkinout["stktaking_proc"] = opeitm["stktaking_proc"]
		stkinout["prjnos_id"] = command_c[tblnamechop+"_prjno_id"]
		stkinout["inoutflg"] = "shp"
		stkinout["shelfnos_id_out"] = command_c[tblnamechop+"_shelfno_id_fm"] 
		stkinout["starttime"]  = command_c[tblnamechop+"_depdate"]
		stkinout["qty_stk"] = 0

		case tblnamechop 
		when /shpsch/
			stkinout["qty_sch"] = command_c["#{tblnamechop}_qty"]  
			stkinout["qty"] = 0 
		when /shpord/
			stkinout["qty"] = command_c["#{tblnamechop}_qty"]  
			stkinout["qty_sch"] = 0 
		end	
		proc_mk_outstks_rec stkinout,"add"

		strsql = %Q&select id from shelfnos where locas_id_shelfno = #{command_c["#{tblnamechop}_loca_id_to"]}
											and code = 'consume'
			&
		shelfnos_id_to = ActiveRecord::Base.connection.select_value(strsql)
		stkinout["shelfnos_id_in"] = (shelfnos_id_to||=0)
		proc_mk_instks_rec stkinout,"add"
		reqparams = RorBlkctl.proc_private_aud_rec  command_c,1,nil,nil,nil
	end

	def proc_reset_shp req,reqparams ###親がordsに変わった時　schsについていた子供の変更
		##
		##  alloctblsの変更で対応
		##
		# strsql = %Q&select t.tblname tblname,t.tblid tblid,t.orgtblname orgtblname,t.orgtblid orgtblid,
		# 				t.paretblname paretblname,t.paretblid paretblid,a.qty_linkto_alloctbl qty_linkto_alloctbl
		# 				from trngantts t 
		# 				inner join alloctbls a on a.trngantts_id = t.id
		# 				where a.srctblname = '#{req["paretblname"]}' and a.srctblid = #{req["paretblid"]}
		# 				and (t.orgtblname != t.paretblname or t.orgtblid != t.paretblid)  
		# &
		# ActiveRecord::Base.connection.select_all(strsql).each do |trn|
		# 	strsql = %Q&select * from r_shpschs s 
		# 					where shpsch_paretblname = '#{trn["tblname"]}' and shpsch_paretblid = #{trn["tblid"]}
		# 	&
		# 	ActiveRecord::Base.connection.select_all(strsql).each do |command_c|
		# 		strsql = %Q&select * from trngantts where orgtblname = '#{trn["orgtblname"]}' and orgtblid = #{trn["orgtblid"]}
		# 									and paretblname = '#{trn["tblname"]}' and paretblid = #{trn["tblid"]}
		# 									and itms_id = #{command_c["shpsch_itm_id"]} and processseq = #{command_c["shpsch_processseq"]}
		# 									and locas_id_pare = #{command_c["shpsch_loca_id_to"]}
		# 		&
		# 		rec = ActiveRecord::Base.connection.select_one(strsql)
		# 		new_qty = rec["qty"].to_f - rec["qty_alloc"].to_f - rec["qty_linkto_alloctbl"].to_f
		# 		command_c[:sio_code] =  command_c[:sio_viewname] =  "r_shpschs"
		# 		command_c[:sio_message_contents] = nil
		# 		command_c[:sio_recordcount] = 1
		# 		command_c[:sio_result_f] =   "0"  
		# 		command_c[:sio_classname] = "shpsch_update_"
		# 		command_c["shpsch_qty"] = new_qty
		# 		command_c["shpsch_amt"] = new_qty * command_c["shpsch_price"].to_f
		# 		###tax 未設定
		# 		reqparams = RorBlkctl.proc_private_aud_rec  command_c,1,nil,nil,nil
		# 	end
		# end
	end

	def proc_mkords email,reqparams,mkordparams  ###xxxschsからxxxordsを作成する。 trngantts:xxxschs= 1:1
		tbldata = reqparams["tbldata"]  ###tbldata -->テーブル項目　　viewではない。
		add_tbl = "" 
		strwhere = {"org"=>"","pare"=>"","trn"=>""} 
		tblxxx = ""
		["org","pare","trn"].each do |sel|  ###抽出条件のsql作成
			case sel
				when "org"
					next if tbldata["orgtblname"] == ""	or tbldata["orgtblname"].nil?
					tblxxx = tbldata["orgtblname"]		
					add_tbl << %Q% inner join  r_#{tblxxx}  org on  orgtblid = org.id  
					%
					strwhere[sel] << "orgtblname = '#{tblxxx}'     and"
				when "pare"
					next if tbldata["paretblname"] == "" or	tbldata["paretblname"].nil?	
					tblxxx = tbldata["paretblname"]
					add_tbl << %Q% inner join (select a.*,src.srctblid from r_#{tblxxx} a inner join srctbls src 
								on a.id = src.tblid 
								where srctblname = '#{tblxxx.gsub("ord","sch")}' and tblname = '#{tblxxx}' ) pare
								%
					strwhere[sel] << " gantt.paretblid = pare.srctblid      and"
				when "trn"   ###必須項目
					next if tbldata["tblname"] == "all"	  ###pur,prd両方抽出
					tblxxx = tbldata["tblname"].gsub("ord","sch")		
					add_tbl << %Q% inner join r_#{tblxxx}  trn on gantt.tblid = trn.id
					%
					strwhere[sel] << " gantt.tblname = '#{tblxxx}'      and"
				else
					next	
			end

			tbldata.each do |field_delm,val|
				if field_delm =~ /_#{sel}$/ and val != "" and !val.nil?
						field,delm = field_delm.split("_#{sel}")
						strsql = "select fieldcode_ftype from r_fieldcodes rf  where pobject_code_fld = '#{field}'"
						ftype = ActiveRecord::Base.connection.select_value(strsql)
						if field =~ /^opeitm|^itm|^loca|^shelf|^person/ and field =~ /_id/
							dummyskipsql = "select code from #{field.split("_")[0]} where id = #{val}"
							dummyskip = ActiveRecord::Base.connection.select_value(dummyskipsql)
							if dummyskip == "dummy"
								next
							else	
								strwhere[sel] << %Q% #{sel}.#{field}  = #{val}   and
								%
							end
						else
							if 	field =~ /^opeitm|^itm|^loca|^shelf|^person/ and field !~ /_id/
								case ftype
								when "date"   
									strwhere[sel] << %Q% #{sel}.#{tblxxx.chop}_#{field} <= to_date('#{val}','yyyy/mm/dd')   and
									%
								when "timestamp(6)"								
									strwhere[sel] << %Q% #{sel}.#{tblxxx.chop}_#{field} <= to_date('#{val}','yyyy/mm/dd hh24:mi:ss')   and
									%
								when "numeric"
									if field !~ /_id/ 	
										strwhere[sel] << %Q% #{sel}.#{tblxxx.chop}_#{field}  = #{val.gsub(",","")}   and
										%
									else  ### codeで入力された内容は _idに変換
									end	
								end	
							else
								case ftype
								when "date"   
									strwhere[sel] << %Q% #{sel}.#{tblxxx.chop}_#{field} <= to_date('#{val}','yyyy/mm/dd')   and
									%
								when "timestamp(6)"								
									strwhere[sel] << %Q% #{sel}.#{tblxxx.chop}_#{field} <= to_date('#{val}','yyyy/mm/dd hh24:mi:ss')   and
									%
								when "numeric"
									if field !~ /_id/ 	
										strwhere[sel] << %Q% #{sel}.#{tblxxx.chop}_#{field}  = #{val.gsub(",","")}   and
										%
									else  ### codeで入力された内容は _idに変換
									end
								end		
							end	
						end   ### case-
				end	  ### case
			end  ###fields.each
		end   ### ["_org","_pare","_trn"].each do |tbl|
		base_strsql = %Q&
			select (gantt.tblname) tblname,(gantt.tblid) tblid, 
					(gantt.orgtblname) orgtblname,(gantt.orgtblid) orgtblid,
					gantt.itms_id_pare,gantt.processseq_pare,
					gantt.itms_id,gantt.processseq,gantt.locas_id,gantt.shelfnos_id_fm,
					(gantt.parenum) parenum,(gantt.chilnum) chilnum,
					(gantt.qty_pare - gantt.qty_pare_alloc - gantt.qty_pare_bal ) qty_pare, 
					case
					when (a.qty - a.qty_alloc) >= (a.qty - a.qty_linkto_alloctbl  )
						then (a.qty - a.qty_alloc )
						else  (a.qty - a.qty_linkto_alloctbl   )
					end qty		, 
					case
					when (a.qty - a.qty_alloc) >= (a.qty - a.qty_linkto_alloctbl  )
						then (a.qty - a.qty_alloc)
						else  (a.qty - a.qty_linkto_alloctbl  )
					end max_qty		, 
					gantt.qty_bal,
					to_char(gantt.duedate,'yyyy/mm/dd') duedate,
					gantt.prjnos_id,opeitm.shelfnos_id shelfnos_id_to,
					gantt.id trngantts_id,gantt.expiredate
				from trngantts gantt #{if add_tbl.size > 1 then add_tbl.chop else "" end } 
					inner join opeitms opeitm on opeitm.itms_id = gantt.itms_id and opeitm.processseq = gantt.processseq
					inner join alloctbls a on a.trngantts_id = gantt.id
				where #{strwhere["org"]}  #{strwhere["pare"]}  #{strwhere["trn"]}
					(a.qty - a.qty_alloc ) > 0
					and (a.qty - a.qty_linkto_alloctbl ) > 0
					and tblname like '%schs'
					and not exists(select 1 from mkordopeitms mk 
									where mk.itms_id = gantt.itms_id  and mk.processseq = gantt.processseq 
									and mk.locas_id = gantt.locas_id  and mk.prjnos_id = gantt.prjnos_id 
									and mk.shelfnos_id_to = opeitm.shelfnos_id 
									and mk.mkords_id = #{reqparams["mkords_id"]}) 
					and opeitm.priority = 999
				&
			
		item_sel_order_by = " order by 	duedate  for update  of gantt limit 1  ---  group byではupdateが使用できない。"	

		save_rec={}	
		save_rec["itms_id"] = "-1"
		save_rec["tblid"] = "-1"
		aqty = 0	###累計数
		qty_bal = 0
		max_qty = 0
		command_c = {}

		sch = {}
		while !sch.nil? do
			sch = ActiveRecord::Base.connection.select_one(base_strsql+item_sel_order_by)
			if sch   ###納期の一番古い品目を選択
				tblord = sch["tblname"].chop.gsub("sch","ord")
				duedate = tblord + "_duedate"
				symqty = tblord + "_qty"
				###納期にかかわらず同一品目を納期順に並べる
				str_order_by = "and gantt.itms_id = #{sch["itms_id"]} and gantt.processseq = #{sch["processseq"]} 
								order by  gantt.locas_id,gantt.itms_id,gantt.processseq,shelfnos_id_to, 
								gantt.itms_id_pare,gantt.processseq_pare,
								duedate for update  of gantt  ---  group byではupdateが使用できない。"	
				ActiveRecord::Base.connection.select_all(base_strsql+str_order_by).each do |rec,index|
					mkordparams[:incnt] += 1
					mkordparams[:inqty] +=  rec["max_qty"].to_f
					schofmkords  reqparams["mkords_id"],rec ###xxxordsのalloctblを作成のためxxxschsのtrngantts_idをsave
					if rec["itms_id"] == (save_rec["itms_id"]) and
						rec["processseq"] == (save_rec["processseq"]||="0") and 
						rec["itms_id_pare"] == (save_rec["itms_id_pare"]||="0") and
						rec["processseq_pare"] == (save_rec["processseq_pare"]||="0") and 
						rec["locas_id"] == (save_rec["locas_id"]||="0") and
						rec["prjnos_id"] == (save_rec["prjnos_id"]||="0")  and
						rec["shelfnos_id_to"] == (save_rec["shelfnos_id_to"]||="0") 
						###期間まとめ期間の確認
						###command_c は###get schsで求めている。
						if save_rec["tblid"] == rec["tblid"]
							qty_bal += rec["qty_bal"].to_f
						else
							qty_bal = rec["qty_bal"].to_f
							save_rec["tblid"] = rec["tblid"]
						end	
						if rec["duedate"].to_date <= (command_c[duedate].to_date  + command_c["opeitm_opt_fixoterm"].to_i) or
								command_c["opeitm_opt_fixoterm"].to_i  == 0   ###opeitm_opt_fixoterm=0まとめなし
							aqty +=   rec["max_qty"].to_f - qty_bal ###
							max_qty += rec["max_qty"].to_f - qty_bal 
							### 発注単位　作業分割未実施	
						else
							### parenum chilnum	
							### pare_opeitm  ###get opeitmで求めている。
							if command_c["opeitm_packqty"].to_f > 0 
								aqty = (aqty / 
									command_c["opeitm_packqty"].to_f).ceil * command_c["opeitm_packqty"].to_f
							end	
							if aqty >  max_qty	
								max_qty = aqty
							end
							command_c[symqty] = max_qty		
							aqty = aqty - max_qty   ###過剰分の繰り越し
							RorBlkctl.proc_private_aud_rec  command_c,1,nil,nil,nil
							mkordparams[:outcnt] += 1
							mkordparams[:outqty] +=  command_c[symqty]
							command_c[duedate] = rec["duedate"]
							max_qty = 0
							qty_bal = 0
							aqty +=   rec["max_qty"].to_f - qty_bal ###
							max_qty += rec["max_qty"].to_f - qty_bal 
						end		
					else
						### parenum chilnum	
						if max_qty > 0 ###最初のレコードは除く	 save_recは使用できない。save_rec["itms_id"] = "-1"
							if command_c["opeitm_packqty"].to_f > 0 
								aqty = (aqty  / 
										command_c["opeitm_packqty"].to_f).ceil * command_c["opeitm_packqty"].to_f
							end		
							command_c[symqty] = aqty
							mkordparams[:outcnt] += 1
							mkordparams[:outqty] +=  command_c[symqty]
							RorBlkctl.proc_private_aud_rec   command_c,1,nil,nil,reqparams
						end
						qty_bal = rec["qty_bal"].to_f
						save_rec["tblid"] = rec["tblid"]
						strsql = %Q%select * from r_#{rec["tblname"].gsub("ord","sch")} where id = #{rec["tblid"]}
							%
						command_r = ActiveRecord::Base.connection.select_one(strsql)  ###get schs
						command_c = command_r.dup
						command_r.each do |key,val|
							next if key =~ /sch_qty_bal$/  ###ordsにはqty_balはない screenfields未使用
							if key =~ /_sno$|_cno$/  ###sno,cnoはschから引き継がない。
								command_c[key.gsub("sch","ord")] = ""
							else	 
								command_c[key.gsub("sch","ord")] = command_r[key]
							end
						end	
					end	
					command_c["#{tblord}_id"] = command_c["id"] = ""
					command_c[:sio_code] =  "r_#{tblord}s"
					command_c[:sio_viewname] =  "r_#{tblord}s"
					command_c[:sio_message_contents] = nil
					command_c[:sio_recordcount] = 1
					command_c[:sio_result_f] =   "0"  
					command_c[:sio_classname] = "_add_ord_by_mkord"
					save_rec = rec.dup   ###get opeitm
					max_qty = rec["max_qty"].to_f
					aqty =   rec["max_qty"].to_f   ###qty qty_bal考慮済
					mk_mkordopeitms reqparams["mkords_id"],save_rec
				end
			else
				sch = nil	
			end	 
		end
			### parenum chilnum	
			###最後のレコードの処理
		if  max_qty > 0
			if command_c["opeitm_packqty"].to_f > 0 
					aqty = (aqty   / 
							command_c["opeitm_packqty"].to_f).ceil * command_c["opeitm_packqty"].to_f
			end	
			if aqty >  max_qty	
					max_qty = aqty
			end		
			command_c[symqty] = max_qty	
			RorBlkctl.proc_private_aud_rec   command_c,1,nil,nil,reqparams
			mkordparams[:outcnt] += 1
			mkordparams[:outqty] +=  command_c["symqty"].to_f	
		end
		return mkordparams
	end	

	def schofmkords mkords_id,rec
		id = RorBlkctl.proc_get_nextval("schofmkords_seq")
		strsql = %Q&
			insert into schofmkords(id,itms_id,processseq,
								mkords_id,trngantts_id,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{id},#{rec["itms_id"]},#{rec["processseq"]},
								#{mkords_id},#{rec["trngantts_id"]},
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','#{@sio_user_code||=0}','#{rec["expiredate"]}','')
		&
		ActiveRecord::Base.connection.insert(strsql) 
	end

	def proc_amtinouts(tblname,tblid,command_r,trngantts_id)	###未完成
		###  amt
		###  out
		amtinout = {}
		amtinout["starttime"]  = get_starttime(tblname,command_r)
		case tblname
		when /^pur/
			###purschs-->opeitm_loca_id    amtはlocas_id
			amtinout["locas_id_out"] = command_r["payment_loca_id_payment"]
			amtinout["locas_id_in"] = command_r["supplier_loca_id_supplier"]
			amtinout["crrs_id"] = command_r[tblname.chop+"_crr_id_pur"]
		when /^insp/
			###purschs-->opeitm_loca_id 
			amtinout["locas_id_out"] = command_r["payment_loca_id_payment"]
			amtinout["locas_id_in"] = command_r["supplier_loca_id_supplier"]
			amtinout["crrs_id"] = command_r[tblname.chop+"_crr_id_insp"]
		when /^prd/   
			amtinout["locas_id_out"] = command_r["opeitm_loca_id"] 
			amtinout["locas_id_in"] = command_r[tblname.chop+"_loca_id_to"]
		when /^shp/
			amtinout["locas_id_out"] = command_r["trngantt_loca_id_fm_shp"] 
		when /^pay/
			amtinout["locas_id_out"] = command_r["payact_loca_id_payment"]
		when /^bill/
			amtinout["locas_id_in"] = command_r["billact_loca_id_payment"]
		end
		amtinout["trngantts_id"] = trngantts_id
		amtinout["amt"] = command_r[tblname.chop+"_amt"]
		mk_outamts_rec amtinout
		###  amt
		###  in
		case tblname
		when /^bill|^pay/
		when /^prd/
		when /^shp/
		end
		mk_inamts_rec amtinout
	end

	def lotno_set tblname,stkinout,command_r  ###新規の時のみ
		if command_r["opeitm_packqty"].to_f > 0
			if tblname =~ /^prd|^insp|^pur/
				if command_r["#{tblname.chop}_lotno"] == ""  or  command_r["#{tblname.chop}_lotno"] == "dummy" 
						stkinout["lotno"] = command_r["#{tblname.chop}_lotno"] = command_r["#{tblname.chop}_sno"]
				else
						stkinout["lotno"] = command_r["#{tblname.chop}_lotno"] 
				end
			else	
				if command_r["#{tblname.chop}_lotno"] == ""   
					stkinout["lotno"] = command_r["#{tblname.chop}_lotno"] = "dummy"
				else
					stkinout["lotno"] = command_r["#{tblname.chop}_lotno"] 
				end
			end
			stkinout["packno"] = command_r["#{tblname.chop}_packno"] = "packno"
		else	
			if command_r["#{tblname.chop}_lotno"] == ""   
				stkinout["lotno"] = command_r["#{tblname.chop}_lotno"] = ""
			else
				stkinout["lotno"] = command_r["#{tblname.chop}_lotno"] 
			end
			stkinout["packno"] = command_r["#{tblname.chop}_packno"] = ""
		end
		return stkinout
	end

	def proc_mk_outstks_rec stkinout,au ###opeitm_stktaking_proc,opeitm_packqty
		idx = 1
		qty_stk = stkinout["qty_stk"].to_f
		if au == "add"
				outstks_id = RorBlkctl.proc_get_nextval("outstks_seq")
				ActiveRecord::Base.connection.insert(outstk_strsql(stkinout,outstks_id)) 
				lotstkhists_in_out "out", stkinout   ###,old_alloc,""
		else
			strsql = %Q&select out.id,out.packno,out.starttime,out.expiredate,out.shelfnos_id_out
									from outstks out
									inner join alloctbls alloc on alloc.id = out.alloctbls_id 
									where alloctbls_id = #{stkinout["alloctbls_id"]} and
										lotno = '#{stkinout["lotno"]}' and
										packno = '#{stkinout["packno"]}'
										---and inoutflg in('pur','prd','con')
										order by lotno,packno
										for update
			&	
			ActiveRecord::Base.connection.select_all(strsql).each do |rec|
				update_sql = %Q%
					update outstks set 
						starttime = '#{rec["starttime"]}',
						qty = #{stkinout["qty"]},
						qty_sch = #{stkinout["qty_sch"]},
						updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						expiredate = '#{rec["expiredate"]}'
					%
				###update_sql << " ,qty_stk = #{qty_stk.to_f},packno = '#{rec["packno"]}' where id = #{rec["id"]}"
				update_sql << " ,qty_stk = #{qty_stk.to_f} where id = #{rec["id"]}"
				ActiveRecord::Base.connection.update(update_sql) 
				stkinout["packno"] = rec["packno"]
				stkinout["shelnos_id_out"] = rec["shelfnos_id_out"]
				stkinout["qty_sch"] = stkinout["qty_sch"].to_f - rec["qty_sch"].to_f
				stkinout["qty"] = stkinout["qty"].to_f - rec["qty"].to_f
				stkinout["qty_stk"] = stkinout["qty_stk"].to_f - rec["qty_stk"].to_f
				lotstkhists_in_out "out", stkinout   ###,old_alloc,""
			end	
		end
		return
	end

	def outstk_strsql stkinout,outstks_id
		strsql = %Q&
				insert into outstks(id,alloctbls_id,shelfnos_id_out,
								starttime,
								qty,qty_stk,qty_sch,
								lotno,packno,inoutflg,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{outstks_id},#{stkinout["alloctbls_id"]},#{stkinout["shelfnos_id_out"]},
								'#{stkinout["starttime"]}',
								#{stkinout["qty"]},#{stkinout["qty_stk"]},#{stkinout["qty_sch"]},
								'#{stkinout["lotno"]}','#{stkinout["packno"]}','#{stkinout["inoutflg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','#{@sio_user_code||=0}','#{stkinout["expiredate"]}','')
		&
	end 	

	def proc_mk_instks_rec stkinout,au
		if au == "add"
				instks_id = RorBlkctl.proc_get_nextval("instks_seq")
				strsql = %Q&
					insert into instks(id,alloctbls_id,shelfnos_id_in,
								starttime,
								qty,qty_stk,qty_sch,
								lotno,packno,inoutflg,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{instks_id},#{stkinout["alloctbls_id"]},#{stkinout["shelfnos_id_in"]},
								'#{stkinout["starttime"]}',
								#{stkinout["qty"]},#{stkinout["qty_stk"]},#{stkinout["qty_sch"]},
								'#{stkinout["lotno"]}','#{stkinout["packno"]}','#{stkinout["inoutflg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','#{@sio_user_code||=0}','#{stkinout["expiredate"]}','')
					&
				ActiveRecord::Base.connection.insert(strsql) 
				###old_alloc = {"qty_sch"=>0,"qty"=>0,"qty_stk"=>0,"srctblname"=>""} ### "srctblname"=>"":旧データなし又はsch,ords等で対応済
				lotstkhists_in_out "in", stkinout   ###,old_alloc,""  ###新規登録のためテーブル情報は不要
		else	
			strsql = %Q%select * from instks where alloctbls_id = #{stkinout["alloctbls_id"]} 
										and lotno = '#{stkinout["lotno"]}' and packno = '#{stkinout["packno"]}' 
										order by lotno,packno
										for update
				%	
			ActiveRecord::Base.connection.select_all(strsql).each do |rec|
					update_sql = %Q%
						update instks set 
							starttime = '#{stkinout["starttime"]}',
							qty = #{stkinout["qty"].to_f },
							qty_sch = #{stkinout["qty_sch"]},
							qty_stk = #{stkinout["qty_stk"]},
							updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss')
							where id = #{rec["id"]} 
					%
					ActiveRecord::Base.connection.update(update_sql) 
					stkinout["packno"] = rec["packno"]
					stkinout["shelnos_id_in"] = rec["shelfnos_id_in"]
					stkinout["qty_sch"] = stkinout["qty_sch"].to_f - rec["qty_sch"].to_f
					stkinout["qty"] = stkinout["qty"].to_f - rec["qty"].to_f
					stkinout["qty_stk"] = stkinout["qty_stk"].to_f - rec["qty_stk"].to_f
					lotstkhists_in_out "in", stkinout   ###,old_alloc,""  ###新規登録のためテーブル情報は不要
			end	
		end
		return
	end

	def mk_custwhs_rec stkinout,au  ###lotstkhistsは棚のみ
		if au == "add"
				instks_id = RorBlkctl.proc_get_nextval("custwhs_seq")
				strsql = %Q&insert into custwhs(id,alloctbls_id,custrcvplcs_id,
								duedate,
								qty,qty_stk,
								lotno,packno,inoutflg,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{instks_id},#{stkinout["alloctbls_id"]},#{stkinout["custrcvplcs_id"]},
								'#{stkinout["duedate"]}',
								#{stkinout["qty"]},
								#{stkinout["qty_stk"]},
								'#{stkinout["lotno"]}','#{stkinout["packno"]}','#{stkinout["inoutflg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','#{@sio_user_code||=0}','#{stkinout["expiredate"]}','')
				&
				ActiveRecord::Base.connection.insert(strsql)
		else
			strsql = %Q%select * from custwhs where alloctbls_id = #{stkinout["alloctbls_id"]} 
										and packno = '#{stkinout["packno"]}'
										and lotno = '#{stkinout["lotno"]}',
										order by lotno,packno
										for update
			%
			ActiveRecord::Base.connection.select_all(strsql).each do |rec|	
				update_sql = %Q% update custwhs set 
									shelfnos_id_in = #{stkinout["shelfnos_id_in"]},
									starttime = '#{stkinout["starttime"]}',
									qty = #{stkinout["qty"]},qty_sch = #{stkinout["qty_sch"]},
									inoutflg = '#{stkinout["inoutflg"]}',
									updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
									expiredate = '#{stkinout["expiredate"]}',
									qty_stk = #{stkinout["qty_stk"]}
				%
				ActiveRecord::Base.connection.update(update_sql) 
			end	
		end
	end

	def mk_outamts_rec amtinout
		outamts_id = RorBlkctl.proc_get_nextval("outamts_seq")
		strsql = %Q&
					insert into outamts(id,alloctbls_id,locas_id_out,crrs_id,
								starttime,
								amt,
								inoutflg,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{outamts_id},#{amtinout["alloctbls_id"]},#{amtinout["locas_id_out"]},#{amtinout["crrs_id"]},
								'#{amtinout["starttime"]}',
								#{amtinout["amt"]},
								'#{amtinout["inoutflg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','#{@sio_user_code||=0}','2099/12/31','')
		&
		ActiveRecord::Base.connection.insert(strsql) 
	end

	def mk_inamts_rec amtinout
		inamts_id = RorBlkctl.proc_get_nextval("inamts_seq")
		strsql = %Q&
					insert into inatms(id,alloctbls_id,locas_id_in,crrs_id,
								starttime,
								amt,
								inoutflg,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{inamts_id},#{amtinout["alloctbls_id"]},#{amtinout["locas_id_in"]},#{amtinout["crrs_id"]},
								'#{amtinout["starttime"]}',
								#{amtinout["amt"]},
								'#{amtinout["inoutflg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ',#{@sio_user_code||=0},'2099/12/31','')
		&
		ActiveRecord::Base.connection.insert(strsql) 
	end

	###出庫の前の完成　完成時の員数可変による消費数対応ができてない。"create_other_table_record_job.consume_exception"
	def lotstkhists_in_out kubun,stkinout   ###,old_alloc,srctblname
		if kubun == "out" 
			stk_shelfnos_id = stkinout["shelfnos_id_out"]
			inout = -1
		else
			stk_shelfnos_id =  stkinout["shelfnos_id_in"] 
			inout = 1
		end	
	
		strsql = %Q% select qty_sch ,qty, qty_stk,id
								from lotstkhists
								where   itms_id = #{stkinout["itms_id"]} and  shelfnos_id = #{stk_shelfnos_id} and
										processseq = #{stkinout["processseq"]} and
										prjnos_id = #{stkinout["prjnos_id"]} and
										starttime <= to_date('#{stkinout["starttime"]}','yyyy-mm-dd hh24:mi:ss') and 
										packno = '#{stkinout["packno"]}' and  lotno = '#{stkinout["lotno"]}'
										order by starttime desc for update limit 1
				%
		pre_lot = ActiveRecord::Base.connection.select_one(strsql)
		if pre_lot.nil?
				pre_lot = {"qty_sch"=>0,"qty"=>0,"qty_stk"=>0} 
		end
		pre_lot["qty_sch"] = pre_lot["qty_sch"].to_f + stkinout["qty_sch"].to_f * inout
		pre_lot["qty"] = pre_lot["qty"].to_f + stkinout["qty"].to_f * inout
		pre_lot["qty_stk"] = pre_lot["qty_stk"].to_f + stkinout["qty_stk"].to_f * inout
		lotstkhists_seq = RorBlkctl.proc_get_nextval("lotstkhists_seq")
		strsql = %Q&insert into lotstkhists(id,
									itms_id,shelfnos_id,
									prjnos_id,
									starttime,processseq,
									lotno,packno,
									qty_sch,
									qty_stk,
									qty,
									stktaking_proc,
									created_at,
									updated_at,
									update_ip,persons_id_upd,expiredate,remark)
							values(#{lotstkhists_seq},
									#{stkinout["itms_id"]},#{stk_shelfnos_id},
									#{stkinout["prjnos_id"]},
									'#{stkinout["starttime"]}',#{stkinout["processseq"]},
									'#{stkinout["lotno"]}','#{stkinout["packno"]}',
									#{pre_lot["qty_sch"].to_f},
									#{pre_lot["qty_stk"].to_f},
									#{pre_lot["qty"].to_f},
									'#{stkinout["stktaking_proc"]}',
									to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
									to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
									' ',#{@sio_user_code||=0},'#{stkinout["expiredate"]}','')
									ON CONFLICT on CONSTRAINT lotstkhists_uky10 DO UPDATE SET
												qty_stk = #{pre_lot["qty_stk"].to_f} ,
												qty = #{pre_lot["qty"].to_f},
												qty_sch = #{pre_lot["qty_sch"].to_f} 
			&
		ActiveRecord::Base.connection.insert(strsql) 
		strsql = %Q% select * from lotstkhists
						where itms_id = #{stkinout["itms_id"]} and   shelfnos_id = #{stk_shelfnos_id} and
								lotno = '#{stkinout["lotno"]}' and 
								processseq = #{stkinout["processseq"]} and
								packno = '#{stkinout["packno"]}' and
								prjnos_id = #{stkinout["prjnos_id"]}  and
								starttime > to_date( '#{stkinout["starttime"]}','yyyy/mm/dd hh24:mi:ss')
								for update
		%  ###該当日以降の在庫修正
		ActiveRecord::Base.connection.select_all(strsql).each do |futrec|
			strsql = %Q& update lotstkhists set  
									updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
									persons_id_upd = #{@sio_user_code||=0},
									qty_stk = #{stkinout["qty_stk"].to_f * inout + futrec["qty_stk"].to_f},
									qty = #{stkinout["qty"].to_f * inout + futrec["qty"].to_f},
									qty_sch = #{stkinout["qty_sch"].to_f * inout + futrec["qty_sch"].to_f} 
									where id = #{futrec["id"]}					
			&
			ActiveRecord::Base.connection.update(strsql) 
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
			when "custs"	
				case totbl
					when "custrcvplcs"
						command_c["custrcvplc_cust_id"] = command_c["id"]  
						command_c["custrcvplc_code"] = "000"  
						command_c["custrcvplc_name"] = "same as customer"  
						command_c["id"] = nil
						command_c = update_table command_c,totbl do
							"_add_proc_createtable_data"
						end
				end
			when /suppliers/
						command_c["shelno_loca_id_shelfno"] = command_c["id"]  
						command_c["shelfno_code"] = command_c["loca_code_supplier"]
						command_c["shelfno_name"] = "same as loca name"  
						command_c["id"] = nil
						command_c = update_table command_c,totbl do
							"_add_proc_createtable_data"
						end
						command_c["shelno_loca_id_shelfno"] = command_c["id"]  
						command_c["shelfno_code"] = "consume"
						command_c["shelfno_name"] = "consume"  
						command_c["shelfno_content"] = "必須データ 親部品完成時の子部品消費"
						command_c["id"] = nil
						command_c = update_table command_c,totbl do
							"_add_proc_createtable_data"
						end
			when /workplaces/
						command_c["shelfno_loca_id_shelfno"] = command_c["id"]  
						command_c["shelfno_code"] =  command_c["loca_code_workplace"]
						command_c["shelfno_name"] = "same as loca name"  
						command_c["shelfno_content"] = "作業用"
						command_c["id"] = nil
						command_c = update_table command_c,totbl do
							"_add_proc_createtable_data"
						end
						command_c["shelfno_loca_id_shelfno"] = command_c["id"]  
						command_c["shelfno_code"] =  "consume"
						command_c["shelfno_name"] = "consume"  
						command_c["shelfno_content"] = "必須データ 親部品完成時の子部品消費"
						command_c["id"] = nil
						command_c = update_table command_c,totbl do
							"_add_proc_createtable_data"
						end
		end
	end	

	def proc_shpact_stk_move rec,paretblname,parent
	end	

	def proc_consume_self_sch_parts rec,paretblname,parent   ###tblname like %schs
		strsql = %Q%select instk.qty,instk.qty_stk,instk.qty_sch,instk.packno,instk.alloctbls_id alloc_id,
					trn.itms_id,trn.processseq,trn.prjnos_id,trn.expiredate,trn.qty_bal trn_qty_bal,
					instk.shelfnos_id_in,alloc.srctblname,
					shelf.locas_id_shelfno shelf_loca_id
					from instks instk 
					inner join(alloctbls alloc inner join trngantts trn on trn.id =  alloc.trngantts_id)
						on alloc.id = instk.alloctbls_id 
					inner join shelfnos shelf on shelf.id =   shelfnos_id_in
					where  alloc.trngantts_id = #{rec["id"]} 
					and instk.qty_sch > 0
					and alloc.srctblname = '#{rec["tblname"]}' and alloc.srctblid = #{rec["tblid"]}
		%
		ActiveRecord::Base.connection.select_all(strsql).each do |stkinout|
			stkinout["inoutflg"] = "con"
			stkinout["alloctbls_id"] = stkinout["alloc_id"]
			case paretblname ###消費場所
			when /^prd/
				if parent["workplace_loca_id_workplace"] == stkinout["shelf_loca_id"]
					stkinout["shelfnos_id_out"] = stkinout["shelfnos_id_in"]  ### 子部品を直接親のlocasに納入した時
				else	
					strsql = %Q%select id from shelfnos where code = 'consume' 
														and locas_id_shelfno = #{parent["workplace_loca_id_workplace"]}
					%
					stkinout["shelfnos_id_out"] = ActiveRecord::Base.connection.select_value(strsql)
					stkinout["shelfnos_id_out"] ||= 0 
				end
			when /^pur/
				if parent["supplier_loca_id_supplier"] == stkinout["shelf_loca_id"]
					stkinout["shelfnos_id_out"] = stkinout["shelfnos_id_in"]  ### 子部品を直接親のlocasに納入した時
				else	
					strsql = %Q%select id from shelfnos where code = 'consume' 
														and locas_id_shelfno = #{parent["supplier_loca_id_supplier"]}
					%
					stkinout["shelfnos_id_out"] = ActiveRecord::Base.connection.select_value(strsql)
					stkinout["shelfnos_id_out"] ||= 0 
				end
			else
				stkinout["shelfnos_id_out"] = 0
			end
			
			stkinout["starttime"] = parent[paretblname.chop+"_duedate"]
			
			stkinout["qty_sch"] = stkinout["qty_sch"].to_f - stkinout["trn_qty_bal"].to_f
			stkinout["qty"] = 0
			stkinout["qty_stk"] = 0
			proc_mk_outstks_rec stkinout,"add"
		end
	end

	def proc_consume_self_ord_parts stkinout ###親がacts,schs以外の時
		###親を求める。
		strsql = %Q%select s.id shelfno_id,ord.duedate from #{stkinout["paretblname"]} ord
					#{case stkinout["paretblname"] 
						when /^prd/
							"inner join (r_workplaces w 
										inner join shelfnos s on w.workplace_loca_id_workplace = s.locas_id_shelfno 
													--- and w.loca_code_workplace = 'consume'
												)
									on workplaces_id = w.id	
										"
						when /^pur/
							"inner join (r_suppliers w 
										inner join shelfnos s on w.supplier_loca_id_supplier = s.locas_id_shelfno 
													--- and w.loca_code_supplier = 'consume'
												)
									on suppliers_id = w.id	
										"
						else
						end}
					where ord.id = #{stkinout["paretblid"]}
			%	
		parent = ActiveRecord::Base.connection.select_one(strsql)
		stkinout["shelfnos_id_out"] = (parent["shelfno_id"]||=0)
		stkinout["inoutflg"] = "con"
		###消費時期
		stkinout["starttime"] = parent["duedate"]
		stkinout["qty"] = stkinout["qty"].to_f  + stkinout["qty_stk"].to_f
		stkinout["qty_sch"] = 0
		stkinout["qty_stk"] = 0
		proc_mk_outstks_rec stkinout,"add"
	end

	def update_table command_c,totbl
		command_c[:sio_code] = command_c[:sio_viewname] =  "r_" + totbl
		command_c[:sio_message_contents] = nil
		command_c[:sio_recordcount] = 1
		command_c[:sio_result_f] =   "0"  
		command_c[:sio_classname] = yield
		command_c = RorBlkctl.proc_update_table command_c,1
		return command_c
	end

	def get_starttime tblname,command_r  ###
		case tblname
		when /purschs|purords|prdschs|prdords/
			starttime  = command_r[tblname.chop+"_duedate"]
		when /purinsts/
			starttime  = command_r["purinst_replydate"]
		when /puracts/
			starttime  = command_r["puract_rcptdate"]
		when /purdlvs/
			starttime  =  (Date.strptime(command_r["purdlv_depdate"].gsub("/","-"),'%Y-%m-%d')  + 1).to_s
		when /prdinsts/
			starttime  = command_r["prdact_commencementdate"]
		when /prdacts/
			starttime  = command_r["prdact_cmpldate"]
		when /^shp/
			starttime  = command_r[tblname.chop+"_depdate"]	
		when /custschs|custords|custinst/
			starttime  = (Date.strptime(command_r[tblname.chop+"_duedate"].gsub("/","-"),'%Y-%m-%d') - 1).to_s
		when /custdlvs/
			starttime  = command_r[tblname.chop+"_depdate"]
		when /custacts/
			starttime  = (Date.strptime(command_r["custact_saledate"].gsub("/","-"),'%Y-%m-%d') - 1).to_s
		end
		return starttime	
	end

	def prev_trngantts_update tblname,tblid,tbldata
		sql_alloc_src = %Q%
			select * from  alloctbls a
						inner join srctbls b on a.srctblname = b.srctblname and a.srctblid = b.srctblid 
						where b.tblname = '#{tblname}' and b.tblid  = #{tblid}
				%

		if tbldata["qty_stk"]
			link_qty = tbldata["qty_stk"].to_f  ###prd,purではqty又はqty_stkどちらかの項目のみ
		else
			link_qty = tbldata["qty"].to_f
		end
		fields = {:qty_alloc=>0,:qty_bal=>0}
		new_fields = {:qty_alloc=>0,:qty_bal=>0}
		sql_new = "select * from r_#{tblname} where id = #{tblid} "
		command_new = ActiveRecord::Base.connection.select_one(sql_new)
		
		new_starttime = get_starttime tblname,command_new
		command_c = nil
		ActiveRecord::Base.connection.select_all(sql_alloc_src).each do |alloc|
			if command_c.nil?	
				new_fields = {:srctblname=>tblname,:srctblid=>tblid,:starttime=>new_starttime,
					:remark=>" 1822 "}			
				sql_c = "select * from r_#{alloc["srctblname"]} where id = #{alloc["srctblid"]} "
				command_c = ActiveRecord::Base.connection.select_one(sql_c)
			end
			if alloc["qty_linkto_alloctbl"].to_f >= alloc["qty"].to_f
				next
			else
				fields = {:srctblname => alloc["srctblname"],:srctblid => alloc["srctblid"],
						:trngantts_id => alloc["trngantts_id"],:remark => " 1830 "}
				new_fields[:trngantts_id] = alloc["trngantts_id"]
				if link_qty >= alloc["qty"].to_f -  alloc["qty_linkto_alloctbl"].to_f 
					new_fields[:qty] = alloc["qty"].to_f -  alloc["qty_linkto_alloctbl"].to_f
					fields[:qty_linkto_alloctbl] = alloc["qty"].to_f 
					link_qty = link_qty - (alloc["qty"].to_f -  alloc["qty_linkto_alloctbl"].to_f) 
				else
					new_fields[:qty] = link_qty
					fields[:qty_linkto_alloctbl] =  link_qty
					link_qty = 0
				end
			end
			if tbldata["qty_stk"]
				new_fields[:qty_stk] =  new_fields[:qty]
				fields[:qty_stk] =  fields[:qty_linkto_alloctbl] 
			else
				new_fields[:qty_stk] =  0
			end	
			add_update_alloctbls fields,command_c
			add_update_alloctbls new_fields,command_new
		end	  
		new_fields[:qty] = link_qty
		sql_trn_id = %Q%
			select id from trngantts 
						where tblname = '#{tblname}' and tblid  = #{tblid}
						and orgtblname = paretblname and paretblname = tblname
						and orgtblid = paretblid and paretblid = tblid
				%
		trngantts_id = ActiveRecord::Base.connection.select_value(sql_trn_id)
		new_fields[:trngantts_id] =  trngantts_id
		if tbldata["qty_stk"]
			new_fields[:qty_stk] =  new_fields[:qty]
		else
			new_fields[:qty_stk] =  0
		end	
		add_update_alloctbls new_fields,command_new
	end


	def proc_rinout_to_inout stk,r_inout  ###
			stkinout = {}
			stkinout["shelfnos_id_out"] = r_inout["outstk_shelfno_id_out"]
			stkinout["shelfnos_id_in"] = r_inout["instk_shelfno_id_in"]
			stkinout["qty_stk"] = r_inout["#{stk}_qty_stk"]
			stkinout["qty"] = r_inout["#{stk}_qty"]
			stkinout["qty_sch"] = r_inout["#{stk}_qty_sch"]
			stkinout["itms_id"] = r_inout["trngantt_itm_id"]
			stkinout["lotno"] = r_inout["#{stk}_lotno"]
			stkinout["processseq"] = r_inout["trngantt_processseq"]
			stkinout["packno"] =  r_inout["#{stk}_packno"]
			stkinout["prjnos_id"] = r_inout["trngantt_prjno_id"]
			stkinout["starttime"] = r_inout["#{stk}_starttime"]
			stkinout["expiredate"] = r_inout["#{stk}_expiredate"]
			return stkinout
	end
	
	def add_stkinouts(fields,command_r,au)  ###au--> add or update。
		tblname = fields[:srctblname]
		stkinout = {}
		stkinout["expiredate"] = command_r[tblname.chop+"_expiredate"]
		stkinout =  lotno_set(tblname,stkinout,command_r) 
		stkinout["alloctbls_id"] = fields[:alloctbls_id]
		stkinout["processseq"] = command_r["opeitm_processseq"]
		stkinout["itms_id"] = command_r["opeitm_itm_id"]
		stkinout["stktaking_proc"] = command_r["opeitm_stktaking_proc"]
		stkinout["prjnos_id"] = command_r[tblname.chop+"_prjno_id"]
		stkinout["inoutflg"] = fields[:inoutflg]
		packqty = command_r["opeitm_packqty"].to_f
		##

		case  tblname
		when 	/schs$|custords/   ###pur,prdではqtyとqty_schの区別はしてない。
			stkinout["qty"] = stkinout["qty_stk"] = 0
			if 

		when /acts$/
			stkinout["qty"] = stkinout["qty_sch"] = 0
			stkinout["qty_stk"] = fields[:qty_stk].to_f - fields[:qty_linkto_alloctbl].to_f - fields[:qty_alloc].to_f
		else
			stkinout["qty_stk"] = 0
			stkinout["qty_sch"] = 0
			stkinout["qty"] =  fields[:qty].to_f - fields[:qty_linkto_alloctbl].to_f - fields[:qty_alloc].to_f
		end	
		###  stk		###  out
		case tblname
		when /^cust/  ###shelfnos_id = 0は必須
			case tblname ###
				when /schs$|ords$/
					stkinout["shelfnos_id_out"] = command_r["opeitm_shelfno_id"]
				when /insts$|dlvs$|acts$/
					stkinout["shelfnos_id_out"] = command_r[tblname.chop+"_shelfno_id_to"]
			end
			stkinout["processseq"] = command_r["opeitm_processseq"]
			stkinout["starttime"]  = get_starttime(tblname,command_r)
			#if tblname == "puracts" and !command_r["puract_sno_purdlv"].nil? and command_r["puract_sno_purdlv"] != ""
			### stk-in purdlvを使用
			#else
			proc_mk_outstks_rec stkinout,au
			#end
		when /^pur|^insp|^prd/
			case stkinout["inoutflg"]
			when /^con|^shp/
				if au == "update"
					proc_mk_outstks_rec stkinout,"update"
				end	
			end	 
		end
		
		###  stk
		###  in
		if tblname =~ /acts$/
			qty_stk  = command_r["prdact_qty_stk"].to_f
		else
			qty_stk = 0	
		end
		case tblname
			when /^pur|^insp|^prd/
				stkinout["starttime"]  = get_starttime(tblname,command_r)
				stkinout["shelfnos_id_in"] = command_r[tblname.chop+"_shelfno_id_to"]
				if stkinout["packno"] == "packno" and tblname =~ /acts$/
					stkinout["qty_stk"] = packqty 
					idx = 0
					until qty_stk <= 0 do
						stkinout["packno"] = format('%03d', idx) 
						proc_mk_instks_rec stkinout,au
						qty_stk -=  packqty 
						idx += 1
					end
				else
					proc_mk_instks_rec stkinout,au
				end	
			when /^cust/
				stkinout["duedate"]  = command_r[tblname.chop+"_duedate"]
				stkinout["custrcvplcs_id"]  = command_r[tblname.chop+"_custrcvplc_id"]
				if stkinout["packno"] == "packno" and tblname == "custacts"
					stkinout["qty_stk"] = packqty 
					idx = 0
					until qty_stk <= 0 do
						stkinout["packno"] = format('%03d', idx) 
						mk_custwhs_rec stkinout,au
						qty_stk -=  packqty 
						idx += 1
					end
				else
					mk_custwhs_rec stkinout,au
				end	
		end
	end

	def proc_trngantts tblname,tblid,paretblname,paretblid,reqparams
		###
		###
		tbldata = reqparams["tbldata"]
		strsql = %Q% select * from trngantts where tblname = '#{tblname}' and tblid = #{tblid}
					  and orgtblname = paretblname and paretblname = tblname
					  and orgtblid = paretblid and paretblid = tblid
		%
		rec = ActiveRecord::Base.connection.select_one(strsql)
		if rec.nil?  ###trngantts 追加
			if (tblid == paretblid and tblname == paretblname) 
				###新規本体を作成
				trngantts_id,reqparams = init_trngantts_add_detail(tblname,tblid,paretblname,paretblid,reqparams)	
			else ###構成の一部になっているとき(本体を作成後確認)
				trngantts_id,reqparams = child_trngantts(tblname,tblid,reqparams)  
			end	
			reqparams["trngantts_id"] = trngantts_id
		else ###trngantts 変更
			if tblname =~ /purschs|prdschs/
				qty = (tbldata["qty"]||=0) - (tbldata["qty_bal"]||=0)
			else
				qty = (tbldata["qty"]||=0) 
			end	
			qty_stk = (tbldata["qty_stk"]||=0)
			fields = {:srctblname=>tblname,:srctblid=>tblid,:trngantts_id=>rec["id"],
						:remark=>" 2106 ",
						:qty=>qty,:qty_stk=>qty_stk,:qty_alloc=>0}
			if rec["qty"].to_f == qty.to_f and  rec["qty_stk"].to_f == qty_stk.to_f
				###日付の変更
			else
				srctblqty = 0
				strsql = %Q&update trngantts set
								updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								qty = #{qty},qty_stk = #{qty_stk},remark = '1925'
								where  id = #{rec["id"]} &
				ActiveRecord::Base.connection.update(strsql)
				if qty >= rec["qty_linkto_alloctbl"].to_f  ###rec["qty_alloc"] = 0のはず　
					fields[:qty_linkto_alloctbl] =  rec["qty_linkto_alloctbl"].to_f 
				else
					if qty_stk >= rec["qty_linkto_alloctbl"].to_f 	
						fields[:qty_linkto_alloctbl] =  rec["qty_linkto_alloctbl"].to_f 
					else
						if qty >= qty_stk 
							fields[:qty_linkto_alloctbl] =  qty
							srctblqty = qty
						else
							fields[:qty_linkto_alloctbl] =  qty_stk
							srctblqty = qty_stk
						end
					end
				end
				strsql = %Q%select * from r_#{tblname} where id = #{tblid}%
				command_r = ActiveRecord::Base.connection.select_one(strsql)
				add_update_alloctbls fields,command_r
				if  rec["qty_linkto_alloctbl"].to_f > fields[:qty_linkto_alloctbl] 
					strsql = %Q% select * from  alloctbls where  trngantts_id != #{rec["id"]} 
									and srctblname = '#{tblname}' and srctblid = #{tblid} order by id desc %
					allocs = ActiveRecord::Base.connection.select_all(strsql)
					allocs.each do |alloc|
						if srctblqty < alloc["qty_linkto_alloctbl"].to_f      ###子供への必要数が不足したとき
							fields = {:srctblname=>tblname,:srctblid=>srctblid,:trngantts_id=>alloc["trngantts_id"],
										:qty=>alloc["qty"],:qty_stk=>alloc["qty_stk"],:qty_alloc=>alloc["qty_alloc"],
										:remark=>" 2141 ",
										:qty_linkto_alloctbl=>srctblqty}
							add_update_alloctbls fields,command_r
							strsql = %Q%select * from trngantts where id = #{alloc["trngantts_id"]}
							%
							trn = ActiveRecord::Base.connection.update(strsql)
							strsql = %Q&update trngantts set 
											updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
											qty_linkto_alloctbl = #{trn["qty_linkto_alloctbl"].to_f - (alloc["qty_linkto_alloctbl"].to_f - srctblqty)} ,
											remark = '2107'	where  id = #{alloc["trngantts_id"]} &
							ActiveRecord::Base.connection.update(strsql)
							srctblqty = 0
						else
							srctblqty  = srctblqty - alloc["qty_linkto_alloctbl"].to_f   ###余剰分　
							###freeの残数はtrngantts org = pare = tblのレコードの qty - qty_alloc 
						end
					end
				end	
			end
			###
			reqparams["trngantts_id"] = rec["id"]
		end
		if tblname =~ /^prd|^pur/ and  tblname =~ /insts$|acts$|rets$/
			prev_trngantts_update tblname,tblid,tbldata
		end
		return reqparams
	end

	def mk_mkordopeitms mkords_id,save_rec
		id = RorBlkctl.proc_get_nextval("mkordopeitms_seq")
		strsql = %Q&
					insert into mkordopeitms(id,
								mkords_id,
								itms_id,processseq,
								locas_id,prjnos_id,shelfnos_id_to,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{id},
								#{mkords_id},
								'#{save_rec["itms_id"]}','#{save_rec["processseq"]}',
								'#{save_rec["locas_id"]}','#{save_rec["prjnos_id"]}','#{save_rec["shelfnos_id_to"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ',#{@sio_user_code||=0},'2099/12/31','')
		&
		ActiveRecord::Base.connection.insert(strsql) 
	end
	
	def proc_processreqs_add tblname,tblid,paretblname,paretblid,reqparams
		processreqs_id = RorBlkctl.proc_get_nextval("processreqs_seq")
		if reqparams["seqno"].nil?
			reqparams["seqno"] = []
		end	
		reqparams["seqno"] << processreqs_id  ###class UploadsController で使用

		strsql = %Q&
			insert into processreqs(tblname,tblid,paretblname,paretblid,
						contents,remark,
						created_at,updated_at,
						update_ip,persons_id_upd,reqparams,seqno,
						id,result_f)
						values('#{tblname}',#{tblid},'#{paretblname}',#{paretblid||=0},
						'','',
						to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						'',#{@sio_user_code||=0},'#{JSON.generate(reqparams)}',#{reqparams["seqno"][0]},
						#{processreqs_id},'0')
		&
		ActiveRecord::Base.connection.insert(strsql) 
		 ## @sio_user_code||=0 ==>operationから呼ばれたときは@sio_user_code=nil
		return processreqs_id,reqparams
	end
end
