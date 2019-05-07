module Api
  class UploadsController < ApplicationController
    before_action :authenticate_api_user!
    before_action :set_upload, only: [:update]

    # GET /api/uploads
      def index
        strsql = "select id from persons where email = '#{params[:email]}'"
        persons_id = ActiveRecord::Base.connection.select_value(strsql)
        render json: Upload.order(:updated_at).where(persons_id_upd:"'#{persons_id}'").take(params[:count]).with_attached_excel
      end

    # PUT /api/recipes/1
      def update
        if @upload.update(update_params)
          render json: @upload
        else
          render json: @upload.errors, status: :unprocessable_entity
        end
      end
      #def create
      #  if CreateUploadService.new(Upload, create_params).call
      #      render json: @upload
      #  else
      #      ##render json: @upload.errors, status: :unprocessable_entity
      #      render json: {:error=>"NG"}
      #  end
      #end 
      def create
        upload = Upload.create!(upload_params)
        ##redirect_to :action => "show", :id => upload.id
        render json:upload
      end

      def show
      end
    private
        def upload_params
          params.require(:upload).permit(:id,:title,:contents,:excel)
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
  end
end  