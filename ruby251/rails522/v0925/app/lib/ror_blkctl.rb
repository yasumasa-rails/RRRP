# -*- coding: utf-8 -*-
# RorBlk
# 2099/12/31を修正する時は　2100/01/01の修正も
module RorBlkctl
	extend self
	def system_person_id ## command_cで利用
		if @system_person_id
			@system_person_id
		else
			@system_person_id = ActiveRecord::Base.connection.select_value("select id from persons where code = '0'")
			if @system_person_id
				@system_person_id
			else
				Rails.logger.debug"  error missuing person_id = 0 "
				raise
			end
		end
	end
	def grp_code usr_email
        return @pare_class if  @pare_class == "batch"
		if @usrgrp_code
			return @usrgrp_code
		else
			@usrgrp_code =  ActiveRecord::Base.connection.select_value("select usrgrp_code from r_persons where person_email = '#{usr_email}'")
			if @usrgrp_code
				return @usrgrp_code
			else	
				p "add person to his or her email "
				raise   ### 別画面に移動する　後で対応
			end
		end
	end
	def proc_blkgetpobj code,ptype,usr_email
		##sub_blkgetpobj code,ptype
	##end
    ##def sub_blkgetpobj code,ptype    ###
        fstrsqly = contents = ""
        ##grp_code =  sub_blkget_grpcode
		if grp_code(usr_email) == "batch"
            orgname = code
		end
		if code =~ /_id/ or   code == "id"
			orgname = code
		else
			orgname,code,contents = Rails.cache.fetch('proc_blkgetpobj'+code+ptype+usr_email) do
				orgname = ""
				basesql = "select pobjgrp_name ,pobjgrp_contents from R_POBJGRPS where POBJGRP_EXPIREDATE > current_date AND USRgrp_code = '#{grp_code(usr_email)}' and   "
				fstrsql = basesql +  " POBJECT_CODE = '#{code}' and POBJECT_OBJECTTYPE = '#{ptype}' "
				###  フル項目で指定しているとき
				rec = ActiveRecord::Base.connection.select_one(fstrsql)
				if rec
					orgname = rec["pobjgrp_name"]
					contents = rec["pobjgrp_contents"]
				else
					orgname = code
				end		
				if orgname == code and ptype == "view_field" then  ###view項目の時はテーブル項目まで
					orgname = ""
					code.split('_').each_with_index do |value,index|
						fstrsqly =  basesql +  "   POBJECT_CODE = '#{if index == 0 then value + "s" else value end}'  and POBJECT_OBJECTTYPE = '#{if index == 0 then  'tbl' else 'tbl_field' end}' "
						if ActiveRecord::Base.connection.select_value(fstrsql)   ## tbl name get
							orgname <<  ActiveRecord::Base.connection.select_value(fstrsql)  + "_"
						else
							orgname << value + "_"
						end
					end   ## do code.
					orgname.chop!
				end ## if orgname
				[orgname,code,contents]
			end
		end  ##
        return orgname,code,contents
    end  ## def getpobj
    def sub_blkget_code_fm_name name,ptype,current_user    ###
         ##grp_code =  sub_blkget_grpcode
         if name =~ /_id/ or   name == "id" then
            orgcode = name
           else
            orgcode = ""
            basesql = "select POBJECT_CODE  from R_POBJGRPS where POBJGRP_EXPIREDATE > current_date AND USERGROUP_CODE = '#{grp_code(current_user[:email])}' and   "
            basesql  <<  " pobjgrp_name = '#{name}' and POBJECT_OBJECTTYPE = '#{ptype}' "
            pobject_code = ActiveRecord::Base.connection.select_value(basesql)
            orgcode =  if pobject_code then pobject_code else name end
         end  ## if ocde
      return orgcode ||= name
    end  ## def getpobj
	def proc_tblname_field_delm(param_key)  ###import excelでも呼ばれる
		if param_key =~ /^mk/
			mktblname,tblnamechop,field,delm = param_key.split("_",4)
			if mktblname =~ /mkord|mktrngantts/
				return tblnamechop,field,delm
			else
				return nil,nil,nil
			end
		else
			tblnamechop,field,delm = param_key.split("_",3)
		end
	end
    def user_seq_nextval
      ses_cnt_usercode = "userproc_ses_cnt" + @sio_user_code.to_s ###user_code 15char 以下
      unless proc_sequences_exist(ses_cnt_usercode)
             ActiveRecord::Base.connection.execute("CREATE SEQUENCE #{ses_cnt_usercode}")
             ActiveRecord::Base.connection.execute("CREATE SEQUENCE userproc#{@sio_user_code.to_s}s_seq")
             userprocs = "CREATE TABLE userproc#{@sio_user_code.to_s}s
                   ( id numeric(38)
				     ,session_counter numeric(38)
                     ,tblname VARCHAR(30)
                     ,status VARCHAR(20)
                     ,cnt numeric(38)
                     ,cnt_out numeric(38)
                     ,Persons_id_Upd numeric(38)
                     ,Update_IP varchar(40)
                     ,created_at timestamp(6)
                     ,Expiredate date
                     ,Updated_at timestamp(6)
                     ,CONSTRAINT userproc#{@sio_user_code.to_s}s_id_pk PRIMARY KEY (id)
					 ,CONSTRAINT userproc#{@sio_user_code.to_s}s_uk1 UNIQUE(session_counter,tblname)
                      )"
              ActiveRecord::Base.connection.execute(userprocs)
      end
      return proc_get_nextval(ses_cnt_usercode)
    end
    def user_parescreen_nextval
        parescreen_cnt_usercode = "parescreen_a" + @sio_user_code.to_s
        unless proc_sequences_exist(parescreen_cnt_usercode)
            ActiveRecord::Base.connection.execute("CREATE SEQUENCE #{parescreen_cnt_usercode}")
            parescreens = "CREATE TABLE parescreen#{@sio_user_code.to_s}s
                   ( id numeric(38)
                    ,rcdkey VARCHAR(200)
                     ,strsql VARCHAR(4000)
                     ,ctltbl VARCHAR(4000)
                     ,Persons_id_Upd numeric(38)
                     ,Update_IP varchar(40)
                     ,created_at timestamp(6)
                     ,Expiredate date
                     ,Updated_at timestamp(6)
                     , CONSTRAINT parescreen#{@sio_user_code.to_s}s_id_pk PRIMARY KEY (id)
                      )"
              ActiveRecord::Base.connection.execute(parescreens)
        end
        return proc_get_nextval(parescreen_cnt_usercode)
    end
  def proc_update_table command_r,r_cnt0  ##rec = command_c command_rとの混乱を避けるためrecにした。
      	begin
         	tmp_key = {}
			tblname = command_r[:sio_viewname].split("_")[1]
        	if  command_r[:sio_message_contents].nil?
				command_r = proc_set_src_tbl(command_r) ### @src_tblの項目作成
				command_r["person_id_upd"] =  @sio_user_code
				if command_r[:sio_classname] =~ /_add_|_edit_|_delete_/ and tblname !~ /tblink/  ## rec = command_c = sio_xxxxx
					proc_command_before_instance_variable(command_r)
					proc_tblinks(command_r) do
						"before"
				end
			end
			command_r[:sio_recordcount] = r_cnt0
			if tblname =~ /^mk/ and @screen_code !~ /#{tblname}/  ###mkxxxxは追加のみ
				proc_tbl_add_arel(tblname,@src_tbl)
			else
				case command_r[:sio_classname]
				when /_add_/
					proc_tbl_add_arel(tblname,@src_tbl)
				when /_edit_/
					##@src_tbl[:where] = {:id => @src_tbl[:id]}             ##変更分のみ更新
					proc_tbl_edit_arel(tblname,@src_tbl," id = #{@src_tbl[:id]}")
				when  /_delete_/
					if tblname =~ /schs$|ords$|insts$|acts$/  ##alloctblにかかわるtrnは削除なし
						@src_tbl[:qty] = 0 if @src_tbl[:qty]
						@src_tbl[:qty_stk] = 0 if @src_tbl[:qty_stk]
						@src_tbl[:amt] = 0 if @src_tbl[:amt]
						@src_tbl[:tax] = 0 if @src_tbl[:tax]      ##変更分のみ更新
						proc_tbl_edit_arel(tblname,@src_tbl," id = #{@src_tbl[:id]}")
					else
						proc_tbl_delete_arel(tblname," id = #{@src_tbl[:id]}")
					end
				end ### blkukyの時は　constrainも削除
			end
		else
			Rails.logger.debug "command_r = '#{command_r}'"
			raise
		end   ## case iud
		if command_r[:sio_classname] =~ /_add_|_edit_|_delete_/ and tblname !~ /tblink/  ## rec = command_c = sio_xxxxx
			proc_command_after_instance_variable(command_r)
			proc_tblinks(command_r) do
						"after"
			end
		end
      	rescue
        	ActiveRecord::Base.connection.rollback_db_transaction()
            @sio_result_f = command_r[:sio_result_f] =   "9"  ##9:error
            command_r[:sio_message_contents] =  "class #{self} : LINE #{__LINE__} $!: #{$!} "    ###evar not defined
            command_r[:sio_errline] =  "class #{self} : LINE #{__LINE__} $@: #{$@} "[0..3999]
            Rails.logger.debug"error class #{self} : #{Time.now}: #{$@} "
          	Rails.logger.debug"error class #{self} : $!: #{$!} "
          	Rails.logger.debug"  command_r: #{command_r} "
      	else
        	@sio_result_f = command_r[:sio_result_f] =  "1"   ## 1 normal end
          	command_r[:sio_message_contents] = nil
          	command_r[(tblname.chop + "_id")] =  command_r["id"] = @src_tbl[:id]
					proc_delayjob_or_optiontbl(tblname,command_r["id"]) ###  if vproc_optiontabl(tblname)
					##crt_def_all if tblname =~ /rubycodings|tblink/
            ##crt_def_tb if  tblname == "blktbs"
      	ensure
            proc_insert_sio_r( command_r) #### if @pare_class != "batch"    ## 結果のsio書き込み
	  	end ##begin
	  	return command_r
	end
	##def vproc_optiontabl tblname
	##	if tblname =~ /rplies$|mksch|mkords|results$/ then true else false end  ###mkinsts,mkactsは使用してない　12/9
	##end
	def proc_delayjob_or_optiontbl tblname,id
		###ActionController::Base::DbCud.new
      case tblname
			#when   /mkschs/   ###mkinsts,mkactsは使用してない　12/9
			#			if @tbl_mkschs
			#			else
			#				 @tbl_mkschs = []
			#			end
			#			@tbl_mkschs << [tblname,id]
			#							 		####when   /schs$|ords$|insts$|acts$/
			when   /mkords/   ###mkinsts,mkactsは使用してない　12/9
						if @tbl_mkords
						else
						 	@tbl_mkords = []
						end
						@tbl_mkords << [tblname,id]
 			when   /mkbttables/   ###mkinsts,mkactsは使用してない　12/9
 						if @tbl_mktbls
 						else
 						 	@tbl_mktbls = []
 						end
 						@tbl_mktbls << [tblname,id]
 			when    /rplies$/  ###mkinsts,mkactsは使用してない　12/9
 						if @tbl_rpls
 						else
 						 	@tbl_rpls = []
 						end
 						@tbl_rpls << [tblname,id]
 			when    /results$/  ###mkinsts,mkactsは使用してない　12/9
 						if @tbl_results
 						else
 						 	@tbl_results = []
 						end
 						@tbl_results << [tblname,id]
      end
	end
	def vproc_tbl_mk_sub tbls
		begin
			 tbls.each do |tbl|
				##rec = ActiveRecord::Base.connection.select_one("select * from #{tbl[0]} where result_f = '0'  and id = #{tbl[1]}  order by id")   ##0 未処理
				rec = {}
				rec["result_f"] = "5"
				##proc_tbl_edit_arel tbl[0],rec," id = ( #{rec["id"]} )"
				proc_tbl_edit_arel tbl[0],rec," id = ( #{tbl[1]} )"
			end
			 	yield
				ActiveRecord::Base.connection.commit_db_transaction()
		rescue
			ActiveRecord::Base.connection.rollback_db_transaction()
			Rails.logger.debug"error class #{self}   #{Time.now}$@: #{$@} "
			Rails.logger.debug"error class LINE #{__LINE__}   $!: #{$!} "
			Rails.logger.debug"error class LINE #{__LINE__}   perform error: #{ tbls} "
		end
	end
	def vproc_tbl_mk
			##case tblname
			##when "mkschs"  ##not spport
			##if @tbl_mkschs
			##	vproc_tbl_mk_sub  @tbl_mkschs
			##end
			###when "mkbttables"
			if  @tbl_mktbls
				vproc_tbl_mk_sub  @tbl_mktbls do
					dbmks = DbCud.new
					dbmks.perform_mkbttables @tbl_mktbls
				end
			end
			## when "mkords"
			if @tbl_mkords
				vproc_tbl_mk_sub @tbl_mkords do
					dbmks = DbCud.new
					dbmks.perform_mkords @tbl_mkords
				end
			end
 			###when   /rplies$/
			if @tbl_rpls
				vproc_tbl_mk_sub  @tbl_rpls do
					dbmks = DbCud.new
				  dbmks.perform_setreplies  @tbl_rpls
				end
			end
 			##when   /results$/
			if @tbl_results
				vproc_tbl_mk_sub @tbl_results do
					dbmks = DbCud.new
				  dbmks.perform_setresults @tbl_results
				end
			end
	end
	def proc_insert_sio_c  command_c ###要求  無限ループにならないこと
        command_c[:sio_term_id] =  request.remote_ip  if respond_to?("request.remote_ip")  ## batch処理ではrequestはnil　　？？
        command_c[:sio_command_response] = "C"
        command_c[:sio_add_time] = Time.now
		begin
			###既定値をセット
			command_c = vproc_command_c_dflt_set_fm_rubycoding if command_c[:sio_classname] =~ /_add_|_edit_|_delete_/
			if command_c[:sio_viewname] =~ /_inouts$/ and  command_c[:sio_classname] =~ /_add_|_edit_|_delete_/
			else
				command_c[:sio_id] =  proc_get_nextval("sio.SIO_#{command_c[:sio_viewname]}_SEQ")  ## 別スキーマ
				proc_tbl_add_arel("sio_#{command_c[:sio_viewname]}",command_c)
			end
		rescue
			ActiveRecord::Base.connection.rollback_db_transaction()
			Rails.logger.debug " proc_insert_sio_c err  ...command_c = #{command_c}"
            Rails.logger.debug"error class #{self}  $@: #{$@} "
            Rails.logger.debug"error class #{self} #{Time.now} $!: #{$!} "
			raise
		end
  	end   ## sub_insert_sio_c

	def vproc_command_c_dflt_set_fm_rubycoding  ###　引き数はcommand_cで固定
		command_r = command_c.dup
		tblnamechop = command_c[:sio_viewname].split("_",2)[1].chop
		command_c.each do |key,val|
			if (val == "" or val.nil? or val == "dummy" ) and  key.to_s =~ /^#{tblnamechop}_/
				if respond_to?("proc_view_field_#{key.to_s}_dflt_for_tbl_set")
					command_r[key] = __send__("proc_view_field_#{key.to_s}_dflt_for_tbl_set",command_r)
				else
					fld_tbl = key.to_s.split("_",2)[1]
					if respond_to?("proc_field_#{fld_tbl}_dflt_for_tbl_set")
						command_r[key] = __send__("proc_field_#{fld_tbl}_dflt_for_tbl_set",command_r)
					end
				end
			end
		end
		return command_r
	end
	def proc_userproc_insert command_c
    ##def sub_userproc_insert command_c
        userproc = {}
        userproc[:id] = proc_get_nextval("userproc#{@sio_user_code.to_s}s_seq")
				userproc[:session_counter] = command_c[:sio_session_counter]
        userproc[:tblname] = "sio_"+ command_c[:sio_viewname]
        userproc[:cnt] = command_c[:sio_recordcount]
        userproc[:cnt_out] = 0
        userproc[:status] = "request"
        userproc[:created_at] = Time.now
        userproc[:updated_at] = Time.now
        userproc[:persons_id_upd] = system_person_id
        userproc[:expiredate] = DateTime.parse("2099/12/31")
        proc_tbl_add_arel("userproc#{@sio_user_code.to_s}s",userproc)
    ##end
	##	sub_userproc_chk_set command_c
	end
    def proc_userproc_chk_set command_c
		strwhere = "select * from userproc#{@sio_user_code.to_s}s where tblname = 'sio_#{command_c[:sio_viewname]}' and "
		strwhere << " session_counter = #{command_c[:sio_session_counter]} "
        chkuserproc = ActiveRecord::Base.connection.select_one(strwhere)
		if chkuserproc
		    chkuserproc["cnt"] += 1
            ### chkuserproc["where"] = {:id=>chkuserproc["id"]}
            proc_tbl_edit_arel("userproc#{@sio_user_code.to_s}s",chkuserproc," id = #{chkuserproc["id"]}" )
		else
		    proc_userproc_insert command_c
		end
    end
    def sub_parescreen_insert hash_rcd
        parescreen = {}
        parescreen[:id] = @ss_id.to_i
        parescreen[:rcdkey] = nil ###   rcdkey
        parescreen[:strsql] = hash_rcd[:strsql]
        parescreen[:ctltbl] = hash_rcd[:ctltbl]
        parescreen[:created_at] = Time.now
        parescreen[:updated_at] = Time.now
        parescreen[:persons_id_upd] = system_person_id
        parescreen[:expiredate] = Date.today + 1
        proc_tbl_add_arel("parescreen#{@sio_user_code.to_s}s",parescreen)
    end
    def proc_insert_sio_r  command_c ####レスポンス
        command_c[:sio_id] =  proc_get_nextval("sio.SIO_#{command_c[:sio_viewname]}_SEQ")
        command_c[:sio_command_response] = "R"
		command_c[:sio_add_time] = Time.now
		###画面専用項目
		command_c.delete("gridmessage")
		command_c.delete("confirm")
		proc_tbl_add_arel  "SIO_#{command_c[:sio_viewname]}",command_c
    end   ## 
    def char_to_number_data  command_c  ###excel からのデータ取り込み　根本解決を
				##rubyXl マッキントッシュ excel windows excel not perfect
				@date1904 = nil
				viewtype = proc_blk_columns("sio_#{command_c[:sio_viewname]}")
				##@show_data[:allfields].each do |i|
				command_c.each do |key,j|
					if viewtype[key]
						###case @show_data[:alltypes][i]
						case viewtype[key][:data_type].downcase
						when /date|^timestamp/ then
			        begin
						command_c[key] = Time.parse(command_c[key].gsub(/\W/,"")) if command_c[key].class == String
						command_c[key] = num_to_date(command_c[key])  if command_c[key].class == Fixnum  or command_c[key].class == Float
			        rescue
                       command_c[key] = Time.now
			        end
						when /number/ then
							command_c[key] = command_c[key].gsub(/,|\(|\)|\\/,"").to_f if command_c[key].class == String
						when /char/
							command_c[key] = command_c[key].to_i.to_s if command_c[key].class == Fixnum
						end  #case show_data
					else
						command_c.delete(key)
					end  ## if command_c
				end  ## sho_data.each
				command_c[:id] = command_c[(command_c[:sio_viewname].split("_")[1].chop + "_id")]
    end ## defar_to....

    def num_to_date(num)
      return nil if num.nil?
      if @date1904
        compare_date = DateTime.parse('December 31, 1903')
      else
        compare_date = DateTime.parse('December 31, 1899')
      end
      # subtract one day to compare date for erroneous 1900 leap year compatibility
      compare_date - 1 + num
		end
		def create_filteredstr filtered,where_info
			if where_info[:filtered]
				 where_str =  where_info[:filtered] + "    and "
			else
				 where_str = "  where "	 
			end	
			filtered.each  do |strjson|  ##xparams gridの生
				ff = JSON.parse(strjson)
	      		case where_info[ff["id"].to_sym]
				when nil
					next
		 		when /number/
					if ff["value"] =~ /^<=/  or ff["value"] =~ /^>=/ or ff["value"]=~ /^!=/
						where_str << " #{ff["id"]} #{ff["value"][0..1]} #{ ff["value"][2..-1]}      AND "   
					else
						if ff["value"] =~ /^</   or  ff["value"] =~ /^>/	or  ff["value"] =~ /^=/
							where_str << " #{ff["id"]}  #{ff["value"][0]}  #{ ff["value"][1..-1]}      AND "   
						else	
							where_str << " #{ff["id"]} = #{ff["value"]}     AND "
						end	
					end	
	      		when /^date|^timestamp/
		      		case  ff["value"].size
			        when 4
									where_str << " to_char( #{ff["id"]},'yyyy') = '#{ff["value"]}'       AND "
			        when 5
									where_str << " to_char( #{ff["id"]},'yyyy') #{ff["value"][0]} '#{ff["value"][1..-1]}'      AND "  if  ( ff["value"]=~ /^</   or ff["value"] =~ /^>/ )
					when 6
									where_str << " to_char( #{ff["id"]},'yyyy')  #{ff["value"][0..1]} '#{ff["value"][2..-1]}'      AND "  if   (ff["value"] =~ /^<=/  or ff["value"] =~ /^>=/ )
			        when 7
									where_str <<" to_char( #{ff["id"]},'yyyy/mm') = '#{ff["value"]}'       AND "  if Date.valid_date?(ff["value"].split("/")[0].to_i,ff["value"].split("/")[1].to_i,01)
			        when 8
									where_str << " to_char( #{ff["id"]},'yyyy/mm') #{ff["value"][0]} '#{ff["value"][1..-1]}'      AND "  if Date.valid_date?(ff["value"][1..-1].split("/")[0].to_i,ff["value"].split("/")[1].to_i,01)  and ( ff["value"] =~ /^</   or  ff["value"] =~ /^>/ )
                	when 9
									where_str << " to_char( #{ff["id"]},'yyyy/mm')  #{ff["value"][0..1]} '#{ff["value"][2..-1]}'      AND "  if Date.valid_date?(ff["value"][1..-1].split("/")[0].to_i,ff["value"].split("/")[1].to_i,01)   and (ff["value"] =~ /^<=/  or ff["value"]=~ /^>=/ )
			        when 10
									where_str << " to_char( #{ff["id"]},'yyyy/mm/dd') = '#{ff["value"]}'       AND "  if Date.valid_date?(j.split("/")[0].to_i,ff["value"].split("/")[1].to_i,ff["value"].split("/")[2].to_i)
			        when 11
									where_str << " to_char( #{ff["id"]},'yyyy/mm/dd') #{ff["ivalue"][0]} '#{ff["value"][1..-1]}'      AND "  if Date.valid_date?(ff["value"][1..-1].split("/")[0].to_i,ff["value"].split("/")[1].to_i,ff["value"].split("/")[2].to_i)  and ( ff["value"] =~ /^</   or  ff["value"] =~ /^>/ )
                	when 12
									where_str << " to_char( #{ff["id"]},'yyyy/mm/dd')  #{ff["value"][0..1]} '#{ff["value"][2..-1]}'      AND "  if Date.valid_date?(ff["value"][2..-1].split("/")[0].to_i,ff["value"].split("/")[1].to_i,ff["value"].split("/")[2].to_i)   and (ff["value"] =~ /^<=/  or ff["value"]=~ /^>=/ )
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
                	end ## ff["value"].size
				when /char|text/
					if  (ff["value"] =~ /^%/ or ff["value"] =~ /%$/ ) then 
						where_str << " #{ff["id"]} like '#{ff["value"]}'     AND "
					elsif ff["value"] =~ /^<=/  or ff["value"] =~ /^>=/ then 
						where_str << " #{ff["id"]} #{ff["id"][0..1]} '#{ff["id"][2..-1]}'     AND "
					elsif 	ff["value"] =~ /^</   or  ff["value"] =~ /^>/
						where_str << " #{ff["id"]}   #{ff["value"][0]}  '#{ff["value"][1..-1]}'         AND " 
					else
						where_str << " #{ff["id"]} = '#{ff["value"]}'         AND "
					end
	      		when "select"
					where_str << " #{ff["id"]} = '#{ff["value"]}'         AND "
        		end   ##show_data[:alltypes][i]
        		tmpwhere = " #{ff["id"]} #{ff["value"]}    AND " if  ff["value"] =~/is\s*null/ or ff["value"]=~/is\s*not\s*null/
	      		where_str << (tmpwhere||="")
			end ### command_c.each  do |i,j|###
    	return where_str[0..-7]
		end	
		def fetch_data_blk id,select_fields,page_info,strwhere,sorting
				strsorting = ""
				if sorting
				end
				strsql = "select #{select_fields} from (SELECT ROW_NUMBER() OVER (#{strsorting}) ,#{select_fields}
																	 FROM #{id} #{if strwhere == '' then '' else strwhere end } ) x
																	where ROW_NUMBER > #{(page_info[:pageNo]-1.0)*page_info[:sizePerPage] } 
																 and ROW_NUMBER <= #{(page_info[:pageNo])*page_info[:sizePerPage] } 
																  "
				pagedata = ActiveRecord::Base.connection.select_all(strsql)

				strsql = "SELECT count(*) FROM #{id} #{if strwhere == '' then '' else strwhere end } "
				total_cnt = ActiveRecord::Base.connection.select_value(strsql)
				page_info[:totalPage] = (total_cnt.to_f/page_info[:sizePerPage].to_f).ceil
				return  pagedata,	page_info
		end	
		def download_data_blk screenCode,select_fields,strwhere
				strsql = "select #{select_fields} from  #{screenCode}
							 #{if strwhere == '' then '' else strwhere   end }  limit 1000000	  "
				pagedata = ActiveRecord::Base.connection.select_all(strsql)
				strsql = "select count(*) from  #{screenCode}
							 #{if strwhere == '' then '' else strwhere   end }  limit 1000000	  "
				cnt = ActiveRecord::Base.connection.select_value(strsql)
				return  pagedata,cnt
		end	
		def add_empty_data id,columns_info,page_info
				num = page_info[:sizePerPage]
				pagedata =[]
				until num <= 0 do
							temp ={}
							columns_info.each do |cell|
									temp[cell[:accessor]] = ""
							end	
							pagedata << temp
							num = num - 1
				end
				page_info[:totalPage] = 1
				return  pagedata,	page_info
		end	
    def proc_blk_paging  command_c,screen_prop,field_prop
        ### strsqlにコーディングしてないときは、viewを使用
        ### strdql はupdate insertには使用できない。
        ### command_c[:sio_strsql] = (select  ・・・・) a
				tmp_sql = (screen_prop[:screen_strwhere]||="")  
        if  command_c[:sio_strsql]     ## 親からの引き継ぎ検索ありの時
				command_c[:sio_strsql].each do|key,val|
					tmp_sql << " and #{key} = #{val} "   ###親側で文字タイプの「'」はセットすること
				end
		end
		###screen登録された　既定値の抽出条件
		##strsql = "SELECT id FROM " + tmp_sql
        if command_c[:sio_search]  == "true"   ### proc_strwhere(command_c) 画論に入力された抽出条件
				tmp_sql <<  proc_strwhere(command_c)
		end
		case tmp_sql.strip
		when /^where /   ###next
		when /^and /
			tmp_sql.sub!(/^and /,"where ") 
		when ""   ### next
		else
			tmp_sql << "where " + tmp_sql
		end
		tmp_sql = command_c[:sio_viewname] + " a  " + tmp_sql
        command_c[:sio_totalcount] =  ActiveRecord::Base.connection.select_value( "SELECT count(*) FROM  #{tmp_sql}")
		sort_tmp =  if screen_prop[:screen_strorder] then  " order by "  + screen_prop[:screen_strorder].sub(/order\s*by/,"") else "" end   ### sort 初期セット
        sort_sql = ""
        unless command_c[:sio_sidx].nil? or command_c[:sio_sidx] == ""  ###画面からsort keyを指定
	        sort_sql = " ROW_NUMBER() over (order by " +  command_c[:sio_sidx] + " " +  command_c[:sio_sord]  + " ) "
					sort_tmp  = ""
	    else
			if sort_tmp == ""
	        	sort_sql = "ROW_NUMBER() over () "
			else
		        sort_sql = " ROW_NUMBER() over ( " +  sort_tmp  + " ) "  ### screensにsort keyがセットされているとき　sortの既定値
			end
        end
        case  command_c[:sio_totalcount]
            when nil,0   ## 該当データなし　　回答
	            command_c[:sio_recordcount] = 0
                command_c[:sio_result_f] = "8"  ## no record
                command_c[:sio_message_contents] = proc_blkgetpobj("not find record","err_msg",command_c[:sio_email] )[0]
                proc_insert_sio_r command_c
            else
                strsql = "select #{screen_prop[:sqlrecstr]} from (SELECT #{sort_sql} cnt,a.* FROM #{tmp_sql} )  b "
                strsql  <<    " WHERE  cnt <= #{command_c[:sio_end_record]}  and  cnt >= #{command_c[:sio_start_record]} "
				pagedata = ActiveRecord::Base.connection.select_all(strsql)
				command_c[:sio_recordcount] = pagedata.length
				show_records = []
				pagedata.each do |j|
					phash = {}
                    j.each do |j_key,j_val|
						command_c[j_key]   = j_val ## 
						proc_tbl_field_to_screen_field_hash(j_key,j_val,field_prop,phash) 
                    end
					show_records << phash
                    command_c[:sio_result_f] = "1"
                    command_c[:sio_message_contents] = nil
					proc_insert_sio_r command_c ###回答					
	            end  ##pagedata
				##show_records = if show_records.size > 1 then show_records.chop + "]" else "[{}]" end 
        end   ## case
		return show_records
    end   ##sub_blk_paging

    def proc_strwhere command_c
	  #日付　/ - 固定にしないようにできないか?
        if command_c[:sio_strsql] then
          strwhere =  if command_c[:sio_strsql].downcase.split(")")[-1] =~ /where/ then   " and " else  " where "  end
          else
           strwhere = " WHERE "
        end
		strwhere = proc_search_key_strwhere strwhere
	end
	def proc_search_key_strwhere search_key,strwhere,show_data   ###search key:"xxxx"   not sym   ## search_key 画面と db_cud(データ選択)で使用
    search_key.each  do |i,j|  ##xparams gridの生
        next if j == ""
				tmpwhere = nil
	      case show_data[:alltypes][i.to_sym]
				when nil
					next
	      when /number/
                    tmpwhere = " #{i} = #{j}     AND "
		            tmpwhere = " #{i}  #{j[0]}  #{j[1..-1]}      AND "   if j =~ /^</   or  j =~ /^>/
		            tmpwhere = " #{i} #{j[0..1]} #{j[2..-1]}      AND "    if j =~ /^<=/  or j =~ /^>=/ or j =~ /^!=/
	      when /^date|^timestamp/
		            case  j.size
			          when 4
			                tmpwhere = " to_char( #{i},'yyyy') = '#{j}'       AND "
			          when 5
			                tmpwhere = " to_char( #{i},'yyyy') #{j[0]} '#{j[1..-1]}'      AND "  if  ( j =~ /^</   or  j =~ /^>/ )
                        when 6
			                tmpwhere = " to_char( #{i},'yyyy')  #{j[0..1]} '#{j[2..-1]}'      AND "  if   (j =~ /^<=/  or j =~ /^>=/ )
			          when 7
			                tmpwhere = " to_char( #{i},'yyyy/mm') = '#{j}'       AND "  if Date.valid_date?(j.split("/")[0].to_i,j.split("/")[1].to_i,01)
			          when 8
			                tmpwhere = " to_char( #{i},'yyyy/mm') #{j[0]} '#{j[1..-1]}'      AND "  if Date.valid_date?(j[1..-1].split("/")[0].to_i,j.split("/")[1].to_i,01)  and ( j =~ /^</   or  j =~ /^>/ )
                when 9
			                tmpwhere = " to_char( #{i},'yyyy/mm')  #{j[0..1]} '#{j[2..-1]}'      AND "  if Date.valid_date?(j[1..-1].split("/")[0].to_i,j.split("/")[1].to_i,01)   and (j =~ /^<=/  or j =~ /^>=/ )
			          when 10
			                tmpwhere = " to_char( #{i},'yyyy/mm/dd') = '#{j}'       AND "  if Date.valid_date?(j.split("/")[0].to_i,j.split("/")[1].to_i,j.split("/")[2].to_i)
			          when 11
			                tmpwhere = " to_char( #{i},'yyyy/mm/dd') #{j[0]} '#{j[1..-1]}'      AND "  if Date.valid_date?(j[1..-1].split("/")[0].to_i,j.split("/")[1].to_i,j.split("/")[2].to_i)  and ( j =~ /^</   or  j =~ /^>/ )
                when 12
			                tmpwhere = " to_char( #{i},'yyyy/mm/dd')  #{j[0..1]} '#{j[2..-1]}'      AND "  if Date.valid_date?(j[2..-1].split("/")[0].to_i,j.split("/")[1].to_i,j.split("/")[2].to_i)   and (j =~ /^<=/  or j =~ /^>=/ )
			          when 16
			                if Date.valid_date?(j.split("/")[0].to_i,j.split("/")[1].to_i,j.split("/")[2][0..1].to_i)
												hh = j.split(" ")[1][0..1]
												mi = j.split(" ")[1][3..4]
												delm = j.split(" ")[1][2.2]
												if  Array(0..24).index(hh.to_i) and Array(0..60).index(mi.to_i) and delm ==":"
													tmpwhere = " to_char( #{i},'yyyy/mm/dd hh24:mi') = '#{j}'       AND "
												end
											end
			          when 17
									if Date.valid_date?(j[1..-1].split("/")[0].to_i,j.split("/")[1].to_i,j.split("/")[2][0..1].to_i)  and ( j =~ /^</   or  j =~ /^>/ or  j =~ /^=/ )
										hh = j.split(" ")[1][0..1]
										mi = j.split(" ")[1][3..4]
										delm = j.split(" ")[1][2.2]
										if  Array(0..24).index(hh.to_i) and Array(0..60).index(mi.to_i) and delm ==":"
											tmpwhere = " to_char( #{i},'yyyy/mm/dd hh24:mi') #{j[0]} '#{j[1..-1]}'      AND "
										end
									end
                when 18
			                if Date.valid_date?(j[2..-1].split("/")[0].to_i,j.split("/")[1].to_i,j.split("/")[2][0..1].to_i)   and (j =~ /^<=/  or j =~ /^>=/ )
												hh = j.split(" ")[1][0..1]
												mi = j.split(" ")[1][3..4]
												delm = j.split(" ")[1][2.2]
												if  Array(0..24).index(hh.to_i) and Array(0..60).index(mi.to_i) and delm ==":"
													tmpwhere = " to_char( #{i},'yyyy/mm/dd hh24:mi')  #{j[0..1]} '#{j[2..-1]}'      AND "
												end
											end
                end ## j.size
	      when /char|text/
                tmpwhere = " #{i} = '#{j}'         AND "
		            tmpwhere = " #{i}  #{j[0]}  '#{j[1..-1]}'         AND "  if j =~ /^</   or  j =~ /^>/
		            tmpwhere = " #{i} #{j[0..1]} '#{j[2..-1]}'       AND "    if j =~ /^<=/  or j =~ /^>=/
		            tmpwhere = " #{i} like '#{j}'     AND " if (j =~ /^%/ or j =~ /%$/ )
	                #when  "textarea"
                    #       tmpwhere = " #{i.to_s} like '#{j}'     AND " if (j =~ /^%/ or j =~ /%$/ )
	      when "select"
                   tmpwhere = " #{i} = '#{j}'         AND "
        end   ##show_data[:alltypes][i]
        tmpwhere = " #{i} #{j}    AND " if  j =~/is\s*null/ or j =~/is\s*not\s*null/
	      strwhere << tmpwhere  if  tmpwhere
    end ### command_c.each  do |i,j|###
    return strwhere[0..-7]
  end   ## proc_strwhere
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

	def proc_get_starttime duedate,duration,period,type
		case type
			when nil
				case period
					when "day"
						duedate - duration * 24 * 60* 60
				end
		end
	end

	def proc_get_transport fm_id,to_id   ### transport
		if LocaTransport[fm_id.to_s + to_id.to_s]
			return LocaTransport[fm_id.to_s + to_id.to_s]
		else
			strsql = "select transport_id,transport_code,transport_name,localt_duration duration from r_localts
						where localt_loca_id_fm = #{fm_id} and localt_loca_id_to = #{to_id} order by localt_priority"
			LocaTransport[fm_id.to_s + to_id.to_s] = ActiveRecord::Base.connection.select_one(strsql)
			if LocaTransport[fm_id.to_s + to_id.to_s]
				return LocaTransport[fm_id.to_s + to_id.to_s]
			else
				strsql = "select transport_id,transport_code,transport_name,localt_duration duration from r_localts
						where localt_loca_id_fm = #{fm_id}  order by localt_priority"
				LocaTransport[fm_id.to_s + to_id.to_s] = ActiveRecord::Base.connection.select_one(strsql)
				if 	LocaTransport[fm_id.to_s + to_id.to_s]
					return LocaTransport[fm_id.to_s + to_id.to_s]
				else
					strsql = "select transport_id,transport_code,transport_name,1 duration from r_transports
							where transport_code = 'dummy' "
					LocaTransport[fm_id.to_s + to_id.to_s] = ActiveRecord::Base.connection.select_one(strsql)
					if LocaTransport[fm_id.to_s + to_id.to_s]
						return LocaTransport[fm_id.to_s + to_id.to_s]
					else
						Rails.logger.debug " line #{__LINE__} fm_id:#{fm_id}, to_id:#{to_id} "
						raise
					end
				end
			end
		end
	end
    def proc_get_cons_chil(key)  ###工程の始まり=前工程の終わり
		strsql = "select nditm_itm_id_nditm itms_id, nditm_loca_id_nditm locas_id,nditm_processseq_nditm processseq ,
		                nditm_consumtype consumtype,nditm_consumauto consumauto,nditm_minqty minqty,nditm_consumunitqty consumunitqty
					from r_nditms nd
		            where  nditm_Expiredate > current_date
					and opeitm_itm_id = #{key["itms_id"]} and opeitm_loca_id = #{key["locas_id"]}  and opeitm_processseq = #{key["processseq"]} order by itm_code "
		chils = ActiveRecord::Base.connection.select_all(strsql)
		strsql = "select chil.itms_id itms_id, chil.locas_id locas_id,chil.processseq processseq ,
		                chil.consumtype consumtype,chil.consumauto consumauto,chil.minqty minqty,chil.consumunitqty consumunitqty
					from opeitms pare,opeitms chil
		            where  chil.Expiredate > current_date and pare.expiredate > current_date
					and pare.itms_id = #{key["itms_id"]} and  pare.processseq = #{key["processseq"]}
					and pare.itms_id = chil.itms_id and pare.processseq > chil.processseq and (pare.priority = chil.priority or chil.priority = 999)
					order by chil.processseq desc"
		chil_opeitm = ActiveRecord::Base.connection.select_one(strsql)
		chils << chil_opeitm if chil_opeitm
		return chils
    end
	def proc_get_trngantt_cons_chil_inout_fm_alloc_id alloc_id   ### trngantt作成時　の消費の予定
		alloc = ActiveRecord::Base.connection.select_one("select * from alloctbls where id = #{alloc_id}")
		if alloc["srctblname"] == "trngantts"
			strsql = "select calloc.qty calloc_qty,calloc.qty_stk calloc_qty_stk,calloc.id calloc_id,calloc.destblname calloc_destblname,calloc.destblid calloc_destblid,
						palloc.id palloc_id,palloc.destblname palloc_destblname,palloc.destblid palloc_destblid,
						cgantt.trngantt_qty cgantt_qty,cgantt.trngantt_qty_stk cgantt_qty_stk,cgantt.trngantt_id cgantt_id,
						cgantt.trngantt_itm_id cgantt_itm_id,cgantt.trngantt_processseq cgantt_processseq,cgantt.trngantt_consumtype cgantt_consumtype,
						pgantt.trngantt_starttime pgantt_starttime,pgantt.trngantt_loca_id pgantt_loca_id,pgantt.trngantt_itm_id pgantt_itm_id
						from r_trngantts cgantt,alloctbls calloc,alloctbls palloc ,r_trngantts pgantt
						where pgantt.trngantt_id = #{alloc["srctblid"]}
						and pgantt.trngantt_orgtblname = cgantt.trngantt_orgtblname and pgantt.trngantt_orgtblid = cgantt.trngantt_orgtblid
						and pgantt.trngantt_key = case length(cgantt.trngantt_key)
						                             when 3 then
														to_char(cgantt.trngantt_key - 1,'000')
													 else
													     substr(cgantt.trngantt_key,1,length(cgantt.trngantt_key) -3 )
													 end
						and palloc.srctblname = 'trngantts' and palloc.srctblid = pgantt.trngantt_id and (palloc.qty > 0 or palloc.qty_stk >0 )
						and calloc.srctblname = 'trngantts' and calloc.srctblid = cgantt.trngantt_id and (calloc.qty > 0 or calloc.qty_stk > 0)
						and calloc.allocfree = 'alloc' and 	palloc.allocfree = 'alloc' 	"
			children = ActiveRecord::Base.connection.select_all(strsql)
			children.each do |chil|
				proc_command_instance_variable(ActiveRecord::Base.connection.select_one(" select * from r_#{chil["calloc_destblname"]} where id = #{chil["calloc_destblid"]}"))
				case chil["cgantt_consumtype"]
				when /con|BYP/
					inout = {}
					inout[:id] = proc_get_nextval("inouts_seq")
					@sio_classname = "_add_proc_get_trngantt_cons_chil_inout_fm_alloc_id"
						inout[:inout_alloctbl_id_inout] = chil["calloc_id"]
						###logger.debug "trace  '#{chil["calloc_id"]} "
						inout[:inout_trngantt_id_inout] = chil["cgantt_id"]
						inout[:inout_itm_id_pare] = chil["pgantt_itm_id"]
						inout[:inout_inoutflg] = chil["cgantt_consumtype"]
						inout[:inout_qty] = chil["calloc_qty"] * -1
						inout[:inout_qty_stk] = chil["calloc_qty_stk"] * -1
						pare = ActiveRecord::Base.connection.select_one(" select * from r_#{alloc["destblname"]} where id = #{alloc["destblid"]}")
						inout[:inout_loca_id] = pare["opeitm_loca_id"]
						inout[:inout_starttime] = pare["#{alloc["destblname"].chop}_starttime"]   ###在庫とあっていること　原価の計算とも合うこと
						##inout[:inout_processseq] = if  chil["pgantt_itm_id"] == chil["cgantt_itm_id"] then pare["#{alloc["destblname"].chop}_processseq"] else chil["cgantt_processseq"] end
						__send__("proc_fld_con_#{alloc["destblname"]}_inouts_self10") do   ###alloctbls 自身のinout　　 con子部品の消費
							inout
						end
					##end
				when "DEV"  ###装置が空いた
				when "MET"  ### 完了したとき返却
				end
			end
		else
			Rails.logger.debug "logic err alloc = '#{alloc} "
			raise
		end
	end
	def proc_get_trngantt_pic_stk(shp,shp_id)  ### shp,dlv
		strsql = %Q& select lot.*,alloc.qty_stk alloc_qty_stk
						from trngantts gantt,alloctbls alloc ,lotstkhists lot,
							(select pgantt.* from trngantts pgantt,alloctbls ,#{shp} shp
									where pgantts.id = srctblid and srctblname = 'trngantts' and destblname = '#{shp}' and destblid = shp.id
									and shp.id = #{shp_id}) pgantt
						where alloc.srctblname = 'trngantts' and gantt.id = alloc.srctblid
						and alloc.destblname = 'lotstkhists' and alloc.destblid = lot.id
						and lot.itms_id = #{@itm_id} and lot.locas_id = #{@loca_id}
						and gantt.orgtblname = pgantt.orgtblname and gantt.orgtblid = pgantt.orgtblid and pgantt.key = substr(gantt.key,1,length(pgantt.key))
						&
		ActiveRecord::Base.connection.select_all(strsql)
	end
	def proc_auto_add_pobject_code(pobject_code,objecttype)
        strsql = "select code from pobjects where code = '#{pobject_code}' and objecttype = '#{objecttype}'  and expiredate > current_date"
        if   ActiveRecord::Base.connection.select_one(strsql).nil?
	        command_c = {}.with_indifferent_access
            command_c[:pobject_code] = pobject_code
            command_c[:pobject_expiredate] = "2099/12/31".to_date
            command_c[:pobject_objecttype] = objecttype
            command_c[:sio_viewname] = "r_pobjects"
            command_c[:sio_session_counter] =   user_seq_nextval   ##
            command_c[:sio_classname] = "_auto_add_by_screencodes"
            command_c[:id] = command_c[:pobject_id] = proc_get_nextval("pobjects_seq")
            command_c[:sio_user_code] = (@sio_user_code ||=0)
            proc_simple_sio_insert command_c
			id = command_c[:id]
		else
			id = nil
        end
	end
	def proc_get_pare_opeitms_by_nditms(itms_id,locas_id) ##未作成
		strsql = "select * from r_nditms where nditm_opeitm_id = #{opeitms_id} #{strwhere}  and nditm_Expiredate > current_date "
		rnditms = ActiveRecord::Base.connection.select_all(strsql)
	end

	def proc_get_pare_opeitm_by_opeitm (itms_id,locas_id,processseq)  ##未作成
		strsql = "select * from r_opeitms where opeitm_itm_id = #{itms_id} and opeitm_loca_id = #{locas_id}   and opeitm_processseq >  #{processseq } and opeitm_Expiredate > current_date
																			order by opeitm_processseq  ,opeitm_priority desc"
		pare_opeitm = ActiveRecord::Base.connection.select_one(strsql)
		pare_opeitm ||= {}
	end

	def proc_get_pare_trngantts_itm_by_trn(tblname,tblid)  ##未作成
			strsql = "select pare.* from r_trngantts pare,trngantts chil,alloctbls a where chil.id = a.srctblid and a.srctblname = 'trngantts'
			                        and destblname = '#{tblname}' and destblid = #{tblid}
															and pare.trngantt_key =  case length(chil.key) when 3 then  to_char(chil.key  - 1,'000')   else   substr(chil.key,1,length(chil.key) -3)   end
									and pare.trngantt_orgtblname = chil.orgtblname and 	pare.trngantt_orgtblid = chil.orgtblid"
			ActiveRecord::Base.connection.select_all(strsql)
	end

	def proc_get_pare_trngantts_by_chil_trngantt_id(id) ##
		strsql = "select pare.id from trngantts pare,trngantts chil where pare.orgtblname = chil.orgtblname  and pare.orgtblid = chil.orgtblid  and chil.id = #{id} and
		                             pare.key = substr(chil.key,1,length(pare.key))  "
		ActiveRecord::Base.connection.select_all(strsql)   		###副産物がある
	end
	def proc_get_chil_trngantts_by_pare_trngantt_id(id) ##
		strsql = "select chil.id from trngantts pare,trngantts chil where pare.orgtblname = chil.orgtblname  and pare.orgtblid = chil.orgtblid  and pare.id = #{id} and
		                             chil.id != pare.id and pare.key = substr(chil.key,1,length(pare.key))  and pare.qty > 0 "
		ActiveRecord::Base.connection.select_values(strsql)
	end
  def proc_get_chil_prdpurshps_by_pare_trngantt_id(id) ##
		trns = proc_get_chil_trngantts_by_pare_trngantt_id(id)
		if trns.size > 0
			strsql = "select * from alloctbls where allocfree = 'alloc' and srctblname = 'trngantts' and  srctblid in (#{trns.join(",")}) "
			ActiveRecord::Base.connection.select_all(strsql)
		else
			[]
		end
	end
	def proc_get_chil_prdpurshps_by_pare_prdpurshp(tblname,tblid) ##
		allocs = []
		strsql = "select srctblid from alloctbls where allocfree = 'alloc' and srctblname = 'trngantts' and destblname = '#{tblname}' and destblid = #{tblid} and (qty > 0 or qty_stk > 0)"
		trnids = ActiveRecord::Base.connection.select_values(strsql)
		trnids.each do|trnid|
			allocs.concat(proc_get_chil_prdpurshps_by_pare_trngantt_id(trnid))
		end
		return allocs
	end
	def proc_get_pare_opeitms_by_trngantts(itms_id,locas_id) ## 未作成

	end
	def proc_sch_chil_get orgtblname,orgtblid	##
		strsql = "select alloctbl.id alloctbl_id from trngantts trn ,alloctbls alloctbl where trn.orgtblname = '#{orgtblname}' and trn.orgtblid = #{orgtblid}
						and alloctbl.srctblname = 'trngantts' and alloctbl.srctblid = trn.id
						and (destblname like 'pur%' or destblname like 'prd%' or destblname like 'dym%') order by trn.key "
		alloc_ids = ActiveRecord::Base.connection.select_values(strsql)
		alloc_ids.each do |alloc_id|
			proc_get_trngantt_cons_chil_inout_fm_alloc_id(alloc_id)
		end
	end
  def vproc_get_chil_itms(n0,duedate)  ###工程の始まり=前工程の終わり
		rnditms = ActiveRecord::Base.connection.select_all("select * from nditms where opeitms_id = #{n0[:opeitms_id]} and Expiredate > current_date  ")
		if rnditms.size > 0 then
			ngantts = []  ###viewの内容なので　itm_id  loca_id
			mlevel = n0[:mlevel] + 1
			rnditms.each.with_index(1)  do |i,cnt|
				chil_ope = proc_get_opeitms_rec(i["itms_id_nditm"], i["locas_id_nditm"],i["processseq_nditm"])
				if chil_ope.nil?
					chil_ope = proc_get_opeitms_rec(i["itms_id_nditm"],nil,i["processseq_nditm"],999)
				end
				##if chil_ope and i["consumtype"]
				if chil_ope
					  opeitm = proc_get_opeitms_rec(i["itms_id_nditm"], i["locas_id_nditm"],i["processseq_nditm"])
						i["consumtype"] = "con"  if  i["consumtype"] =~ /con/
						ngantts << {:seq=>n0[:seq] + sprintf("%03d", cnt),:mlevel=>mlevel,:itms_id=>i["itms_id_nditm"],
								##:prdpurshp=>"shp",
								:prdpurshp=>opeitm["prdpurshp"],
								:processseq=>i["processseq_nditm"],
								:locas_id=> i["locas_id_nditm"],
								:locas_id_to=>n0[:locas_id],:opeitms_id =>chil_ope["id"],
								:priority=>chil_ope["priority"],
								:duedate=>duedate,:duration=>(n0[:duration]||=1),:shelfnos_id=>chil_ope["shelfnos_id"],:shuffleflg=>chil_ope["shuffleflg"],
								:consumtype=>i["consumtype"],:consumauto=>i["consumauto"],
								:autocreate_ord=>chil_ope["autocreate_ord"],:autoord_p=>chil_ope["autoord"],
								:autocreate_inst=>chil_ope["autocreate_inst"],:autocreate_act=>chil_ope["autocreate_act"],
								:parenum=>i["parenum"],:chilnum=>i["chilnum"],:id=>"nditms_"+i["id"].to_s}  ###
				else
					item_code  = ActiveRecord::Base.connection.select_value("select code from itms where id = #{i["itms_id_nditm"]} ")
					@errmsg = "missng opeitms ... item_code = #{item_code} processseq =  #{i["processseq_nditm"]}"
					raise
				end
			end
		else
				ngantts  = [{}]
		end
		return ngantts
  end
	def vproc_set_dummy_process(n0,starttime)  ### 保管場所(pordessseq==999))しかマスターにない。仮の作業、発注先を作成
		ngantts = []  ###viewの内容なので　itm_id  loca_id
		mlevel = n0[:mlevel] + 1
		ngantts << {:seq=>n0[:seq] + sprintf("%03d", 1),:mlevel=>mlevel,:itms_id=>n0[:itms_id],
				:prdpurshp=>"dym",
				:processseq=>0,
				:locas_id=> 0,
				:locas_id_to=>n0[:locas_id],
				:opeitms_id =>0,:shelfnos_id=>0,:shuffleflg=>nil,
				:priority=>0,
				:duedate=>starttime,:duration=>1,
				:consumtype=>nil,:consumauto=>nil,
				:autocreate_ord=>nil,:autoord_p=>nil,
				:autocreate_inst=>nil,:autocreate_act=>nil,
				:parenum=>1,:chilnum=>1,:id=>"nditms_dym_" + n0[:opeitms_id].to_s + "1"}  ###
	end
  def vproc_get_pare_itms(n0,duedate)  ###
		strsql = "select * from nditms where itms_id_nditm = #{n0[:itms_id]} and locas_id_nditm = #{n0[:locas_id]} and processseq_nditm = #{n0[:processseq]} and Expiredate > current_date  "
		nditms = ActiveRecord::Base.connection.select_all(strsql)
		if nditms.size > 0 then
			ngantts = []  ###viewの内容なので　itm_id  loca_id
			mlevel = n0[:mlevel] + 1
			nditms.each.with_index(1)  do |i,cnt|
				ope = ActiveRecord::Base.connection.select_one("select * from opeitms where id = #{i["opeitms_id"]} ")
				if ope
				    np= {:parenum => i["chilnum"],:chilnum => i["parenum"],:prdpurshp => ope["prdpurshp"],:consumtype => i["nditm_consumtype"],
							:consumauto => i["nditm_consumauto"],:opeitms_id => i["opeitms_id"],
							:itms_id => ope["itms_id"],:locas_id => ope["locas_id"],:processseq=>ope["processseq"],:priority=>ope["priority"],
							:seq=>n0[:seq] + sprintf("%03d", cnt),:mlevel=>mlevel,:level=>1,
							:starttime=>duedate,:duration=>(i["duration"]||=1),:duedate=> proc_get_starttime(n0[:duedate] ,(i["duration"]||=1)*-1,"day",nil),
							:id=>"nditms_"+i["id"].to_s}  ###
					ngantts << np
			   else
					Rails.logger.debug "logic error opeitms missing  line :#{__LINE_} select * from opeitms where id = #{i["opeitms_id"]} "
					@errmsg =  "logic error opeitms missing  line :#{__LINE_} select * from opeitms where id = #{i["opeitms_id"]} "
					raise
			   end
			end
		else
			ngantts  = [{}]
		end
		return ngantts
  end
	###def vproc_get_ope_id_priority(i,n0)
	### 	strsql = "select id,priority,locas_id from opeitms where itms_id = #{i["itms_id_nditm"]} and locas_id = #{i["locas_id_nditm"]} and processseq = #{i["processseq_nditm"]} and priority = #{n0[:priority]} "
	###		ActiveRecord::Base.connection.select_one(strsql)
	###end
  def vproc_get_prev_process(n0,starttime)  ###工程の始まり=前程の終わり
      rec = ActiveRecord::Base.connection.select_one("select * from opeitms where itms_id = #{n0[:itms_id]} and Expiredate > current_date
																			and Priority = #{n0[:priority]} and processseq < #{n0[:processseq]}  order by   processseq desc")
      if rec
	       ngantts = []
				ngantts << {:seq=>(n0[:seq] + "000"),:mlevel=>n0[:mlevel]+1,:itms_id=>rec["itms_id"],:locas_id=>rec["locas_id"],:opeitms_id=>rec["id"],
							:locas_id_to=>n0[:locas_id],:shelfnos_id=>rec["shelfnos_id"],:shuffleflg=>rec["shuffleflg"],
							:duedate=>starttime,:prdpurshp=>rec["prdpurshp"],:duration=>(rec["duration"]||=1),
							:parenum=>rec["parenum"],:chilnum=>rec["chilnum"],
							:autocreate_ord=>rec["autocreate_ord"],:autocreate_inst=>rec["autocreate_inst"],
							:autoord_p=>rec["autoord_p"],
							:consumtype=>rec["consumtype"],:consumauto=>n0[:consumauto],
							:safestkqty=>rec["safestkqty"],:id=>"opeitms_"+rec["id"].to_s,:priority=>rec["priority"],:processseq=>rec["processseq"],
							:starttime => proc_get_starttime(starttime ,(rec["duration"]||=1),"day",nil)}  ###基準日　期間　タイプ　休日考慮
		else
          ngantts = [{}]
      end
      return ngantts
  end
  def vproc_get_after_process(n0,duedate)  ###工程の始まり=前程の終わり
      rec = ActiveRecord::Base.connection.select_one("select * from opeitms where itms_id = #{n0[:itms_id]} and Expiredate > current_date
																			and Priority = #{n0[:priority]} and processseq > #{n0[:processseq]}  order by   processseq ")
      if rec
	       ngantts = []
           ngantts << {:seq=>(n0[:seq] + "000"),:mlevel=>n0[:mlevel]+1,:itms_id=>rec["itms_id"],:locas_id=>rec["locas_id"],:opeitms_id=>rec["id"],
		   :locas_id_to=>n0[:locas_id],:prdpurshp=>rec["prdpurshp"],:duedate=>proc_get_starttime(duedate,(rec["duration"]||=1)*-1,"day",nil),
		   :duration=>(rec["duration"]||=1),:parenum=>rec["parenum"],:chilnum=>rec["chilnum"],:shelfnos_id=>rec["shelfnos_id"],:shuffleflg=>rec["shuffleflg"],
		   :autocreate_ord=>rec["autocreate_ord"],:autocreate_inst=>rec["autocreate_inst"],:autoord_p=>rec["autoord_p"],
		   :safestkqty=>rec["safestkqty"],:id=>"opeitms_"+rec["id"].to_s,:priority=>rec["priority"],:processseq=>rec["processseq"],
            :starttime => duedate } ##基準日　期間　タイプ　休日考慮
		else
          ngantts = [{}]
      end
      return ngantts
    end
  def sub_cal_date(locas_id,ops_loca_id,dueday)
        dueday
  end

  def  sub_get_bilcode(locas_id_custs)
         locas_id_custs
  end

  def  sub_get_pay_incomming_day(locas_id,dueday)
         dueday
  end
  def sub_get_to_locaid(custord_loca_id,itms_id)
        custord_loca_id
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
  def proc_get_dealers_id_fm_locas_id  locas_id
	    locas_id ||= 0
	    dealers_id = ActiveRecord::Base.connection.select_value("select id from dealers where locas_id_dealer = #{locas_id} ")
		if dealers_id.nil?
	       Rails.logger.debug "err logic err?  locas_id:#{locas_id}"
		   raise
	    end
	    return dealers_id
	end
  def sub_get_locas_id_fm_dealers_id  dealers_id
	    locas_id = ActiveRecord::Base.connection.select_value("select locas_id_dealer from dealers where id = #{dealers_id} ")
		if locas_id.nil?
	       p "err logic err?  dealers_id:#{dealers_id}"
		   raise
	    end
	    return locas_id
	end

  def proc_get_opeitms_rec itms_id,locas_id,processseq = nil,priority = nil  ###
		strsql = %Q& select * from opeitms where itms_id = #{itms_id} #{if locas_id then " and locas_id = " + locas_id.to_s else "" end}
		           and processseq = #{processseq ||= 999}
				   #{if priority then " and priority = " + priority.to_s else "" end}
				   and expiredate > current_date &
		rec = ActiveRecord::Base.connection.select_one(strsql)
        if rec
	        rec
		  else
            Rails.logger.debug "error class logic err proc_get_opeitms_rec itms_id = #{itms_id} ,locas_id = #{locas_id}, processseq = #{processseq ||= 999} ,
					priority = = #{priority ||= 999} ,expiredate > #{Date.today}"
            raise
        end
  end
  def proc_get_chrgperson_fm_loca locas_id,prdpurshp
      case prdpurshp
			when "pur"
	           strsql = "select * from dealers where locas_id_dealer = #{locas_id} and expiredate > current_date"
			else
			   strsql = "select * from asstwhs where locas_id_asstwh = #{locas_id} and expiredate > current_date"
	    end
      chrgperson = ActiveRecord::Base.connection.select_one(strsql)
	    if chrgperson
				chrgperson_id = chrgperson["chrgpersons_id_dflt"]
			else
				chrgperson = ActiveRecord::Base.connection.select_one("select * from r_chrgs where person_code =  'dummy'")
				if chrgperson
					chrgperson_id = chrgperson["id"]
				else
					Rails.logger.debug " proc_get_chrgperson_fm_loca  chrgpersons dummy code missing "
					raise
				end
	    end
	    return chrgperson_id
  end
  def proc_get_tree_pare_itms_locas ngantts,gantt_reverse ### bgantt 表示内容　ngantt treeスタック  itms_idは必須
      n0 = ngantts.shift
	    if n0.size > 0  ###子部品がいなかったとき{}になる。
				case gantt_reverse
				when /gantt/
					starttime,duedate = proc_get_item_loca_contents(n0,gantt_reverse)
					tmp = vproc_get_chil_itms(n0,starttime)
					ngantts.concat(tmp) if tmp[0].size > 0
					tmpx = vproc_get_prev_process(n0,starttime)
					if tmpx[0].size > 0
							ngantts.concat(tmpx)
					else
							if tmp[0].size == 0 and n0[:processseq] == 999 and n0[:consumtype] == "con"
								tmp = vproc_set_dummy_process(n0,starttime)
								ngantts.concat(tmp)
							end
					end
				when /reverse/
					starttime,duedate = proc_get_item_loca_contents(n0,gantt_reverse)
					tmp = vproc_get_pare_itms(n0,duedate)
					ngantts.concat(tmp) if tmp[0].size > 0
					tmp = vproc_get_after_process(n0,duedate)
					ngantts.concat(tmp) if tmp[0].size > 0
				end
	    end
        return ngantts
    end  ##

    def proc_get_item_loca_contents(n0,gantt_reverse)   ##n0[:itms_id] r0[:itms_id]
	    qty = if n0[:seq].size > 4 then (@bgantts[n0[:seq][0..-4]][:qty] ||= 1) else  (@bgantts["000"][:qty] ||= 1) end
	    new_qty = qty.to_f / (n0[:parenum]||=1) * (n0[:chilnum]||=1)
		###:autocreate_ord,:autocreate_instは画面にはセットしない。
		if gantt_reverse =~ /mst$/
			itm = ActiveRecord::Base.connection.select_one("select * from itms where id = #{n0[:itms_id]}  ")
			loca = ActiveRecord::Base.connection.select_one("select * from locas where id = #{n0[:locas_id]}  ")
			bgantt = {:mlevel=>n0[:mlevel],:itm_code=>itm["code"], :itm_name=>itm["name"],:loca_code=>loca["code"],:loca_name=>loca["name"],
								:duration=>(n0[:duration]||=1),:depends=>"",:shelfnos_id=>n0[:shelfnos_id],:shuffleflg=>n0[:shuffleflg],
								 :parenum=>n0[:parenum]||=1,:chilnum=>n0[:chilnum]||=1,:prdpurshp=>n0[:prdpurshp],
								 :consumtype=>n0[:consumtype],:consumauto=>n0[:consumauto],
                                 :id=>n0[:id],:itms_id=>n0[:itms_id],:locas_id=>n0[:locas_id],
								:autocreate_ord=>n0[:autocreate_ord],:autoord_p=>n0[:autoord_p],:autocreate_inst=>n0[:autocreate_inst],
								:processseq=>n0[:processseq],:priority=>n0[:priority],:qty=>new_qty,:qty_src=>new_qty,:qty_stk=>0,
								:opeitms_id => n0[:opeitms_id]}
		else  ###trngantts insert 用
			bgantt = {:mlevel=>n0[:mlevel],###:itm_code=>itm["code"], :itm_name=>itm["name"],:loca_code=>loca["code"],:loca_name=>loca["name"],
								:duration=>(n0[:duration]||=1),:depends=>"",
								 :parenum=>n0[:parenum]||=1,:chilnum=>n0[:chilnum]||=1,:prdpurshp=>n0[:prdpurshp],
								 :consumtype=>n0[:consumtype],:consumauto=>n0[:consumauto],:shelfnos_id=>n0[:shelfnos_id],:shuffleflg=>n0[:shuffleflg],
                                 :id=>n0[:id],:itms_id=>n0[:itms_id],:locas_id=>n0[:locas_id],
								:autocreate_ord=>n0[:autocreate_ord],:autoord_p=>n0[:autoord_p],:autocreate_inst=>n0[:autocreate_inst],
								:processseq=>n0[:processseq],:priority=>n0[:priority],:qty=>new_qty,:qty_src=>new_qty,:qty_stk=>0}
		end
		 case gantt_reverse
			when /gantt/
				cgantt = {:duedate=>n0[:duedate],:duedate_est=>n0[:duedate],
									:starttime=>proc_get_starttime(n0[:duedate],(n0[:duration]||=1),"day",nil),
									:starttime_est=>proc_get_starttime(n0[:duedate],(n0[:duration]||=1),"day",nil)}
			when /reverse/
				cgantt = {:starttime=>n0[:starttime],:starttime_est=>n0[:starttime],
									:duedate=>proc_get_starttime(n0[:starttime],(n0[:duration]||=1)*-1,"day",nil),
									:duedate_est=>proc_get_starttime(n0[:starttime],(n0[:duration]||=1)*-1,"day",nil)}
		 end
        bgantt.merge! cgantt
		@bgantts[n0[:seq]] = bgantt
	    @min_time = cgantt[:starttime] if (@min_time||="2099/12/31".to_time) > cgantt[:starttime]
		@max_time = cgantt[:duedate] if (@max_time||=Time.now)  < cgantt[:duedate]
        return cgantt[:starttime],cgantt[:duedate]
    end
    def prv_resch_trn   ##本日を起点に再計算
        dp_id = 0
        @bgantts.sort.each  do|key,value|    ###set depends
            if key.to_s.size > 3 then
                @bgantts[key[0..-4]][:depends] << dp_id.to_s + ","
				@bgantts[key[0..-4]][:duration] = 0  if @bgantts[key[0..-4]][:itm_id] != @bgantts[key][:itm_id]
            end
            dp_id += 1
        end

        today = Time.now
        @bgantts.sort.reverse.each  do|key,value|  ###計算
		    if key.size > 3
                if  value[:depends] == ""
		    	    if @bgantts[key][:starttime_est]  <  today
                       @bgantts[key][:starttime_est]  =  today
                       @bgantts[key][:duedate_est]  =   proc_get_starttime(@bgantts[key][:starttime_est], (value[:duration]||=1)*-1,"day",nil)    ###稼働日考慮今なし
                    end
			    end
                if  (@bgantts[key[0..-4]][:starttime_est] ) < @bgantts[key][:duedate_est]
                    @bgantts[key[0..-4]][:starttime_est]  =   @bgantts[key][:duedate_est]   ###稼働日考慮今なし
                    @bgantts[key[0..-4]][:duedate_est] =  proc_get_starttime(@bgantts[key[0..-4]][:starttime_est],@bgantts[key[0..-4]][:duration]*-1,"day",nil)
				    ##p key
				    ##p @bgantts[key]
			    end
            end
        end
        @bgantts.sort.each  do|key,value|  ###topから再計算
		    if key.size > 3
                if  (@bgantts[key[0..-4]][:starttime_est]  ) > @bgantts[key][:duedate_est]
                      @bgantts[key][:duedate_est]  =   @bgantts[key[0..-4]][:starttime_est]    ###稼働日考慮今なし
                      @bgantts[key][:starttime_est] =  proc_get_starttime(@bgantts[key][:duedate_est],(value[:duration]||=1) ,"day",nil)
                end
            end
        end
        return
    end
  def proc_tblinks command_c
			if command_c[:sio_code] !~ /blktbs/ and command_c[:sio_code] !~ /tblink/
				strsql = " select * from r_tblinks where pobject_code_scr_src = '#{command_c[:sio_code]}' and tblink_expiredate > current_date "
				strsql << " and tblink_beforeafter = '#{yield}' order by tblink_seqno "
				do_all = ActiveRecord::Base.connection.select_all(strsql)
				do_all.each do |dorec|
					if respond_to?(dorec["tblink_codel"])
						__send__(dorec["tblink_codel"],eval(dorec["tblink_hikisu"]))
					else
						proc_crt_def_rubycode({"codel"=> dorec["tblink_codel"],"hikisu"=>dorec["tblink_hikisu"],"rubycode"=>dorec["tblink_rubycode"]})
						__send__(dorec["tblink_codel"],eval(dorec["tblink_hikisu"]))
					end
				end
			end
	end
	def proc_set_src_tbl rec  ##rec["xxxxx"]
  		@src_tbl = {}   ###テーブル更新
		tblnamechop = rec[:sio_viewname].split("_",2)[1].chop
        rec.each do |j,k|
          j_to_stbl,j_to_sfld = j.to_s.split("_",2)
			if   j_to_stbl == tblnamechop  and 
					j_to_sfld != "code_upd" and  j_to_sfld != "name_upd"   and  j_to_sfld != "id_upd"##本体の更新
			    if  k
	              @src_tbl[j_to_sfld.sub("_id","s_id").to_sym] = k
                  @src_tbl[j_to_sfld.to_sym] = nil  if k  == "\#{nil}"  ##
				end
            end   ## if j_to_s.
        end ## rec.each
        @src_tbl[:persons_id_upd] = rec["#{tblnamechop}_person_id_upd"] = @sio_user_code
        @src_tbl[:updated_at] = rec["#{tblnamechop}_updated_at"] = Time.now
		if rec[:sio_classname] =~ /_add_/
			@src_tbl[:created_at] =  rec["#{tblnamechop}_created_at"] = Time.now
			rec["id"] = @src_tbl[:id] = proc_get_nextval("#{tblnamechop}s_seq")
		end	
		return rec
	end
	def proc_save_rec_btch_sub rec
		tmp = {}
		tblnamechop = rec[:sio_viewname].split("_")[1].chop
		rec.each do |key,val|
			if  key.to_s =~ /_id/ and val
				screenchop,tbl,filler = key.to_s.split("_",3)
				if filler
					delm = "_" + key.to_s.split("_id",2)[1]
				else
					delm = ""
				end
				if tblnamechop == screenchop  and tbl != "id" ###  a
					if tbl == "person"
						if @person_rec
							if @person_rec["id"] = val
								trec = @person_rec
							else
								@person_rec = trec = ActiveRecord::Base.connection.select_one("select * from #{"r_" + tbl + "s"} where id = #{val}")
							end
						else
							@person_rec = trec = ActiveRecord::Base.connection.select_one("select * from #{"r_" + tbl + "s"} where id = #{val}")
						end
					else
						trec = ActiveRecord::Base.connection.select_one("select * from #{"r_" + tbl + "s"} where id = #{val}")
					end
					if trec.nil?  ###logic error
						Rails.logger.debug " logic error rec = #{rec} "
						Rails.logger.debug " key = '#{key}' val = #{val} "
						raise
					end
					trec.each do |reckey,recval|
						tmp[reckey+delm] = recval if recval and reckey != "id"
					end
				end
			end
		end
		show_data = get_show_data(rec[:sio_code]||=rec["sio_code"])
		show_data[:allfields].each  do |fld|  ###必要項目のみセット
			rec[fld.to_s] = tmp[fld]  if tmp[fld]
		end
		return rec
	end
	def proc_save_rec_btch rec
			if @rec_save
				if @rec_save["sio_code"] == rec["sio_code"] and @rec_save["id"] == rec["id"]
					return @rec_save
				else
					@rec_save = proc_save_rec_btch_sub rec
				end
			else
				@rec_save = proc_save_rec_btch_sub rec
			end
			return @rec_save
	end
  def proc_command_before_instance_variable rec
	    if @pare_class == "batch"  ###delayjobからだと必要データが来ない。
				proc_command_instance_variable(proc_save_rec_btch(rec))
			else
				proc_command_instance_variable rec
	    end
  end
  def proc_command_after_instance_variable rec
	    if @pare_class == "batch"  ###delayjobからだと必要データが来ない。
				proc_command_instance_variable(proc_save_rec_btch(rec))
			else
				proc_command_instance_variable rec
			end
  end
	def proc_command_instance_variable rec ###@xxxxの作成
	    str = ""
        rec.each do |key,val|
	        case
		        when key == "rubycoding_rubycode"
	                @rubycoding_rubycode = val
		        when key == "button_onclickbutton"
	                @button_onclickbutton = val
		        when val.class == String
	                str << %Q%@#{key} = "#{val.gsub('"','\"')}"\n%
		        when val.class == Date
	                str << "@#{key} = %Q%#{val}%.to_date\n"
		        when val.class == Time
	                str << "@#{key} = %Q%#{val}%.to_time\n"
		        when val.class == NilClass
	                str << "@#{key} = nil\n"
		        else
	                str << "@#{key} = #{val}\n"
	        end
	    end
	    eval(str)
	end
    def undefined
      nil
    end
    def get_screen_code params
        case
            when params[:sid]  ##disp  
               screen_code = (params[:sid].split('_div_')[1]||= params[:sid])   ##子画面
            when params[:nst_tbl_val]
               screen_code =  params[:nst_tbl_val].split("_div_")[1]  ###chil_screen_code
		    when params[:dump]  ### import by excel
               screen_code =  params[:dump][:screen_code]
		end
		return screen_code
    end
    def crt_def_all
        eval("def dummy_def \n end")
		begin
			crt_defs = ActiveRecord::Base.connection.select_all("select * from rubycodings where expiredate > current_date")
			crt_defs.each do |src_tbl|
				vproc_crt_def_rubycode src_tbl
			end
			proc_create_tblinkfld_def
			crt_defs = ActiveRecord::Base.connection.select_all("select * from tblinks where expiredate > current_date")
			crt_defs.each do |src_tbl|
				vproc_crt_def_rubycode src_tbl
			end
		rescue
			if self.to_s != "main"
				Rails.logger.debug" error class #{self} #{Time.now}:  $@: #{$@} "
				Rails.logger.debug"  error class #{self} :  $!: #{$!} "
			else
				p " error class #{self} #{Time.now}:  $@: #{$@} "
				p "  error class #{self} :  $!: #{$!} "
			end
		end
	end
    def vproc_crt_def_rubycode src_tbl
		strdef = "def #{src_tbl["codel"]}  #{src_tbl["hikisu"]} \n"
		strdef << src_tbl["rubycode"]
	    strdef <<"\n end"
		if self.to_s != "main"
			Rails.logger.debug strdef
		else
			p strdef[0..50]
		end
	    eval(strdef)
    end
	def proc_crt_def_tblink codel
		src_tbl  = ActiveRecord::Base.connection.select_one("select * from tblinks where codel = '#{codel}' and expiredate > current_date")
		proc_crt_def_rubycode(src_tbl)
	end
    def proc_crt_def_rubycode(src_tbl)
		strdef = "def #{src_tbl["codel"]}  #{src_tbl["hikisu"]} \n"
		strdef << src_tbl["rubycode"]
		strdef <<"\n end"
		if self.to_s != "main"
			Rails.logger.debug strdef
		else
			p strdef[0..50]
		end
		eval(strdef)
		proc_create_tblinkfld_def do
		 " and tblink_codel = '#{src_tbl["codel"]}' "
		end
    end
	def str_init_command_c tbl_dest
	    %Q%
		command_c = {}.with_indifferent_access
		command_c[:sio_session_counter] =   @new_sio_session_counter
		command_c[:sio_recordcount] = 1
		command_c[:sio_user_code] =   @sio_user_code
		command_c[:sio_code] = command_c[:sio_viewname] = @sio_code = "#{tbl_dest}"
		command_c.merge!(yield) if block_given?
		%
	end
	def proc_simple_sio_insert command_c
        ### @src_tbl作成はproc_update_tableで実施
		proc_update_table proc_insert_sio_c(command_c),1
		#####proc_command_c_to_instance command_c  ###@xxxx_yyyy作成
	end
	def str_sio_set tblchop
		%Q%
		command_c[:sio_classname] = (@#{tblchop}_classname ||= @sio_classname)
		proc_simple_sio_insert command_c
	    end
		%
	end
    def proc_create_tblinkfld_def
		strsql = " select * from r_tblinkflds where tblinkfld_expiredate > current_date "
		if block_given?
			strsql << yield
		end
		strsql << " order by pobject_code_scr_src,pobject_code_tbl_dest,tblink_beforeafter,tblink_seqno,tblinkfld_seqno "
	    recs = ActiveRecord::Base.connection.select_all(strsql)
		streval = nil
		tblchop = ""
		src_screen = ""
		beforeafter = ""
		seqno = ""
	    recs.each do |rec|
			if src_screen != rec["pobject_code_scr_src"] or 	tblchop != rec["pobject_code_tbl_dest"].chop or
					beforeafter != rec["tblink_beforeafter"] or seqno != rec["tblink_seqno"]
					if streval
						streval << str_sio_set(tblchop)
						if self.to_s != "main"
							Rails.logger.debug streval
						else
							p streval[0..50]
						end
						eval(streval)
					end
					src_screen = rec["pobject_code_scr_src"]
					tblchop = rec["pobject_code_tbl_dest"].chop
					beforeafter = rec["tblink_beforeafter"]
					seqno = rec["tblink_seqno"]
					streval = "def proc_fld_#{src_screen}_#{tblchop}s_#{beforeafter+seqno.to_s}\n"
					p streval
					streval << str_init_command_c("r_#{rec["pobject_code_tbl_dest"]}")
			end
			if  rec["pobject_code_fld"] =~ /s_id/   ###tblchop==delm ###ヘッダーと同じものは除く crttblviewscreen
				fld = tblchop + "_" + rec["pobject_code_fld"].sub("s_id","_id")
			else
				fld = tblchop+"_"+rec["pobject_code_fld"]
			end
			if rec["tblinkfld_rubycode"] and rec["tblinkfld_rubycode"] != "undefined"
					streval << %Q&\n	command_c[:#{fld}] = #{rec["tblinkfld_rubycode"]} 	&
			else
				str = vproc_tblinkfld_dflt_set_fm_rubycoding(fld)
				if str
					streval << %Q&\n command_c[:#{fld}] = #{str} 	&
				end
			end
			if  rec["pobject_code_fld"] =~ /s_id/
				streval << %Q&\n 	command_c[:#{fld}] = "missing id #{fld}"  if command_c[:#{fld}].nil?  &  	###_id項目は必須
			end
	    end ##
		if recs.size > 0
		    streval << %Q&\n command_c[(command_c[:sio_viewname].split("_")[1].chop+"_id").to_sym] = command_c[:id] &
			streval << str_sio_set(tblchop)
			if self.to_s != "main"
				Rails.logger.debug streval
			else
				p streval[0..50]
			end
			eval(streval)
		end
    end
	def vproc_tblinkfld_dflt_set_fm_rubycoding fld
		dflt_rubycode = nil
		strsql = %Q& select * from r_rubycodings where pobject_objecttype = 'view_field' 	and  pobject_code = '#{fld}'
							and rubycoding_codel like '%dflt_for_tbl_set' &
		rubycode_view = ActiveRecord::Base.connection.select_one(strsql)
		if rubycode_view
			dflt_rubycode = rubycode_view["rubycoding_codel"] + " " +(rubycode_view["rubycoding_hikisu"]||="" )
		else
			fld_tbl = fld.split("_",2)[1]
			strsql = %Q& select * from r_rubycodings where pobject_objecttype = 'tbl_field' 	and  pobject_code = '#{fld_tbl}'
					and rubycoding_codel like '%dflt_for_tbl_set' &
			rubycode_tbl = ActiveRecord::Base.connection.select_one(strsql)
			if rubycode_tbl
				dflt_rubycode = rubycode_tbl["rubycoding_codel"] + " " + (rubycode_tbl["rubycoding_hikisu"]||="")
			end
		end
		return dflt_rubycode
	end
    def proc_set_fields_from_allfields params ## value ###画面の内容をcommand_rへ ###typeの変換を
        command_c = params.dup
	    command_c[:sio_code]  = screen_code
		char_to_number_data command_c
	        ## nilは params[j] にセットされない。
			### 下記の変換が未実施
			###  1 (params == String ,command_c=float or integer
    end
	def init_from_screen current_user,params  ###
		@sio_user_code = ActiveRecord::Base.connection.select_value("select id from persons where email = '#{current_user[:email]}'")
		command_c = {}
		#command_c[:sio_user_code] = @sio_user_code  ###########   LOGIN USER
		#command_c[:sio_email] = current_user[:email]
	 	#command_c[:sio_code]  = params[:screenCode]
		#command_c[:sio_params] = params.to_json.to_s[0..3999]
		return command_c
	end
	
	def create_grid_columns_info screen_code,email
			grid_columns_info = Rails.cache.fetch('screenfield'+RorBlkctl.grp_code(email)+screen_code) do
        	###  ダブルコーティション　「"」は使用できない。 
        	sqlstr = "select * from  func_get_screenfield_grpname('#{email}','#{screen_code}')"
				columns_info = []
				page_info = {}
				where_info = {}
				select_fields = ""
				ActiveRecord::Base.connection.select_all(sqlstr).each_with_index do |i,cnt|
							columns_info <<{:Header=>i["screenfield_name"],
													:accessor=>i["pobject_code_sfd"],
													:show=>if  i["screenfield_hideflg"] == "0" then true else false end,
												##	:filterable=>i["screenfield_hideflg"] 
													}
					select_fields = 	select_fields + 		i["pobject_code_sfd"] + ','
          if cnt == 0
                	where_info[:filtered] = i["screen_strwhere"]
                	page_info[:sizePerPage] = i["screen_rows_per_page"].to_i
                	page_info[:pageNo] = 1
									page_info[:sizePerPageList] = []
									i["screen_rowlist"].split(",").each do |list|
										##screen_prop[:sizePerPageList]  << {:text=> list.to_s,:value=> list.to_i}
										page_info[:sizePerPageList]  <<  list.to_i
									end
       		end
				end
				grid_columns_info = [columns_info,page_info,where_info,select_fields.chop]
			end
	end
	
	def create_grid_editable_columns_info screen_code,email,req
		grid_columns_info = Rails.cache.fetch('screenfield'+RorBlkctl.grp_code(email)+screen_code) do
				###  ダブルコーティション　「"」は使用できない。 
				sqlstr = "select * from  func_get_screenfield_grpname('#{email}','#{screen_code}')"
			columns_info = []
			page_info = {}
			where_info = {}
			select_fields = ""
			if (req==='editabletablereq' )

				columns_info << {:Header=>"confirm",
									:accessor=>"confirm",
									:show=>true,
									:filtered=>false,
									:id=>"",
									:className=>"checkbox"
									}
			end		
			ActiveRecord::Base.connection.select_all(sqlstr).each_with_index do |i,cnt|
				case  i["screenfield_type"] 
					when  'numeric'
					when 'date'
					when 'timestamp'
						 ##renderer
				end	
				columns_info <<{:Header=>"#{i["screenfield_name"]}",
												:accessor=>"#{i["pobject_code_sfd"]}",
												:show=>if  i["screenfield_hideflg"] == "0" then true else false end,
												:filtered=>true,
												:id=>"#{i["screenfield_id"]}",
												:className=>if ((req==="editabletablereq" or req==="inlineaddreq") and 
																		  (i["screenfield_editable"] === "1" or i["screenfield_editable"] === "2"))
																	if	(i["screenfield_indisp"] === "1" or i["screenfield_indisp"] === "2")
																			"renderEditableRequired"
																	else
																			"renderEditable"
																	end			  
															else	
																"renderNonEditable"
															end	
									}
				where_info[i["pobject_code_sfd"].to_sym] = 	i["screenfield_type"]								
				select_fields = 	select_fields + 	i["pobject_code_sfd"] + ','
				if cnt == 0
								where_info[:filtered] = i["screen_strwhere"]
								page_info[:sizePerPage] = i["screen_rows_per_page"].to_i
								page_info[:pageNo] = 1
								page_info[:sizePerPageList] = []
								i["screen_rowlist"].split(",").each do |list|
									page_info[:sizePerPageList]  <<  list.to_i
								end
				 end
			end
			if (req==='editabletablereq' or req==="inlineaddreq")

				yup = YupSchema.create_yupfetchcode screen_code

				columns_info << {:Header=>"gridmessage",
									:accessor=>"gridmessage",
									:show=>false,
									:filtered=>false,
									:className=>"renderNonEditable",
									:id=>""
									}
			end		
			if (req==="inlineaddreq")
				columns_info << {:Header=>"confirm",
									:accessor=>"confirm",
									:show=>true,
									:filtered=>false,
									:id=>"",
									:className=>"checkbox"
									}
			end		
			grid_columns_info = [columns_info,page_info,where_info,select_fields.chop,yup]
		end
	end
	
	def create_download_columns_info screen_code,email
		download_columns_info = Rails.cache.fetch('download'+RorBlkctl.grp_code(email)+screen_code) do
				###  ダブルコーティション　「"」は使用できない。 
			sqlstr = "select * from  func_get_screenfield_grpname('#{email}','#{screen_code}')"
			columns_info = []
			where_info = {}
			select_fields = ""	
			ActiveRecord::Base.connection.select_all(sqlstr).each_with_index do |i,cnt|
				if cnt == 0
								where_info[:filtered] = i["screen_strwhere"]
				end
				if i["screenfield_hideflg"] == "0"
					case  i["screenfield_type"] 
						when  'numeric'
						when 'date'
						when 'timestamp'
						 ##renderer
					end	
					columns_info <<%Q%{"label":"#{i["screenfield_name"]}","value":"#{i["pobject_code_sfd"]}"}%
					where_info[i["pobject_code_sfd"].to_sym] = 	i["screenfield_type"]								
					select_fields = 	select_fields + 	i["pobject_code_sfd"] + ','
				end	
			end
			download_columns_info = [columns_info,where_info,select_fields.chop]
		end
	end
	def get_fetch_rec params
			strsql = ""
			mainviewflg = true  ##自分自身の登録か？
			keys = ""
			fetchview = params["fetchview"].split(":")[0]  ##拡張子の確認
			tblnamechop = fetchview.split("_")[1].chop
			strsql = " select * from #{fetchview} where "
			JSON.parse(params["fetchcode"]).each do |key,val|
					if params["screenCode"].split("_")[1].chop != key.to_s.split("_")[0]
						mainviewflg = false
					end	 
			end	
			screendata = JSON.parse(params["resolvedData"])
			fetcfieldgetsql = "select pobject_code_sfd from r_screenfields
								 where pobject_code_scr =  '#{params["screenCode"]}' 
								 and screenfield_paragraph = '#{params["fetchview"]}'"	
			delm = (params["fetchview"].split(":")[1]||="")
			ActiveRecord::Base.connection.select_all(fetcfieldgetsql).each do |rec|
				if delm == ""
					strsql << "  #{rec["pobject_code_sfd"]} = '#{screendata[rec["pobject_code_sfd"]]}'    and"
				else
					strsql << "  #{rec["pobject_code_sfd"].split(delm)[0]} = '#{screendata[rec["pobject_code_sfd"]]}'    and"
				end		
				keys <<  "  #{rec["pobject_code_sfd"]} : '#{screendata[rec["pobject_code_sfd"]]}',"
            end
			rec =  ActiveRecord::Base.connection.select_one(strsql[0..-4])	
			fetch_data = {}
			if rec
				screendata.each do |key,val|  ###結果をセット
						if rec[key] and key !="id" and key !~ /person.*upd/
							 fetch_data[key+delm] =  rec[key]
						end
				end	
				fetch_data[params["screenCode"].split("_")[1].chop+"_"+tblnamechop+"_id"+delm] =  rec["id"]
			end			
			return fetch_data,mainviewflg,keys
	end	

	def proc_get_nextval tbl_seq
		ActiveRecord::Base.uncached() do
			case ActiveRecord::Base.configurations[Rails.env]['adapter']
				when /post/
					ActiveRecord::Base.connection.select_value("SELECT nextval('#{tbl_seq}')")  ##post
				when /oracle/
					ActiveRecord::Base.connection.select_value("select #{tbl_seq}.nextval from dual")  ##oracle
			end
		end
	end

	def proc_blk_columns tblname
		columns = {}
		case ActiveRecord::Base.configurations[Rails.env]['adapter']
			when /post/
				ActiveRecord::Base.connection.select_all("SELECT attname, typname FROM pg_class, pg_attribute, pg_type WHERE   relkind     = 'r'
												AND relname     ='テーブル名' AND attrelid    = (select relid from pg_stat_all_tables where relname = 'テーブル名')
												AND attnum      > 0    AND pg_type.oid = atttypid;")  ##post
			when /oracle/
				recs = ActiveRecord::Base.connection.select_all("select * from user_tab_columns where  table_name = '#{tblname.upcase}'")  ##oracle
				recs.each do |rec|
					columns[rec["column_name"].downcase] = {:data_type=>rec["data_type"],:data_precision=>rec["data_precision"],:data_scale=>rec["data_scale"],:char_length=>rec["char_length"]}
				end
		end
		return columns
	end
	def proc_get_trg_view_fm_tblname_tblid tblname,srctblname,srctblid  ##レコードが見つからなかったときの処理は親ですること。
		if block_given?
			rec = ActiveRecord::Base.connection.select_one("select * from r_#{tblname} where #{tblname.chop}_tblname = '#{srctblname}' and #{tblname.chop}_tblid = #{srctblid} #{yield}")
		else
			rec = ActiveRecord::Base.connection.select_one("select * from r_#{tblname} where #{tblname.chop}_tblname = '#{srctblname}' and #{tblname.chop}_tblid = #{srctblid}")
		end
		####id = proc_get_nextval "#{tblname}_seq" if id.nil?
		proc_command_instance_variable(rec)
		return rec.with_indifferent_access if rec
	end
	def proc_get_trg_rec_fm_tblname_tblid tblname,srctblname,srctblid  ##レコードが見つからなかったときの処理は親ですること。
			ActiveRecord::Base.connection.select_one(%Q% select * from #{tblname} where tblname = '#{srctblname}' and tblid = #{srctblid} #{if block_given? then yield else "" end}%)
	end
	def proc_get_trg_rec_id_fm_tblname_tblid tblname,srctblname,srctblid
			rec = proc_get_trg_rec_fm_tblname_tblid(tblname,srctblname,srctblid)
			if rec
				rec["id"]
			else
				nil
			end
	end
	def proc_get_rec_fm_tblname_sno tblname,sno　 ##レコードが見つからなかったときの処理は親ですること。
		rec = {}
		rec = ActiveRecord::Base.connection.select_one("select * from #{tblname} where sno = #{sno}")
		if rec
		else
			rec["id"] = nil
		     ###snoはテーブル毎に必ずユニーク
			 return
		end
		rec.with_indifferent_access if rec
	end

	def proc_get_rec_fm_tblname_yield tblname  ##proc_fld_xxxxの中の項目を求める。　 ##レコードが見つからなかったときの処理は親ですること。
		rec = ActiveRecord::Base.connection.select_one("select * from #{tblname} where expiredate > current_date and #{yield}")
		rec.with_indifferent_access if rec
	end
	def proc_get_rec_fm_viewname_yield viewname  ##proc_fld_xxxxの中の項目を求める。　 ##レコードが見つからなかったときの処理は親ですること。
		rec = ActiveRecord::Base.connection.select_one("select * from #{viewname} where #{viewname.split("_")[1].chop}_expiredate > current_date and #{yield}")
		if rec
		  rec.with_indifferent_access
		else
			nil
		end
	end
	def proc_get_allrecs_fm_tblname_yield tblname  ##proc_fld_xxxxの中の項目を求める。　 ##レコードが見つからなかったときの処理は親ですること。
		 ActiveRecord::Base.connection.select_all("select * from #{tblname} where expiredate > current_date and  #{yield}")
		##### recs.with_indifferent_access
	end
	def proc_get_viewrec_from_id tblname,id  ##  ##レコードが見つからなかったときの処理は親ですること。
		rec = ActiveRecord::Base.connection.select_one("select * from r_#{tblname} where id = #{id}")
		return rec.with_indifferent_access if rec
	end
	def proc_get_tblrec_from_id tblname,id  ##  ##レコードが見つからなかったときの処理は親ですること。
		rec = ActiveRecord::Base.connection.select_one("select * from #{tblname} where id = #{id}")
		return rec.with_indifferent_access if rec
	end
	def proc_get_pare_from_trn_id trn_id  ## inoutsのprocessseq　itms_id_pare  品目違いの親を求める。
		inout = {}
		for ii in 1..5 do
			strsql = " select case when pare.itm_id = trn.itm_id then pare.trngantt_processseq else 999 end processseq,
					pare.itm_id itms_id_pare,trn.itm_id itms_id,pare.trngantt_key key,pare.trngantt_id pare_trn_id, pare.trngantt_processseq  processseq_pare
					from r_trngantts trn,r_trngantts pare
					where trn.trngantt_orgtblname = pare.trngantt_orgtblname and trn.trngantt_orgtblid = pare.trngantt_orgtblid
					and pare.trngantt_key =  case length(trn.trngantt_key)      when 3 then  to_char(trn.trngantt_key  - 1,'000')   else   substr(trn.trngantt_key,1,length(trn.trngantt_key) -3)   end
					and trn.id = #{trn_id} "
			rec = ActiveRecord::Base.connection.select_one(strsql)
			if rec
				inout[:inout_itm_id_pare] = rec["itms_id_pare"]
				inout[:inout_processseq_pare] = rec["processseq_pare"]
				break if rec["itms_id_pare"] != rec["itms_id"]
				break if  rec["key"].size < 4
			else
				rec1 = ActiveRecord::Base.connection.select_one("select itms_id,processseq from trngantts where id = #{trn_id}")
				inout[:inout_itm_id_pare] = rec1["itms_id"]
				inout[:inout_processseq_pare] = rec1["processseq"]
				break
			end
			ii += 1
			trn_id = rec["pare_trn_id"]
		end
		return inout
	end
	def proc_decision_id_by_key(tblname,where)
		strsql = %Q& select * from #{tblname} where #{where} for update &
		rec = ActiveRecord::Base.connection.select_one(strsql)
		eval(%Q& if  rec.nil?
					rec = {}
					rec["id"] =  proc_get_nextval("#{tblname}_seq")
					@#{tblname.chop}_classname = "#{tblname}_add_#{where}"[0..49]
					rec["expiredate"] = "2099/12/31".to_date
					rec["created_at"] = Time.now
				else
					### tbllinksでユニークkey チェックをセットする。　複数レコードはエラー
					@#{tblname.chop}_classname  = "#{tblname}_edit_#{where}"[0..49]
				end &)
		eval(%Q& @#{tblname.chop}_id = rec["id"] &)
		rec["updated_at"] = Time.now
		rec["persons_id_upd"] = (@sio_user_code ||=0)
		return rec
	end
	def proc_decision_all_ids_by_key(tblname,where)
		strsql = %Q& select * from #{tblname} where #{where} for update &
		recs = ActiveRecord::Base.connection.select_all(strsql)
		eval(%Q& if  recs.size == 0
					rec[0] = {"id" =>  proc_get_nextval("#{tblname}_seq")}
					@#{tblname.chop}_classname = "#{tblname}_add_#{where}"[0..49]
				else
					@#{tblname.chop}_classname  = "#{tblname}_edit_#{where}"[0..49]
				end &)
		return recs
	end
	def proc_akakuro
		case yield[:table]
		when nil
			raise
		else
			if yield[:tblname]
				add_field = {}
				rec =  proc_get_trg_rec_fm_tblname_tblid(yield[:table],yield[:tblname],yield[:tblid]) do
	            " order by id desc "
				end
				if rec
	    		rec["id"] =  proc_get_nextval("#{yield[:table]}_seq")
					rec["updated_at"] = Time.now
					if rec["qty"]
						rec["qty"] = rec["qty"] * -1
					end
					if rec["qty_stk"]
						rec["qty_stk"] = rec["qty_stk"] * -1
					end
					proc_tbl_add_arel  yield[:table],rec
				end
			end
		end
	end
	def proc_tbl_add_arel  tblname,tblarel ##
		fields = ""
		values = ""
		tblarel.each do |key,val|
			fields << key.to_s + ","
			values << case val.class.to_s
						when "String"
							%Q&'#{val.gsub("'","''")}',&
						when "Fixnum","Bignum","BigDecimal","Float","Integer"
							"#{val},"
						when "Date"
							%Q& to_date('#{val.strftime("%Y/%m/%d")}','yyyy/mm/dd'),&
						when "Time"
							case key.to_s
							when "created_at","updated_at"
									%Q& to_date('#{val.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),&
							else
									%Q& to_date('#{val.strftime("%Y/%m/%d %H:%M")}','yyyy/mm/dd hh24:mi'),&
							end
						when "DateTime"
							case key.to_s
							when "expiredate"
									%Q& to_date('#{val.strftime("%Y/%m/%d")}','yyyy/mm/dd'),&
							else
								%Q& to_date('#{val.strftime("%Y/%m/%d %H:%M")}','yyyy/mm/dd hh24:mi'),&
							end
						when "NilClass"
							"null,"
						when "Hash"
							"'#{val.to_query}',"
						else
							Rails.logger.debug " line #{__LINE__} : error val.class #{val.class}  key #{key.to_s} "
						end
		end
		case tblname.downcase
		when  /^sio_/
			ActiveRecord::Base.connection.insert("insert into sio.#{tblname.downcase}(#{fields.chop}) values(#{values.chop})")
		when  /^bk_/
			ActiveRecord::Base.connection.insert("insert into bk.#{tblname.downcase}(#{fields.chop}) values(#{values.chop})")
		else
			ActiveRecord::Base.connection.insert("insert into #{tblname.downcase}(#{fields.chop}) values(#{values.chop})")
		end
	end
	def proc_tbl_rec_to_screen_field hash ##
		strset = "{"
		hash.each do |key,val|
			strset << case val.class.to_s 
				when "String"
					%Q& #{key.to_s}: "#{val}",&
				when "Fixnum","Bignum","BigDecimal","Float"
					" #{key.to_s}: #{val.to_s},"
				when "Date"
					%Q&  #{key.to_s}: '#{val.strftime("%Y/%m/%d")}',&
				when "Time"
					case key.to_s
						when /created_at|updated_at/
							%Q&  #{key.to_s}:  '#{val.strftime("%Y/%m/%d %H:%M:%S")}',&
						when /expiredate/
							%Q&  #{key.to_s}: '#{val.strftime("%Y/%m/%d")}',&
						else
							%Q&  #{key.to_s}: '#{val.strftime("%Y/%m/%d %H:%M")}',&
					end
				when "NilClass"
					"  #{key.to_s}: '',"
				else
					Rails.logger.debug " line #{__LINE__} : error val.class #{val.class}  key #{key.to_s} "
					raise
		   end
		end
		return strset.chop + "},"
	end
	def proc_tbl_field_to_screen_field key,val,prop ##
		strset = ""
		strset << case val.class.to_s 
				when "String"
					%Q& #{key.to_s}: "#{val}"&
				when "Fixnum","Bignum","BigDecimal","Float"
					" #{key.to_s}: #{val.to_s}"
					### 小数点編集等
				when "Date"
					%Q&  #{key.to_s}: '#{val.strftime("%Y/%m/%d")}'&
				when "Time"
					case key.to_s
						when /created_at|updated_at/
							%Q&  #{key.to_s}:  '#{val.strftime("%Y/%m/%d %H:%M:%S")}'&
						when /expiredate/
							%Q&  #{key.to_s}: '#{val.strftime("%Y/%m/%d")}'&
						else
							%Q&  #{key.to_s}: '#{val.strftime("%Y/%m/%d %H:%M")}'&
					end
				when "NilClass"
					"  #{key.to_s}: ''"
				else
					Rails.logger.debug " line #{__LINE__} : error val.class #{val.class}  key #{key.to_s} "
					raise
		   		end
		return strset
	end
	def proc_tbl_field_to_screen_field_hash key,val,prop,phach##
		case val.class.to_s 
			when "String"
					phach[key]= val
			when "Fixnum	","Bignum","BigDecimal","Float"
					phach[key]=  val.to_s
					### 小数点編集等
			when "Date"
					phach[key.to_s]= val.strftime("%Y/%m/%d")
			when "Time"
				case key.to_s
					when /created_at|updated_at/
							phach[key]= val.strftime("%Y/%m/%d %H:%M:%S")
					when /expiredate/
							phach[key]= val.strftime("%Y/%m/%d")
					else
							phach[key]= val.strftime("%Y/%m/%d %H:%M")
				end
			when "NilClass"
					phach[key.to_s]= ""
			else
					Rails.logger.debug " line #{__LINE__} : error val.class #{val.class}  key #{key.to_s} "
					raise
		   	end
		return
	end
	def proc_tbl_edit_arel  tblname,hash,strwhere ##
		strset = ""
		hash.each do |key,val|
			strset << key.to_s  + " = "
			strset << case val.class.to_s
				when "String"
					%Q&'#{val.gsub("'","''")}',&
				when "Fixnum","Bignum","BigDecimal","Float"
					"#{val},"
				when "Date"
					%Q& to_date('#{val.strftime("%Y/%m/%d")}','yyyy/mm/dd'),&
				when "Time"
					case key.to_s
						when "created_at","updated_at"
							%Q& to_date('#{val.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),&
						else
							%Q& to_date('#{val.strftime("%Y/%m/%d %H:%M")}','yyyy/mm/dd hh24:mi'),&
					end
				when "NilClass"
					"null,"
				else
					Rails.logger.debug " line #{__LINE__} : error val.class #{val.class}  key #{key.to_s} "
					raise
		   end
		end
		ActiveRecord::Base.connection.update("update #{tblname}  set #{strset.chop} where #{strwhere} ")
	end
	def proc_tbl_delete_arel  tblname,strwhere ##
		ActiveRecord::Base.connection.delete("delete from  #{tblname}  where #{strwhere} ")
	end
	def proc_price_amt command_c
		tblnamechop = (command_c[:sio_viewname].split("_",2)[1].chop)
		qty = command_c[("#{tblnamechop}_qty").to_sym]
		case tblnamechop
			when /^cust/
				pricetbl = "custs"
				loca_code = command_c[:loca_code_cust]
			when /^pur/
				pricetbl = "dealers"
				loca_code = command_c[:loca_code]   ###入力でdealerを保証する。
			when /^prd/
				pricetbl = "asstwhs"
				loca_code = command_c[:loca_code_asstwh]
			when /^shp/
				loca_code = command_c[:loca_code_to]
				case command_c[:opeitm_oparation]
					when "shp:delivered_goods"
							pricetbl = "custs"
					when "shp:feepayment"
							pricetbl = "feepayms"
					when "shp:shipment"
							pricetbl = "asstwhs"
					else
							pricetbl = "asstwhs"
				end
				loca_code = command_c[:loca_code_to]
			when /mkact/
				case command_c[:mkact_prdpurshp]
					when "pur"
						pricetbl = "dealers"
						if command_c[:mkact_sno_inst]
							strsql = "select * from r_purinsts where purinst_sno = '#{command_c[:mkact_sno_inst]}'"
							loca_code = ActiveRecord::Base.connection.select_one(strsql)["loca_code"]
						else
							if command_c[:mkact_sno_act]
								strsql = "select * from r_puracts where purinst_sno = '#{command_c[:mkact_sno_act]}'"
								loca_code = ActiveRecord::Base.connection.select_one(strsql)["loca_code"]
							else
								return {}
							end
						end
					else
						return {}
				end
			else
				return {}
		end
		strsql = "select *
				from r_pricemsts 	/*同一品目内ではcontract_price<pricemst_amtroundは有効日内で同一であること*/
				where pricemst_tblname =  '#{pricetbl}' and pricemst_expiredate >= current_date and
				itm_code = '#{command_c[:itm_code]}' AND loca_code = '#{loca_code}' "
		rec_contract = ActiveRecord::Base.connection.select_one(strsql)   ###画面のfield
		command_c[("#{tblnamechop}_contract_price").to_sym]||=""
		if command_c[("#{tblnamechop}_contract_price").to_sym]  != "" ###変更の時
			contract = command_c[("#{tblnamechop}_contract_price").to_sym]
			price = (command_c[("#{tblnamechop}_price").to_sym]||=0).to_f
			amtround = rec_contract["pricemst_amtround"] if rec_contract
			amtdecimal = rec_contract["pricemst_amtdecimal"] if rec_contract
		else   ###新規登録の時の単価
			if rec_contract.nil?
				contract = ""
				case tblnamechop
					when /^cust/
						contract= "C"
					when /^pur/
						contract = "D"
					when /^prd/
						contract = "X"  ###単価未定
						expiredate = ""
						return {:price=>"0",:amt=>"0",:tax=>"0",:amtf=>"0",:contract_price => contract}   ##
					when /^shp/
						case command_c[:opeitm_oparation]
							when "shp:delivered_goods"
								contract= "C"
							when "shp:feepayment"
								contract = "F"
							when "shp:shipment"
								contract = "X"  ###単価未定
								expiredate = ""
								return {:price=>"0",:amt=>"0",:tax=>"0",:amtf=>"0",:contract_price => contract}   ##
							else
								contract = "X"  ###単価未定
								expiredate = ""
								return {:price=>"0",:amt=>"0",:tax=>"0",:amtf=>"0",:contract_price => contract}   ##
					end
				end
			else
				contract = rec_contract["pricemst_contract_price"]
				amtround = rec_contract["pricemst_amtround"]
				amtdecimal = rec_contract["pricemst_amtdecimal"]
			end
		end
		##7:出荷日までに決定する単価
		##　8:受入日までに決定する単価　
		##9:単価決定=検収
		expiredate = nil
		case contract
			when "1" ###発注日ベース　　発注日　== String 以下同様
				if tblnamechop =~ /ord|sch/
					expiredate = vproc_price_expiredate_set(contract,command_c)
				else
					return {:pricef=>true,:amtf=>true}
				end
			when "2"	###納期ベース
				if tblnamechop =~ /inst|ord|sch/
					expiredate = vproc_price_expiredate_set(contract,command_c)
				else
					return {:pricef=>true,:amtf=>true}
				end
			when "3","4"
				expiredate = vproc_price_expiredate_set(contract,command_c)
			when "C","D","F" ##C : custs テーブルに従う D:dealersテーブルに従う
				case  pricetbl
					when  "custs"
						strsql = "select  * from r_custs
								where loca_code_cust =  '#{loca_code}' and cust_expiredate > current_date "
						pare_contract = ActiveRecord::Base.connection.select_one(strsql)   ###画面のfield
						if pare_contract
							expiredate = vproc_price_expiredate_set(pare_contract["cust_contract_price"],command_c)
							if expiredate.nil?
								Rails.logger.debug "line #{__LINE__} strsql #{strsql}"
								raise
							end
							pare_rule_price = pare_contract["cust_rule_price"]
							amtround = pare_contract["pricemst_amtround"]
							amtdecimal = pare_contract["pricemst_amtdecimal"]
						end
					when  "dealers"
						strsql = "select  * from r_dealers
									where loca_code_dealer =  '#{loca_code}' and dealer_expiredate > current_date "
						pare_contract = ActiveRecord::Base.connection.select_one(strsql)   ###画面のfield
						expiredate = vproc_price_expiredate_set(pare_contract["dealer_contract_price"],command_c)
						if expiredate.nil?
							Rails.logger.debug "line #{__LINE__} strsql #{strsql}"
							raise
						end
						pare_rule_price = pare_contract["dealer_rule_price"]
						amtround = pare_contract["pricemst_amtround"]
						amtdecimal = pare_contract["pricemst_amtdecimal"]
					when  "feepayms"
						strsql = "select  * from r_feepayms
									where loca_code_dealer_fee =  '#{loca_code}' and feepaym_expiredate > current_date "
						pare_contract = ActiveRecord::Base.connection.select_one(strsql)   ###画面のfield
						expiredate = vproc_price_expiredate_set(pare_contract["feepaym_contract_price"],command_c)
						if expiredate.nil?
							Rails.logger.debug "line #{__LINE__} strsql #{strsql}"
							raise
						end
						pare_rule_price = pare_contract["feepaym_rule_price"]
						amtround = pare_contract["pricemst_amtround"]
						amtdecimal = pare_contract["pricemst_amtdecimal"]
				end
			when "Z"
				expiredate = ""
		end
		if expiredate.nil?
			Rails.logger.debug "line #{__LINE__} proc_price_amt :master error ???"
		end
		strsql = %Q& select * from r_pricemsts
					where pricemst_tblname =  '#{pricetbl}' and
						itm_code = '#{command_c[:itm_code]}' AND loca_code = '#{loca_code}' and
						pricemst_maxqty >= #{qty} and
						pricemst_expiredate >= to_date('#{expiredate}','yyyy/mm/dd') and
						pricemst_contract_price = '#{contract}'
						order by pricemst_expiredate ,pricemst_maxqty  &
		price_rec = ActiveRecord::Base.connection.select_one(strsql)   ###画面のfield
		if price_rec
			amtf = true
			contract = price_rec["pricemst_contract_price"]
			amtround = price_rec["pricemst_amtround"]
			amtdecimal = price_rec["pricemst_amtdecimal"]
			if price_rec["pricemst_rule_price"] == "0"
				pricef = true
				price =  price_rec["pricemst_price"]
			else
				if contract == "Z"
					price = command_c[("#{tblnamechop}_price").to_sym].to_f
					contract = "Z" if price_rec["pricemst_price"] != price
				else
					price =  price_rec["pricemst_price"]
				end
			end
		else
			if pare_rule_price  == "0" and @pare_class != "batch"
				price = proc_blkgetpobj("単価マスタなし","err_msg",command_c[:sio_email] )[0]
				return {:price=>price.to_s,:amt=>"",:tax=>"",:pricef=>true,:amtf=>true,:contract_price => contract}
			end
			if @pare_class == "batch"
				@errmsg = proc_blkgetpobj("単価マスタなし","err_msg",command_c[:sio_email] )[0]
				return {:price=>"0",:amt=>"0",:tax=>"0",:pricef=>false,:amtf=>false,:contract_price => "X"}
			end
            ###画面から単価入力された時
		end
		amt = qty.to_f * price
		case amtround
			when "-1"  ###切り捨て
				amt = amt.floor2(amtdecimal)
			when "0"
				amt = amt.round(amtdecimal)
			when "1"  ###切り上げ
				amt = amt.ceil2(amtdecimal)
			else
				raise  ###該当レコードのremarkに
		end
		tax = vproc_get_tax(amt,loca_code)    ###作成中
		return {:price=>price.to_s,:amt=>amt.to_s,:tax=>tax.to_s,:pricef=>true,:amtf=>true,:contract_price => contract}
	end
	def vproc_get_tax(amt,loca_code)  ###作成中
		0
	end
	def vproc_price_expiredate_set(contract,command_c)
		tblnamechop = command_c[:sio_viewname].split("_",2)[1].chop
		case contract  ###
			when "1"   ###発注日ベース
				expiredate = command_c[(tblnamechop+"_isudate").to_sym].strftime("%Y/%m/%d")
			when "2" ###納期ベース
				expiredate = command_c[(tblnamechop+"_duedate").to_sym].strftime("%Y/%m/%d")
			when "3" ###:受入日ベース
				if tblnamechop =~ /acts$/
					expiredate = command_c[(tblnamechop+"_rcptdate").to_sym].strftime("%Y/%m/%d")
				else
					expiredate = command_c[(tblnamechop+"_duedate").to_sym].strftime("%Y/%m/%d")
				end
			when "4" ###:出荷日ベース　
				expiredate = command_c[(tblnamechop+"_depdate").to_sym].strftime("%Y/%m/%d")
			when "5" #####:検収ベース
				expiredate = command_c[(tblnamechop+"acpdate").to_sym].strftime("%Y/%m/%d")
		end
	end

	def proc_get_duration_by_loca(loca_id_fm,loca_id_to,priority)
		{:duration=>1,:transport_id =>ActiveRecord::Base.connection.select_value("select id from transports where code = 'dummy' ")}
	end
	def proc_ord_inst_qty_chng tblname,tblid,qty
		strsql = "select sum(qty) from alloctbls where srctblname = 'trngantts' and
							destblname = '(#{tblname}' and destblid = #{tblid}
							group by srctblname,destblname,destblid for update"

	end

	def proc_prj_allocprjcodes prj_code
		prjcodes = []
		prjcodes << prj_code
		loopcode =[]
		loopcode << prj_code
		ii = 0
		until loopcode.size < 1
			strsql = "select self.code_chil from prjnos self,prjnos chil where self.code_chil = chil.code and self.code = '#{loopcode.shift}'"
			rec_prjs = ActiveRecord::Base.connection.select_values(strsql)
			rec_prjs.each do |prj|
				if prjcodes.index(prj).nil?
					prjcodes << prj
					loopcode << prj
				end
				ii += 1
				break if ii >10
			end
		end
		prjcodes.join("','")
	end


	def proc_save_trn_of_opeitm trn  ##複数の品目の時、内容が変わってしまうのでsaveした。
		yield
		trn[:sio_classname] = @sio_classname
		if  @opeitm_id   ###pic,dlvは親でprocessseq等をセット
			trn[:prdpurshp] ||= @opeitm_prdpurshp
			trn[:stktaking_f] =@opeitm_stktaking_f
			trn[:packqty] =  if (@opeitm_packqty ||=0) == 0 then 0 else @opeitm_packqty end
			trn[:priority] = @opeitm_priority
			trn[:processseq] = @opeitm_processseq
			trn[:shuffleflg] = @opeitm_shuffleflg
			trn[:packno_flg] = @opeitm_packno_flg
      trn[:shelfnos_id] = @opeitm_shelfno_id
		end
		trn[:processseq_pare] = eval("@#{trn[:tblname].chop}_processseq_pare")
		trn[:itms_id] = @itm_id
		trn[:locas_id] = @loca_id
		trn[:locas_id_to] = eval("@#{trn[:tblname].chop}_loca_id_to")
		trn[:id] = eval("@#{trn[:tblname].chop}_id")
		trn[:qty] = eval("@#{trn[:tblname].chop}_qty||=0")
		trn[:qty_stk] = eval("@#{trn[:tblname].chop}_qty_stk||=0")
		trn[:prjnos_id] = eval("@#{trn[:tblname].chop}_prjno_id")
		trn[:starttime] = eval("@#{trn[:tblname].chop}_starttime")
		trn[:depdate] = eval("@#{trn[:tblname].chop}_depdate")
		trn[:lotno] = eval("@#{trn[:tblname].chop}_lotno||='dummy'")
		trn[:packno] = eval("@#{trn[:tblname].chop}_packno||='dummy'")
		trn[:duedate] = case  trn[:tblname]
							when "puracts"
								@puract_rcptdate
							when "prdacts"
								@prdact_cmpldate
							when "lotstkhists"
								nil
							else
								eval("@#{trn[:tblname].chop}_duedate")
						end
		return trn
	end
	def proc_get_shp_contents(trn)
		lot_qty_stk = []
		strsql = " select aprev.destblname destblname ,aprev.destblid destblid,aprev.qty_stk alloc_qty_stk,shp.trngantt_processseq pare_processseq
					from alloctbls aprev,r_trngantts prev,alloctbls ashp, r_trngantts shp
					where aprev.srctblname = 'trngantts' and  aprev.srctblid = prev.trngantt_id
					and ashp.srctblname = 'trngantts' and  ashp.srctblid = shp.trngantt_id
					and prev.trngantt_orgtblname = shp.trngantt_orgtblname and prev.trngantt_orgtblid = shp.trngantt_orgtblid
					and shp.trngantt_key =  case length(prev.trngantt_key) when 3 then to_char(prev.trngantt_key  - 	1,'000') else substr(prev.trngantt_key,1,(length(prev.trngantt_key)-3)) end
					and prev.itm_id = shp.itm_id
					and ashp.destblname = '#{trn[:tblname]}' and ashp.destblid = #{trn[:id]} and aprev.qty_stk >0 "
		prevs =  ActiveRecord::Base.connection.select_all(strsql)
		prevs.each do |prev|
			strsql = %Q& select '#{prev["destblname"]}' tblname,
						#{case  prev["destblname"]
							when "lotstkhists"
								"lotstkhist_lotno lotno,lotstkhist_packno packno,lotstkhist_loca_id locas_id,lotstkhist_itm_id itms_id ,lotstkhist_stktaking_f stktaking_f"
							when /^pic/
								"#{prev["destblname"].chop}_lotno lotno,#{prev["destblname"].chop}_packno packno,#{prev["destblname"].chop}_loca_id locas_id,
								#{prev["destblname"].chop}_itm_id itms_id ,#{prev["destblname"].chop}_stktaking_f stktaking_f "
							else
								"'dummy' lotno,'dummy' packno , opeitm_itm_id itms_id ,sno  "
							end },
						#{prev["alloc_qty_stk"]} qty_stk
						from  r_#{prev["destblname"]} where id = #{prev["destblid"]} &
			lotstk = ActiveRecord::Base.connection.select_one(strsql)
			next if (lotstk["stktaking_f"] == "0" or (lotstk["stktaking_f"].nil?) and  prev["destblname"] =~ /lotstkhists|^pic/)
			lot_qty_stk << [lotstk["lotno"],lotstk["qty_stk"],1,lotstk["tblname"],lotstk["packno"],lotstk["itms_id"],prev["pare_processseq"],lotstk["sno"]]
		end
		return lot_qty_stk
	end
	def sql_proc_chng_lot_to_pic(trn,sql_param)
		" select aprev.alloctbl_id id, alloctbl_srctblname srctblname,alloctbl_destblname destblname,
					alloctbl_srctblid srctblid,alloctbl_destblid destblid,alloctbl_allocfree allocfree,alloctbl_packqty packqty,
					alloctbl_qty qty,alloctbl_qty_stk qty_stk,shp.trngantt_loca_id  shp_loca_id,shp.trngantt_processseq shp_trngantt_processseq,
					ashp.destblname shp_tblname,ashp.destblid shp_tblid
					from r_alloctbls aprev,r_trngantts prev,alloctbls ashp, r_trngantts shp
					where aprev.alloctbl_srctblname = 'trngantts' and  aprev.alloctbl_srctblid = prev.trngantt_id
					and ashp.srctblname = 'trngantts' and  ashp.srctblid = shp.trngantt_id
					and prev.trngantt_orgtblname = shp.trngantt_orgtblname and prev.trngantt_orgtblid = shp.trngantt_orgtblid
					and shp.trngantt_key =  case length(prev.trngantt_key) when 3 then to_char(prev.trngantt_key  - 1,'000') else substr(prev.trngantt_key,1,(length(prev.trngantt_key)-3)) end
					and prev.itm_id = shp.itm_id
					and ashp.destblname = '#{trn[:tblname]}' and ashp.destblid = #{trn[:id]}
					and #{sql_param}
					and  aprev.alloctbl_allocfree = 'alloc' "
	end
	def proc_already_use_packno(prev,trn)  ###工事中
		proc_alloc_to_sch(prev,0,0)
		free_trn_strwhere = " and trngantt_itm_id = #{@lotstkhist_itm_id} and trngantt_processseq = #{@lotstkhist_processseq}
						and alloctbl_destblname = 'lotstkhists'
						and alloctbl_destblid in(select id from lotstkhists where itms_id = #{@lotstkhist_itm_id}
						and processseq = #{@lotstkhist_processseq}
						and locas_id = #{@lotstkhist_loca_id} and qty_stk >= #{prev["qty_stk"]}) "
		trg_trn_strwhere = " and trngantt_id = #{prev["srctblid"]} and alloctbl_srctblname = 'trngantts' 	"
		proc_free_to_alloc("","",free_trn_strwhere,trg_trn_strwhere)
		strsql = "select * from alloctbls where srctblname = 'trngantts' and srctblid = #{prev["srctblid"]}
								and destblname = 'lotstkhists' and allocfree = 'alloc' and qty_stk = #{prev["qty_stk"]} "
		new_lot = ActiveRecord::Base.connection.select_one(strsql)
		if new_lot
			strsql = %Q& select * from  r_lotstkhists  where id = #{new_lot["destblid"]} &
			proc_command_instance_variable(ActiveRecord::Base.connection.select_one(strsql))
			true
		else   ###一リールが複数に引きあたっているとき　空きがない。
			strsql = "select * from alloctbls where srctblname = 'trngantts' and destblname = '#{trn[:tblname]}' and destblid = #{trn[:id]} "
			alloc = ActiveRecord::Base.connection.select_one(strsql)
			proc_alloc_to_sch(alloc,0,0)
			prev[:destblname] = alloc[:destblname]
			false
		end
	end
	def proc_mkord_err rec,mag
		proc_tbl_edit_arel(rec["alloctbl_destblname"],{:remark=>mag}," id = #{rec["alloctbl_destblid"]}")
	end
	def proc_chil_items_auto_shp(tblname,tblid)
		chil_items = {}
		trn_ids = ActiveRecord::Base.connection.select_all("select srctblid from alloctbls where srctblname = 'trngantts' and destblname = '#{tblname}' and destblid = #{tblid} and qty > 0 ")
		trn_ids.each do |tid|
			strsql = "select chil.id chil_id,shp.*,alloc.id alloc_id,alloc.srctblname alloc_srctblname,alloc.srctblid alloc_srctblid,alloc.destblname alloc_destblname,alloc.destblid alloc_destblid
							from trngantts chil,trngantts pare, alloctbls alloc,r_shpschs shp
								where pare.id = #{tid} and chil.orgtblnmae = pare.orgtblname and chil.orgtblid = pare.orgtblid
								and pare.key =  case length(chil.key) when 3 then to_char(chil.key  - 1,'000') else substr(chil.key,1,length(chil.key) -3)   end
								and alloc.srctblname = 'trngantts' and alloc.srctblid = chil.id and alloc.destblname = 'shpschs' and alloc.destblid = shp.id and alloc.qty > 0 "
			items = ActiveRecord::Base.connection.select_all(strsql)
			allocs = []
			items.each do |item|
				if chil_items[item["chil_id"].to_s].nil?
					shp = {}
					item.each do |key,val|
						if key =~ /^shpsch/
							shp[key] = val
						end
					end
				else
					shp["qty"] += item["qty"]
				end
				allocs << {:id=>item["alloc_id"],:srctblname=>item["alloc_srctblname"],:srctblid=>item["alloc_srctblid"],:destblname=>item["alloc_destblname"],:destblid=>item["alloc_destblid"]}
			end
			chil_items[item["chil_id"].to_s] = {:shp=>shp,:allocs=>allocs}
		end
	end

	def proc_blk_constrains tbl,colm,type,constraint_name   ###r_blktbsのテーブル　view作成ボタンでblkukysにレコードを追加してないとチェックはできない。
		strsql = ""
		ActiveRecord::Base.uncached() do
			case ActiveRecord::Base.configurations[Rails.env]['adapter']
				when /post/
					##post
				when /oracle/
					strsql = "select  c.table_name, c.constraint_name, c.constraint_type, cc.position, cc.column_name from user_constraints c, user_cons_columns cc
								where c.table_name      = cc.table_name  and c.constraint_name = cc.constraint_name "
					strsql << if tbl then " and c.table_name = '#{tbl.upcase}' " else "" end
					strsql << if colm
								if colm =~ /%$|^%/ then " and  cc.column_name like  '#{colm.upcase}' " else " and  cc.column_name = '#{colm.upcase}'" end
								else
									""
								end
					strsql << if type then " and c.constraint_type = '#{type.upcase}' " else "" end
					strsql << if constraint_name then " and c.constraint_name = '#{constraint_name.upcase}' " else "" end
					strsql << " order by c.constraint_name ,cc.position "
			end
			ActiveRecord::Base.connection.select_all(strsql)
		end
	end
	def proc_blk_get_constrains tbl,type
		strsql = ""
		ActiveRecord::Base.uncached() do
			case ActiveRecord::Base.configurations[Rails.env]['adapter']
				when /post/
					strsql = "SELECT  constraint_name FROM information_schema.table_constraints WHERE table_name = '#{tbl.downcase}'
										and constraint_type = #{case type.upcase when /^U/ then 'UNIQUE' when /^F/ then 'FOREIGN KEY' else '' end } "
				when /oracle/
					strsql = "select constraint_name 	from all_constraints 	where  table_name = '#{tbl.upcase}'  and constraint_type = '#{type[0].upcase}'"
			end
			ActiveRecord::Base.connection.select_values(strsql)
		end
	end
	def proc_sequences_exist seq_name
		case ActiveRecord::Base.configurations[Rails.env]['adapter']
			when /oracle/
				sql = "SELECT 1	FROM user_sequences WHERE sequence_name = '#{seq_name.upcase}' "
			when /post/
				sql = "SELECT 1 FROM pg_class where relname = '#{seq_name.downcase}'"
		end
		ActiveRecord::Base.connection.select_one(sql)
	end
	def proc_no_set code,key
		rec =  proc_decision_id_by_key("notbls","  code = '#{code}' and key = '#{key}'" )
		if @notbl_classname =~ /_add_/
			rec["code"] = code
			rec["key"] = key
			rec["seqno"] = 1
			proc_tbl_add_arel("notbls",rec)
			return 1
		else
			rec["seqno"] += 1
			proc_tbl_edit_arel("notbls",rec," id = #{rec["id"]}")
			return rec["seqno"]
		end
	end
	# Float()で変換できれば数値、例外発生したら違う
	def float_string?(str)
		begin
			if str.class == Fixnum  or str.class == Bignum    or str.class == Float
				true
			else
				Float(str)
				true
			end
		rescue ###ArgumentError
			false
		end
	end
	def date_string?(str)
		begin
			if str.class == Time
				true
			else
				Date.parse(str)
				true
			end
		rescue ###ArgumentError
			false
		end
	end
	class Float
		def floor2(exp = 0)
			multiplier = 10 ** exp
			((self * multiplier).floor).to_f/multiplier.to_f
		end
		def ceil2(exp = 0)
			multiplier = 10 ** exp
			((self * multiplier).ceil).to_f/multiplier.to_f
		end
	end
end   ##module Ror_blk
