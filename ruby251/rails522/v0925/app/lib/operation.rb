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
		tbldata = reqparams["tbldata"]
		orgtblname = reqparams["orgtblname"]
		orgtblid = reqparams["orgtblid"]
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

		trn = {}
		strsql = "select * from r_#{paretblname} where id = #{paretblid} "
		pare_opeitm = ActiveRecord::Base.connection.select_one(strsql)
		case tblname
			when /^prdschs|^purschs/
				trn["locas_id"] = pare_opeitm["opeitm_loca_id"]
			when /^prdords/
				trn["locas_id"] = pare_opeitm["workplace_loca_id_workplace"]
			when /^prdinsts/
				tbldata["starttime"] = tbldata["duedate"] = tbldata["replydate"]
				trn["locas_id"] = pare_opeitm["workplace_loca_id_workplace"]
			when /^prdacts/
				tbldata["starttime"] = tbldata["duedate"] = tbldata["cmpldate"]
				trn["locas_id"] = pare_opeitm["workplace_loca_id_workplace"]
			when /^purords|^inspords/
				trn["locas_id"] = pare_opeitm["supplier_loca_id_supplier"]
			when /^purinsts|^inspinsts/
				tbldata["starttime"] = tbldata["duedate"] = tbldata["replydate"]
				trn["locas_id"] = pare_opeitm["supplier_loca_id_supplier"]
			when /^puracts|^inpsacts/
				tbldata["starttime"] = tbldata["duedate"] = tbldata["rcptdate"]
				trn["locas_id"] = pare_opeitm["supplier_loca_id_supplier"]
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
		trn["qty_stk"]  = qty_stk
		trn["qty_alloc"]  = 0
		trn["qty_linkto_alloctbl"] = 0
		trn["qty_pare"] = (pare_opeitm["#{paretblname.chop}_qty"]||=0)
		trn["qty_pare_alloc"] = 0
		trn["qty_stk_pare"] = (pare_opeitm["#{paretblname.chop}_qty_stk"]||=0)
		trn["itms_id"] = opeitm["itms_id"]
		trn["processseq"] = opeitm["processseq"] 
		trn["shelfnos_id_fm"] = tbldata["shelfnos_id_to"] 
		trn["prjnos_id"] = tbldata["prjnos_id"]
		trn["itms_id_pare"]  = pare_opeitm["opeitm_itm_id"] 
		trn["processseq_pare"]  = pare_opeitm["opeitm_processseq"] 
		trn["locas_id_pare"] = pare_opeitm["opeitm_loca_id"]
		trn["consumtype"] = child["consumtype"]
		trn["consumunitqty"] = (child["consumunitqty"]||=0) 
		trn["consumminqty"]  = (child["consumminqty"]||=0) 
		trn["consumchgoverqty"] = (child["consumchgoverqty"]||=0)
		trn["starttime"] = tbldata["starttime"]
		trn["duedate"] = trn["duedate_org"] = tbldata["duedate"]
		trngantts_id = RorBlkctl.proc_get_nextval("trngantts_seq")
		trn["trngantts_id"] = trn["id"] = trngantts_id
		trn["remark"] = "88"
		insert_trngantt trn

		alloc = {}  ###alloctbls
		fields = {}
		fields[:alloctbls_id] = alloc["id"] = RorBlkctl.proc_get_nextval("alloctbls_seq")
		alloc["srctblname"] = fields[:srctblname] = tblname
		alloc["srctblid"] = fields[:srctblid] = tblid
		alloc["qty"] = fields[:qty] = trn["qty"] 
		alloc["qty_stk"] =  fields[:qty_stk] = trn["qty_stk"]
		alloc["qty_linkto_alloctbl"] = fields[:qty_linkto_alloctbl] = 0
		alloc["qty_alloc"] = fields[:qty_alloc] = 0
		alloc["trngantts_id"] = fields[:trngantts_id] = trngantts_id
		alloc["remark"] = "97"
		insert_alloctbls alloc
		
		strsql = %Q%select * from r_#{tblname} where id = #{tblid}
		%
		command_r = ActiveRecord::Base.connection.select_one(strsql)
		add_stkinouts(fields,command_r,"add")  ###tblname,tblid,command_r,alloctbls_id

		if tblname =~ /purords|prdords/
			reqparams["trngantts_id"] = trngantts_id
			free_ordtbl_to_alloc trn,reqparams,alloc
		end
		return  trngantts_id,reqparams
	end

	def add_alloc_and_trn free,sch,add_free_qty, add_free_qty_stk ###free:free_trngantts    sch:custords等のtrngantts  
		strsql = %Q&update  trngantts set
									updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'), 
									qty_linkto_alloctbl = #{add_free_qty + add_free_qty_stk + free["qty_linkto_alloctbl"].to_f},			
									remark = '141' where id = #{free["id"]}
						&
		ActiveRecord::Base.connection.update(strsql)  ###freeの引き当て数変更
		###
		strsql = %Q&update  trngantts set
									updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'), 
									qty_linkto_alloctbl = #{sch["trngantt_qty_linkto_alloctbl"].to_f + add_free_qty+ add_free_qty_stk},				
									remark = '146' where id = #{sch["id"]}
						&
		ActiveRecord::Base.connection.update(strsql)  ###trnの引き当て数変更
		###
		#### free のalloctblsの変更
		###
		strsql = %Q%select * from r_#{free["orgtblname"]} where id = #{free["orgtblid"]}
		%
		command_r = ActiveRecord::Base.connection.select_one(strsql)  ###tblname,tblid,command_r,alloctbls_id
		fields = {:trngantts_id=>free["id"],:srctblname=>free["tblname"],:srctblid=>free["tblid"],
					:qty=>free["qty"].to_f,:qty_stk=>free["qty_stk"].to_f, 
					:qty_linkto_alloctbl=>add_free_qty + add_free_qty_stk + free["qty_linkto_alloctbl"].to_f ,
					:qty_alloc=>0} 
					 ###追加の数量，親からの引当数=0 既に登録済のはず
		###
		rec = add_update_alloctbls fields,command_r   ###➀ trngantts:alloctbls=1:1
		###
		#### free to alloc 
		###
		strsql = %Q%select  qty,qty_stk from alloctbls 
					where srctblname = '#{free["tblname"]}' and srctblid = '#{free["tblid"]}' 
					and trngantts_id = #{sch["id"]} 
				%
		rec = ActiveRecord::Base.connection.select_one(strsql)
		if rec
			add_free_qty = add_free_qty.to_f + rec["qty"].to_f
			add_free_qty_stk = add_free_qty_stk + rec["qty_stk"].to_f
		end	
		fields = {:trngantts_id=>sch["id"],:srctblname=>free["tblname"],:srctblid=>free["tblid"],
					:qty=>add_free_qty,:qty_stk=>add_free_qty_stk}
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
				:qty=>sch["trngantt_qty"].to_f ,:qty_stk=>sch["trngantt_qty_stk"].to_f ,
				:qty_linkto_alloctbl=>(sch["trngantt_qty_linkto_alloctbl"].to_f + add_free_qty + add_free_qty_stk)} 
		###
		sch_alloc = add_update_alloctbls fields ,command_r    ###➂		###trngantts:alloctbls=1:1
		#### free to alloc 
		###
		##fields = {:trngantts_id=>free["id"],:srctblname=>sch["tblname"],:srctblid=>sch["tblid"],
		##			:qty=>0 ,:qty_linkto_alloctbl=>add_free_qty}
		###
		##rec = add_update_alloctbls fields ,command_r   ###➃
		###create_ord_consume_outstk sch_alloc,ord_alloc,add_free_qty
		return
	end

	def add_update_alloctbls fields,command_r
		###freeのin-out数変更
		strsql = %Q%select  id,qty,qty_stk,qty_linkto_alloctbl,qty_alloc from alloctbls 
				where srctblname = '#{fields[:srctblname]}' and srctblid = '#{fields[:srctblid]}' 
				and trngantts_id = #{fields[:trngantts_id]} 
			%
		rec = ActiveRecord::Base.connection.select_one(strsql)
		if rec 
			fields[:alloctbls_id] = rec["id"]
			if fields[:qty_linkto_alloctbl].nil?
				fields[:qty_linkto_alloctbl] = rec["qty_linkto_alloctbl"]
			end
			if fields[:qty_alloc].nil?
				fields[:qty_alloc] = rec["qty_alloc"]
			end
			strsql = %Q&update alloctbls set updated_at =to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						qty_linkto_alloctbl = #{fields[:qty_linkto_alloctbl]},
						qty_alloc = #{fields[:qty_alloc]},qty = #{fields[:qty]},qty_stk = #{fields[:qty_stk]},
						remark = '217 add_update_alloctbls' where id = #{rec["id"]}
						&
			ActiveRecord::Base.connection.update(strsql)
			add_stkinouts(fields,command_r,"update")  ###rec["id"]:alloctbls_id
		else
			rec = {}
			rec["id"] = fields[:alloctbls_id] = RorBlkctl.proc_get_nextval("alloctbls_seq")
			rec["srctblname"] = fields[:srctblname]
			rec["srctblid"] = fields[:srctblid]
			rec["trngantts_id"] = fields[:trngantts_id]
			rec["qty_stk"] =  fields[:qty_stk]
			rec["qty"] = fields[:qty]
			rec["qty_linkto_alloctbl"] = (fields[:qty_linkto_alloctbl]||=0)
			rec["qty_alloc"] = (fields[:qty_alloc]||=0)
			rec["remark"] = "231 add_update_alloctbls"
			insert_alloctbls rec
			add_stkinouts(fields,command_r,"add")  ###rec["id"]:alloctbls_id
		end
		return rec
	end	

	def proc_consume_child_parts rec,act_qty,tblname,tblid  ###親がactsの時
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
				ActiveRecord::Base.connection.insert(outstk_strsql stkinout)
				break  if  consume_qty <= 0
			end	 
			if consume_qty > 0
				stkinout["lotno"] = ""
				stkinout["packno"] = "" 
				stkinout["qty_stk"] = consume_qty
				ActiveRecord::Base.connection.insert(outstk_strsql stkinout)
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
							qty,qty_stk,
							qty_alloc,qty_linkto_alloctbl,
							qty_pare,qty_stk_pare,qty_pare_alloc,
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
						#{trn["qty"]},#{trn["qty_stk"]},
						#{trn["qty_alloc"]},#{trn["qty_linkto_alloctbl"]},
						#{trn["qty_pare"]},#{trn["qty_stk_pare"]},#{trn["qty_pare_alloc"]},
						#{trn["itms_id"]},#{trn["processseq"]},#{trn["shelfnos_id_fm"]},#{trn["prjnos_id"]},#{trn["locas_id"]},
						#{trn["itms_id_pare"]},#{trn["processseq_pare"]},#{trn["locas_id_pare"]},
						'#{trn["consumtype"]}',#{trn["consumunitqty"]},#{trn["consumminqty"]},#{trn["consumchgoverqty"]},
						to_timestamp('#{trn["starttime"]}','yyyy/mm/dd hh24:mi:ss'),
						to_timestamp('#{trn["duedate"]}','yyyy/mm/dd hh24:mi:ss'),
						to_timestamp('#{trn["duedate_org"]}','yyyy/mm/dd hh24:mi:ss'),
						to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						' ','0','2099/12/31',#{trn["remark"]})
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

	def schstbl_alloc_to_freetbl  tblname,tblid,reqparams
		tbldata = reqparams["tbldata"]
		opeitm = reqparams["opeitm"]
		###freeを探す　xxxordsのみ引き当てる。
		strsql = %Q%select locas_id_shelfno from shelfnos where id = #{opeitm["shelfnos_id"]}
		%
		locas_id_shelfno =  ActiveRecord::Base.connection.select_value(strsql)

		strsql = %Q&select
					case
					when a.qty_stk >  a.qty_alloc
						then '02' 
					when  a.duedate <= to_date('#{tbldata["duedate"]}','yyyy-mm-/dd')
						then '01'	
					else
						'03' end  priority,
					to_number(to_char(duedate,'yyyymmdd'),'99999999')*-1 due,
					a.qty qty,a.qty_alloc qty_alloc,
					a.qty_linkto_alloctbl qty_linkto_alloctbl,
					a.qty_pare_alloc qty_pare_alloc,a.itms_id,a.prjnos_id,a.shelfnos_id_fm,
					a.id id,a.orgtblname orgtblname,a.orgtblid orgtblid,a.tblname tblname,a.tblid tblid			
					from trngantts a
					inner join shelfnos c on  a.shelfnos_id_fm = c.id
					where a.prjnos_id =  #{tbldata["prjnos_id"]}
						and a.orgtblname = a.paretblname and a.paretblname = a.tblname
						and a.orgtblid = a.paretblid  and a.paretblid = a.tblid
						and  a.itms_id = #{opeitm["itms_id"]} and a.processseq = #{opeitm["processseq"]}
						and c.locas_id_shelfno = #{locas_id_shelfno}
						and (a.tblname like '%ords' or a.tblname = 'lotstkhists')
						and (a.tblname like 'prd%' or a.tblname like 'pur%' or a.tblname like 'shp%' or a.tblname = 'lotstkhists')
						and ((a.qty - a.qty_linkto_alloctbl) >  0 or (a.qty_stk - a.qty_linkto_alloctbl) > 0)
						 --- free trnではfree["qty_alloc"].to_f==0 
						order by priority,due
						for update
					& ### xxxacts等を登録するときは必ずxxxordsを前に登録すること。
		frees = ActiveRecord::Base.connection.select_all(strsql)   ### free trnではfree["qty_alloc"].to_f==0 

		###引き当てられる側
		strsql = %Q% select id,
						orgtblname,orgtblid,paretblname,paretblid,tblname,tblid,
						qty trngantt_qty,
						qty_stk trngantt_qty_stk,
						qty_alloc trngantt_qty_alloc,
						qty_linkto_alloctbl trngantt_qty_linkto_alloctbl
						from trngantts where id = #{reqparams["trngantts_id"]} 
						and (qty > (qty_linkto_alloctbl + qty_alloc) or qty_stk > (qty_linkto_alloctbl + qty_alloc))%
		sch =  ActiveRecord::Base.connection.select_one(strsql)

		total_alloc_qty = sch["trngantt_qty_linkto_alloctbl"].to_f
		bal_free_qty = 0
		frees.each do |free|
			if free["qty"]  > free["qty_stk"]  ###在庫の判断
				bal_free_qty = free["qty"] - free["qty_linkto_alloctbl"].to_f 
				bal_free_qty_stk = 0
			else
				bal_free_qty_stk = free["qty_stk"] - free["qty_linkto_alloctbl"].to_f 
				bal_free_qty = 0
			end
			bal_alloc_qty =  (sch["trngantt_qty"].to_f - sch["trngantt_qty_alloc"].to_f - sch["trngantt_qty_linkto_alloctbl"].to_f)
			bal_alloc_qty_stk = 0  ###ベースのtrngantsのqty_stkはzero (sch["trngantt_qty_stk"] = 0
			if bal_free_qty >= bal_alloc_qty
				proc_add_ free,sch,bal_alloc_qty, bal_alloc_qty_stk   ###引きあたったalloc作成
				total_alloc_qty += bal_alloc_qty
			else
				proc_add_ free,sch, bal_free_qty, bal_free_qty_stk ###引きあたったalloc作成
				total_alloc_qty += bal_free_qty
			end  ### 
			break if (total_alloc_qty + sch["trngantt_qty_alloc"].to_f + sch["trngantt_qty_linkto_alloctbl"].to_f) >= sch["trngantt_qty"].to_f
			strsql = %Q% select id,
							orgtblname,orgtblid,paretblname,paretblid,tblname,tblid,
							qty trngantt_qty,
							qty_stk trngantt_qty_stk,
							qty_alloc trngantt_qty_alloc,
							qty_linkto_alloctbl trngantt_qty_linkto_alloctbl
							from trngantts where id = #{reqparams["trngantts_id"]} %
			sch =  ActiveRecord::Base.connection.select_one(strsql)
		end
		if total_alloc_qty >  sch["trngantt_qty_linkto_alloctbl"].to_f ###freeのxxxordsテーブルに引きあたった子部品を引き当て済にする。
			fields = {:qty_linkto_alloctbl=>total_alloc_qty,
							:qty_alloc=>sch["trngantt_qty_alloc"].to_f,:qty_pare_alloc=>sch["trngantt_qty_pare_alloc"].to_f }
			free_ordtbl_to_alloc_child sch,fields  ###新規展開中は子部品はいない。
		end
		return
	end	
                              ### free purords又はprdords
	def free_ordtbl_to_alloc  free,reqparams,free_alloc  ###freeで登録されたordを引き当てる。free:trngantts-->orgtblid=paretblid=tblid
		tbldata = reqparams["tbldata"]
		opeitm = reqparams["opeitm"]
		if free["qty"].to_f > free["qty_stk"].to_f  ###freeのtrngantts
			bal_free_qty = free["qty"].to_f 
		else
			bal_free_qty = free["qty_stk"].to_f 
		end	  ### qty_alloc ,qty_linkto_alloctblはzero 新規のため
		strsql = %Q%select locas_id_shelfno from shelfnos where id = #{opeitm["shelfnos_id"]}
		%  ### free trn org=pare=tbl では qty_linkto_alloctbl
		locas_id_shelfno =  ActiveRecord::Base.connection.select_value(strsql)
		if tbldata[%Q%sno_#{free["tblname"].gsub("ord","sch").chop}%] == ""
			strsql = %Q&select '01' priority,to_number(to_char(duedate,'yyyymmdd'),'99999999')*-1 due,d.id alloc_id,
						d.qty alloc_qty,d.qty_stk alloc_qty_stk,d.qty_linkto_alloctbl  alloctbl_qty_linkto_alloctbl,
						a.qty trngantt_qty,a.qty_alloc trngantt_qty_alloc,a.qty_linkto_alloctbl trngantt_qty_linkto_alloctbl,
						a.qty_pare_alloc trngantt_qty_pare_alloc,
						a.id id,a.orgtblname orgtblname,a.orgtblid orgtblid,a.tblname tblname,a.tblid tblid		
						from trngantts a
						inner join shelfnos c on  a.shelfnos_id_fm = c.id
						inner join alloctbls d on  a.id = d.trngantts_id
						where a.prjnos_id =  #{tbldata["prjnos_id"]}
							and  a.paretblid != a.tblid and a.tblname like '%schs'
							and  a.itms_id = #{opeitm["itms_id"]} and a.processseq = #{opeitm["processseq"]}
							and c.locas_id_shelfno = #{locas_id_shelfno}
							and a.tblname = d.srctblname and a.tblid = d.srctblid
							and (a.qty - a.qty_alloc - a.qty_linkto_alloctbl) > 0 
					order by priority,duedate,a.id for update of a,d
			&
		else   ###xxxordsでxxxschsのsnoを指定したとき
			strsql = %Q&select '01' priority,to_number(to_char(duedate,'yyyymmdd'),'99999999')*-1 due,d.id alloc_id,
							d.qty alloc_qty,d.qty_stk alloc_qty_stk,d.qty_linkto_alloctbl  alloctbl_qty_linkto_alloctbl,
							a.qty trngantt_qty,a.qty_alloc trngantt_qty_alloc,a.qty_stk trngantt_qty_stk,
							a.qty_linkto_alloctbl trngantt_qty_linkto_alloctbl,
							a.qty_pare_alloc trngantt_qty_pare_alloc,
							a.id id,a.orgtblname orgtblname,a.orgtblid orgtblid,a.tblname tblname,a.tblid tblid							
							from trngantts a
							inner join shelfnos c on  a.shelfnos_id_fm = c.id
							inner join alloctbls d on  a.id = d.trngantts_id
							inner join #{free["tblname"].gsub("ord","sch")} sch on  a.tblid = sch.id
							where a.prjnos_id =  #{tbldata["prjnos_id"]}
								and  a.paretblid != a.tblid and a.tblname like '%schs'
								and  a.itms_id = #{opeitm["itms_id"]} and a.processseq = #{opeitm["processseq"]}
								and c.locas_id_shelfno = #{locas_id_shelfno}
								and a.tblname = d.srctblname and a.tblid = d.srctblid
								and (a.qty - a.qty_alloc - a.qty_linkto_alloctbl) > 0  
								and sch.sno = #{tbldata["sno_#{free["tblname"].gsub("ord","sch").chop}"]} 
						order by priority,duedate,a.id for update a,d
				&
		end	
		bal_alloc_qty = 0
		ActiveRecord::Base.connection.select_all(strsql).each do |sch|
			bal_alloc_qty = sch["trngantt_qty"].to_f - sch["trngantt_qty_alloc"].to_f - sch["trngantt_qty_linkto_alloctbl"].to_f
			if bal_alloc_qty < bal_free_qty
				if free["qty"].to_f > free["qty_stk"].to_f 
					add_alloc_and_trn free,sch, bal_alloc_qty,0 ###freeに引きあたったalloc作成
				else	
					add_alloc_and_trn free,sch, 0,bal_alloc_qty ###freeに引きあたったalloc作成
				end
				qty_linkto_alloctbl = bal_alloc_qty
				bal_free_qty -= bal_alloc_qty
			else
				if free["qty"].to_f > free["qty_stk"].to_f 
					add_alloc_and_trn free,sch, bal_free_qty,0 ###freeに引きあたったalloc作成
				else
					add_alloc_and_trn free,sch, 0,bal_free_qty ###freeに引きあたったalloc作成
				end
				qty_linkto_alloctbl = bal_free_qty
				bal_free_qty = 0
			end
			###
			
			fields = {:qty_linkto_alloctbl=>sch["trngantt_qty_linkto_alloctbl"].to_f + qty_linkto_alloctbl ,
						:qty=>sch["trngantt_qty"].to_f,:qty_stk=>sch["trngantt_qty_stk"].to_f,
						:qty_alloc =>sch["trngantt_qty_alloc"].to_f,
						:qty_pare_alloc=>sch["trngantt_qty_pare_alloc"].to_f}
			free_ordtbl_to_alloc_child sch,fields  ###freeのxxxordsテーブルを他のオーだのもとにあるxxxschsに引き当てる。
			break if bal_free_qty <= 0
			strsql = %Q%select * from trngantts where id = #{free["id"]}%
			free = ActiveRecord::Base.connection.select_one(strsql) 
		end
		return
	end	

	###下位の構成の引き当てられる員数の変更	
	def free_ordtbl_to_alloc_child sch,fields    ###日付変更の対応が未だ
		strsql = %Q&update  trngantts set 
						updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						qty_alloc = #{fields[:qty_alloc]},qty_pare_alloc = #{fields[:qty_pare_alloc]},
						qty_linkto_alloctbl = #{fields[:qty_linkto_alloctbl]},remark = '419' where  id = #{sch["id"]}&
		ActiveRecord::Base.connection.update(strsql)
		strsql = %Q%select * from trngantts where orgtblname = '#{sch["orgtblname"]}' and orgtblid = #{sch["orgtblid"]}
											and  paretblname = '#{sch["tblname"]}' and paretblid = #{sch["tblid"]}
											and (qty - qty_alloc ) > 0 for update
		%
		ActiveRecord::Base.connection.select_all(strsql).each do |child| ###下位構成の引き当てなおし
			gfields = {}
			gfields[:qty_alloc] = (fields[:qty_alloc] + fields[:qty_linkto_alloctbl]) * child["chilnum"].to_f / child["parenum"].to_f
			if  (child["qty"].to_f + child["qty_stk"].to_f) < child["qty_linkto_alloctbl"].to_f + gfields[:qty_alloc]  ###child -->schs
				qty_linkto_alloctbl = child["qty_linkto_alloctbl"]  =  (child["qty"].to_f + child["qty_stk"].to_f) - gfields[:qty_alloc] 
			else
				qty_linkto_alloctbl = child["qty_linkto_alloctbl"].to_f  
			end
			###
			strsql = %Q% select a.id alloc_id,b.id trn_id,a.qty_linkto_alloctbl,b.qty_linkto_alloctbl link_qty,
								a.srctblname,a.srctblid,a.trngantts_id,
								a.qty,a.qty_stk,b.orgtblname,b.tblname,b.orgtblid,b.tblid  from alloctbls  a 
										inner join trngantts b  on  a.trngantts_id = b.id
										where a.trngantts_id = #{child["id"]}
									---	and (a.srctblname != '#{child["tblname"]}' or a.srctblid != #{child["tblid"]} )
										and (a.qty > 0 or a.qty_stk > 0 )
										order by a.srctblname,a.srctblid
										%
			save_srctblid = '0'
			ActiveRecord::Base.connection.select_all(strsql).each do |over|
				if save_srctblid != over["srctblid"]
						strsql = %Q% select * from r_#{over["srctblname"]} where id = #{over["srctblid"]} %
						command_r = ActiveRecord::Base.connection.select_one(strsql)
						save_srctblid = over["srctblid"]
				end	
				if over["srctblid"] == child["tblid"]  and  over["srctblname"] == child["tblname"]  ###orgtbl の配下のテーブルの引き当て変更
						alloc_fields ={:trngantts_id=>over["trngantts_id"],:srctblname=>child["tblname"],:srctblid=>child["tblid"],
									:qty_linkto_alloctbl=>child["qty_linkto_alloctbl"],:qty_alloc=> gfields[:qty_alloc] ,
									:qty=>over["qty"].to_f,:qty_stk=>over["qty_stk"].to_f}
						add_update_alloctbls alloc_fields,command_r
				else
					if over["qty_linkto_alloctbl"].to_f >= qty_linkto_alloctbl
						alloc_fields ={:trngantts_id=>over["trngantts_id"],:srctblname=>over["srctblname"],:srctblid=>over["srctblid"],
										:qty_linkto_alloctbl=> qty_linkto_alloctbl,:qty_alloc=>0 ,
										:qty=>over["qty"].to_f,:qty_stk=>over["qty_stk"].to_f}
						add_update_alloctbls alloc_fields,command_r  
						strsql =%Q%select * from trngantts where orgtblid = '#{over["srctblid"]}' and paretblid = '#{over["srctblid"]}' and
									tblid = '#{over["srctblid"]}' and 
									orgtblname = '#{over["srctblname"]}' and paretblname = '#{over["srctblname"]}' and 
									tblname = '#{over["srctblname"]}'  
						%
						free = ActiveRecord::Base.connection.select_one(strsql)
						free_qty_linkto_alloctbl = free["qty_linkto_alloctbl"].to_f - (over["qty_linkto_alloctbl"].to_f - qty_linkto_alloctbl)
						strsql =%Q%update trngantts set  qty_linkto_alloctbl = #{free_qty_linkto_alloctbl}
									where id = #{free["id"]}
						%
						qty_linkto_alloctbl = 0	
					else
						qty_linkto_alloctbl  = qty_linkto_alloctbl - over["qty_linkto_alloctbl"].to_f
					end	
				end	
			end	
			###親からの構成引継ぎなのでaslloctblsとのリンクはない。
			###本体の子の構成は親からの引き当ての継続　直接ordsには引きあたらない。
			gfields[:qty_linkto_alloctbl] = child["qty_linkto_alloctbl"].to_f   ###trnganttsのfreeオーダ引き当て数全体数
			gfields[:qty_pare_alloc] = fields[:qty_alloc]
			free_ordtbl_to_alloc_child child,gfields
		end
	end	

	def update_alloctbls_inout fields,key    ###,old_alloc
		strfield2 = " updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),"
		fields.each do |field,val|
			strfield2 << " #{field.to_s} = "
			case val.class.to_s
				when "String"
					strfield2 << " '#{val}',"
				when "Time"
					strfield2 << " to_date('#{val.to_s}','yyyy/mm/dd hh24:mi:ss'),"
				when "Date"
					strfield2 << " to_date('#{val.to_s}','yyyy/mm/dd') ,"
				else
					strfield2 << " #{val},"
			end
		end
		where = " where "
		key.each do |k,v|
			case k.to_s
			when "alloctbls_id"
				where << " id = #{v}   and "
			when "trngantts_id"
				where << " trngantts_id = #{v}   and "
			when "srctblname"
				where << " srctblname = '#{v} '  and "
			when "srctblid"		
				where << " srctblid = #{v}   and "
			else
			end			
		end	
		strsql =  "update alloctbls  set " + strfield2.chop + where[0..-6]
		ActiveRecord::Base.connection.update(strsql)

		link_qty = fields[:qty_linkto_alloctbl].to_f  ### qty_linkto_alloctbl --->引き当たった数

		case key[:srctblname]
		when /acts$/
			qty_stk = fields[:qty_stk].to_f  - link_qty 
			qty_sch = qty = 0
		when /schs$/   ###alloctblsではqtyとqty_schを分けてない。
			qty_sch = fields[:qty].to_f - link_qty 
		else
			qty = fields[:qty].to_f - link_qty 
			qty_stk = qty_sch = 0
		end

		strsql  = %Q%select * from r_instks  where  instk_alloctbl_id = #{key[:alloctbls_id]} %
		r_inout  = ActiveRecord::Base.connection.select_one(strsql)  ###更新後のr_instks
		
		strsql = %Q%update instks  set 
					 qty = #{qty},qty_stk = #{qty_stk} ,qty_sch = #{qty_sch} 
					 where  alloctbls_id = #{key[:alloctbls_id]} %
		ActiveRecord::Base.connection.update(strsql)

		r_inout["qty_sch"] = qty_sch
		r_inout["qty"] = qty
		r_inout["qty_stk"] = qty_stk
		stkinout = rinout_to_inout "instk",r_inout 
		if r_inout["alloctbl_srctblname"] =~ /shpschs|shpords|shpinsts/
			###在庫の移動はなし　　shpords shpinstsはあくまで予定
		else	
			lotstkhists_in_out "in",stkinout  ##,old_alloc,r_inout["alloctbl_srctblname"]
		end
		##
		strsql = %Q%update outstks  set 
						qty = #{qty},qty_stk = #{qty_stk} ,qty_sch = #{qty_sch} 
						where  alloctbls_id = #{key[:alloctbls_id]} %
		ActiveRecord::Base.connection.update(strsql)
		strsql  = %Q%select * from r_outstks  where  outstk_alloctbl_id = #{key[:alloctbls_id]} %
		r_inout  = ActiveRecord::Base.connection.select_one(strsql)
		stkinout = rinout_to_inout "outstk",r_inout 
		if r_inout["alloctbl_srctblname"] =~ /shpschs|shpords|shpinsts/
			###在庫の移動はなし　　shpords shpinstsはあくまで予定
		else	
			lotstkhists_in_out "out",stkinout   ###,old_alloc,r_inout["alloctbl_srctblname"]
		end
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
		trn["qty_stk_pare"]  = (pare["qty_stk"]||=0)
		trn["qty"] = (tbldata["qty"]||=0)
		trn["qty_stk"] = (tbldata["qty_stk"]||=0)
		if  pare["tblname"] ==  reqparams["orgtblname"] and  pare["tblname"] =~ /ords$/
			trn["qty_alloc"] = (trn["qty_stk_pare"].to_f ) * child["chilnum"].to_f / child["parenum"].to_f
		else   ###child_trnganttsでは rec["tblname"] =~ /schs$/のはず 
			trn["qty_alloc"] = (trn["qty_stk_pare"].to_f + pare["qty_alloc"].to_f + pare["qty_linkto_alloctbl"].to_f) * 
								child["chilnum"].to_f / child["parenum"].to_f
		end
		trn["qty_linkto_alloctbl"] = 0
		trn["qty_pare_alloc"] = pare["qty_alloc"]
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
		trn["remark"] = "514"
		insert_trngantt trn

		alloc = {}
		fields = {}
		fields[:alloctbls_id] = alloc["id"] = RorBlkctl.proc_get_nextval("alloctbls_seq")
		alloc["srctblname"] = fields[:srctblname] = tblname
		alloc["srctblid"] = fields[:srctblid] = tblid
		alloc["qty"] = fields[:qty] = trn["qty"] 
		alloc["qty_stk"] =  fields[:qty_stk] =trn["qty_stk"]
		alloc["qty_alloc"] = fields[:qty_alloc] = trn["qty_alloc"]
		alloc["qty_linkto_alloctbl"] = fields[:qty_linkto_alloctbl] = 0
		alloc["remark"] = "610"
		alloc["trngantts_id"]  = fields[:trngantts_id] =  trngantts_id 
		insert_alloctbls alloc

		strsql = %Q%select * from r_#{tblname} where id = #{tblid}
		%
		command_r = ActiveRecord::Base.connection.select_one(strsql)
		add_stkinouts(fields,command_r,"add")  ###tblname,tblid,command_r,alloctbls_id
		
		 ###元がordsの時のみ子のschsをords等に引き当てる。
		if reqparams["orgtblname"] =~ /ords$/ and trn["qty"].to_f > trn["qty_alloc"].to_f 
			reqparams["trngantts_id"] = trngantts_id
			schstbl_alloc_to_freetbl  tblname,tblid,reqparams
		end
		return trngantts_id,reqparams
	end
	
	def proc_nextshp req,email,pare_loca_id,parent,tbldata
		command_c = {}
		command_c[:sio_code] =  command_c[:sio_viewname] =  "r_shp#{yield}s"
		command_c[:sio_message_contents] = nil
		command_c[:sio_recordcount] = 1
		command_c[:sio_result_f] =   "0"  
		command_c[:sio_classname] = "shp#{yield}_add_"
		strsql = %Q% select pobject_code_sfd from  func_get_screenfield_grpname('#{email}','r_shp#{yield}s')
				%
		fields = ActiveRecord::Base.connection.select_values(strsql) 
		opeitm_id = {}
		strsql = %Q& select ord.* from r_#{req["tblname"]} ord	where ord.id = #{req["tblid"]}
			&
		ActiveRecord::Base.connection.select_one(strsql).each do |key,val|
				if key == "id" 
					command_c[key] = ""
					command_c["shp#{yield}_id"] = "" 
				else
					if fields.index(key)
						command_c[key] = val
					else
						if fields.index(key.sub("#{req["tblname"].chop}","shp#{yield}"))
							command_c[key.sub("#{req["tblname"].chop}","shp#{yield}")] = val
						else
							case key.to_s
							when "opeitm_itm_id"
								command_c["shp#{yield}_itm_id"] = val
							when "opeitm_processseq"
								command_c["shp#{yield}_processseq"] = val
							end
						end
					end
				end
		end
		command_c["shp#{yield}_isudate"] = Time.now 
		command_c["shp#{yield}_shelfno_id_fm"] = tbldata["shelfnos_id_to"]
		command_c["shp#{yield}_loca_id_to"] = pare_loca_id
		command_c["shp#{yield}_depdate"] = parent["#{req["paretblname"].chop}_starttime"]
		command_c["shp#{yield}_gno"] = parent["#{req["paretblname"].chop}_sno"] 
		command_c["shp#{yield}_transport_id"] = 0 
		command_c["shp#{yield}_paretblname"] = req["paretblname"] 
		command_c["shp#{yield}_paretblid"] = req["paretblid"]
		if req["paretblname"] =~ /^pur/   ###tblname= 'feepayment'--->有償支給
			strsql =%Q&select * from pricemsts where tblname= 'feepayment' and expiredate >= current_date
								and itms_id = #{command_c["shp#{yield}_itm_id"]} 
								and processseq = #{command_c["shp#{yield}_processseq"]}
								and (locas_id = #{pare_loca_id} or locas_id = (select id from locas where code = 'dummy' ))
								order by expiredate limit 1
			& 
			rec = ActiveRecord::Base.connection.select_one(strsql)
			if rec
				###日付、数量による再設定
			else
				command_c["shp#{yield}_price"] = 0 	
				command_c["shp#{yield}_amt"] = 0 	
				command_c["shp#{yield}_tax"] = 0 	
				command_c["shp#{yield}_crr_id"] = 0 	
			end
		else
			command_c["shp#{yield}_price"] = 0 	
			command_c["shp#{yield}_amt"] = 0 	
			command_c["shp#{yield}_tax"] = 0 	
			command_c["shp#{yield}_crr_id"] = 0 	
		end	
		command_r,reqparams = RorBlkctl.proc_private_aud_rec  command_c,1,nil,nil,nil
	end

	def proc_resetshp req,reqparams ###親がordsに変わった時　schsについていた子供の変更
		strsql = %Q&select t.tblname tblname,t.tblid tblid,t.orgtblname orgtblname,t.orgtblid orgtblid,
						t.paretblname paretblname,t.paretblid paretblid,a.qty_linkto_alloctbl qty_linkto_alloctbl
						from trngantts t 
						inner join alloctbls a on a.trngantts_id = t.id
						where a.srctblname = '#{req["paretblname"]}' and a.srctblid = #{req["paretblid"]}
						and (t.orgtblname != t.paretblname or t.orgtblid != t.paretblid)  
		&
		ActiveRecord::Base.connection.select_all(strsql).each do |trn|
			strsql = %Q&select * from r_shpschs s 
							where shpsch_paretblname = '#{trn["tblname"]}' and shpsch_paretblid = #{trn["tblid"]}
			&
			ActiveRecord::Base.connection.select_all(strsql).each do |command_c|
				strsql = %Q&select * from trngantts where orgtblname = '#{trn["orgtblname"]}' and orgtblid = #{trn["orgtblid"]}
											and paretblname = '#{trn["tblname"]}' and paretblid = #{trn["tblid"]}
											and itms_id = #{command_c["shpsch_itm_id"]} and processseq = #{command_c["shpsch_processseq"]}
											and locas_id_pare = #{command_c["shpsch_loca_id_to"]}
				&
				rec = ActiveRecord::Base.connection.select_one(strsql)
				new_qty = rec["qty"].to_f - rec["qty_alloc"].to_f - rec["qty_linkto_alloctbl"].to_f
				command_c[:sio_code] =  command_c[:sio_viewname] =  "r_shpschs"
				command_c[:sio_message_contents] = nil
				command_c[:sio_recordcount] = 1
				command_c[:sio_result_f] =   "0"  
				command_c[:sio_classname] = "shpsch_update_"
				command_c["shpsch_qty"] = new_qty
				command_c["shpsch_amt"] = new_qty * command_c["shpsch_price"].to_f
				###tax 未設定
				command_r,reqparams = RorBlkctl.proc_private_aud_rec  command_c,1,nil,nil,nil
			end
		end
	end

	def proc_mkords email,reqparams  ###xxxschsからxxxordsを作成する。 trngantts:xxxschs= 1:1
		tbldata = reqparams["tbldata"]
		strsql = strwhere = allocwhere = ""
		incnt = outcnt = inqty = outqty = inamt = outamt = 0
		["_org","_pare"].each do |tbl|  ###抽出条件のsql作成
			case tbl
			when "_org"
				if  tbldata["orgtblname"] and tbldata["orgtblname"] != ""
					tblxxx = tbldata["orgtblname"]
					strsql << %Q% r_#{tblxxx}  org,
					%
					strwhere << "orgtblname = '#{tblxxx}' and orgtblid = org.id      and"
				else	
					next
				end
			when "_pare"   ###pareはxxxordsであること。
				if  tbldata["paretblname"] and tbldata["paretblname"] != ""
					tblxxx = tbldata["paretblname"]
					allocwhere = %Q& gantt.id in(select alloc.trngantts_id from alloctbls alloc where srctblname = '#{tbldata["paretblname"]}'  and
										srctblid in(select id from r_#{tbldata["paretblname"]} where  &
				else
					next
				end
			end
    		if tblxxx != "" and !tblxxx.nil?
        		strsql = %Q% select pobject_code_sfd,screenfield_type from  func_get_screenfield_grpname('#{email}','#{tblxxx}')
        		%
				fields = ActiveRecord::Base.connection.select_all(strsql)
				case tbl
				when "_org"
					fields.each do |fd|
						if tbldata[fd["pobject_code_sfd"]+"_org"] != "" and  !tbldata[fd["pobject_code_sfd"]+"_org"].nil? and tbldata["orgtblname"] != ""
							case fd["screenfield_type"]
							when "date"   
								strwhere << %Q% org.#{fd["pobject_code_sfd"]} <= to_date('#{tbldata[fd["pobject_code_sfd"]+"_org"]}','yyyy/mm/dd')   and
								%
							when "timestamp(6)"								
								strwhere << %Q% org.#{fd["pobject_code_sfd"]} <= to_date('#{tbldata[fd["pobject_code_sfd"]+"_org"]}','yyyy/mm/dd hh24:mi:ss')   and
								%
							when "numeric"
								if tbldata[fd["pobject_code_sfd"]] != '0' and fd["pobject_code_sfd"] =~ /_id/ ###XXXs_id == 0（未定)　対象外
									strwhere << %Q% org.#{fd["pobject_code_sfd"]} = #{tbldata[fd["pobject_code_sfd"]+"_org"]}   and
									%
								else
									if fd["pobject_code_sfd"] !~ /_id/ 	
										strwhere << %Q% org.#{fd["pobject_code_sfd"]} = #{tbldata[fd["pobject_code_sfd"]+"_org"]}   and
										%
									else
										###抽出なし
									end	
								end
							else
								strwhere << %Q% org.#{fd["pobject_code_sfd"]} = '#{tbldata[fd["pobject_code_sfd"]+"_org"]}'   and
								%
							end   ### case-
						end	  ### if tbldata
					end  ###fields.each
				when "_pare"
					fields.each do |fd|
						if tbldata[fd["pobject_code_sfd"]+"_pare"] != "" and  !tbldata[fd["pobject_code_sfd"]+"_pare"].nil? 
							case fd["screenfield_type"]
							when "date"   
								allocwhere  << %Q% #{fd["pobject_code_sfd"]} <= to_date('#{tbldata[fd["pobject_code_sfd"]+"_pare"]}','yyyy/mm/dd')   and
								%
							when "timestamp(6)"
								allocwhere  << %Q% #{fd["pobject_code_sfd"]} <= to_date('#{tbldata[fd["pobject_code_sfd"]+"_pare"]}','yyyy/mm/dd hh24:mi:ss')   and
								%
							when "numeric"
								if tbldata[fd["pobject_code_sfd"]+"_pare"] != '0' and fd["pobject_code_sfd"] =~ /_id/ ###XXXs_id == 0（未定)　対象外
									allocwhere  << %Q% #{fd["pobject_code_sfd"]} = #{tbldata[fd["pobject_code_sfd"]+"_pare"]}   and
									%
								else
									if fd["pobject_code_sfd"] !~ /_id/ 	
										allocwhere  << %Q% #{fd["pobject_code_sfd"]} = #{tbldata[fd["pobject_code_sfd"]+"_pare"]}   and
										%
									else
										###抽出なし
									end	
								end
							else
								allocwhere  << %Q% org.#{fd["pobject_code_sfd"]} = '#{tbldata[fd["pobject_code_sfd"]+"_pare"]}'   and
								%
							end   ### case-
						end	  ### if tbldata
					end  ###fields.each
				end
			end   ###tblxxx != "" and !tblxxx.nil?
		end   ### ["_org","_pare","_trn"].each do |tbl|
		
		strsql = %Q&select max(gantt.tblname) tblname,max(gantt.tblid) tblid, 
					gantt.paretblname,max(gantt.paretblid) paretblid,
					max(gantt.orgtblname) orgtblname,max(gantt.orgtblid) orgtblid,
					gantt.itms_id,gantt.processseq,
					sum(gantt.qty - gantt.qty_alloc - gantt.qty_linkto_alloctbl ) qty, 
					to_char(gantt.starttime,'yyyy/mm/dd') starttime,to_char(gantt.duedate,'yyyy/mm/dd') duedate,
					prjnos_id,chrgs_id
				from trngantts gantt,#{strsql.chop} 
				where #{strwhere}  #{allocwhere} (gantt.qty - gantt.qty_alloc - gantt.qty_linkto_alloctbl ) > 0
				group by gantt.paretblname,gantt.itms_id,gantt.processseq,locas_id,
							to_char(gantt.starttime,'yyyy/mm/dd') ,to_char(gantt.duedate,'yyyy/mm/dd'),prjnos_id,chrgs_id
				order by  gantt.paretblname,locas_id,gantt.itms_id,gantt.processseq, duedate
			&
		command_c = {}
		tblords = tbldata["tblname"].gsub("schs","ords")
		command_c["opeitm_itm_id"] = command_c["opeitm_processseq"] = command_c["opeitm_loca_id"] = ""
		command_c["#{tblords.chop}_duedate"] = "2000/01/01"
		command_c["#{tblords.chop}_qty"] = 0
		command_c["#{tblords.chop}_prjno_id"] = command_c["#{tblords.chop}_chrg_id"] = ""
			
		ActiveRecord::Base.connection.select_all(strsql).each do |rec,index|
			incnt += 1
			inqty += rec["qty"].to_f
			if rec["items_id"] == save_rec["itms_id"] and
				rec["processseq"] == save_rec["processseq"] and 
				rec["locas_id"] == save_rec["loca_id"] and
				rec["prjnos_id"] == save_rec["prjnos_id"] and 
				rec["chrgs_id"] == save_rec["chrgs_id"] 
				###まとめ機関の確認
				if rec["duedate"].to_date <= command_c["#{tblxxx.chop}_duedate"].date  + command_c["#{tblxxx.chop}_opt_fixoterm"].to_i
					command_c["#{tblords.chop}_qty"] = command_c["#{tblords.chop}_qty"].to_f + rec["qty"].to_f
				else
					if command_c["#{tblords.chop}_packqty"].to_f > 0 
						qty = (command_c["#{tblords.chop}_qty"].to_f / command_c["#{tblords.chop}_packqty"].to_f).ceil * command_c["#{tblords.chop}_packqty"].to_f
						saveqty = command_c["#{tblords.chop}_qty"] 
						command_c["#{tblords.chop}_qty"] = qty 
					else
						saveqty = qty = command_c["#{tblords.chop}_qty"] 
					end
					command_r,reqparams = RorBlkctl.  command_c,1,reqparams
					outcnt += 1
					outqty +=  command_c["#{tblords.chop}_qty"].to_f
					command_c["#{tblords.chop}_duedate"] = rec["duedate"]
					command_c["#{tblords.chop}_qty"] = rec["qty"].to_f + saveqty - qty   ###過剰分の繰り越し
				end		
			else
				if command_c["#{tblords.chop}_qty"].to_f > 0 ###最初のレコードは除く
					if command_c["#{tblords.chop}_packqty"].to_f > 0 
						command_c["#{tblords.chop}_qty"] = (command_c["#{tblords.chop}_qty"].to_f / command_c["#{tblords.chop}_packqty"].to_f).ceil * command_c["#{tblords.chop}_packqty"].to_f
					end
					command_r,reqparams = RorBlkctl.proc_private_aud_rec  command_c,1,nil,nil,reqparams
				end
				strsql = %Q%select * from r_#{tblxxx} where id = #{rec["tblid"]}
				%
				command_c = ActiveRecord::Base.connection.select_one(strsql)
				command_c["#{tblords.chop}_id"] = command_c["id"] = ""
				command_c[:sio_code] =  "r_#{tblords}"
				command_c[:sio_viewname] =  "r_#{tblords}"
				command_c[:sio_message_contents] = nil
				command_c[:sio_recordcount] = 1
				command_c[:sio_result_f] =   "0"  
				command_c[:sio_classname] = "_add_ord_by_mkord"
				save_rec = rec.dup
			end
		end	 
		###最後のレコードの処理
		if command_c["#{tblords.chop}_qty"].to_f > 0
			if command_c["#{tblords.chop}_packqty"].to_f > 0 
				command_c["#{tblords.chop}_qty"] = (command_c["#{tblords.chop}_qty"].to_f / command_c["#{tblords.chop}_packqty"].to_f).ceil * command_c["#{tblords.chop}_packqty"].to_f
			end
			command_r,reqparams = RorBlkctl.proc_private_aud_rec  command_c,1,nil,nil,reqparams
			outcnt += 1
			outqty +=  command_c["#{tblords.chop}_qty"].to_f
		end
		return incnt, outcnt ,inqty ,outqty, inamt ,outamt
	end

	def proc_mkshps email,reqparams  ###shpxxxsからshpyyysを作成する。 
		tbldata = reqparams["tbldata"]
		strsql = strwhere = ""
		incnt = outcnt = inqty = outqty = inamt = outamt = 0
		["_org","_pare"].each do |tbl|  ###抽出条件のsql作成
			case tbl
				when "_org"
					if  tbldata["orgtblname"] and tbldata["orgtblname"] != ""
						tblxxx = tbldata["orgtblname"]
						strsql << %Q% r_#{tblxxx}  org,
						%
						strwhere << "orgtblname = '#{tblxxx}' and orgtblid = org.id      and"
					else	
						next
					end
				when "_pare"   ###pareはxxxordsであること。
					if  tbldata["paretblname"] and tbldata["paretblname"] != ""
						tblxxx = tbldata["paretblname"]
						allocwhere = %Q& gantt.id in(select alloc.trngantts_id from alloctbls alloc where srctblname = '#{tbldata["paretblname"]}'  and
											srctblid in(select id from r_#{tbldata["paretblname"]} where  &
					else
						next
					end
			end
			if tblxxx != "" and !tblxxx.nil?
					strsql = %Q% select pobject_code_sfd,screenfield_type from  func_get_screenfield_grpname('#{email}','#{tblxxx}')
					%
					fields = ActiveRecord::Base.connection.select_all(strsql)
					case tbl
					when "_org"
						fields.each do |fd|
							if tbldata[fd["pobject_code_sfd"]+"_org"] != "" and  !tbldata[fd["pobject_code_sfd"]+"_org"].nil? and tbldata["orgtblname"] != ""
								case fd["screenfield_type"]
								when "date"   
									strwhere << %Q% org.#{fd["pobject_code_sfd"]} <= to_date('#{tbldata[fd["pobject_code_sfd"]+"_org"]}','yyyy/mm/dd')   and
									%
								when "timestamp(6)"								
									strwhere << %Q% org.#{fd["pobject_code_sfd"]} <= to_date('#{tbldata[fd["pobject_code_sfd"]+"_org"]}','yyyy/mm/dd hh24:mi:ss')   and
									%
								when "numeric"
									if tbldata[fd["pobject_code_sfd"]] != '0' and fd["pobject_code_sfd"] =~ /_id/ ###XXXs_id == 0（未定)　対象外
										strwhere << %Q% org.#{fd["pobject_code_sfd"]} = #{tbldata[fd["pobject_code_sfd"]+"_org"]}   and
										%
									else
										if fd["pobject_code_sfd"] !~ /_id/ 	
											strwhere << %Q% org.#{fd["pobject_code_sfd"]} = #{tbldata[fd["pobject_code_sfd"]+"_org"]}   and
											%
										else
											###抽出なし
										end	
									end
								else
									strwhere << %Q% org.#{fd["pobject_code_sfd"]} = '#{tbldata[fd["pobject_code_sfd"]+"_org"]}'   and
									%
								end   ### case-
							end	  ### if tbldata
						end  ###fields.each
					when "_pare"
						fields.each do |fd|
							if tbldata[fd["pobject_code_sfd"]+"_pare"] != "" and  !tbldata[fd["pobject_code_sfd"]+"_pare"].nil? 
								case fd["screenfield_type"]
								when "date"   
									allocwhere  << %Q% #{fd["pobject_code_sfd"]} <= to_date('#{tbldata[fd["pobject_code_sfd"]+"_pare"]}','yyyy/mm/dd')   and
									%
								when "timestamp(6)"
									allocwhere  << %Q% #{fd["pobject_code_sfd"]} <= to_date('#{tbldata[fd["pobject_code_sfd"]+"_pare"]}','yyyy/mm/dd hh24:mi:ss')   and
									%
								when "numeric"
									if tbldata[fd["pobject_code_sfd"]+"_pare"] != '0' and fd["pobject_code_sfd"] =~ /_id/ ###XXXs_id == 0（未定)　対象外
										allocwhere  << %Q% #{fd["pobject_code_sfd"]} = #{tbldata[fd["pobject_code_sfd"]+"_pare"]}   and
										%
									else
										if fd["pobject_code_sfd"] !~ /_id/ 	
											allocwhere  << %Q% #{fd["pobject_code_sfd"]} = #{tbldata[fd["pobject_code_sfd"]+"_pare"]}   and
											%
										else
											###抽出なし
										end	
									end
								else
									allocwhere  << %Q% org.#{fd["pobject_code_sfd"]} = '#{tbldata[fd["pobject_code_sfd"]+"_pare"]}'   and
									%
								end   ### case-
							end	  ### if tbldata
						end  ###fields.each
					end	
			end
		end   ### ["_org","_pare"].each do |tbl|
		
			strsql = %Q&select max(gantt.tblname) tblname,max(gantt.tblid) tblid, ---出庫の時はparetblid,itms_id,processseqでユニークになる
					gantt.paretblname,max(gantt.paretblid) paretblid,
					max(gantt.orgtblname) orgtblname,max(gantt.orgtblid) orgtblid,
					gantt.itms_id,gantt.processseq,
					sum(gantt.qty - gantt.qty_alloc - gantt.qty_linkto_alloctbl ) qty, 
					to_char(gantt.starttime,'yyyy/mm/dd') starttime,to_char(gantt.duedate,'yyyy/mm/dd') duedate,
					prjnos_id,chrgs_id
				from trngantts gantt,#{strsql.chop} 
				where #{strwhere} (gantt.qty - gantt.qty_alloc - gantt.qty_linkto_alloctbl ) > 0
				group by gantt.paretblname,gantt.itms_id,gantt.processseq,locas_id,
							to_char(gantt.starttime,'yyyy/mm/dd') ,to_char(gantt.duedate,'yyyy/mm/dd'),prjnos_id,chrgs_id
				order by  gantt.paretblname,locas_id,gantt.itms_id,gantt.processseq, duedate
			&
		tblords = tblxxx.gsub("schs","ords")
		command_c = {}
		command_c["opeitm_itm_id"] = command_c["opeitm_processseq"] = command_c["opeitm_loca_id"] = ""
		command_c["#{tblords.chop}_duedate"] = "2000/01/01"
		command_c["#{tblords.chop}_qty"] = 0
		command_c["#{tblords.chop}_prjno_id"] = command_c["#{tblords.chop}_chrg_id"] = ""
			
		ActiveRecord::Base.connection.select_all(strsql).each do |rec,index|
			incnt += 1
			inqty += rec["qty"].to_f
			if rec["items_id"] == save_rec["itms_id"] and
				rec["processseq"] == save_rec["processseq"] and 
				rec["locas_id"] == save_rec["loca_id"] and
				rec["prjnos_id"] == save_rec["prjnos_id"] and 
				rec["chrgs_id"] == save_rec["chrgs_id"] 
				###まとめ機関の確認
				if rec["duedate"].to_date <= command_c["#{tblxxx.chop}_duedate"].date  + command_c["#{tblxxx.chop}_opt_fixoterm"].to_i
					command_c["#{tblords.chop}_qty"] = command_c["#{tblords.chop}_qty"].to_f + rec["qty"].to_f
				else
					if  tblords == "shpords"
						outcnt,outqty,outamt = shpords_aud_rec(save_rec,outcnt,outqty,outamt)
					else
						if command_c["#{tblords.chop}_packqty"].to_f > 0 
							qty = (command_c["#{tblords.chop}_qty"].to_f / command_c["#{tblords.chop}_packqty"].to_f).ceil * command_c["#{tblords.chop}_packqty"].to_f
							saveqty = command_c["#{tblords.chop}_qty"] 
							command_c["#{tblords.chop}_qty"] = qty 
						else
							saveqty = qty = command_c["#{tblords.chop}_qty"] 
						end
						command_r,reqparams = RorBlkctl.  command_c,1,reqparams
						outcnt += 1
						outqty +=  command_c["#{tblords.chop}_qty"].to_f
					end
					command_c["#{tblords.chop}_duedate"] = rec["duedate"]
					command_c["#{tblords.chop}_qty"] = rec["qty"].to_f + saveqty - qty   ###過剰分の繰り越し
				end		
			else
				if command_c["#{tblords.chop}_qty"].to_f > 0 ###最初のレコードは除く
					if  tblords == "shpords"
						outcnt,outqty,outamt = shpords_aud_rec(save_rec,outcnt,outqty,outamt)
					else
						if command_c["#{tblords.chop}_packqty"].to_f > 0 
							command_c["#{tblords.chop}_qty"] = (command_c["#{tblords.chop}_qty"].to_f / command_c["#{tblords.chop}_packqty"].to_f).ceil * command_c["#{tblords.chop}_packqty"].to_f
						end
						command_r,reqparams = RorBlkctl.proc_private_aud_rec  command_c,1,nil,nil,reqparams
					end
				end
				strsql = %Q%select * from r_#{tblxxx} where id = #{rec["tblid"]}
				%
				command_c = ActiveRecord::Base.connection.select_one(strsql)
				command_c["#{tblords.chop}_id"] = command_c["id"] = ""
				command_c[:sio_code] =  "r_#{tblords}"
				command_c[:sio_viewname] =  "r_#{tblords}"
				command_c[:sio_message_contents] = nil
				command_c[:sio_recordcount] = 1
				command_c[:sio_result_f] =   "0"  
				command_c[:sio_classname] = "_add_ord_by_mkord"
				save_rec = rec.dup
			end
		end	 
		###最後のレコードの処理
		if command_c["#{tblords.chop}_qty"].to_f > 0
			if  tblords == "shpords"
				outcnt,outqty,outamt = shpords_aud_rec(save_rec,outcnt,outqty,outamt)
			else
				if command_c["#{tblords.chop}_packqty"].to_f > 0 
					command_c["#{tblords.chop}_qty"] = (command_c["#{tblords.chop}_qty"].to_f / command_c["#{tblords.chop}_packqty"].to_f).ceil * command_c["#{tblords.chop}_packqty"].to_f
				end
				command_r,reqparams = RorBlkctl.proc_private_aud_rec  command_c,1,nil,nil,reqparams
				outcnt += 1
				outqty +=  command_c["#{tblords.chop}_qty"].to_f
			end
		end
		return incnt, outcnt ,inqty ,outqty, inamt ,outamt
	end

	def shpords_aud_rec  save_rec,outcnt,outqty,outamt
		strsql = %Q%select trn.paretblname paretblname,trn.paretblid paretblid,trn.qty trn_qty,trn.qty_stk trn_qty_stk,
							shp.id shp_id,lot.qty lot_qty ,lot.qty_stk lot_qty_stk ,lot.lotno lot_lotno,lot.packno lot_packno,
							lot.shelfnos_id_in lot_shelfnos_id_in,shp.sno shp_sno
								from r_trngantts trn 
								inner join(alloctbls alloc inner join instks lot on alloc.id = lot.aloctbls_id ) 
											on trn.id = alloc.trngantts_id
								inner join shpschs shp on trn.paretblname = shp.paretblname and   trn.paretblid = shp.paretblid and  
											trn.itms_id = shp.itms_id and trn.processseq = shp.processseq
								where trn.paretblname = #{save_rec["paretblname"]} 
								   			trn.paretblid = #{save_rec["paretblid"]} and trn.itms_id = #{save_rec["itms_id"]} and 
											trn.processseq = #{save_rec["processseq"]} and alloc.qty_linkto_alloctbl = 0
		%
		ActiveRecord::Base.connection.select_all(strsql).each do |rec|
			if save["trn_qty"].to_f >= rec["lot_qty"].to_f 
					save_rec["qty"] = save_rec["qty"].to_f - rec["lot_qty"].to_f 
					qty =  rec["lot_qty"].to_f 
			else
					qty =  save_rec["qty"].to_f 	
					save_rec["qty"] = 0  ###他のshpに引きあたっている。
			end
			qty_stk = 0
			strsql = %Q%select * r_shpschs where id = #{save_rec["tblid"]}
			%
			shpsch = ActiveRecord::Base.connection.select_one(strsql)
			command_c = {}
			shpsch.each do |key,val|
				command_c[key.to_s.sub("shpsch_","shpord_")] = val
			end	
			strsql = %Q&select max(gno) gno,sum(qty) qty from shpords where gno like '#{proc_field_gno(save_rec["paretblid"].to_i)}%'
			&
			ord_gno = ActiveRecord::Base.connection.select_one(strsql)
			if ord_gno
				next if ord_gno["qty"].to_f >= rec["qty"].to_f 
				gno = org_gno["gno"][0..-3] + format('%02d',(ord_gno["gno"][-2..-1].to_i + 1)) ###出庫指示が分割されたとき
			else
				gno = proc_field_gno(save_rec["paretblid"].to_i) + "-00" 
			end
			command_c["shpord_id"] = command_c["id"] = ""
			command_c[:sio_code] =  "r_shpords"
			command_c[:sio_viewname] =  "r_shpords"
			command_c[:sio_message_contents] = nil
			command_c[:sio_recordcount] = 1
			command_c[:sio_result_f] =   "0"  
			command_c[:sio_classname] = "_add_shpord_by_mkord"
			command_c["shpord_sno_shpsch"] = command_c["shpord_sno"]
			command_c["shpord_sno"] = ""
			command_c["shpord_cno"] = ""
			command_c["shpord_gno"] = gno
			command_c["shpord_qty"] = qty
			command_c["shpord_qty_stk"] = qty_stk
			command_c["shpord_lotno"] = rec["lot_lotno"]
			command_c["shpord_packno"] = rec["lot_packno"]
			command_c["shpord_shelfno_id_fm"] = rec["lot_shelfnos_id_in"]  ###入力の棚が変更されたとき
			command_c,reqparams = RorBlkctl.  command_c,1,nil
			outcnt += 1
			outqty = outqty + command_c["shpord_qty"] + command_c["shpord_qty_stk"]
			outamt += command_c["shpord_amt"].to_f
			###prev_trngantts_update("sno","shpschs",rec["shp_sno"],qty,0,"0","shpords", command_c["id"])
		end
		return outcnt,outqty,outamt	
	end

	def proc_amtinouts(tblname,tblid,command_r,trngantts_id)	###未完成
		###  amt
		###  out
		amtinout = {}
		case tblname
		when /^pur/
			###purschs-->opeitm_loca_id    amtはlocas_id
			amtinout["locas_id_out"] = command_r["payment_loca_id_payment"]
			amtinout["locas_id_in"] = command_r["supplier_loca_id_supplier"]
			amtinout["starttime"]  = (command_r[tblname.chop+"_depdate"]||=command_r[tblname.chop+"_duedate"])
			amtinout["crrs_id"] = command_r[tblname.chop+"_crr_id_pur"]
		when /^insp/
			###purschs-->opeitm_loca_id 
			amtinout["locas_id_out"] = command_r["payment_loca_id_payment"]
			amtinout["locas_id_in"] = command_r["supplier_loca_id_supplier"]
			amtinout["starttime"]  = (command_r[tblname.chop+"_depdate"]||=command_r[tblname.chop+"_duedate"])
			amtinout["crrs_id"] = command_r[tblname.chop+"_crr_id_insp"]
		when /^prd/   
			amtinout["locas_id_out"] = command_r["opeitm_loca_id"] 
			amtinout["locas_id_in"] = command_r[tblname.chop+"_loca_id_to"]
			amtinout["starttime"]  = (command_r[tblname.chop+"commencementdate"]||=command_r[tblname.chop+"_starttime"])
		when /^shp/
			amtinout["locas_id_out"] = command_r["trngantt_loca_id_fm_shp"] 
			amtinout["starttime"]  = command_r[tblname.chop+"_depdate"]
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
		if command_r["opeitm_packqty"].to_f > 1
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
				stkinout["lotno"] = command_r["#{tblname.chop}_lotno"] = "dummy"
			else
				stkinout["lotno"] = command_r["#{tblname.chop}_lotno"] 
			end
			stkinout["packno"] = command_r["#{tblname.chop}_packno"] = "dummy"
		end
		return stkinout
	end

	def mk_outstks_rec stkinout,command_r,au ###opeitm_stktaking_proc,opeitm_packqty
		packnos = []
		idx = 1
		qty_stk = stkinout["qty_stk"].to_f
		packqty = command_r["opeitm_packqty"].to_f
		if au == "add"
			###old_alloc = {"qty_sch"=>0,"qty"=>0,"qty_stk"=>0,"srctblname"=>""} ### "srctblname"=>"":旧データなし又はsch,ords等で対応済
			if stkinout["packno"] == "packno" and qty_stk > 0
				stkinout["qty_stk"] = packqty 
				until qty_stk <= 0 do
					stkinout["packno"] = format('%03d', idx) 
					ActiveRecord::Base.connection.insert(outstk_strsql(stkinout)) 
					lotstkhists_in_out "out", stkinout  ###,old_alloc,""  ###新規登録のためテーブル情報は不要
					qty_stk -=  packqty 
					idx += 1
					packnos << stkinout["packno"]
				end
			else
				packnos << stkinout["packno"]
				ActiveRecord::Base.connection.insert(outstk_strsql(stkinout)) 
				lotstkhists_in_out "out", stkinout   ###,old_alloc,""
			end
		else
			strsql = %Q&select out.id,out.packno from outstks out
									inner join alloctbls alloc on alloc.id = out.alloctbls_id 
									where alloctbls_id = #{stkinout["alloctbls_id"]} and
										lotno = '#{stkinout["lotno"]}' 
										and inoutflg in('pur','prd','con')
										order by lotno,packno
										for update
			&	
			ActiveRecord::Base.connection.select_all(strsql).each do |rec|
					update_sql = %Q% update outstks set 
									----shelfnos_id_out = #{stkinout["shelfnos_id_out"]},
									starttime = '#{stkinout["starttime"]}',
									qty = #{stkinout["qty"]},
									qty_sch = #{stkinout["qty_sch"]},
									----lotno = '#{stkinout["lotno"]}',
									---inoutflg = '#{stkinout["inoutflg"]}',
									updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
									expiredate = '#{stkinout["expiredate"]}'
					%
				packnos << rec["packno"]
				if packqty  < qty_stk and qty_stk > 0
					qty_stk = packqty
				else
					qty_stk = 0
				end		
				###update_sql << " ,qty_stk = #{qty_stk.to_f},packno = '#{rec["packno"]}' where id = #{rec["id"]}"
				update_sql << " ,qty_stk = #{qty_stk.to_f} where id = #{rec["id"]}"
				ActiveRecord::Base.connection.update(update_sql) 
				stkinout["packno"] = rec["packno"]
				lotstkhists_in_out "out", stkinout   ###,old_alloc,""
				packnos << stkinout["packno"]
			end	
		end
		return  packnos,command_r
	end

	def mk_shpact_outstks_rec stkinout,command_r ###opeitm_stktaking_proc,opeitm_packqty
		packnos = []
		stkinout["lotno"] = command_r["lot_packno"] 
		stkinout["packno"] = command_r["shpact_packno"] 
		packno << command_r["shpact_packno"] 
		ActiveRecord::Base.connection.insert(outstk_strsql(stkinout)) 
		###old_alloc = {"qty_sch"=>0,"qty"=>0,"qty_stk"=>0,"srctblname"=>""} ### "srctblname"=>"":旧データなし又はsch,ords等で対応済
		lotstkhists_in_out "out", stkinout   ###,old_alloc,"shpacts"
		return  packnos,command_r
	end

	def outstk_strsql stkinout
		outstks_id = RorBlkctl.proc_get_nextval("outstks_seq")
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

	def mk_instks_rec stkinout,packnos,packqty,au
		if au == "add"
			packnos.each do |packno|
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
								'#{stkinout["lotno"]}','#{packno}','#{stkinout["inoutflg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','#{@sio_user_code||=0}','#{stkinout["expiredate"]}','')
					&
				ActiveRecord::Base.connection.insert(strsql) 
				###old_alloc = {"qty_sch"=>0,"qty"=>0,"qty_stk"=>0,"srctblname"=>""} ### "srctblname"=>"":旧データなし又はsch,ords等で対応済
				stkinout["packno"] = packno
				lotstkhists_in_out "in", stkinout   ###,old_alloc,""  ###新規登録のためテーブル情報は不要
			end	
		else	
			packnos.each do |packno|
				strsql = %Q%select * from instks where alloctbls_id = #{stkinout["alloctbls_id"]} 
										and lotno = '#{stkinout["lotno"]}' and packno = '#{packno}' 
										order by lotno,packno
										for update
				%	
				ActiveRecord::Base.connection.select_all(strsql).each do |rec|
					update_sql = %Q% update instks set 
									shelfnos_id_in = #{stkinout["shelfnos_id_in"]},
									starttime = '#{stkinout["starttime"]}',
									qty = #{stkinout["qty"].to_f },
									qty_sch = #{stkinout["qty_sch"]},
									qty_stk = #{stkinout["qty_stk"]},
									lotno = '#{stkinout["lotno"]}',inoutflg = '#{stkinout["inoutflg"]}',
									updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
									expiredate = '#{stkinout["expiredate"]}',
					%
					update_sql << " packno = '#{packno}'  where id = #{rec["id"]} "
					ActiveRecord::Base.connection.update(update_sql) 
					stkinout["packno"] = packno
					lotstkhists_in_out "in", stkinout   ###,old_alloc,""  ###新規登録のためテーブル情報は不要
				end	
			end
		end
	end

	def mk_incustwhs_rec stkinout,packnos,packqty,au  ###lotstkhistsは棚のみ
		if au == "add"
			packnos.each do |packno|
				instks_id = RorBlkctl.proc_get_nextval("incustwhs_seq")
				strsql = %Q&insert into incustwhs(id,alloctbls_id,custrcvplcs_id,
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
								'#{stkinout["lotno"]}','#{packno}','#{stkinout["inoutflg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','#{@sio_user_code||=0}','#{stkinout["expiredate"]}','')
				&
				ActiveRecord::Base.connection.insert(strsql)
			end
		else
			strsql = %Q%select * from incustwhs where alloctbls_id = #{stkinout["alloctbls_id"]} order by lotno,packno
										for update
			%
			ActiveRecord::Base.connection.select_all(strsql).each do |rec|	
				update_sql = %Q% update incustwhs set 
									shelfnos_id_in = #{stkinout["shelfnos_id_in"]},
									starttime = '#{stkinout["starttime"]}',
									qty = #{stkinout["qty"]},qty_sch = #{stkinout["qty_sch"]},
									lotno = '#{stkinout["lotno"]}',inoutflg = '#{stkinout["inoutflg"]}',
									updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
									expiredate = '#{stkinout["expiredate"]}',
				%
				packnos << rec["packno"]
				qty_stk = rec["qty_stk"].to_f
				if packqty  < qty_stk and qty_stk > 0
					qty_stk = packqty
				else
					qty_stk = 0
				end		
				update_sql << " qty_stk = #{qty_stk},packno = '#{packno}'  "
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
							where   itms_id = #{stkinout["itms_id"]} and
									processseq = #{stkinout["processseq"]} and
									prjnos_id = #{stkinout["prjnos_id"]} and  shelfnos_id = #{stk_shelfnos_id} and
									starttime = to_date('#{stkinout["starttime"]}','yyyy-mm-dd hh24:mi:ss') and 
									packno = '#{stkinout["packno"]}' and  lotno = '#{stkinout["lotno"]}' for update
			%
		lot = ActiveRecord::Base.connection.select_one(strsql)

		if lot
			strsql = %Q& update lotstkhists set  updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
							starttime = to_date('#{stkinout["starttime"]}','yyyy/mm/dd  hh24:mi:ss'),
							persons_id_upd = #{@sio_user_code||=0},
							qty_stk = #{lot["qty_stk"].to_f  + stkinout["qty_stk"].to_f * inout}  , 
							qty = #{lot["qty"].to_f  + stkinout["qty"].to_f * inout},
							qty_sch = #{lot["qty_sch"].to_f + stkinout["qty_sch"].to_f * inout} where id = #{lot["id"]}					
				&
			ActiveRecord::Base.connection.update(strsql)
		else	
			strsql = %Q% select qty_sch ,qty, qty_stk,id
								from lotstkhists
								where   itms_id = #{stkinout["itms_id"]} and
										processseq = #{stkinout["processseq"]} and
										prjnos_id = #{stkinout["prjnos_id"]} and  shelfnos_id = #{stk_shelfnos_id} and
										starttime < to_date('#{stkinout["starttime"]}','yyyy-mm-dd hh24:mi:ss') and 
										packno = '#{stkinout["packno"]}' and  lotno = '#{stkinout["lotno"]}'
										order by starttime desc limit 1
				%
			pre_lot = ActiveRecord::Base.connection.select_one(strsql)
			if pre_lot.nil?
				pre_lot = {"qty_sch"=>0,"qty"=>0,"qty_stk"=>0}
			end
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
									#{stkinout["qty_sch"].to_f * inout + pre_lot["qty_sch"].to_f},
									#{stkinout["qty_stk"].to_f * inout + pre_lot["qty_stk"].to_f},
									#{stkinout["qty"].to_f * inout + pre_lot["qty"].to_f},
									'#{stkinout["stktaking_proc"]}',
									to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
									to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
									' ',#{@sio_user_code||=0},'#{stkinout["expiredate"]}','')
			&
			ActiveRecord::Base.connection.insert(strsql) 
		end
		strsql = %Q% select id from lotstkhists
						where itms_id = #{stkinout["itms_id"]} and  lotno = '#{stkinout["lotno"]}' and 
								processseq = #{stkinout["processseq"]} and
								packno = '#{stkinout["packno"]}' and  shelfnos_id = #{stk_shelfnos_id} and
								prjnos_id = #{stkinout["prjnos_id"]}  and
								starttime > to_date( '#{stkinout["starttime"]}','yyyy/mm/dd hh24:mi:ss')
								for update
		%  ###該当日以降の在庫修正
		ActiveRecord::Base.connection.select_all(strsql).each do |futrec|
			strsql = %Q& update lotstkhists set  updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
												persons_id_upd = #{@sio_user_code||=0},
												qty_stk = #{stkinout["qty_stk"].to_f * inout + futrec["qty_stk"].to_f}  ,
												qty = #{stkinout["qty"].to_f * inout + futrec["qty"].to_f},
												qty_sch = #{stkinout["qty_sch"].to_f * inout + futrec["qty_sch"].to_f} where id = #{futrec["id"]}					
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

	def proc_consume_self_sch_parts rec,paretblname,parent   ###親がacts以外の時
		strsql = %Q%select instk.qty,instk.qty_stk,instk.qty_sch,instk.packno,instk.alloctbls_id alloc_id,
					trn.itms_id,trn.processseq,trn.prjnos_id,trn.expiredate,instk.shelfnos_id_in,alloc.srctblname,
					shelf.locas_id_shelfno shelf_loca_id
					from instks instk 
					inner join(alloctbls alloc inner join trngantts trn on trn.id =  alloc.trngantts_id)
					on alloc.id = instk.alloctbls_id 
					inner join shelfnos shelf on shelf.id =   shelfnos_id_in
					where  alloc.trngantts_id = #{rec["id"]} 
					and (instk.qty > 0 or instk.qty_sch >0 or instk.qty_stk > 0)
		%
		ActiveRecord::Base.connection.select_all(strsql).each do |stkinout|
			stkinout["inoutflg"] = "con"
			stkinout["alloctbls_id"] = stkinout["alloc_id"]
			case paretblname  ###消費場所
			when /^prd/
				if parent["workplace_loca_id_workplace"] == stkinout["shelf_loca_id"]
					stkinout["shelfnos_id_out"] = stkinout["shelfnos_id_in"]  ### 子部品を直接親のlocasに納入した時
				else	
					strsql = %Q%select id from shelfnos where code = 'consume' and locas_id_shelfno = #{parent["workplace_loca_id_workplace"]}
					%
					stkinout["shelfnos_id_out"] = ActiveRecord::Base.connection.select_value(strsql)
					stkinout["shelfnos_id_out"] ||= 0 
				end
			when /^pur/
				if parent["supplier_loca_id_supplier"] == stkinout["shelf_loca_id"]
					stkinout["shelfnos_id_out"] = stkinout["shelfnos_id_in"]  ### 子部品を直接親のlocasに納入した時
				else	
					strsql = %Q%select id from shelfnos where code = 'consume' and locas_id_shelfno = #{parent["supplier_loca_id_supplier"]}
					%
					stkinout["shelfnos_id_out"] = ActiveRecord::Base.connection.select_value(strsql)
					stkinout["shelfnos_id_out"] ||= 0 
				end
			else
				stkinout["shelfnos_id_out"] = 0
			end
			case paretblname    ###消費時期
			when /puracts/
				stkinout["starttime"] = parent[paretblname.chop+"_rcptdate"]
			when /prdacts/
				stkinout["starttime"] = parent[paretblname.chop+"_cmpldate"]
			else
				stkinout["starttime"] = parent[paretblname.chop+"_duedate"]
			end	
			case stkinout["srctblname"]   ###消費量
			when /schs$/
				stkinout["qty_sch"] = stkinout["qty"].to_f + stkinout["qty_sch"].to_f + stkinout["qty_stk"].to_f
				stkinout["qty"] = 0
				stkinout["qty_stk"] = 0
			when /ords$|insts$/
				stkinout["qty"] = stkinout["qty"].to_f + stkinout["qty_sch"].to_f + stkinout["qty_stk"].to_f
				stkinout["qty_sch"] = 0
				stkinout["qty_stk"] = 0
			when /acts$/
				stkinout["qty_stk"] = stkinout["qty"].to_f + stkinout["qty_sch"].to_f + stkinout["qty_stk"].to_f
				stkinout["qty_sch"] = 0
				stkinout["qty"] = 0
			else
				stkinout["qty"] = stkinout["qty_stk"] = stkinout["qty_sch"] =  0
			end		
			ActiveRecord::Base.connection.insert(outstk_strsql(stkinout))
			##old_alloc = {"qty_sch"=>0,"qty"=>0,"qty_stk"=>0,"srctblname"=>""} ### 旧データなし又はsch,ords等で対応済
			lotstkhists_in_out "out", stkinout   ###,old_alloc,paretblname
		end
	end

	def proc_consume_self_ord_parts stkinout ###親がacts,schs以外の時
		###親を求める。
		strsql = %Q%select s.id shelfno_id,s.duedate from #{stkinout["paretblname"]}
					#{case stkinout["paretblname"] 
						when /^prd/
							"inner join (workplaces w 
										inner join shelfnos s on w.locas_id_workplace = s.locas_id_shelfno 
													and w.code = 'consume')
									on workplaces.id = w.id	
										"
						when /^pur/
							"inner join (suppliers w 
										inner join shelfnos s on w.locas_id_supplier = s.locas_id_shelfno 
													and w.code = 'consume')
									on workplaces.id = w.id	
										"
						else
						end}
					where id = #{stkinout["paretblid"]}
			%	
		parent = ActiveRecord::Base.connection.select_one(strsql)
		stkinout["shelfnos_id_out"] = (parent["shelfno_id"]||=0)
		stkinout["inoutflg"] = "con"
		###消費時期
		stkinout["starttime"] = parent["duedate"]
		stkinout["qty"] = stkinout["qty"].to_f  + stkinout["qty_stk"].to_f
		stkinout["qty_sch"] = 0
		stkinout["qty_stk"] = 0
		ActiveRecord::Base.connection.insert(outstk_strsql(stkinout))
			##old_alloc = {"qty_sch"=>0,"qty"=>0,"qty_stk"=>0,"srctblname"=>""} ### 旧データなし又はsch,ords等で対応済
		lotstkhists_in_out "out", stkinout   ###,old_alloc,paretblname
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

	def prev_trngantts_update xno,prevtbl,val,qty,qty_stk,stktaking_proc,tblname,tblid,trngantts_id  ###新規の時

		trn_qty_linkto_alloctbl = 0
		trn_qty = 0
		prev_command ={}
		strsql = %Q%select * from r_#{tblname} where id = #{tblid}
				%
		tbl_command = ActiveRecord::Base.connection.select_one(strsql)
		strsql = %Q% select b.id prev_alloc_id,b.qty prev_alloctbl_qty,b.qty_stk prev_alloctbl_qty_stk,
						b.qty_linkto_alloctbl prev_alloctbl_qty_linkto_alloctbl,
						b.prevtbls_id prevtbls_id,
						a.tblname, a.id prev_trngantts_id,
						(case a.tblname when '#{prevtbl}' then '0' else '1' end) sort_no
						from trngantts a
						inner join (select x.*,y.id prevtbls_id from alloctbls x 
								inner join #{prevtbl} y	on x.srctblid = y.id and  y.#{xno} = '#{val}')  b
						on  a.id = b.trngantts_id
						---where  (b.qty_linkto_alloctbl < b.qty )
						order by sort_no,a.duedate for update
					%
		ActiveRecord::Base.connection.select_all(strsql).each do |prev|
			if prev_command == {}
				strsql = %Q%select * from r_#{prevtbl} where id = #{prev["prevtbls_id"]}
					%
				prev_command = ActiveRecord::Base.connection.select_one(strsql)
			end
			if tblname =~ /acts$/
				newstrqty = "qty_stk"
			else
				newstrqty = "qty"
			end
			if prevtbl =~ /acts$/
				oldstrqty = "qty_stk"
			else
				oldstrqty = "qty"
			end
			case prev["tblname"]
			when prevtbl  ###trnganttsの数量は変更しない。　
				prev_qty = prev["prev_alloctbl_qty"].to_f +  prev["prev_alloctbl_qty_stk"].to_f  ##qty又はqty_stkはzero
				tbl_qty = qty.to_f + qty_stk.to_f +  prev["prev_alloctbl_qty_linkto_alloctbl"].to_f 
				if prev_qty >= tbl_qty 
					fields ={:trngantts_id =>prev["prev_trngantts_id"],:srctblname =>prevtbl,:srctblid=>prev["prevtbls_id"],
					:qty=>prev["prev_alloctbl_qty"].to_f + qty,:qty_stk=>prev["prev_alloctbl_qty_stk"].to_f + qty_stk,:qty_alloc=>0,
					:qty_linkto_alloctbl=>tbl_qty}  ###prevtbl=tbl=orgtbl
					### qty又はqty_stkはzero
					add_update_alloctbls fields,prev_command
				end
				###

			when /schs$/
				###trnganttsは何もしない。
				fields ={:trngantts_id =>prev["prev_trngantts_id"],:srctblname => prevtbl,:srctblid=>prev["prevtbls_id"],
					:qty=>prev["prev_alloctbl_qty"],:qty_stk=>prev["prev_alloctbl_qty_stk"],:qty_alloc=>0,
					:qty_linkto_alloctbl=>prev["prev_alloctbl_qty_linkto_alloctbl"].to_f + 
											prev["prev_alloctbl_qty"].to_f + prev["prev_alloctbl_qty_stk"].to_f}
					### qty又はqty_stkはzero
				add_update_alloctbls fields,prev_command	###引き当て済に変更
				###
				if qty >= prev["prev_alloctbl_qty"].to_f
					newqty = prev["prev_alloctbl_qty"].to_f
					qty = qty -  prev["prev_alloctbl_qty"].to_f
				else
					newqty = qty
					qty = 0
				end	
				if qty_stk >= prev["prev_alloctbl_qty_stk"].to_f
					newqty_stk = prev["prev_alloctbl_qty_stk"].to_f
					qty_stk = qty_stk -  prev["prev_alloctbl_qty_stk"].to_f
				else
					newqty_stk = qty_stk
					qty_stk = 0
				end	
				fields ={:trngantts_id =>prev["prev_trngantts_id"],:srctblname =>tblname,:srctblid=>tblid,
					:qty=>newqty ,:qty_stk=>newqty_stk,
					:qty_alloc=>0,:qty_linkto_alloctbl=>0}  ###qtyとqty_stkとは入れ替わる可能性がある。qtyとqty_stkのどちらかはzero
					### qty又はqty_stkはzero
				add_update_alloctbls fields,tbl_command   ###新たなalloctbl
			end
			break if qty <= 0 and qty_stk <= 0
		end	
	end

	def cal_pare_qty_dataprecision fields,rec  ###確認中
		pare_opeitm = proc_get_opeitms_rec rec["itms_id_pare"],nil,rec["processseq_pare"],nil 
		qty_pare = fields[:qty].to_f / rec["chilnum"].to_f * rec["parenum"].to_f
		strsql = %Q%select	 dataprecision from units where id = #{pare_opeitm["units_id_prdpurshp"]}
				 %
		dataprecision = ActiveRecord::Base.connection.select_value(strsql) 
		fields[:qty_pare] = (qty_pare*10**dataprecision.to_i).to_i / 10**dataprecision.to_i
		return  fields
	end

	def cal_pare_qty fields,rec  ###確認中
		pare_opeitm = proc_get_opeitms_rec rec["itms_id_pare"],nil,rec["processseq_pare"],nil 
		fields[:qty_pare] = fields[:qty].to_f / rec["chilnum"].to_f * rec["parenum"].to_f
		return  fields
	end

	def cal_qty_dataprecision fields,trn,rec  ###確認中
		pare_opeitm = proc_get_opeitms_rec rec["itms_id_pare"],nil,rec["processseq_pare"],nil 
		fields[:qty_pare] = trn["qty"].to_f / rec["chilnum"].to_f * rec["parenum"].to_f
		##if pare_opeitm["packqty"] > 0  ##まとまるのは発注又は製造単位　引き当て単位ではない。
		##	float = fields[:qty_pare] / pare_opeitm["packqty"]
		##		fields[:qty_pare] = float.to_i * pare_opeitm["packqty"]
		##		trn["qty"]  = fields[:qty_pare] * rec["chilnum"].to_f / rec["parenum"].to_f
		##else
			##if (fields[:qty_pare] - fields[:qty_pare].to_i) > 0
				 strsql = %Q%select	 dataprecision from units where id = #{pare_opeitm["units_id_prdpurshp"]}
				 %
				 dataprecision = ActiveRecord::Base.connection.select_value(strsql) 
				 fields[:qty_pare] = (fields[:qty_pare]*10**dataprecision.to_i).to_i / 10**dataprecision.to_i

				 opeitm = proc_get_opeitms_rec rec["itms_id"],nil,rec["processseq"],nil 
				 strsql = %Q%select	 dataprecision from units where id = #{opeitm["units_id_prdpurshp"]}
				 %
				 dataprecision = ActiveRecord::Base.connection.select_value(strsql) 
				 qty = (fields[:qty]*10**dataprecision.to_i).to_i / 10**dataprecision.to_i

			##end
		###end
		return  fields,trn,rec
	end

	def rinout_to_inout stk,r_inout  ###
			stkinout = {}
			stkinout["shelfnos_id_out"] = r_inout["outstk_shelfno_id_out"]
			stkinout["shelfnos_id_in"] = r_inout["instk_shelfno_id_in"]
			stkinout["qty_stk"] = r_inout["#{stk}_qty_stk"]
			stkinout["qty"] = r_inout["#{stk}_qty"]
			stkinout["itms_id"] = r_inout["trngantt_itm_id"]
			stkinout["lotno"] = r_inout["#{stk}_lotno"]
			stkinout["processseq"] = r_inout["trngantt_processseq"]
			stkinout["packno"] =  r_inout["#{stk}_packno"]
			stkinout["prjnos_id"] = r_inout["trngantt_prjno_id"]
			stkinout["starttime"] = r_inout["#{stk}_starttime"]
			stkinout["expiredate"] = r_inout["#{stk}_expiredate"]
			return stkinout
	end
	
	def add_stkinouts(fields,command_r,au)  ###au--> add or update
		tblname = fields[:srctblname]
		stkinout = {}
		stkinout["expiredate"] = command_r[tblname.chop+"_expiredate"]
		stkinout =  lotno_set(tblname,stkinout,command_r) 
		stkinout["alloctbls_id"] = fields[:alloctbls_id]
		stkinout["processseq"] = command_r["opeitm_processseq"]
		stkinout["itms_id"] = command_r["opeitm_itm_id"]
		stkinout["stktaking_proc"] = command_r["opeitm_stktaking_proc"]
		stkinout["prjnos_id"] = command_r[tblname.chop+"_prjno_id"]
		stkinout["inoutflg"] = tblname[0..2]
		case tblname
		###  stk
		###  out
		when /^pur|^insp/  ###shelfnos_id = 0は必須
			case tblname ###purschs-->opeitm_loca_id 
				when /^pur/
					strsql = %Q%select id from shelfnos where locas_id_shelfno  = #{command_r["supplier_loca_id_supplier"]}
						%
					id = ActiveRecord::Base.connection.select_value(strsql)
				when /^insp/
					id = command_r[tblname.chop+"_shelfno_id_to"] 
			end
			id ||= 0 
			stkinout["shelfnos_id_out"] = id 
			case tblname
				when /purschs|purords/
					stkinout["starttime"]  = (Date.strptime(command_r[tblname.chop+"_duedate"].gsub("/","-"),'%Y-%m-%d') - 1).to_s
				when /purinsts/
					stkinout["starttime"]  = (Date.strptime(command_r["purinst_replydate"].gsub("/","-"),'%Y-%m-%d') - 1).to_s
				when /purdlvs/
					stkinout["starttime"]  = command_r["purdlv_depdate"]
				when /puracts$/
					if command_r["puract_sno_purdlv"] == ""
						stkinout["starttime"]  = (Date.strptime(command_r["puract_rcptdate"].gsub("/","-"),'%Y-%m-%d') - 1).to_s
					end
			end
		when /^prd/   ###commencementdate 作業開始
			strsql = %Q% select id from shelfnos where locas_id_shelfno  = #{command_r["workplace_loca_id_workplace"]}
					%
			id = ActiveRecord::Base.connection.select_value(strsql) 
			id ||= 0
			stkinout["shelfnos_id_out"] = id
			case tblname
				when /schs$|ords$/
					stkinout["starttime"]  = command_r[tblname.chop+"_duedate"] 
				when /insts$/
					stkinout["starttime"]  = command_r[tblname.chop+"_commencementdate"]
				when /acts$/
					stkinout["starttime"]  = command_r[tblname.chop+"_cmpldate"]
			end
			stkinout["processseq"] = command_r["opeitm_processseq"]
		when /^shp/
			stkinout["shelfnos_id_out"] = command_r[tblname.chop+"_shelfno_id_fm"] 
			stkinout["starttime"]  = command_r[tblname.chop+"_depdate"]
			stkinout["processseq"] = command_r["trngantt_processseq"]
		when /^cust/  ###shelfnos_id = 0は必須
			case tblname ###
				when /schs$|ords$/
					stkinout["shelfnos_id_out"] = command_r["opeitm_shelfno_id"]
				when /insts$|dlvs$|acts$/
					stkinout["shelfnos_id_out"] = command_r[tblname.chop+"_shelfno_id_to"]
			end
			stkinout["processseq"] = command_r["opeitm_processseq"]
			case tblname
				when /schs$|ords$|inst$/
					stkinout["starttime"]  = (Date.strptime(command_r[tblname.chop+"_duedate"].gsub("/","-"),'%Y-%m-%d') - 1).to_s
				when /dlvs$/
					stkinout["starttime"]  = command_r[tblname.chop+"_depdate"]
				when /acts$/
					if command_r["puract_sno_purdlv"] == ""
						stkinout["starttime"]  = (Date.strptime(command_r[tblname.chop+"_rcptdate"].gsub("/","-"),'%Y-%m-%d') - 1).to_s
					end
			end
		end

		case  tblname
		when 	/schs$/   ###pur,prdではqtyとqty_schの区別はしてない。
			stkinout["qty"] = stkinout["qty_stk"] = 0
			stkinout["qty_sch"] = fields[:qty].to_f - fields[:qty_linkto_alloctbl].to_f - fields[:qty_alloc].to_f
		when /acts$/
			stkinout["qty"] = stkinout["qty_sch"] = 0
			stkinout["qty_stk"] = fields[:qty_stk].to_f - fields[:qty_linkto_alloctbl].to_f - fields[:qty_alloc].to_f
		else
			stkinout["qty_stk"] = 0
			stkinout["qty_sch"] = 0
			stkinout["qty"] =  fields[:qty].to_f - fields[:qty_linkto_alloctbl].to_f - fields[:qty_alloc].to_f
		end	
		##
		if tblname == "puracts" and !command_r["puract_sno_purdlv"].nil? and command_r["puract_sno_purdlv"] != ""
			### stk-in purdlvを使用
		else
			if 	tblname == "shpacts"
				packnos,command_r = mk_shpact_outstks_rec stkinout,command_r,au
			else
				packnos,command_r = mk_outstks_rec stkinout,command_r,au
			end
		end
		
		###  stk
		###  in
		packqty = command_r["opeitm_packqty"].to_f
		case tblname
			when /^pur|^insp/
				case tblname
					when /purschs|purords/
						stkinout["starttime"]  = command_r[tblname.chop+"_duedate"]
					when /purinsts/
						stkinout["starttime"]  = command_r["purinst_replydate"]
					when /puracts/
						stkinout["starttime"]  = command_r["puract_rcptdate"]
					when /purdlvs/
						stkinout["starttime"]  =  (Date.strptime(command_r["purdlv_depdate"].gsub("/","-"),'%Y-%m-%d')  + 1).to_s
				end
				stkinout["shelfnos_id_in"] = command_r[tblname.chop+"_shelfno_id_to"]
				mk_instks_rec stkinout,packnos,packqty,au
			when /^prd/
				case tblname
					when /schs$|ords$/
						stkinout["starttime"]  = command_r[tblname.chop+"_duedate"] 
					when /insts$/
						stkinout["starttime"]  = command_r[tblname.chop+"_commencementdate"]
					when /acts$/
						stkinout["starttime"]  = command_r[tblname.chop+"_cmpldate"]
				end
				stkinout["shelfnos_id_in"] = command_r[tblname.chop+"_shelfno_id_to"]
				mk_instks_rec stkinout,packnos,packqty,au
			when /^shp/
				stkinout["starttime"]  = command_r[tblname.chop+"_duedate"]
				strsql = %Q%select id from r_shelfnos where shelfno_loca_id_shelfno = #{command_r[tblname.chop+"_loca_id_to"]}
														and loca_code = shelfno_code
				%  ###作業場所、外注先に棚は必須(loca_code=棚code)
				shelfnos_id_in =  ActiveRecord::Base.connection.select_value(strsql)  
				shelfnos_id_in ||= 0
				stkinout["shelfnos_id_in"] = shelfnos_id_in
				mk_instks_rec stkinout,packnos,packqty,au
			when /^cust/
				stkinout["duedate"]  = command_r[tblname.chop+"_duedate"]
				stkinout["custrcvplcs_id"]  = command_r[tblname.chop+"_custrcvplc_id"]
				mk_incustwhs_rec stkinout,packnos,packqty,au
		end
	end

	def proc_trngantts tblname,tblid,paretblname,paretblid,reqparams
		tbldata = reqparams["tbldata"]
		strsql = %Q% select * from trngantts where tblname = '#{tblname}' and tblid = #{tblid}
					  and orgtblname = paretblname and paretblname = tblname
					  and orgtblid = paretblid and paretblid = tblid
		%
		rec = ActiveRecord::Base.connection.select_one(strsql)
		if rec.nil?  ###trngantts 追加
			if tblid.to_i == paretblid.to_i and tblname == paretblname ###新規本体を作成
				trngantts_id,reqparams = init_trngantts_add_detail(tblname,tblid,paretblname,paretblid,reqparams)	
			else ###構成の一部になっているとき(本体を作成後確認)
				trngantts_id,reqparams = child_trngantts(tblname,tblid,reqparams)  
			end	
			reqparams["trngantts_id"] =  trngantts_id
			tbldata.each do |key,val|   ###前の状態のtrn変更
				if key =~ /^sno_|^cno_/ and val  ##gnoはレコードをまとめるもので前の状態変化には使用できない。
					if val.size > 0
						xno = key.to_s.split("_")[0] 
						prevtbl = key.to_s.split("_")[1] + "s"
						if tbldata["qty"]  
							qty = tbldata["qty"].to_f  
							qty_stk = 0
						else
							qty_stk =  tbldata["qty_stk"].to_f  
							qty = 0
						end
						strsql = %Q% select stktaking_proc from opeitms where  id = #{tbldata["opeitms_id"]} %
						stktaking_proc = ActiveRecord::Base.connection.select_value(strsql)
						prev_trngantts_update(xno,prevtbl,val,qty,qty_stk,stktaking_proc,tblname,tblid,trngantts_id)
						sw = false
						break
					end	
				end	
			end	
			reqparams["trngantts_id"] = trngantts_id
		else ###trngantts 変更
			qty = (tbldata["qty"]||=0)
			qty_stk = (tbldata["qty_stk"]||=0)
			fields = {:srctblname=>tblname,:srctblid=>tblid,:trngantts_id=>rec["id"],
						:qty=>qty,:qty_stk=>qty_stk,:qty_alloc=>0}
			if rec["qty"].to_f == qty.to_f and  rec["qty_stk"].to_f == qty_stk.to_f
				###日付の変更
			else
				strsql = %Q&update trngantts set updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
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
										:qty_linkto_alloctbl=>srctblqty}
							add_update_alloctbls fields,command_r
							strsql = %Q%select * from trngantts where id = #{rec["trngantts_id"]}
							%
							trn = ActiveRecord::Base.connection.update(strsql)
							strsql = %Q&update trngantts set updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
											qty_linkto_alloctbl = #{trn["qty_linkto_alloctbl"].to_f - (alloc["qty_linkto_alloctbl"].to_f - srctblqty) } ,
											remark = '1963'	where  id = #{rec["trngantts_id"]} &
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
		return reqparams
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