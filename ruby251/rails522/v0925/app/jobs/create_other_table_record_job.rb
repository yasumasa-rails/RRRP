class CreateOtherTableRecordJob < ApplicationJob
    queue_as :default 
    def perform(pid)
        # 後で実行したい作業をここに書く
        perform_strsql = "select * from  processreqs where result_f = '0'  and seqno = #{pid} order by id limit 1 for update"
        begin
        ActiveRecord::Base.connection.begin_db_transaction()
            req = ActiveRecord::Base.connection.select_one(perform_strsql)
            while req do 
                strsql = %Q%update processreqs set result_f = '5'  where id = #{req["id"]}
                %
                ActiveRecord::Base.connection.update(strsql)
                strsql = %Q%select * from  r_#{req["tblname"]} where id = #{req["tblid"]}%
                parent = ActiveRecord::Base.connection.select_one(strsql) ###依頼元
                orgReqParams = JSON.parse(req["reqparams"])
                reqparams = orgReqParams.dup
                tbldata = reqparams["tbldata"]
                strsql = %Q% select email from persons where id = #{tbldata["persons_id_upd"]}
                %
                email = ActiveRecord::Base.connection.select_value(strsql) ###
                if  parent   
                    case reqparams["segment"]
                        when "skip" 
                        when "trngantts" 
                            reqparams = Operation.proc_trngantts req["tblname"],req["tblid"],reqparams
                        when "opeitm_acceptance_proc"  ###
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
                        when "mkschs"  ### XXXXschs,ordsの時XXXschsを作成
                            case req["tblname"]
                                when /^custords/   ###custxxxではitm_code = 'dummyship'初期設定での登録が必要
                                   qty,trnganttkey = chk_custords_alloc orgReqParams,parent  ###引き当てるcustschsを検索
                                   parent["custord_qty"] = qty
                                   strsql = custxxx_strsql parent
                                when /^custschs/  ###itm_code = 'dummyship'初期設定での登録が必要
                                    strsql = custxxx_strsql parent
                                else
                                    tbl_opeitm_id = req["tblname"].chop + "_opeitm_id"
                                    strsql = %Q%select * from nditms where expiredate > current_date and opeitms_id = #{parent[tbl_opeitm_id]}%
                            end
                            trnganttkey ||= 0
                            key = orgReqParams["trnganttkey"]
                            if key
                                reqparams["orgtrnganttkey"] = key 
                            else
                                reqparams["orgtrnganttkey"] = "00000"
                                key = ""
                            end    
                            ActiveRecord::Base.connection.select_all(strsql).each do |child|
                                    command_r,opeitm = add_update_table_from_nditm  child,parent
                                    trnganttkey += 1
                                    reqparams["trnganttkey"] = key + format('%05d', trnganttkey)
                                    reqparams["paretblname"] = req["tblname"]
                                    reqparams["paretblid"] = req["tblid"]
                                    reqparams["child"] = child
                                    reqparams["opeitm"] = opeitm  ###子部品のopeitms
				                    command_r,reqparams = RorBlkctl.proc_private_aud_rec(command_r,1,reqparams) 
                                    command_r[:sio_result_f] =  "1"   ## 1 normal end
                                    command_r[:sio_message_contents] = nil
                                    tblname = command_r[:sio_viewname].split("_")[1]
                                    tblid = command_r[(tblname.chop + "_id")] =  command_r["id"]
                                    RorBlkctl.proc_insert_sio_r(command_r) #### if @pare_class != "batch"    ## 結果のsio書き込み
                            end 
                        when "sumrequest" 
                        when "splitrequest"  
                        when "createtable"
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

                        when "mkords"  ###  xxxschsからxxxordsを作成。
                            reqparams = orgReqParams.dup
                            incnt, outcnt ,inqty ,outqty, inamt ,outamt = Operation.proc_mkords email,reqparams
                            parent = ActiveRecord::Base.connection.select_one(strsql) ###依頼元
                            strsql = %Q%update mkords set incnt = #{incnt},inqty = #{inqty},inamt = #{inamt},
                                                outcnt = #{outcnt},outqty = #{outqty},outamt = #{outamt} where id = #{parent["id"]}
                            %
                            ActiveRecord::Base.connection.update(strsql)

                        when "mkshpschs"  ###出庫の作成　
                            strsql = %Q% select * from r_trngantts where trngantt_paretblname = '#{req["tblname"]}'
                                                        and trngantt_paretblid = #{req["tblid"]}  
                                                        and (trngantt_tblid != #{req["tblid"]} or trngantt_tblname != '#{req["tblname"]}')
                                                        and trngantt_tblname != 'trngantts'
                                                        and shelfno_loca_id_shelfno_fm != trngantt_loca_id_pare    ---同一場所の部品の出庫はない。
                                                        and trngantt_qty_pare > 0 and (trngantt_qty > 0 or  trngantt_qty_stk > 0)    for update                 
                            %
                            recs = ActiveRecord::Base.connection.select_all(strsql)
                            reqparams = orgReqParams.dup
                            Operation.proc_mkshpschs recs,email,reqparams

                        when "consume_child_parts"  ###子部品の消費 ###金型返却　###装置の解放
                           strsql =%Q% select gantt.*  from trngantts gantt 
                                                where gantt.paretblname = '#{req["tblname"]}' and gantt.paretblid = '#{req["tblid"]}'
                                                and (gantt.tblname != gantt.paretblname or gantt.tblid != gantt.paretblid )
                                                and (gantt.qty > 0 or gantt.qty_stk >0) for update
                           %
                            ActiveRecord::Base.connection.select_all(strsql).each do |rec|
                                consumtype = (rec["consumtype"]||="")
                                consumtype = consumtype.gsub(" ","")
                                case consumtype
                                when "con" ###子部品の消費
                                    Operation.proc_consume_child_parts rec,req["paretblname"],parent
                                when "" ###子部品の消費
                                    Operation.proc_consume_child_parts rec,req["paretblname"],parent
                                end
                            end

                        when "consume_sch_self_parts_by_parent"  ###自身の消費予定 
                           strsql =%Q% select gantt.*  from trngantts gantt 
                                                where gantt.tblname = '#{req["tblname"]}' and gantt.tblid = '#{req["tblid"]}'
                                                and gantt.paretblname = '#{req["paretblname"]}' and gantt.paretblid = #{req["paretblid"]}
                                                and (gantt.tblname != gantt.paretblname or gantt.tblid != gantt.paretblid )
                                                and (gantt.qty > 0 or gantt.qty_stk >0) for update
                           %
                            ActiveRecord::Base.connection.select_all(strsql).each do |rec|
                                consumtype = (rec["consumtype"]||="")
                                consumtype = consumtype.gsub(" ","")
                                case consumtype
                                when "con" ###子部品の消費
                                    Operation.proc_consume_child_parts rec,req["paretblname"],parent
                                when "" ###子部品の消費
                                    Operation.proc_consume_child_parts rec,req["paretblname"],parent
                                end
                            end

                        when "consume_ord_self_parts_by_parent"  ###自身の消費予定 
                           strsql =%Q% select gantt.*  from trngantts gantt 
                                                inner join alloctbls alloc on gantt.id = alloc.trngantts_id
                                                where (gantt.tblname != gantt.paretblname or gantt.tblid != gantt.paretblid )
                                                and alloc.srctblname = '#{req["tblname"]}' and alloc.srctblid = #{req["tblid"]}
                                                and (gantt.qty > 0 or gantt.qty_stk >0) for update
                           %
                            ActiveRecord::Base.connection.select_all(strsql).each do |rec|
                                strsql = %Q%select * from #{rec["paretblname"]} where id =  #{rec["paretblid"]}
                                %
                                ord_parent =  ActiveRecord::Base.connection.select_one(strsql)
                                consumtype = (rec["consumtype"]||="")
                                consumtype = consumtype.gsub(" ","")
                                case consumtype
                                when "con" ###子部品の消費
                                    Operation.proc_consume_child_parts rec,rec["paretblname"],ord_parent
                                when "" ###子部品の消費
                                    Operation.proc_consume_child_parts rec,req["paretblname"],parent
                                end
                            end

                        else  
                            err_proc req  do 
                                req["result_f"] = '6'
                                req["remark"] = " program nothing for #{reqparams["segment"]} "  
                            end
                    end ## process   
                else  
                    err_proc req  do 
                        req["result_f"] = '7'
                        req["remark"] = " data sourece nothing. delete #{req["tblname"]} id= #{req["tblid"]} ?"  
                    end
                end 
                strsql = %Q%update processreqs set result_f = '1'  where id = #{req["id"]}
                %
                ActiveRecord::Base.connection.update(strsql)
                req = ActiveRecord::Base.connection.select_one(perform_strsql)
            end 
        rescue
            ActiveRecord::Base.connection.rollback_db_transaction()
            ActiveRecord::Base.connection.begin_db_transaction()
            strsql = %Q%update processreqs set result_f = '5'  where seqno = #{pid} and id < #{req["id"]}
            %
            ActiveRecord::Base.connection.update(strsql)

            remark =  %Q% $@: #{$@[0..200]} :class #{self} : LINE #{__LINE__} $!: #{$!} %  ###evar not defined
            Rails.logger.debug"error class #{self} : #{Time.now}: #{$@} "
            Rails.logger.debug"error class #{self} : $!: #{$!} "
            strsql = %Q%update processreqs set result_f = '9'  where seqno = #{pid} and id = #{req["id"]}
            %
            ActiveRecord::Base.connection.update(strsql)

            strsql = %Q%update processreqs set result_f = '8'  where seqno = #{pid} and id > #{req["id"]}
            %
            ActiveRecord::Base.connection.update(strsql)
            ActiveRecord::Base.connection.commit_db_transaction()
        else
            ActiveRecord::Base.connection.commit_db_transaction()
        end    
    end
    
    def err_proc req
        yield   
        req["updated_at"] = Time.now
        RorBlkctl.proc_tbl_edit_arel   "processreqs",req," id = #{req["id"]} "   
    end

    def chk_custords_alloc orgReqParams,parent  ###引き当てるcustschsを検索
        ###strsql = %Q%select * from trngantts where id = #{orgReqParams["trngantts_id"]}
        ###%
        ###trn =  ActiveRecord::Base.connection.select_one(strsql)
        tbldata = orgReqParams["tbldata"]
        ###同一品目(processseqを含む)、同一出庫場所(棚は無視),同一プロジェクト
        strsql = %Q%select a.* from trngantts a
            inner join custschs b  on a.orgtblid = b.id 
            inner join shelfnos c on  a.shelfnos_id_fm = c.id
            where a.orgtblname = 'custschs' and b.custs_id = #{tbldata["custs_id"]}
            and a.prjnos_id =  #{tbldata["prjnos_id"]}
            and a.orgtblname = a.paretblname and a.paretblname = a.tblname
            and a.orgtblid = a.paretblid  and a.paretblid = a.tblid
            and  a.itms_id = #{parent["opeitm_itm_id"]} and a.processseq = #{parent["opeitm_processseq"]}
            and c.locas_id_shelfno = #{parent["shelfno_loca_id_shelfno"]}
            and (a.qty > 0 or a.qty_stk > 0) order by a.duedate
            for update
        %
        recs = ActiveRecord::Base.connection.select_all(strsql)
        qty = parent["custord_qty"].to_f
        key = 0
        recs.each do |rec|
            if qty >= rec["qty"].to_f and  rec["qty"].to_f > 0
                qty -=   rec["qty"].to_f
                strsql = %Q% update trngantts set qty = 0,remark = '516' where id = #{rec["id"]}%
                ActiveRecord::Base.connection.update(strsql)
                key += 1
                trn["key"] = format("%05d",key)
                Operation.proc_add_alloc_and_trn rec,orgReqParams["trngantts_id"]
                break if qty <= 0
            else
                if qty < rec["qty"].to_f and  rec["qty"].to_f > 0
                    strsql = %Q% update trngantts set qty = #{rec["qty"].to_f - qty},remark = '517' where id = #{rec["id"]}%
                    ActiveRecord::Base.connection.update(strsql)
                    key += 1
                    trn["key"] = format("%05d",key)
                    rec["qty"] = qty
                    Operation.proc_add_alloc_and_trn rec,orgReqParams["trngantts_id"]
                    qty = 0
                    break
                else    
                    if qty >= rec["qty_stk"].to_f and  rec["qty_stk"].to_f > 0
                        qty -=   rec["qty_stk"].to_f
                        strsql = %Q% update trngantts set qty_stk = 0,remark = '516' where id = #{rec["id"]}%
                        ActiveRecord::Base.connection.update(strsql)
                        key += 1
                        trn["key"] = format("%05d",key)
                        Operation.proc_add_alloc_and_trn rec,orgReqParams["trngantts_id"]
                        break if qty <= 0
                    else
                        if qty < rec["qty_stk"].to_f and  rec["qty_stk"].to_f > 0
                            strsql = %Q% update trngantts set qty = #{rec["qty"] - qty},remark = '517' where id = #{rec["id"]}%
                            ActiveRecord::Base.connection.update(strsql)
                            key += 1
                            trn["key"] = format("%05d",key)
                            rec["qty_stk"] = qty
                            Operation.proc_add_alloc_and_trn rec,orgReqParams["trngantts_id"]
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
	def add_update_table_from_nditm  child,parent ### id processreqsのid child-->nditms  parent ===> r_prd,pur XXXs
		opeitm  = Operation.proc_get_opeitms_rec(child["itms_id_nditm"],nil,child["processseq_nditm"],nil)
		command_r = Operation.proc_fields_update parent do |command_c,para|
				command_c[:sio_viewname] =  "r_"+ opeitm["prdpurshp"]+"schs" 
				command_c["id"]=""
				command_c["opeitm_loca_id"]= opeitm["locas_id"]
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

    
    def  custxxx_strsql parent
        strsql = %Q%select id from r_opeitms where itm_code = 'dummyship' and opeitm_processseq = 999
            %
        val  = ActiveRecord::Base.connection.select_value(strsql)
        if val.nil? ###nditmは自動作成
            p " missing item 'dummyship' please entry"
            p " missing item 'dummyship' please entry"
            p " missing item 'dummyship' please entry"
            raise
        end    ###opeitms itm_code : dummyship
        strsql = %Q%select * from nditms where expiredate > current_date and 
                opeitms_id = #{val} and itms_id_nditm = #{parent["opeitm_itm_id"]} 
                and processseq_nditm = #{parent["opeitm_processseq"]} limit 1
        %
        return strsql
    end
end