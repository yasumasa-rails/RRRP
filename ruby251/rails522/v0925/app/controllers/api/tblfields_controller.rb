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
                messages,modifysql = TblField.blktbs params,current_api_user
                foo = File.open("#{Rails.root}/vendor/postgresql/tblviewupdate#{(Time.now).strftime("%Y%m%d%H%M%S")}.sql", "w:UTF-8") # 書き込みモード
                foo.puts modifysql
                foo.close
                foo = File.open("#{Rails.root}/vendor/postgresql/messages#{(Time.now).strftime("%Y%m%d%H%M%S")}.sql", "w:UTF-8") # 書き込みモード
                foo.puts messages
                foo.close
                params[:messages] = 	messages 
                render json:{:params=>params}  
              when 'createUniqueIndex'  ### createUniqueIndex
                messages,sql = TblField.createUniqueIndex params
                foo = File.open("#{Rails.root}/vendor/postgresql/tblviewupdate#{(Time.now).strftime("%Y%m%d%H%M%S")}.sql", "w:UTF-8") # 書き込みモード
                foo.puts sql
                foo.close
                foo = File.open("#{Rails.root}/vendor/postgresql/messages#{(Time.now).strftime("%Y%m%d%H%M%S")}.txt", "w:UTF-8") # 書き込みモード
                foo.puts messages
                foo.close
                params[:messages] = 	messages 
                render json:{:params=>params}  
            end 
          end
          def show
          end  
    end
  end
    