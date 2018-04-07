class ScreensController < ApplicationController
    before_action :sign_in_required, only: [:index]
    before_action :set_users, only: [:show, :edit, :update, :destroy,:create]
    before_action :authenticate_user!
  
    def index
         crtcachelist
    end
	#### 
    def crtcachelist ### grpcode
        catelist = {}
		cate_list = Rails.cache.fetch('screenlist'+RorBlkctl.grp_code(current_user[:email])) do
		    strsql = "select * from r_screens where substr(screen_grpcodename,1,1) != '#' and screen_expiredate >current_date order by screen_grpcodename"
            ActiveRecord::Base.connection.select_all(strsql).each do |i|
                catelist[i["screen_grpcodename"][0,1]]||=[]
                catelist[i["screen_grpcodename"][0,1]]<<RorBlkctl.proc_blkgetpobj(i["pobject_code_scr"],"screen",current_user[:email])
             ### 画面の種類にかかわらずscreen_codeユニークであること。
             # 将来はグループ分けが必要
            end
            catelist
        end  
        @cate_list = cate_list.to_a
    end
    def show
        RorBlkctl.init_from_screen current_user,params
        @screen_prototype[:page] = 1
        @command_c[:sio_start_record] = 1
        @command_c[:sio_end_record] = @screen_prototype[:sizeperpage]
        RorBlkctl.proc_blk_paging  @screen_code
        ##debugger
        ##@show_columns = "[{ dataField :'pobject_code_view',            text:'pobject_code_view',             hidden :false},{ dataField :'id',            text:'id',                   hidden :false}];"
        ##@show_records = "[{pobject_code_view: 'r_prdrets',id : '12345' }]"
    end
end