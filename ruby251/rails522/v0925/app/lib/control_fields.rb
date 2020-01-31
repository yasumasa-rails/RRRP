# -*- coding: utf-8 -*-
module ControlFields
### 個別項目　チェック
	extend self	
		
	def  chk_fetch_rec params  
		fetch_data,mainviewflg,keys,findstatus,screendata,missing = get_fetch_rec params
	  	if findstatus
			if mainviewflg 
				if 	params[:parse_linedata]["aud"] == "add" or params["buttonflg"] =~ /add/  ##mainviewflg = true 自分自身の登録
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
			orgtblnamechop = ""
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
			delm = (params[:fetchview].split(":")[1]||="")
			missing = false   ###missing:true パラメータが未だ未設定　　false:チェックok
			strsql = " select * from #{fetchview}  where "
			ActiveRecord::Base.connection.select_all(fetcfieldgetsql).each do |rec|
				xfield = screendata[rec["pobject_code_sfd"]].to_s.gsub(",","_") ###入力項目に「,」が入っていた時
				keys <<  "  #{rec["pobject_code_sfd"]} : '#{xfield}',"  ###入力項目に「,」が入っていた時
				if screendata[rec["pobject_code_sfd"]] == "" or screendata[rec["pobject_code_sfd"]].nil?   ###未入力
					missing = true
				else
					if rec["pobject_code_sfd"] 	=~ /_sno_|_cno_|_gno_/
						tblnamechop,xno,orgtblnamechop = rec["pobject_code_sfd"].split("_")
						strsql << " #{orgtblnamechop}_#{xno} = '#{screendata[rec["pobject_code_sfd"]]}'       and"
					else
						if delm == ""
							strsql << "  #{rec["pobject_code_sfd"]} = '#{screendata[rec["pobject_code_sfd"]]}'        and"
						else
							strsql << "  #{rec["pobject_code_sfd"].split(delm)[0]} = '#{screendata[rec["pobject_code_sfd"]]}'       and"
						end
					end
				end
				fetch_data[rec["pobject_code_sfd"]] = screendata[rec["pobject_code_sfd"]]	
			end
			if missing == false
				rec =  ActiveRecord::Base.connection.select_one(strsql[0..-8] + " limit 1")
			else
				rec = nil
			end
			if rec
				missing = false
				screendata.each do |key,val|  ###結果をセット
					items = key.split("_")
					if items[-1] == delm[1..-1]   ##delmは_(アンダーバー付き)
						field = items[0..-2].join("_")
					else	
						field = items.join("_")
					end	
					if rec[field] and key !="id" and key !~ /person.*upd/ and field !~ /^#{params[:screenCode].split("_")[1].chop}/ 
						fetch_data[field+delm] =  rec[field]
					else
						if 	field =~ /^#{tblnamechop}/ and  rec[field.gsub(tblnamechop,orgtblnamechop)] and
								field !~ /_isudate$|_sno$|_gno$|_cno$/ and field != "#{tblnamechop}_id"
							fetch_data[field] =  rec[field.gsub(tblnamechop,orgtblnamechop)]
						else
							if  field =~ /^#{tblnamechop}_qty_stk/ and rec["#{orgtblnamechop}_qty"] 
								strsql = %Q% select sum(qty) qty,sum(qty_stk) qty_stk from trngantts
												where tblname = '#{orgtblnamechop}s' and tblid = #{rec["id"]}
								%  ###次のステータスに移行していないqty
								org =  ActiveRecord::Base.connection.select_one(strsql)
								if tblnamechop =~ /act$/
									if  orgtblnamechop =~ /act$/
										fetch_data["#{tblnamechop}_qty_stk"] = org["qty_stk"] 
									else
										fetch_data["#{tblnamechop}_qty_stk"] = org["qty"]
									end
								else
									if  orgtblnamechop =~ /act$/
										fetch_data["#{tblnamechop}_qty"] = org["qty_stk"] 
									else
										fetch_data["#{tblnamechop}_qty"] = org["qty"]
									end
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
				if  !save_blkuky_grp.nil?
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

	def judge_check_code params
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
		sno = linedata["#{tblname.chop}_sno_#{prevStatus[tblname]}"]
		symqty = tblname.chop + "_qty"
		if linedata[symqty] == ""
			checkstatus = false
			params[:err] =  "error   --->#{symqty} missing "
		else
			currtblnamechop = ""
			tblnamechop = "" 
			linedata.each do |key,val|
				if key.to_s =~ /_sno_/  and !val.nil? and val != ""
					currtblnamechop,tblnamechop = key.to_s.split("_sno_")
					strsql = %Q%select id from #{tblnamechop}s  where sno = '#{sno}' %
				end
				tblid = ActiveRecord::Base.connection.select_value(strsql)	
				strsql = %Q%select sum(qty) qty from trngantts where tblname = '#{tblnamechop}s'
								and tblid = #{tblid} group by  tblname,tblid
				%
				prev_qty = ActiveRecord::Base.connection.select_value(strsql)	
				if linedata[symqty].to_f  <= prev_qty.to_f   ### オーダ以上を許可するルール未設定
						checkstatus = true
				else
						checkstatus = false
						params[:err] =  "error   --->  #{prev_qty} <　#{curr_qty}  + input qty:#{linedata[symqty]} "
				end	
				checkstatus = true
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

	def snolist   ###reqparams["segment"] = ["trn_org"]の対象でもある。
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
 
 
end   ##module