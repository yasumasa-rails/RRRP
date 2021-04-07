class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
       ## before_action :authenticate_api_user!
	$ftype = {}
	strsql = %Q&select pobject_code_fld,fieldcode_ftype from r_fieldcodes
	        	where   fieldcode_expiredate >= current_date &
	ActiveRecord::Base.connection.select_all(strsql).each do |rec|
		$ftype[rec["pobject_code_fld"]] = rec["fieldcode_ftype"]
	end

	$materiallized = {"scrlvs"=>["r_screens","r_screenfields"],
		"pobjects"=>["r_pobjects","r_fieldcodes","r_blktbs","r_tblfields","r_screens","r_screenfields"],
		"fieldcodes"=>["r_fieldcodes","r_tblfields","r_screenfields"],
		"blktbs"=>["r_blktbs","r_tblfields","r_screenfields"],
		"tblfields"=>["r_tblfields","r_screenfields"],
		"screens"=>["r_screens","r_screenfields"],
		"screenfields"=>["r_screenfields"]}

	$tblfield_materiallized = ["r_pobjects","r_screenfields"]
end
