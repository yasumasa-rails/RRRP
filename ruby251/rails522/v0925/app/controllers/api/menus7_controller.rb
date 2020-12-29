module Api
  class Menus7Controller < ApplicationController
      before_action :authenticate_api_user!
      def index
      end
      def create
            grid_columns_info = {}
            strsql = "select person_code_chrg from r_chrgs rc where person_email_chrg = '#{current_api_user[:email]}'"
            person_code_chrg = ActiveRecord::Base.connection.select_value(strsql)
            params[:person_code_chrg] = person_code_chrg
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
                strsql = "select pobject_code_scr_ub screen_code,button_code,button_contents,button_title
                        from r_usebuttons u
                        inner join r_persons p on u.screen_scrlv_id_ub = p.person_scrlv_id
                                   and p.person_email = '#{current_api_user[:email]}' 
                        where usebutton_expiredate > current_date
                        order by pobject_code_scr_ub,button_seqno"
                recs = ActiveRecord::Base.connection.select_all(strsql)
                render json:  recs , status: :ok
            
            when 'viewtablereq7','inlineedit7'
                ScreenLib.proc_create_grid_editable_columns_info current_api_user[:email],params,grid_columns_info
                if params[:filtered]  ###sortの処理はScreenLib内部だけ
                    ScreenLib.proc_create_filteredstr params,grid_columns_info
                else
                  if grid_columns_info["init_where_info"]["filtered"]
                    if grid_columns_info["init_where_info"]["filtered"].size > 1
                      params[:where_str] = " where " + grid_columns_info["init_where_info"]["filtered"] 
                    end
                  end   
                  ###@where_info["filtered"] screen sort 規定値
                  params[:filtered]="[]"
                end    
                params[:pageIndex] = params[:pageIndex].to_f
                params[:pageSize] = params[:pageSize].to_f
                params[:disableFilters] = false
                pagedata = ScreenLib.proc_search_blk params,grid_columns_info   ###:pageInfo ,:yup -->menu7から未使用
                render json:{:grid_columns_info=>grid_columns_info,:data=>pagedata,:params=>params}
                # render json:{:columns=>grid_columns_info["columns_info"],:data=>pagedata,:pageInfo=>{},:params=>params,
                #        :yup=>grid_columns_info["yup"],:dropdownlist=>grid_columns_info["dropdownlist"],   　　
                ##:nameToCode=>grid_columns_info["nameToCode"]}         
             
            when 'inlineadd7'
                ScreenLib.proc_create_grid_editable_columns_info current_api_user[:email] ,params,grid_columns_info
                params[:pageIndex] = 0
                params[:filtered]="[]"
                params[:sort]="[]"
                pagedata = ScreenLib.add_empty_data  params,grid_columns_info ### nil filtered sorting
                render json:{:grid_columns_info=>grid_columns_info,:data=>pagedata,:params=>params}               
          
            when "fetch_request"
                xparams = params.dup   ### ControlFields.proc_chk_fetch_rec でparamsがnilになってしまうため。　　
                xparams[:parse_linedata] = JSON.parse(params[:linedata])
                xparams = ControlFields.proc_chk_fetch_rec xparams
                xparams[:parse_linedata] = {}
                render json: {:params=>xparams}   

            when "check_request"  
                xparams = params.dup ## ControlFields.proc_judge_check_code でparamsがnilになってしまうため。
                xparams[:parse_linedata] =  JSON.parse(params[:linedata])
                xparams = ControlFields.proc_judge_check_code xparams
                xparams[:parse_linedata] = {}
                render json: {:params=>xparams}   

            when "confirm7"
                rparams = params.dup
                ScreenLib.proc_create_grid_editable_columns_info current_api_user[:email],params,grid_columns_info
                tblnamechop = params[:screenCode].split("_")[1].chop
                yup_fetch_code = grid_columns_info["yup"]["yupfetchcode"]
                yup_check_code = grid_columns_info["yup"]["yupcheckcode"]
                rparams[:parse_linedata] = JSON.parse(params[:linedata])
                parse_linedata = rparams[:parse_linedata].dup
                addfield = {}
                rparams[:err] = ""
                parse_linedata.each do |field,val|
                  if yup_fetch_code[field] 
                    ##rparams["fetchcode"] = %Q%{"#{field}":"#{val}"}%  ###clientのreq='fetch_request'で利用
                    if rparams[:parse_linedata]["id"] == ""  ###tableのユニークid
                        rparams[:parse_linedata]["aud"]= "add" 
                    end  
                    rparams["fetchview"] = yup_fetch_code[field]
                    rparams = ControlFields.proc_chk_fetch_rec rparams  
                    if rparams[:err] != ""  
                      rparams[:parse_linedata][:confirm_gridmessage] = rparams[:err] 
                      rparams[:parse_linedata][:confirm] = false 
                      rparams[:parse_linedata][(field+"_gridmessage").to_sym] = rparams[:err] 
                      break
                    end
                  end
                  if rparams[:err] == ""
                    if yup_check_code[field] 
                      rparams = ControlFields.proc_judge_check_code rparams  
                      if rparams[:err] != ""
                        rparams[:parse_linedata][:confirm_gridmessage] = rparams[:err] 
                        rparams[:parse_linedata][:confirm] = false 
                        rparams[:parse_linedata][(field+"_gridmessage").to_sym] = rparams[:err] 
                        break
                      end
                    end
                  end    
                end	
                if  rparams[:err] == ""
                  command_c =  RorBlkctl.init_from_screen rparams[:uid],rparams[:screenCode]
                  parse_linedata = rparams[:parse_linedata].dup
                  parse_linedata.each do |key,val|
                      if key.to_s =~ /_id/ and val == ""   and tblnamechop == key.to_s.split("_")[0] and
                         key.to_s !~ /_gridmessage$/ and  key.to_s !~ /_person_id_upd$/ and  key.to_s != "#{tblnamechop}_id"
                            rparams[:parse_linedata][:confirm_gridmessage] = " key #{key.to_s} missing"
                            rparams[:parse_linedata][:confirm] = false 
                            rparams[:err] = "error  key #{key.to_s} missing"
                            break
                      else
                            command_c[key] = rparams[:parse_linedata][key]
                      end
                  end 
                  ### セカンドkeyのユニークチェック
                  err = ControlFields.proc_blkuky_check params[:screenCode].split("_")[1],rparams[:parse_linedata]
                  err.each do |key,recs|
                    recs.each do |rec|
                        if command_c["id"] != rec["id"]
                            rparams[:err] = " error #{key} already exist "
                            rparams[:parse_linedata][("confirm_gridmessage").to_sym] = rparams[:err] 
                            rparams[:parse_linedata][:confirm] = false 
                        end  
                    end	
                  end	
                end
                if  rparams[:err] == "" and rparams[:screenCode] =~ /tblfields/
                        strsql =  %Q%  select screenfield_seqno,pobject_code_sfd from r_screenfields  
                              where screenfield_expiredate > current_date and 
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
                    rparams[:parse_linedata][:confirm] = false 
                  else
                    if (seqchkfields["screenfield_qty_case"]||="99999") <  (seqchkfields["screenfield_qty"]||="0")
                        rparams[:err] =  " qty_case seqno > qty seqno  "  ###画面表示順　　包装単位の計算ため
                        rparams[:parse_linedata][("confirm_gridmessage").to_sym] = rparams[:err] 
                        rparams[:parse_linedata][:confirm] = false 
                    end
                  end
                end
                if  rparams[:err] == ""
                  if command_c["id"] == "" or  command_c["id"].nil?
                      command_c[:sio_classname] = "_add_update_grid_line_data"
                  else         
                      command_c[:sio_classname] = "_edit_update_grid_line_data"
                  end
                  RorBlkctl.proc_update_table(command_c,1)
                  if command_c[:sio_result_f]  == "9"
                    rparams[:parse_linedata][:confirm] = false  
                    err_message = command_c[:sio_message_contents].split(":")[1][0..100] + 
                                  command_c[:sio_errline].split(":")[1][0..100]  
                    rparams[:parse_linedata][("confirm_gridmessage").to_sym] = err_message
                  else
                    rparams[:parse_linedata][:id] = command_c["id"]
                    rparams[:parse_linedata][(tblnamechop+"_id").to_sym] = command_c[tblnamechop+"_id"]
                    rparams[:parse_linedata][:confirm] = true  
                    rparams[:parse_linedata][("confirm_gridmessage").to_sym] = "done"
                  end
                end 
                render json: {:linedata=> rparams[:parse_linedata]}

            when 'download7'
                ScreenLib.proc_create_grid_editable_columns_info current_api_user[:email],params,grid_columns_info
                if params[:filtered]
                    ScreenLib.proc_create_filteredstr params,grid_columns_info
                else
                  params[:where_str] = (grid_columns_info["where_info"]["filtered"]||"")
                end 
                download_columns_info = ScreenLib.proc_create_download_columns_info params,current_api_user[:email]  
                pagedata = ScreenLib.proc_download_data_blk params,download_columns_info  ### nil filtered sorting
                render json:{:excelData=>{:columns=>download_columns_info["columns_info"],:data=>pagedata},:totalCount=>params[:totalCount]}    

            when 'mkshpinsts'  ###shpordsは作成済が条件
                outcnt,shortcnt,err = ScreenLib.proc_mkshpinsts params[:screenCode],params[:clickIndex]
                render json:{:outcnt=>outcnt,:shortcnt=>shortcnt,:err=>err}    
            
            when 'mkshpacts'
                params[:where_str] ||= ""
                params[:filtered] ||= []
                params[:pageIndex] ||= 0
                params[:pageSize] ||= 100
                req = params[:req] = "inlineedit7"
                screenCode = params[:screenCode] = "foract_shpinsts"   ###shpinstsがshpactsに変わるため
                ScreenLib.proc_create_grid_editable_columns_info current_api_user[:email],params,grid_columns_info
                pagedata = ScreenLib.proc_mkshpacts params,grid_columns_info
                render json:{:grid_columns_info=>grid_columns_info,:data=>pagedata,:params=>params}  
            
            when 'refshpacts'
                params[:where_str] ||= ""
                params[:filtered] ||= []
                params[:pageIndex] ||= 0
                params[:pageSize] ||= 100
                req = params[:req] = "'viewtablereq7'"
                screenCode = params[:screenCode] = "r_shpacts"   ###shpinstsがshpactsに変わるため
                ScreenLib.proc_create_grid_editable_columns_info current_api_user[:email],params,grid_columns_info
                pagedata = ScreenLib.proc_refshpacts params,grid_columns_info
                render json:{:grid_columns_info=>grid_columns_info,:data=>pagedata,:params=>params}
  
            when 'confirm_all'  ###チェック済が条件
                case params[:screenCode]
                when "foract_shpinsts"
                    outcnt,shortcnt,err = ScreenLib.proc_shpact_confirmall params
                    render json:{:outcnt=>outcnt,:err=>err}  
                end  
            else
              p "#{Time.now} : req-->#{req} not support "    
          end   
      end
      def show
      end
  end    
end
