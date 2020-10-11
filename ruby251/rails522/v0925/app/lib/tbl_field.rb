# -*- coding: utf-8 -*-
module TblField
extend self
	def blktbs params,current_api_user   ### r_blktbs又はr_tblfieldsから呼ばれることを想定
		@checktbls = {}   ### 対象となるテーブル群
		@add_id_to_tbl = {}   ### FIELD・・・s_idが追加された
		@delete_id_to_tbl = {}  # ### FIELD・・・s_idが削除された
		@messages =[]
		@modifysql = ""
		@current_api_user = current_api_user[:email]

		strsql = "select pobject_code,pobject_id from r_pobjects where  pobject_objecttype = 'view_field'
							and pobject_expiredate > current_date  "
		recs = ActiveRecord::Base.connection.select_all(strsql)
		@screenfields ={}
		recs.each do |rec|
			@screenfields[rec["pobject_code"]] = rec["pobject_id"]
		end
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
				strsql = %Q% delete from screenfields where id in(select id from r_screenfields 
								where pobject_code_scr  = 'r_#{tbl}' )
								and (created_at = updated_at or expiredate < current_date)		
						%
				ActiveRecord::Base.connection.delete(strsql)
				create_foreign_key_constraint
				delete_foreign_key_constraint
				###seq の作成
				strsql = "SELECT c.relname FROM pg_class c LEFT join pg_user u ON c.relowner = u.usesysid 
							WHERE c.relkind = 'S' and c.relname='#{tbl}_seq'"
				chk = ActiveRecord::Base.connection.select_one(strsql)
				if chk
				else		
					@modifysql <<  "\n create sequence #{tbl}_seq ;"
				end
				@add_delete_recs = []
				add_default_screenfield tbl
				###sioの作成
				create_sio_table "r_#{tbl}"
				chk_viewfields_exists tbl
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
			##if ["id","expiredate","created_at","updated_at","update_ip"].include?(field["column_name"])
			##	next
			##else	
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
								@delete_id_to_tbl[field["table_name"]]  << field["table_name"]
							else
								@delete_id_to_tbl[field["table_name"]] =[] 
								@delete_id_to_tbl[field["table_name"]]  << field["table_name"]
							end	
						end	
			  		end
				end	
			##end		
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
				create_add_field_sql rec  ###該当テーブルの項目作成
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
			if (field["udt_name"] == rec["fieldcode_ftype"] or (field["udt_name"] == 'bpchar' and  rec["fieldcode_ftype"] == 'char'))
				case field["udt_name"] 
				when "varchar","char"
					if field["character_maximum_length"] > rec["fieldcode_fieldlength"].to_i
					   	rslt = check_exists_fieldid rec["pobject_code_tbl"],rec["pobject_code_fld"]
					  	if rslt
							@messages << rslt
							@checktbls[rec["pobject_code_tbl"]]= "NG"
					   	else	 
							create_modify_field_sql rec
						end
					else  
						if field["character_maximum_length"] < rec["fieldcode_fieldlength"].to_i
							create_modify_field_sql rec
						end
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
			rslt = "DROP COLUMN but already used table:#{table_name},field:#{column_name},value:#{rec[column_name]} "
		else
			rslt = nil	
		end
		return rslt
	end		
	def create_drop_field_sql table_name,column_name
		@modifysql << "\n alter table #{ table_name} DROP COLUMN #{column_name} CASCADE;\n"
		@modifysql << "\n --- 使用しているview "
		@modifysql << "\n --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields "
		@modifysql << "\n ---- where  pobject_code_sfd = '#{column_name}'"
		@modifysql << "\n ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　#{column_name}が削除　#{Time.now}' "
		@modifysql << "\n ---- where  pobject_code_sfd = '#{column_name}'"
	end	
	def create_modify_field_sql rec
		case rec["fieldcode_ftype"]
		when /char/
			@modifysql << "\n alter table #{rec["pobject_code_tbl"]} ALTER COLUMN #{rec["pobject_code_fld"]}  TYPE #{rec["fieldcode_ftype"]}(#{rec["fieldcode_fieldlength"] })"
			if rec["pobject_code_fld"] == "sno" or rec["pobject_code_fld"] == "cno" or rec["pobject_code_fld"] == "gno"
				@modifysql << ";\n alter table #{rec["pobject_code_tbl"]} ALTER COLUMN #{rec["pobject_code_fld"]}  set not null;\n"
			else
				@modifysql << " ;\n"
			end	
		when "numeric"
			@modifysql << "\n alter table  #{rec["pobject_code_tbl"]} ALTER COLUMN #{rec["pobject_code_fld"]}  TYPE #{rec["fieldcode_ftype"]}(#{rec["fieldcode_dataprecision"]},#{rec["fieldcode_datascale"]})"
			if rec["pobject_code_fld"] =~ /_id$|_id_/
				@modifysql << " not null;\n"
			else
				@modifysql << " ;\n"
			end	
        end
	end
	def create_add_field_sql rec  ###該当テーブルの項目作成
		case rec["fieldcode_ftype"]
		when /char/
			@modifysql << "\n alter table #{rec["pobject_code_tbl"]}  ADD COLUMN #{rec["pobject_code_fld"]} #{rec["fieldcode_ftype"]}(#{rec["fieldcode_fieldlength"] });\n"
		when "numeric"
			@modifysql << "\n alter table  #{rec["pobject_code_tbl"]}  ADD COLUMN #{rec["pobject_code_fld"]} #{rec["fieldcode_ftype"]}(#{rec["fieldcode_dataprecision"]},#{rec["fieldcode_datascale"]})"
			if rec["pobject_code_fld"] =~ /_id$|_id_/
				@modifysql << " not null;\n"
			else
				@modifysql << " ;\n"
			end	
		when /date|timestamp/
			@modifysql << "\n alter table #{rec["pobject_code_tbl"]}  ADD COLUMN #{rec["pobject_code_fld"]} #{rec["fieldcode_ftype"]};\n"
		end	
	end	
	def add_default_screenfield tbl
		screens_id  = chk_screen_and_add_screenfields("r_#{tbl}")
		if screens_id
			@add_id_to_tbl.each do |owntbl,othertblfieldids|
				othertblfieldids.each do |othertblfieldid|   ### xxxxs_id
					othertbl,delm = othertblfieldid.split("_id",2)
					delm ||=""
					add_other_viewfield othertbl,owntbl,delm 
				end
			end	
			@delete_id_to_tbl.each do  |owntbl,othertblfieldids|
				othertblfieldids.each do |othertblfieldids|
					othertbl,delm = othertblfieldids.split("_id",2)
					delm ||=""
					delete_other_viewfield othertbl,owntbl,delm  ###テーブルから ・・・s_idが削除されたとき
				end	
			end	
			@add_delete_recs.each do |rec|
				strsql = "select 1 from screenfields where screens_id = #{screens_id} and 
														pobjects_id_sfd = #{rec["screenfield_pobject_id_sfd"]} "
				chk = ActiveRecord::Base.connection.select_one(strsql)
				if chk.nil?
					add_otherview_screenfield_record screens_id,rec,tbl
				end
			end	
			create_viewfield "r_#{tbl}"
		end	
	end	
	def add_other_viewfield othertbl,owntbl,delm 
		howntbl = {}
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
						and screenfield_selection != 0
						and pobject_code_sfd not in('id',
						'#{othertbl.chop}_id','#{othertbl.chop}_created_at','#{othertbl.chop}_update_ip','#{othertbl.chop}_remark',
						'#{othertbl.chop}_updated_at','#{othertbl.chop}_expiredate','#{othertbl.chop}_person_id_upd',
						'person_code_upd','person_name_upd','person_id_upd') "
		recs = ActiveRecord::Base.connection.select_all(strsql)		
		recs.each do |rec|       ### "0" screenfield_editable 入力不可
			owntblkey = "r_#{owntbl}"
			codekey = "#{rec["pobject_code_sfd"]+delm}"
			###debugger if othertbl == "payments" and rec["pobject_code_sfd"] =~ /_code/
			if howntbl[owntblkey].nil?
				howntbl[owntblkey] = {}
				strsql = "select  * from r_screenfields where pobject_code_scr  = 'r_#{owntbl}' and screenfield_expiredate > current_date "
					##	and screenfield_pobject_id_sfd = (select id from pobjects where code = '#{rec["pobject_code_sfd"]+delm}' and objecttype = 'view_field')
					##	and  screenfield_expiredate > current_date"
				chks = ActiveRecord::Base.connection.select_all(strsql)
				chks.each do |chk|
					howntbl[owntblkey][chk["pobject_code_sfd"]] = 1
				end
			end
			if howntbl[owntblkey][codekey]
				###何もしない
			else
				if rec["pobject_code_sfd"] != "id"					
					pobjects_id_sfd = chk_pobject_sfd_and_add rec["pobject_code_sfd"]+delm
					rec["screenfield_pobject_id_sfd"] = pobjects_id_sfd
					rec["screenfield_expiredate"] = "2099/12/31"
					rec["screenfield_crtfield"] = othertbl.chop+(delm||="") 
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
						where pobject_code_scr = '#{screencode}' and screenfield_expiredate > current_date 
						and pobject_code_sfd not in('id',
						'#{othertbl.chop}_id','#{othertbl.chop}_created_at','#{othertbl.chop}_update_ip','#{othertbl.chop}_remark',
						'#{othertbl.chop}_updated_at','#{othertbl.chop}_expiredate','#{othertbl.chop}_person_id_upd',
						'person_code_upd','person_name_upd','person_id_upd') "
		recs = ActiveRecord::Base.connection.select_all(strsql)		
		recs.each do |rec|       #
			strsql = "select  * from r_screenfields where pobject_code_scr  = '#{owntbl}'
						and screenfield_pobject_id_sfd = (select id from pobjects where code = '#{rec["pobject_code_sfd"]+delm}' and objecttype = 'view_field')
						and screenfield_expiredate > current_date "
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
		tmpstrsql = "\n create table #{pobject_code_tbl} ("
		strsql = "select fieldcode_ftype,fieldcode_dataprecision,fieldcode_datascale,fieldcode_fieldlength,pobject_code_fld
						 from r_tblfields where pobject_code_tbl = '#{pobject_code_tbl}'
						  		and tblfield_expiredate > current_date  order by tblfield_seqno"
		fields = ActiveRecord::Base.connection.select_all(strsql)
		fields.each do |field|
			tmpstrsql << "\n #{field["pobject_code_fld"]} #{field["fieldcode_ftype"]}"
            case field["fieldcode_ftype"]
                when /char/
					tmpstrsql    << "(#{field["fieldcode_fieldlength"]})  "
                when "numeric"
					tmpstrsql    <<  if field["fieldcode_dataprecision"] == 0  or field["fieldcode_dataprecision"].nil? 
								 "(22,0) "
							else
								 "(" + field["fieldcode_dataprecision"].to_s + "," + (field["fieldcode_datascale"]||0).to_s + " )  "
							end 
				else
					tmpstrsql     <<     " "
			end	
			["id","code","name"].each do |indispf|
				if field["pobject_code_fld"] == indispf 
					tmpstrsql << " not null "
					break
				end
			end			
			if field["pobject_code_fld"] =~ /s_id/
				tmpstrsql << " not null ,"
			else	
				tmpstrsql << " ,"
			end 	
			if field["pobject_code_fld"] =~ /s_id/
				if  @add_id_to_tbl[pobject_code_tbl] 
					@add_id_to_tbl[pobject_code_tbl]  << field["pobject_code_fld"] 
				else
					@add_id_to_tbl[pobject_code_tbl] =[] 
					@add_id_to_tbl[pobject_code_tbl]  << field["pobject_code_fld"] 
				end	
			end	
    	end
		##  primkey key対応
		tmpstrsql<<  "\n  CONSTRAINT #{pobject_code_tbl}_id_pk PRIMARY KEY (id));"
		@modifysql << tmpstrsql
	end	
	def chk_screen_and_add_screenfields screen  ###該当screenは登録済
		tbl = screen.split("_",2)[1]
		strsql = "select id from r_screens where pobject_code_scr ='#{screen}' "
		screens_id = ActiveRecord::Base.connection.select_value(strsql)
		if screens_id  ###テーブルからviewの項目がscreenfieldsに登録れさてぃるかチェック、されてなければ登録する。
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
					p "#{screens_id},#{pobjects_id_sfd},#{field}" 
				end
				if screenfield == "id"
					screenfield = tbl.chop +  "_id"
					pobjects_id_sfd = chk_pobject_sfd_and_add screenfield
					strsql = "select 1 from screenfields where screens_id = #{screens_id} and pobjects_id_sfd = #{pobjects_id_sfd} "
					rec = ActiveRecord::Base.connection.select_one(strsql)
					if rec.nil?
						add_screenfield_record screens_id,pobjects_id_sfd,field
						p "#{screens_id},#{pobjects_id_sfd},#{field}" 
					end
				end	
			end
		else 
			### テーブルscreendsに登録されてない
			@messages << " <p>please add screen  to　screens   --> '#{screen}' </p>"
			strsql = "select * from pobjects where code ='#{screen}' and objecttype = 'screen'"
			pobject_id_scr = ActiveRecord::Base.connection.select_one(strsql)
			if pobject_id_scr
				###ok
			else
				@messages << " <p>please  add screen code to pobjects --> '#{screen}' </p>"
			end	
		end
		return 	screens_id
	end	
	def  chk_pobject_sfd_and_add screenfield
		##strsql = "select pobject_id from r_pobjects where pobject_code = '#{screenfield}' and pobject_objecttype = 'view_field'
		##			and pobject_expiredate > current_date  "
		##pobjects_id_sfd = ActiveRecord::Base.connection.select_value(strsql)
		if @screenfields[screenfield]
			pobjects_id_sfd =  @screenfields[screenfield]
		else
			pobjects_id_sfd = add_pobject_record screenfield
		end		
		return pobjects_id_sfd
	end	
	def  add_pobject_record screenfield
		command_r =  RorBlkctl.init_from_screen @current_api_user,@params[:screenCode]
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
		###screenfield_screen_id = 1201 and  screenfield_pobject_id_sfd = 13952
		p command_r if command_r["screenfield_pobject_id_sfd"].to_s == "13952"
		reqparams = RorBlkctl.proc_private_aud_rec(command_r,1,nil,nil,nil) 
		if @sio_result_f ==   "9"
		 	@messages <<  "error  add_pobject_record #{screenfield}"
		end  
		return command_r["id"]
	end	

	def add_screenfield_record screens_id,pobjects_id_sfd,field
		if @save_user !=  @current_api_user or @params[:screenCode] ==   @params_screenCode
			@save_user =  @current_api_user 
			@params_screenCode = @params[:screenCode]
			command_r =  RorBlkctl.init_from_screen @current_api_user,@params[:screenCode]
			@command_init = command_r.dup
		else
			command_r = @command_init.dup
		end 
			command_r[:sio_viewname] =  "r_screenfields"
			command_r[:sio_message_contents] = nil
			command_r[:sio_recordcount] = 1
			command_r[:sio_result_f] =   "0"  
			command_r["id"] = ""
			command_r[:sio_classname] = "_add_screenfield_record"
			command_r["screenfield_id"] = ""
			command_r["screenfield_remark"] =	if field["pobject_code_fld"] =~ /s_id/ and field["pobject_code_fld"] != "persons_id_upd"
												" 検索項目の入力を忘れずに"
											else	
												"auto add to screenfield "
											end
			command_r["screenfield_expiredate"] = '2099/12/31'
			command_r["screenfield_screen_id"] = screens_id
			command_r["screenfield_selection"] = "1"
			command_r["screenfield_hideflg"] = if field["pobject_code_fld"] =~ /_id/  or field["pobject_code_fld"] == "id" then "1" else "0" end
			command_r["screenfield_seqno"] =	if ["persons_id_upd","created_at","updated_at","update_ip"].include?(field["pobject_code_fld"]) or
												field["pobject_code_fld"] =~ /_id/  or field["pobject_code_fld"] == "id"
	  												 "9990"
											 else
												if ["code","sno","gno","cno"].include?(field["pobject_code_fld"] ) 
													  "100"
												else
													if field["pobject_code_fld"] == "name"
														"110"
													else
														if 	["exiredate","remark","contents"].include?(field["pobject_code_fld"] ) 
															"800"
														else
															"200"
														end	
													end	  
												end 		  
   											end
			command_r["screenfield_rowpos"]="0"
			command_r["screenfield_colpos"]="0"
			command_r["screenfield_width"]="120"
			command_r["screenfield_type"]= field["fieldcode_ftype"]
			command_r["screenfield_dataprecision"] = field["fieldcode_dataprecision"]
			command_r["screenfield_datascale"] = field["fieldcode_datascale"]
			command_r["screenfield_indisp"] =	if field["pobject_code_fld"] =~ /s_id/ and field["pobject_code_fld"] != "persons_id_upd"
												"1"
											else	
												"0"
											end  ###画面からのチェックはできない。
			command_r["screenfield_subindisp"] =""
			command_r["screenfield_editable"] =	if ["created_at","updated_at","update_ip"].include?(field["pobject_code_fld"]) or
													 field["pobject_code_fld"] =~ /_id/  or field["pobject_code_fld"] == "id"
												"0"
											else
												"1"
											end	 ###"1"  ###変更可
			command_r["screenfield_maxvalue"] ="0"
			command_r["screenfield_minvalue"] ="0"
			command_r["screenfield_edoptsize"] ="0"
			command_r["screenfield_edoptmaxlength"] = field["fieldcode_fieldlength"]
			command_r["screenfield_edoptrow"] ="0"
			command_r["screenfield_edoptcols"] ="0"
			command_r["screenfield_edoptvalue"] = "0"
			command_r["screenfield_pobject_id_sfd"] = pobjects_id_sfd
			command_r["screenfield_tblfield_id"] = field["id"]
			command_r["screenfield_paragraph"] =""
			command_r["screenfield_formatter"] =""
			p command_r if command_r["screenfield_pobject_id_sfd"].to_s == "13952"
			reqparams = RorBlkctl.proc_private_aud_rec(command_r,1,nil,nil,nil) 
			if @sio_result_f ==   "9"
		 		@messages <<  "error  add_screenfield_record #{field["pobject_code_tbl"].chop}_#{field["pobject_code_fld"]}"
			else  
		  		@params[:addId] = command_r["id"]
			end  
	end	
	
	def add_otherview_screenfield_record screens_id,rec,tbl
		command_r =  RorBlkctl.init_from_screen @current_api_user,@params[:screenCode]
		command_r[:sio_viewname] =  "r_screenfields"
		command_r[:sio_message_contents] = nil
		command_r[:sio_recordcount] = 1
		command_r[:sio_result_f] =   "0"  
		command_r["id"] = ""
		command_r[:sio_classname] = "_add_otherview_screenfield_record"
		command_r["screenfield_id"] = ""
		command_r["screenfield_remark"] = "auto add otherview  screenfield --->r_#{tbl} #{rec["pobject_code_sfd"]}"
		command_r["screenfield_expiredate"] = rec["screenfield_expiredate"]
		command_r["screenfield_screen_id"] = screens_id
		command_r["screenfield_selection"] = if rec["pobject_code_sfd"] =~ /_code|_name|_id|opeitm_packqty/  
													'1'
												else
													'0'  
												end  ###screenfield_selection 包装単位数の計算で使用
		command_r["screenfield_hideflg"] = if rec["pobject_code_sfd"] =~ /_id/ or rec["screenfield_hideflg"] != '0' or 
												rec["pobject_code_sfd"] =~ /_remark/ then "1" else "0" end
		command_r["screenfield_seqno"]   =	if rec["pobject_code_sfd"] =~ /_code/ or rec["pobject_code_sfd"] =~ /_name/ 
												  "150"
											else
												if rec["pobject_code_sfd"] == "id"  or rec["screenfield_hideflg"] != '0' or rec["pobject_code_sfd"] =~ /_remark/
													"9992"
												else	
													  "300"	
												end	  
											end 	
		command_r["screenfield_rowpos"]="0"
		command_r["screenfield_colpos"]="0"
		command_r["screenfield_width"]=rec["screenfield_width"]
		command_r["screenfield_type"]=rec["screenfield_type"]
		command_r["screenfield_dataprecision"] =rec["screenfield_dataprecision"]
		command_r["screenfield_datascale"] = rec["screenfield_datascale"]
		command_r["screenfield_indisp"] = "0"
		command_r["screenfield_subindisp"] =""
		command_r["screenfield_editable"] ="0"  ###変更不可
		command_r["screenfield_maxvalue"] =rec["screenfield_maxvalue"]
		command_r["screenfield_minvalue"] =rec["screenfield_minvalue"]
		command_r["screenfield_edoptsize"] ="0"
		command_r["screenfield_edoptmaxlength"] = rec["screenfield_edoptmaxlength"]
		command_r["screenfield_edoptrow"] ="0"
		command_r["screenfield_edoptcols"] ="0"
		command_r["screenfield_edoptvalue"] = "0"
		command_r["screenfield_pobject_id_sfd"] = rec["screenfield_pobject_id_sfd"]
		command_r["screenfield_tblfield_id"] = rec["screenfield_tblfield_id"]
		command_r["screenfield_paragraph"] =""
		command_r["screenfield_formatter"] =rec["screenfield_formatter"]
		command_r["screenfield_crtfield"] = rec["screenfield_crtfield"]  ###create viewのview
		p command_r if command_r["screenfield_pobject_id_sfd"].to_s == "13952"
		reqparams = RorBlkctl.proc_private_aud_rec(command_r,1,nil,nil,nil) 
		if @sio_result_f ==   "9"
		 	@messages <<  "error  add_screenfield_record: r_#{tbl} -->#{rec["pobject_code_sfd"]}"
		else  
		  @params[:addId] = command_r["id"]
		end  
	end	
	def create_viewfield view
		strsql = "select pobject_code_sfd,screenfield_crtfield from r_screenfields where pobject_code_scr = '#{view}' and
					 screenfield_selection = '1' and
					 screenfield_expiredate > current_date "   ####   and screenfield_selection = 1 
		selectfields = ActiveRecord::Base.connection.select_all(strsql)
		createviewscript = "\n --- drop view #{view} cascade  "
		createviewscript << "\n create or replace view #{view} as select  "
		tblchop = view.split("_")[1].chop
		otherview =[]
		selectfields.each do |rec|
			field = rec["pobject_code_sfd"]	
			if rec["screenfield_crtfield"]
				delm = rec["screenfield_crtfield"].split("_",2)[1]
				if !delm.nil?
					delm = "_" + delm 
				end	
			else
				delm = nil
			end	
			if field.split("_")[0] == tblchop
				if field.split("_")[2] =~/id/  ## 自分のテーブル.chop_相手のテーブル.chop_id  + delm
					createviewscript << "\n#{tblchop}.#{field.split("_")[1]}s_id#{field.split("_id")[1]}   #{field},"
					otherview << field.split("_")[1]  + if field.split("_id")[1] then   field.split("_id")[1] else "" end
				else	
					createviewscript << "\n#{tblchop}.#{field.split("_",2)[1]}  #{field},"
				end	
			else
				if field == "id"
					createviewscript << "\n#{tblchop}.id id,"
				else
					if !delm.nil?
						createviewscript << "\n  #{rec["screenfield_crtfield"]}.#{field.split(/#{delm}$/)[0]}  #{field} ,"
					else
						createviewscript << "\n  #{rec["screenfield_crtfield"]}.#{field}  #{field} ,"
					end	
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
		@modifysql << ";" 
		@messages << " --- create view script   #{view} "
	end
	def create_foreign_key_constraint
		@add_id_to_tbl.each do |tbl,fields|
			fields.each do |field|
					strsql = "SELECT table_name, constraint_name FROM information_schema.table_constraints
							where table_catalog='#{ActiveRecord::Base.configurations["development"]["database"]}' 
							and table_name = '#{tbl}'  and constraint_name = '#{tbl.chop}_#{field}'
							and constraint_type = 'FOREIGN KEY';"
					chk = ActiveRecord::Base.connection.select_one(strsql)
					if chk
					 ###何もしない
					else
						@modifysql << "\n ALTER TABLE #{tbl} ADD CONSTRAINT #{tbl.chop}_#{field} FOREIGN KEY (#{field})
																		 REFERENCES #{field.split("_id",2)[0]} (id);"
					end
			end	
		end		
	end		
	def delete_foreign_key_constraint
		@delete_id_to_tbl.each do |tbl,fields|
			fields.each do |field|
				strsql = "SELECT table_name, constraint_name FROM information_schema.table_constraints
							where table_catalog='#{ActiveRecord::Base.configurations["development"]["database"]}' 
							and table_name = '#{tbl}' and constraint_name = '#{tbl.chop}_#{field}'
							AND constraint_type = 'FOREIGN KEY';	"
				chk = ActiveRecord::Base.connection.select_one(strsql)
				if chk
					@modifysql = "\n ALTER TABLE distributors DROP CONSTRAINT  if exists #{tbl.chop}_#{field};"
				else
					###何もしない
				end
			end	
		end		
	end
	
	def create_sio_table  viewname
		begin
		  @modifysql  << "\n DROP TABLE IF EXISTS " + "sio.sio_" + viewname + ";"
		rescue
			  ###例外が発生したときの処理
		else
		# 例外が発生しなかったときに実行される処理
		ensure
		# 例外の発生有無に関わらず最後に必ず実行する処理
		end
			@modifysql << "\n CREATE TABLE " + "sio.sio_" + viewname   + " (\n"
		  	@modifysql <<  "          sio_id numeric(22,0)  CONSTRAINT " +  "SIO_" + viewname   + "_id_pk PRIMARY KEY "
		 	@modifysql <<  "          ,sio_user_code numeric(22,0)\n"
		  	@modifysql <<  "          ,sio_Term_id varchar(30)\n"
		  	@modifysql <<  "          ,sio_session_id numeric(22,0)\n"
		  	@modifysql <<  "          ,sio_Command_Response char(1)\n"
		  	@modifysql <<  "          ,sio_session_counter numeric(22,0)\n"
		  	@modifysql <<  "          ,sio_classname varchar(50)\n"
		  	@modifysql <<  "          ,sio_viewname varchar(30)\n"
		  	@modifysql <<  "          ,sio_code varchar(30)\n"
		  	@modifysql <<  "          ,sio_strsql varchar(4000)\n"
		  	@modifysql <<  "          ,sio_totalcount numeric(22,0)\n"
		  	@modifysql <<  "          ,sio_recordcount numeric(22,0)\n"
		  	@modifysql <<  "          ,sio_start_record numeric(22,0)\n"
		  	@modifysql <<  "          ,sio_end_record numeric(22,0)\n"
		  	@modifysql <<  "          ,sio_sord varchar(256)\n"
		  	@modifysql <<  "          ,sio_search varchar(10)\n"
		  	@modifysql <<  "          ,sio_sidx varchar(256)\n"
		  	@modifysql  <<  sio_fields(viewname)
		  	@modifysql <<  "          ,sio_errline varchar(4000)\n"
		  	@modifysql <<  "          ,sio_org_tblname varchar(30)\n"
		  	@modifysql <<  "          ,sio_org_tblid numeric(22,0)\n"
		  	@modifysql <<  "          ,sio_add_time date\n"
		  	@modifysql <<  "          ,sio_replay_time date\n"
		  	@modifysql <<  "          ,sio_result_f char(1)\n"
		  	@modifysql <<  "          ,sio_message_code char(10)\n"
		  	@modifysql <<  "          ,sio_message_contents varchar(4000)\n"
		  	@modifysql <<  "          ,sio_chk_done char(1)\n"
			@modifysql <<  ");\n"
			  
		  	@modifysql <<  " CREATE INDEX sio_#{viewname}_uk1 \n"
		  	@modifysql << "  ON sio.sio_#{viewname}(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); \n"
			  
			@modifysql <<  "\n drop sequence  if exists sio.sio_#{viewname}_seq ;"##logger.debug @modifysql
			@modifysql <<  "\n create sequence sio.sio_#{viewname}_seq ;"##logger.debug @modifysql
	end #
	def sio_fields viewname
			sio_field_strsql = ""
			strsql = "select screenfield_type,screenfield_dataprecision,screenfield_datascale,pobject_code_sfd,
						screenfield_edoptmaxlength,fieldcode_fieldlength
						from r_screenfields a
						where pobject_code_scr = '#{viewname}' and screenfield_expiredate > current_date 
						order by screenfield_seqno"
			fields = ActiveRecord::Base.connection.select_all(strsql)	
		  	fields.each do |sr|
			  sio_field_strsql << "," + sr["pobject_code_sfd"] + " " 
			  case  sr["screenfield_type"]
				when /char|text/
					  sio_field_strsql << " varchar (" +  sr["fieldcode_fieldlength"].to_s + ") \n"
				when /select/
						sio_field_strsql << " varchar (20) \n"
				when /check/
						sio_field_strsql << " char (01) \n"
				when /number|numeric/
					sio_field_strsql << " numeric "
					sio_field_strsql << if sr["screenfield_dataprecision"] == "0" or sr["screenfield_dataprecision"].nil?
											"(22,0)\n"
										else
											"(#{sr["screenfield_dataprecision"]},#{sr["screenfield_datascale"]})\n"
										end						
				  else
					  sio_field_strsql << "  #{sr["screenfield_type"]} \n"
			  end
		  end
		  return sio_field_strsql
	end 

	def proc_drop_index tblname
		proc_blk_get_constrains(tblname,'U').each do |key|
			@modifysql << " ALTER TABLE #{tblname} drop CONSTRAINT #{key}"
		end
	end

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
				strsql = %Q%select pobject_code_sfd from r_screenfields where screenfield_selection != 0
								and screenfield_expiredate > current_date 	and pobject_code_scr = '#{join_rtbl}'
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
	def chk_viewfields_exists tbl
		chkfields = {}
		strsql = %Q&select pobject_code_fld from r_tblfields where pobject_code_tbl ='#{tbl}'
						and tblfield_expiredate >  current_date and pobject_code_fld like '%s_id%'
						and pobject_code_fld != 'id' and pobject_code_fld != 'persons_id_upd'
				&
		ActiveRecord::Base.connection.select_all(strsql).each do |rec|
			chktbl_delm = rec["pobject_code_fld"].split("_id",2)
			chktbl = chktbl_delm[0]
			delm = (chktbl_delm[1]||="")
			if chkfields.empty? or chkfields["r_#{chktbl}"].nil?
				strsql = "select	table_name,column_name from 	information_schema.columns 
											where 	table_catalog='#{ActiveRecord::Base.configurations["development"]["database"]}' 
											and table_name='r_#{chktbl}'  and column_name  not like '%_upd'
											and column_name  != 'id' "
				chks = ActiveRecord::Base.connection.select_all(strsql)
				chks.each do |chkrec|
					##if chkfields[chkrec["table_name"]].nil?
					##	chkfields[chkrec["table_name"]] = 1
					##else
					##	chkfields[chkrec["table_name"]] += 1
					##end
					if chkfields[chkrec["column_name"]+delm].nil? 
						chkfields[chkrec["column_name"]+delm] = 1
					else
						chkfields[chkrec["column_name"]+delm] += 1
						@messages << "<p>step 1-0: view  #{chkrec["table_name"]}.#{chkrec["column_name"]} duplicate </p>"
					end
				end
			end
		end			
		strsql = %Q&select pobject_code_sfd from r_screenfields where pobject_code_scr ='r_#{tbl}'
								and screenfield_expiredate >  current_date 
								and pobject_code_sfd != 'id' and pobject_code_sfd  not like '%_upd'
					&
		ActiveRecord::Base.connection.select_values(strsql).each do |view|
			viewname = "r_"+view.split("_")[0]+"s"
			tblname = view.split("_")[0]+"s"
			##if  view =~ /_id/
			##	if chkfields[viewname].nil? and "r_#{tbl}" != viewname
			##		@messages << "<p> step 0 : view  #{viewname} not exists field #{view} </p>"
			##	end
			##else
				if  chkfields[view]
					if  chkfields[view] == 1
						chkfields[view] += 1
					else
						@messages << "<p>step 1-2: view field #{view} duplicate </p>"
					end
				else
					##if tblname != tbl
					##	strsql =%Q% delete from screenfields where id in(select id from r_screenfields 
					##			where pobject_code_scr  = 'r_#{tbl}' and  pobject_code_sfd = '#{view}')
					##			and (created_at = updated_at or expiredate < current_date)		
					##	%
					##	ActiveRecord::Base.connection.delete(strsql)
					##end
					##strsql =%Q% delete from screenfields where id in(select id from r_screenfields 
					##			where pobject_code_scr  = 'r_#{tbl}' )
					##			and (created_at = updated_at or expiredate < current_date)		
					##	%
					##	ActiveRecord::Base.connection.delete(strsql)
									
				end
			##end
		end
	end 
	def createUniqueIndex params
		@messages = [] 
		@sql = ""
		ukey = {}
		params["data"].each do |tmp|
			val = JSON.parse(tmp)
			next if val["blkuky_expiredate"] == ""
			next if val["blkuky_expiredate"].to_date < Time.now
			next if val["pobject_code_tbl"] == ""
			next if val["blkuky_grp"] == ""
			if ukey[val["pobject_code_tbl"]].nil?
				ukey[val["pobject_code_tbl"]] = {}
			end	
			if ukey[val["pobject_code_tbl"]][val["blkuky_grp"]].nil?
				ukey[val["pobject_code_tbl"]][val["blkuky_grp"]] = {}
			end	
			ukey[val["pobject_code_tbl"]][val["blkuky_grp"]][val["blkuky_seqno"]] = val["pobject_code_fld"]
		end	
		ukey.each do |tbl,val|
			tblname = tbl.to_s
			val.each do |grp,valseq|  
				grpname = grp.to_s
				constraint_exists = chk_constraint tblname,grpname
				codes = []
				valseq.sort.each do |valseq,code|
					codes << code
				end	
				if constraint_exists
					drop_constraint tblname,grpname,codes
				end	
				create_uniq_constraint tblname,grpname,codes
			end	
		end	
		return @messages,@sql
	end
	def chk_constraint tblname,grpname
		strsql = %Q%SELECT table_name,constraint_name
					FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
					WHERE TABLE_SCHEMA = 'public' and table_name = '#{tblname}'
					and constraint_name = '#{tblname}_uky#{grpname}'
					ORDER BY CONSTRAINT_CATALOG, CONSTRAINT_SCHEMA, CONSTRAINT_NAME%
		chkrecs = ActiveRecord::Base.connection.select_one(strsql)
		constraint_exists = nil
		if chkrecs.nil?
			@messages << " create TABLE_CONSTRAINTS :#{tblname}_uky#{grpname} "
		else
			@messages << " table:#{tblname} already exist :#{tblname}_uky#{grpname} "
			@messages << " Therefore drop  CONSTRAINT  :#{tblname}_uky#{grpname}"
			@messages << "	    and  create TABLE_CONSTRAINTS :#{tblname}_uky#{grpname} "
			constraint_exists = true
		end
		return 	constraint_exists
	end	
	def	create_uniq_constraint tblname,grpname,codes
		 @sql << %Q%ALTER TABLE public.#{tblname}
				ADD CONSTRAINT #{tblname}_uky#{grpname} UNIQUE(#{codes.join(",")});\n%
	end	 	
	def	drop_constraint tblname,grpname,codes
		 @sql << %Q%ALTER TABLE public.#{tblname}
				drop CONSTRAINT #{tblname}_uky#{grpname} cascade;\n%
	end	 
end