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
                orgreqparams = JSON.parse(req["reqparams"])
                if  parent                                                                      ###req  processreqs
                    orgreqparams["segment"].each do |segment|                                                    
                        idx += 1                                                                    ###process processcontrols 
                        case segment
                        when "skip" 
                        when "mkschs"  ###XXXschs作成 XXXXschs,ordsの時作成
                            strsql = %Q%select 1 from trngantts where paretblname = '#{req["tblname"]}' and paretblid = '#{req["tblid"]}'
                                        and (tblname != '#{req["tblname"]}' or tblid != '#{req["tblid"]}')%
                            recs = ActiveRecord::Base.connection.select_all(strsql) ###子供がないことの確認
                            trnganttkey = 0
                            key = orgreqparams["trnganttkey"]||=""
                            if recs.empty?
                                tbl_opeitm_id = req["tblname"].chop + "_opeitm_id"
                                strsql = %Q%select * from nditms where expiredate > current_date and opeitms_id = #{parent[tbl_opeitm_id]}%
                                ActiveRecord::Base.connection.select_all(strsql).each do |child|
                                    command_r,opeitm = Operation.proc_add_update_table_from_nditm  child,parent
                                    trnganttkey += 1
                                    reqparams = orgreqparams.dup
                                    reqparams["trnganttkey"] = key + format('%05d', trnganttkey)
                                    reqparams["paretblname"] = req["tblname"]
                                    reqparams["paretblid"] = req["tblid"]
                                    reqparams["child"] = child
                                    reqparams["opeitm"] = opeitm
				                    command_r,processreqs_ids = RorBlkctl.private_aud_rec(command_r,1,reqparams) 
                                    command_r[:sio_result_f] =  "1"   ## 1 normal end
                                    command_r[:sio_message_contents] = nil
                                    tblname = command_r[:sio_viewname].split("_")[1]
                                    tblid = command_r[(tblname.chop + "_id")] =  command_r["id"]
                                    RorBlkctl.proc_insert_sio_r(command_r) #### if @pare_class != "batch"    ## 結果のsio書き込み
                                    gids << processreqs_ids if  processreqs_ids 
                                end  
                            else  ###更新データがなぜかあった。　logic　エラー
                                strsql = "update processreqs set remark ='mksch logic error' where id = #{req["id"]}  "
                                ActiveRecord::Base.connection.update(strsql)
                            end  
                        when "consume_child_parts"  ###子部品の変更　展開
                            strsql =%Q% select * from trngantts where paretblname = '#{req["paretblname"]}' and 
                                                    and paretblid = #{req["paretblid"]} and qty >0  and 
                                                    (tblname != '#{req["paretblname"]}' or tblid = #{req["tblid"]})
                            %
                            ActiveRecord::Base.connection.select_all(strsql).each do |rec|
                                Operation.proc_consume_child_parts rec
                            end
                        when "lotstkhists"  ###
                            Operation.proc_lotstkhists orgreqparams["trngantts_id"]
                        when "sumrequest" 
                        when "splitrequest"  
                        when "createtable"
                        when "chng_trngantts_tbl"
                            roottbl = ControlField[prevTbl[req["tblname"]]]
                            strsql = %Q%select id from #{roottbl} where sno = #{srctbl["sno_#{statusTbl[roottbl]}"]}
                                %
                            rootid =  ActiveRecord::Base.connection.select_value(strsql)
                            Operation.proc_chng_trngantts_tbl roottbl,rootid,req["tblname"],req["tblid"],orgreqparams
                        when "mkshpschs"
                            strsql = %Q% select * from trngannts where where paretblname = '#{req["tblname"]}' and paretblid = #{rec["tblid"]}  
                                                        and locas_id_fm != locas_id_pare   and pare_qty > 0 and qty > 0                         
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