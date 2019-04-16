module Api
    class MenusController < ApplicationController
        before_action :authenticate_api_user!
          def index
          end
          def create
            if params[:screenCode]  ##
                screenCode = params[:screenCode]
                   column_info,page_info,where_info,select_fields = RorBlkctl.create_grid_columns_info screenCode,current_api_user[:email]  
                   where_info = RorBlkctl.create_filteredstr params[:filtered],where_info
                   page_info[:pageNo] = (params[:page]||=0).to_f 
                   page_info[:pageNo] += 1.0 
                   page_info[:sizePerPage] =params[:pageSize].to_f
                   pagedata,page_info = RorBlkctl.fetch_data screenCode,select_fields,page_info,where_info,nil   ### nil filter sorting
                   render json:{:columns=>column_info,:data=>pagedata,:pageInfo=>page_info } , status: :ok
            else      
                strsql = "select * from func_get_screen_menu('#{current_api_user[:email]}')"
                recs = ActiveRecord::Base.connection.select_all(strsql)
                 render json:  recs , status: :ok
            end   
          end
          def show
          end  
    end
  end
    