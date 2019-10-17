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
            JSON.parse(params["lines"]).each do |linedata|
                jparams[:parse_linedata] = linedata.dup
                linedata.each do |field,val| 
                    jparams["screenCode"] = params["screenCode"]
                    jparams[:err] = ""
                    if yupfetchcode[field] and linedata["confirm"] == ""   ##エラーがないもの　、name項目行を除く
                        jparams["fetchcode"] = %Q%{"#{field}":"#{val}"}%
                        jparams["fetchview"] = yupfetchcode[field]
                        jparams = RorBlkctl.chk_fetch_rec jparams  
                        if jparams[:err] == ""
                            jparams[:fetch_data].each do |fd,vl|
                                jparams[:parse_linedata][fd] = vl
                            end   
                            if yupcheckcode[field] and val != ""
                                jparams["checkcode"] = %Q%{"#{field}":"#{val}"}%
                                jparams = RorBlkctl.judge_check_code jparams
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
                if status == true and jparams[:parse_linedata]["confirm"] == "" 
                    command_c = command_init.dup
                    jparams[:parse_linedata].each do |key,value|
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
                    command_r = RorBlkctl.add_update_rec(jparams,command_c) 
                    command_all << command_r
                end
            end
            RorBlkctl.proc_update_table(command_all,command_all.size,nil,nil,nil) 
            render json: {:results=>results}
        end    
        def show
        end
        private
    end
end  