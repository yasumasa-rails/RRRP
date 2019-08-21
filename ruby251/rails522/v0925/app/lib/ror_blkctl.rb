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
  	def proc_update_table command_r,r_cnt0  ##rec = command_c command_rとの混乱を避けるためrecにした。
      	begin
         	tmp_key = {}
			tblname = command_r[:sio_viewname].split("_")[1]
        	if  command_r[:sio_message_contents].nil?
				command_r = proc_set_src_tbl(command_r) ### @src_tblの項目作成
			end
			command_r[:sio_recordcount] = r_cnt0
			if tblname =~ /^mk/ and @screen_code !~ /#{tblname}/  ###mkxxxxは追加のみ
				proc_tbl_add_arel(tblname,@src_tbl)
			else
				case command_r[:sio_classname]
				when /_add_/
					proc_tbl_add_arel(tblname,@src_tbl)
				when /_edit_/
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
				end ##
				processreqs_id = proc_processreqs_add tblname,@src_tbl[:id]
			end ##se iud
      	rescue
        	ActiveRecord::Base.connection.rollback_db_transaction()
            command_r[:sio_result_f] =   "9"  ##9:error
            command_r[:sio_message_contents] =  "class #{self} : LINE #{__LINE__} $!: #{$!} "    ###evar not defined
            command_r[:sio_errline] =  "class #{self} : LINE #{__LINE__} $@: #{$@} "[0..3999]
            Rails.logger.debug"error class #{self} : #{Time.now}: #{$@} "
          	Rails.logger.debug"error class #{self} : $!: #{$!} "
          	Rails.logger.debug"  command_r: #{command_r} "
      	else
        	command_r[:sio_result_f] =  "1"   ## 1 normal end
          	command_r[:sio_message_contents] = nil
          	command_r[(tblname.chop + "_id")] =  command_r["id"] = @src_tbl[:id]
			proc_insert_sio_r( command_r) #### if @pare_class != "batch"    ## 結果のsio書き込み
			CreateOtherTableRecordJob.perform_later processreqs_id
      	ensure
	  	end ##begin
	  	return command_r
	end
	##def vproc_optiontabl tblname
	##	if tblname =~ /rplies$|mksch|mkords|results$/ then true else false end  ###mkinsts,mkactsは使用してない　12/9
	##end
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
		rec = {}
        rec[:sio_id] =  proc_get_nextval("sio.SIO_#{command_c[:sio_viewname]}_SEQ")
        rec[:sio_command_response] = "R"
		rec[:sio_add_time] = Time.now
		###画面専用項目
		command_c.each do |key,val|
			next if key.to_s =~ /gridmessage/
			next if key.to_s =~ /^_/
			next if key.to_s == "confirm"
			rec[key] = val
		end	
		proc_tbl_add_arel  "SIO_#{command_c[:sio_viewname]}",rec
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
				next if ff["value"].nil?
				next if ff["value"] == ""
	      		case where_info[ff["id"].to_sym]
				when nil
					next
		 		when /numeric/
					if ff["value"] =~ /^<=/  or ff["value"] =~ /^>=/ or ff["value"]=~ /^!=/
						next if ff["value"].size == 2 
						where_str << " #{ff["id"]} #{ff["value"][0..1]} #{ ff["value"][2..-1]}      AND "   
					else
						if ff["value"] =~ /^</   or  ff["value"] =~ /^>/	or  ff["value"] =~ /^=/
							next if ff["value"].size == 1 
							where_str << " #{ff["id"]}  #{ff["value"][0]}  #{ ff["value"][1..-1]}      AND "   
						else	
							where_str << " #{ff["id"]} = #{ff["value"]}     AND "
						end	
					end	
				  when /^date|^timestamp/
					ff["value"] = ff["value"].gsub("-","/")
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
						else
							next						
                	end ## ff["value"].size
				when /char|text|select/
					if  (ff["value"] =~ /^%/ or ff["value"] =~ /%$/ ) then 
						where_str << " #{ff["id"]} like '#{ff["value"]}'     AND "
					elsif ff["value"] =~ /^<=/  or ff["value"] =~ /^>=/ then 
						where_str << " #{ff["id"]} #{ff["id"][0..1]} '#{ff["id"][2..-1]}'     AND "
					elsif 	ff["value"] =~ /^</   or  ff["value"] =~ /^>/
						where_str << " #{ff["id"]}   #{ff["value"][0]}  '#{ff["value"][1..-1]}'         AND " 
					else
						where_str << " #{ff["id"]} = '#{ff["value"]}'         AND "
					end
	      		##when "select"
				##	where_str << " #{ff["id"]} = '#{ff["value"]}'         AND "
        		end   ##show_data[:alltypes][i]
        		tmpwhere = " #{ff["id"]} #{ff["value"]}    AND " if  ff["value"] =~/is\s*null/ or ff["value"]=~/is\s*not\s*null/
	      		where_str << (tmpwhere||="")
			end ### command_c.each  do |i,j|###
    	return where_str[0..-7]
		end	
		def fetch_data_blk id,select_fields,page_info,strwhere,sort_info
				strsorting = ""
				if sort_info[:option] and  sort_info[:option] != ""
					strsorting << "order by #{sort_info[:option]}"
				else
					if sort_info[:default]	and  sort_info[:default] != ""
						strsorting << "order by #{sort_info[:default]}"
					end	
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
				return  pagedata,page_info
		end	
		def download_data_blk screenCode,select_fields,strwhere,columns_color
				strsql = "select #{select_fields} from  #{screenCode}
							 #{if strwhere == '' then '' else strwhere   end }  limit 1000000	  "
				recs = ActiveRecord::Base.connection.select_all(strsql)
				cnt = 0
				pagedata = "[["
				recs.each do |rec|
					rec.each do |key,val|
						pagedata << %Q%{"value":"#{val}","style":{"fill":{"patternType": "solid", "fgColor": {"rgb": "#{columns_color[key.to_sym]}"}}}}\n,%
					end
					pagedata = pagedata.chop +  "],["
					cnt += 1	
				end	
				pagedata = pagedata[0..-3] + "]"
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
		else
			@src_tbl[:id] = 	rec["id"]	
		end	
		return rec
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

	def init_from_screen current_user,params  ### current_user = current_api_user
		@sio_user_code = ActiveRecord::Base.connection.select_value("select id from persons where email = '#{current_user[:email]}'")
		command_c = {}
		command_c[:sio_viewname] =  params[:screenCode]
		command_c[:sio_code] =  params[:screenCode]
		command_c[:sio_message_contents] = nil
		command_c[:sio_recordcount] = 1
		command_c[:sio_result_f] =   "0"  
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
			gridmessages_fields = ""  ### error messages
			dropdownlist = {}
			sort_info = {}
			screenwidth = 0
			if (req==='editabletablereq' )

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
			end		
			ActiveRecord::Base.connection.select_all(sqlstr).each_with_index do |i,cnt|							
				select_fields = 	select_fields + 	i["pobject_code_sfd"] + ','
				columns_info << {:Header=>"#{i["screenfield_name"]}",
												:accessor=>"#{i["pobject_code_sfd"]}",
												:show=>if  i["screenfield_hideflg"] == "0" then true else false end,
												:filtered=>true,
												:width => i["screenfield_width"].to_i,
												:id=>"#{i["screenfield_id"]}",
												##:style=>%Q%{"textAlign":#{if i["screenfield_type"] == "numeric" then "right" else "left" end}%, 
												:style=>{:textAlign=>if i["screenfield_type"] == "numeric" then "right" else "left" end}, 
												:className=>if ((req==="editabletablereq" or req==="inlineaddreq") and 
																		  (i["screenfield_editable"] === "1" or i["screenfield_editable"] === "2"))
																if  i["screenfield_type"] == "select" 
																	"renderSelectEditable"
															    else
																	if	(i["screenfield_indisp"] === "1" or i["screenfield_indisp"] === "2")
																			"renderEditableRequired"
																	else
																			"renderEditable"
																	end
																end				  
															else	
																if  i["screenfield_type"] == "select" 
																	"renderSelectNonEditable"
															    else
																	"renderNonEditable"
																end	
															end	
									}
				if (req==="editabletablereq" or req==="inlineaddreq") and  (i["screenfield_editable"] === "1" or i["screenfield_editable"] === "2")
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
								page_info[:sizePerPage] = i["screen_rows_per_page"].to_i
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
			if (req==='editabletablereq' or req==="inlineaddreq")
				yup = YupSchema.create_yupfetchcode screen_code   
			else
				yup={}
			end		
			dropdownlist.each do |key,val|
				tmpval="["
				val.split(",").each do  |drop|
					tmpval << %Q%{"value":"#{drop.split(":")[0]}","label":"#{drop.split(":")[1]}"},%
				end
				dropdownlist[key] = tmpval.chop + "]"
			end	
			if sort_info[:default]
				ary_select_fields = select_fields.split(',')
				sort_info[:default].split(/\s*,\s*/).each do |sort_field|
					ok = false
					sort_field.split(" ").each do|chk|
						if(ary_select_fields.include?(chk.gsub(" ","").downcase))
							ok = true
						else
							if ok==true and (chk.gsub(" ","").downcase=="asc" or chk.gsub(" ","").downcase=="desc")
							else
								sort_info[:default] = nil
								sort_info[:err] = "sort option error"
								break
							end		
						end		
					end	
					break if sort_info[:default].nil?
				end	
			end	 
			page_info[:screenwidth] = screenwidth	
			if gridmessages_fields.size > 1
				select_fields << gridmessages_fields
			end
			grid_columns_info = [columns_info,page_info,where_info,select_fields.chop,yup,dropdownlist,sort_info ]
		end
	end
	
	def create_download_columns_info screen_code,email
		download_columns_info = Rails.cache.fetch('download'+RorBlkctl.grp_code(email)+screen_code) do
				###  ダブルコーティション　「"」は使用できない。 
			sqlstr = "select * from  func_get_screenfield_grpname('#{email}','#{screen_code}')"
			columns_info = "["
			columns_color = {}
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
					where_info[i["pobject_code_sfd"].to_sym] = 	i["screenfield_type"]	
					columns_color[i["pobject_code_sfd"].to_sym] = color							
					select_fields = 	select_fields + 	i["pobject_code_sfd"] + ','
				end	
			end
			columns_info = columns_info.chop 
			columns_info = columns_info + "]"
			download_columns_info = [columns_info,where_info,select_fields.chop,columns_color]
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
			##params["fetchcode"].each do |key,val|
					if params["screenCode"].split("_")[1].chop != key.to_s.split("_")[0]
						mainviewflg = false
					end	 
			end	
			screendata = JSON.parse(params["linedata"])
			fetcfieldgetsql = "select pobject_code_sfd from r_screenfields
								 where pobject_code_scr =  '#{params["screenCode"]}' 
								 and screenfield_paragraph = '#{params["fetchview"]}'"	
			delm = (params["fetchview"].split(":")[1]||="")
			missing = false
			ActiveRecord::Base.connection.select_all(fetcfieldgetsql).each do |rec|
				if delm == ""
					strsql << "  #{rec["pobject_code_sfd"]} = '#{screendata[rec["pobject_code_sfd"]]}'    and"
				else
					strsql << "  #{rec["pobject_code_sfd"].split(delm)[0]} = '#{screendata[rec["pobject_code_sfd"]]}'    and"
				end		
				keys <<  "  #{rec["pobject_code_sfd"]} : '#{screendata[rec["pobject_code_sfd"]].gsub(",","_")}',"  ###入力項目に「,」が入っていた時
				if screendata[rec["pobject_code_sfd"]] == "" or screendata[rec["pobject_code_sfd"]].nil?   ###未入力
					missing = true
					rec = nil
				end		
			end
			if missing == false
				rec =  ActiveRecord::Base.connection.select_one(strsql[0..-4])
			end
			fetch_data = {}
			if rec
				screendata.each do |key,val|  ###結果をセット
						key = key.sub(delm,"")
						if rec[key] and key !="id" and key !~ /person.*upd/ 
							 fetch_data[key+delm] =  rec[key]
						end
				end	
				field = params["screenCode"].split("_")[1].chop+"_"+tblnamechop+"_id"+delm
				if JSON.parse(params["linedata"])[field]
					fetch_data[field] =  rec["id"]
				end
				field = tblnamechop+"_id"+delm
				if JSON.parse(params["linedata"])[field]
					fetch_data[field] =  rec["id"]
				end	
				findstatus = true
			else
				fetch_data[params["screenCode"].split("_")[1].chop+"_"+tblnamechop+"_id"+delm] =  ""  ##再入力時のNgに対応
				findstatus = false
			end		
			return fetch_data,mainviewflg,keys,findstatus
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
	def proc_get_tblrec_from_id tblname,id  ##  ##レコードが見つからなかったときの処理は親ですること。
		rec = ActiveRecord::Base.connection.select_one("select * from #{tblname} where id = #{id}")
		return rec.with_indifferent_access if rec
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
									%Q& to_timestamp('#{val.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),&
							else
									%Q& to_timestamp('#{val.strftime("%Y/%m/%d %H:%M")}','yyyy/mm/dd hh24:mi'),&
							end
						when "DateTime"
							case key.to_s
							when "expiredate"
									%Q& to_date('#{val.strftime("%Y/%m/%d")}','yyyy/mm/dd'),&
							else
								%Q& to_timestamp('#{val.strftime("%Y/%m/%d %H:%M")}','yyyy/mm/dd hh24:mi'),&
							end
						when "NilClass"
							"null,"
						when "Hash"
							"'#{val.to_query}',"
						when "TrueClass"
							if val == true then "1," else "0," end	
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
	def proc_tbl_edit_arel  tblname,hash,strwhere ##
		strset = ""
		hash.each do |key,val|
			strset << key.to_s  + " = "
			strset << case val.class.to_s
				when "String"
					%Q&'#{val.gsub("'","''")}',&
				when "Fixnum","Bignum","BigDecimal","Float","Integer"
					"#{val},"
				when "Date"
					%Q& to_timestamp('#{val.strftime("%Y/%m/%d")}','yyyy/mm/dd'),&
				when "Time"
					case key.to_s
						when "created_at","updated_at"
							%Q&to_timestamp('#{val.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),&
						else
							%Q& to_timestamp('#{val.strftime("%Y/%m/%d %H:%M")}','yyyy/mm/dd hh24:mi'),&
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
	def proc_processreqs_add tblname,id
		processreqs_id = proc_get_nextval("#{tblname}_seq")
		strsql = %Q%
		insert into processreqs(tblname,tblid,contents,remark,
								created_at,updated_at,
								update_ip,persons_id_upd,
								id,result_f)
								values('#{tblname}',#{id},'','',
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								'',#{@sio_user_code},
								#{processreqs_id},'0')
		%
		ActiveRecord::Base.connection.insert(strsql)
		return processreqs_id
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
