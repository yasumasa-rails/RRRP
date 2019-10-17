class CreateOtherTableRecordJob < ApplicationJob
  queue_as :default 
  def perform(id)
    # 後で実行したい作業をここに書く
    ActiveRecord::Base.connection.begin_db_transaction()
    strsql = "select * from  processreqs where result_f = '0'  and id = #{id} for update"
    req = ActiveRecord::Base.connection.select_one(strsql)
    if req   
      Operation.err_proc req  do 
        req["result_f"] = '5'
        req["remark"] = "start"  
      end  
      idx = 0
      strsql = "select * from r_#{req["tblname"]} where id = #{req["tblid"]} "
      srctbl = ActiveRecord::Base.connection.select_one(strsql) ###依頼元
      strsql = "select * from processcontrols where tblname = '#{req["tblname"]}' order by seqno"       
      process = ActiveRecord::Base.connection.select_all(strsql) ###作業内容               
      if srctbl                                                                       ###req  processreqs
        process.each do |proc|                                                        ###srctbl 依頼元テーブル
          idx += 1                                                                    ###process processcontrols 
          case proc["segment"]
            when "skip" 
            when "nditm"  ###
                ##登録か変更か?
                strsql = %Q% select * from trngentts where paretblname = '#{req["tblname"]}' and paretblid = #{req["tblid"]}
                              and (qty > 0 or qty_stk > 0) and paretblname  != orgtblname
                %
                if srctbl["qty"] then symqty = "qty" else symqty = "qty_stk" end
                ActiveRecord::Base.connection.select_all(strsql).each do |child|　###変更処理
                  save_child_qty =   child[symqty] 
                  if srctbl[symqty] < child[symqty]
                      child[symqty] =  srctbl[symqty]
                      srctbl[symqty]  = 0
                  else
                      srctbl[symqty] = srctbl[symqty] - child[symqty] 
                  end  
                  Operation.update_trngantt child 
                  case child["orgtblname"]
                    when /schs$/
                      Operation.fields_update_from_pare_source child
                    when /ords$|insts$|acts$/
                      if save_child_qty >  child[symqty] 
                        Operation.proc_chg_free_trn  child,save_child_qty   
                      end
                  end 
                end
                if srctbl[symqty] > 0    ###登録
                  strsql = %Q% select * from trngentts where paretblname = '#{req["tblname"]}' and paretblid = #{req["tblid"]}
                                (paretblname is null or paretblname  = orgtblname) and  (paretblidis is null or paretblid  = orgtblid)
                  %
                  trn = ActiveRecord::Base.connection.select_all(strsql)
                  if trn
                      trn[symqty] =  srctbl[symqty]
                      update_trngantt trn
                  else     
                    Operation.err_proc req  do 
                      req["result_f"] = '9'
                      req["remark"]  << " trngantts missing tblname:#{req["tblname"]} id=#{req["tblid"]} "
                    end  
                  end  
                  strsql = %Q% select * from r_nditms where nditm_opeitm_id = #{srctbl[opeitms_id]} and nditm_expiredate > current_date
                  %
                  ActiveRecord::Base.connection.select_all(strsql).each do |child|  ###schsを作成
                    rlst_processid = Operation.proc_add_update_table_from_nditm   child,srctbl   
                  end  
                end        
            when "trn_org"
                  Operation.proc_trn_org   req["paretblname"],req["paretblid"] ,req["tblname"],req["tblid"],req["reqparams"]      
            when "alloc"
            when "realloc"
            when "sumrequest" 
            when "splitrequest"  
            when "createtable"
            else  
              Operation.err_proc req  do 
                req["result_f"] = '8'
                req["remark"] = " program nothing for #{proc["segment"]} "  
              end
            end    
        end ## process      
        if  idx == 0
          Operation.err_proc req  do 
              req["result_f"] = '3'
              req["remark"] = " out of service "  
            end
        end  
      else  
        Operation.err_proc req  do 
          req["result_f"] = '8'
          req["remark"] = " sourece nothing. delete #{req["tblname"]} id= #{req["tblid"]} ?"  
        end
      end 
    else
        p " processreqs id=#{id} delete?"
    end 
    ActiveRecord::Base.connection.commit_db_transaction()
  end  
end