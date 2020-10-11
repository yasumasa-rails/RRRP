
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

	def proc_update_table command_c,r_cnt0  ##rec = command_c command_rとの混乱を避けるためrecにした。
		begin
				ActiveRecord::Base.connection.begin_db_transaction()
				reqparams = proc_private_aud_rec(command_c,r_cnt0,nil,nil,nil) 
		rescue
        		ActiveRecord::Base.connection.rollback_db_transaction()
				##command_r = command_c.dup
            	command_c[:sio_result_f] =   "9"  ##9:error
            	command_c[:sio_message_contents] =  "class #{self} : LINE #{__LINE__} $!: #{$!} "[0..3999]    ###evar not defined
            	command_c[:sio_errline] =  "class #{self} : LINE #{__LINE__} $@: #{$@} "[0..3999]
            	Rails.logger.debug"error class #{self} : #{Time.now}: #{$@} "
          		Rails.logger.debug"error class #{self} : $!: #{$!} "
          		Rails.logger.debug"  command_c: #{command_c} "
      	else
        		command_c[:sio_result_f] =  "1"   ## 1 normal end
				command_c[:sio_message_contents] = nil
				tblname = command_c[:sio_viewname].split("_")[1]
          		command_c[(tblname.chop + "_id")] =  command_c["id"] = @src_tbl[:id]
				proc_insert_sio_r( command_c) #### if @pare_class != "batch"    ## 結果のsio書き込み
				ActiveRecord::Base.connection.commit_db_transaction()
				if reqparams   ###画面からの時はperform_later(reqparams["seqno"][0])　seqnoは一つのみ。次の処理がないときはreqparams=nil
					if command_c["mkord_runtime"]
						CreateOtherTableRecordJob.set(wait: command_c["mkord_runtime"].to_f.hours).perform_later(reqparams["seqno"][0])
					else	
						CreateOtherTableRecordJob.perform_later(reqparams["seqno"][0])
					end
				end	
      	ensure
	  	end ##begin
	end

	def proc_private_aud_rec  command_r,r_cnt0,paretblname,paretblid,reqparams
		tmp_key = {}
		tblname = command_r[:sio_viewname].split("_")[1]
		if  command_r[:sio_message_contents].nil? 
			command_r,srctblname,srctblid = set_src_tbl(command_r) ### @src_tblの項目作成
		end
		command_r[:sio_recordcount] = r_cnt0
		case command_r[:sio_classname]
		when /_add_|_insert_/
			proc_tbl_add_arel(tblname,@src_tbl)
		when /_edit_|_update_/
			proc_tbl_edit_arel(tblname,@src_tbl," id = #{@src_tbl[:id]}")
		when  /_delete_|_purge_/
			if tblname =~ /schs$|ords$|insts$|dlvs$|acts$/  ##削除なし
					@src_tbl[:qty] = 0 if @src_tbl[:qty]
					@src_tbl[:qty_stk] = 0 if @src_tbl[:qty_stk]
					@src_tbl[:amt] = 0 if @src_tbl[:amt]
					@src_tbl[:tax] = 0 if @src_tbl[:tax]      ##変更分のみ更新
					proc_tbl_edit_arel(tblname,@src_tbl," id = #{@src_tbl[:id]}")
			else
					proc_tbl_delete_arel(tblname," id = #{@src_tbl[:id]}")
			end
		else
			3.times{p "sio_classname missing"}	
		end
		##
		if reqparams.nil?
			reqparams = {}
			reqparams["orgtblname"] = tblname
			reqparams["orgtblid"] = @src_tbl[:id]	
			reqparams["sio_classname"] = command_r[:sio_classname]
			reqparams["seqno"] = []
		else
			###reqparamsは既にセットされている。
		end
		reqparams["tbldata"] = @src_tbl.stringify_keys  
		   
		case  tblname
			when /prdschs/  
				reqparams["segment"]  = "trngantts"   ###Operation.proc_trngantts：構成を作成 alloctbl inoutstkを含む
				processreqs_id ,reqparams = Operation.proc_processreqs_add tblname,@src_tbl[:id],paretblname,paretblid,reqparams	
				### trngantts,alloctblsを作成してないとordsの時対象とならない。
				if reqparams["orgtblname"] =~ /^cust/ or reqparams["mkords_id"] ###元がcust,・・・時のみ子、孫へと展開
					reqparams["segment"]  = "mkschs"   ###構成展開
					processreqs_id,reqparams = Operation.proc_processreqs_add tblname,@src_tbl[:id],paretblname,paretblid,reqparams	
				end
				if paretblname =~ /prd|pur/  
					reqparams["segment"]  = "consume_self_sch_parts"  ###消費
					processreqs_id,reqparams = Operation.proc_processreqs_add tblname,@src_tbl[:id],paretblname,paretblid,reqparams
					reqparams["segment"]  = "mk_shpsch_by_prd_pursch"   ###出庫
					processreqs_id ,reqparams = Operation.proc_processreqs_add tblname,@src_tbl[:id],paretblname,paretblid,reqparams
				end

			when /prdords/  
				if reqparams["orgtblname"] == "mkords"
					reqparams["orgtblname"] = tblname
					reqparams["orgtblid"] = @src_tbl[:id]
				end	
				###
				###➀
				###
				command_r.each do |key,val|   ###procの処理を実行
					if key =~ /^opeitm_/ and key =~ /_proc$/ and val == "1"
						reqparams["segment"] = key
						processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams	
					end
				end  
				###
				###➁
				###
				reqparams["segment"]  = "trngantts"   ###Operation.：prdordsのtrngantts作成
				processreqs_id ,reqparams = Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams				
				###
				###➂
				###
				reqparams["segment"]  = "mkschs"   ###構成展開
				processreqs_id ,reqparams = Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams	

				###reqparams["segment"] = "mkshpschs" ###子部品出庫 prdords作成時には子部品のschsはできてない。
				###processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],reqparams	

				###
				###➃
				###
				if paretblname =~ /prd|pur/   ###親が受注の時はは出荷
					reqparams["segment"]  =  "consume_self_ord_parts"
					processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams
				end
				###ordではsnoが入らないときがある。###sno,cnoでの前の状態との関係
				add_update_srctbl(srctblname,srctblid,tblname) if srctblname != ""
				###
			when /prdinsts/ 
				reqparams["segment"]  = "trngantts"   ###Operation.proc_trngantts：prdinstsのtrngantts作成
				processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams	 
				if paretblname =~ /prd|pur/    ###親が受注の時はは出荷
					reqparams["segment"]  =  "consume_self_ord_parts"
					processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams
				end
				add_update_srctbl srctblname,srctblid,tblname ###sno,cnoでの前の状態との関係

			when /prdacts/ 
				reqparams["segment"]  = "trngantts"   ###Operation.：構成を作成
				processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams	

				reqparams["segment"]  = "consume_child_parts"  ###子部品の消費　金型の返却(未設定)　装置の解放(未設定)
				processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams	

				add_update_srctbl srctblname,srctblid,tblname

			when /purschs/  
				reqparams["segment"]  = "trngantts"   ###Operation.proc_trngantts：構成を作成
				processreqs_id ,reqparams = Operation.proc_processreqs_add tblname,@src_tbl[:id],paretblname,paretblid,reqparams	
				### trngantts,alloctblsを作成してないとordsの時対象とならない。
				if reqparams["orgtblname"] =~ /^cust/   or reqparams["mkords_id"] ###元がcust,・・・時のみ子、孫へと展開
					reqparams["segment"]  = "mkschs"   ###構成展開
					processreqs_id ,reqparams = Operation.proc_processreqs_add tblname,@src_tbl[:id],paretblname,paretblid,reqparams	
				end
				##if (req["paretblid"] != @src_tbl[:id] or req["paretblname"] != tblname) ## and reqparams["orgtblname"] =~ /ords$/ 
				if paretblname =~ /prd|pur/  
					reqparams["segment"]  = "consume_self_sch_parts"
					processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],paretblname,paretblid,reqparams
					reqparams["segment"]  = "mk_shpsch_by_prd_pursch"
					processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],paretblname,paretblid,reqparams
				end
				##end
				###

			when /purords/  
				if reqparams["orgtblname"] == "mkords"
					reqparams["orgtblname"] = tblname
					reqparams["orgtblid"] =  @src_tbl[:id]
				end	
				###
				###➀
				###
				command_r.each do |key,val|   ###procの処理を実行
					if key =~ /^opeitm_/ and key =~ /_proc$/ and val == "1"
						reqparams["segment"] = key
						processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams	
					end
				end  
				###
				###➁
				###
				reqparams["segment"]  = "trngantts"   ###Operation.proc_trngantts：
				processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams	
				###
				###➂
				###
				reqparams["segment"]  = "mkschs"   ###構成展開
				processreqs_id ,reqparams = Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams	

				###reqparams["segment"] = ""  ###子部品出庫　作成時には子部品のschsはできてない。
				###processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],reqparams
				###
				###➃
				###	
				if paretblname =~ /prd|pur/  
					reqparams["segment"]  =  "consume_self_ord_parts"
					processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams
				end

				add_update_srctbl(srctblname,srctblid,tblname) if srctblname != ""  ###ordではsnoが入らないときがある。
				###
			when /purinsts/  
				reqparams["segment"]  = "trngantts"   ###Operation.proc_trngantts：
				processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams	 
				if paretblname =~ /prd|pur/  
					reqparams["segment"]  =  "consume_self_ord_parts"
					processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams
				end
				add_update_srctbl srctblname,srctblid,tblname

			when /puracts/   
				reqparams["segment"]  = "trngantts"   ###Operation.：構成を作成
				processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams	
			
				reqparams["segment"]  = "consume_child_parts"
				processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams	

				add_update_srctbl srctblname,srctblid,tblname

			when /custschs/  
				reqparams["segment"]  = "trngantts"   ###Operation.：
				processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams	

			when /custords/  
				reqparams["segment"]  = "trngantts"   ###Operation.proc_trngantts：custordsのtrngantts作成
				processreqs_id ,reqparams = Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams	
				reqparams["segment"]  = "mkschs"   ###構成展開
				processreqs_id ,reqparams = Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams	

			when /custinsts/  
				reqparams["segment"]  = "trngantts"   ###Operation.：
				processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams	

			when /custacts/   
				reqparams["segment"]  = "trngantts"   ###Operation.
				processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],tblname,@src_tbl[:id],reqparams	

			when /^custs$|suppliers|workplaces/
				reqparams["segment"] = "createtable"
				processreqs_id ,reqparams = Operation.proc_processreqs_add tblname,@src_tbl[:id],nil,nil,reqparams	

			 when /mkords/
			 	reqparams["segment"] = "mkords"
			 	reqparams["mkords_id"] = @src_tbl[:id]
			 	processreqs_id ,reqparams= Operation.proc_processreqs_add tblname,@src_tbl[:id],nil,nil,reqparams	
			else
				reqparams = nil
		end
		return reqparams
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
			next if key.to_s == "aud"
			rec[key] = val
		end	
		proc_tbl_add_arel  "SIO_#{command_c[:sio_viewname]}",rec
	end   ## 
	


	def proc_create_filteredstr filtered,where_info
			if (where_info[:filtered]||="").size > 0
				 where_str =   "  where " +	 where_info[:filtered] + "    and "
			else
				 where_str = "  where "	 
			end	
			filtered.each  do |strjson|  ##xparams gridの生
				ff = JSON.parse(strjson)
				next if ff["value"].nil?
				next if ff["value"] == ""
				next if ff["value"] =~ /'/
	      		case where_info[ff["id"].to_sym]
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
									where_str << " to_char( #{ff["id"]},'yyyy/mm/dd') = '#{ff["value"]}'       AND "  if Date.valid_date?(ff["value"].split("/")[0].to_i,ff["value"].split("/")[1].to_i,ff["value"].split("/")[2].to_i)
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
    		return where_str[0..-7]
	end	

	def proc_search_blk id,select_fields,page_info,strwhere,sort_info
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
				if strwhere =~ /where/ 
					strsql = "SELECT count(*) FROM #{id} #{strwhere}"
				else
					strsql = "SELECT count(*) FROM #{id.split("_")[1]} "
				end  ###id=view名　fillterがあるので、table名は抽出条件に合わず使用できない。
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
					rec.each do |key,val|  ## nl 改行は使用できない。
						pagedata << %Q%{"value":"#{if val then val.gsub(/"/,"'").gsub(/\n/," ").gsub(/\x09/," ") end}",
										"style":{"fill":{"patternType": "solid", "fgColor": {"rgb": "#{columns_color[key.to_sym]}"}}}}\n,%
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

	def set_src_tbl rec  ##rec["xxxxx"]
		srctblid = srctblname = ""
  		@src_tbl = {}   ###テーブル更新
		tblnamechop = rec[:sio_viewname].split("_",2)[1].chop
		if rec[:sio_classname] =~ /_add_/
			@src_tbl[:created_at] =  rec["#{tblnamechop}_created_at"] = Time.now
			if  rec["id"] == "" or rec["id"].nil?
				rec["id"] = @src_tbl[:id] = proc_get_nextval("#{tblnamechop}s_seq")
				rec[tblnamechop+"_id"] = rec["id"] 
			else
				@src_tbl[:id] = rec["id"]  ###fields_updateでセット
			end
		else
			@src_tbl[:id] =	rec["id"]	
		end	
        rec.each do |j,k|
        	j_to_stbl,j_to_sfld = j.to_s.split("_",2)
			if  j_to_stbl == tblnamechop  and j_to_sfld !~ /_gridmessage/ and j_to_sfld != "id" and
					j_to_sfld != "code_upd" and  j_to_sfld != "name_upd"   and  j_to_sfld != "id_upd"##本体の更新
			    if  k
	            	@src_tbl[j_to_sfld.sub("_id","s_id").to_sym] = k
						@src_tbl[j_to_sfld.to_sym] = nil  if k  == "\#{nil}"  ##
					if k == ""
						case 	  j_to_sfld
						when 'sno'
							rec[tblnamechop+"_sno"] = @src_tbl[:sno] = ControlFields.proc_field_sno(tblnamechop,rec["id"])
						when 'cno'
							rec[tblnamechop+"_cno"] = @src_tbl[:cno] = ControlFields.proc_field_cno(rec["id"])
						when 'gno'
							rec[tblnamechop+"_gno"] = @src_tbl[:gno] = ControlFields.proc_field_gno(rec["id"])
						end
					else
						case j_to_sfld   ###j_to_sfld.split("_")[0]   sno又はcno
						when /^sno_|^cno_/
							sno_strsql = %Q%select id from #{j_to_sfld.split("_")[1]}s where  #{j_to_sfld.split("_")[0]} = '#{k}'
										for update
							%
							srctblname = j_to_sfld.split("_")[1] + "s"
							srctblid =  ActiveRecord::Base.connection.select_value(sno_strsql)  ###ロックをかけておく
						end		
					end
				end
            end   ## if j_to_s.
		end ## rec.each
        @src_tbl[:persons_id_upd] = rec["#{tblnamechop}_person_id_upd"] = (@sio_user_code||=0) ###performでの処理では@sio_user_code=nil
		@src_tbl[:updated_at] = rec["#{tblnamechop}_updated_at"] = Time.now
		return rec,srctblname,srctblid
	end

    def undefined
    	nil
    end

	def init_from_screen email,screenCode  ### current_user = current_api_user
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

	def create_grid_columns_info screen_code,email
			grid_columns_info = Rails.cache.fetch('screenfield'+grp_code(email)+screen_code) do
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
                		###page_info[:sizePerPage] = i["screen_rows_per_page"].to_i
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
	
	def proc_create_grid_editable_columns_info screen_code,email,req
		grid_columns_info = Rails.cache.fetch('screenfield'+grp_code(email)+screen_code) do
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
				##if i["screenfield_selection"] == "0" or i["pobject_code_sfd"] == "id" or i["pobject_code_sfd"] =~ /_id/ 		
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
	
	def create_download_columns_info screen_code,email
		download_columns_info = Rails.cache.fetch('download'+grp_code(email)+screen_code) do
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

	def proc_tbl_add_arel  tblname,tblarel ##
		fields = ""
		values = ""
		tblarel.each do |key,val|
			fields << key.to_s + ","
			strsql = %Q&select fieldcode_ftype from r_fieldcodes
						where  pobject_code_fld = '#{if tblname.downcase =~ /^sio|^bk/ then key.to_s.split("_",2)[1] else key.to_s end}'&
			ftype = ActiveRecord::Base.connection.select_value(strsql)
			 	values << 	case ftype
			 			when /char/  ###db type
			 				%Q&'#{(val||="").gsub("'","''")}',&
			 			when "numeric"
			 				"#{(val||="").to_s.gsub(",","")},"
						when /timestamp|date/  ##db type
							case (val||="").class.to_s  ### ruby type
							when  /Time|Data/
								case key.to_s
			 					when "created_at","updated_at"
			 						%Q& to_timestamp('#{val.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),&
								when "expiredate"
									%Q& to_date('#{val.strftime("%Y/%m/%d")}','yyyy/mm/dd'),&
			 					else
									%Q& to_timestamp('#{val.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),&
								end
							when "String"	 
								case key.to_s
			 					when "created_at","updated_at"
			 						%Q& to_timestamp('#{val.gsub("-","/")}','yyyy/mm/dd hh24:mi:ss'),&
								when "expiredate"
									%Q& to_date('#{val.gsub("-","/")}','yyyy/mm/dd'),&
			 					else
									%Q& to_timestamp('#{val.gsub("-","/")}','yyyy/mm/dd hh24:mi:ss'),&
								end
							else
							   Rails.logger.debug " line #{__LINE__} : error val.class #{ftype}  key #{key.to_s} "
							   p " line #{__LINE__} : error val.class #{ftype}  key #{key.to_s} "
							end	
						else
							if tblname.downcase =~ /^sio_|^bk_/
								%Q&'#{val.to_s.gsub("'","''")}',&
							else
								Rails.logger.debug " line #{__LINE__} : error val.class #{ftype}  key #{key.to_s} "
								p " line #{__LINE__} : error val.class #{ftype}  key #{key.to_s} "
							end	
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
		strset = ""
		hash.each do |key,val|
			strsql = %Q&select fieldcode_ftype from r_fieldcodes where  pobject_code_fld = '#{key.to_s}'&
			ftype = ActiveRecord::Base.connection.select_value(strsql)
			strset << case ftype
			when /char/  ###db type
				%Q& #{key.to_s} = '#{val.gsub("'","''")}',&
			when "numeric"
				"#{key.to_s} = #{val.to_s.gsub(",","")},"
		   	when /timestamp|date/  ##db type
			   case val.class.to_s  ### ruby type
			   when  /Time|Data/
				   case key.to_s
					when "created_at","updated_at"
						%Q& #{key.to_s} =  to_timestamp('#{val.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),&
				   when "expiredate"
					   %Q&  #{key.to_s} = to_date('#{val.strftime("%Y/%m/%d")}','yyyy/mm/dd'),&
					else
						%Q&  #{key.to_s} = to_timestamp('#{val.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),&
				   end
			   when "String"	 
				   case key.to_s
					when "created_at","updated_at"
						%Q&  #{key.to_s} = to_timestamp('#{val.gsub("-","/")}','yyyy/mm/dd hh24:mi:ss'),&
				   	when "expiredate"
					   %Q&  #{key.to_s} = to_date('#{val.gsub("-","/")}','yyyy/mm/dd'),&
					else
						%Q&  #{key.to_s} = to_timestamp('#{val.gsub("-","/")}','yyyy/mm/dd hh24:mi:ss'),&
				   end
			   else
				  Rails.logger.debug " line #{__LINE__} : error val.class #{ftype}  key #{key.to_s} "
				  p " line #{__LINE__} : error val.class #{ftype}  key #{key.to_s} "
			   end	
			else
				if tblname.downcase =~ /^sio_|^bk_/
					%Q& #{key.to_s} = '#{val.to_s.gsub("'","''")}',&
				else
					Rails.logger.debug " line #{__LINE__} : error val.class #{ftype}  key #{key.to_s} "
					p " line #{__LINE__} : error val.class #{ftype}  key #{key.to_s} "
				end	
			end
		end
		ActiveRecord::Base.connection.update("update #{tblname}  set #{strset.chop} where #{strwhere} ")
	end

	def proc_tbl_delete_arel  tblname,strwhere ##
		ActiveRecord::Base.connection.delete("delete from  #{tblname}  where #{strwhere} ")
	end

	def add_update_srctbl srctblname,srctblid,tblname   ###sno,cnoでの前の状態との関係
		strsql = %Q% select id from srctbls where srctblid = #{srctblid} and srctblname = '#{srctblname}'
							and tblname = '#{tblname}' and tblid = #{@src_tbl[:id]}
				%
			rec = ActiveRecord::Base.connection.select_one(strsql)
			if rec
				strsql = %Q% update srctbls set  updated_at = to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
								qty_src = #{@src_tbl[:qty]||=@src_tbl[:qty_stk]} where id = #{rec["id"]}					
				%
				ActiveRecord::Base.connection.update(strsql) 
			else
				srctbls_seq = RorBlkctl.proc_get_nextval("srctbls_seq")
				sno_sym = ("sno_" + srctblname.chop).to_sym 
				cno_sym = ("cno_" + srctblname.chop).to_sym 
				strsql = %Q%insert into srctbls(id,
						srctblname,sno,cno,srctblid,
						tblname,tblid,qty_src,
						created_at,
						updated_at,
						update_ip,persons_id_upd,expiredate,remark)
					values(#{srctbls_seq},
						'#{srctblname}','#{@src_tbl[sno_sym]}','#{@src_tbl[cno_sym]}',#{srctblid}, 
						'#{tblname}',#{@src_tbl[:id]},#{@src_tbl[:qty]||=@src_tbl[:qty_stk]} , 
						to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						to_timestamp('#{Time.now.strftime("%Y/%m/%d %H:%M:%S")}','yyyy/mm/dd hh24:mi:ss'),
						' ',#{@sio_user_code||=0},'#{@src_tbl[:expiredate]}','')
				%
				ActiveRecord::Base.connection.insert(strsql) 
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
