module Api
    class MenusController < ApplicationController
        before_action :authenticate_api_user!
          def index
          end
          def create
            case params[:req] 
              when 'viewtablereq','editabletablereq'
                  screenCode = params[:screenCode]
                  if params[:req]  == 'viewtablereq'
                      column_info,page_info,where_info,select_fields = RorBlkctl.create_grid_columns_info screenCode,current_api_user[:email]  
                  else
                      column_info,page_info,where_info,select_fields = RorBlkctl.create_grid_editable_columns_info screenCode,current_api_user[:email]  
                  end    
                   where_info = RorBlkctl.create_filteredstr params[:filtered],where_info
                   page_info[:pageNo] = (params[:page]||=0).to_f 
                   page_info[:pageNo] += 1.0 
                   page_info[:sizePerPage] =params[:pageSize].to_f
                   pagedata,page_info = RorBlkctl.fetch_data screenCode,select_fields,page_info,where_info,nil   ### nil filter sorting
                   render json:{:columns=>column_info,:data=>pagedata,:pageInfo=>page_info } , status: :ok          
              when 'menureq'  
                strsql = "select * from func_get_screen_menu('#{current_api_user[:email]}')"
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
            end   
          end
          def show
          end  
    end
  end
    