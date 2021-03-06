
# -*- coding: utf-8 -*-
#ScreenLib 
# 2099/12/31を修正する時は　2100/01/01の修正も
module ScreenLib
	extend self

	def proc_create_filteredstr  params,grid_columns_info
			where_info = (grid_columns_info["init_where_info"]||={})
			if (where_info["filtered"]||={}).size > 0
				 where_str =   "  where " +	 where_info["filtered"] + "    and "
			else
				 where_str = "  where "	 
			end	
			JSON.parse(params[:filtered]).each  do |ff|  ##xparams gridの生
				###ff = JSON.parse(strjson)
				next if ff["value"].nil?
				next if ff["value"] == ""
				next if ff["value"] =~ /'/
				next if ff["value"] == "null"
	      		case where_info[ff["id"]]  ### where_info[i["pobject_code_sfd"].to_sym] = i["screenfield_type"]	
				when nil
					next
		 		when /numeric/
					if ff["value"] =~ /^<=/  or ff["value"] =~ /^>=/ or ff["value"]=~ /^!=/
						next if ff["value"].size == 2 
						next if ff["value"][2..-1] !~ /^[0-9]+$|^\.[0-9]+$|^[0-9]+\.[0-9]+$/
						where_str << " #{ff["id"]} #{ff["value"][0..1]} #{ ff["value"][2..-1]}      AND "   
					else
						if ff["value"] =~ /^</   or  ff["value"] =~ /^>/	or  ff["value"] =~ /^=/
							next if ff["value"].size == 1 
							next if ff["value"][1..-1] !~ /^[0-9]+$|^\.[0-9]+$|^[0-9]+\.[0-9]+$/
							where_str << " #{ff["id"]}  #{ff["value"][0]}  #{ ff["value"][1..-1]}      AND "   
						else	
							next if ff["value"]  !~ /^[0-9]+$|^\.[0-9]+$|^[0-9]+\.[0-9]+$/
							where_str << " #{ff["id"]} = #{ff["value"]}     AND "
						end	
					end	
				  when /^date|^timestamp/
					ff["value"] = ff["value"].gsub("-","/")
		      		case  ff["value"].size
			         when 4
					 	where_str << "to_char(#{ff["id"]},'yyyy') = '#{ff["value"]}'      							 AND "
			         when 5
					 	where_str << "to_char(#{ff["id"]},'yyyy') #{ff["value"][0]} '#{ff["value"][1..-1]}'          AND "  if  ( ff["value"]=~ /^</   or ff["value"] =~ /^>/ )
					 when 6
					 	where_str << "to_char(#{ff["id"]},'yyyy')  #{ff["value"][0..1]} '#{ff["value"][2..-1]}'      AND "  if   (ff["value"] =~ /^<=/  or ff["value"] =~ /^>=/ )
			         when 7
					 	where_str << "to_char(#{ff["id"]},'yyyy/mm') = '#{ff["value"]}'                              AND "  if Date.valid_date?(ff["value"].split("/")[0].to_i,ff["value"].split("/")[1].to_i,01)
			         when 8
					 	where_str << "to_char(#{ff["id"]},'yyyy/mm') #{ff["value"][0]} '#{ff["value"][1..-1]}'       AND "  if Date.valid_date?(ff["value"][1..-1].split("/")[0].to_i,ff["value"].split("/")[1].to_i,01)  and ( ff["value"] =~ /^</   or  ff["value"] =~ /^>/ )
                	 when 9
					 	where_str << "to_char(#{ff["id"]},'yyyy/mm')  #{ff["value"][0..1]} '#{ff["value"][2..-1]}'   AND "  if Date.valid_date?(ff["value"][1..-1].split("/")[0].to_i,ff["value"].split("/")[1].to_i,01)   and (ff["value"] =~ /^<=/  or ff["value"]=~ /^>=/ )
			         when 10
					 	where_str << "to_char(#{ff["id"]},'yyyy/mm/dd') = '#{ff["value"]}'                           AND "  if Date.valid_date?(ff["value"].split("/")[0].to_i,ff["value"].split("/")[1].to_i,ff["value"].split("/")[2].to_i)
			         when 11
					 	where_str << "to_char(#{ff["id"]},'yyyy/mm/dd') #{ff["value"][0]} '#{ff["value"][1..-1]}'   AND "  if Date.valid_date?(ff["value"][1..-1].split("/")[0].to_i,ff["value"].split("/")[1].to_i,ff["value"].split("/")[2].to_i)  and ( ff["value"] =~ /^</   or  ff["value"] =~ /^>/ )
                	 when 12
					 	where_str << "to_char(#{ff["id"]},'yyyy/mm/dd')  #{ff["value"][0..1]} '#{ff["value"][2..-1]}' AND "  if Date.valid_date?(ff["value"][2..-1].split("/")[0].to_i,ff["value"].split("/")[1].to_i,ff["value"].split("/")[2].to_i)   and (ff["value"] =~ /^<=/  or ff["value"]=~ /^>=/ )
			         when 16
			            if Date.valid_date?(ff["value"].split("/")[0].to_i,ff["value"].split("/")[1].to_i,ff["value"].split("/")[2][0..1].to_i)
					 							hh = ff["value"].split(" ")[1][0..1]
					 							mi = ff["value"].split(" ")[1][3..4]
					 							delm = ff["value"].split(" ")[1][2.2]
					 							if  Array(0..24).index(hh.to_i) and Array(0..60).index(mi.to_i) and delm ==":"
					 								where_str << " to_char( #{ff["id"]},'yyyy/mm/dd hh24:mi') = '#{ff["value"]}'       AND "
					 							end
					 	end
			        when 17
						if Date.valid_date?(ff["value"][1..-1].split("/")[0].to_i,ff["value"].split("/")[1].to_i,ff["value"].split("/")[2][0..1].to_i)  and ( ff["value"] =~ /^</   or ff["value"] =~ /^>/ or  ff["value"] =~ /^=/ )
										hh = ff["value"].split(" ")[1][0..1]
										mi = ff["value"].split(" ")[1][3..4]
										delm = ff["value"].split(" ")[1][2.2]
										if  Array(0..24).index(hh.to_i) and Array(0..60).index(mi.to_i) and delm ==":"
											where_str << " to_char( #{ff["id"]},'yyyy/mm/dd hh24:mi') #{ff["id"][0]} '#{ff["id"][1..-1]}'      AND "
										end
									end
                	when 18
			                if Date.valid_date?(j[2..-1].split("/")[0].to_i,ff["value"].split("/")[1].to_i,ff["value"].split("/")[2][0..1].to_i)   and (ff["value"]=~ /^<=/  or ff["value"]=~ /^>=/ )
												hh = ff["value"].split(" ")[1][0..1]
												mi = ff["value"].split(" ")[1][3..4]
												delm = ff["value"].split(" ")[1][2.2]
												if  Array(0..24).index(hh.to_i) and Array(0..60).index(mi.to_i) and delm ==":"
													where_str << " to_char( #{ff["id"]},'yyyy/mm/dd hh24:mi')  #{ff["id"][0..1]} '#{ff["id"][2..-1]}'      AND "
												end
											end
						else
							next						
                	end ## ff["value"].size
				when /char|text|select/
					if  (ff["value"] =~ /^%/ or ff["value"] =~ /%$/ ) then 
						where_str << " #{ff["id"]} like '#{ff["value"]}'     AND " if  ff["value"] != ""
					elsif ff["value"] =~ /^<=/  or ff["value"] =~ /^>=/ then 
						where_str << " #{ff["id"]} #{ff["id"][0..1]} '#{ff["id"][2..-1]}'     AND " if  ff["value"] != ""
					elsif 	ff["value"] =~ /^</   or  ff["value"] =~ /^>/
						where_str << " #{ff["id"]}   #{ff["value"][0]}  '#{ff["value"][1..-1]}'         AND "  if  ff["value"] != ""
					elsif 	ff["value"] =~ /^!=/   
						where_str << " #{ff["id"]}   #{ff["value"][0..1]}  '#{ff["value"][2..-1]}'         AND "  if  ff["value"] != ""
					else
						where_str << " #{ff["id"]} = '#{ff["value"]}'         AND "
					end
	      		##when "select"
				##	where_str << " #{ff["id"]} = '#{ff["value"]}'         AND "
        		end   ##show_data[:alltypes][i]
        		tmpwhere = " #{ff["id"]} #{ff["value"]}    AND " if  ff["value"] =~/is\s*null/ or ff["value"]=~/is\s*not\s*null/
	      		where_str << (tmpwhere||="")
			end ### command_c.each  do |i,j|###
		params[:where_str] = 	where_str[0..-7]
		return params
	end	

	def proc_search_blk params,grid_columns_info
		screenCode = params[:screenCode]
		where_str = params[:where_str]
		
		strsorting = ""
			if params[:sortBy]  and   params[:sortBy] != "" ###: {id: "itm_name", desc: false}
				sortBy = JSON.parse(params[:sortBy])
				sortBy.each do |sortKey|
					strsorting = " order by " if strsorting == ""
					strsorting << %Q% #{sortKey["id"]} #{if sortKey["desc"]  == false then " asc " else "desc" end} ,%
				end	
				if strsorting == ""
					strsorting = " order by id desc "
				else
					strsorting << " id desc "
				end
			else
				strsorting = "  order by id desc "
				params[:sortBy] = "[]"
			end
			strsql = "select #{grid_columns_info["select_fields"]} 
						from (SELECT ROW_NUMBER() OVER (#{strsorting}) ,#{grid_columns_info["select_fields"]}
													 FROM #{screenCode} #{if where_str == '' then '' else where_str end } ) x
														where ROW_NUMBER > #{(params[:pageIndex].to_f)*params[:pageSize] } 
														and ROW_NUMBER <= #{(params[:pageIndex].to_f + 1)*params[:pageSize] } 
																  "
			pagedata = ActiveRecord::Base.connection.select_all(strsql)
			if where_str =~ /where/ 
				strsql = "SELECT count(*) FROM #{screenCode} #{where_str}"
			else
				strsql = "SELECT count(*) FROM #{screenCode.split("_")[1]} "
			end  ###fillterがあるので、table名は抽出条件に合わず使用できない。
			totalCount = ActiveRecord::Base.connection.select_value(strsql)
			params[:pageCount] = (totalCount.to_f/params[:pageSize].to_f).ceil
			params[:totalCount] = totalCount.to_f
		return pagedata 
	end	

	def add_empty_data params,grid_columns_info
		num = params[:pageSize].to_f
		columns_info = grid_columns_info["columns_info"]
		pagedata = []
		until num <= 0 do
			temp ={}
			columns_info.each do |cell|
				temp[cell[:accessor]] = ""
				next if cell[:accessor] == "id" 
				next if cell[:accessor] =~ /_id/
				if cell[:className] =~ /Editable/
					if cell[:className] =~ /Numeric/
						temp[cell[:accessor]] = "0"
					end
					if cell[:className] =~ /^Editable/
						case cell[:accessor]
						when /_expiredate/
							temp[cell[:accessor]] = "2099-12-31"
						when /_isudate|_rcptdate|_cmpldate/
							temp[cell[:accessor]] = Time.now.strftime("%Y/%m/%d")
						when /pobject_objecttype_tbl/
							temp[cell[:accessor]] = "tbl"
						when /opeitm_processseq|opeitm_priority/	
							temp[cell[:accessor]] = "999"
						when /person_code_chrg/	
							temp[cell[:accessor]] = params[:person_code_chrg]
						when /prjno_code/	
							temp[cell[:accessor]] = "0"
						end
						case params[:screenCode]
						when "r_mkords"
							case cell[:accessor]
								when /loca_code_|itm_code_/	
									temp[cell[:accessor]] = "dummy"
								when /mkord_starttime_|mkord_duedate_/
									temp[cell[:accessor]] = "2099/12/31"  
							end
						end
					end
				end
			end	
			pagedata << temp
			num = num - 1
		end
		params[:pageCount] = 1
		return pagedata		
	end	   ## proc_strwhere

  	def  proc_pdfwhere pdfscript,command_c
	    reports_id = pdfscript[:id]
	    viewname = command_c[:sio_viewname]
        tmpwhere = proc_strwhere command_c
        case  params[:initprnt]
            when  "1"  then
	            tmpwhere <<  if tmpwhere.size > 1 then " and " else " where " end
	            tmpwhere << "   not exists (select 1 from HisOfRprts x
                                   where lower(tblname) = '#{viewname}' and #{viewname.split('_')[1].chop}_id = recordid
				                and reports_id = #{reports_id}) "
		end
        case  params[:afterprnt]
            when  "1"  then
	            tmpwhere <<  if tmpwhere.size > 1 then " and " else " where " end
	            tmpwhere << " exists (select 1 from  (select max(updated_at) updated_at ,recordid
     							       from HisOfRprts x where reports_id = #{reports_id}
     								   group by reports_id,recordid )
								   where id = recordid and  #{viewname.split("_")[1].chop}_updated_at > updated_at )"
		end
        if params[:whoupdate] == '1' then
	        	tmpwhere <<  if tmpwhere.size > 1 then " and " else " where " end
	        	tmpwhere << " person_code_upd = '#{@sio_user_code}'"
				##tmpwhere <<  ActiveRecord::Base.connection.select_value("select code from persons where email = '#{current_user[:email]}'")
				##tmpwhere << "'"
        end
        if pdfscript[:pobject_code_rep] =~ /order_list/ then
	        	tmpwhere <<  if tmpwhere.size > 1 then " and " else " where " end
	        	tmpwhere << "  #{pdfscript[:pobject_code_view].split('_')[1].chop}_confirm  in('1','5')  "   ##order_listの時は確定又は確認済しか印刷しない
        end
        	##if params[:
        return tmpwhere
    end

  	def  sub_getfield
      		@show_data[:allfields].join(",").to_s
  	end   ##  sub_getfield

 	def sub_set_chil_tbl_info next_screen_data
      strwhere = "select ctlb_id from CTL#{next_screen_data[:sio_org_tblname]} where ptblid = #{next_screen_data[:sio_org_tblid]} and "
      strwhere << "ctblname = '#{next_screen_data[:sio_viewname].split("_")[1]}'  "
      ctbl_id = ActiveRecord::Base.connection.select_value(strwhere)
      if ctbl_id
	  return ctbl_id
       else
	  ##logger.debug " LINE #{__LINE__}  ptblname CTL#{next_screen_data[:sio_org_tblname]} ; strwhere = #{strwhere} "
	  raise "error"
      end
    end

  	def sub_get_sects_id_fm_locas_id  locas_id
	    sect_id = ActiveRecord::Base.connection.select_value("select id from sects where locas_id_sect = #{locas_id||=0} ")
		if sect_id.nil?
	       sect_id = ActiveRecord::Base.connection.select_value("select id from r_sects where loca_code_sect =  'dummy'")
		   sect_id ||= 0
	    end
	    return sect_id
	end

  	def sub_get_locas_id_fm_sects_id  sects_id
	    locas_id = ActiveRecord::Base.connection.select_value("select locas_id_sect from sects where id = #{sects_id} ")
		if locas_id.nil?
	       p "err logic err?"
		   raise
	    end
	    return locas_id
	end

    def undefined
    	nil
    end

	def proc_init_from_screen email,screenCode  ### current_user = current_api_user
		##@sio_user_code = ActiveRecord::Base.connection.select_value("select id from persons where email = '#{current_user[:email]}'")
		@sio_user_code = ActiveRecord::Base.connection.select_value("select id from persons where email = '#{email}'")
		command_c = {}
		strsql = "select pobject_code_view from r_screens where pobject_code_scr = '#{screenCode}' and screen_expiredate > current_date"
		command_c[:sio_viewname] =  ActiveRecord::Base.connection.select_value(strsql)
		command_c[:sio_code] =  screenCode
		command_c[:sio_message_contents] = nil
		command_c[:sio_recordcount] = 1
		command_c[:sio_result_f] =   "0"  
		return command_c
	end
	
	def proc_create_grid_editable_columns_info email,params,grid_columns_info
		req = params[:req]
		screenCode = params[:screenCode]
		grid_columns_info = Rails.cache.fetch('screenfield'+RorBlkctl.proc_grp_code(email)+screenCode) do
				###  ダブルコーティション　「"」は使用できない。 
			sqlstr = "select * from  func_get_screenfield_grpname('#{email}','#{screenCode}')"
			screenwidth = 0
			select_fields = ""
			gridmessages_fields = ""  ### error messages
			init_where_info = {}
			dropdownlist = {}
			sort_info = {}
			nameToCode = {}
			columns_info = []
			hiddenColumns = []
			if (req=='inlineedit7'|| req=="inlineadd7" )
				columns_info << {:Header=>"confirm",
									:accessor=>"confirm",
									:id=>"",
									:className=>"checkbox",
									:width=>50
									}
				columns_info << {:Header=>"confirm_gridmessage",
									:accessor=>"confirm_gridmessage",
									:id=>"",
									:className=>"gridmessage",
									}
				hiddenColumns << "confirm_gridmessage"
			end		
			ActiveRecord::Base.connection.select_all(sqlstr).each_with_index do |i,cnt|			
					select_fields = 	select_fields + 	i["pobject_code_sfd"] + ','
					if 	nameToCode[i["screenfield_name"]].nil?   ###nameToCode excelから取り込むときの表示文字からテーブル項目名への変換テーブル
						nameToCode[i["screenfield_name"]] = i["pobject_code_sfd"]
					else
						if i["pobject_code_sfd"].split("_")[0] == screenCode.split("_")[1].chop
							nameToCode[i["screenfield_name"]] = i["pobject_code_sfd"]  ###nameがテーブル項目しか登録されてない。
						end
					end
					grid_columns_info["nameToCode"] = nameToCode
					columns_info << {:Header=>"#{i["screenfield_name"]}",
									:id=>"#{i["screenfield_id"]}",
									:accessor=>"#{i["pobject_code_sfd"]}",
									:filter=>case i["screenfield_type"]
												when "select" 
													"includes"
												when "check"
													"checkbox"
												else 
													"text"
												end	,
									:canFilter => if i["screenfield_type"] =~ /check/ then false else true end,
									###widthが120以下だと右の境界線が消える。	
									:width => if i["screenfield_width"].to_i < 80 then 80 else  i["screenfield_width"].to_i end,
									##:style=>%Q%{"textAlign":#{if i["screenfield_type"] == "numeric" then "right" else "left" end}%, 
									##:style=>{:textAlign=>if i["screenfield_type"] == "numeric" then "right" else "left" end}, 
									:className=>if  (req==="inlineedit7" or req==="inlineadd7") and 
													(i["screenfield_editable"] === "1" or i["screenfield_editable"] === "2" or i["screenfield_editable"] === "3") 
														if i["screenfield_indisp"] === "1"  ###必須はyupでも
															case i["screenfield_type"] 
															when "select"
																	"SelectEditableRequire"
															when "check"
																	"CheckEditableRequire"
															when "numeric"
																	"EditableRequire Numeric "
															else
																	"EditableRequire"
															end
														else
															case i["screenfield_type"] 
															when "select"
																	"SelectEditable"
															when "check"
																	"CheckEditable"
															when "numeric"
																	"Editable Numeric "
															else
																	"Editable"
															end
														end
												else	
														case i["screenfield_type"]
															when "select"
																"SelectNonEditable"
															when "check"
																"CheckNonEditable"
															when "numeric"
																"NonEditable Numeric "
															else
																"NonEditable"
														end
												end	
									}
					if ((req==="inlineedit7" or req==="inlineadd7") and i["screenfield_editable"] === "1") or
						(req==="inlineedit7"  and i["screenfield_editable"] === "2") or
						( req==="inlineadd7" and i["screenfield_editable"] === "3") 
						columns_info << {:Header=>"#{i["screenfield_name"]}_gridmessage",
										:accessor=>"#{i["pobject_code_sfd"]}_gridmessage",
										:id=>"#{i["pobject_code_sfd"]}_gridmessage",
										:className=>"gridmessages"
									}
						gridmessages_fields << %Q% '' #{i["pobject_code_sfd"]}_gridmessage,%	
						hiddenColumns << %Q%#{i["pobject_code_sfd"]}_gridmessage%	
					end																
					init_where_info[i["pobject_code_sfd"]] = i["screenfield_type"]	
					if cnt == 0
								init_where_info["filtered"] = i["screen_strwhere"]
								grid_columns_info[:pageSizeList] = []
								i["screen_rowlist"].split(",").each do |list|
									grid_columns_info[:pageSizeList]  <<  list.to_i
								end
								if i["screen_strorder"] 
									sort_info[:default] = i["screen_strorder"]
								end	
				 	end
					if  i["screenfield_edoptvalue"]
						dropdownlist[i["pobject_code_sfd"]] = i["screenfield_edoptvalue"]
					end	
					if   i["screenfield_hideflg"] == "0" 
						screenwidth = screenwidth +  i["screenfield_width"].to_i
					else
						hiddenColumns << i["pobject_code_sfd"]
					end
				##end
			end
			grid_columns_info["columns_info"] = columns_info
			grid_columns_info["hiddenColumns"] = hiddenColumns
			grid_columns_info["yup"] = {}
			grid_columns_info["yup"]["yupfetchcode"] = YupSchema.create_yupfetchcode   screenCode
			grid_columns_info["yup"]["yupcheckcode"] = YupSchema.create_yupcheckcode   screenCode

			dropdownlist.each do |key,val|
				tmpval="["
				val.split(",").each do  |drop|
					tmpval << %Q%{"value":"#{drop.split(":")[0]}","label":"#{drop.split(":")[1]}"},%
				end
				dropdownlist[key] = tmpval.chop + "]"
			end	
			grid_columns_info["dropdownlist"] = dropdownlist
			if sort_info[:default]
				ary_select_fields = select_fields.split(',')
				sort_info = ControlFields.proc_detail_check_strorder sort_info,ary_select_fields
			end	
			grid_columns_info["init_where_info"] = init_where_info
			grid_columns_info["sort_info"] = sort_info	
			grid_columns_info["screenwidth"] = screenwidth	
			if gridmessages_fields.size > 1
				select_fields << gridmessages_fields
			end
			grid_columns_info["select_fields"] = select_fields.chop
			return grid_columns_info 
		end
	end
	
	def proc_create_download_columns_info params,email
		screenCode = params[:screenCode]
		columns_info = "["
		columns_color = {}
		select_fields = ""	
		download_columns_info = Rails.cache.fetch('download'+RorBlkctl.proc_grp_code(email)+screenCode) do
				###  ダブルコーティション　「"」は使用できない。 
				sqlstr = "select * from  func_get_screenfield_grpname('#{email}','#{screenCode}')"
				ActiveRecord::Base.connection.select_all(sqlstr).each_with_index do |i,cnt|
					if i["screenfield_hideflg"] == "0"
						case  i["screenfield_type"] 
							when  'numeric'
							when 'date'
							when 'timestamp'
							 ##renderer
						end	
						if i["screenfield_indisp"] == "1"
							color = "00bfff"  ##rgb(125, 177, 245)
						else
							if i["screenfield_editable"] == "1"	
								color = "87ceeb"  ## rgb(200, 220, 245);
							else
								color = "ffffff"
							end
						end			##value: "Blue",  style: {fill: {patternType: "solid", fgColor: {rgb: "FF0000FF"}}}
						columns_info << %Q%{"title":"#{i["screenfield_name"]}"},%
						columns_color[i["pobject_code_sfd"]] = color							
						select_fields = 	select_fields + 	i["pobject_code_sfd"] + ','
					end	
				end
				columns_info = columns_info.chop  + "]"
				download_columns_info = {"columns_info"=>columns_info,
									  	"select_fields"=>select_fields.chop,	
										"columns_color" =>	columns_color}
		end
		return download_columns_info
	end
	
	def proc_download_data_blk params,download_columns_info 
		screenCode = params[:screenCode]
		strsql = "select #{ download_columns_info["select_fields"]} from  #{screenCode}
							 #{if params[:where_str] == '' then '' else params[:where_str]   end }  limit 10000	  "
		recs = ActiveRecord::Base.connection.select_all(strsql)
		cnt = 0
		pagedata = "[["
		recs.each do |rec|
					rec.each do |key,val|  ## nl 改行は使用できない。
						pagedata << %Q%{"value":"#{if val then val.gsub(/"/,"'").gsub(/\n/," ").gsub(/\x09/," ") end}",
										"style":{"fill":{"patternType": "solid", 
										"fgColor": {"rgb": "#{download_columns_info["columns_color"][key]}"}}}}\n,%
					end
					pagedata = pagedata.chop +  "],["
					cnt += 1	
				end	
		params[:totalCount] = recs.count
		if params[:totalCount] > 0
			pagedata = pagedata[0..-3] + "]"
		else
			pagedata = "[]"
		end	
		return  pagedata
	end	

	def proc_create_upload_editable_columns_info screen_code,email,req
		grid_columns_info = Rails.cache.fetch('screenfield'+RorBlkctl.proc_grp_code(email)+screen_code) do
				###  ダブルコーティション　「"」は使用できない。 
			sqlstr = "select * from  func_get_screenfield_grpname('#{email}','#{screen_code}')"
			columns_info = []
			page_info = {}
			where_info = {}
			select_fields = ""
			gridmessages_fields = ""  ### error messages
			dropdownlist = {}
			sort_info = {}
			screenwidth = 0
			nameToCode = {}
			columns_info << {:Header=>"confirm",
									:accessor=>"confirm",
									:show=>true,
									:filtered=>false,
									:id=>"",
									:className=>"checkbox",
									:width=>50
									}
			columns_info << {:Header=>"confirm_gridmessage",
									:accessor=>"confirm_gridmessage",
									:show=>false,
									:filtered=>false,
									:id=>"",
									:className=>"gridmessage",
									}
			ActiveRecord::Base.connection.select_all(sqlstr).each_with_index do |i,cnt|				
					select_fields = 	select_fields + 	i["pobject_code_sfd"] + ','
					if 	nameToCode[i["screenfield_name"]].nil?   ###nameToCode excelから取り込むときの表示文字からテーブル項目名への変換テーブル
						nameToCode[i["screenfield_name"]] = i["pobject_code_sfd"]
					else
						if i["pobject_code_sfd"].split("_")[0] == screen_code.split("_")[1].chop
							nameToCode[i["screenfield_name"]] = i["pobject_code_sfd"]  ###nameがテーブル項目しか登録されてない。
						end
					end
					columns_info << {:Header=>"#{i["screenfield_name"]}",
									:accessor=>"#{i["pobject_code_sfd"]}",
									:show=>if  i["screenfield_hideflg"] == "0" then true else false end,
									:filtered=>true,
									:width => i["screenfield_width"].to_i,
									:id=>"#{i["screenfield_id"]}",
									##:style=>%Q%{"textAlign":#{if i["screenfield_type"] == "numeric" then "right" else "left" end}%, 
									:style=>{:textAlign=>if i["screenfield_type"] == "numeric" then "right" else "left" end}, 
									:className=>if ((req==="editabletablereq" or req==="inlineaddreq") and i["screenfield_editable"] === "1") or
													(req==="editabletablereq"  and i["screenfield_editable"] === "2") or
													( req==="inlineaddreq" and i["screenfield_editable"] === "3") 
													if  i["screenfield_type"] == "select" 
															"renderSelectEditable"
													else
														if i["screenfield_type"] == "check" 
																		"checkbox"
														else		
															if	(i["screenfield_indisp"] === "1" or i["screenfield_indisp"] === "2")
																			"renderEditableRequired"
															else
																			"renderEditable"
															end
														end
													end				  
												else	
													if  i["screenfield_type"] == "select" 
																	"renderSelectNonEditable"
													else	
														if i["screenfield_type"] == "check" 
																		""
												   		else
																		"renderNonEditable"
														end
													end
												end	
									}
					if ((req==="editabletablereq" or req==="inlineaddreq") and i["screenfield_editable"] === "1") or
						(req==="editabletablereq"  and i["screenfield_editable"] === "2") or
						( req==="inlineaddreq" and i["screenfield_editable"] === "3") 
						columns_info << {:Header=>"#{i["screenfield_name"]}_gridmessage",
										:accessor=>"#{i["pobject_code_sfd"]}_gridmessage",
										:show=>false,
										:filtered=>false,
										:width => 10,
										:id=>"#{i["screenfield_id"]}_gridmessage",
										:className=>"gridmessages"
									}
						gridmessages_fields << %Q% '' #{i["pobject_code_sfd"]}_gridmessage,%	
					end																
					where_info[i["pobject_code_sfd"].to_sym] = 	i["screenfield_type"]	
					if cnt == 0
								where_info[:filtered] = i["screen_strwhere"]
								###page_info[:sizePerPage] = i["screen_rows_per_page"].to_i
								page_info[:pageNo] = 1
								page_info[:sizePerPageList] = []
								i["screen_rowlist"].split(",").each do |list|
									page_info[:sizePerPageList]  <<  list.to_i
								end
								if i["screen_strorder"] 
									sort_info[:default] = i["screen_strorder"]
								end	
				 	end
					if  i["screenfield_edoptvalue"]
						dropdownlist[i["pobject_code_sfd"]] = i["screenfield_edoptvalue"]
					end	
					if   i["screenfield_hideflg"] == "0" 
						screenwidth = screenwidth +  i["screenfield_width"].to_i
					end
				##end
			end	
			if (req==="inlineaddreq")
				columns_info << {:Header=>"confirm",
									:accessor=>"confirm",
									:show=>true,
									:filtered=>false,
									:id=>"",
									:className=>"checkbox",
									:width=>50
									}
			end	
			yup={}
			yup[:yupfetchcode] = YupSchema.create_yupfetchcode screen_code   
			yup[:yupcheckcode]  = YupSchema.create_yupcheckcode screen_code   
			dropdownlist.each do |key,val|
				tmpval="["
				val.split(",").each do  |drop|
					tmpval << %Q%{"value":"#{drop.split(":")[0]}","label":"#{drop.split(":")[1]}"},%
				end
				dropdownlist[key] = tmpval.chop + "]"
			end	
			if sort_info[:default]
				ary_select_fields = select_fields.split(',')
				sort_info = ControlFields.proc_detail_check_strorder sort_info,ary_select_fields
			end	 
			page_info[:screenwidth] = screenwidth	
			if gridmessages_fields.size > 1
				select_fields << gridmessages_fields
			end
			grid_columns_info = [columns_info,page_info,where_info,select_fields.chop,yup,dropdownlist,sort_info,nameToCode]
		end
	end

end   ##module ScreenLib
