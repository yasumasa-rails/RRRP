module Api
    class TblfieldsController < ApplicationController
        before_action :authenticate_api_user!
          def index
          end
          def create
            case params[:req] 
              when 'yup'
                yup = YupSchema.create_schema 	
                foo = File.open("#{Rails.root}/vendor/yup/yupschema.js", "w:UTF-8") # 書き込みモード
                foo.puts yup[:yupschema]
                params[:message] = " yup schema created " 
                render json:{:params=>params} 
              when 'createTblViewScreen'  ### blktbs tblfields 
	            	@messages =[]
		            @modifysql = ""
                TblField.blktbs params	
                foo = File.open("#{Rails.root}/vendor/postgesql/tblviewupdate#{(Time.now).strftime("%Y/%m/%d%H%M")}.sql", "w:UTF-8") # 書き込みモード
                foo.puts @modifysql
                params[:messages] = 	@messages 
                render json:{:params=>params}  
            end 
          end
          def show
          end  
    end
  end
    