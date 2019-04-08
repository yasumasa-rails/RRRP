module Api
    class MenusController < ApplicationController
        before_action :authenticate_api_user!
          def index
          end
          def create
            if params[:id]  ###id screen_code
                if params[:where]
                  render json:  [{:a=>"a"},{:b=>"b"}] , status: :ok
                else
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
    