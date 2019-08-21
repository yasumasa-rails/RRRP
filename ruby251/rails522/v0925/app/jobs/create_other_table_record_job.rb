
class CreateOtherTableRecordJob < ApplicationJob
  queue_as :default
 
  def perform(id)
    # 後で実行したい作業をここに書く
    strsql = "select * from  processreqs where result_f = '0'  and id = #{id} for update"
    rec = ActiveRecord::Base.connection.select_one(strsql)
    if rec
      rec["result_f"] = '8'
      rec["remark"] = ""
      strsql = "select * from processcontrols where tblname = '#{rec["tblname"]}' order by seqno"
      process = ActiveRecord::Base.connection.select_all(strsql)
      idx = 0
      process.each do |proc|
          idx += 1
          case proc["segment"]
          when "skip" 
          when "nditm"  ###tblnameにはopeitms_idを含んでいること。
                parameters = {}
                proc["rubycode"].split(",").each do |items|
                  field,val = items.split("=")
                  parameters[field] = val
                end  
                if parameters["opeitms_id"]
                      rlst_processid = Operation.proc_create_table_from_nditm   parameters["opeitms_id"],parameters["operation"] ,rec["tblname"],rec["id"],id   
                else
                  rec["remark"]  << "opeitms_id missing  "   
                  rec["result_f"] = '8'
                  rec["update_at"] = Time.now
                  RorBlkctl.proc_tbl_edit_arel   "processreqs",rec," id = #{rec["id"]} "                        
                end      
          when "alloc"
          when "realloc"
          when "sumrequest" 
          when "splitrequest"  
          when "createtable"
          else
          end
      end  
      if idx == 0
      else  
      end  
      ActiveRecord::Base.connection.commit_db_transaction()
    end 
  end
end