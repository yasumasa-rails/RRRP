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
              column_info,page_info,where_info,select_fields,yup,dropdownlist,sort_info,nameToCode = RorBlkctl.create_grid_editable_columns_info screenCode,current_api_user[:email],params[:req]   
              if params["filtered"]
                where_str = RorBlkctl.create_filteredstr params["filtered"],where_info
              else
                 where_str = (where_info["filtered"]||"")
              end    
              page_info[:pageNo] = (params[:page]||=0).to_f 
              page_info[:pageNo] += 1.0 
              page_info[:sizePerPage] =params[:pageSize].to_f
              pagedata,page_info = RorBlkctl.fetch_data_blk screenCode,select_fields,page_info,where_str,sort_info
              render json:{:columns=>column_info,:data=>pagedata,:pageInfo=>page_info,:yup=>yup,:dropdownlist=>dropdownlist,:nameToCode=>nameToCode}       
            
            when 'inlineaddreq'
              screenCode = params[:screenCode]
              column_info,page_info,where_info,select_fields,yup,dropdownlist,sort_info,nameToCode = RorBlkctl.create_grid_editable_columns_info screenCode,current_api_user[:email] ,params[:req]  
              page_info[:pageNo] = 1
              page_info[:sizePerPage] = params[:pageSize].to_f
              pagedata,page_info = RorBlkctl.add_empty_data screenCode,column_info,page_info  ### nil filtered sorting
              render json:{:columns=>column_info,:data=>pagedata,:pageInfo=>page_info,:yup=>yup,:dropdownlist=>dropdownlist,:nameToCode=>nameToCode}      
              
            when "fetch_request"
                xparams = params.dup  
                xparams[:parse_linedata] = JSON.parse(params["linedata"])
                xparams = RorBlkctl.chk_fetch_rec xparams
                render json: {:params=>xparams}   

            when "check_request"  
                  status,rparams = RorBlkctl.judge_check_code params
                  render json: {:params=>rparams}   

            when "confirm"
              rparams = params.dup
              yup_fetch_code = JSON.parse(params["yupfetchcode"])
              yup_check_code = JSON.parse(params["yupcheckcode"])
              rparams[:parse_linedata] = JSON.parse(params["linedata"])
              addfield = {}
              rparams[:parse_linedata].each do |field,val|
                if yup_fetch_code[field] 
                    ##rparams["fetchcode"] = %Q%{"#{field}":"#{val}"}%  ###clientのreq='fetch_request'で利用
                    if rparams[:parse_linedata]["id"].nil?
                        rparams[:parse_linedata]["aud"]= "add" 
                    end  
                    rparams["fetchview"] = yup_fetch_code[field]
                    rparams = RorBlkctl.chk_fetch_rec rparams  
                    if rparams[:err] == ""
                        if yup_check_code[field] and val != ""
                            rparams["checkcode"] = %Q%{"#{field}":"#{val}"}%
                            rparams = RorBlkctl.judge_check_code rparams
                        end
                    else
                      rparams[:parse_linedata][:confirm_gridmessage] = rparams[:err] 
                      rparams[:parse_linedata][(field+"_gridmessage").to_sym] = rparams[:err] 
                    end
                end
              end
              if  rparams[:err] == ""
                  command_c =  RorBlkctl.init_from_screen rparams[:uid],rparams[:screenCode]
                  linedata={}
                  (rparams[:parse_linedata]).each do |key,val|
                      command_c[key] = rparams[:parse_linedata][key]
                  end 
                  linedata = rparams[:parse_linedata].dup
                  if command_c["id"] == ""
                      command_c[:sio_classname] = "_add_update_grid_line_data"
                  else         
                      command_c[:sio_classname] = "_edit_update_grid_line_data"
                  end
                  command_r = RorBlkctl.add_update_rec(rparams,command_c) 
                  RorBlkctl.proc_update_table(command_r,1,nil,nil,nil)
              else 
                  linedata = rparams[:parse_linedata].dup 
              end  
              render json: {:linedata=>linedata}

            when 'download'
              screenCode = params[:screenCode]
              column_info,where_info,select_fields,columns_color = RorBlkctl.create_download_columns_info screenCode,current_api_user[:email]  
              if params["filtered"]
                where_str = RorBlkctl.create_filteredstr params["filtered"],where_info
              else
                 where_str = (where_info["filtered"]||"")
              end    
              pagedata,totalcnt = RorBlkctl.download_data_blk screenCode,select_fields,where_str,columns_color  ### nil filtered sorting

              render json:{:excelData=>{:columns=>column_info,:data=>pagedata},:totalcnt=>totalcnt}       
                
          end   
      end
      def show
      end
  end    
end
