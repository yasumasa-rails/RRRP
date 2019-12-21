module Api
    class JsonsController < ApplicationController
    before_action :authenticate_api_user!
    # GET /api/json
        def index
        end

    # PUT /api/recipes/1
        def update
        end
        def create
            yupfetchcode =  JSON.parse(params["yupfetchcode"])    
            yupcheckcode =  JSON.parse(params["yupcheckcode"])  
            command_all = []
            results = []   
            status = true
            command_init =  RorBlkctl.init_from_screen params[:uid],params[:screenCode]
            jparams = {}

            ###外部key XXXXs_idの作成
            strsql = "select	column_name from 	information_schema.columns 
                                    where 	table_catalog='#{ActiveRecord::Base.configurations["development"]["database"]}' 
                                    and table_name='r_#{params[:screenCode].split("_")[1]}'
                                    and column_name like '%_id%' and  column_name not like  '%person_id_upd'
                                    and split_part(column_name,'_',1) = '#{params[:screenCode].split("_")[1].chop}'"
            
            keyids = ActiveRecord::Base.connection.select_values(strsql)
            
            lines = JSON.parse(params["lines"])
            lines.each do |linedata|
                jparams[:parse_linedata] = linedata.dup
                keyids.each do |idkey|
                    if jparams[:parse_linedata][idkey].nil?
                        jparams[:parse_linedata][idkey] = ""
                    end
                end    
                linedata.each do |field,val| 
                    jparams[:screenCode] = params[:screenCode]
                    jparams[:err] = ""
                    ##エラーがないもの　、最初のレコード(confirm="confirm")のname項目行を除く
                    if yupfetchcode[field] and linedata["confirm"] == ""   
                        jparams[:fetchcode] = %Q%{"#{field}":"#{val}"}%
                        jparams[:fetchview] = yupfetchcode[field]
                        jparams = ControlFields.chk_fetch_rec jparams  
                        if jparams[:err] == ""
                            jparams[:fetch_data].each do |fd,vl|
                                jparams[:parse_linedata][fd] = vl
                            end  
                            if yupcheckcode[field] and val != ""
                                jparams["yupcheckcode"] = %Q%{"#{field}":"#{val}"}%
                                jparams = ControlFields.judge_check_code jparams
                                debugger
                                if jparams[:err] == ""
                                    ##
                                else
                                    jparams[:parse_linedata]["confirm"] = jparams[:err]
                                    status = false    
                                end
                            end
                        else    
                            jparams[:parse_linedata]["confirm"] = jparams[:err]    
                            status = false    
                        end  
                    end 
                end
                results << jparams[:parse_linedata]
            end
            results.each do |parse_linedata|
                if parse_linedata["confirm"] == ""    ###重複keyチェック
                    err = ControlFields.blkuky_check params[:screenCode].split("_")[1],parse_linedata
                    command_c = command_init.dup
                    err.each do |key,recs|
                        recs.each do |rec|
                            if command_c["id"] != rec["id"]
                                status = false    
                            end  
                        end	
                    end
                end
                if status == true and parse_linedata["confirm"] == "" 
                    parse_linedata.each do |key,value|
                        command_c[key] = value
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
            update_table_json(command_all,command_all.size) 
            render json: {:results=>results}
        end    
        def show
        end
        private
        def update_table_json command_c,r_cnt0  ##rec = command_c command_rとの混乱を避けるためrecにした。
            
                acommand =[]
                aprocessreqs_id = []
                idx = 0
                begin
                    ActiveRecord::Base.connection.begin_db_transaction()
                    command_c.each do |command_cn|
                        command_rn,processreqs_ids = RorBlkctl.private_aud_rec(command_cn,r_cnt0,nil) ###最後のパラメータはreqparams
                        acommand << command_rn
                        aprocessreqs_id  << processreqs_ids if processreqs_ids
                        idx += 1
                    end
                rescue
                     ActiveRecord::Base.connection.rollback_db_transaction()
                    command_c[idx][:sio_result_f] =   "9"  ##9:error
                    command_c[idx][:sio_message_contents] =  "class #{self} : LINE #{__LINE__} $!: #{$!} "    ###evar not defined
                    command_c[idx][:sio_errline] =  "class #{self} : LINE #{__LINE__} $@: #{$@} "[0..3999]
                    Rails.logger.debug"error class #{self} : #{Time.now}: #{$@} "
                    Rails.logger.debug"error class #{self} : $!: #{$!} "
                    Rails.logger.debug"  idx = #{idx} command_r: #{command_c} "
                else
                    idx = 0
                    ActiveRecord::Base.connection.commit_db_transaction()
                    acommand.each do |command|
                        command[:sio_result_f] =  "1"   ## 1 normal end
                        command[:sio_message_contents] = nil
                        tblname = command[:sio_viewname].split("_")[1]
                        ###command[(tblname.chop + "_id")] =  command["id"] 
                        RorBlkctl.proc_insert_sio_r( command) #### if @pare_class != "batch"    ## 結果のsio書き込み
                        CreateOtherTableRecordJob.perform_later aprocessreqs_id[idx]
                        idx += 1
                    end	
                ensure
                end ##begin
                return acommand
        end		
    
    end
end  