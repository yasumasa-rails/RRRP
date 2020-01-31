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
                if  parent                                                                              ###req  processreqs
                    orgReqParams["segment"].each do |segment|                                                    
                        idx += 1                                                                    ###process processcontrols 
                        case segment
                        when "skip" 
                        when "mkschs"  ###XXXschs作成 XXXXschs,ordsの時作成
                            case req["tblname"]
                                when /^cust/  ###itm_code = 'dummyship'初期設定での登録が必要
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
                                else
                                    tbl_opeitm_id = req["tblname"].chop + "_opeitm_id"
                                    strsql = %Q%select * from nditms where expiredate > current_date and opeitms_id = #{parent[tbl_opeitm_id]}%
                            end
                            reqparams = orgReqParams.dup
                            trnganttkey = 0
                            key = orgReqParams["trnganttkey"]
                            if key
                                reqparams["orgtrnganttkey"] = key 
                            else
                                reqparams["orgtrnganttkey"] = "00000"
                                key = ""
                            end    
                            ActiveRecord::Base.connection.select_all(strsql).each do |child|
                                    command_r,opeitm = Operation.proc_add_update_table_from_nditm  child,parent
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
                        when "opeitm_stktaking_proc"  ###
                                Operation.proc_stkinouts(req["tblname"],req["tblid"],parent,orgReqParams["trngantts_id"])
                        when "opeitm_acceptance_proc"  ###
                            strsql = %Q% select email from persons where id = #{orgReqParams["tbldata"]["persons_id_upd"]}
                            %
                            email = ActiveRecord::Base.connection.select_value(strsql) ###
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
                        when "sumrequest" 
                        when "splitrequest"  
                        when "createtable"
                            ### 仕入れ先登録時仕入れ先の棚番自動登録
                            ### 作業場所の棚番自動登録
                        when "mkshpschs"  ###出庫の作成　
                            strsql = %Q% select * from trngantts where paretblname = '#{req["tblname"]}' and paretblid = #{req["tblid"]}  
                                                        and shelfnos_id_fm != locas_id_pare   and qty_pare > 0 and qty > 0                         
                            %
                            recs = ActiveRecord::Base.connection.select_all(strsql)
                            Operation.proc_mkshpschs recs
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
end