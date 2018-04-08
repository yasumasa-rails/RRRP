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
		screen_code = RorBlkctl.get_screen_code params
		prototype = RorBlkctl.get_screen_and_fields_prototype current_user,screen_code
		@screen_prop = prototype[:screen_prop]
		@show_columns = prototype[:show_columns]
        command_c = RorBlkctl.init_from_screen current_user,params,screen_code
		command_c[:sio_viewname]  = @screen_prop[:viewname]
        RorBlkctl.proc_insert_sio_c  command_c  ###画面からの要求内容を記録
        @screen_prop[:page] = 1
        command_c[:sio_start_record] = 1
        command_c[:sio_end_record] = @screen_prop[:sizeperpage]
        @show_records = RorBlkctl.proc_blk_paging  command_c,@screen_prop,prototype[:field_prop]
        @screen_prop[:total_cnt] = command_c[:sio_totalcount]
        @field_prop = prototype[:field_prop]
    end
    def pagination
        debugger
        @res={}
        @res[:datashowrecords] = show_records
        @res[:datashowfields] = show_fields
    end
end