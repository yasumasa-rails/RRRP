class CreateOtherTableRecordJob < ApplicationJob
    queue_as :default 
    def perform(ids)
        # 後で実行したい作業をここに書く
        gids = []
        return if ids.class.to_s != "Array"  ###なぜか不定期に呼ばれている。
        ids.each do |id|
            next if id.nil?
            ActiveRecord::Base.connection.begin_db_transaction()
            strsql = "select * from  processreqs where result_f = '0'  and id = #{id} for update"
            req = ActiveRecord::Base.connection.select_one(strsql)
            if req   
                err_proc req  do 
                    req["result_f"] = '5'
                    req["remark"] = "start"  
                end  
                idx = 0
                strsql = %Q%select * from  r_#{req["tblname"]} where id = #{req["tblid"]}%
                parent = ActiveRecord::Base.connection.select_one(strsql) ###依頼元
                orgReqParams = JSON.parse(req["reqparams"])
                reqparams = orgReqParams.dup
                tbldata = orgReqParams["tbldata"]
                strsql = %Q% select email from persons where id = #{tbldata["persons_id_upd"]}
                %
                email = ActiveRecord::Base.connection.select_value(strsql) ###
                if  parent                                                                              ###req  processreqs
                    orgReqParams["segment"].each do |segment|                                                    
                        idx += 1                                                                    ###process processcontrols 
                        case segment
                        when "skip" 
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
                        when "mkschs"  ###XXXschs作成 XXXXschs,ordsの時作成
                            case req["tblname"]
                                when /^custords/   ###custxxxではitm_code = 'dummyship'初期設定での登録が必要
                                   qty,trnganttkey = chk_custords_alloc orgReqParams,parent
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
				                    command_r,processreqs_ids = RorBlkctl.proc_private_aud_rec(command_r,1,reqparams) 
                                    command_r[:sio_result_f] =  "1"   ## 1 normal end
                                    command_r[:sio_message_contents] = nil
                                    tblname = command_r[:sio_viewname].split("_")[1]
                                    tblid = command_r[(tblname.chop + "_id")] =  command_r["id"]
                                    RorBlkctl.proc_insert_sio_r(command_r) #### if @pare_class != "batch"    ## 結果のsio書き込み
                                    gids << processreqs_ids if  processreqs_ids 
                            end 
                         when "consume_child_parts"  ###子部品の消費
                            strsql =%Q% select * from trngantts where paretblname = '#{req["paretblname"]}' and 
                                                    paretblid = #{req["paretblid"]} and qty > 0  and 
                                                    (tblname != '#{req["paretblname"]}' or tblid != #{req["tblid"]})
                            %
                            ActiveRecord::Base.connection.select_all(strsql).each do |rec|
                                Operation.proc_consume_child_parts rec
                            end
                        when "sumrequest" 
                        when "splitrequest"  
                        when "createtable"
                            ### 仕入れ先登録時仕入れ先の棚番自動登録
                            ### 作業場所の棚番自動登録
                            case req["tblname"]
                            when "custs"
                                Operation.proc_createtable("custs","custrcvplcs",parent,email)
                            end
                        when "mkshpschs"  ###出庫の作成　
                            strsql = %Q% select * from r_trngantts where trngantt_paretblname = '#{req["tblname"]}'
                                                        and trngantt_paretblid = #{req["tblid"]}  
                                                        and (trngantt_tblid != #{req["tblid"]} or trngantt_paretblname != '#{req["tblname"]}')
                                                        and trngantt_tblname != 'trngantts'
                                                        and shelfno_loca_id_shelfno_fm != trngantt_loca_id_pare    ---同一場所の部品の出庫はない。
                                                        and trngantt_qty_pare > 0 and (trngantt_qty > 0 or  trngantt_qty_stk > 0)                     
                            %
                            recs = ActiveRecord::Base.connection.select_all(strsql)
                            Operation.proc_mkshpschs recs,email,reqparams
                        else  
                            err_proc req  do 
                                req["result_f"] = '8'
                                req["remark"] = " program nothing for #{segment} "  
                            end
                        end    
                    end ## process      
                    if  idx == 0
                        err_proc req  do 
                            req["result_f"] = '3'
                            req["remark"] = " out of service "  
                        end
                    end  
                else  
                    err_proc req  do 
                        req["result_f"] = '8'
                        req["remark"] = " sourece nothing. delete #{req["tblname"]} id= #{req["tblid"]} ?"  
                    end
                end 
            else
                p " processreqs id=#{id} delete?"
            end 
            ActiveRecord::Base.connection.commit_db_transaction()
            gids.each do |ids|
                perform ids
            end
            strsql = "select * from  processreqs where result_f = '5'  and id = #{id} for update"
            req = ActiveRecord::Base.connection.select_one(strsql)
            if req   
                err_proc req  do 
                    req["result_f"] = '1'
                    req["remark"] = "normal end"  
                end  
            end
        end
    end
    
    def err_proc req
        yield   
        req["updated_at"] = Time.now
        RorBlkctl.proc_tbl_edit_arel   "processreqs",req," id = #{req["id"]} "   
    end

    def chk_custords_alloc orgReqParams,parent
        strsql = %Q%select * from trngantts where id = #{orgReqParams["trngantts_id"]}
        %
        trn =  ActiveRecord::Base.connection.select_one(strsql)
        tbldata = orgReqParams["tbldata"]
        ###同一品目(processseqを含む)、同一出庫場所(棚は無視),同一プロジェクト
        strsql = %Q%select a.* from trngantts a
            inner join custschs b  on a.orgtblid = b.id 
            inner join shelfnos c on  a.shelfnos_id_fm = c.id
            where a.orgtblname = 'custschs' and b.custs_id = #{tbldata["custs_id"]}
            and a.prjnos_id =  #{tbldata["prjnos_id"]}
            and a.orgtblname = a.paretblname and a.paretblname = a.tblname
            and a.orgtblid = a.paretblid  and a.paretblid = a.tblid
            and  a.itms_id = #{trn["itms_id"]} and a.processseq = #{trn["processseq"]}
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
                Operation.proc_add_alloc_and_trn rec,trn
                break if qty <= 0
            else
                if qty < rec["qty"].to_f and  rec["qty"].to_f > 0
                    strsql = %Q% update trngantts set qty = #{rec["qty"].to_f - qty},remark = '517' where id = #{rec["id"]}%
                    ActiveRecord::Base.connection.update(strsql)
                    key += 1
                    trn["key"] = format("%05d",key)
                    rec["qty"] = qty
                    Operation.proc_add_alloc_and_trn rec,trn
                    qty = 0
                    break
                else    
                    if qty >= rec["qty_stk"].to_f and  rec["qty_stk"].to_f > 0
                        qty -=   rec["qty_stk"].to_f
                        strsql = %Q% update trngantts set qty_stk = 0,remark = '516' where id = #{rec["id"]}%
                        ActiveRecord::Base.connection.update(strsql)
                        key += 1
                        trn["key"] = format("%05d",key)
                        Operation.proc_add_alloc_and_trn rec,trn
                        break if qty <= 0
                    else
                        if qty < rec["qty_stk"].to_f and  rec["qty_stk"].to_f > 0
                            strsql = %Q% update trngantts set qty = #{rec["qty"] - qty},remark = '517' where id = #{rec["id"]}%
                            ActiveRecord::Base.connection.update(strsql)
                            key += 1
                            trn["key"] = format("%05d",key)
                            rec["qty_stk"] = qty
                            Operation.proc_add_alloc_and_trn rec,trn
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
        end    
        strsql = %Q%select * from nditms where expiredate > current_date and 
                opeitms_id = #{val} and itms_id_nditm = #{parent["opeitm_itm_id"]} 
                and processseq_nditm = #{parent["opeitm_processseq"]} limit 1
        %
        return strsql
    end
end