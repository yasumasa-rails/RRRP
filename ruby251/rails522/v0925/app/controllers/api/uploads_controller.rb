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
      
      def create   ###自動で作成されたファイル名は変更しないこと。
        upload = Upload.create!(upload_params)
        blob_path = Rails.application.routes.url_helpers.rails_blob_path(upload.excel, only_path: true)
        tmp1,defCode,screenCode,tmp2 = blob_path.split("@")
        tblname = screenCode.split("_")[1]
        column_info,page_info,where_info,select_fields,yup,dropdownlist,sort_info,nameToCode = 
                  RorBlkctl.proc_create_upload_editable_columns_info screenCode,current_api_user[:email],"inlineaddreq" 
        
        strsql = "select	column_name from 	information_schema.columns 
                  where 	table_catalog='#{ActiveRecord::Base.configurations["development"]["database"]}' 
                  and table_name='#{screenCode}' and  column_name not like  '%person_id_upd' "
                ###  and column_name like '%_id%'
                ###  and split_part(column_name,'_',1) = '#{screenCode.split("_",2)[1].chop}'"
        keyids = ActiveRecord::Base.connection.select_values(strsql)
        
        command_all = []
        results = []   
        status = true
        command_init =  RorBlkctl.proc_init_from_screen current_api_user[:uid],screenCode
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
                            else
                              jparams[:parse_linedata]["#{field}_gridmessage"] = "ok"
                            end
                        end
                    else   
                        status = false    
                    end  
                  else  
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
                err = ControlFields.proc_blkuky_check screenCode.split("_")[1],parse_linedata
                tblid = screenCode.split("_")[1].chop + "_id"
                err.each do |key,recs|
                    recs.each do |rec|
                        if command_c["id"].nil? or command_c["id"] == ""
                              command_c["id"] = rec["id"]
                              parse_linedata[tblid] = parse_linedata["id"] = rec["id"]
                        else
                          if command_c["id"] != rec["id"]
                              status = false  
                              parse_linedata["confirm_gridmessage"] = "error key:#{key}"
                          end
                        end  
                        if  parse_linedata["aud"] == "add" and  rec["id"] 
                          status = false  
                          parse_linedata["confirm_gridmessage"] = "error already exist key:#{key}"
                        end 
                    end	
                    if recs.empty?
                      if  parse_linedata["aud"] == "update" or parse_linedata["aud"] == "delete"
                          status = false  
                          parse_linedata["confirm_gridmessage"] = "error key not exist key:#{key}"
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
                    command_c[:sio_classname] = "_add_grid_line_data"
                when "update"         
                    command_c[:sio_classname] = "_update_grid_line_data"
                when "delete"       
                    command_c[:sio_classname] = "_delete_grid_line_data"
                end
                ###command_r = Operation.add_update_rec(jparams,command_c) 
                command_all << command_c
            end
        end
        if status == true  and defCode == "add_update"
            results = RorBlkctl.proc_update_table_json(command_all,command_all.size,results)

            ### errorの処理　未処理

            if $materiallized[tblname]
              $materiallized[tblname].each do |view|
                strsql = %Q%select 1 from pg_catalog.pg_matviews pm 
                      where matviewname = '#{view}' %
                if ActiveRecord::Base.connection.select_one(strsql)			
                      strsql = %Q%REFRESH MATERIALIZED VIEW #{view} %
                      ActiveRecord::Base.connection.execute(strsql)
                else
                      3.times{p "materiallized error :#{view}"}
                end
              end
            end
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
  end
end  