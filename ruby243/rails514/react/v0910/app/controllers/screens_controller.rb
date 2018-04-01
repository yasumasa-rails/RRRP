class ScreensController < ApplicationController
    before_action :sign_in_required, only: [:index]
    before_action :set_users, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!
  
    def index
         crtcachelist
    end
	#### 
    def crtcachelist ### grpcode
        catelist = {}
		cate_list = Rails.cache.fetch('screenlist'+RorBlkctl.grp_code(current_user)) do
		    strsql = "select * from r_screens where substr(screen_grpcodename,1,1) != '#' and screen_expiredate >current_date order by screen_grpcodename"
	        ActiveRecord::Base.connection.select_all(strsql).each do |i|
                catelist[i["screen_grpcodename"][0,1]]||=[]
                catelist[i["screen_grpcodename"][0,1]]<<RorBlkctl.proc_blkgetpobj(i["pobject_code_scr"],"screen",current_user) 
             ### 画面の種類にかかわらずscreen_codeユニークであること。
             # 将来はグループ分けが必要
            end
            catelist
        end  
        @cate_list = cate_list.to_a
    end
end