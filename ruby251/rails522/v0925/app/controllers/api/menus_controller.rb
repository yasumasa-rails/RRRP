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
                          from r_usebuttons u
                          inner join r_persons p on u.scrlv_code_ub = p.scrlv_code and p.person_email = '#{current_api_user[:email]}' 
                          where usebutton_expiredate > current_date
                          order by pobject_code_scr_ub,button_seqno"
                recs = ActiveRecord::Base.connection.select_all(strsql)
                render json:  recs , status: :ok
              when 'viewtablereq','editabletablereq'
                screenCode = params[:screenCode]
                column_info,page_info,where_info,select_fields,yup,dropdownlist,sort_info= RorBlkctl.create_grid_editable_columns_info screenCode,current_api_user[:email],params[:req]   
                if params[:filtered]
                  where_str = RorBlkctl.create_filteredstr params[:filtered],where_info
                else
                   where_str = (where_info[:filtered]||"")
                end    
                page_info[:pageNo] = (params[:page]||=0).to_f 
                page_info[:pageNo] += 1.0 
                page_info[:sizePerPage] =params[:pageSize].to_f
                pagedata,page_info = RorBlkctl.fetch_data_blk screenCode,select_fields,page_info,where_str,sort_info
                render json:{:columns=>column_info,:data=>pagedata,:pageInfo=>page_info,:yup=>yup,:dropdownlist=>dropdownlist}       
              
              when 'inlineaddreq'
                screenCode = params[:screenCode]
                column_info,page_info,where_info,select_fields,yup,dropdownlist= RorBlkctl.create_grid_editable_columns_info screenCode,current_api_user[:email] ,params[:req]  
                page_info[:pageNo] = 1
                page_info[:sizePerPage] = params[:pageSize].to_f
                pagedata,page_info = RorBlkctl.add_empty_data screenCode,column_info,page_info  ### nil filtered sorting
                render json:{:columns=>column_info,:data=>pagedata,:pageInfo=>page_info,:yup=>yup,:dropdownlist=>dropdownlist}      
                
              when "updateGridLineData"
                  add_update_rec params
              when "fetch_request"  
                  rparams = chk_fetch_rec params
                  render json: {:params=>rparams}   
              when "confirm"
                linedata = {}
                rparams = params.dup
                JSON.parse(params["linedata"]).each do |field,val|
                  linedata[field] = val
                  if params["yupfetchcode"][field]
                      params["fetchcode"] = %Q%{"#{field}":"#{val}"}%
                      params["fetchview"] = JSON.parse(params["yupfetchcode"])[field]
                      rparams = chk_fetch_rec params  
                      if rparams[:err] == ""
                          rparams[:fetch_data].each do |fd,vl|
                            linedata[fd] = vl
                          end    
                      else
                          render json: {:params=>rparams}
                          return
                      end  
                  end  
                end  
                rparams["linedata"] = JSON.generate(linedata)
                add_update_rec rparams                              
              when 'download'
                screenCode = params[:screenCode]
                column_info,where_info,select_fields,columns_color = RorBlkctl.create_download_columns_info screenCode,current_api_user[:email]  
                if params[:filtered]
                  where_str = RorBlkctl.create_filteredstr params[:filtered],where_info
                else
                   where_str = (where_info[:filtered]||"")
                end    
                pagedata,totalcnt = RorBlkctl.download_data_blk screenCode,select_fields,where_str,columns_color  ### nil filtered sorting

                render json:{:excelData=>{:columns=>column_info,:data=>pagedata},:totalcnt=>totalcnt}       
                  
            end   
        end
        def show
        end
        def  chk_fetch_rec params  
          fetch_data,mainviewflg,keys,findstatus = RorBlkctl.get_fetch_rec params
          if findstatus
              if mainviewflg  ##mainviewflg = true 自分自身の登録
                params[:err] = "error duplicate code #{keys} "
                params[:keys] = []
                keys.split(",").each do |key| 
                  params[:keys] =  [key.split(":")[0].gsub(" ","")] 
                end  
                params[:fetch_data] = {}
              else
                params[:fetch_data] = fetch_data
                params[:err] = ""
                keys.split(",").each do |key| ###コードが変更されたとき既に使用されている？
                    if key =~/_code/
                      ###作成中
                    end  
                end  
              end  
          else
            if mainviewflg
              params[:fetch_data] = {}
              params[:err] = ""
            else
              params[:err] =  "error   --->not find #{keys} "
              params[:fetch_data] = fetch_data
              params[:keys] =[]
              keys.split(",").each do |key| 
                  params[:keys] << key.split(":")[0].gsub(" ","")
              end  
            end  
          end 
          return params 
        end
        def add_update_rec params
          tmp1 =  RorBlkctl.init_from_screen current_api_user,params
          tmp2 = JSON.parse(params["linedata"])
          tmp3 = tmp1.merge(tmp2)
          if tmp3["id"] == ""
             tmp3[:sio_classname] = "_add_update_grid_line_data"
          else         
             tmp3[:sio_classname] = "_edit_update_grid_line_data"
          end       
          command_r = RorBlkctl.proc_update_table(tmp3,1)
          rparams={}
          (JSON.parse params["linedata"]).each do |key,val|
            rparams[key] = command_r[key] if  command_r[key]
          end  
          render json: {:params=>rparams}
        end      
    end
  end
    