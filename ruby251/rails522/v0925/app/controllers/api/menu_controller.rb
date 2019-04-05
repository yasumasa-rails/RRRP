module Api
    class MenuController < ApplicationController
          def index
              strsql = "select * from func_screen_menu('#{current_api_user[:email]}')"
              recs = ActiveRecord::Base.connection.select_all(strsql)
              render json:  recs , status: :ok
          end
    end
  end
    