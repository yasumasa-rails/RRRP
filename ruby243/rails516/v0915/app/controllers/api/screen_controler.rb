module Api
    class ScreensController < ApplicationController
      before_action :authenticate_user!
      def index
        @catelist = {}
		cate_list = Rails.cache.fetch('screenlist'+RorBlkctl.grp_code(current_user[:email])) do
		    strsql = "select * from r_screens where substr(screen_grpcodename,1,1) != '#' and screen_expiredate >current_date order by screen_grpcodename"
            ActiveRecord::Base.connection.select_all(strsql).each do |i|
                @catelist[i["screen_grpcodename"][0,1]]||=[]
                vals = RorBlkctl.proc_blkgetpobj(i["pobject_code_scr"],"screen",current_user[:email])
            ##   vals[3] =  RorBlkctl.get_screen_and_fields_prototype(current_user,vals[1])[:show_columns]
                @catelist[i["screen_grpcodename"][0,1]]<< vals
             ### 画面の種類にかかわらずscreen_codeユニークであること。
             # 将来はグループ分けが必要
            end
            @catelist
        end 
        render json: { catelist: @catelist }, status: :ok
      end
    end
  end