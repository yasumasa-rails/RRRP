module Api
    class MenusController < ApplicationController
        before_action :authenticate_api_user!
          def index
          end
          def create
            case params[:req] 
              when 'menureq'
                if Rails.env == "development" 
                    strsql = "select * from func_get_screen_menu('#{current_api_user[:email]}')"
                else
                  strsql = "select * from func_get_screen_menu('#{current_api_user[:email]}') and pobject_code_sgrp <'S'"
                end      
                recs = ActiveRecord::Base.connection.select_all(strsql)
                render json:  recs , status: :ok 
              when 'bottunlistreq'  
                strsql = "select pobject_code_scr_ub screen_code,button_title,button_code,button_contents
                          from r_usebuttons
                          inner join persons p on screen_scrlv_id_ub = scrlvs_id and p.email = '#{current_api_user[:email]}' 
                          where usebutton_expiredate > current_date
                          order by pobject_code_scr_ub,button_seqno"
                recs = ActiveRecord::Base.connection.select_all(strsql)
                render json:  recs , status: :ok
              when 'viewtablereq','editabletablereq'
                screenCode = params[:screenCode]
                column_info,page_info,where_info,select_fields,yup = RorBlkctl.create_grid_editable_columns_info screenCode,current_api_user[:email],params[:req]   
                if params[:filtered]
                  where_str = RorBlkctl.create_filteredstr params[:filtered],where_info
                else
                   where_str = (where_info[:filtered]||"")
                end    
                page_info[:pageNo] = (params[:page]||=0).to_f 
                page_info[:pageNo] += 1.0 
                page_info[:sizePerPage] =params[:pageSize].to_f
                pagedata,page_info = RorBlkctl.fetch_data_blk screenCode,select_fields,page_info,where_str,nil   ### nil filtered sorting
                render json:{:columns=>column_info,:data=>pagedata,:pageInfo=>page_info,:yup=>yup}       
              
              when 'inlineaddreq'
                screenCode = params[:screenCode]
                column_info,page_info,where_info,select_fields,yup= RorBlkctl.create_grid_editable_columns_info screenCode,current_api_user[:email] ,params[:req]  
                page_info[:pageNo] = 1
                page_info[:sizePerPage] = params[:pageSize].to_f
                pagedata,page_info = RorBlkctl.add_empty_data screenCode,column_info,page_info  ### nil filtered sorting
                render json:{:columns=>column_info,:data=>pagedata,:pageInfo=>page_info,:yup=>yup}      
                
              when "updateGridLineData"
                commad_r =  RorBlkctl.init_from_screen current_api_user,params
                command_r = JSON.parse params[:linedata]
                command_r[:sio_viewname] =  params[:screenCode]
                command_r[:sio_message_contents] = nil
                command_r[:sio_recordcount] = 1
                command_r[:sio_result_f] =   "0"  
                if command_r["id"] == ""
                   command_r[:sio_classname] = "_add_update_grid_line_data"
                else         
                    command_r[:sio_classname] = "_edit_update_grid_line_data"
                end       
                command_r = RorBlkctl.proc_update_table(command_r,1)
                if @sio_result_f ==   "9"
                    params[:status]= "error"
                    render json: {:params=>params}
                else  
                    params[:status]= "OK"
                    if command_r[:sio_classname] == "_add_update_grid_line_data"
                      params[:addId] = command_r["id"]
                    end  
                    render json: {:params=>params}
                end  
              when "fetch_request"   
                  fetch_data,mainviewflg,keys = RorBlkctl.get_fetch_rec params
                  if fetch_data.size > 0
                      if mainviewflg
                        params[:err] = "error duplicate code #{keys} "
                        params[:keys] = []
                         keys.split(",").each do |key| 
                          params[:keys] =  [key.split(":")[0].gsub(" ","")] 
                         end  
                      else
                        params[:fetchdata] = fetch_data 
                        params[:err] = ""
                      end  
                  else
                    if mainviewflg
                      params[:fetchdata] = {}
                      params[:err] = ""
                    else
                      params[:err] =  "error   --->not find #{keys} "
                      params[:fetchdata] = {}
                       keys.split(",").each do |key| 
                        params[:keys] =  [key.split(":")[0].gsub(" ","")] 
                       end  
                    end  
                  end     
                  render json: {:params=>params}  
                                
              when 'download'
                screenCode = params[:screenCode]
                column_info,where_info,select_fields = RorBlkctl.create_download_columns_info screenCode,current_api_user[:email]  
                if params[:filtered]
                  where_str = RorBlkctl.create_filteredstr params[:filtered],where_info
                else
                   where_str = (where_info[:filtered]||"")
                end    
                pagedata,totalcnt = RorBlkctl.download_data_blk screenCode,select_fields,where_str  ### nil filtered sorting
                render json:{:excelColumns=>column_info,:excelData=>pagedata,:totalcnt=>totalcnt}       
                  
            end   
          end
          def show
          end  
    end
  end
    