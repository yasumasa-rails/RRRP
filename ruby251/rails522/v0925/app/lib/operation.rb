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

	def chk_custords_alloc  tblid,tbldata  ###引き当てるcustschsを検索
        ###同一品目(processseqを含む)、同一出庫場所(棚は無視),同一プロジェクト
        strsql = %Q%select alloc.*,gantt1.itms_id,gantt1.processseq,gantt1.prjnos_id
						from alloctbls alloc
            			inner join (select gantt.* from trngantts gantt 
										inner join ( select o.* from opeitms o inner join custords c
														   on o.id = c.opeitms_id  where c.id = #{tbldata["id"]}) o1
											on gantt.itms_id = o1.itms_id and gantt.processseq = o1.processseq ) gantt1  											 			   
								on gantt1.id = alloc.trngantts_id and gantt1.prjnos_id =  #{tbldata["prjnos_id"]}
            			where	--- and  gantt.locas_id_fm = #{tbldata["locas_id_fm"]}  ---場所の違いは無視した
            				 (alloc.qty_sch - alloc.qty_linkto_alloctbl > 0 and
								alloc.srctblname = 'custschs' and
								(select custs_id from custschs where id = alloc.srctblid) = #{tbldata["custs_id"]})
							or
							 (alloc.qty_stk - alloc.qty_linkto_alloctbl) > 0
							order by gantt1.duedate
            for update
        %
        ActiveRecord::Base.connection.select_all(strsql).each do |rec|
        	qty = tbldata["qty"].to_f
        	key = 0
			src = {"srctblname"=>"custschs","srctblid"=>rec["srctblid"],
						"trngantts_id"=>src["trngantts_id"],"qty_src"=>0,
						"itms_id"=>rec["itms_id"],"processseq"=>rec["processseq"],"prjnos_id"=>rec["prjnos_id"]}
            if qty >= rec["qty_sch"].to_f > 0
                qty -=   rec["qty_sch"].to_f
				src["qty_src"] = rec["qty_sch"]
				prev_trngantts_update "custords",tblid,src
                break if qty <= 0
            else
                if qty < rec["qty"].to_f and  rec["qty"].to_f > 0
					src["qty_src"] = qty
					prev_trngantts_update "custords",tblid,src
                    qty = 0
                    break
                else    
                    if qty >= rec["qty_stk"].to_f and  rec["qty_stk"].to_f > 0
						qty -=   rec["qty_stk"].to_f
						src["qty_src"] = rec["qty_stk"]
						prev_trngantts_update "custords",tblid,src
                        break if qty <= 0
                    else
                        if qty < rec["qty_stk"].to_f 
							src["qty_src"] = qty
							prev_trngantts_update "custords",tblid,src
                            qty = 0
                            break 
                        end
                    end
                end            
            end    
        end  
        return 
    end    
	
	def proc_trngantts tblname,tblid,paretblname,paretblid,reqparams
		###
		###
		tbldata = reqparams["tbldata"]  ### /ords|insts|replyinputs|acts/ではtrnganttsは作成しない。
		strsql = %Q% select * from trngantts where tblname = '#{tblname}' and tblid = #{tblid}
					  and orgtblname = paretblname and paretblname = tblname
					  and orgtblid = paretblid and paretblid = tblid
		%
		rec = ActiveRecord::Base.connection.select_one(strsql)
		if rec.nil?  ###trngantts 追加、またはtblname=~/insts|acts・・・の時
			if (tblid == paretblid and tblname == paretblname) 
				###schs$,ords$--->新規本体を作成  ^pur,^prd --->prev_trngantts_update
				trngantts_id,reqparams = init_trngantts_add_detail(tblname,tblid,paretblname,paretblid,reqparams)
			else ###構成の一部になっているとき(本体を作成後確認)
				trngantts_id,reqparams = child_trngantts(tblname,tblid,reqparams)  
			end	
			reqparams["trngantts_id"] = trngantts_id
		else ###trngantts 変更
			qty_sch = rec["qty_sch"] = tbldata["qty_sch"].to_f   ###tbldataではqty_sch,qty,qty_stkのうち2つ以上はzero
			qty		=  rec["qty"] = tbldata["qty"].to_f
			qty_stk =  rec["qty_stk"] = tbldata["qty_stk"].to_f
			rec["prjnos_id"] = tbldate["prjnos_id"] 
			rec["shelfnos_id_in"] = tbldata["shelfnos_id_to"] ###trnganttsの項目ではない。
			rec["starttime"] = tbldata["duedate"]
			fields = {:srctblname=>tblname,:srctblid=>tblid,:trngantts_id=>rec["id"],
						:remark=>" 2106 ",:inoutflg=>tblname,
						:qty_sch=>qty_sch,:qty=>qty,:qty_stk=>qty_stk,:qty_alloc=>0}
			### topではtrngamtts.qty_alooc = 0 ,top: org=pare=tbl
			strsql = %Q&update trngantts set
								updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								prjnos_id = #{rec["prjnos_id"]},starttime = '#{rec["starttime"]}',
								qty_sch = #{qty_sch},qty = #{qty},qty_stk = #{qty_stk},remark = '1925'
								where  id = #{rec["id"]} &
			ActiveRecord::Base.connection.update(strsql)
			new_qty = qty_sch + qty + qty_stk ### org=pare=tblのtrnganttsでは rec["qty_alloc"].to_f == 0
			strsql = %Q% select * from  alloctbls
									 where  trngantts_id = #{rec["id"]}   
									 and tblname = '#{tblname}' and tblid = #{tblid}%
			old_alloc = ActiveRecord::Base.connection.select_one(strsql) ### otg=pare=tbl trngantts:alloctbls = 1:1
				new_alloc = old.alloc.dup
				new_alloc["prjnos_id"] = tbldate["prjnos_id"] 
				new_alloc["shelfnos_id_in"] = tbldata["shelfnos_id_to"] ###trnganttsの項目ではない。
				new_alloc["starttime"] = tbldata["duedate"]
				new_alloc["qty_sch"] = qty_sch   
				new_alloc["qty"] = qty   
				new_alloc["qty_stk"] = qty_stk  
				if new_alloc["qty_linkto_alloctbl"].to_f > new_qty
					new_alloc["qty_linkto_alloctbl"] = new_qty
				end
				### alloctblsとtrngantts登録変更
				chng_lotstkhists_of_alloc old_alloc,new_qty_link
			
			if old_alloc["qty_linkto_alloc"].to_f > new_alloc["qty_linkto_alloc"].to_f 
				strsql = %Q% select *
								from  alloctbls
								where  trngantts_id = #{rec["id"]}   
								and (tblname != '#{tblname}' or tblid != #{tblid})
								and ((qty_sch + qty + qty_stk) > qty_linkto_alloctbl )
								---生きているレコードのみ対象
									%
				ActiveRecord::Base.connection.select_all(strsql).each do |link_alloc|
					new_link_alloc = link_alloc.dup
					### qty_sch,qty,qrt_stkの2つ以上はzero
					if link_alloc["qty_sch"].to_f >= new_qty
						new_link_alloc["qty_sch"].to_f = new_qty
						new_qty = 0
					else
						new_qty = new_qty - link_alloc["qty_sch"].to_f
					end
					if link_alloc["qty"].to_f >= new_qty
						new_link_alloc["qty"].to_f = new_qty
						new_qty = 0
					else
						new_qty = new_qty - link_alloc["qty"].to_f
					end
					if link_alloc["qty_stk"].to_f >= new_qty
						new_link_alloc["qty_stk"].to_f = new_qty
						new_qty = 0
					else
						new_qty = new_qty - link_alloc["qty_stk"].to_f
					end
					if link_alloc["qty_sch"] != new_link_alloc["qty_sch"] or
						link_alloc["qty"] != new_link_alloc["qty"] or
							link_alloc["qty_stk"] != new_link_alloc["qty_stk"] 
								chng_lotstkhists_of_alloc link_alloc,new_link_alloc
					end			
				end	
			end	
			###
			reqparams["trngantts_id"] = rec["id"]
		end
		return reqparams
	end

	def chng_lotstkhists_of_alloc old_alloc,new_alloc
		strsql = %Q&select  lot.*,alloc.id alloctbls_id
								from lotstkhists lot
								inner join alloctbls alloc on lot.id = alloc.lotstkhists_id 
								where alloc.id = #{old_alloc["id"]} 
							for update
		&	
		rec = ActiveRecord::Base.connection.select_all(strsql)
		rec["qty_sch"] = rec["qty_sch"].to_f * -1  
		rec["qty"] 	   = rec["qty"].to_f * -1  
		rec["qty_stk"] = rec["qty_stk"].to_f * -1  
		lotstkhists_in_out "upd", rec   ###,old_alloc,""
		strsql = %Q&
			update alloctbls set
				updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
				qty_sch = 0,qty = 0,qty_stk = 0,qty_linkto_alloctbl = 0,lotstkhists_id = 0
				where  id = #{old_alloc["id"]} &
		ActiveRecord::Base.connection.update(strsql)
		if (new_alloc["qty_sch"].to_f + new_alloc["qty"].to_f + new_alloc["qty_stk"].to_f)  > 0
			alloc = insert_alloctbls new_alloc
			lotstkhists_id = lotstkhists_in_out "in", rec   ###,old_alloc,""
			strsql = %Q&
				update alloctbls set lotstkhists_id = #{lotstkhists_id}
				where  id = #{alloc["id"]} &
			ActiveRecord::Base.connection.update(strsql)
		end
	end

	def init_trngantts_add_detail   tblname,tblid,paretblname,paretblid,reqparams
		gantt = {}
		src_no = ""
		srctblname = ""
		if reqparams["orgtblname"] == "mkords"   ###mkordsはtreeの親ではない。
			gantt["remark"] = "by mkords "
		else
			gantt["remark"] = ""
		end		###トップ登録時org=pare=tbl
		orgtblname = paretblname  ###prd,purの作成依頼元
		orgtblid = paretblid
		tbldata = reqparams["tbldata"]
		child = (reqparams["child"]||={})    ###本体単独の時　child=nil
		qty_sch = 	(tbldata["qty_sch"]||=0) 
		qty = 	(tbldata["qty"]||=0) 
		qty_stk = 	(tbldata["qty_stk"]||=0) 
		strsql = "select * from opeitms where id = #{tbldata["opeitms_id"]} "  ###trnganttsテーブルの対象テーブルにはopeitms_idを必ず含む
		opeitm = ActiveRecord::Base.connection.select_one(strsql)
		reqparams["opeitm"] = opeitm

		strsql = "select * from r_#{paretblname} where id = #{paretblid} "
		pare_tbl = ActiveRecord::Base.connection.select_one(strsql)
		case tblname
			when /^prdschs|^purschs/
				gantt["locas_id"] = pare_tbl["opeitm_loca_id_opeitm"]
				gantt["starttime"] = tbldata["duedate"].to_time - opeitm["duraion"]*60*60*24 
				gantt["org_duedate"] = tbldata["duedate"]
				gantt["duedate"] = tbldata["duedate"]
			when /^prdords/
				gantt["locas_id"] = pare_tbl["workplace_loca_id_workplace"]
				gantt["starttime"] = tbldata["isudate"] 
				gantt["duedate"] = tbldata["duedate"]
			when /^prdinsts/
				gantt["starttime"] = tbldata["isudate"] 
				gantt["duedate"] = tbldata["duedate"] 
				gantt["locas_id"] = pare_tbl["workplace_loca_id_workplace"]
			when /^replyinputs/
				tbldata["starttime"] =  tbldata["replydate"]
			when /^prdacts/
				tbldata["starttime"] = tbldata["duedate"] = tbldata["cmpldate"]
				gantt["locas_id"] = pare_tbl["workplace_loca_id_workplace"]
			when /^purords/
				gantt["locas_id"] = pare_tbl["supplier_loca_id_supplier"]
			when /^purinsts/
				tbldata["starttime"] = tbldata["duedate"] = tbldata["replydate"]
				gantt["locas_id"] = pare_tbl["supplier_loca_id_supplier"]
			when /^puracts/
				tbldata["starttime"] = tbldata["duedate"] = tbldata["rcptdate"]
				gantt["locas_id"] = pare_tbl["supplier_loca_id_supplier"]
			when /^custschs/
				tbldata["shelfnos_id_to"] = opeitm["shelfnos_id"]  ###shelfnos_id_fm:親がこの子部品をどこからとってくるか
				tbldata["starttime"] = (tbldata["duedate"].to_date - 1).strftime("%Y-%m-%d %H:%M:%S")
				gantt["locas_id"] = opeitm["locas_id_opeitm"]
			when /^custords/
				tbldata["shelfnos_id_to"] = opeitm["shelfnos_id"]  ###shelfnos_id_fm:親がこの子部品をどこからとってくるか
				tbldata["starttime"] = (tbldata["duedate"].to_date - 1).strftime("%Y-%m-%d %H:%M:%S")
				gantt["locas_id"] = opeitm["locas_id_opeitm"]
		end

		case tblname
		when /schs$|ords$/  ###insts,replyinputs,dlvs,actsはtrnganttsは作成しない。
			gantt["key"] = reqparams["trnganttkey"] = "00000"
			gantt["orgtblname"] = orgtblname
			gantt["orgtblid"] = orgtblid
			gantt["paretblname"] = paretblname
			gantt["paretblid"] = paretblid
			gantt["tblname"] = tblname
			gantt["tblid"] = tblid
			gantt["mlevel"] = 0
			gantt["shuffle_flg"] = (opeitm["shuffle_flg"]||="0")
			gantt["parenum"] = gantt["chilnum"] = 1
			gantt["qty_sch"] = qty_sch
			gantt["qty"] = qty
			gantt["qty_bal"] =  (tbldata["qty_bal"]||=0) 
			gantt["qty_stk"]  = 0
			gantt["qty_alloc"]  = 0
			gantt["qty_pare"] = (pare_tbl["#{paretblname.chop}_qty"]||=0)
			gantt["qty_pare_alloc"] = 0
			gantt["qty_stk_pare"] = (pare_tbl["#{paretblname.chop}_qty_sch"]||=0)
			gantt["qty_stk_pare"] = (pare_tbl["#{paretblname.chop}_qty_stk"]||=0)
			gantt["qty_pare_bal"] = (pare_tbl["#{paretblname.chop}_qty_bal"]||=0)
			gantt["itms_id"] = opeitm["itms_id"]
			gantt["processseq"] = opeitm["processseq"] 
			gantt["shelfnos_id_fm"] = opeitm["shelfnos_id"] 
			gantt["prjnos_id"] = tbldata["prjnos_id"]
			gantt["itms_id_pare"]  = pare_tbl["opeitm_itm_id"] 
			gantt["processseq_pare"]  = pare_tbl["opeitm_processseq"] 
			gantt["locas_id_pare"] = pare_tbl["opeitm_loca_id_opeitm"]
			gantt["consumtype"] = child["consumtype"]
			gantt["consumunitqty"] = (child["consumunitqty"]||=0) 
			gantt["consumminqty"]  = (child["consumminqty"]||=0) 
			gantt["consumchgoverqty"] = (child["consumchgoverqty"]||=0)
			gantt["duedate"] = gantt["duedate_org"] = tbldata["duedate"]
			trngantts_id = RorBlkctl.proc_get_nextval("trngantts_seq")
			gantt["trngantts_id"] = gantt["id"] = trngantts_id
			###gantt["autocreate_ord"]を追加
			gantt["remark"] << "206"
			insert_trngantt gantt
					
			rec_alloc = {}  ###alloctbls　 ###instks,outstks作成用
			##fields = {}
			rec_alloc["srctblname"] = tblname
			rec_alloc["srctblid"] = tblid
			rec_alloc["qty_sch"] =  gantt["qty_sch"]
			rec_alloc["qty"] =  gantt["qty"]
			rec_alloc["qty_stk"] =  gantt["qty_stk"]
			rec_alloc["qty_linkto_alloctbl"] =  0
			rec_alloc["trngantts_id"] = trngantts_id
			rec_alloc["remark"] = "223"
			insert_alloctbls rec_alloc
	
			rec_alloc["alloctbls_id"] = rec_alloc["id"]
			rec_alloc["shelfnos_id_in"] = tbldata["shelfnos_id_to"]
			rec_alloc["starttime"] = tbldata["starttime"]
			rec_alloc["lotno"] = tbldata["lotno"]
			rec_alloc["packno"] = tbldata["packno"]
			rec_alloc["inoutflg"] = tblname
			rec_alloc["itms_id"] = opeitm["itms_id"]
			rec_alloc["processseq"] = opeitm["processseq"] 
			rec_alloc["prjnos_id"] = tbldata["prjnos_id"]
			case tblname
			when /^pur|^prd/
				proc_mk_instks_rec rec_alloc,"add"
			when /custschs/
				mk_custwhs_rec rec_alloc,"add"
			else ###insts$,acts$はords$に必ずひもつくこと。
				### 意思を持ってxxxschsを登録したときは、既にあるfreeのordsに引き当てない。
				###但し、後でmkordsの選択対象になる。
			end
		end
		
		case tblname
		when /custords/
			chk_custords_alloc tblid,tbldata ###引き当てるcustschsを検索
			### mk_custwhs_rec rec_alloc,"add"
		when /ords$/				
			reqparams["trngantts_id"] = trngantts_id
			free = gantt.dup
			free["free_trngantts_id"] = gantt["id"] 
			free["free_alloctbls_id"] = rec_alloc["id"] 
			if tbldata["sno_#{tblname.gsub("ords","sch")}"].size > 0
				reqparams["src_no"] = tbldata["sno_#{tblname.gsub("ords","sch")}"]
				reqparams["src_snocno"] = "sno"
			end
			free_ordtbl_alloc_to_sch free,reqparams,tblname
		when /insts$|acts$|dlvs$|replyinputs$/
			case 
			when  !tbldata["sno_purord"].nil?
				if  tbldata["sno_purord"].size > 0
					src_sno = tbldata["sno_purord"]
					src_cno = ""
				end	
			when  !tbldata["sno_purinst"].nil?
				if  tbldata["sno_purinst"].size > 0
					src_sno = tbldata["sno_purinst"]
					src_cno = ""
				end	
			when  !tbldata["sno_prdord"].nil?
				if  tbldata["sno_prdord"].size > 0
					src_sno = tbldata["sno_prdord"]
					src_cno = ""
				end	
			when  !tbldata["sno_prdinst"].nil?
				if  tbldata["sno_prdinst"].size > 0
					src_sno = tbldata["sno_prdinst"]
					src_cno = ""
				end	
			when  !tbldata["cno_purinst"].nil?
				if  tbldata["cno_purinst"].size > 0
					src_cno = tbldata["cno_purinst"]
					src_sno = ""
				end	
			when  !tbldata["cno_prdinst"].nil?
				if  tbldata["cno_prdinst"].size > 0
					src_cno = tbldata["cno_prdinst"]
					src_sno = ""
				end	
			when  !tbldata["cno_purdlv"].nil?
				if  tbldata["cno_purdlv"].size > 0
					src_cno = tbldata["cno_purdlv"]
					src_sno = ""
				end	
			when  !tbldata["cno_prddlv"].nil?
				if  tbldata["cno_prddlv"].size > 0
					src_cno = tbldata["cno_prddlv"]
					src_sno = ""
				end	
			end	
			srctbldata = {"src_no"=>src_no,"srctblname"=>srctblname,
							"qty_src"=>gantt["qty"].to_f + gantt["qty_stk"].to_f,trngantts_id=>rec["trngantts_id"],
							"sno"=>src_sno,"cno"=>src_cno}
			prev_trngantts_update tblname,tblid,srctbldata
		when /rets$/
			case 
			when  !tbldata["sno_puract"].nil?
				if  tbldata["sno_puract"].size > 0
					src_sno = tbldata["sno_puract"]
					src_cno = ""
				end	
			when  !tbldata["sno_prdact"].nil?
				if  tbldata["sno_prdinst"].size > 0
					if  tbldata["sno_prdact"].size > 0
						src_sno = tbldata["sno_prdact"]
						src_cno = ""
					end
				end
			end	
			srctbldata = {"src_no"=>src_no,"srctblname"=>srctblname,
				"qty"=>0,"qty_stk"=>(gantt["qty_stk"].to_f * -1) ,trngantts_id=>rec["trngantts_id"],
				"sno"=>src_sno,"cno"=>src_cno}
			prev_trngantts_update tblname,tblid,srctbldata	
		end	

		return  trngantts_id,reqparams
	end

	def child_trngantts  tblname,tblid,reqparams  ###child_trnganttsのデータはxxxschsのデータのみ
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

		strsql = %Q&select qty_linkto_alloctbl from alloctbls where trngantts_id = #{pare["id"]}
							and srctblname like '%schs' 
		&
		gantt = {}
		gantt["qty_pare_alloc"] = ActiveRecord::Base.connection.select_value(strsql)
		gantt["qty_pare_alloc"] = gantt["qty_pare_alloc"].to_f + pare["qty_alloc"].to_f
		gantt["key"] = reqparams["trnganttkey"]
		gantt["orgtblname"] = reqparams["orgtblname"]
		gantt["orgtblid"] = reqparams["orgtblid"]
		gantt["paretblname"] = pare["tblname"]
		gantt["paretblid"] = pare["tblid"]
		gantt["tblname"] = tblname
		gantt["tblid"] = tblid
		gantt["mlevel"] = pare["mlevel"].to_i+1
		gantt["shuffle_flg"] = pare["shuffle_flg"]
		gantt["parenum"] = child["parenum"]
		gantt["chilnum"] = child["chilnum"]
		gantt["qty_pare"] = (pare["qty"]||=pare["qty_sch"])
		gantt["qty_pare_bal"] = (pare["qty_bal"]||=0)
		gantt["qty_stk_pare"]  = (pare["qty_stk"]||=0)
		gantt["qty"] = 0   ###schsのみ
		gantt["qty_sch"] = (tbldata["qty_sch"]||=0)
		packqty = if (child_opeitm["packqty"]||="0") == "0" 
					1
				 else
					 child_opeitm["packqty"].to_f
				 end 
		packqty = if  packqty == 0 then 1 else 	packqty end	
		gantt["qty_alloc"] =	gantt["qty_pare_alloc"].to_f * gantt["chilnum"].to_f / gantt["parenum"].to_f   
		gantt["qty_stk"] = 0
		gantt["qty_bal"] = (tbldata["qty_bal"]||=0)
		### parenum chilnum
		gantt["itms_id"] = child["itms_id_nditm"]
		gantt["processseq"] = child["processseq_nditm"]
		gantt["shelfnos_id_fm"] = child_opeitm["shelfnos_id"] 
		gantt["prjnos_id"] = tbldata["prjnos_id"]
		gantt["locas_id"] = child_opeitm["locas_id_opeitm"]  ###
		gantt["itms_id_pare"]  = pare["itms_id"]
		gantt["processseq_pare"]  = pare["processseq"]
		gantt["locas_id_pare"] = pare_opeitm["locas_id_opeitm"]
		gantt["consumtype"] = child["consumtype"]
		gantt["consumunitqty"] = child["consumunitqty"] 
		gantt["consumminqty"]  = child["consumminqty"] 
		gantt["consumchgoverqty"] = child["consumchgoverqty"]
		gantt["starttime"] = tbldata["starttime"]
		gantt["duedate"] = tbldata["duedate"]
		gantt["duedate_org"] = gantt["duedate"]
		trngantts_id = RorBlkctl.proc_get_nextval("trngantts_seq")
		gantt["trngantts_id"] = trngantts_id
		gantt["remark"] = "469"
		insert_trngantt gantt

		 ###親の引き当て処理追加要		

		rec_alloc = {}  ###instks,outstks作成用
		###fields = {}
		rec_alloc["srctblname"]  = tblname
		rec_alloc["srctblid"]  = tblid
		rec_alloc["qty_sch"]  = gantt["qty_sch"].to_f - gantt["qty_alloc"]
		rec_alloc["qty"]  = 0  ### childはschsのみ
		rec_alloc["qty_stk"]  = 0
		rec_alloc["qty_linkto_alloctbl"] = 0
		rec_alloc["remark"] = "482"
		rec_alloc["trngantts_id"]  =  trngantts_id 
		insert_alloctbls rec_alloc
		
		
		rec_alloc["itms_id"] = gantt["itms_id"] 
		rec_alloc["processseq"] = child["processseq"] 
		rec_alloc["prjnos_id"] = tbldata["prjnos_id"]
		strsql = %Q%select * from r_#{tblname} where id = #{tblid}
		%
		command_r = ActiveRecord::Base.connection.select_one(strsql)
	 	if tblname =~ /^pur|^prd/
			rec_alloc["alloctbls_id"] = rec_alloc["id"]
			rec_alloc["shelfnos_id_in"] = tbldata["shelfnos_id_to"]
			### starttime:lotstkhists 在庫変化日　  pur,prd:発注日、作業開始日
			rec_alloc["starttime"] = tbldata["duedate"]
			rec_alloc["lotno"] = tbldata["lotno"]
			rec_alloc["packno"] = tbldata["packno"]
			rec_alloc["inoutflg"] = tblname
	 		proc_mk_instks_rec rec_alloc,"add"
	 	end			
		 ###元がordsの時のみ子のschsをords等に引き当てる。
		if reqparams["orgtblname"] =~ /ords$/   ###child_trnganttsのデータはxxxschsのデータのみ　
			reqparams["trngantts_id"] = gantt["id"] = trngantts_id
			###新規登録なのでqty_linkto_alloctbl=0
			###親が新規登録後引き当る可能性があるのでqty_alloc != 0
			required_sch_qty = gantt["qty_sch"].to_f - gantt["qty_alloc"].to_f - gantt["qty_bal"].to_f
			schstbl_alloc_to_freetbl(tblname,tblid,reqparams,gantt,required_sch_qty) ###trn==sch
		end
		return trngantts_id,reqparams,rec
	end

	# def add_alloc_and_trn free,sch,sch_to_ord_qty,sch_to_stk_qty,sourceline ###free:free_trngantts    sch:custords等のtrngantts  
	# 	###
	# 	#### free のxxxords,insts,actsのalloctblsの変更
	# 	###
	# 	### free引き当て可能数の減 qtyは変更数をセット
	# 	fields = {:trngantts_id=>free["id"],:srctblname=>free["tblname"],:srctblid=>free["tblid"],
	# 				:remark=>"161 <-- #{sourceline[0..100]} ",   ###qty_schは引当には関係しない。
	# 				:inoutflg =>free["orgtblname"] ,
	# 				:qty_linkto_alloctbl=>(sch_to_ord_qty + sch_to_stk_qty),
	# 				:itms_id=>free["itms_id"],:processseq=>free["processseq"],:prjnos_id=>free["prjnos_id"]} 
	# 	###追加の数量，親からの引当数(qty_alloc)=0 
	# 	### 引き当て可能数の減
	# 	rec = add_update_alloctbls fields ###,command_r   ###➀ trngantts:alloctbls=1:1
	# 	###
	# 	#### free to alloc 
	# 	###
	# 	### free trnganttsに引き当っている内訳(alloctbls)を作成。freeからtrnganttsの構成に変更。	
	# 	fields = {:trngantts_id=>sch["id"],:srctblname=>free["tblname"],:srctblid=>free["tblid"],
	# 				:remark=>" 280 <--#{sourceline[0..100]} ",
	# 				:inoutflg =>free["orgtblname"],
	# 				:qty=>sch_to_ord_qty ,:qty_stk=>sch_to_stk_qty,
	# 				:itms_id=>free["itms_id"],:processseq=>free["processseq"],:prjnos_id=>free["prjnos_id"]}
	# 	###
	# 	ord_alloc = add_update_alloctbls fields  ###,command_r     ###➁trngantts:alloctbls=1:n
	# 	###
	# 	#### sch のalloctblsの変更
	# 	###
	# 	### 既に登録済のはず
	# 	if  sourceline =~ /^full/   ###packqty対応
	# 		new_qty = add_free_qty - sch["qty_sch"].to_f
	# 	else
	# 		new_qty = 0
	# 	end	
	# 	fields = {:trngantts_id=>sch["id"],:srctblname=>sch["tblname"],:srctblid=>sch["tblid"],
	# 			:remark=>" 295 <---#{sourceline[0..100]}",
	# 			:inoutflg =>sch["tblname"],
	# 			:qty_linkto_alloctbl=>sch_to_ord_qty + sch_to_stk_qty ,
	# 			:itms_id=>sch["itms_id"],:processseq=>sch["processseq"],:prjnos_id=>sch["prjnos_id"]} 
	# 	###　引当済数の追加
	# 	sch_alloc = add_update_alloctbls fields ###,command_r    ###➂		###trngantts:alloctbls=1:1
	# 	#### free to alloc
	# 	###
	# 	return sch_alloc
	# end

	def add_update_alloctbls alloc ###,command_r ###allocのqtyには増減分をセット
		###freeのin-out数変更
		strsql = %Q%select  id,qty,qty_stk,qty_linkto_alloctbl,remark from alloctbls 
				where srctblname = '#{alloc[:srctblname]}' and srctblid = #{alloc[:srctblid]} 
				and trngantts_id = #{alloc[:trngantts_id]} 
			%
		rec = ActiveRecord::Base.connection.select_one(strsql)
		if rec 
			alloc[:alloctbls_id] = rec["id"]
			if alloc[:qty_linkto_alloctbl].nil?
				qty_linkto_alloctbl = rec["qty_linkto_alloctbl"].to_f
			else
				qty_linkto_alloctbl = alloc[:qty_linkto_alloctbl] + rec["qty_linkto_alloctbl"].to_f
			end
			if alloc[:qty_sch].nil?
				alloc[:qty_sch] = rec["qty_sch"].to_f
			else
				alloc[:qty_sch] = alloc[:qty_sch] + rec["qty_sch"].to_f
			end
			if alloc[:qty].nil?
				alloc[:qty] = rec["qty"].to_f
			else
				alloc[:qty] = alloc[:qty] + rec["qty"].to_f
			end
			if alloc[:qty_stk].nil?
				alloc[:qty_stk] = rec["qty_stk"].to_f
			else
				alloc[:qty_stk] = alloc[:qty_stk] + rec["qty_stk"].to_f
			end
			strsql = %Q&update alloctbls set 
						updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						qty_linkto_alloctbl = #{alloc[:qty_linkto_alloctbl]},
						qty_sch = #{alloc[:qty_sch]},qty = #{alloc[:qty]},qty_stk = #{alloc[:qty_stk]},
						remark = '336 <--#{(alloc[:remark]+rec["remark"])[0..100]}' where id = #{rec["id"]}
						&
			ActiveRecord::Base.connection.update(strsql)
			au = "update"
		else
			rec_alloc = {}
			rec_alloc = insert_alloctbls alloc.stringify_keys
			alloc[:alloctbls_id] = rec_alloc["id"]
			au = "add"
		end	
		case tblname
			when /^pur|^prd/
				proc_mk_instks_rec alloc,au
			when /^cust/
				mk_custwhs_rec alloc,au
		end	
		return alloc
	end	

	def insert_trngantt gantt
		strsql = %Q&
		insert into trngantts(id,key,
							orgtblname,orgtblid,paretblname,paretblid,
							tblname,tblid,
							mlevel,
							shuffle_flg,
							parenum,chilnum,
							qty,qty_stk,qty_bal,
							qty_alloc,
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
			values(#{gantt["trngantts_id"]},'#{gantt["key"]}',
						'#{gantt["orgtblname"]}',#{gantt["orgtblid"]},'#{gantt["paretblname"]}',#{gantt["paretblid"]},
						'#{gantt["tblname"]}',#{gantt["tblid"]},
						'#{gantt["mlevel"]}',
						'#{gantt["shuffle_flg"]}',
						#{gantt["parenum"]},#{gantt["chilnum"]},
						#{gantt["qty"]},#{gantt["qty_stk"]},#{gantt["qty_bal"]},
						#{gantt["qty_alloc"]},
						#{gantt["qty_pare"]},#{gantt["qty_stk_pare"]},#{gantt["qty_pare_alloc"]},#{gantt["qty_pare_bal"]},
						#{gantt["itms_id"]},#{gantt["processseq"]},#{gantt["shelfnos_id_fm"]},#{gantt["prjnos_id"]},#{gantt["locas_id"]},
						#{gantt["itms_id_pare"]},#{gantt["processseq_pare"]},#{gantt["locas_id_pare"]},
						'#{gantt["consumtype"]}',#{gantt["consumunitqty"]},#{gantt["consumminqty"]},#{gantt["consumchgoverqty"]},
						to_timestamp('#{gantt["starttime"]}','yyyy/mm/dd hh24:mi:ss'),
						to_timestamp('#{gantt["duedate"]}','yyyy/mm/dd hh24:mi:ss'),
						to_timestamp('#{gantt["duedate_org"]}','yyyy/mm/dd hh24:mi:ss'),
						to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						' ','0','2099/12/31','#{gantt["remark"]}')
		&
		ActiveRecord::Base.connection.insert(strsql)
		return
	end

	def insert_alloctbls rec_alloc
		rec_alloc["id"] = RorBlkctl.proc_get_nextval("alloctbls_seq")
		strsql = %Q&
		insert into alloctbls(id,
							srctblname,srctblid,
							trngantts_id,lotstkhists_id_alloctbl ,
							qty_sch,qty,qty_stk,
							qty_linkto_alloctbl,
							created_at,
							updated_at,
							update_ip,persons_id_upd,expiredate,remark)
					values(#{rec_alloc["id"]},
							'#{rec_alloc["srctblname"]}',#{rec_alloc["srctblid"]},
							#{rec_alloc["trngantts_id"]},0,
							#{rec_alloc["qty_sch"]},#{rec_alloc["qty"]},#{rec_alloc["qty_stk"]},
							#{rec_alloc["qty_linkto_alloctbl"]},
							to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
							to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
							' ','0','2099/12/31','#{rec_alloc["remark"]}')
		&
		ActiveRecord::Base.connection.insert(strsql)
		return rec_alloc
	end

	def schstbl_alloc_to_freetbl  tblname,tblid,reqparams,sch,required_sch_qty
		   ###qty 発注又は製造まとめ数　在庫があるときは qty - qty_bal が必要数になる。未対応 
		tbldata = reqparams["tbldata"]
		opeitm = reqparams["opeitm"]
		###freeを探す　xxxordsのみ引き当てる。
		strsql = %Q%select locas_id_shelfno from shelfnos where id = #{tbldata["shelfnos_id_to"]}
		%
		locas_id_shelfno =  ActiveRecord::Base.connection.select_value(strsql)

		strsql = %Q&select   ---  free
					case
					when gantt.qty_stk >  gantt.qty_alloc
						then '02' 
					when  gantt.duedate <= to_date('#{tbldata["duedate"]}','yyyy-mm-/dd')
						then '01'	
					else
						'03' end  priority,
					to_number(to_char(duedate,'yyyymmdd'),'99999999')*-1 due,
					(alloc.qty - alloc.qty_linkto_alloctbl )  qty,
					gantt.qty_alloc qty_alloc,
					gantt.qty_pare_alloc qty_pare_alloc,gantt.itms_id,gantt.prjnos_id,gantt.shelfnos_id_fm,
					gantt.id id,gantt.orgtblname orgtblname,gantt.orgtblid orgtblid,gantt.tblname tblname,gantt.tblid tblid,
					alloc.srctblname srctblname,alloc.srctblid srctblid,alloc.trngantts_id trngantts_id			
					from trngantts gantt
					inner join alloctbls alloc on gantt.id = alloc.trngantts_id and gantt.orgtblname = alloc.srctblname 
													and gantt.orgtblid = alloc.srctblid
					inner join shelfnos c on gantt.shelfnos_id_fm = c.id
					where gantt.prjnos_id =  #{tbldata["prjnos_id"]}
						and gantt.orgtblname = gantt.paretblname and gantt.paretblname = gantt.tblname
						and gantt.orgtblid = gantt.paretblid  and gantt.paretblid = gantt.tblid
						and  gantt.itms_id = #{opeitm["itms_id"]} and gantt.processseq = #{opeitm["processseq"]}
						and c.locas_id_shelfno = #{locas_id_shelfno}
						and (gantt.tblname like 'prd%' or gantt.tblname like 'pur%'  or gantt.tblname = '未定在庫調整' )
						--- freeの在庫　　未定
						and ((alloc.qty - alloc.qty_linkto_alloctbl) >  0 or (alloc.qty_stk - alloc.qty_linkto_alloctbl) >  0) 
						 --- free trnではfree["qty_alloc"].to_f==0 
						order by priority,due
						---for update
					& ### xxxacts等を登録するときは必ずxxxordsを前に登録すること。
		ActiveRecord::Base.connection.select_all(strsql).each do |free|   ### free trnではfree["qty_alloc"].to_f==0 
			bal_free_qty = free["qty"].to_f 
			bal_free_qty_stk = free["qty_stk"].to_f
			src = {"srctblname"=>sch["tblname"],"srctblid"=>sch["tblid"],"trngantts_id"=>free["trngantts_id"]} 
			qty_src = 0
			if bal_free_qty >= required_sch_qty
				###sch_alloc = add_alloc_and_trn free,sch,required_sch_qty,0,"full_558"  ###引きあたったalloc作成
				bal_free_qty -= required_sch_qty 
				src["qty_src"] = required_sch_qty
			else
				if bal_free_qty_stk >= required_sch_qty
					###sch_alloc = add_alloc_and_trn free,sch,0,required_sch_qty,"full_562" ###引きあたったalloc作成
					bal_free_qty_stk -= required_sch_qty
					src["qty_src"] = required_sch_qty
				else
					if bal_free_qty > 0
						###sch_alloc = add_alloc_and_trn free,sch,bal_free_qty,0,"566" ###引きあたったalloc作成
						src["qty_src"] = bal_free_qty
						bal_free_qty = 0
					else
						if bal_free_qty_stk > 0
							###sch_alloc = add_alloc_and_trn free,sch,0,bal_free_qty_stk,"570" ###引きあたったalloc作成
							src["qty_src"] = bal_free_qty_stk
							bal_free_qty_stk = 0
						else
							p"error 567"
						end		
					end	
				end	
			end  ###
			prev_trngantts_update free["srctblname"],free["srctblid"],src 		 
			###qty_schからqtyに変化分の消費分のoutstk作成
			###qty_schの減、freeのqtyの減のstkinoutは既に作成済なので対応不要
			reqparams["segment"]  =  "consume_self_ord_parts"  ### 
			processreqs_id ,reqparams= Operation.proc_processreqs_add free["tblname"],free["tblid"],free["tblname"],free["tblid"],reqparams			   
		end
		
		return
	end	

	def alloc_strsql tbldata,opeitm,locas_id_shelfno,src_no  ###free ords等に引き当るschを探す
		%Q&
		select gantt.id id,gantt.id trngantts_id,
		'01' priority,to_number(to_char(duedate,'yyyymmdd'),'99999999')*-1 due,alloc.id alloc_id,
		(alloc.qty_sch  - alloc.qty_linkto_alloctbl - gantt.qty_bal) required_sch_qty,
		alloc.qty_sch,alloc.srctblname, alloc.srctblid,   --- packqty分変更する可能性あり
		alloc.qty_linkto_alloctbl qty_linkto_alloctbl,
		gantt.qty sch_qty,gantt.qty_alloc qty_alloc,
		gantt.qty_pare_alloc sch_qty_pare_alloc,
		gantt.orgtblname orgtblname,gantt.orgtblid orgtblid,gantt.tblname tblname,gantt.tblid tblid,
		gantt.itms_id,gantt.processseq,o.packqty,gantt.expiredate,gantt.remark sch_remark,
		gantt.qty_bal,		
		gantt.qty_pare sch_qty_pare,gantt.parenum,gantt.chilnum#{src_no}
		from trngantts gantt  --- schでは　trn:alloc= 1:1
		inner join shelfnos c on  gantt.shelfnos_id_fm = c.id
		inner join alloctbls d on  gantt.id = alloc.trngantts_id
		inner join opeitms o on  gantt.itms_id = o.itms_id and gantt.processseq = o.processseq and gantt.locas_id = o.locas_id
		#{yield}
		where gantt.prjnos_id =  #{tbldata["prjnos_id"]}
			and gantt.orgtblname like '%ords'  --- topがordsのみ対象
			and  gantt.paretblid != gantt.tblid and gantt.tblname like '%schs'
			and  gantt.itms_id = #{opeitm["itms_id"]} and gantt.processseq = #{opeitm["processseq"]}
			and c.locas_id_shelfno = #{locas_id_shelfno}
			and gantt.tblname = alloc.srctblname and gantt.tblid = alloc.srctblid
			and (alloc.qty_sch -  alloc.qty_linkto_alloctbl ) > 0  ---  マイナスqty_bal
			and (gantt.qty_sch + gantt.qty + gantt.qty_stk -  gantt.qty_alloc ) > 0  
		order by o.priority,gantt.duedate,gantt.id for update of gantt,alloc ---alloc.qty_linkto_alloctbl insts,actsに既に移行済
		&
	end
	
	### free purords又はprdords
	def free_ordtbl_alloc_to_sch  free,reqparams,tblname 
		 ###freeで登録されたordを引き当てる。free:trngantts-->orgtblid=paretblid=tblid
		tbldata = reqparams["tbldata"]
		opeitm = reqparams["opeitm"]
		srctblname = tblname.gsub("ord","sch")
		strsql = %Q%select locas_id_shelfno from shelfnos where id = #{opeitm["shelfnos_id"]}
		%  ### free trn org=pare=tbl では qty - qty_linkto_alloctblがfree残数
		locas_id_shelfno =  ActiveRecord::Base.connection.select_value(strsql)
		# case reqparams["segment"]  
		# when "trngantts"
		src_no = tbldata["src_no"]
		src_snocno = reqparams["src_snocno"]
		sqlsrc_snocno = ""
		if src_no == ""
				strsql = alloc_strsql tbldata,opeitm,locas_id_shelfno,sqlsrc_snocno do 
						""
				end
		else   ###xxxordsでxxxschsのsnoを指定したとき
				src_snocno = reqparams["src_snocno"]
				sqlsrc_snocno = ",#{reqparams["src_snocno"]}"
				strsql = alloc_strsql tbldata,opeitm,locas_id_shelfno,sqlsrc_snocno do
						%Q%inner join #{srctblname} sch on "
								sch.#{src_snocno} = '#{src_no}' %
				end
		end
		###else	
			###Rails.logger.debug" error segment:#{reqparams["segment"]} \n reqparams: #{reqparams} "
			###Rails.logger.debug" error free: #{free} "
		###end
		ActiveRecord::Base.connection.select_all(strsql).each do |sch|  ###freeを求めているschsを検索
			###freeのtrngantts freeのqtyとfreeのqty_stkはレコードが分かれる。
			srctbldata = {"srctblname"=>sch["tblname"],"srctblid"=>sch["tblid"],
				"sno"=>"","cno"=>"",trngantts_id=>sch["trngantts_id"],"qty_src"=>0}
			bal_free_qty = free["qty"].to_f 
			bal_free_qty_stk = free["qty_stk"].to_f ### free_recのqty_allocはzero ,新規のためqty_linkto_alloctblはzero 
			required_sch_qty =  sch["required_sch_qty"].to_f
			if bal_free_qty >= required_sch_qty 
				##fields = add_alloc_and_trn free,sch, required_sch_qty,0,"full_662" ###freeに引きあたったalloc作成
				srctbldata["qty_src"] = required_sch_qty
				##qty_linkto_alloctbl = required_sch_qty
				bal_free_qty -= required_sch_qty
				bal_free_qty_stk = 0
			else	
				if bal_free_qty_stk >= required_sch_qty 
					###fields = add_alloc_and_trn free,sch,0, required_sch_qty,"full_667" ###freeに引きあたったalloc作成
					###qty_linkto_alloctbl = required_sch_qty
					srctbldata["qty_src"] = required_sch_qty
					bal_free_qty_stk -= required_sch_qty
					bal_free_qty = 0
				else
					if bal_free_qty > 0 
						###fields = add_alloc_and_trn free,sch, bal_free_qty,0,"672" ###freeに引きあたったalloc作成
						srctbldata["qty_src"] = bal_free_qty
						##qty_linkto_alloctbl = bal_free_qty
						bal_free_qty = 0
						bal_free_qty_stk = 0
					else
						if bal_free_qty_stk > 0
							###fields = add_alloc_and_trn free,sch, 0,bal_free_qty_stk,"676" ###freeに引きあたったalloc作成
							srctbldata["qty_src"] = bal_free_qty
							###qty_linkto_alloctbl = bal_free_qty_stk
							bal_free_qty_stk = 0
							bal_free_qty = 0
						end
					end
				end
				###
			end
			###add_update_linktbls sch["srctblname"],sch["srctblid"],tblname,tbldata
			prev_trngantts_update  tblname,free["tblid"],srctbldata
			
			fields = {:qty_alloc =>srctbldata["qty"] + srctbldata["qty_stk"]}
			free_ordtbl_to_alloc_child sch,fields  ###親が別の親に引き当ったので子供の引き当てを解除する。
			break if bal_free_qty <= 0 and  bal_free_qty_stk <= 0 
		end
		return
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
		ActiveRecord::Base.connection.select_one(strsql).each do |rec|
			gfields = {}
			gfields[:qty_pare_alloc] =  fields[:qty_alloc] 
			gfields[:qty_alloc] =  fields[:qty_alloc] * child["chilnum"].to_f / child["parenum"].to_f
			update_sql = %Q& 
						update trngantts set qty_alloc = #{gfields[:qty_alloc]},qty_pare_alloc = #{gfields[:qty_pare_alloc]}
								where id = #{rec["id"]}
					&
			ActiveRecord::Base.connection.update(update_sql)
			bal_qty = rec["qty"].to_f - rec["qty_alloc"].to_f
			strsql = %Q%select *,((qty_sch + qty + qty_stk) - qty_linkto_alloctbl) bql_qty
							from alloctbls where trngantts_id = #{rec["id"]}
							and ((qty_sch + qty + qty_stk) - qty_linkto_alloctbl) > 0
							for update
			%
			ActiveRecord::Base.connection.select_all(strsql).each do |child| ###下位構成の引き当てなおし
				###本体の子の構成は親からの引き当ての継続　直接ordsには引きあたらない。
				##gfields[:qty_pare] = fields[:qty_pare]
				if bal_qty > child["bal_qty"].to_f 
					bal_qty = bal_qty - child["bal_qty"].to_f
				else
					case
					when child["qty_sch"] > 0
						qty_sch = bal_qty
						qty = 0
						qty_stk = 0
					when child["qty"] > 0
						qty_sch = 0
						qty = bal_qty
						qty_stk = 0
					when child["qty_stk"] > 0
						qty_sch = 0
						qty = 0
						qty_stk = bal_qty
					end
					update_sql = %Q& 
								update alloctbls set qty_sch = #{qty_sch},qty = #{qty},qty_stk = #{qty_stk}
										where id = #{child["id"]}
							&
					ActiveRecord::Base.connection.update(update_sql)
					strsql = %Q&select * from linktbls where
												tblname = '#{child["srctblname"]}' and tblid = #{child["srctblid"]} and
												trngantts_id = #{child["trngantts_id"]}  
					&
					ActiveRecord::Base.connection.select_all(strsql).each do |link|
						if link["qty_src"].to_f > bal_qty
							new_bal_qty = bal_qty
							bal_qty = 0
						else
							new_bal_qty =  link["qty_src"].to_f 
							bal_qty -= new_bal_qty
						end
						src = {"srctblname"=>link["srctblname"],"srctblid"=>link["srctblid"],
								"trngantts_id"=>link["trngantts_id"],"qty_src"=>new_bal_qty * -1}						
						prev_trngantts_update child["srctblname"],child["srctblid"],src
						break if bal_qty <= 0
					end
					free_ordtbl_to_alloc_child rec,gfields   ###
				end
			end
		end
	end	

	def add_update_linktbls srctblname,srctblid,tblname,tblid,src
		###sno,cnoでの前の状態との関係  tbldata = {"id"=>,"qty"=>,"qty_stk"=>}
		strsql = %Q% select id from linktbls where srctblid = #{srctblid} and srctblname = '#{srctblname}'
							and tblname = '#{tblname}' and tblid = #{tblid}
							and trngantts_id = #{trngantts_id}
				%
		rec = ActiveRecord::Base.connection.select_one(strsql)
		if rec
				strsql = %Q% update linktbls set  updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								qty_src = #{tbldata["qty"].to_f+tbldata["qty_stk"].to_f} + qty_src
								where id = #{rec["id"]}					
				%
				ActiveRecord::Base.connection.update(strsql) 
		else
				srctbls_seq = RorBlkctl.proc_get_nextval("srctbls_seq")
				sno_sym = ("sno_" + srctblname.chop)
				cno_sym = ("cno_" + srctblname.chop) 
				strsql = %Q%insert into linktbls(id,trngantts_id,
						srctblname,sno,cno,srctblid,
						tblname,tblid,qty_src,
						created_at,
						updated_at,
						update_ip,persons_id_upd,expiredate,remark)
					values(#{srctbls_seq},trngantts_id,
						'#{srctblname}','#{(tbldata[sno_sym]||="")}','#{(tbldata[cno_sym]||="")}',#{srctblid}, 
						'#{tblname}',#{tblid},#{tbldata["qty"].to_f+tbldata["qty_stk"]} , 
						to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						' ',#{@sio_user_code||=0},'2099/12/31','')
					%
				ActiveRecord::Base.connection.insert(strsql) 
		end
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
					add_tbl << %Q% inner join (select alloc.*,src.srctblid from r_#{tblxxx} a inner join linktbls src 
								on alloc.id = src.tblid 
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

			tbldatalloc.each do |field_delm,val|
				if field_delm =~ /_#{sel}$/ and val != "" and !val.nil?
						field,delm = field_delm.split("_#{sel}")
						# strsql = "select fieldcode_ftype from r_fieldcodes rf  where pobject_code_fld = '#{field}'"
						# ftype = ActiveRecord::Base.connection.select_value(strsql)
						ftype = $ftype["field"]
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
					 (alloc.qty - alloc.qty_linkto_alloctbl) qty		, 
					gantt.qty_bal,
					to_char(gantt.duedate,'yyyy/mm/dd') duedate,
					gantt.prjnos_id,opeitm.shelfnos_id shelfnos_id_to,
					gantt.id trngantts_id,gantt.expiredate,
					alloc.srctblname,alloc.srctblid,gantt.id trngantts_id
				from trngantts gantt #{if add_tbl.size > 1 then add_tbl.chop else "" end } 
					inner join opeitms opeitm on opeitm.itms_id = gantt.itms_id and opeitm.processseq = gantt.processseq
					inner join alloctbls a on alloc.trngantts_id = gantt.id
				where #{strwhere["org"]}  #{strwhere["pare"]}  #{strwhere["trn"]}
					(alloc.qty -  alloc.qty_linkto_alloctbl) > 0
					and alloc.srctblname like '%schs'
					 --- and not exists(select 1 from schofmkords mk 
					 				--- where mk.trngantts_id = gantt.id
									--- and mk.mkords_id = #{reqparams["mkords_id"]}) 
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
		tblord = ""
		while !sch.nil? do
			sch = ActiveRecord::Base.connection.select_one(base_strsql+item_sel_order_by)
			if sch   ###納期の一番古い品目を選択
				tblord = sch["tblname"].chop.gsub("sch","ord")
				duedate = tblord + "_duedate"
				symqty = tblord + "_qty"
				command_c["#{tblord}_id"] = command_c["id"] = proc_get_nextval("#{tblord}s_seq")
				command_c[:sio_code] =  "r_#{tblord}s"
				command_c[:sio_viewname] =  "r_#{tblord}s"
				command_c[:sio_message_contents] = nil
				command_c[:sio_recordcount] = 1
				command_c[:sio_result_f] =   "0"  
				command_c[:sio_classname] = "_add_ord_by_mkord"
				###納期にかかわらず同一品目を納期順に並べるrec["id"] = 
				str_order_by = "and gantt.itms_id = #{sch["itms_id"]} and gantt.processseq = #{sch["processseq"]} 
								order by  gantt.locas_id,gantt.itms_id,gantt.processseq,shelfnos_id_to, 
								gantt.itms_id_pare,gantt.processseq_pare,
								duedate for update  of gantt  ---  group byではupdateが使用できない。"	
				ActiveRecord::Base.connection.select_all(base_strsql+str_order_by).each do |rec,index|
					mkordparams[:incnt] += 1
					mkordparams[:inqty] +=  rec["qty"].to_f
					# schofmkords_insert  reqparams["mkords_id"],rec ###xxxordsのalloctblを作成のためxxxschsのtrngantts_idをsave
					if rec["itms_id"] == (save_rec["itms_id"]) and
						rec["processseq"] == (save_rec["processseq"]||="0") and 
						rec["itms_id_pare"] == (save_rec["itms_id_pare"]||="0") and
						rec["processseq_pare"] == (save_rec["processseq_pare"]||="0") and 
						rec["locas_id"] == (save_rec["locas_id"]||="0") and
						rec["prjnos_id"] == (save_rec["prjnos_id"]||="0")  and
						rec["shelfnos_id_to"] == (save_rec["shelfnos_id_to"]||="0") 
						###期間まとめ期間の確認
						###command_c は###get schsで求めている。
						qty_bal += rec["qty_bal"].to_f
						if rec["duedate"].to_date <= (command_c[duedate].to_date  + command_c["opeitm_opt_fixoterm"].to_i) or
								command_c["opeitm_opt_fixoterm"].to_i  == 0   ###opeitm_opt_fixoterm=0まとめなし
							aqty +=   rec["qty"].to_f - qty_bal ###
							max_qty += rec["qty"].to_f  
							### 発注単位　作業分割未実施
							srctbldata = {"srctblname"=>rec["srctblname"],"srctblid"=>rec["srctblid"],
											"qty_src"=>rec["qty"],"trngantts_id"=>rec["trngantts_id"],	
											"sno"=>"","cno"=>""}
							prev_trngantts_update  "#{tblord}s",command_c["id"],srctbldata
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
							RorBlkctl.proc_update_table  command_c,1
							srctbldata = {"srctblname"=>rec["srctblname"],"srctblid"=>rec["srctblid"],
											"sno"=>"","cno"=>"",trngantts_id=>rec["trngantts_id"],
											"qty_src"=>command_c[symqty]}	
							prev_trngantts_update  "#{tblord}s",command_c["id"],rec["trngantts_id"],srctbldata
							command_c["#{tblord}_id"] = command_c["id"] = proc_get_nextval("#{tblord}s_seq")
							mkordparams[:outcnt] += 1
							mkordparams[:outqty] +=  command_c[symqty]
							command_c[duedate] = rec["duedate"]
							max_qty = 0
							qty_bal = 0
							aqty +=   rec["qty"].to_f - qty_bal ###
							max_qty += rec["qty"].to_f - qty_bal 
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
							srctbldata = {"srctblname"=>rec["srctblname"],"srctblid"=>rec["srctblid"],
											"sno"=>"","cno"=>"",trngantts_id=>rec["trngantts_id"],
											"qty_src"=>command_c[symqty]}
							prev_trngantts_update  "#{tblord}s",command_c["id"],srctbldata
							command_c["#{tblord}_id"] = command_c["id"] = proc_get_nextval("#{tblord}s_seq")
						end
						qty_bal = rec["qty_bal"].to_f
						save_rec["tblid"] = rec["tblid"]
						strsql = %Q%select * from r_#{rec["srctblname"]} where id = #{rec["srctblid"]}
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
					save_rec = rec.dup   ###get opeitm
					max_qty = rec["qty"].to_f
					aqty =   rec["qty"].to_f   ###qty qty_bal考慮済
					###mk_mkordopeitms reqparams["mkords_id"],save_rec
				end
			else
				sch = nil	
			end	 
		end
			### parenum chilnum	
			###最後のレコードの処理
		###未処理－－＞最大発注量の分割
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
			srctbldata = {"srctblname"=>save_rec["srctblname"],"srctblid"=>save_rec["srctblid"],
							"sno"=>"","cno"=>"",trngantts_id=>save_rec["trngantts_id"],
							"qty_src"=>command_c[symqty]}
			prev_trngantts_update  "#{tblord}s",command_c["id"],srctbldata
			mkordparams[:outcnt] += 1
			mkordparams[:outqty] +=  command_c["symqty"].to_f	
		end
		return mkordparams
	end	

	# def schofmkords_insert mkords_id,rec   ### schsをfreeのords引き当てるときに使用。対象のitms_id等を求める
	# 	### proc_mkordsの時一時的に使用
	# 	id = RorBlkctl.proc_get_nextval("schofmkords_seq")
	# 	strsql = %Q&
	# 		insert into schofmkords(id,itms_id,processseq,
	# 							mkords_id,trngantts_id,
	# 							created_at,
	# 							updated_at,
	# 							update_ip,persons_id_upd,expiredate,remark)
	# 					values(#{id},#{rec["itms_id"]},#{rec["processseq"]},
	# 							#{mkords_id},#{rec["trngantts_id"]},
	# 							to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
	# 							to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
	# 							' ','#{@sio_user_code||=0}','#{rec["expiredate"]}','')
	# 	&
	# 	ActiveRecord::Base.connection.insert(strsql) 
	# end

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
		when /^prd/   
			amtinout["locas_id_out"] = command_r["opeitm_loca_id_opeitm"] 
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
			if tblname =~ /^prd|^pur/
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
		if au == "add"
				ActiveRecord::Base.connection.insert(outstk_strsql(stkinout)) 
		else
			strsql = %Q&select  lot.*,alloc.id alloctbls_id
									from lotstkhists lot
									inner join alloctbls alloc on lot.id = alloc.lotstkhists_id 
									where alloc.id = #{stkinout["alloctbls_id"]} 
								for update
			&	
			rec = ActiveRecord::Base.connection.select_all(strsql)
			lotstkhists_in_out "upd", rec   ###,old_alloc,""
			update_sql = %Q%
					update outstks set 
						starttime = '#{stkinout["starttime"]}',
						lotno = '#{stkinout["lotno"]}' ,
						packno = '#{stkinout["packno"]}',
						shelfnos_id_out = #{stkinout["shelfnos_id_out"]},
						updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						expiredate = '#{rec["expiredate"]}'
						where id = #{rec["alloctbls_id"]}
					%
			ActiveRecord::Base.connection.update(update_sql)
		end
		lotstkhists_seq = lotstkhists_in_out "out", stkinout   ###,old_alloc,""
		update_sql = %Q%
			update alloctbls set lotstkhists_id = #{lotstkhists_seq}
				where id = #{rec["alloctbls_id"]} 
		%
		ActiveRecord::Base.connection.update(update_sql)
		return
	end

	def outstk_strsql stkinout,outstks_id
		outstks_id = RorBlkctl.proc_get_nextval("outstks_seq")
		strsql = %Q&
				insert into outstks(id,alloctbls_id,shelfnos_id_out,
								starttime,
								---qty,qty_stk,qty_sch,
								lotno,packno,inoutflg,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{outstks_id},#{stkinout["alloctbls_id"]},#{stkinout["shelfnos_id_out"]},
								'#{stkinout["starttime"]}',
								---#{stkinout["qty"]},#{stkinout["qty_stk"]},#{stkinout["qty_sch"]},
								'#{stkinout["lotno"]}','#{stkinout["packno"]}','#{stkinout["inoutflg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','#{@sio_user_code||=0}','2099/12/31','')
		&
	end 	

	def proc_mk_instks_rec stkinout,au
		if au == "add"
				instks_id = RorBlkctl.proc_get_nextval("instks_seq")
				strsql = %Q&
					insert into instks(id,alloctbls_id,shelfnos_id_in,
								starttime,
								lotno,packno,inoutflg,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{instks_id},#{stkinout["alloctbls_id"]},#{stkinout["shelfnos_id_in"]},
								'#{stkinout["starttime"]}',
								'#{stkinout["lotno"]}','#{stkinout["packno"]}','#{stkinout["inoutflg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','#{@sio_user_code||=0}','2099/12/31','')
					&
				ActiveRecord::Base.connection.insert(strsql) 
				lotstkhists_seq = lotstkhists_in_out "in", stkinout   ###,old_alloc,""  ###新規登録のためテーブル情報は不要
				update_sql = %Q%
					update alloctbls set lotstkhists_id = #{lotstkhists_seq}
						where id = #{stkinout["alloctbls_id"]} 
				%
				ActiveRecord::Base.connection.update(update_sql)
		else
			strsql = %Q&select  lot.*,alloc.id alloctbls_id
									from lotstkhists lot
									inner join alloctbls alloc on lot.id = alloc.lotstkhists_id 
									where alloc.id = #{stkinout["alloctbls_id"]} 
								for update
			&	
			rec = ActiveRecord::Base.connection.select_all(strsql)
			rec["qty_sch"] = rec["qty_sch"].to_f * -1  
			rec["qty"] 	   = rec["qty"].to_f * -1  
			rec["qty_stk"] = rec["qty_stk"].to_f * -1  
			lotstkhists_in_out "upd", rec   ###,old_alloc,""
			update_sql = %Q%
					update instks set 
						starttime = '#{stkinout["starttime"]}',
						lotno = '#{stkinout["lotno"]}' ,
						packno = '#{stkinout["packno"]}',
						shelfnos_id_out = #{stkinout["shelfnos_id_out"]},
						updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						expiredate = '#{rec["expiredate"]}'
						where id = #{rec["alloctbls_id"]}
					%
			ActiveRecord::Base.connection.update(update_sql)
			lotstkhists_seq = lotstkhists_in_out "in", stkinout   ###,old_alloc,""
			update_sql = %Q%
				update alloctbls set lotstkhists_id = #{lotstkhists_seq}
					where id = #{rec["alloctbls_id"]} 
			%
			ActiveRecord::Base.connection.update(update_sql)
		end
		return
	end

	def mk_custwhs_rec stkinout,au  ###lotstkhistsは棚のみ
		strsql = %Q&select alloc.id,alloc.srctblname,alloc.srctblid,alloc.qty_sch,alloc.qty,alloc.qty_stk,
							gantt.itms_id, gantt.processseq
							from alloctbls alloc
							inner join trngantts gantt on alloc.trngantts_id = gantt.id
							where orgtblname = paretblname and orgtblid = paretblid
							and (paretblname != tblname or paretblid != tblid)
							and orgtblname = '#{stkinout["srctblname"]}' and orgtblid = #{stkinout["srctblid"]}
							and (alloc.qty_sch + alloc.qty + alloc.qty_stk) > alloc.qty_linkto_alloctbl
		&
		alloc = ActiveRecord::Base.connection.select_one(strsql)
		strsql = %Q&select * from #{alloc["srctblname"]} where id = #{alloc["srctblid"]}
		& 
		tbl = ActiveRecord::Base.connection.select_one(strsql)
		case alloc["srctblname"]
		when /replyinputs$/
			stkinout["starttime"] = tbl["replydate"]
		when /puracts/
			stkinout["starttime"] = tbl["rcptdate"]
		when /prdacts/
			stkinout["starttime"] = tbl["cmpldate"]
		else
			stkinout["starttime"] = tbl["duedate"]
		end		
		stkinout["lotno"] = tbl["lotno"]
		stkinout["packno"] = tbl["packno"]
		stkinout["shelfnos_id_out"] = tbl["shelfnos_id_to"]
		stkinout["alloctbls"] = alloc["id"]

		if au == "add"
			ActiveRecord::Base.connection.insert(outstk_strsql(stkinout)) 

			### locas_id から custrcvplcs_idへの日数未設定
			stkinout["duedate"] = 
			custwhs_id = RorBlkctl.proc_get_nextval("custwhs_seq")
			strsql = %Q&insert into custwhs(id,alloctbls_id,custrcvplcs_id,
								duedate,
								qty,qty_stk,
								lotno,packno,inoutflg,
								created_at,
								updated_at,
								update_ip,persons_id_upd,expiredate,remark)
						values(#{custwhs_id},#{stkinout["alloctbls_id"]},#{stkinout["custrcvplcs_id"]},
								'#{stkinout["duedate"]}',
								'#{stkinout["lotno"]}','#{stkinout["packno"]}','#{stkinout["inoutflg"]}',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								' ','#{@sio_user_code||=0}','2099/12/31','')
				&
				ActiveRecord::Base.connection.insert(strsql)
		else
			###変更　再考要
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
									---qty = #{stkinout["qty"]},qty_sch = #{stkinout["qty_sch"]},
									inoutflg = '#{stkinout["inoutflg"]}',
									updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss')
									---qty_stk = #{stkinout["qty_stk"]},
									---expiredate = '#{stkinout["expiredate"]}
									'
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

	###出庫の前の完成　完成時の員数可変による消費数対応ができてない。"create_other_table_record_jogantt.consume_exception"
	def lotstkhists_in_out kubun,stkinout   ###,old_alloc,srctblname
		case kubun
		when "out" 
			stk_shelfnos_id = stkinout["shelfnos_id_out"]
			inout = -1
			strsql = %Q% select *
									from lotstkhists
									where   itms_id = #{stkinout["itms_id"]} and  shelfnos_id = #{stk_shelfnos_id} and
											processseq = #{stkinout["processseq"]} and
											prjnos_id = #{stkinout["prjnos_id"]} and
											starttime = to_date('#{stkinout["starttime"]}','yyyy-mm-dd hh24:mi:ss') and 
											packno = '#{stkinout["packno"]}' and  lotno = '#{stkinout["lotno"]}'
					%
			lotstkhists =  ActiveRecord::Base.connection.select_one(strsql)
		when "in"
			stk_shelfnos_id =  stkinout["shelfnos_id_in"] 
			inout = 1
			strsql = %Q% select *
									from lotstkhists
									where   itms_id = #{stkinout["itms_id"]} and  shelfnos_id = #{stk_shelfnos_id} and
											processseq = #{stkinout["processseq"]} and
											prjnos_id = #{stkinout["prjnos_id"]} and
											starttime = to_date('#{stkinout["starttime"]}','yyyy-mm-dd hh24:mi:ss') and 
											packno = '#{stkinout["packno"]}' and  lotno = '#{stkinout["lotno"]}'
					%
			lotstkhists =  ActiveRecord::Base.connection.select_one(strsql)
		when "upd"
			stk_shelfnos_id =  stkinout["shelfnos_id"] 
			inout = 1
			lotstkhists = stkinout.dup
		end	
		if lotstkhists.nil?
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
											0,
											0,
											0,
											'#{stkinout["stktaking_proc"]}',
											to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
											to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
											' ',#{@sio_user_code||=0},'2099/12/31','')
					&
				ActiveRecord::Base.connection.insert(strsql) 
				lotstkhists_id = lotstkhists_seq
				stkinout["qty_sch"] = stkinout["qty_sch"].to_f * inout 
				stkinout["qty"]     = stkinout["qty"].to_f * inout 
				stkinout["qty_stk"] = stkinout["qty_stk"].to_f * inout 
		else
				stkinout["qty_sch"] = stkinout["qty_sch"].to_f * inout + lotstkhists["qty_sch"].to_f 
				stkinout["qty"]     = stkinout["qty"].to_f * inout  + lotstkhists["qty"].to_f
				stkinout["qty_stk"] = stkinout["qty_stk"].to_f * inout  +  + lotstkhists["qty_stk"].to_f
				lotstkhists_id = lotstkhists["lotstkhists_id"]
		end
		strsql = %Q% select *
						from lotstkhists
						where   itms_id = #{stkinout["itms_id"]} and  shelfnos_id = #{stk_shelfnos_id} and
							processseq = #{stkinout["processseq"]} and
							prjnos_id = #{stkinout["prjnos_id"]} and
							starttime >= to_date('#{stkinout["starttime"]}','yyyy-mm-dd hh24:mi:ss') and 
							packno = '#{stkinout["packno"]}' and  lotno = '#{stkinout["lotno"]}'
							order by starttime desc for update 
				%
		ActiveRecord::Base.connection.select_all(strsql).each do |futrec|
			strsql = %Q& update lotstkhists set  
									updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
									persons_id_upd = #{@sio_user_code||=0},
									qty_stk = #{stkinout["qty_stk"] * inout + futrec["qty_stk"].to_f},
									qty = #{stkinout["qty"] * inout + futrec["qty"].to_f},
									qty_sch = #{stkinout["qty_sch"].to_f * inout + futrec["qty_sch"].to_f} 
									where id = #{futrec["id"]}					
						&
			ActiveRecord::Base.connection.update(strsql) 
		end		
		return lotstkhists_id
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
					when "payschs"
						command_c["paysch_payment_id_pay"] = command["supplier_payment_id"] 
						command_c["paysch_itm_id"] = command["opeitm_itm_id"] 
						command_c = update_table command_c,totbl do
							"_add_proc_createtable_data"
						end
				end	
			when "puracts"	
			when "purrsltinputs"
				case totbl
					when "payords"
						command_c["payord_payment_id_pay"] = command["supplier_payment_id"] 
						command_c["payord_itm_id"] = command["opeitm_itm_id"] 
						command_c = update_table command_c,totbl do
							"_add_proc_createtable_data"
						end	
					when "puracts"
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

	def prev_trngantts_update tblname,tblid,src   ###

		旧のテーブルとのリンク作成
		add_update_linktbls src["srctblname"],src["srctblid"],tblname,tblid,src

		strsql = %Q%
			select * from  alloctbls alloc 
						where tblname = '#{tblname}' and tblid  = #{tblid} 
						and	srctblname = '#{src["srctblname"]}' and srctblid  = #{src["srctblid"]} 
						and trngantts_id = #{src["trngantts_id"]} for update
				%

		rec = ActiveRecord::Base.connection.select_one(strsql)
		###新規ALLOCのLINK数変更
		update_sql = %Q& 
				update alloctbls set qty_linkto_alloctbl = qty_linkto_alloctbl + #{rec["qty"]} + #{rec["qty_stk"]}
							where id = #{rec["id"]}
		&
		ActiveRecord::Base.connection.update(update_sql)
		###command_c = nil
		### 旧のリンク数変更
		strsql = %Q%
		select * from  alloctbls alloc 
					where srctblname = '#{src["srctblname"]}' and srctblid  = #{src["srctblid"]} 
					and qty > qty_linkto_alloctbl
			%
		link_qty = src["qty_src"].to_f 
		ActiveRecord::Base.connection.select_all(strsql).each do |alloc|
			if (alloc["qty"].to_f + alloc["qty_stk"].to_f) > (alloc["qty_linkto_alloctbl"].to_f + link_qty) 
				qty_linkto_alloctbl = alloc["qty_linkto_alloctbl"].to_f + link_qty
				link_qty = 0
				if alloc["qty"].to_f > alloc["qty_stk"].to_f
					qty = src["qty_src"].to_f
					qty_stk = 0
				else	 
					qty_stk =  src["qty_src"].to_f
					qty = 0
				end	
			else
				qty_linkto_alloctbl = alloc["qty"].to_f + alloc["qty_stk"].to_f
				if alloc["qty"] > alloc["qty_stk"]
					qty = alloc["qty"].to_f - alloc["qty_linkto_alloctbl"].to_f
					link_qty = linkqty + qty
					qty_stk = 0
				else
					qty_stk = alloc["qty_stk"].to_f - alloc["qty_linkto_alloctbl"].to_f
					link_qty = link_qty + qty_stk
					qty = 0
				end		
			end	
			update_sql = %Q& 
					update alloctbls set qty_linkto_alloctbl = #{qty_linkto_alloctbl}
								where id = #{alloc["id"]}
			&
			ActiveRecord::Base.connection.update(update_sql)
			
			###新規LINK作成
			fields = {:srctblname => tblname,:srctblid => tblid,
						:inoutflg=>tblname,:qty_sch=>0,
						:qty=>qty,:qty_alloc=>qty_stk,
						:qty_linkto_alloctbl=>qty_linkto_alloctbl,
						:trngantts_id => alloc["trngantts_id"],:lotstkhists_id => alloc["lotstkhists_id"],
						:remark => " 2068 ",
						:itms_id=>src["itms_id"],:processseq=>src["processseq"],:prjnos_id=>src["prjnos_id"]}
			add_update_alloctbls fields ###,command_c
			case tblname
			when /^pur|^prd/
				proc_mk_instks_rec fields.stringify_keys,"add"
			when /^cust/
				mk_custwhs_rec fields.stringify_keys,"add"
			end	
		end	  
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