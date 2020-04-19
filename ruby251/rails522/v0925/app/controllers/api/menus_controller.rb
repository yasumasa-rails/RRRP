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
              column_info,page_info,where_info,select_fields,yup,dropdownlist,sort_info,nameToCode = RorBlkctl.proc_create_grid_editable_columns_info screenCode,current_api_user[:email],params[:req]   
              if params["filtered"]
                where_str = RorBlkctl.proc_create_filteredstr params["filtered"],where_info
              else
                 where_str = (where_info["filtered"]||"")
              end    
              page_info[:pageNo] = (params[:page]||=0).to_f 
              page_info[:pageNo] += 1.0 
              page_info[:sizePerPage] =params[:pageSize].to_f
              pagedata,page_info = RorBlkctl.proc_search_blk screenCode,select_fields,page_info,where_str,sort_info
              render json:{:columns=>column_info,:data=>pagedata,:pageInfo=>page_info,:yup=>yup,:dropdownlist=>dropdownlist,:nameToCode=>nameToCode}       
            
            when 'inlineaddreq'
              screenCode = params[:screenCode]
              column_info,page_info,where_info,select_fields,yup,dropdownlist,sort_info,nameToCode = RorBlkctl.proc_create_grid_editable_columns_info screenCode,current_api_user[:email] ,params[:req]  
              page_info[:pageNo] = 1
              page_info[:sizePerPage] = params[:pageSize].to_f
              pagedata,page_info = RorBlkctl.add_empty_data screenCode,column_info,page_info  ### nil filtered sorting
              render json:{:columns=>column_info,:data=>pagedata,:pageInfo=>page_info,:yup=>yup,:dropdownlist=>dropdownlist,:nameToCode=>nameToCode}      
              
            when "fetch_request"
                xparams = params.dup  
                xparams[:parse_linedata] = JSON.parse(params["linedata"])
                xparams = ControlFields.proc_chk_fetch_rec xparams
                render json: {:params=>xparams}   

            when "check_request"  
                  xparams = params.dup  
                  xparams[:parse_linedata] =  JSON.parse(xparams[:linedata])
                  rparams = ControlFields.proc_judge_check_code xparams
                  render json: {:params=>rparams}   

            when "confirm"
              rparams = params.dup
              tblnamechop = params[:screenCode].split("_")[1].chop
              yup_fetch_code = JSON.parse(params["yupfetchcode"])
              yup_check_code = JSON.parse(params["yupcheckcode"])
              rparams[:parse_linedata] = JSON.parse(params["linedata"])
              parse_linedata = rparams[:parse_linedata].dup
              addfield = {}
              rparams[:err] = ""
              parse_linedata.each do |field,val|
                if yup_fetch_code[field] 
                    ##rparams["fetchcode"] = %Q%{"#{field}":"#{val}"}%  ###clientのreq='fetch_request'で利用
                    if rparams[:parse_linedata]["id"] == ""
                        rparams[:parse_linedata]["aud"]= "add" 
                    end  
                    rparams["fetchview"] = yup_fetch_code[field]
                    rparams = ControlFields.proc_chk_fetch_rec rparams  
                    if rparams[:err] != ""  
                      rparams[:parse_linedata][:confirm_gridmessage] = rparams[:err] 
                      rparams[:parse_linedata][(field+"_gridmessage").to_sym] = rparams[:err] 
                      break
                    end
                end
                if rparams[:err] == ""
                  if yup_check_code[field] 
                    rparams = ControlFields.proc_judge_check_code rparams  
                    if rparams[:err] != ""
                      rparams[:parse_linedata][:confirm_gridmessage] = rparams[:err] 
                      rparams[:parse_linedata][(field+"_gridmessage").to_sym] = rparams[:err] 
                      break
                    end
                  end
                end    
              end	
              if  rparams[:err] == ""
                  command_c =  RorBlkctl.init_from_screen rparams[:uid],rparams[:screenCode]
                  parse_linedata.each do |key,val|
                      if key.to_s =~ /_id/ and val == ""   and tblnamechop == key.to_s.split("_")[0] and
                         key.to_s !~ /_gridmessage$/ and  key.to_s !~ /_person_id_upd$/ and  key.to_s != "#{tblnamechop}_id"
                          rparams[:parse_linedata][:confirm_gridmessage] = " key #{key.to_s} missing"
                          rparams[:err] = "error  key #{key.to_s} missing"
                          break
                      else
                          command_c[key] = rparams[:parse_linedata][key]
                      end
                  end 
                  ### セカンドkeyのユニークチェック
                  err = ControlFields.blkuky_check params[:screenCode].split("_")[1],rparams[:parse_linedata]
                  err.each do |key,recs|
                    recs.each do |rec|
                        if command_c["id"] != rec["id"]
                            rparams[:err] = key + " already exist "
                            rparams[:parse_linedata][("confirm_gridmessage").to_sym] = rparams[:err] 
                        end  
                    end	
                  end	
              end
              if  rparams[:err] == "" and rparams[:screenCode] =~ /tblfields/
                              strsql =  %Q%  select screenfield_seqno,pobject_code_sfd from r_screenfields  where screenfield_expiredate > current_date and 
                              id in (select id from r_screenfields where pobject_code_scr = '#{params[:screenCode]}') and
                              pobject_code_sfd in('screenfield_starttime','screenfield_duedate','screenfield_qty','screenfield_qty_case')
                  %
                  seqchkfields ={}
                  recs = ActiveRecord::Base.connection.select_all(strsql)
                  recs.each do |rec|
                    seqchkfields[rec["pobject_code_sfd"]] = rec["screenfield_seqno"]
                  end  
                  seqchkfields[rparams[:parse_linedata]["pobject_code_sfd"]] = rparams[:parse_linedata]["screenfield_seqno"]
                  if (seqchkfields["screenfield_starttime"]||="99999") <  (seqchkfields["screenfield_duedate"]||="0")
                    rparams[:err] =  " starttime seqno > duedate seqno  "
                    rparams[:parse_linedata][("confirm_gridmessage").to_sym] = rparams[:err] 
                  else
                    if (seqchkfields["screenfield_qty_case"]||="99999") <  (seqchkfields["screenfield_qty"]||="0")
                        rparams[:err] =  " qty_case seqno > qty seqno  "  ###画面表示順　　包装単位の計算ため
                        rparams[:parse_linedata][("confirm_gridmessage").to_sym] = rparams[:err] 
                    end
                  end
              end
              if  rparams[:err] == ""
                  if command_c["id"] == ""
                      command_c[:sio_classname] = "_add_update_grid_line_data"
                  else         
                      command_c[:sio_classname] = "_edit_update_grid_line_data"
                  end
                  RorBlkctl.proc_update_table(command_c,1)
                  rparams[:parse_linedata][:confirm] = true  
                  rparams[:parse_linedata][("confirm_gridmessage").to_sym] = "done"
              end 
              render json: {:linedata=> rparams[:parse_linedata]}

            when 'download'
              screenCode = params[:screenCode]
              column_info,where_info,select_fields,columns_color = RorBlkctl.create_download_columns_info screenCode,current_api_user[:email]  
              if params["filtered"]
                where_str = RorBlkctl.proc_create_filteredstr params["filtered"],where_info
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
