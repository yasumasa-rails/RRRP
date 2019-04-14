module Api
    class MenusController < ApplicationController
        before_action :authenticate_api_user!
          def index
          end
          def create
            if params[:id]  ###id screen_code
                id = params[:id]
                if params[:page]>0 
                   column_info,page_info,where_info,select_fields = RorBlkctl.create_grid_columns_info id,current_api_user[:email]  
                   where_info = RorBlkctl.create_filteredstr params[:filtered],where_info
                   pagedata,page_info = RorBlkctl.fetch_data id,select_fields,page_info,where_info,nil   ### nil filter sorting
                   render json:{:rows=>pagedata,:pages=>page_info[:totalPage] } , status: :ok
                else
                  column_info,page_info,where_info,select_fields = RorBlkctl.create_grid_columns_info id,current_api_user[:email]  
                  pagedata,page_info = RorBlkctl.fetch_data id,select_fields,page_info,nil,nil   ### nil filter sorting
                  render json:{:columns=>column_info,:pageInfo=>page_info,:data=>pagedata} , status: :ok
                end  
            else      
                strsql = "select * from func_screen_menu('#{current_api_user[:email]}')"
                recs = ActiveRecord::Base.connection.select_all(strsql)
                 render json:  recs , status: :ok
            end   
          end
          def show
          end  
    end
  end
    