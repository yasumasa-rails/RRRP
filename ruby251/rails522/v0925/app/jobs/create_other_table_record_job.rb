class CreateOtherTableRecordJob < ApplicationJob
    queue_as :default 
    def perform(pid)
        # 後で実行したい作業をここに書く
        begin
        ActiveRecord::Base.connection.begin_db_transaction()
            perform_strsql = "select * from  processreqs where result_f = '0'  and seqno = #{pid} order by id limit 1 for update"
            req = ActiveRecord::Base.connection.select_one(perform_strsql)
            until req.nil? do 
                strsql = %Q%update processreqs set result_f = '5'  where id = #{req["id"]}
                %
                ActiveRecord::Base.connection.update(strsql)
                if req["paretblname"].size > 0
                    strsql = %Q%select * from  r_#{req["paretblname"]} where id = #{req["paretblid"]}%
                    parent = ActiveRecord::Base.connection.select_one(strsql) ###依頼元
                else
                    parent = nil
                end
                orgReqParams = JSON.parse(req["reqparams"])
                reqparams = orgReqParams.dup
                tbldata = reqparams["tbldata"]
                strsql = %Q% select email from persons where id = #{tbldata["persons_id_upd"]}
                %
                email = ActiveRecord::Base.connection.select_value(strsql) ###
                result_f = '1'
                remark = "perform 26"
                case reqparams["segment"]
                    when "skip" 
                    when "trngantts" 
                            reqparams = Operation.proc_trngantts req["tblname"],req["tblid"],req["paretblname"],req["paretblid"],reqparams
                    when "opeitm_acceptance_proc"  ### opeitmsのフラグ処理
                        if parent 
                            case req["tblname"]
                            when "purords"  
                                    Operation.proc_createtable("purords","inspords",parent,email)
                                    Operation.proc_createtable("purords","payschs",parent,email)
                            when "puracts"
                                if parent["opeitm_acceptance_proc"] == "1" 
                                    Operation.proc_createtable("puracts","inspacts",parent,email)
                                end    
                            when "inspacts"
                                Operation.proc_createtable("inspacts","payords",parent,email)
                            when /^pay/
                                Operation.proc_amtinouts(req["tblname"],req["tblid"],parent,orgReqParams["trngantts_id"])
                            end
                        else
                            result_f = '7'
                            remark = "opeitm_acceptance_proc parent table data nothing. delete #{req["paretblname"]} id= #{req["paretblid"]} ?" 
                        end
                    when "mkschs"  ### XXXXschs,ordsの時XXXschsを作成
                            case req["tblname"]
                                when /^custords/   ###custxxxではitm_code = 'dummyship'初期設定での登録が必要
                                   qty,trnganttkey = chk_custords_alloc tbldata ###引き当てるcustschsを検索
                                   tbldata["custord_qty"] = qty
                                   strsql = custxxx_strsql tbldata
                                when /^custschs/  ###itm_code = 'dummyship'初期設定での登録が必要
                                    strsql = custxxx_strsql tbldata
                                else
                                    tbl_opeitm_id = req["tblname"].chop + "_opeitm_id"
                                    strsql = %Q%select * from nditms where expiredate > current_date and opeitms_id = #{tbldata["opeitms_id"]}%
                            end
                            trnganttkey ||= 0  ###keyのカウンター
                            key = orgReqParams["trnganttkey"]
                            if key
                                reqparams["orgtrnganttkey"] = key 
                            else
                                reqparams["orgtrnganttkey"] = "00000"
                                key = ""
                            end   
                            ActiveRecord::Base.connection.select_all(strsql).each do |child|
                                command_r,opeitm = add_update_table_from_nditm  child,parent,req["paretblname"]
                                trnganttkey += 1
                                reqparams["trnganttkey"] = key + format('%05d', trnganttkey)
                                reqparams["child"] = child
                                reqparams["opeitm"] = opeitm  ###子部品のopeitms
				                command_r,reqparams = RorBlkctl.proc_private_aud_rec(command_r,1,req["tblname"],req["tblid"],reqparams) 
                                command_r[:sio_result_f] =  "1"   ## 1 normal end
                                command_r[:sio_message_contents] = nil
                                tblname = command_r[:sio_viewname].split("_")[1]
                                tblid = command_r[(tblname.chop + "_id")] =  command_r["id"]
                                RorBlkctl.proc_insert_sio_r(command_r) #### if @pare_class != "batch"    ## 結果のsio書き込み
                            end 
                    when "sumrequest" 
                    when "splitrequest"  
                    when "createtable"
                        if parent 
                            case req["tblname"]
                            ### 仕入れ先登録時仕入れ先の棚番自動登録
                            when "suppliers"
                                Operation.proc_createtable("suppliers","shelfnos",parent,email)
                            ### 作業場所の棚番自動登録
                            when "workplaces"
                                Operation.proc_createtable("workplaces","shelfnos",parent,email)
                            when "custs"
                                Operation.proc_createtable("custs","custrcvplcs",parent,email)
                            end
                        else
                            result_f = '7'
                            remark = "createtable parent table data nothing. delete #{req["paretblname"]} id= #{req["paretblid"]} ?" 
                        end    

                    when "mkords"  ###  xxxschsからxxxordsを作成。
                            incnt, outcnt ,inqty ,outqty, inamt ,outamt = Operation.proc_mkords email,reqparams
                            strsql = %Q%update mkords set incnt = #{incnt},inqty = #{inqty},inamt = #{inamt},
                                                outcnt = #{outcnt},outqty = #{outqty},outamt = #{outamt} where id = #{parent["id"]}
                            %
                            ActiveRecord::Base.connection.update(strsql)

                        # when "mkshpschs"  ###出庫の作成　freeのtrnが対象
                        #     strsql = %Q% select alloc.srctblname,alloc.srctblid ,trn.starttime,ord.sno,
                        #                     trn.id trn_id
                        #                     from trngantts trn
                        #                     inner join (alloctbls alloc inner join instks ins on alloc.id = ins.alloctbls_id)
                        #                                 on trn.id = alloc.trngantts_id  
                        #                     inner join #{req["tblname"]} ord on trn.paretblid = ord.id 
                        #                     where trn.paretblname =  '#{req["tblname"]}' and trn.paretblid = #{req["tblid"]}
                        #                     and trn.orgtblname = trn.paretblname and trn.orgtblid = trn.paretblid
                        #                     and (trn.tblname != trn.paretblname or trn.tblid != trn.paretblid)
                        #     %
                        #     case req["tblname"]
                        #         when /^prd/
                        #             pare_loca_id = parent["workplace_loca_id_workplace"]
                        #         when /^pur/      
                        #             pare_loca_id = parent["supplier_locas_id_supplier"]
                        #     end 
                        #     recs = ActiveRecord::Base.connection.select_all(strsql)
                        #     Operation.proc_mkshpschs recs,email,pare_loca_id

                    when "consume_child_parts"  ###qty_act子部品の消費 ###金型返却　###装置の解放
                            act_qty = (tbldata["qty"]||=tbldata["qty_stk"]).to_f
                            strsql =%Q% select gantt.* ,c_alloc.id alloc_id, '#{req["tblname"]}' act_tblname,#{req["tblid"]} acttblid
                                            from trngantts gantt 
                                            inner join((alloctbls p_alloc inner join srctbls src 
                                                on p_alloc.srctblname = src.srctblname and p_alloc.srctblid = src.srctblid
                                                    and  src.tblname = '#{req["tblname"]}' and src.tblid =  #{req["tblid"]})
                                                    --- xxxactsからxxxords(insts)を求める p_alloc親のalloctbls
                                                    inner join trngantts  pare_trn on p_alloc.trngantts_id = pare_trn.id 
                                                        and pare_trn.paretblname = p_alloc.srctblname and pare_trn.paretblid = p_alloc.srctblid
                                                        and pare_trn.paretblname = pare_trn.orgtblname and pare_trn.paretblid = pare_trn.orgtblid )
                                                        --- 消費する親のords(insts)のfreeのtrnganttsを求める。　　　xxxschsのtrnganttsを除く
                                                        on gantt.paretblid = p_alloc.srctblid  and gantt.paretblname = p_alloc.srctblname
                                            inner join alloctbls c_alloc on gantt.id = c_alloc.trngantts_id 
                                                --- c_alloc消費される子部品のalloctbls
                                                where (c_alloc.qty > c_alloc.qty_linkto_alloctbl or c_alloc.qty_stk >  c_alloc.qty_linkto_alloctbl)
                                                and gantt.orgtblname = gantt.paretblname and gantt.orgtblid = gantt.paretblid
                                                and (gantt.tblname != gantt.paretblname or gantt.tblid != gantt.paretblid)
                                                for update    
                           %
                            ActiveRecord::Base.connection.select_all(strsql).each do |rec|
                                consumtype = (rec["consumtype"]||="")
                                consumtype = consumtype.gsub(" ","")
                                case consumtype
                                when "con" ###子部品の消費
                                    Operation.proc_consume_child_parts rec,act_qty,req["tblname"],req["tblid"]
                                when "" ###子部品の消費
                                    Operation.proc_consume_child_parts rec,act_qty,req["tblname"],req["tblid"]
                                end
                            end

                    when "consume_self_sch_parts"  ###qty_sch消費予定 ・・・
                            ###schs -->新規時親から作成するので親登録時には、まだ子供のtrnganttsはないので子供作成時に、消費を作成する。
                            strsql =%Q% select gantt.*  from trngantts gantt 
                                                where gantt.tblname = '#{req["tblname"]}' and gantt.tblid = #{req["tblid"]}
                                                and (gantt.tblname != gantt.paretblname or gantt.tblid != gantt.paretblid )
                                                and (gantt.qty > 0 or gantt.qty_stk >0) for update
                           %
                            ActiveRecord::Base.connection.select_all(strsql).each do |rec|
                                
                                consumtype = (rec["consumtype"]||="")
                                consumtype = consumtype.gsub(" ","")
                                consumtype = consumtype.gsub("","con")
                                case consumtype  ###
                                when "con" ###子部品消費
                                    ###消費　　
                                    Operation.proc_consume_self_sch_parts rec,req["paretblname"],parent
                                end
                            end
                    
                    when "consume_self_ord_parts"  ###ords,insts 自身の消費予定 ・・・
                            ###schs -->新規時親から作成するのでまだ子供のtrnganttsはないので子供作成時に、消費を作成する。
                            strsql =%Q& select t2.itms_id ,t2.processseq,t2.prjnos_id ,
                                            a2.srctblname,((a2.qty + a2.qty_stk) - (a2.qty_alloc + a2.qty_linkto_alloctbl )) qty,
                                            a2.id alloctbls_id,
                                            t2.paretblname,t2.paretblid
                                            from trngantts t2 
                                            inner join alloctbls a2 	on t2.id = a2.trngantts_id 
                                            where a2.srctblname = '#{req["tblname"]}'  and a2.srctblid = #{req["tblid"]}
                                            and		(a2.qty + a2.qty_stk) > (a2.qty_alloc + a2.qty_linkto_alloctbl )
                                            and (t2.consumtype = 'con' or  t2.consumtype = '' or t2.consumtype is null) 
                                            and (t2.paretblname != t2.tblname or t2.paretblid != t2.tblid) 
                                            and t2.paretblname = t2.orgtblname and t2.paretblid = t2.orgtblid
                                            and t2.paretblname not like '%acts'  ---actsは除く"consume_child_parts"で対応
                                            and t2.paretblname not like '%schs'  
                                &
                            ActiveRecord::Base.connection.select_all(strsql).each do |stkinout|
                                Operation.proc_consume_self_ord_parts stkinout
                            end
                    when "consume_exception"
                            ###出庫の前の完成　完成時の員数可変による消費数対応

                    
                    when "mk_shpsch_by_prd_pursch"  ###qty_sch 自身の出庫 ・・・
                        ###schs -->新規時親から作成するので親登録時には、まだ子供のtrnganttsはないので子供作成時に、消費を作成する。
                        strsql =%Q% select *  from trngantts  
                                                    where tblname = '#{req["tblname"]}' and tblid = #{req["tblid"]}
                                                    and (tblname != paretblname or tblid != paretblid )
                                                    and (qty + qty_stk - qty_linkto_alloctbl - qty_alloc) > 0
                                                    for update
                               %
                        ActiveRecord::Base.connection.select_all(strsql).each do |rec|                                
                            consumtype = (rec["consumtype"]||="")
                            consumtype = consumtype.gsub(" ","")
                            consumtype = consumtype.gsub("","con")
                            strsql = %Q& select locas_id_shelfno  from shelfnos shelf where shelf.id = #{tbldata["shelfnos_id_to"]}
                                    &
                            locas_id_shelfno = ActiveRecord::Base.connection.select_value(strsql)
                            case req["paretblname"]
                                when /^prd/
                                        pare_loca_id = parent["workplace_loca_id_workplace"]
                                when /^pur/      
                                        pare_loca_id = parent["supplier_locas_id_supplier"]
                                when /^cust/      
                                        pare_loca_id = parent["cust_loca_id_cust_custrcvplc"]
                            end 
                            case consumtype  ###
                                when "con" ###子部品出庫
                                    ###出庫
                                    if locas_id_shelfno != pare_loca_id 
                                        case  req["paretblname"]
                                             when /schs$/
                                                Operation.proc_nextshp req,email,pare_loca_id,parent,tbldata do
                                                    "sch"
                                                end
                                            when  /ords$/   
                                                Operation.proc_nextshp req,email,pare_loca_id,parent,tbldata do
                                                    "sch"
                                                end  
                                                Operation.proc_resetshp req,reqparams
                                        end
                                    end
                            end
                        end

                    when "mkshps"     ###  shpxxxsからshpyyysを作成。
                        incnt, outcnt ,inqty ,outqty, inamt ,outamt = Operation.proc_mkshps email,reqparams
                        strsql = %Q%update mkshps set incnt = #{incnt},inqty = #{inqty},inamt = #{inamt},
                                            outcnt = #{outcnt},outqty = #{outqty},outamt = #{outamt} where id = #{req["tblid"]}
                        %
                        ActiveRecord::Base.connection.update(strsql)
                    else  
                        result_f = '6'
                        remark = " program nothing for #{reqparams["segment"]} "  
                end ## process   
                strsql = %Q%update processreqs set result_f = '#{result_f}',remark = '#{remark}' where id = #{req["tblid"]}
                %
                ActiveRecord::Base.connection.update(strsql)
                req = ActiveRecord::Base.connection.select_one(perform_strsql)
            end 
        rescue
            ActiveRecord::Base.connection.rollback_db_transaction()
            ActiveRecord::Base.connection.begin_db_transaction()
            if req 
                strsql = %Q%update processreqs set result_f = '5'  where seqno = #{pid} and id < #{req["id"]}
                %
                ActiveRecord::Base.connection.update(strsql)
            end
            remark =  %Q% $@: #{$@[0..200]} :class #{self} : LINE #{__LINE__} $!: #{$!} %  ###evar not defined
            Rails.logger.debug"error class #{self} : #{Time.now}: #{$@} "
            Rails.logger.debug"error class #{self} : $!: #{$!} "
            if req
                strsql = %Q%update processreqs set result_f = '9'  where seqno = #{pid} and id = #{req["id"]}
                %
                ActiveRecord::Base.connection.update(strsql)

                strsql = %Q%update processreqs set result_f = '8'  where seqno = #{pid} and id > #{req["id"]}
                %
                ActiveRecord::Base.connection.update(strsql)
            end
            ActiveRecord::Base.connection.commit_db_transaction()
        else
            ActiveRecord::Base.connection.commit_db_transaction()
        end  
    end
    
    #############修正要
    def chk_custords_alloc  tbldata  ###引き当てるcustschsを検索
        ###strsql = %Q%select * from trngantts where id = #{orgReqParams["trngantts_id"]}
        ###%
        ###trn =  ActiveRecord::Base.connection.select_one(strsql)
        ###同一品目(processseqを含む)、同一出庫場所(棚は無視),同一プロジェクト
        strsql = %Q%select a.* from trngantts a
            inner join custschs b  on a.orgtblid = b.id 
            where a.orgtblname = 'custschs' and b.custs_id = #{tbldata["custs_id"]}
            and a.prjnos_id =  #{tbldata["prjnos_id"]}
            and a.orgtblname = a.paretblname and a.paretblname = a.tblname
            and a.orgtblid = a.paretblid  and a.paretblid = a.tblid
            and  b.opeitms_id = #{tbldata["opeitms_id"]} 
            --- and  b.locas_id_fm = #{tbldata["locas_id_fm"]}  ---場所の違いは無視した
            and (a.qty + a.qty_stk - a.qty_linkto_alloctbl > 0) order by a.duedate
            for update
        %
        recs = ActiveRecord::Base.connection.select_all(strsql)
        qty = tbldata["custord_qty"].to_f
        key = 0
        recs.each do |rec|
            if qty >= rec["qty"].to_f and  rec["qty"].to_f > 0
                qty -=   rec["qty"].to_f
                strsql = %Q% update trngantts set qty = 0,remark = '516' where id = #{rec["id"]}%
                ActiveRecord::Base.connection.update(strsql)
                key += 1
                trn["key"] = format("%05d",key)
                gantt = {"id"=>orgReqParams["trngantts_id"],"qty_linkto_alloctbl"=>0}
                Operation.xxxxxxxxxxxxx
                break if qty <= 0
            else
                if qty < rec["qty"].to_f and  rec["qty"].to_f > 0
                    strsql = %Q% update trngantts set qty = #{rec["qty"].to_f - qty},remark = '517' where id = #{rec["id"]}%
                    ActiveRecord::Base.connection.update(strsql)
                    key += 1
                    trn["key"] = format("%05d",key)
                    rec["qty"] = qty
                    Operation.xxxxxxxxxxxxx
                    qty = 0
                    break
                else    
                    if qty >= rec["qty_stk"].to_f and  rec["qty_stk"].to_f > 0
                        qty -=   rec["qty_stk"].to_f
                        strsql = %Q% update trngantts set qty_stk = 0,remark = '516' where id = #{rec["id"]}%
                        ActiveRecord::Base.connection.update(strsql)
                        key += 1
                        trn["key"] = format("%05d",key)
                        Operation.xxxxxxxxxxxxx
                        break if qty <= 0
                    else
                        if qty < rec["qty_stk"].to_f and  rec["qty_stk"].to_f > 0
                            strsql = %Q% update trngantts set qty = #{rec["qty"] - qty},remark = '517' where id = #{rec["id"]}%
                            ActiveRecord::Base.connection.update(strsql)
                            key += 1
                            trn["key"] = format("%05d",key)
                            rec["qty_stk"] = qty
                            Operation.xxxxxxxxxxxxx
                            qty = 0
                            break 
                        end
                    end
                end            
            end    
        end  
        return qty,key
    end    
 
	###schsの追加	paretblname =~ /schs$|ords$/の時呼ばれる 
	def add_update_table_from_nditm  child,parent,paretblname ### id processreqsのid child-->nditms  parent ===> r_prd,pur XXXs
		opeitm  = Operation.proc_get_opeitms_rec(child["itms_id_nditm"],nil,child["processseq_nditm"],nil)
		command_r = ControlFields.proc_fields_update parent,paretblname do |command_c,para|
				command_c[:sio_viewname] =  "r_"+ opeitm["prdpurshp"]+"schs" 
				command_c["id"]=""
				command_c["opeitm_loca_id"]= opeitm["locas_id"]
				para["opeitms_id"] = opeitm["id"]
				para["duration"] =  opeitm["duration"].to_f
				para["parenum"] = child["parenum"].to_f
				para["chilnum"] = child["chilnum"].to_f
				para["locas_id_fm"] = child["locas_id_fm"]
				para["consumunitqty"] = child["consumunitqty"].to_f
				para["consumminqty"] = child["consumminqty"].to_f
				para["shelfnos_id_to"] = opeitm["shelfnos_id"]
				para["locas_id"] = opeitm["locas_id"]  ###発注の時の作業場所
		end
		return command_r,opeitm
    end
        
    def  custxxx_strsql tbldata
        strsql = %Q%select id from r_opeitms where itm_code = 'dummyship' and opeitm_processseq = 999
            %
        val  = ActiveRecord::Base.connection.select_value(strsql)
        if val.nil? ###nditmは自動作成
            p " missing item 'dummyship' please entry"
            p " missing item 'dummyship' please entry"
            p " missing item 'dummyship' please entry"
            raise
        end    ###opeitms itm_code : dummyship
        strsql = %Q&select itms_id,processseq from opeitms where id = #{tbldata["opeitms_id"]}
        &
        opeitm  = ActiveRecord::Base.connection.select_one(strsql)
        strsql = %Q%select * from nditms where expiredate > current_date and 
                opeitms_id = #{val} and itms_id_nditm = #{opeitm["itms_id"]} 
                and processseq_nditm = #{opeitm["processseq"]} limit 1
        %
        return strsql
    end
end