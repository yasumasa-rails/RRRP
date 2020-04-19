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

	def init_trngantts_add_detail   tblname,tblid,reqparams
		tbldata = reqparams["tbldata"]
		orgtblname = reqparams["orgtblname"]
		orgtblid = reqparams["orgtblid"]
		paretblname = reqparams["paretblname"]
		paretblid = reqparams["paretblid"]
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
		pare_opeitm = ActiveRecord::Base.connection.select_one(strsql)
		case tblname
		when /^purinsts/
			tbldata["starttime"] = tbldata["duedate"] = tbldata["replydate"]
		when /^puracts/
			tbldata["starttime"] = tbldata["duedate"] = tbldata["rcptdate"]
		when /^custschs/
			tbldata["shelfnos_id_to"] = opeitm["shelfnos_id"]  ###shelfnos_id_fm:親がこの子部品をどこからとってくるか
			tbldata["starttime"] = (tbldata["duedate"].to_date - 1).strftime("%Y-%m-%d %H:%M:%S")
		when /^custords/
			tbldata["shelfnos_id_to"] = opeitm["shelfnos_id"]  ###shelfnos_id_fm:親がこの子部品をどこからとってくるか
			tbldata["starttime"] = (tbldata["duedate"].to_date - 1).strftime("%Y-%m-%d %H:%M:%S")
		end

		trn = {}
		trn["key"] = (reqparams["trnganttkey"]||="00000")
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
		trn["consumunitqty"] = (child["consumunitqty"]||=0) 
		trn["consumminqty"]  = (child["consumminqty"]||=0) 
		trn["consumchgoverqty"] = (child["consumchgoverqty"]||=0)
		trn["starttime"] = tbldata["starttime"]
		trn["duedate"] = trn["duedate_org"] = tbldata["duedate"]
		trngantts_id = RorBlkctl.proc_get_nextval("trngantts_seq")
		trn["trngantts_id"] = trn["id"] = trngantts_id
		trn["remark"] = "88"
		insert_trngantt trn

		rec = {}
		rec["id"] = RorBlkctl.proc_get_nextval("alloctbls_seq")
		rec["srctblname"] = tblname
		rec["srctblid"] = tblid
		rec["trngantts_id"] = trngantts_id 
		rec["qty"] = qty
		rec["qty_linkto_alloctbl"] = 0
		rec["remark"] = "97"
		insert_alloctbls rec

		
		strsql = %Q%select * from r_#{tblname} where id = #{tblid}
		%
		command_r = ActiveRecord::Base.connection.select_one(strsql)
		command_r["#{trn["orgtblname"].chop}_qty"] = trn["qty"] 
		command_r["#{trn["orgtblname"].chop}_qty_pare"] = trn["qty_pare"] 
		command_r["#{trn["orgtblname"].chop}_qty_stk"] = trn["qty_stk"] 
		add_stkinouts(trn["orgtblname"],trn["orgtblid"],command_r,rec["id"])

		strsql = %Q%select * from r_#{tblname} where id = #{tblid}
		%
		command_r = ActiveRecord::Base.connection.select_one(strsql)
		if tblname =~ /purords|prdords/
			reqparams["trngantts_id"] = trngantts_id
			free_ordtbl_to_alloc trn,reqparams
		end
		return  trngantts_id
	end

	def proc_add_alloc_and_trn free,trn
		strsql = %Q%select  id,qty_linkto_alloctbl from alloctbls 
												where srctblname = '#{free["orgtblname"]}' and srctblid = '#{free["orgtblid"]}' 
												and trngantts_id = #{trn["id"]} 
		%
		rec = ActiveRecord::Base.connection.select_one(strsql)
		if rec 
			qty = rec["qty_linkto_alloctbl"].to_f +  free["qty_linkto_alloctbl"].to_f
			strsql = %Q%update alloctbls set updated_at =to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								qty_linkto_alloctbl = #{qty},where id = #{rec["id"]}
			%
			ActiveRecord::Base.connection.update(strsql)
		else
			rec = {}
			rec["id"] = RorBlkctl.proc_get_nextval("alloctbls_seq")
			rec["srctblname"] = free["orgtblname"]
			rec["srctblid"] = free["orgtblid"]
			rec["trngantts_id"] = trn["id"]
			rec["qty"] = 0
			rec["qty_linkto_alloctbl"] = free["qty_linkto_alloctbl"]
			rec["remark"] = "138"
			insert_alloctbls rec
		end
		strsql = %Q%select * from r_#{free["orgtblname"]} where id = #{free["orgtblid"]}
		%
		command_r = ActiveRecord::Base.connection.select_one(strsql)
		command_r["#{free["orgtblname"].chop}_qty"] = free["qty"] if command_r["#{free["orgtblname"].chop}_qty"] 
		command_r["#{free["orgtblname"].chop}_qty_pare"] = free["qty_pare"] if command_r["#{free["orgtblname"].chop}_qty_pare"] 
		command_r["#{free["orgtblname"].chop}_qty_stk"] = free["qty_stk"] if command_r["#{free["orgtblname"].chop}_qty_stk"] 
		add_stkinouts(free["orgtblname"],free["orgtblid"],command_r,rec["id"])
		return
	end
	
	def insert_trngantt trn
		strsql = %Q%
		insert into trngantts(id,key,
							orgtblname,orgtblid,paretblname,paretblid,
							tblname,tblid,
							mlevel,
							shuffle_flg,
							parenum,chilnum,
							qty,qty_stk,qty_alloc,qty_linkto_alloctbl,
							qty_pare,qty_stk_pare,qty_pare_alloc,
							itms_id,processseq,shelfnos_id_fm,prjnos_id,
							itms_id_pare,processseq_pare,locas_id_pare,
							consumunitqty,consumminqty,consumchgoverqty,
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
							#{trn["qty"]},#{trn["qty_stk"]},#{trn["qty_alloc"]},#{trn["qty_linkto_alloctbl"]},
							#{trn["qty_pare"]},#{trn["qty_stk_pare"]},#{trn["qty_pare_alloc"]},
							#{trn["itms_id"]},#{trn["processseq"]},#{trn["shelfnos_id_fm"]},#{trn["prjnos_id"]},
							#{trn["itms_id_pare"]},#{trn["processseq_pare"]},#{trn["locas_id_pare"]},
							#{trn["consumunitqty"]},#{trn["consumminqty"]},#{trn["consumchgoverqty"]},
							to_timestamp('#{trn["starttime"]}','yyyy-mm-dd hh24:mi:ss'),
							to_timestamp('#{trn["duedate"]}','yyyy-mm-dd hh24:mi:ss'),
							to_timestamp('#{trn["duedate_org"]}','yyyy-mm-dd hh24:mi:ss'),
							to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
							to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
							' ','0','2099/12/31',#{trn["remark"]})
		%
		ActiveRecord::Base.connection.insert(strsql)
		return
	end

	def alloctbls_insert_update rec
		strsql = %Q% select * from alloctbls where srctblname = '#{rec["srctblname"]}' and srctblid = #{rec["srctblid"]}
						and trngantts_id = #{rec["trngantts_id"]}
		%
		alloc = ActiveRecord::Base.connection.select_one(strsql)
		if alloc
			strsql = %Q% update alloctbls set updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
							qty_alloc  = #{rec["qty_alloc"]} 	and id = #{alloc["id"]}
			%
			ActiveRecord::Base.connection.update(strsql)
		else	
			rec["remark"] = "203"
			insert_alloctbls rec
		end	
	end

	def insert_alloctbls trn
		strsql = %Q%
		insert into alloctbls(id,
							srctblname,srctblid,
							trngantts_id,
							qty,
							qty_linkto_alloctbl,
							created_at,
							updated_at,
							update_ip,persons_id_upd,expiredate,remark)
					values(#{trn["id"]},
							'#{trn["srctblname"]}',#{trn["srctblid"]},
							#{trn["trngantts_id"]},
							#{trn["qty"]},
							#{trn["qty_linkto_alloctbl"]},
							to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
							to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
							' ','0','2099/12/31','#{trn["remark"]}')
		%
		ActiveRecord::Base.connection.insert(strsql)
		return
	end

	def schstbl_alloc_to_freetbl  tblname,tblid,reqparams
		tbldata = reqparams["tbldata"]
		opeitm = reqparams["opeitm"]
		###freeを探す
		strsql = %Q%select locas_id_shelfno from shelfnos where id = #{opeitm["shelfnos_id"]}
		%
		locas_id_shelfno =  ActiveRecord::Base.connection.select_value(strsql)

		strsql = %Q&select
						case
						when a.qty_stk >  a.qty_alloc
							then '02' 
						when  a.duedate <= to_date('#{tbldata["duedate"]}','yyyy/mm/dd')
							then '01'	
						else
							'03' end  priority,
						to_number(to_char(duedate,'yyyymmdd'),'99999999')*-1 due,a.* from trngantts a
						inner join shelfnos c on  a.shelfnos_id_fm = c.id
						where a.prjnos_id =  #{tbldata["prjnos_id"]}
							and a.orgtblname = a.paretblname and a.paretblname = a.tblname
							and a.orgtblid = a.paretblid  and a.paretblid = a.tblid
							and  a.itms_id = #{opeitm["itms_id"]} and a.processseq = #{opeitm["processseq"]}
							and c.locas_id_shelfno = #{locas_id_shelfno}
							and (a.tblname like '%ords' or a.tblname like '%insts' or a.tblname like '%acts')
							and (a.tblname like 'prd%' or  a.tblname like 'pur%')
							and (a.qty - a.qty_linkto_alloctbl) >  0 ---- free trnではfree["qty_alloc"].to_f==0 
							order by priority,due
							for update
							&
		frees = ActiveRecord::Base.connection.select_all(strsql)   ### free trnではfree["qty_alloc"].to_f==0 

		####引き当てられる側
		strsql = %Q% select * from trngantts where id = #{reqparams["trngantts_id"]} %
		rec =  ActiveRecord::Base.connection.select_one(strsql)
	
		if rec["qty"].to_f > rec["qty_stk"].to_f  ###在庫の判断  混在はない。
			sym = "qty"
		else 
			sym = "qty_stk"
		end

		total_alloc_qty = rec["qty_linkto_alloctbl"].to_f
		bal_free_qty = 0
		frees.each do |free|
			save_alloc_qty_of_free =  free["qty_linkto_alloctbl"].to_f  ### free trnではfree["qty_alloc"].to_f==0 
			if free["qty"].to_f  > free["qty_stk"].to_f  ###在庫の判断
				qty_or_stk = "qty"
			else
				qty_or_stk = "qty_stk"
			end
			bal_free_qty = free[qty_or_stk].to_f - save_alloc_qty_of_free
			qty =  (rec[sym].to_f - rec["qty_alloc"].to_f - rec["qty_linkto_alloctbl"].to_f)
			if bal_free_qty >= qty
				free["qty_linkto_alloctbl"] = qty
				proc_add_alloc_and_trn free,rec   ###引きあたったalloc作成
				total_alloc_qty += qty
				strsql = %Q%update  trngantts set updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'), 
												qty_linkto_alloctbl = #{rec["qty_linkto_alloctbl"].to_f + qty},				
												remark = '285' where id = #{free["id"]}
								%
			else
				free["qty_linkto_alloctbl"] =  bal_free_qty
				proc_add_alloc_and_trn free,rec ###引きあたったalloc作成
				total_alloc_qty += bal_free_qty
				strsql = %Q%update  trngantts set updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
									 qty_linkto_alloctbl = #{save_alloc_qty_of_free + bal_free_qty} ,				
									remark = '293' where id = #{free["id"]}	%
			end
			ActiveRecord::Base.connection.update(strsql)  ###freeの引き当て数変更
			break if (total_alloc_qty + rec["qty_alloc"].to_f) >= rec[sym].to_f
		end
		if total_alloc_qty > 0
			fields = {:qty_linkto_alloctbl=>total_alloc_qty,
							:qty_alloc=>rec["qty_alloc"].to_f,:qty_pare_alloc=>rec["qty_pare_alloc"].to_f }
			free_ordtbl_to_alloc_child rec,fields  ###freeのxxxordsテーブルに引きあたった子部品を引き当て済にする。
		end
		return
	end	

	def free_ordtbl_to_alloc  free,reqparams  ###freeで登録されたordを引き当てる。free:orgtblid=paretblid=tblid
		tbldata = reqparams["tbldata"]
		opeitm = reqparams["opeitm"]
		if free["qty"].to_f > free["qty_stk"].to_f
			sym = "qty"
		else
			sym = "qty_stk"
		end	
		bal_free_qty = free[sym].to_f ### qty_alloc ,qty_linkto_alloctblはzero 新規のため
		strsql = %Q%select locas_id_shelfno from shelfnos where id = #{opeitm["shelfnos_id"]}
		%  ### free trn org=pare=tbl では qty_linkto_alloctbl
		locas_id_shelfno =  ActiveRecord::Base.connection.select_value(strsql)
		strsql = %Q&select '01' priority,to_number(to_char(duedate,'yyyymmdd'),'99999999')*-1 due,a.* from trngantts a
						inner join shelfnos c on  a.shelfnos_id_fm = c.id
						where a.prjnos_id =  #{tbldata["prjnos_id"]}
							and  a.paretblid != a.tblid and a.tblname like '%schs'
							and  a.itms_id = #{opeitm["itms_id"]} and a.processseq = #{opeitm["processseq"]}
							and c.locas_id_shelfno = #{locas_id_shelfno}
							and (a.qty - a.qty_alloc - a.qty_linkto_alloctbl) > 0 
					order by priority,duedate for update
		&
		bal_alloc_qty = 0
		ActiveRecord::Base.connection.select_all(strsql).each do |sch|
			bal_alloc_qty = sch["qty"].to_f - sch["qty_alloc"].to_f - sch["qty_linkto_alloctbl"].to_f
			if bal_alloc_qty < bal_free_qty
				free["qty_linkto_alloctbl"] = bal_alloc_qty   ### free["qty_linkto_alloctbl"].to_f  == 0のはず 新規登録のため
				proc_add_alloc_and_trn free,sch ###引きあたったalloc作成
				fields = {:qty_linkto_alloctbl=>sch["qty_linkto_alloctbl"].to_f +  bal_alloc_qty }
				free_ordtbl_to_alloc_child sch,fields  ###freeのxxxordsテーブルを他のオーだのもとにあるxxxschsに引き当てる。
				strsql = %Q%update  trngantts set  qty_linkto_alloctbl = #{free["qty_linkto_alloctbl"].to_f},
									remark = '342'
									where  id = #{free["id"]}
				%
				ActiveRecord::Base.connection.update(strsql)
				strsql = %Q% select * from alloctbls where trngantts_id = #{sch["id"]} %
				alloc =  ActiveRecord::Base.connection.select_one(strsql)
				fields = {:qty => 0,:qty_linkto_alloctbl=>0} 
				key = {:id => alloc["id"]}
				update_alloctbls_inout fields,key   ###前のレコード(引き当てられた)schs変更を変更してin-outの情報を変更
			else
				free["qty_linkto_alloctbl"] = bal_free_qty  ### 
				proc_add_alloc_and_trn free,sch ###引きあたったalloc作成 ### free["qty_linkto_alloctbl"].to_f  == 0のはず 新規登録のため
				fields = {:qty_linkto_alloctbl=>bal_free_qty + sch["qty_linkto_alloctbl"].to_f}
				free_ordtbl_to_alloc_child sch,fields  ###freeのxxxordsテーブルを他のオーだのもとにあるxxxschsに引き当てる。
				strsql = %Q%update  trngantts set  qty_linkto_alloctbl = #{free["qty_linkto_alloctbl"].to_f},
									remark = '358'
				 					where  id = #{free["id"]}
				%
				ActiveRecord::Base.connection.update(strsql)
				strsql = %Q% select * from alloctbls where trngantts_id = #{sch["id"]} %
				alloc =  ActiveRecord::Base.connection.select_one(strsql)
				fields = {:qty=>bal_alloc_qty - bal_free_qty ,:qty_linkto_alloctbl=>bal_alloc_qty - bal_free_qty} 
				key = {:id =>alloc["id"]}
				update_alloctbls_inout fields,key   ###引き当て前のレコードのinoutを変更
				bal_free_qty = 0
			end
		end
		return
	end	

	###下位の構成の員数変更	
	def free_ordtbl_to_alloc_child alloc,fields    ###日付変更の対応が未だ
		if fields[:qty_alloc]
			strsql = %Q%update  trngantts set updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						 qty_alloc = #{fields[:qty_alloc]},qty_pare_alloc = #{fields[:qty_pare_alloc]},
						qty_linkto_alloctbl = #{fields[:qty_linkto_alloctbl]},remark = '362' where  id = #{alloc["id"]}%
		else
			strsql = %Q%update  trngantts set updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
										qty_linkto_alloctbl = #{fields[:qty_linkto_alloctbl]},remark = '362' where  id = #{alloc["id"]}%
		end
		ActiveRecord::Base.connection.update(strsql)
		strsql = %Q%select * from trngantts where orgtblname = '#{alloc["orgtblname"]}' and orgtblid = #{alloc["orgtblid"]}
											and  paretblname = '#{alloc["tblname"]}' and paretblid = #{alloc["tblid"]}
											and qty > 0 for update
		%
		ActiveRecord::Base.connection.select_all(strsql).each do |child| ###下位構成の引き当てなおし
			qty = 0  ####qty_linkto_alloctbl
			gfields = {}
			gfields[:qty_alloc] = (fields[:qty_alloc] + fields[:qty_linkto_alloctbl]) * child["chilnum"].to_f / child["parenum"].to_f
			if (gfields[:qty_alloc] + child["qty_linkto_alloctbl"].to_f) <=  child["qty"].to_f
				qty = child["qty_linkto_alloctbl"].to_f
			else
				qty = (gfields[:qty_alloc] + child["qty_linkto_alloctbl"].to_f) -  child["qty"].to_f
				strsql = %Q% select * from alloctbls where trngantts_id = #{child["id"]} and qty_linkto_alloctbl > 0%
				ActiveRecord::Base.connection.select_all(strsql).each do |over|
					if over["qty_linkto_alloctbl"] <= qty
						qty -= over["qty_linkto_alloctbl"].to_f
					else
						strsql = %Q%update  alloctbls set
								updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								qty_linkto_alloctbl = #{qty} where id = #{over["id"]}
						%
						ActiveRecord::Base.connection.update(strsql)	
						qty = 0
					end
				end
				qty =  gfields[:qty_alloc] -  child["qty"].to_f
			end
			###親からの構成引継ぎなのでaslloctblsとのリンクはない。
			###本体の子の構成は親からの引き当ての継続　直接ordsには引きあたらない。
			gfields[:qty_linkto_alloctbl] = qty
			gfields[:qty_pare_alloc] = fields[:qty_alloc]
			free_ordtbl_to_alloc_child child,gfields
		end
	end	

	def update_alloctbls_inout fields,key
		strfield2 = " updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),"
		fields.each do |field,val|
			strfield2 << " #{field.to_s} = "
			case val.class.to_s
			when "String"
				strfield2 << " '#{val}',"
			when "Time"
				strfield2 << " to_date('#{val.to_s}','yyyy-mm-dd hh24:mi:ss'),"
			when "Date"
				strfield2 << " to_date('#{val.to_s}','yyyy-mm-dd') ,"
			else
				strfield2 << " #{val},"
			end
		end
		strsql =  "update alloctbls  set " + strfield2.chop + " where  id = #{key[:id]} "
		ActiveRecord::Base.connection.update(strsql)

		if fields[:qty]
			qty = fields[:qty].to_f
			qty_stk = 0
		end
		if fields[:qty_stk]
			qty_stk = fields[:qty_stk].to_f
			qty = 0
		end
		strsql = %Q%update instks  set 
		             qty = #{qty},qty_stk = #{qty_stk} where  alloctbls_id = #{key[:id]} %
		ActiveRecord::Base.connection.update(strsql)

		strsql  = %Q%select * from r_instks  where  instk_alloctbl_id = #{key[:id]} %
		r_inout  = ActiveRecord::Base.connection.select_one(strsql)
		stkinout = rinout_to_inout "instk",r_inout 
		lotstkhists_in_out "in",stkinout
		##
		strsql = %Q%update outstks  set 
						qty = #{qty},qty_stk = #{qty_stk} where  alloctbls_id = #{key[:id]} %
		ActiveRecord::Base.connection.update(strsql)
		strsql  = %Q%select * from r_outstks  where  outstk_alloctbl_id = #{key[:id]} %
		r_inout  = ActiveRecord::Base.connection.select_one(strsql)
		stkinout = rinout_to_inout "outstk",r_inout 
		lotstkhists_in_out "out",stkinout
	end	

	def child_trngantts  tblname,tblid,reqparams
		strsql = %Q% select * from trngantts where key = '#{reqparams["orgtrnganttkey"]}' and 
						 orgtblname ='#{reqparams["orgtblname"]}' and 
						 orgtblid = #{reqparams["orgtblid"]}
		%
		rec = ActiveRecord::Base.connection.select_one(strsql)
		### keyはorgtblname,orgtblid,key,tblname,tblidであるがorgtblname,orgtblid,keyで検索
		###  員数等はorgtblname,orgtblid,keyで同一であること。
		tbldata = reqparams["tbldata"]
		child = reqparams["child"] ##子供の情報
		pare_opeitm = proc_get_opeitms_rec rec["itms_id"],nil,rec["processseq"],priority = nil
		child_opeitm = proc_get_opeitms_rec child["itms_id_nditm"],nil,child["processseq_nditm"],priority = nil

		trn = {}
		trn["key"] = reqparams["trnganttkey"]
		trn["orgtblname"] = reqparams["orgtblname"]
		trn["orgtblid"] = reqparams["orgtblid"]
		trn["paretblname"] = rec["tblname"]
		trn["paretblid"] = rec["tblid"]
		trn["tblname"] = tblname
		trn["tblid"] = tblid
		trn["mlevel"] = rec["mlevel"].to_i+1
		trn["shuffle_flg"] = rec["shuffle_flg"]
		trn["parenum"] = child["parenum"]
		trn["chilnum"] = child["chilnum"]
		trn["qty_pare"] = rec["qty"]
		trn["qty_stk_pare"]  = rec["qty_stk"]
		trn["qty"] = (tbldata["qty"]||=0)
		trn["qty_stk"] = (tbldata["qty_stk"]||=0)
		##if trn["qty_stk_pare"].to_f > 0 
		##	trn["qty_alloc"] =  trn["qty_stk_pare"].to_f *  child["chilnum"].to_f / child["parenum"].to_f 
		##else
			trn["qty_alloc"] = 0
		##end
		trn["qty_linkto_alloctbl"] = 0
		trn["qty_pare_alloc"] = rec["qty_alloc"]
		##if trn["qty_pare_alloc"].to_f > 0  or rec["qty_linkto_alloctbl"].to_f > 0 
		##	qty =  trn["qty_pare_alloc"].to_f  +  rec["qty_linkto_alloctbl"].to_f
		##	trn["qty_alloc"] =  qty *  child["chilnum"].to_f / child["parenum"].to_f + trn["qty_alloc"]
		##end
		trn["itms_id"] = child["itms_id_nditm"]
		trn["processseq"] = child["processseq_nditm"]
		trn["shelfnos_id_fm"] = child_opeitm["shelfnos_id"] 
		trn["prjnos_id"] = tbldata["prjnos_id"]
		trn["itms_id_pare"]  = rec["itms_id"]
		trn["processseq_pare"]  = rec["processseq"]
		trn["locas_id_pare"] = pare_opeitm["locas_id"]
		trn["consumunitqty"] = child["consumunitqty"] 
		trn["consumminqty"]  = child["consumminqty"] 
		trn["consumchgoverqty"] = child["consumchgoverqty"]
		trn["starttime"] = rec["starttime"].to_date-1
		trn["duedate"] = trn["starttime"].to_date-child["duration"].to_i
		trn["duedate_org"] = trn["duedate"]
		trngantts_id = RorBlkctl.proc_get_nextval("trngantts_seq")
		trn["trngantts_id"] = trngantts_id
		trn["remark"] = "514"
		insert_trngantt trn

		rec = {}
		rec["id"] = RorBlkctl.proc_get_nextval("alloctbls_seq")
		rec["srctblname"] = tblname
		rec["srctblid"] = tblid
		rec["trngantts_id"] = trngantts_id 
		rec["qty"] = (tbldata["qty"]||=tbldata["qty_stk"])
		rec["qty_linkto_alloctbl"] = 0
		rec["remark"] = "510"
		insert_alloctbls rec

		strsql = %Q%select * from r_#{tblname} where id = #{tblid}
		%
		command_r = ActiveRecord::Base.connection.select_one(strsql)
		add_stkinouts(tblname,tblid,command_r,rec["id"])
		
		if reqparams["orgtblname"] =~ /ords$/ and trn["qty"].to_f > trn["qty_alloc"].to_f  ###元がordsの時のみ子のschsをords等に引き当てる。
			reqparams["trngantts_id"] = trngantts_id
			schstbl_alloc_to_freetbl  tblname,tblid,reqparams
		end
		return trngantts_id
	end
	
### prd,pur,shp ・・・schs,ords,insts,acts,retsのレコード作成　	
	def proc_fields_update parent
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
			##when  /shelfno_loca_id_shelfno_to/
			##	@para["parent_locas_id"] = val.to_f
			end
		end	
		@command_c[:sio_message_contents] = nil
		@command_c[:sio_recordcount] = 1
		@command_c[:sio_result_f] =   "0"  

		@tblnamechop = @command_c[:sio_viewname].split("_")[1].chop
		@command_c[:sio_code] =  @command_c[:sio_viewname] if @command_c[:sio_code].nil?

		strsql =  %Q%select pobject_code_fld from r_tblfields where tblfield_expiredate > current_date and 
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
					@command_c["#{@tblnamechop}_sno"]  = proc_field_sno(@tblnamechop,@command_c["id"])
				when "cno"
					if @command_c["#{@tblnamechop}_cno"].nil? or @command_c["#{@tblnamechop}_cno"] == ""
						@command_c["#{@tblnamechop}_cno"]  = proc_field_cno @command_c["id"]
					end
				when "gno"
					@command_c["#{@tblnamechop}_gno"]   = proc_field_gno @command_c["id"]
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
		@command_c["#{@tblnamechop}_isudate"] = Time.now.to_s if @command_c["#{@tblnamechop}_isudate"].nil? or @command_c["#{@tblnamechop}_isudate"] == ""
	end	 

	def field_duedate 
		duedate = @para["parent_starttime"].to_date - 1
		@command_c["#{@tblnamechop}_toduedate"] = @command_c["#{@tblnamechop}_duedate"] = duedate.to_s
	end

	def field_starttime
		starttime =  @command_c["#{@tblnamechop}_duedate"].to_date - @para["duration"]
		@command_c["#{@tblnamechop}_starttime"] = starttime.to_s
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

	def proc_field_sno(tblnamechop,id)
		ControlFields.proc_snolist["#{tblnamechop}s"] + format('%05d', id) 
	end


	def proc_field_cno id 
		 format('%07d', id)
	end

	def proc_field_gno id
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

	def proc_consume_child_parts rec
		###子部品の消費
		###金型の返却
		###使用装置の解放
	end

	def proc_mkshpschs recs,email,reqparams
		command_c = {}
		command_c[:sio_code] =  "r_shpschs"
		command_c[:sio_viewname] =  "r_shpschs"
		command_c[:sio_message_contents] = nil
		command_c[:sio_recordcount] = 1
		command_c[:sio_result_f] =   "0"  
		command_c[:sio_classname] = reqparams["sio_classname"]
		tbldata = reqparams["tbldata"]
		strsql = %Q% select pobject_code_sfd from  func_get_screenfield_grpname('#{email}','r_shpschs')
				%
		fields = ActiveRecord::Base.connection.select_values(strsql) 
		opeitm_id = {}
		recs.each_with_index do |rec,index|
			if index == 0
				opeitm_id = proc_get_opeitms_rec rec["trngantt_itm_id_pare"],nil,rec["trngantt_processseq_pare"],nil
			end	
			strsql = %Q%select * from nditms where opeitms_id = #{opeitm_id["id"]} and 
				%
			rec.each do |key,val|
				if key == "id" 
					command_c[key] = ""
					command_c["shpsch_id"] = "" 
				else
					if fields.index(key)
						command_c[key] = val
					else
						if fields.index(key.sub("trngantt","shpsch"))
							command_c[key.sub("trngantt","shpsch")] = val
						end
					end
				end
			end
			command_c["shpsch_isudate"] = Time.now 
			command_c["shpsch_loca_id_to"] = rec["trngantt_loca_id_pare"]
			command_c["shpsch_depdate"] = rec["trngantt_starttime"]
			strsql << " itms_id_nditm = #{rec["trngantt_itm_id"]} and processseq_nditm = #{rec["trngantt_processseq"]} "
			shp_crr_price = ActiveRecord::Base.connection.select_one(strsql) 
			command_c["shpsch_price"] = shp_crr_price["price"] 
			command_c["shpsch_crr_id"] = shp_crr_price["crrs_id"] 
			command_c["shpsch_chrg_id"] = tbldata["chrgs_id"] 
			command_c["shpsch_gno"] = tbldata["sno"] 
			command_c["shpsch_transport_id"] = 0 
			RorBlkctl.proc_private_aud_rec  command_c,1,reqparams
		end
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
			if tblname =~ /^prd|^insp/
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
		return stkinout,command_r
	end

	def mk_outstks_rec stkinout,command_r ###opeitm_stktaking_proc,opeitm_packqty
		packnos = []
		idx = 1
		qty_stk = stkinout["qty_stk"].to_f
		packqty = command_r["opeitm_packqty"].to_f
		if stkinout["packno"] == "packno" and qty_stk > 0
			stkinout["qty_stk"] = packqty 
			until qty_stk <= 0 do
				stkinout["packno"] = format('%03d', idx) 
				ActiveRecord::Base.connection.insert(outstk_strsql(stkinout)) 
				if command_r["opeitm_stktaking_proc"] == "1"
					lotstkhists_in_out "out", stkinout
				end
				qty_stk -=  packqty 
				idx += 1
				packnos << stkinout["packno"]
			end
		else
			packnos << stkinout["packno"]
			ActiveRecord::Base.connection.insert(outstk_strsql(stkinout)) 
			if command_r["opeitm_stktaking_proc"] == "1"
				lotstkhists_in_out "out", stkinout
			end
		end
		return  packnos,command_r
	end

	def outstk_strsql stkinout
		outstks_id = RorBlkctl.proc_get_nextval("outstks_seq")
		strsql = %Q%
				insert into outstks(id,alloctbls_id,shelfnos_id_out,
								starttime,
								qty,
								qty_stk,
								lotno,packno,inoutflg,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{outstks_id},#{stkinout["alloctbls_id"]},#{stkinout["shelfnos_id_out"]},
								'#{stkinout["starttime"]}',
								#{stkinout["qty"]},
								#{stkinout["qty_stk"]},
								'#{stkinout["lotno"]}','#{stkinout["packno"]}','#{stkinout["inoutflg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','#{@sio_user_code||=0}','#{stkinout["expiredate"]}','')
		%
	end 	

	def mk_instks_rec stkinout,opeitm_stktaking_proc,packnos
		packnos.each do |packno|
			instks_id = RorBlkctl.proc_get_nextval("instks_seq")
			strsql = %Q%
					insert into instks(id,alloctbls_id,shelfnos_id_in,
								starttime,
								qty,qty_stk,
								lotno,packno,inoutflg,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{instks_id},#{stkinout["alloctbls_id"]},#{stkinout["shelfnos_id_in"]},
								'#{stkinout["starttime"]}',
								#{stkinout["qty"]},
								#{stkinout["qty_stk"]},
								'#{stkinout["lotno"]}','#{packno}','#{stkinout["inoutflg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','#{@sio_user_code||=0}','#{stkinout["expiredate"]}','')
			%
			ActiveRecord::Base.connection.insert(strsql) 
			if opeitm_stktaking_proc == "1"
				lotstkhists_in_out "in", stkinout
			end
		end
	end

	def mk_incustwhs_rec stkinout,stktaking_proc,packnos
		packnos.each do |packno|
			instks_id = RorBlkctl.proc_get_nextval("incustwhs_seq")
			strsql = %Q%
					insert into incustwhs(id,alloctbls_id,custrcvplcs_id,
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
			%
			ActiveRecord::Base.connection.insert(strsql) 
			if stktaking_proc == "1"
				lotstkhists_in_out "in", stkinout
			end
		end
	end

	def mk_outamts_rec amtinout
		outamts_id = RorBlkctl.proc_get_nextval("outamts_seq")
		strsql = %Q%
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
		%
		ActiveRecord::Base.connection.insert(strsql) 
	end

	def mk_inamts_rec amtinout
		inamts_id = RorBlkctl.proc_get_nextval("inamts_seq")
		strsql = %Q%
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
		%
		ActiveRecord::Base.connection.insert(strsql) 
	end

	def lotstkhists_in_out kubun,stkinout
		shelfnos_id = if kubun == "out" then stkinout["shelfnos_id_out"] else  stkinout["shelfnos_id_in"] end
		qty_stk = 	 if kubun == "out" then stkinout["qty_stk"].to_f*(-1)  else  stkinout["qty_stk"].to_f end
		qty = 	if kubun == "out" then stkinout["qty"].to_f*(-1)  else  stkinout["qty"].to_f end
		strsql = %Q% select * from lotstkhists
						where itms_id = #{stkinout["itms_id"]} and  lotno = '#{stkinout["lotno"]}' and 
								processseq = #{stkinout["processseq"]} and
								packno = '#{stkinout["packno"]}' and  shelfnos_id = #{shelfnos_id} and
								prjnos_id = #{stkinout["prjnos_id"]} 
		%
		rec = ActiveRecord::Base.connection.select_one(strsql)
		if rec
			strsql = %Q% update lotstkhists set  updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
												starttime = '#{stkinout["starttime"]}',persons_id_upd = #{@sio_user_code||=0},
												qty_stk = #{rec["qty_stk"].to_f + qty_stk},qty = #{rec["qty"].to_f + qty}
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
									#{stkinout["itms_id"]},#{shelfnos_id},
									#{stkinout["prjnos_id"]},
									'#{stkinout["starttime"]}',#{stkinout["processseq"]},
									'#{stkinout["lotno"]}','#{stkinout["packno"]}',
									#{qty_stk},#{qty},
									'#{stkinout["stktaking_proc"]}',
									to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
									to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
									' ',#{@sio_user_code||=0},'#{stkinout["expiredate"]}','')
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

	def prev_trngantts_update xno,prevtbl,val,qty,qty_stk,stktaking_proc,tblname,tblid
		case xno
		when "sno"
			strsql = %Q% select a.*,c.qty trn_qty,c.qty_stk trn_qty_stk from alloctbls a,#{prevtbl} b,trngantts c
							where srctblname = '#{prevtbl}' and srctblid =  b.id and b.#{xno} = '#{val}'  
							and a.trngantts_id = c.id
							and a.qty_linkto_alloctbl > 0 	order by c.duedate
					%
		else
			p " 工事中"
			raise
		end
		recs = ActiveRecord::Base.connection.select_all(strsql)   ###前の状態のレコード
		if  qty.to_f > qty_stk.to_f
			new_qty = qty.to_f
		else
			new_qty = qty_stk.to_f
		end
		recs.each do |rec|  ###前の状態のレコード
			if  rec["trn_qty"].to_f > rec["trn_qty_stk"].to_f
				old_qty = rec["trn_qty"].to_f
			else
				old_qty = rec["trn_qty_stk"].to_f
			end
			nrec = rec.dup
			nrec["srctblname"] = tblname
			nrec["srctblid"] = tblid
			key = {:id=>rec["id"]}
			strsql = %Q%select * from r_#{rec["srctblname"]} where id = #{rec["srctblid"]}
						%
			command_r = ActiveRecord::Base.connection.select_one(strsql)
			if new_qty >= old_qty
				fields = {:qty=>0,:qty_stk=>0,:qty_linkto_alloctbl=>0} 
				update_alloctbls_inout fields,key   ###前のレコード変更
				alloctbls_insert_update nrec
				command_r["#{tblname.chop}_qty"] = rec["qty_alloc"] 
				command_r["#{tblname.chop}_qty_pare"] = rec["qty_pare"] 
				command_r["#{tblname.chop}_qty_stk"] = 0
				add_stkinouts(tblname,tblid,command_r,rec["id"])
				new_qty =  new_qty - rec["qty_alloc"].to_f
			else
				qty = old_qty - new_qty
				if  rec["trn_qty"].to_f > rec["trn_qty_stk"].to_f
					fields = {:qty=>qty,:qty_stk=>0} 
				else
					fields = {:qty=>0,:qty_stk=>qty}
				end
				if new_qty >=  rec["qty_linkto_alloctbl"].to_f
					nrec["qty_linkto_alloctbl"] = rec["qty_linkto_alloctbl"].to_f
					fields[:qty_linkto_alloctbl] = 0  ###旧レコード
				else
					nrec["qty_linkto_alloctbl"] = new_qty
					fields[:qty_linkto_alloctbl] = rec["qty_linkto_alloctbl"].to_f - new_qty
				end
				update_alloctbls_inout fields,key
				alloctbls_insert_update nrec
				command_r["#{tblname.chop}_qty"] = rec["qty"] 
				command_r["#{tblname.chop}_qty_pare"] = rec["qty_pare"] 
				command_r["#{tblname.chop}_qty_stk"] = 0
				add_stkinouts(tblname,tblid,command_r,rec["id"])
				new_qty = 0
			end
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
	
	def add_stkinouts(tblname,tblid,command_r,alloctbls_id)
		stkinout = {}
		case tblname
		###  stk
		###  out
		when /^pur|^insp/  ###shelfnos_id = 0は必須
			case tblname ###purschs-->opeitm_loca_id 
				when /^pur/
					if command_r["supplier_loca_id_supplier"]
						strsql = %Q% select id from shelfnos where locas_id_shelfno  = #{command_r["supplier_loca_id_supplier"]}
						%
					else
						strsql = %Q% select id from shelfnos where locas_id_shelfno  = #{command_r["opeitm_loca_id"]}
						%
					end
					id = ActiveRecord::Base.connection.select_value(strsql)
				when /^insp/
					id = command_r[tblname.chop+"_shelfno_id_to"] 
			end
			id ||= 0 
			stkinout["shelfnos_id_out"] = id 
			stkinout["shelfnos_id_in"] = command_r[tblname.chop+"_shelfno_id_to"] 
			stkinout["inoutflg"] = ""
			stkinout["processseq"] = command_r["opeitm_processseq"]
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
			if command_r["workplace_loca_id_workplace"]
				strsql = %Q% select id from shelfnos where locas_id_shelfno  = #{command_r["workplace_loca_id_workplace"]}
					%
			else
				strsql = %Q% select id from shelfnos where locas_id_shelfno  = #{command_r["opeitm_loca_id"]}
				%
			end
			id = ActiveRecord::Base.connection.select_value(strsql) 
			id ||= 0
			stkinout["shelfnos_id_out"] = id
			stkinout["inoutflg"] = ""
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
			stkinout["shelfnos_id_out"] = command_r["trngantt_shelfno_id_fm_shp"] 
			stkinout["inoutflg"] = ""
			stkinout["starttime"]  = command_r[tblname.chop+"_depdate"]
			stkinout["processseq"] = command_r["trngantt_processseq_shp"]
		when /^cust/  ###shelfnos_id = 0は必須
			case tblname ###purschs-->opeitm_loca_id 
				when /schs$|ords$/
					stkinout["shelfnos_id_out"] = command_r["opeitm_shelfno_id"]
				when /insts$|dlvs$|acts$/
					stkinout["shelfnos_id_out"] = command_r[tblname.chop+"_shelfno_id_to"]
			end
			stkinout["inoutflg"] = ""
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
		if command_r[tblname.chop+"_qty_stk"]
			stkinout["qty_stk"] = command_r[tblname.chop+"_qty_stk"]
		else
			stkinout["qty_stk"] = 0
		end
		
		if command_r[tblname.chop+"_qty"]
			stkinout["qty"] = command_r[tblname.chop+"_qty"]
		else
			stkinout["qty"] = 0
		end	
		stkinout["expiredate"] = command_r[tblname.chop+"_expiredate"]
		stkinout,command_r =  lotno_set(tblname,stkinout,command_r) 
		stkinout["alloctbls_id"] = alloctbls_id
		stkinout["processseq"] = command_r["opeitm_processseq"]
		stkinout["itms_id"] = command_r["opeitm_itm_id"]
		stkinout["stktaking_proc"] = command_r["opeitm_stktaking_proc"]
		stkinout["prjnos_id"] = command_r[tblname.chop+"_prjno_id"]
		##
		if tblname == "puracts" and !command_r["puract_sno_purdlv"].nil? and command_r["puract_sno_purdlv"] != ""
			### stk-in purdlvを使用
		else	
			packnos,command_r = mk_outstks_rec stkinout,command_r
		end
		
		###  stk
		###  in
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
			mk_instks_rec stkinout,command_r["opeitm_stktaking_proc"],packnos
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
			mk_instks_rec stkinout,command_r["opeitm_stktaking_proc"],packnos
		when /^shp/
			stkinout["starttime"]  = command_r[tblname.chop+"_duedate"]
			stkinout["shelfnos_id_in"] = command_r[tblname.chop+"_shelfno_id_to"]
			mk_instks_rec stkinout,command_r["opeitm_stktaking_proc"],packnos
		when /^cust/
			stkinout["duedate"]  = command_r[tblname.chop+"_duedate"]
			stkinout["custrcvplcs_id"]  = command_r[tblname.chop+"_custrcvplc_id"]
			mk_incustwhs_rec stkinout,command_r["custrcvplc_stktaking_proc"],packnos
		end
	end
    
	def proc_trngantts tblname,tblid,reqparams
		processreqs_ids = []
		tbldata = reqparams["tbldata"]
		if tbldata["qty"] then symqty = "qty" else symqty = "qty_stk" end
		strsql = %Q% select * from trngantts where tblname = '#{tblname}' and tblid = #{tblid}
					  and orgtblname = paretblname and paretblname = tblname
					  and orgtblid = paretblid and paretblid = tblid
		%
		rec = ActiveRecord::Base.connection.select_one(strsql)
		if rec.nil?  ###trngantts 追加
			if tblid.to_i == reqparams["paretblid"].to_i and tblname == reqparams["paretblname"]
				trngantts_id ,qty_alloc  = init_trngantts_add_detail(tblname,tblid,reqparams)	###新規本体を作成
			else
				trngantts_id = child_trngantts(tblname,tblid,reqparams)   ###構成の一部になっているとき(本体を作成後確認)
			end	
			reqparams["trngantts_id"] =  trngantts_id
			##if (reqparams["orgtblname"] != tblname or   reqparams["orgtblid"] != tblid) and
			##		tblname =~ /schs$/ and reqparams["orgtblname"] =~ /ords$/
			case tblname   ###次の動作を確定
			when /prdschs|purschs|custschs|custords/
				reqparams["segment"]  << "mkschs"   ###構成展開
				reqparams["paretblname"] = tblname
				reqparams["paretblid"] = tblid 
				processreqs_id = proc_processreqs_add tblname,tblid,reqparams
			when /prdords|purords/
				reqparams["paretblname"] = tblname
				reqparams["paretblid"] = tblid	
				reqparams["segment"]  << "mkschs"
				reqparams["segment"]  << "mkshpschs"   ###出庫 
				processreqs_id = proc_processreqs_add tblname,tblid,reqparams	
			when /insts$/
			when /acts$/
				reqparams["segment"]  << "consume_child_parts"
				processreqs_id = proc_processreqs_add tblname,tblid,reqparams
			else
				processreqs_id = nil
			end
			processreqs_ids << processreqs_id	
			tbldata.each do |key,val|   ###前の状態のtrn変更
				if key =~ /^sno_|^gno_|^cno_/ and val
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
						prev_trngantts_update(xno,prevtbl,val,qty,qty_stk,stktaking_proc,tblname,tblid)
						sw = false
					end	
				end	
			end	
		else ###trngantts 変更
			srctblqty = tbldata[symqty].to_f 
			strsql = %Q% update trngantts set updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
							#{symqty} = #{srctblqty} where  id = #{rec["id"]} %
			ActiveRecord::Base.connection.update(strsql)
			strsql = %Q% update alloctbls set updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								qty_linkto_alloctbl = #{srctblqty} 
								where  trngantts_id = #{rec["id"]} and srctblname = '#{tblname}' and srctblid = #{tblid} %
			ActiveRecord::Base.connection.update(strsql)
			strsql = %Q% select * from  alloctbls where  trngantts_id != #{rec["id"]} 
													and srctblname = '#{tblname}' and srctblid = #{tblid} %
			allocs = ActiveRecord::Base.connection.select_all(strsql)
			allocs.each do |alloc|
				if srctblqty < alloc["qty_linkto_alloctbl"].to_f      ###子供への必要数が不足したとき
					fields = {:qty_linkto_alloctbl=>srctblqty}
					key = {:id=>alloc["id"]}
					update_alloctbls_inout fields,key
					srctblqty = 0
				else
					srctblqty  = srctblqty - alloc["qty_alloc"].to_f   ###余剰分　
					###freeの残数はtrngantts org = pare = tblのレコードの qty - qty_alloc 
				end
			end
		end
		if reqparams["segment"].size > 5
			p reqparams["segment"]
			p "error error"
			raise
		end	
		return processreqs_ids
	end
	
	def proc_processreqs_add tblname,tblid,reqparams
		processreqs_id = RorBlkctl.proc_get_nextval("processreqs_seq")
		strsql = %Q%
		insert into processreqs(tblname,tblid,paretblname,paretblid,
								contents,remark,
								created_at,updated_at,
								update_ip,persons_id_upd,reqparams,
								id,result_f)
								values('#{tblname}',#{tblid},'#{reqparams["paretblname"]}',#{reqparams["paretblid"]},
								'','',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								'',#{@sio_user_code||=0},'#{JSON.generate(reqparams)}',
								#{processreqs_id},'0')
		%
		ActiveRecord::Base.connection.insert(strsql)  ## @sio_user_code||=0 ==>operationから呼ばれたときは@sio_user_code=nil
		return processreqs_id
	end
end   ##module
