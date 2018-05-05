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
            @title = "screen list"
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
        command_c[:sio_start_record] = 0
        command_c[:sio_end_record] = 0
        @show_records = RorBlkctl.proc_blk_paging  command_c,@screen_prop,prototype[:field_prop]
        @screen_prop[:total_cnt] = command_c[:sio_totalcount]
        if @screen_prop[:sizePerPageList][-1].class ==  Hash
        else    
            @screen_prop[:sizePerPageList] << {:text =>'all',:value=>@screen_prop[:total_cnt]}
        end    
        @field_prop = prototype[:field_prop]
        @title = @screen_prop [:screen_name]
        render  :layout => "screen"
    end
    def pagination
		screen_code = RorBlkctl.get_screen_code params
		prototype = RorBlkctl.get_screen_and_fields_prototype current_user,screen_code
        command_c = RorBlkctl.init_from_screen current_user,params[:keynewState],screen_code
		command_c[:sio_viewname]  = prototype[:screen_prop][:viewname]
        RorBlkctl.proc_insert_sio_c  command_c  ###画面からの要求内容を記録
        subParams = (JSON.parse params[:keynewState]).with_indifferent_access
        command_c[:sio_start_record] =  1 + (subParams[:page] -1) * subParams[:sizePerPage]
        command_c[:sio_end_record] = subParams[:sizePerPage] * subParams[:page] 
        subParams[:sqlrecstr] = prototype[:screen_prop][:sqlrecstr]
        show_records = RorBlkctl.proc_blk_paging  command_c,subParams,prototype[:field_prop]
        @res={}
        @res[:datashowrecords] = show_records
        @res[:total_cnt] = command_c[:sio_totalcount]
        render :partical =>"pagination", :layout => false
    end
    def showfields
		screen_code = RorBlkctl.get_screen_code params
        prototype = RorBlkctl.get_screen_and_fields_prototype current_user,screen_code
        ##@res = {}
        @res= prototype[:show_columns]
        render 'showfields', formats: 'json', handlers: 'jbuilder'
    end
end