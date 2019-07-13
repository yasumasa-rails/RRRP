# -*- coding: utf-8 -*-
module TblField
extend self
	def blktbs params,current_api_user   ### r_blktbs又はr_tblfieldsから呼ばれることを想定
		@checktbls = {}   ### 対象となるテーブル群
		@add_id_to_tbl = {}   ### FIELD・・・s_idが追加された
		@delete_id_to_tbl = {}  # ### FIELD・・・s_idが削除された
		@messages =[]
		@modifysql = ""
		@current_api_user = current_api_user
		@params = params
		params["data"].each do |lineData|
			linedata = JSON.parse(lineData)
			if @checktbls[linedata["pobject_code_tbl"]] 
				next
			else
			    @checktbls[linedata["pobject_code_tbl"]]="done"
				strsql = "select * from r_tblfields where pobject_code_tbl = '#{linedata["pobject_code_tbl"]}' 
							and pobject_code_fld = 'id' and  tblfield_expiredate > current_date "
				rec = ActiveRecord::Base.connection.select_one(strsql)	
				if rec
					strsql = "select relname as TABLE_NAME from	pg_stat_user_tables where relname='#{linedata["pobject_code_tbl"]}' "
					chk = ActiveRecord::Base.connection.select_one(strsql)
					if chk
						delete_tblfields linedata["pobject_code_tbl"]
						modify_tblfield_and_view_screenfields linedata["pobject_code_tbl"]
					else
						create_tbl_view_screenfields linedata["pobject_code_tbl"]
					end
				else
					@messages << "table #{linedata["pobject_code_tbl"]} has not id "	
				end
			end	
		end	
		###テーブルの追加修正が完了したので、画面項目とviewの作成
		@checktbls.each do |tbl,flg|
			if flg == "done"
				@add_delete_recs = []
				add_default_screenfield tbl
			end	
		end	
		return 	@messages,@modifysql
	end
	def delete_tblfields pobject_code_tbl
		strsql = "select 	* from 	information_schema.columns 
					where 
					table_catalog='#{ActiveRecord::Base.configurations["development"]["database"]}' 
					and table_name='#{pobject_code_tbl}' "
		fields = ActiveRecord::Base.connection.select_all(strsql)	
		fields.each do |field|
			if ["id","expiredate","created_at","updated_at","update_ip"].include?(field["column_name"])
				next
			else	
				strsql = "select * from r_tblfields where pobject_code_tbl = '#{field["table_name"]}'
						 and pobject_code_fld = '#{field["column_name"]}'   and tblfield_expiredate > current_date "
				rec = ActiveRecord::Base.connection.select_one(strsql)	
				if rec
					next
				else 
					rslt = check_exists_fieldid field["table_name"],field["column_name"]
					if rslt
						@messages << rslt
						@checktbls[field["table_name"]]= "NG"
					else	 
						create_drop_field_sql field["table_name"],field["column_name"]
						if field["column_name"] =~ /s_id/
							if  @delete_id_to_tbl[field["table_name"]] 
								@delete_id_to_tbl[rec["pobject_code_tbl"]]  << rec["pobject_code_fld"] 
							else
								@delete_id_to_tbl[field["table_name"]] =[] 
								@delete_id_to_tbl[field["table_name"]]  << field["table_name"]
							end	
						end	
			  		end
				end	
			end		
		end			
	end	
	def modify_tblfield_and_view_screenfields pobject_code_tbl
		strsql = "select * from r_tblfields where pobject_code_tbl = '#{pobject_code_tbl}' and  tblfield_expiredate > current_date "
		recs = ActiveRecord::Base.connection.select_all(strsql)
		recs.each do |rec|
			strsql = "select 	* from 	information_schema.columns 
						where 
						table_catalog='#{ActiveRecord::Base.configurations["development"]["database"]}' 
						and table_name='#{pobject_code_tbl}'
						and column_name = '#{rec["pobject_code_fld"]}' "
			field = ActiveRecord::Base.connection.select_one(strsql)	
			if field
				modify_field rec,field
			else 
				create_add_field_sql rec　###該当テーブルの項目作成
			end		
			if rec["pobject_code_fld"] =~ /s_id/
				if  @add_id_to_tbl[rec["pobject_code_tbl"]] 
					@add_id_to_tbl[rec["pobject_code_tbl"]]  << rec["pobject_code_fld"] 
				else
					@add_id_to_tbl[rec["pobject_code_tbl"]] =[] 
					@add_id_to_tbl[rec["pobject_code_tbl"]]  << rec["pobject_code_fld"] 
				end	
			end		
		end	
	end	
	def modify_field rec,field
		if field["column_name"] == rec["pobject_code_fld"]
			if field["udt_name"] == rec["fieldcode_ftype"]
				case field["udt_name"] 
				when "varchar"
					if field["character_maximum_length"] > rec["fieldcode_fieldlength"].to_i
					   	rslt = check_exists_fieldid rec["pobject_code_tbl"],rec["pobject_code_fld"]
					  	if rslt
							@messages << rslt
							@checktbls[rec["pobject_code_tbl"]]= "NG"
					   	else	 
							create_modify_field_sql rec
						end
					else
						###修正なし
					end
				when "numeric"
						if  (field["numeric_precision"]||=22)  <= rec["fieldcode_dataprecision"].to_i  and 
							(field["numeric_scale"]||=0)  <= rec["fieldcode_datascale"].to_i 
							if  field["numeric_precision"] == rec["fieldcode_dataprecision"].to_i  and 
								field["numeric_scale"]  == rec["fieldcode_datascale"].to_i 
								###修正なし
							else
								create_modify_field_sql rec
							end		
						else
							rslt = check_exists_fieldid rec["pobject_code_tbl"],rec["pobject_code_fld"]
						   	if rslt
								@messages << rslt
								@checktbls[rec["pobject_code_tbl"]]= "NG"
							else	 
								create_modify_field_sql rec
							end
						end
				else	
					###修正なし
				end			
			else
				if field["udt_name"] =~ /timestamp/ and  rec["fieldcode_ftype"] =~ /timestamp/
					###何もしない。
				else
					rslt = check_exists_fieldid rec["pobject_code_tbl"],rec["pobject_code_fld"]
			    	if rslt
						@messages << rslt
						@checktbls[rec["pobject_code_tbl"]]= "NG"
					else		 
						create_drop_field_sql rec["pobject_code_tbl"], rec["pobject_code_fld"]
						create_add_field_sql  rec ###該当テーブルの項目作成	
						if rec["pobject_code_fld"] =~ /s_id/
							if  @add_id_to_tbl[rec["pobject_code_tbl"]] 
								@add_id_to_tbl[rec["pobject_code_tbl"]]  << rec["pobject_code_fld"] 
							else
								@add_id_to_tbl[rec["pobject_code_tbl"]] =[] 
								@add_id_to_tbl[rec["pobject_code_tbl"]]  << rec["pobject_code_fld"] 
							end	
						end	
					end
				end		
			end
		else
			p" err	modify_field 001"
			raise
		end	
	end 
	def check_exists_fieldid table_name,column_name
		strsql = "select id,#{column_name} from #{table_name} where #{column_name} is not null"
		rec = ActiveRecord::Base.connection.select_one(strsql)
		if rec
			rslt = " already used table:#{table_name},field:#{column_name},value:#{rec[column_name]} "
		else
			rslt = nil	
		end
		return rslt
	end		
	def create_drop_field_sql table_name,column_name
		@modifysql << "alter table #{ table_name} DROP COLUMN #{column_name} CASCADE;\n"
	end	
	def create_modify_field_sql rec
		case rec["fieldcode_ftype"]
		when /char/
			@modifysql << "alter table #{rec["pobject_code_tbl"]} ALTER COLUMN #{rec["pobject_code_fld"]}  TYPE #{rec["fieldcode_ftype"]}(#{rec["fieldcode_fieldlength"] });\n"
		when "numeric"
			@modifysql << "alter table  #{rec["pobject_code_tbl"]} ALTER COLUMN #{rec["pobject_code_fld"]}  TYPE #{rec["fieldcode_ftype"]}(#{rec["fieldcode_dataprecision"]},#{rec["fieldcode_datascale"]});\n"
        end
	end
	def create_add_field_sql rec  ###該当テーブルの項目作成
		case rec["fieldcode_ftype"]
		when /char/
			@modifysql << "alter table #{rec["pobject_code_tbl"]}  ADD COLUMN #{rec["pobject_code_fld"]} #{rec["fieldcode_ftype"]}(#{rec["fieldcode_fieldlength"] });\n"
		when "numeric"
			@modifysql << "alter table  #{rec["pobject_code_tbl"]}  ADD COLUMN #{rec["pobject_code_fld"]} #{rec["fieldcode_ftype"]}(#{rec["fieldcode_dataprecision"]},#{rec["fieldcode_datascale"]});\n"
		when /date|timestamp/
			@modifysql << "alter table #{rec["pobject_code_tbl"]}  ADD COLUMN #{rec["pobject_code_fld"]} #{rec["fieldcode_ftype"]};\n"
		end	
	end	
	def add_default_screenfield tbl
		screens_id  = chk_screen_and_add_screenfields("r_#{tbl}")
		if screens_id
			@add_id_to_tbl.each do |owntbl,othertblfieldids|
				othertblfieldids.each do |othertblfieldid|
					othertbl,delm = othertblfieldid.split("_id",2)
					delm ||=""
					add_other_viewfield othertbl,owntbl,delm 
				end
			end	
			@delete_id_to_tbl.each do  |owntbl,othertblfieldids|
				othertblfieldids.each do |othertblfieldids|
					othertbl,delm = othertblfieldids.split("_id",2)
					delm ||=""
					delete_other_viewfield tbl  othertbl,owntbl,delm  ###テーブルから ・・・s_idが削除されたとき
				end	
			end	
			@add_delete_recs.each do |rec|
				add_otherview_screenfield_record screens_id,rec,tbl
			end	
			create_viewfield "r_#{tbl}"
		end	
	end	
	def add_other_viewfield othertbl,owntbl,delm 
		strsql = "select 	column_name from 	information_schema.columns 
					where 	table_catalog='#{ActiveRecord::Base.configurations["development"]["database"]}'  and 
		 			table_name='r_screenfields'  and column_name like 'screenfield%'
					and column_name not  in('screenfield_updated_at','screenfield_created_at','screenfield_update_ip',
					'screenfield_id','screenfield_person_id_upd','screenfield_editable') "
		
		fields = ActiveRecord::Base.connection.select_values(strsql)	###screenfieldsの項目を調べる。項目が増えた時の対応
		screencode = if othertbl == "persons" and delm == "_upd"
						 "upd_persons"
					else
						 "r_#{othertbl}"
					end	 	 
		strsql = "select  #{fields.join(",")},null id,null screenfield_id  ,pobject_code_sfd,
					case when pobject_code_sfd = '#{othertbl.chop}_code' 
						then  '1' else '0' end   screenfield_editable
						from r_screenfields 
						where pobject_code_scr = '#{screencode}' and  screenfield_expiredate > current_date
						and screenfield_selection = 1
						and pobject_code_sfd not in('id',
						'#{othertbl.chop}_id','#{othertbl.chop}_created_at','#{othertbl.chop}_update_ip',
						'#{othertbl.chop}_updated_at','#{othertbl.chop}_expiredate','#{othertbl.chop}_person_id_upd',
						'person_code_upd','person_name_upd','person_id_upd') "
		recs = ActiveRecord::Base.connection.select_all(strsql)		
		recs.each do |rec|       ### "0" screenfield_editable 入力不可
			strsql = "select  * from r_screenfields where pobject_code_scr  = 'r_#{owntbl}'
						and  pobject_code_sfd = '#{rec["pobject_code_sfd"]+delm}' and  screenfield_expiredate > current_date"
			chk = ActiveRecord::Base.connection.select_one(strsql)
			if chk
				###何もしない
			else
				if rec["pobject_code_sfd"] != "id"					
					pobjects_id_sfd = chk_pobject_sfd_and_add rec["pobject_code_sfd"]+delm
					rec["screenfield_pobject_id_sfd"] = pobjects_id_sfd
					@add_delete_recs << rec
				end	
			end		
		end	
	end	
	def delete_other_viewfield  othertbl,owntbl,delm   ###テーブルから ・・・s_idが削除されたとき
		screencode = if othertbl == "persons" and delm == "_upd"
						 "upd_persons"
					else
						 "r_#{othertbl}"
					end	 	 
		strsql = "select id,screenfield_id,  pobject_code_sfd 
						from r_screenfields 
						where pobject_code_scr = '#{screencode}' 
						and pobject_code_sfd not in('id',
						'#{othertbl.chop}_id','#{othertbl.chop}_created_at','#{othertbl.chop}_update_ip',
						'#{othertbl.chop}_updated_at','#{othertbl.chop}_expiredate','#{othertbl.chop}_person_id_upd',
						'person_code_upd','person_name_upd','person_id_upd') "
		recs = ActiveRecord::Base.connection.select_all(strsql)		
		recs.each do |rec|       #
			strsql = "select  * from r_screenfields where pobject_code_scr  = '#{owntbl}'
						and  pobject_code_sfd = '#{rec["pobject_code_sfd"]+delm}' and screenfield_expiredate > current_date "
			chk = ActiveRecord::Base.connection.select_one(strsql)
			if chk
				rec["screenfield_expiredate"] = (Time.now - 1.day).strftime("%Y/%m/%d")
				@add_delete_recs << rec
			else
				###何もしない
			end		
		end	
	end	
	def create_tbl_view_screenfields pobject_code_tbl
		###未作成
	end	
	def chk_screen_and_add_screenfields screen  ###該当screenは登録済
		tbl = screen.split("_",2)[1]
		strsql = "select id from r_screens where pobject_code_scr ='#{screen}' "
		screens_id = ActiveRecord::Base.connection.select_value(strsql)
		if screens_id  ###テーブルからviewの項目がscreenfieldsに登録れさてぃるがチェック、されてなければ登録する。
			strsql = "select * from r_tblfields where pobject_code_tbl ='#{tbl}'and 
					tblfield_expiredate > current_date   "
			fields = ActiveRecord::Base.connection.select_all(strsql)
			fields.each do |field|
				case field["pobject_code_fld"]
					when "id"
						screenfield = "id"
					when /s_id/
						screenfield = tbl.chop + "_" + field["pobject_code_fld"].sub("s_id","_id")
					else
						screenfield = tbl.chop +  "_" +  field["pobject_code_fld"]
				end	
				pobjects_id_sfd = chk_pobject_sfd_and_add screenfield
				strsql = "select 1 from screenfields where screens_id = #{screens_id} and pobjects_id_sfd = #{pobjects_id_sfd} "
				rec = ActiveRecord::Base.connection.select_one(strsql)
				if rec.nil?
					add_screenfield_record screens_id,pobjects_id_sfd,field
				end
			end
		else 
			### テーブルscreendsに登録されてない
			@messages << " add screen  to　screens   --> '#{screen}'"
			strsql = "select * from pobjects where code ='#{screen}' and objecttype = 'screen'"
			pobject_id_scr = ActiveRecord::Base.connection.select_one(strsql)
			if pobject_id_scr
				###ok
			else　
				@messages << " add screen code to pobjects --> '#{screen}'"
			end	
		end
		return 	screens_id
	end	
	def  chk_pobject_sfd_and_add screenfield
		strsql = "select pobject_id from r_pobjects where pobject_code = '#{screenfield}' and pobject_objecttype = 'view_field'
					and pobject_expiredate > current_date  "
		pobjects_id_sfd = ActiveRecord::Base.connection.select_value(strsql)
		if pobjects_id_sfd
		else
			pobjects_id_sfd = add_pobject_record screenfield
		end		
		return pobjects_id_sfd
	end	
	def  add_pobject_record screenfield
		command_r =  RorBlkctl.init_from_screen @current_api_user,@params
		command_r[:sio_viewname] =  "r_pobjects"
		command_r[:sio_message_contents] = nil
		command_r[:sio_recordcount] = 1
		command_r[:sio_result_f] =   "0"  
		command_r["id"] == ""
		command_r[:sio_classname] = "_add_pobject_screenfield"
		command_r["pobject_id"] = ""
		command_r["pobject_remark"] = "auto add pobject screenfield #{screenfield}"
		command_r["pobject_code"] = screenfield
		command_r["pobject_objecttype"] = "view_field"
		command_r["pobject_expiredate"] = '2099/12/31'
		command_r = RorBlkctl.proc_update_table(command_r,1)
		if @sio_result_f ==   "9"
		 	@messages <<  "error  add_pobject_record #{screenfield}"
		end  
		return command_r["id"]
	end	

	def add_screenfield_record screens_id,pobjects_id_sfd,field
		command_r =  RorBlkctl.init_from_screen @current_api_user,@params
		command_r[:sio_viewname] =  "r_screenfields"
		command_r[:sio_message_contents] = nil
		command_r[:sio_recordcount] = 1
		command_r[:sio_result_f] =   "0"  
		command_r["id"] = ""
		command_r[:sio_classname] = "_add_screenfield_record"
		command_r["screenfield_id"] = ""
		command_r["screenfield_remark"] = "auto add to screenfield ===> #{field["pobject_code_tbl"].chop}_#{field["pobject_code_fld"]}"
		command_r["screenfield_expiredate"] = '2099/12/31'
		command_r["screenfield_screen_id"] = screens_id
		command_r["screenfield_selection"] = "1"
		command_r["screenfield_hideflg"] = if field["pobject_code_fld"] =~ /_id/ then "1" else "0" end
		command_r["screenfield_seqno"]= "0"
		command_r["screenfield_rowpos"]="0"
		command_r["screenfield_colpos"]="0"
		command_r["screenfield_width"]="100"
		command_r["screenfield_type"]= field["fieldcode_ftype"]
		command_r["screenfield_dataprecision"] = field["tblfield_dataprecision"]
		command_r["screenfield_datascale"] = field["tblfield_datascale"]
		command_r["screenfield_indisp"] = "0"
		command_r["screenfield_subindisp"] ="0"
		command_r["screenfield_editable"] ="1"  ###変更可
		command_r["screenfield_maxvalue"] ="0"
		command_r["screenfield_minvalue"] ="0"
		command_r["screenfield_edoptsize"] ="0"
		command_r["screenfield_edoptmaxlength"] ="0"
		command_r["screenfield_edoptrow"] ="0"
		command_r["screenfield_edoptcols"] ="0"
		command_r["screenfield_edoptvalue"] = "0"
		command_r["screenfield_pobject_id_sfd"] = pobjects_id_sfd
		command_r["screenfield_tblfield_id"] = field["id"]
		command_r["screenfield_paragraph"] =""
		command_r["screenfield_formatter"] =""
		command_r = RorBlkctl.proc_update_table(command_r,1)
		if @sio_result_f ==   "9"
		 	@messages <<  "error  add_screenfield_record #{field["pobject_code_tbl"].chop}_#{field["pobject_code_fld"]}"
		else  
		  @params[:addId] = command_r["id"]
		end  
	end	
	
	def add_otherview_screenfield_record screens_id,rec,tbl
		command_r =  RorBlkctl.init_from_screen @current_api_user,@params
		command_r[:sio_viewname] =  "r_screenfields"
		command_r[:sio_message_contents] = nil
		command_r[:sio_recordcount] = 1
		command_r[:sio_result_f] =   "0"  
		command_r["id"] = ""
		command_r[:sio_classname] = "_add_otherview_screenfield_record"
		command_r["screenfield_id"] = ""
		command_r["screenfield_remark"] = "auto add otherview  screenfield --->r_#{tbl} #{rec["pobject_code_sfd"]}"
		command_r["screenfield_expiredate"] = '2099/12/31'
		command_r["screenfield_screen_id"] = screens_id
		command_r["screenfield_selection"] = if rec["pobject_code_fld"] =~ /_id/ or rec["screenfield_selection"] == '0' then '0' else '1' end
		command_r["screenfield_hideflg"] = if rec["pobject_code_fld"] =~ /_id/ or rec["screenfield_hideflg"] != '0' then "1" else "0" end
		command_r["screenfield_seqno"]= "0"
		command_r["screenfield_rowpos"]="0"
		command_r["screenfield_colpos"]="0"
		command_r["screenfield_width"]=rec["screenfield_width"]
		command_r["screenfield_type"]=rec["screenfield_type"]
		command_r["screenfield_dataprecision"] =rec["screenfield_dataprecision"]
		command_r["screenfield_datascale"] = rec["screenfield_datascale"]
		command_r["screenfield_indisp"] = "0"
		command_r["screenfield_subindisp"] ="0"
		command_r["screenfield_editable"] ="0"  ###変更不可
		command_r["screenfield_maxvalue"] =rec["screenfield_maxvalue"]
		command_r["screenfield_minvalue"] =rec["screenfield_minvalue"]
		command_r["screenfield_edoptsize"] ="0"
		command_r["screenfield_edoptmaxlength"] ="0"
		command_r["screenfield_edoptrow"] ="0"
		command_r["screenfield_edoptcols"] ="0"
		command_r["screenfield_edoptvalue"] = "0"
		command_r["screenfield_pobject_id_sfd"] = rec["screenfield_pobject_id_sfd"]
		command_r["screenfield_tblfield_id"] = rec["screenfield_tblfield_id"]
		command_r["screenfield_paragraph"] =""
		command_r["screenfield_formatter"] =rec["screenfield_formatter"]
		command_r = RorBlkctl.proc_update_table(command_r,1)
		if @sio_result_f ==   "9"
		 	@messages <<  "error  add_screenfield_record: r_#{tbl} -->#{rec["pobject_code_sfd"]}"
		else  
		  @params[:addId] = command_r["id"]
		end  
	end	
	def create_viewfield view
		strsql = "select pobject_code_sfd from r_screenfields where pobject_code_view = '#{view}' and
					 screenfield_expiredate > current_date and screenfield_selection = 1 "
		selectfields = ActiveRecord::Base.connection.select_values(strsql)
		createviewscript = "create or replace view #{view} as select \n"
		tblchop = view.split("_")[1].chop
		otherview =[]
		selectfields.each do |field|
			if field.split("_")[0] == tblchop
				if field.split("_")[2] =~/id/  ## 自分のテーブル.chop_相手のテーブル.chop_id  + delm
					createviewscript << "\n#{tblchop}.#{field.split("_")[1]}s_id#{field.split("_id")[1]}   #{field},"
					otherview << ("#{field.split("_")[1]}"+  if field.split("_")[-1] == field.split("_")[2] then  "" else "_"+field.split("_")[-1] end )
				else	
					createviewscript << "\n#{tblchop}.#{field.split("_",2)[1]}  #{field},"
				end	
			else
				if field == "id"
					createviewscript << "\n#{tblchop}.id id,"
				else	
					tblchopdelm = field.split("_")[0]+ if field.split("_")[-1] == field.split("_")[1] then  "" else "_"+field.split("_")[-1] end 
					delm = if field.split("_")[-1] == field.split("_")[1] then  "" else "_"+field.split("_")[-1] end
					createviewscript << "\n  #{tblchopdelm}.#{field.sub(delm,'')}  #{field} ,"
				end	
			end	
		end	
		createviewscript = createviewscript.chop + "\n from #{tblchop}s   #{tblchop}," 
		createviewscript << "\n"
		otherview.each do |xview|
			createviewscript << ("  r_" + xview.split("_")[0] + "s  " + xview  + " ,")
		end 
		createviewscript = createviewscript.chop + "\n  where      "
		otherview.each do |xview|
			createviewscript << " #{tblchop}.#{xview.split("_")[0]}s_id#{if xview.split("_")[1] then "_"+xview.split("_")[1] else "" end} = #{xview}.id      and"
		end 
		@modifysql << createviewscript[0..-5]
		@messages << " --- create view script   #{view} "
	end	
	def sub_crt_tbl_view_screenxxxx  pobject_code_tbl,rec_id
			create_or_replace_view   rec_id,pobject_code_tbl,nil
			Rails.cache.clear(nil)
			prv_create_index_pk pobject_code_tbl
			create_screenfields "r_"+pobject_code_tbl
			proc_set_search_code_of_screen        "r_"+pobject_code_tbl
			chk_index  pobject_code_tbl,columns if columns
	end
	def proc_set_search_code_of_screen   pobject_code_scr
		### 以下　blkukysに変更して　全面コーディングし直した　2014/12/26
		strsql = "select * from r_screenfields where pobject_code_scr = '#{pobject_code_scr}' and  screenfield_selection = 1 "
		screenfields = ActiveRecord::Base.connection.select_all(strsql)
		screenfields.each do |key|
			tgtblchop = key["pobject_code_sfd"].split("_")[0].chop
			if key["pobject_code_sfd"] =~ /_code/ and key["screenfield_indisp"] == "1" and  tgtblchop != pobject_code_scr.split("_",2)[1]
				strsql = "select * from r_blkukys
				           where pobject_code_tbl = '#{tgtblchp}s'  and pobject_code_fld = '#{key["pobject_code_sfd"].split("_")[1]}'"
				ukygrp = ActiveRecord::Base.connection.select_one(strsql)
				dlm = ""
				if ukysgrp.nil?  ###_xxxを使用していた時
					strsql = "select * from r_blkukys
				           where pobject_code_tbl = '#{tgtblchop}s'  and pobject_code_fld = '#{tgtblchop}_code}'"
					ukygrp = ActiveRecord::Base.connection.select_one(strsql)
					dlm = key["pobject_code_sfd"].split("_code",2)[1]
				end
				strsql = "select * from r_blkukys
				           where pobject_code_tbl = '#{pobject_code_scr.split("_",2)[1]}'  and blkuky_grp = '#{ukygrp["blkuky_grp"]}'"
				ukys = ActiveRecord::Base.connection.select_one(strsql)
				ukys.each do|ukey|
					strsql = "select * from r_screenfields where pobject_code_scr = '#{pobject_code_scr}' and
					                                             pobject_code_sfd = '#{ukey["pobject_code_sfd"]+dlm}'"  ###dlm = "_xxxx"
					screenfield = ActiveRecord::Base.connection.select_one(strsql)
					if screenfield["screenfield_paragraph"].nil?
						updatestr = ""
						if   screenfield["screenfield_remark"] !~ /by proc_set_search_code_of_screen/
							updatestr << if screenfield["screenfield_remark"].size <  50  then %Q& remark = '#{screenfield["screenfield_remark"]} _ by proc_set_search_code_of_screen'  & else ""  end
						end
						updatestr << %Q&,paragraph = '#{pobject_code_scr + if dlm == "" then "" else ":" + dlm end}' &
						Screenfield.where(:id=>screenfield["id"]).update_all(updatestr)
					end
                end
			end
			if key["pobject_code_sfd"] =~ /_sno_/ and key["screenfield_indisp"] == "1" and key["pobject_code_sfd"].split("_")[0] == pobject_code_scr.split("_",2)[1].chop
				if screenfield[:screenfield_paragraph].nil?
					updatestr = %Q& paragraph = 'r_#{pobject_code_scr.split("_")[1][3..-1]}#{key["pobject_code_sfd"].split("_sno_")[1]}s'&  ## xxxords,xxxinsts  xxx は3桁
					Screenfield.where(:id=>key["id"]).update_all(updatestr)
				end
            end
		end
	end
	def prv_add_tbl_field tblname,allrecs
		mandatory_field =  prv_init
		@strsql0 = "\n create table #{tblname} ("
		tmpstrsql ={}
		allrecs.each do |rec|
			frec = ActiveRecord::Base.connection.select_one("select * from r_fieldcodes where id = #{rec["fieldcodes_id"]} and fieldcode_ftype not like 'vf%' ")  ### vfield は登録しない
			next if frec.nil?
			tmpstrsql[frec["pobject_code_fld"].to_sym]= frec["pobject_code_fld"] + " " + frec["fieldcode_ftype"] +
                case frec["fieldcode_ftype"]
                when /char/
                        "(#{frec["fieldcode_fieldlength"]}) ,"
                when "numeric"
                        %Q%(#{if frec["fieldcode_dataprecision"] == 0  or frec["fieldcode_dataprecision"].nil? then "38),\n"
																	else frec["fieldcode_dataprecision"].to_s + "," + (frec["fieldcode_datascale"]||0).to_s + " ) ,\n" end }%
								else
                             ","
                 end
			mandatory_field.delete( frec["pobject_code_fld"].to_sym)
    	end
		rec0 = allrecs[0]
		rec0["expiredate"]=Time.parse("2099/12/31")
		rec0["created_at"] = Time.now
		rec0["updated_at"] = Time.now
		mandatory_field.each do |key,value|
			tmpstrsql[value[0].to_sym] = value[1] +  value[2]
			rec0["id"] = proc_get_nextval("tblfields_seq")
			rec_id = ActiveRecord::Base.connection.select_value("select id from fieldcodes where pobjects_id_fld = (select id from pobjects where code = '#{value[1]}'
                                                   and objecttype = 'tbl_field' and expiredate  > current_date)")
			if rec_id
				rec0["fieldcodes_id"]  = rec_id
				##rec0[:seqno] = value[0]
				proc_tbl_add_arel("tblfields",rec0)
			end
		end
		tmpstrsql.sort.each do |key,value|
			@strsql0 << value
		end
		@strsql0 <<  " CONSTRAINT #{tblname}_id_pk PRIMARY KEY (id),"
		##  primkey key対応
		@strsql0 = @strsql0.chop + ")"
		ActiveRecord::Base.connection.execute @strsql0
	end
	def proc_drop_index tblname
		proc_blk_get_constrains(tblname,'U').each do |key|
			@tsqlstr = " ALTER TABLE #{tblname} drop CONSTRAINT #{key}"
			ActiveRecord::Base.connection.execute @tsqlstr
		end
	end
  	def prv_add_field tblname,frec
      case frec["fieldcode_ftype"]
           when "varchar2","char"
                @strsql0 << "alter table #{tblname} add #{frec["pobject_code_fld"]} #{frec["fieldcode_ftype"]}(#{frec["fieldcode_fieldlength"] });\n"
           when "numeric"
                if  frec["fieldcode_dataprecision"] then
                    @strsql0 << "alter table #{tblname} add #{frec["pobject_code_fld"]} #{frec["fieldcode_ftype"]}
                                                           (#{if frec["fieldcode_dataprecision"] == 0 then 38 else frec["fieldcode_dataprecision"] end },#{frec["fielcode_datascale"]||0});\n"
                  else
                    @strsql0 << "alter table #{tblname} add #{frec["pobject_code_fld"]} #{frec["fieldcode_ftype"]};\n"
                end
		   when "vf"
           else
               @strsql0 << "alter table #{tblname} add #{frec["pobject_code_fld"]} #{frec["fieldcode_ftype"]};\n"
       end
  	end

 	def create_or_replace_viewxxxx  tblid,tblname,screen_id
		strsql = "select * from r_tblfields where tblfield_blktb_id = #{tblid} and tblfield_expiredate >  current_date"
   		subfields = ActiveRecord::Base.connection.select_all(strsql)
		tmp_union_tbl = ActiveRecord::Base.connection.select_one("select * from blktbs  where id  = #{tblid} ")
		union_tbls =  if tmp_union_tbl["seltbls"] and tmp_union_tbl["seltbls"] != "undefined" then eval(tmp_union_tbl["seltbls"])  else [""] end ##tblname対応
			### tmp_union_tbl[:seltbls]はarrayであること。　　checkが必要
			selectstr = ""
			fromstr = ""
			wherestr = ""
			@sfd_code_id = {}
			union_tbls.each_with_index do |utbl,idx|   ###うまくセットできてない。　2016/4/24
        		selectstr <<  if idx == 0 then  " select " else "\n union \n select " end
       			wherestr << if utbl == "" then "\n where "  else  "\n where #{tblname.chop}.tblid = #{utbl.to_s.split("_")[1].chop}.id  and
		                                 #{tblname.chop}.tblname = '#{utbl.to_s}' and " end ##join条件
       			fromstr << "\n from " + tblname + " " + tblname.chop + " ,"   ## 最後のSはとる。
				fromstr << if utbl == "" then "" else  utbl.to_s + " " + utbl.to_s.split("_")[1].chop + " ," end
        		subfields.each do |rec|
        			js = rec["pobject_code_fld"]
         			if  js =~ /_id/
           				case  js
          				when /persons_id_upd/   ##person は特殊
              					join_rtbl = "upd_persons"
            			else
             					join_rtbl = "r_" + js.split(/_id/)[0]  ##JOINするテーブル名
           				end
           				rtblname =  js.sub(/s_id/,"")
          				fromstr << join_rtbl + "  " + rtblname + ','    ### from r_xxxxs xxxxx
           				wherestr << " #{rtblname}.id = "  ##相手側のテーブルのid
	         			wherestr << tblname.chop + "." + js  + " and "   ## 自分のテーブル内の相手がわを示すid
			    		delm = js.split("_")[-1]   ###idにdelm識別子を付けたとき
			    		if delm == tblname.chop and js !~ /_id/
				    		new_js = js.sub("_#{tblname.chop}","")    ###ヘッダーと同じものは除く
				    		selectstr << tblname.chop + "." +  js + " " + tblname.chop + "_" +  new_js.sub("s_id","_id") + " ,"
							@sfd_code_id[tblname.chop + "_" +  new_js.sub("s_id","_id")] = rec["id"]
			    		else
				    		selectstr << tblname.chop + "." +  js + " " + tblname.chop + "_" +  js.sub("s_id","_id") + " ,"
							@sfd_code_id[tblname.chop + "_" +  js.sub("s_id","_id")] = rec["id"]
			    		end
            			subtblcrt  join_rtbl,rtblname do |k|   ###相手側の項目セット
              				selectstr << k
          				end
					  else ##not _id
						if js == 'id'
						 	selectstr << tblname.chop + "." +  js  + " id,"
						 	@sfd_code_id["id"] = rec["id"]
					 	end
			   			case rec["tblfield_viewflmk"]
				 		when nil
							strsql = "select id from r_screens where pobject_code_scr = '#{join_rtbl}'    and  screen_expiredate > current_date "
							screen_id = ActiveRecord::Base.connection.select_value(strsql)
							if screen_id and join_rtbl != "upd_persons"
								strsql = %Q%select pobject_code_sfd from r_screenfields where screenfield_selection = 1
																												and screenfield_screen_id = #{screen_id}
																												and pobject_code_sfd = '#{tblname.chop + "_" +  js }' %
								fld = ActiveRecord::Base.connection.select_value(strsql)
								if fld
									selectstr << tblname.chop + "." +  js + " " + fld + " ,"
								else
									next
								end
							else
			      				selectstr << tblname.chop + "." +  js + " " + tblname.chop + "_" +  js + " ,"
							end
							@sfd_code_id[tblname.chop + "_" +  js] = rec["id"]
				 		when /^tblnamefields/  ##vfield対応　union
				    		tblnamefields = eval(rec["tblfield_viewflmk"])
					 		selectstr << utbl.to_s.split("_")[1].chop + "." +  tblnamefields[utbl] + "  vf" + tblname.chop + "_" +  js + " ,"
				 			####@sfd_code_to   未対応
        				end
			 		end      ##if  js =~ /_id/
  			end   ##subfields
			selectstr = selectstr.chop +  fromstr.chop + wherestr[0..-5]
			#fromstr = ""
			#wherestr = ""
		end
   		#sub_rtbl = "r_" + tblname   ##create view name  tbl:view=1:1  自動作成されるviewはr_xxxxで固定
   		#@strsql1 = "create or replace view  " + sub_rtbl + " as "
   		#@strsql1 << selectstr.chop
    	#ActiveRecord::Base.connection.execute(@strsql1)
		### sql実行時のエラー表示　がまだできてない。
 	end  #end create_or_replace_view


	def  subtblcrt  join_rtbl ,rtblname   ## rtblname:join_rtbl(view名) + safix
   		k = ""
	 	unless ActiveRecord::Base.connection.table_exists?(join_rtbl)
           @errmsg << "create view #{ join_rtbl }"
           raise
           ### create_or_replace_view  tblid,tblname
	  	end
	  	subfields = columns = ActiveRecord::Base.connection.columns(join_rtbl)
    	subfields.each do |j|
        	xfield = sfd_code =  j.name
			  next if xfield.upcase == "ID"
			  next if xfield.upcase =~ /_UPD|UPDATED_AT|CREATED|UPDATE_IP|REMARK/ and  join_rtbl  !=  "upd_persons"
			  sfxfld = if rtblname.split("_",2)[1] and join_rtbl != "upd_persons"  then  "_" + rtblname.split("_",2)[1] else "" end
			  ##sfxfld = if rtblname.split("_",2)[1]   then  "_" + rtblname.split("_",2)[1] else "" end
			  sfd_code = xfield + sfxfld
				strsql = %Q%select pobject_code_sfd from r_screenfields where screenfield_selection = 1
																								and pobject_code_scr = '#{join_rtbl}'
																								and pobject_code_sfd = '#{xfield}' %
				fld = ActiveRecord::Base.connection.select_value(strsql)
				next if fld.nil?
        	new_xfield = rtblname + "." + xfield + " " + sfd_code
        	k <<  " " +  new_xfield   + ","
        	lngerrfield = new_xfield.split(" ")[1]
        	##p " 127 #{xfield}"
        	if ( lngerrfield.length) > 30 then  @errmsg << "sub table: #{join_rtbl}   field: #{lngerrfield}  length: #{(lngerrfield.length).to_s}"  end
			  @sfd_code_id[sfd_code] = set_tblfield_id(join_rtbl ,sfd_code,sfxfld)
    		end  ## subfields.each
    	yield k
	end
	def set_tblfield_id join_rtbl ,sfd_code,tmpfld
		if join_rtbl == "upd_persons"
			njoin_rtbl = "r_persons"
			nsfd_code = sfd_code.sub("_upd","")
		else
			njoin_rtbl = join_rtbl
			nsfd_code = sfd_code

		end
		tblchop,fld_delm = sfd_code.split("_",2)
		if join_rtbl.split("_",2)[1].chop == tblchop
			if fld_delm =~ /_id/
				nsfd_code = sfd_code.sub("_id","s_id")
			end
			strsql = "select id from r_tblfields where pobject_code_tbl = '#{njoin_rtbl.split("_",2)[1]}'
					and pobject_code_fld = '#{nsfd_code.split("_",2)[1].sub(tmpfld,"")}' and tblfield_expiredate >  current_date"
			sfd_id = ActiveRecord::Base.connection.select_value(strsql)
		else
			strsql = "select screenfield_tblfield_id from r_screenfields where pobject_code_scr = '#{njoin_rtbl}'
					and pobject_code_sfd = '#{nsfd_code.sub(tmpfld,"")}' and screenfield_expiredate >  current_date"
			sfd_id = ActiveRecord::Base.connection.select_value(strsql)
		end
		return sfd_id
	end
end
