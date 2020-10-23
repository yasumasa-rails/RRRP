module Api
  class UploadsController < ApplicationController
    before_action :authenticate_api_user!
    before_action :set_upload, only: [:update]

    # GET /api/uploads
      def index
      end

    # PUT /api/recipes/1
      def update
      end
      
      def create
        upload = Upload.create!(upload_params)
        blob_path = Rails.application.routes.url_helpers.rails_blob_path(upload.excel, only_path: true)
        tmp1,defCode,screenCode,tmp2 = blob_path.split("@")
        column_info,page_info,where_info,select_fields,yup,dropdownlist,sort_info,nameToCode = 
                  RorBlkctl.proc_create_grid_editable_columns_info screenCode,current_api_user[:email],"inlineaddreq" 
        
        strsql = "select	column_name from 	information_schema.columns 
                  where 	table_catalog='#{ActiveRecord::Base.configurations["development"]["database"]}' 
                  and table_name='#{screenCode}' and  column_name not like  '%person_id_upd' "
                ###  and column_name like '%_id%'
                ###  and split_part(column_name,'_',1) = '#{screenCode.split("_",2)[1].chop}'"
        keyids = ActiveRecord::Base.connection.select_values(strsql)
        
        command_all = []
        results = []   
        status = true
        command_init =  RorBlkctl.init_from_screen current_api_user[:uid],screenCode
        jparams = {}

  		  yupfetchcode = YupSchema.create_yupfetchcode screenCode   
        yupcheckcode  = YupSchema.create_yupcheckcode screenCode   
        tblid = screenCode.split("_")[1].chop + "_id"
        
        lines = JSON.parse(upload.excel.download)
        lines.each do |linedata|
            jparams[:parse_linedata] = linedata.dup
            keyids.each do |idkey|   ###keyids--->view項目
                if jparams[:parse_linedata][idkey].nil?
                    jparams[:parse_linedata][idkey] = ""
                end    
            end  
            jparams[:screenCode] = screenCode
            jparams[:err] = ""  
            linedata.each do |field,val| ###confirmはfunction batchcheckで項目追加している。
                if linedata["confirm"] == true  or linedata["confirm"].nil?
                  ##エラーと最初のレコード(confirm="confirm")のname項目行を除く
                  jparams[:parse_linedata]["confirm"] = true
                  if yupfetchcode[field] 
                    jparams[:fetchcode] = %Q%{"#{field}":"#{val}"}%
                    jparams[:fetchview] = yupfetchcode[field]
                    jparams = ControlFields.proc_chk_fetch_rec jparams  
                    if jparams[:err] == ""
                        jparams[:fetch_data].each do |fd,vl|
                            jparams[:parse_linedata][fd] = vl
                        end  
                        if yupcheckcode[field] and val != ""
                            jparams["yupcheckcode"] = %Q%{"#{field}":"#{val}"}%
                            jparams = ControlFields.proc_judge_check_code jparams
                            if jparams[:err] != ""
                                jparams[:parse_linedata]["confirm_gridmessage"] = jparams[:err]
                                status = false    
                            end
                        end
                    else   
                        status = false    
                    end  
                  end
                end 
            end 
            if status == false    
                jparams[:parse_linedata]["confirm_gridmessage"] = jparams[:err]
            end
            results << jparams[:parse_linedata]
        end
        results.each do |parse_linedata|
            command_c = command_init.dup  ###blkukyはid以外でユニークを保証するkey
            if parse_linedata["confirm"] == true    ###重複keyチェック
                err = ControlFields.blkuky_check screenCode.split("_")[1],parse_linedata
                tblid = screenCode.split("_")[1].chop + "_id"
                err.each do |key,recs|
                    recs.each do |rec|
                        if command_c["id"].nil? or command_c["id"] == ""
                              command_c["id"] = rec["id"]
                              parse_linedata[tblid] = parse_linedata["id"] = rec["id"]
                        else
                          if command_c["id"] != rec["id"]
                              status = false  
                              parse_linedata["confirm_gridmessage"] = "error:#{key}"
                          end
                        end  
                        if  parse_linedata["aud"] == "add" and  rec["id"] 
                          status = false  
                          parse_linedata["confirm_gridmessage"] = "error already exist:#{key}"
                        end 
                    end	
                    if recs.empty?
                      if  parse_linedata["aud"] == "update" or parse_linedata["aud"] == "delete"
                          status = false  
                          parse_linedata["confirm_gridmessage"] = "error not exist:#{key}"
                      end 
                    end  
                end
            end
            if status == true and parse_linedata["confirm"] == true and defCode == "add_update"
                parse_linedata.each do |key,value|
                    command_c[key] = (value||="")
                end
                case command_c["aud"] 
                when "add" 
                    command_c[:sio_classname] = "_add_update_grid_line_data"
                when "update"         
                    command_c[:sio_classname] = "_edit_update_grid_line_data"
                when "delete"       
                    command_c[:sio_classname] = "_delete_update_grid_line_data"
                end
                ###command_r = Operation.add_update_rec(jparams,command_c) 
                command_all << command_c
            end
        end
        if status == true  and defCode == "add_update"
          results = update_table_json(command_all,command_all.size,results)
        end
        render json: {:results=>results}

      end

      def show
      end
    private
        def upload_params
          params.require(:upload).permit(:excel,:title)
        end 
      # Use callbacks to share common setup or constraints between actions.
      def set_upload
          @upload = Upload.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def update_params
        params.permit(:id,:title, :contents)
      end
      def create_params
        params.permit(:excel)
      end
      def update_table_json command_all,r_cnt0,results  ##rec = command_c command_rとの混乱を避けるためrecにした。          
          acommand =[]
          idx = 0
          reqparams = nil
          begin
              ActiveRecord::Base.connection.begin_db_transaction()
                  command_all.each do |command_cn|
                      reqparams = RorBlkctl.proc_private_aud_rec(command_cn,r_cnt0,nil,nil,nil) ###nil:parenttblname,paretblid,reqparams
                      acommand << command_cn
                      results[idx+1]["confirm"] = true
                      idx += 1
                  end
          rescue
              ActiveRecord::Base.connection.rollback_db_transaction()
                  command_all[idx][:sio_result_f] =   "9"  ##9:error
                  command_all[idx][:sio_message_contents] =  "error class #{self} : LINE #{__LINE__} $!: #{$!} "    ###evar not defined
                  command_all[idx][:sio_errline] =  "class #{self} : LINE #{__LINE__} $@: #{$@} "[0..3999]
                  Rails.logger.debug"error class #{self} : #{Time.now}: #{$@} "
                  Rails.logger.debug"error class #{self} : $!: #{$!} "
                  Rails.logger.debug"  idx = #{idx} command_r: #{command_all[idx]} "
                  results[idx+1]["confirm_gridmessage"] = command_all[idx][:sio_message_contents].to_s[0..1000] 
          else
              acommand.each do |command|
                  command[:sio_result_f] =  "1"   ### 1 normal end
                  command[:sio_message_contents] = nil
                  RorBlkctl.proc_insert_sio_r(command) ### if @pare_class != "batch"    ## 結果のsio書き込み
              end	
              ActiveRecord::Base.connection.commit_db_transaction()
              # reqparams["seqno"].each do |idx|
              #   CreateOtherTableRecordJob.perform_later idx
              # end
          ensure
          end ##begin
          return results
      end	
  end
end  