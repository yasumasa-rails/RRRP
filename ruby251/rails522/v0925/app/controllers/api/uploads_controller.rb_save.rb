module Api
  require 'rubyXL'
  class UploadsController < ApplicationController
    before_action :authenticate_api_user!
    before_action :set_upload, only: [:update]

    # GET /api/uploads
      def index
      end

    # PUT /api/recipes/1
      def update
      end
      
      def create
        upload = Upload.create!(upload_params)
        ##redirect_to :action => "show", :id => upload.id
        ##debugger
        blob_path = Rails.application.routes.url_helpers.rails_blob_path(upload.excel, only_path: true)
        screenCode = blob_path.split("/")[-1].split(/\@|\.|\#/)[0]
        binary = upload.excel.download
        workbook = RubyXL::Parser.parse_buffer binary
        ###p "test test    #{workbook[0].sheet_name}"
        column_info,page_info,where_info,select_fields,yup,dropdownlist,sort_info,nameToCode = RorBlkctl.create_grid_editable_columns_info screenCode,current_api_user[:email],"inlineaddreq" 
        
        strsql = "select	column_name from 	information_schema.columns 
                  where 	table_catalog='#{ActiveRecord::Base.configurations["development"]["database"]}' 
                  and table_name='#{screenCode}'
                  and column_name like '%_id%' and  column_name not like  '%person_id_upd'
                  and split_part(column_name,'_',1) = '#{screenCode.split("_",2)[1].chop}'"
        keyids = ActiveRecord::Base.connection.select_values(strsql)
        @fieldcode = []
        @newworkbook = RubyXL::Workbook.new
        workbook.each do |wsheet|
            case  wsheet.sheet_name
            when "add"
                  error = chk_field_code(wsheet,keyids,nameToCode)
                  if error.size > 1
                    @newworkbook[wsheet.sheet_name].each_with_index |sheet,index|
                      sheet[index][0].change_contents(error)
                    end
                  else
                    error,newsheet,command_rs = chk_field_contents(wsheet)
                    if error
                        newsheet
                    else
                        command_rs
                    end
                  end
            when "update"
                  error,newsheet = chk_field_code(wsheet,keyids,nameToCode)
                  if error.size > 1
                    @newworkbook[wsheet.sheet_name].each_with_index |sheet,index|
                      sheet[index][0].change_contents(error)
                    end
                  else
                      error,newsheet,command_rs = chk_field_contents(wsheet)
                      if error
                        @newworkbook[wsheet.sheet_name].each_with_index |sheet,index|
                          sheet[index][0].change_contents(error)
                        end
                      else
                          command_rs
                      end
                  end
            when "delete"
                  error,newsheet = chk_field_code(wsheet,keyids,nameToCode)
                  if error.size > 1
                    @newworkbook[wsheet.sheet_name].each_with_index |sheet,index|
                      sheet[index][0].change_contents(error)
                    end
                  else
                      error,command_rs = chk_field_contents(wsheet)
                      if error
                          newsheet
                      else
                          command_rs
                      end
                  end
            else  
                "sheet name error"
            end  
        end
        render json:upload
      end

      def show
      end
    private
        def upload_params
          params.require(:upload).permit(:excel,:title)
        end 
      # Use callbacks to share common setup or constraints between actions.
      def set_upload
          @upload = Upload.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def update_params
        params.permit(:id,:title, :contents)
      end
      def create_params
        params.permit(:excel)
      end
      def chk_field_code(wsheet,keyids,nameToCode)
          error = ""
          wsheet[0].each do |key,val|
            if keyids[key]
                @fieldcode << key
            else
              if nameToCode[key]
                  @fieldcode << nameToCode[key]
              else
                  error << " field #{key} not exists , "
                  break
              end       
            end  
          end
          @newworkbook.add_worksheet(wsheet.sheet_name)
          @newworkbook[wsheet.sheet_name].insert_column(1)
          @newworkbook[wsheet.sheet_name][0][0].change_contents("confirm") 
          @newworkbook[wsheet.sheet_name][1][0].change_contents(error) 
      end
  end
end  