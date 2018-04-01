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
        ###  ダブルコーティション　「"」は使用できない。 
        sqlstr = "select pobject_code_sfd,screenfield_hideflg,screenfield_editable,screenfield_indisp ,
                    pobject_code_view,screen_strwhere,screen_rows_per_page,screen_rowlist
                    from r_screenfields
                    where pobject_code_scr = '#{params[:sid]}' and screenfield_expiredate > current_date and screenfield_selection = 1
                    order by screenfield_seqno"
        show_columns = "["
        sqlrecstr = ""
        @screen_prototype ={}
        ActiveRecord::Base.connection.select_all(sqlstr).each_with_index do |i,cnt|
            show_columns << %Q%{ dataField :"#{i["pobject_code_sfd"]}",
            text:"#{RorBlkctl.proc_blkgetpobj(i["pobject_code_sfd"],"view_field",current_user[:email])[0]}",
            hidden  :#{if i["screenfield_hideflg"] == "1" then true else false end}},%
            sqlrecstr << i["pobject_code_sfd"] + ","
            if cnt == 0
                @screen_prototype[:pobject_code_src] = i["pobject_code_src"]
                @screen_prototype[:pobject_code_view] = i["pobject_code_view"]
                @screen_prototype[:screen_strwhere] = i["screen_strwhere"]
                @screen_prototype[:screen_rows_per_page] = i["screen_rows_per_page"]
                @screen_prototype[:screen_rowlist] = i["screen_rowlist"]
            end
        end
        @show_columns = show_columns.chop.gsub(/\n/,"") + "]"
        ###sqlstr = "select #{sqlrecstr.chop} from #{params[:sid]} where length(trim(screen_strwhere)) != 0   limit 110 "
        sqlstr = "select #{sqlrecstr.chop} from #{@screen_prototype[:pobject_code_view]}"
        recs = ActiveRecord::Base.connection.select_all(sqlstr)
        RorBlkctl.proc_blk_paging  {},""
        show_records = "["
        recs.each do |rec|
            show_records << RorBlkctl.proc_tbl_rec_to_screen_field(rec)
        end    
        @show_records = show_records.chop + "]"
        ##debugger
        ##@show_columns = "[{ dataField :'pobject_code_view',            text:'pobject_code_view',             hidden :false},{ dataField :'id',            text:'id',                   hidden :false}];"
        ##@show_records = "[{pobject_code_view: 'r_prdrets',id : '12345' }]"
    end
end