class UpdateUploadService
    def initialize(upload, params)
      @upload = upload
      @params = params
    end
  
    def call
      if @params[:excel] && !file?(@params[:excel])
        delete_excel if @upload.excel.attached?
        @params.delete(:excel)
      end
  
      @upload.update(@params)
    end
  
    private
  
    def file?(param)
      param.is_a?(ActionDispatch::Http::UploadedFile)
    end
  
    def delete_excel
      @upload.excel.purge
    end
  end