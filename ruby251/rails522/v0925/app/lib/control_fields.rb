# -*- coding: utf-8 -*-
module ControlFields
### 個別項目　チェック
	extend self	
		
	def  proc_chk_fetch_rec params  
		params[:err] = ""
		fetch_data,mainviewflg,keys,findstatus,screendata,missing = get_fetch_rec params
	  	if findstatus
			if mainviewflg   ##mainviewflg = true 自分自身の登録
				if 	params[:parse_linedata]["aud"] == "add" or params["buttonflg"] =~ /add/
					params[:err] = "error duplicate code #{keys} "
					params[:keys] = []
					keys.split(",").each do |key| 
				  		params[:keys] =  [key.split(":")[0].gsub(" ","")] 
					end  
					params[:fetch_data] = {}
				else
					fetch_data.each do |key,val|
						params[:fetch_data] = {"id" => val}
					end
				end		
			else
				params[:fetch_data] = fetch_data
				keys.split(",").each do |key| ###コードが変更されたとき既に使用されている？
					if key =~/_code/
				  ###作成中
					end  
				end  
			end  
	  	else
			if mainviewflg 
				params[:fetch_data] = {}
			else
				if missing
					params[:fetch_data] = fetch_data
				else
					params[:err] =  "error   --->not find #{keys} "
					params[:fetch_data] = {}
				end	  
			end  
	  	end 
	  	##params["linedata"] = JSON.generate(fetch_data)
	  	return params 
	end  

	def get_fetch_rec params
			strsql = ""
			mainviewflg = true  ##自分自身の登録か？
			keys = ""
			fetch_data = {}
			tblnamechop = ""
			xno = ""
			srctblnamechop = ""
			fetchview = params[:fetchview].split(":")[0]  ##拡張子の確認
			tblnamechop = fetchview.split("_")[1].chop
			screendata = params[:parse_linedata]
			if params[:screenCode].split("_")[1] != fetchview.split("_")[1] 
					mainviewflg = false
			else
				if fetchview.split(":")[1]
					mainviewflg = false
				end	
			end	  
			fetcfieldgetsql = "select pobject_code_sfd from r_screenfields
								 where pobject_code_scr =  '#{params[:screenCode]}' 
								 and screenfield_paragraph = '#{params[:fetchview]}'"	
			delm = ""
			missing = false   ###missing:true パラメータが未だ未設定　　false:チェックok
			strsql = " select * from #{fetchview}  where "
			ActiveRecord::Base.connection.select_all(fetcfieldgetsql).each do |rec|
				xfield = screendata[rec["pobject_code_sfd"]].to_s.gsub(",","_") ###入力項目に「,」が入っていた時
				keys <<  "  #{rec["pobject_code_sfd"]} : '#{xfield}',"  ###入力項目に「,」が入っていた時
				if screendata[rec["pobject_code_sfd"]] == "" or screendata[rec["pobject_code_sfd"]].nil?   ###未入力
					missing = true
				else
					if rec["pobject_code_sfd"] 	=~ /_sno_|_cno_/
						tblnamechop,xno,srctblnamechop = rec["pobject_code_sfd"].split("_")
						strsql << " #{srctblnamechop}_#{xno} = '#{screendata[rec["pobject_code_sfd"]]}'       and"
					else
						delm = (params[:fetchview].split(":")[1]||="")  ###/_sno_|_cno_|_gno_/の時はdelm意味なし
						if delm == ""
							strsql << "  #{rec["pobject_code_sfd"]} = '#{screendata[rec["pobject_code_sfd"]]}'        and"
						else
							strsql << "  #{rec["pobject_code_sfd"].split(delm)[0]} = '#{screendata[rec["pobject_code_sfd"]]}'       and"
						end
					end
				end
				##fetch_data[rec["pobject_code_sfd"]+delm] = screendata[rec["pobject_code_sfd"]]	  ###rec 画面のフィード名レコード
			end
			if missing == false  ###検索のための入力項目はすべて入力されている。
				rec =  ActiveRecord::Base.connection.select_one(strsql[0..-8] + " limit 1")
			else
				rec = nil
			end
			if rec  ###viewレコードあり
				missing = false
				screendata.each do |key,val|  ###結果をセット
					items = key.split("_")
					if items[-1] == delm[1..-1]   ##delmは_(アンダーバー付き)
						field = items[0..-2].join("_")   ##delm(:)が3在った時
					else	
						field = items.join("_")
					end	
					if rec[field] and key !="id" and key !~ /person.*upd/ and field !~ /^#{params[:screenCode].split("_")[1].chop}/ 
						fetch_data[field+delm] =  rec[field] ###rec:検索結果
						case params[:screenCode]
							when /opeitms$/
								if screendata["opeitm_stktaking_proc"] == "" or screendata["opeitm_stktaking_proc"].nil?
									if screendata["classlist_code"] == "ship"
										fetch_data["opeitm_stktaking_proc"] = 0
									else
										fetch_data["opeitm_stktaking_proc"] = 1  ###在庫管理有
									end
								end
						end	
					else                ##tblnamechop idを持ったテーブル名
						if 	field =~ /^#{tblnamechop}/ and  rec[field.gsub(tblnamechop,srctblnamechop)] and
								field !~ /_isudate$|_sno$|_gno$|_cno$/ and field != "#{tblnamechop}_id" 
							fetch_data[field] =  rec[field.gsub(tblnamechop,srctblnamechop)]
						else ###gnoはまとめkeyのため対象外
							if  key	=~ /_sno_|_cno_/ and field =~ /^#{tblnamechop}/ and val != ""  and key !~ /_gridmessage/
								strsql = %Q% select sum(qty_src) qty_src 
												from srctbls  where #{key.split("_")[1]} = '#{val}' 
												and srctblname = '#{srctblnamechop}s'
								%  ###次のステータスに移行していないqty
								org =  ActiveRecord::Base.connection.select_one(strsql)
								strsql = %Q% select qty from #{srctblnamechop}s where #{key.split("_")[1]} = '#{val}'
								% 
								sno_qty = ActiveRecord::Base.connection.select_value(strsql)
								if org
									if tblnamechop =~ /act$/
										fetch_data["#{tblnamechop}_qty_stk"] =  sno_qty.to_f - org["qty_src"].to_f
										if fetch_data["#{tblnamechop}_qty_stk"] <= 0
											params[:err] =  "error   --->over qty"
										end	
									else
										fetch_data["#{tblnamechop}_qty"] = sno_qty.to_f - org["qty_src"].to_f
										if fetch_data["#{tblnamechop}_qty"] <= 0
											params[:err] =  "error   --->over qty"
										end	
									end
								else	
									fetch_data["#{tblnamechop}_qty"] = sno_qty.to_f 
								end
							else
							end
						end
					end
				end	
				field = params[:screenCode].split("_")[1].chop+"_"+tblnamechop+"_id"+delm
				if params[:parse_linedata][field]
					fetch_data[field] =  rec["id"]
				end
				field = tblnamechop+"_id"+delm
				if params[:parse_linedata][field] and fetchview.split("_")[1].chop == tblnamechop
					fetch_data[field] =  rec["id"]
				end	
				findstatus = true
			else
				fetch_data[params[:screenCode].split("_")[1].chop+"_"+tblnamechop+"_id"+delm] =  ""  ##再入力時のNgに対応
				findstatus = false
			end	
		return fetch_data,mainviewflg,keys,findstatus,screendata,missing
	end		

	def blkuky_check tbl,linedata   ###重複チェック
		save_blkuky_grp = nil
		keys = []
		err = {}
		strsql = %Q% select blkuky_grp,pobject_code_fld from r_blkukys where pobject_code_tbl = '#{tbl}' 
						and blkuky_expiredate > current_date order by blkuky_grp,blkuky_seqno%
		ActiveRecord::Base.connection.select_all(strsql).each do |rec|
			if save_blkuky_grp != rec["blkuky_grp"] 
				if  !save_blkuky_grp.nil? and keys.exclude?("id")
					err = blkuky_check_detail tbl,keys,linedata,err
					keys = []
				end
				save_blkuky_grp = rec["blkuky_grp"]
			end
			keys << rec["pobject_code_fld"]
		end
		if !keys.empty? and keys.exclude?("id")  ### id付きの検索keysはたんなるindexのためskip
			err = blkuky_check_detail tbl,keys,linedata,err
		end
		return err
	end	

	def blkuky_check_detail tbl,keys,linedata,err
		strwhere = " where "
		tblchop = tbl.chop
		keys.each do |key|
			symkey = tblchop + "_" + key.gsub("s_id","_id")
			strwhere << "  #{key} = '#{linedata[symkey]}'     and "
		end
		strsql = "select id from #{tbl} " + strwhere[0..-5]
		recs = ActiveRecord::Base.connection.select_all(strsql)
		err[strwhere[6..-5]] = recs
		return err
	end

	def proc_judge_check_code params
		if params[:yupcheckcode]
			judge_code = JSON.parse(params[:yupcheckcode])
			checkstatus = true
			judge_code.each do |key,val|
				params = __send__("check_#{val.split(",")[0]}",params)  ###[1]: nil all,add,updateは画面側で判断
			end
		end
		return params 
	end	

	def check_paragraph params
		linedata = params[:parse_linedata]
		if linedata["screenfield_paragraph"] == ""
			if linedata["pobject_code_sfd"] =~ /_code/ and params[:screenCode].split("_")[1].chop == linedata["pobject_code_sfd"].split("_"[0])
				checkstatus = false
				params[:err] =  "error   --->view or field  #{linedata["screenfield_paragraph"]}　not find "
			else	
				checkstatus = true
			end
		else	
			if linedata["screenfield_paragraph"]
				screen,delm = linedata["screenfield_paragraph"].split(":",2)
				if linedata["pobject_code_sfd"] =~ /_sno_|_cno_|_gno_/
					case linedata["pobject_code_sfd"] 
					when /_sno_/
						field = linedata["pobject_code_sfd"].split("_sno_")[1] + "_sno"
					when /_cno_/
						field = linedata["pobject_code_sfd"].split("_cno_")[1] + "_cno"
					when /_gno_/
						field = linedata["pobject_code_sfd"].split("_gno_")[1] + "_gno"
					else
					end
				else
					if delm
						field =  linedata["pobject_code_sfd"].gsub(delm,"")
					else	
						field =  linedata["pobject_code_sfd"]
					end
				end
				strsql = %Q%select 1 from r_screenfields where pobject_code_scr ='#{screen}' and pobject_code_sfd = '#{field}' %
				rec = ActiveRecord::Base.connection.select_one(strsql)
				if rec
					checkstatus = true
				else
					checkstatus = false
					params[:err] =  "error   --->view or field  #{linedata["screenfield_paragraph"]}　not find "
				end
			end
		end
		return params
	end	

	def check_strorder params
		linedata = params[:parse_linedata]
		if linedata["screen_strorder"] and linedata["screen_strorder"] != ""
			ary_select_fields = linedata.keys
			sort_info = {}
			sort_info[:default] = linedata["screen_strorder"]
			sort_info = proc_detail_check_strorder sort_info,ary_select_fields
			if sort_info[:err] 
				params[:err] =  sort_info[:err] 
			else
				params[:err] =  nil
			end
		end
		return params
	end

	def  proc_detail_check_strorder sort_info,ary_select_fields
		##fields = sort_info[:default].split(/\s*,\s*/)
		sort_info[:default].split(/\s*,\s*/).each do |sort_field|
			ok = false
			sort_field.split(" ").each do |chk|
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
		end	
		return sort_info
	end	

	def check_qty params
		linedata = params[:parse_linedata]
		tblname =  params[:screenCode].split("_")[1]
		symqty = tblname.chop + "_qty"
		if linedata[tblname.chop + "_qty"]
			symqty = tblname.chop + "_qty"
		else
			symqty = tblname.chop + "_qty_stk"
		end

		if linedata[symqty] == ""
			checkstatus = false
			params[:err] =  "error   --->#{symqty} missing "
		else
			currtblnamechop = ""
			tblnamechop = "" 
			strsql = ""
			linedata.each do |key,val|
				case key.to_s
					when  /_sno_/ ### ordからいきなり　actでの入力を認めている。
						if (tblnamechop == "" or  tblnamechop =~ /ord$/ or key.to_s =~ /dlv$/) and val != ""
							currtblnamechop,tblnamechop = key.to_s.split("_sno_")
							strsql = %Q%select id from #{tblnamechop}s  where sno = '#{val}' %
						end
					when  /_cno_/  
						if (tblnamechop == "" or  tblnamechop =~ /ord$/ or key.to_s =~ /dlv$/) and val != ""
							currtblnamechop,tblnamechop = key.to_s.split("_cno_")
							strsql = %Q%select id from #{tblnamechop}s  where cno = '#{val}' %
						end
					when  /_gno_/  
						if (tblnamechop == "" or  tblnamechop =~ /ord$/ or key.to_s =~ /dlv$/) and val != ""
							currtblnamechop,tblnamechop = key.to_s.split("_gno_")
							strsql = %Q%select id from #{tblnamechop}s  where gno = '#{val}' %
						end
				end
			end
			if 	strsql.size > 0
					tblids = ActiveRecord::Base.connection.select_values(strsql)	
					strsql = %Q%select sum(qty_pare) qty from trngantts where paretblname = '#{tblnamechop}s'
								and paretblid in(#{tblids.join(",")})
								and orgtblid = paretblid and paretblid = tblid
					%
					prev_qty = ActiveRecord::Base.connection.select_value(strsql)	
					if linedata[symqty].to_f  <= prev_qty.to_f   ### オーダ以上を許可するルール未設定
						checkstatus = true
					else
						checkstatus = false
						params[:err] =  "error ---> #{prev_qty} <　input qty:#{linedata[symqty]} "
					end
			end
			if linedata["id"] != "" and checkstatus == true ###更新の時のみ　ords-->insts  insts -->actsに既にどれだけ変化しているか？
				strsql = %Q%select sum(qty) qty from trngantts where tblname = '#{currtblnamechop}s'
								and tblid = #{linedata["id"]} group by  tblname,tblid
				%
				chng_qty = ActiveRecord::Base.connection.select_value(strsql)	
				chng_qty ||= 0.0  ###すでに次の状態に変化した数値
				if chng_qty.to_f <= linedata[symqty].to_f
					checkstatus = true
				else
					checkstatus = false
					params[:err] =  "error   ---> qty must be >= #{chng_qty} "
				end	
			end
		end
		return params
	end	

	def check_loca_code_to params
		linedata = params[:parse_linedata]
		tblname =  params[:screenCode].split("_")[1]
		id = linedata["#{tblname.chop}_id"]
		if id != ""  ###更新の時のみ　ords-->insts  insts -->actsに既にどれだけ変化しているか？
			sym = "loca_code_to"
			if linedata[sym] == ""
				checkstatus = false
				params[:err] =  "error   --->#{sym} missing "
			else
				strsql = %Q%select sum(qty) from trngantts where orgtblname ='#{tblname}' and orgtblid = #{id} 
						 and  tblid = #{id} and tblname = '#{tblname}' group by orgtblname,orgtblid,tblname,tblid %
				trn_qty = ActiveRecord::Base.connection.select_value(strsql)
				chng_qty ||= 0.0  ###すでに次の状態に変化した数値
				strsql = %Q%select loca_code_to,#{tblname.chop}_qty from r_#{tblname} where id = #{id} %
				rec = ActiveRecord::Base.connection.select_one(strsql)
				if (chng_qty != rec["#{tblname.chop}_qty"] or rec["#{tblname.chop}_qty"]  != trn_qty) and 
						linedata[sym] != rec["loca_code_to"]
					checkstatus = false
					params[:err] =  "error   ---> loca_code_to must be >= #{rec["loca_code_to"]} "
				end 
			end
		end
		return params
	end	

	###使用していない
	def check_itm_loca_nditm params  ###使用してない
		linedata = params[:parse_linedata]
		if linedata["itm_code_nditm"].size > 0 and  linedata["loca_code_nditm"].size > 0
			strsql = "select id from itms where code = '#{linedata["itm_code_nditm"]}' and expiredate > current_date"
			itms_id = ActiveRecord::Base.connection.select_value(strsql)
			if itms_id 
				strsql = "select id from locas where code = '#{linedata["loca_code_nditm"]}' and expiredate > current_date"
				locas_id = ActiveRecord::Base.connection.select_value(strsql)
				if locas_id
					opeitms = Operation.proc_get_opeitms_rec itms_id,locas_id,processseq = nil,priority = nil
					if opeitms
						checkstatus = true
					else
						checkstatus = false
						params[:err] =  "error   ---> opeitms not exists itm_code :#{linedata["itm_code_nditm"]}  loca_code :#{linedata["loca_code_nditm"]}"
					end
				else
					checkstatus = false
					params[:err] =  "error   ---> opeitms not exists loca_code :#{linedata["loca_code_nditm"]} "
				end		
			else
				checkstatus = false
				params[:err] =  "error   ---> opeitms not exists itm_code :#{linedata["itm_code_nditm"]} "
			end
		end
		return params
	end	

	def prevTbl
		{"purords"=>"purschs","purinsts"=>"purords","purdlvs"=>"purinsts","puracts"=>"purdlvs",
			"inspords"=>"inspschs","inspinsts"=>"inspords","inspacts"=>"inspinsts",
			"prdords"=>"prdschs","prdinsts"=>"prdords","prdacts"=>"prdinsts",
			"payords"=>"payschs","payinsts"=>"payords","payacts"=>"payinsts",
			"billords"=>"billschs","billinsts"=>"billords","billacts"=>"billinsts",
			"shpords"=>"shpschs","shpinsts"=>"shpords","shpacts"=>"shpinsts"}
	end
	def prevStatus
		{"purords"=>"pursch","purinsts"=>"purord","purdlvs"=>"purinsts","puracts"=>"purdlvs",
			"prdords"=>"prdsch","prdinsts"=>"prdord","prdacts"=>"prdinst",
			"payords"=>"paysch","payinsts"=>"payord","payacts"=>"payinst",
			"billords"=>"billsch","billinsts"=>"billord","billacts"=>"billinst",
			"shpords"=>"shpsch","shpinsts"=>"shpord","shpacts"=>"shpinst"}
	end

	def nextTbl
		{"purschs"=>"purords","purords"=>"purinsts","purinsts"=>"purdlvs","purdlvs"=>"puracts",
			"inspschs"=>"inspords","inspords"=>"inspinsts","inspinsts"=>"inspacts",
			"prdschs"=>"prdords","prdords"=>"prdinsts","prdinsts"=>"prdacts",
			"payschs"=>"payords","payords"=>"payinsts","payinsts"=>"payacts",
			"billschs"=>"billords","billords"=>"billinsts","billinsts"=>"billacts",
			"shpschs"=>"shpords","shpords"=>"shpinsts","shpinsts"=>"shpacts"}
	end

	def proc_snolist   ###reqparams["segment"] = ["trn_org"]の対象でもある。
		{"purschs"=>"PS","purords"=>"PE","purinsts"=>"PH","purdlvs"=>"PV","puracts"=>"PA","purrets"=>"PR",
			"inspschs"=>"IS","inspords"=>"IE","inspinsts"=>"IH","inspacts"=>"IA","insprets"=>"IR",
			"prdschs"=>"MS","prdords"=>"ME","prdinsts"=>"MH","prdacts"=>"MA","prdrets"=>"MR",
			"billschs"=>"BS","billords"=>"BE","billinsts"=>"BH","billacts"=>"BA","billrets"=>"BR",
			"payschs"=>"YS","payords"=>"YE","payinsts"=>"YH","payacts"=>"YA","payrets"=>"YR",
			"custschs"=>"CS","custords"=>"CE","custinsts"=>"YH","custacts"=>"YA","custrets"=>"YR",
			"shpschs"=>"SS","shpords"=>"SE","shpinsts"=>"SH","shpacts"=>"SA","shprets"=>"SR"}
	end

	def mkTblListByTbl   ###例:指示テーブル等を使用せずordsから直接snoを入力してpuractsを作成
		{"purmk1s"=>["purords","purinsts","purdlvs"],
			"purords"=>["inspords"],	
			"puracts"=>["inspinsps"]
		}
	end 

	def mkTblListByOpeitms   ##
		{"opeitm_acceptance_proc"=>{"purords"=>["payschs"],"puracts"=>["payords"],"custords"=>["billschs"],"custacts"=>["billords"]}}
	end 
 
	### prd,pur,shp ・・・schs,ords,insts,acts,retsのレコード作成　	
	def proc_fields_update parent,paretblname
		@command_c = {}
		@para = {}
		yield @command_c,@para   ###@para 子供自身の員数等
		parent.each do |key,val|
			case key
				when /^opeitm_loca_id/
					@para["parent_locas_id"] = val
				when	/opeitm_processseq$/
					@para["parent_processseq"] = val
				when /#{paretblname.chop}_starttime/
					@para["parent_starttime"] = val.to_date
				when  /#{paretblname.chop}_chrg_id/
					@para["chrgs_id"] = val
				when /#{paretblname.chop}_qty$/
					@para["parent_qty"] = val.to_f
				when  /#{paretblname.chop}_prjno_id/
					@para["parent_prjno_id"] = val
				when  /opeitm_packqty/
					@para["packqty"] = val.to_f
			end
		end	
		@command_c[:sio_message_contents] = nil
		@command_c[:sio_recordcount] = 1
		@command_c[:sio_result_f] =   "0"  

		@tblnamechop = @command_c[:sio_viewname].split("_")[1].chop
		@command_c[:sio_code] =  @command_c[:sio_viewname] if @command_c[:sio_code].nil?

		strsql =  %Q%select pobject_code_fld from r_tblfields where tblfield_expiredate > current_date and 
						id in (select id from r_tblfields 
									where pobject_code_tbl = '#{@command_c[:sio_code].split("_")[1]}')
						order by tblfield_seqno
		%
		fields = ActiveRecord::Base.connection.select_values(strsql)
		fields.each do |fd|
			###lotnoはpur,prd項目ではないのでここにはない。
			cnoflg = false
			gnoflg = false
			case fd
				when "autocreate_act"
						field_autocreate_act 
				when "autocreate_inst"
						field_autocreate_inst 
				when "autocreate_ord"
						field_autocreate_ord_autoord_p 
				when "chrgs_id"
						field_chrgs_id 
				when "cno"  ###画面の時用にror_blkctl.set_src_tblでもsetしてる
						if (@command_c["#{@tblnamechop}_cno"].nil? or @command_c["#{@tblnamechop}_cno"] == "") and
								(!@command_c["id"].nil? and  @command_c["id"] != "")
							@command_c["#{@tblnamechop}_cno"]  = proc_field_cno @command_c["id"]
						else
							cnoflg = true
						end
				when "confirm"
						field_confirm
				when "consumauto"  ###
						field_consumauto
				when "consumtype"  ###proc_create_table_from_nditmの時は常にopeitmsから
						field_consumtype
				when "duedate"  ###稼働日計算
						field_duedate
				when "expiredate"
						field_expiredate
				when "gno" ###画面の時用にror_blkctl.set_src_tblでもsetしてる
					if @command_c["#{@tblnamechop}_gno"].nil? or @command_c["#{@tblnamechop}_gno"]  == "" and
							(!@command_c["id"].nil? and @command_c["id"] != "")
						@command_c["#{@tblnamechop}_gno"]   = proc_field_gno @command_c["id"]
					else
						gnoflg = true
					end
				when "id"  ###追加または更新の判断
						field_tblid
						if (@command_c["#{@tblnamechop}_cno"].nil? or @command_c["#{@tblnamechop}_cno"] == "") and cnoflg 
							@command_c["#{@tblnamechop}_cno"]  = proc_field_cno @command_c["id"]
						end  ###cnoセット時にまだ　idが決定してなかった。
						if (@command_c["#{@tblnamechop}_gno"].nil? or @command_c["#{@tblnamechop}_gno"]  == "") and  gnoflg
							@command_c["#{@tblnamechop}_gno"]   = proc_field_gno @command_c["id"]
						end
				when "isudate"
						if @command_c[:sio_classname] == "_add_update_grid_line_data"
							field_isudate 
						end
				when "locas_id_to"
						field_locas_id_to
				when "opeitms_id"
						field_opeitms_id fd
				when "price"  ###保留
						field_price_amt_tax_contract_price 
				when "processseq_pare"
						field_processseq_pare
				when "prjnos_id"
						field_prjnos_id
				when "qty"
						field_qty 
				when "qty_case"
						field_qty_case 
				when "qty_stk"
						field_qty_stk 
				when "starttime"  ###稼働日計算
						field_starttime
				when "shelfnos_id_to"
						field_shelfnos_id_to
				when "sno"  ###tblfield_seqnoはidの後であること。###画面の時用にror_blkctl.set_src_tblでもsetしてる
						@command_c["#{@tblnamechop}_sno"]  = proc_field_sno(@tblnamechop,@command_c["id"])
				when "suppliers_id"
						field_suppliers_id
				when "workplaces_id"
						field_workplaces_id
				when "crrs_id_pur"
						field_crrs_id_pur
			end	
		end		
		return @command_c
	end	 

	def	field_tblid
		if @command_c["id"] == "" or  command_c["id"].nil?
			@command_c[:sio_classname] = "_add_update_grid_line_data"
			@command_c["id"] =  RorBlkctl.proc_get_nextval("#{@tblnamechop}s_seq")
	 	else         
			@command_c[:sio_classname] = "_edit_update_grid_line_data"
	 	end   
		@command_c["#{@tblnamechop}_id"] = @command_c["id"]
	end	

	def field_confirm
		@command_c["#{@tblnamechop}_confirm"] = false if @command_c["#{@tblnamechop}_confirm"].nil? or  @command_c["#{@tblnamechop}_confirm"] == ""
	end	

	def field_opeitms_id fd
		key = @tblnamechop + "_" + fd.sub("s_id","_id")
		@command_c[key] = @para["opeitms_id"]  ###  変更はないはず
	end

	def field_locas_id_to 
		@command_c["#{@tblnamechop}_loca_id_to"] = @para["locas_id_fm"] ##
	end 

	def field_suppliers_id 
		strsql = %Q%select  id from suppliers where locas_id_supplier = #{@para["locas_id"]}
		%
		id = ActiveRecord::Base.connection.select_value(strsql)
		###supplier_code = dummy は必須 id = 0
		id ||= 0
		@command_c["#{@tblnamechop}_supplier_id"] = id ##
	end 

	def field_workplaces_id 
		strsql = %Q%select  id from workplaces where locas_id_workplace = #{@para["locas_id"]}
		%
		id = ActiveRecord::Base.connection.select_value(strsql)
		###worlplace_code = dummy は必須 id = 0
		id ||= 0
		@command_c["#{@tblnamechop}_workplace_id"] = id ##
	end 

	def field_crrs_id_pur 
		@command_c["#{@tblnamechop}_crr_id_pur"] = @para["crrs_id_pur"]
	end 

	def field_shelfnos_id_to 
		@command_c["#{@tblnamechop}_shelfno_id_to"] = @para["shelfnos_id_to"] ##
	end 

	def field_processseq_pare 
		@command_c["#{@tblnamechop}_processseq_pare"] = @para["parent_processseq"] 
	end	

	def field_isudate
		@command_c["#{@tblnamechop}_isudate"] = Time.now.to_s if @command_c["#{@tblnamechop}_isudate"].nil? or @command_c["#{@tblnamechop}_isudate"] == ""
	end	 

	def field_duedate 
		duedate = @para["parent_starttime"].to_date - 1
		@command_c["#{@tblnamechop}_toduedate"] = @command_c["#{@tblnamechop}_duedate"] = duedate.to_s
	end

	def field_starttime
		starttime =  @command_c["#{@tblnamechop}_duedate"].to_date - @para["duration"]
		@command_c["#{@tblnamechop}_starttime"] = starttime.to_s
	end

	def field_chrgs_id 
		@command_c["#{@tblnamechop}_chrg_id"] = @para["chrgs_id"] if @command_c["#{@tblnamechop}_chrg_id"].nil? or  @command_c["#{@tblnamechop}_chrg_id"] == ""
	end	

	def field_qty 
		@command_c["#{@tblnamechop}_qty"] = @para["parent_qty"] * @para["chilnum"] / @para["parenum"]
		#consumunitqty等については親に合わせて計算する。
		#if @para["consumunitqty"] > 0
		#	rlst = (@command_c["#{@tblnamechop}_qty"] /  @para["consumunitqty"]).ceil
		#	@command_c["#{tblnamechop}_qty"] = @para["consumunitqty"] * rlst   ###消費単位
		#end	
		#if @para["consumminqty"] > @command_c["#{@tblnamechop}_qty"]
		#	@command_c["#{tblnamechop}_qty"] = @para["consumminqty"]  ###最小消費数
		#end	
	end	

	def field_qty_case 
		if @para["packqty"] > 0
			rlst = ( @command_c["#{@tblnamechop}_qty"] /  @para["packqty"]).ceil
			@command_c["#{@tblnamechop}_qty_case"] = @para["packqty"] *  rlst  ###購入数又は作成数
		else
			@command_c["#{@tblnamechop}_qty_case"] = @command_c["#{@tblnamechop}_qty"] 
		end	
	end	

	def field_qty_stk 
		@command_c["#{@tblnamechop}_qty_stk"] = @para["parent_qty"] * @para["chilnum"] / @para["parenum"]
		if @consumminqty > @command_c["#{@tblnamechop}_qty_stk"]
			@command_c["#{tblnamechop}_qty_stk"] = @para["consumunitqty"]
		end	
	end	

	def field_price_amt_tax_contract_price 
		@command_c["#{@tblnamechop}_price"] = 0 if @command_c["#{@tblnamechop}_price"].nil?
		@command_c["#{@tblnamechop}_amt"] = 0 if @command_c["#{@tblnamechop}_amt"].nil?
		@command_c["#{@tblnamechop}_tax"] = 0 if @command_c["#{@tblnamechop}_tax"].nil?
	end

	def proc_field_sno(tblnamechop,id)
		ControlFields.proc_snolist["#{tblnamechop}s"] + format('%05d', id) 
	end

	def proc_field_cno id 
		 format('%07d', id)
	end

	def proc_field_gno id
		 format('%07d', id) 
	end	

	def field_prjnos_id 
		@command_c["#{@tblnamechop}_prjno_id"] = @para["parent_prjno_id"] 
	end	

	def field_consumtype
		@command_c["#{@tblnamechop}_consumtype"] = @para["consumtype"] if @command_c["#{@tblnamechop}_consumtype"].nil? or  @command_c["#{@tblnamechop}_consumtype"] == ""
	end

	def field_consumauto
		@command_c["#{@tblnamechop}_consumauto"] = @para["consumauto"] if @command_c["#{@tblnamechop}_consumauto"].nil? or  @command_c["#{@tblnamechop}_consumauto"] == ""
	end

	def field_autocreate_ord_autoord_p opeitm_autocreate_ord,opeitm_autoord_p
		if @command_c["#{@tblnamechop}_autocreate_ord"].nil? or  @command_c["#{@tblnamechop}_autocreate_ord"] == "" 
			@command_c["#{@tblnamechop}_autocreate_ord"] = @para["autocreate_ord"] 
			@command_c["#{@tblnamechop}_autoord_p"] = @para["autoord_p"] 
		end
	end	

	def field_autocreate_inst 
		@command_c["#{@tblnamechop}_autocreate_inst"] = @para["autocreate_inst"] if @command_c["#{@tblnamechop}_autocreate_inst"].nil? or  @command_c["#{@tblnamechop}_autocreate_inst"] == ""
	end		

	def field_autocreate_act 
		@command_c["#{@tblnamechop}_autocreate_act"] = @para["autocreate_act"] if @command_c["#{@tblnamechop}_autocreate_act"].nil? or  @command_c["#{@tblnamechop}_autocreate_act"] == ""
	end	
		
	def field_expiredate
		@command_c["#{@tblnamechop}_expiredate"] = "2099/12/31" if @command_c["#{@tblnamechop}_expiredate"].nil? or @command_c["#{@tblnamechop}_expiredate"] == ""
	end	


 
end   ##module