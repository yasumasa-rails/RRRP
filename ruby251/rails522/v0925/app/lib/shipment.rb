# -*- coding: utf-8 -*-
#shipment
# 2099/12/31を修正する時は　2100/01/01の修正も
module Shipmeny
	extend self
	def proc_mkshpinsts screenCode,clickIndex  ###screenCode:r_purords,r_prdords
		pagedata = []
		outcnt = 0
		shortcnt = 0
		err = ""
		shp = {}
		shp["inoutflg"] = "shp"
		clickIndex.each do |strselected|  ###-次のフェーズに進んでないこと。
			selected = JSON.parse(strselected)
			strsql = %Q&select * from #{screenCode} where id = #{selected["id"]}
			& 
			parent = ActiveRecord::Base.connection.select_one(strsql)
			strsql = %Q&select 
							gantt.itms_id,gantt.processseq,gantt.prjnos_id,
							gantt.shelfnos_id_fm shelfnos_id_out,gantt.starttime,
							alloc.srctblname,alloc.srctblid,gantt.expiredate,	alloc.id alloctbls_id,						
							(alloc.qty - 
								(alloc.qty_linkto_alloctbl + alloc.qty_alloc +  coalesce(inst.shp_qty,0))) qty 
							from trngantts gantt 
								inner join alloctbls alloc on gantt.id = alloc.trngantts_id
								inner join shelfnos shelf on gantt.shelfnos_id_fm = shelf.id
								left join (select sum(qty_stk) shp_qty ,shp.itms_id,shp.processseq from shpinsts as shp 
											where shp.paretblname =  '#{screenCode.split("_")[1]}'
											and shp.paretblid = #{selected["id"]}
											group by shp.itms_id,shp.processseq) as inst
									on gantt.itms_id = inst.itms_id and gantt.processseq = inst.processseq	
							where gantt.orgtblname = '#{screenCode.split("_")[1]}' and gantt.orgtblid = #{selected["id"]}
							and (gantt.orgtblname = gantt.paretblname or gantt.orgtblid = gantt.paretblid)
							and (gantt.orgtblname != gantt.tblname or gantt.orgtblid != gantt.tblid)
							and (alloc.qty - 
									(alloc.qty_linkto_alloctbl + alloc.qty_alloc +  coalesce(inst.shp_qty,0)))  > 0
							and gantt.locas_id_pare != shelf.locas_id_shelfno
			&
			ActiveRecord::Base.connection.select_all(strsql).each do |inout|
				allshpqty = inout["qty"].to_f
				opeitm = Operation.proc_get_opeitms_rec(inout["itms_id"],nil,inout["processseq"],nil)
				strsql = %Q&select max(lot.lotstkhist_starttime) starttime,
							max(lot.lotstkhist_itm_id) itms_id,max(lot.lotstkhist_processseq) processseq,
							lot.lotstkhist_shelfno_id shelfnos_id,
							lot.lotstkhist_lotno lotno,lot.lotstkhist_packno packno,max(lot.lotstkhist_prjno_id) prjnos_id,
							case lot.lotstkhist_shelfno_id when #{inout["shelfnos_id_out"]} then '0' else '1' end shelf_seq
							from r_lotstkhists lot inner join r_shelfnos shelf 
															on lot.shelfno_loca_id_shelfno = shelf.shelfno_loca_id_shelfno
							where lot.lotstkhist_itm_id = #{inout["itms_id"]} and lot.lotstkhist_processseq = #{inout["processseq"]}
							and  shelf.shelfno_id = #{inout["shelfnos_id_out"]} and lot.lotstkhist_prjno_id = #{inout["prjnos_id"]}
							group by lot.lotstkhist_shelfno_id,lot.lotstkhist_lotno,lot.lotstkhist_packno,shelf_seq
							order by shelf_seq,starttime desc,lot.lotstkhist_shelfno_id,lot.lotstkhist_lotno,lot.lotstkhist_packno
				&
				ActiveRecord::Base.connection.select_all(strsql).each do |tmplot|
					strsql = %Q&select * from lotstkhists where itms_id = #{tmplot["itms_id"]} and processseq = #{tmplot["processseq"]}
														and shelfnos_id = #{tmplot["shelfnos_id"]} and prjnos_id = #{tmplot["prjnos_id"]}
														and starttime = to_date('#{tmplot["starttime"]}','yyyy-mm-dd hh24:mi:ss')
					&
					ActiveRecord::Base.connection.select_all(strsql).each do |lot|
						    break if allshpqty == 0
							shp["qty"] = shp["qty_sch"] = 0
							shp["stktaking_proc"] = opeitm["stktaking_proc"]
							shp["starttime"]  = inout["starttime"]
							shp["alloctbls_id"]  = inout["alloctbls_id"]
							shp["shelfnos_id_out"]  = lot["shelfnos_id"]
							shp["itms_id"]  = lot["itms_id"]
							shp["prjnos_id"]  = lot["prjnos_id"]
							shp["processseq"]  = lot["processseq"]
							shp["lotno"]  = lot["lotno"]
							shp["packno"]  = lot["pack"]
							shp["expiredate"]  = lot["expiredate"]
							if allshpqty <= lot["qty_stk"].to_f
								shp["qty_stk"] = allshpqty
								shp["qty_shortage"] = 0
								allshpqty = 0
								packnos = Operation.proc_mk_outstks_rec shp,"add"
								packnos.each do |outstk|
									create_r_shpinsts outstk,shp,parent,screenCode
									reset_shpords outstk,shp,parent,screenCode,opeitm["packqty"].to_f
									outcnt += 1
								end	
								break
							else
								if opeitm["packno_flg"]  == "2"
									shortcnt += 1
									err << "stock short itms_id: #{tmplot["itms_id"]},processseq:#{tmplot["processseq"]}"
								else	
									if  lot["qty_stk"].to_f > 0
										shp["qty_stk"] = lot["qty_stk"].to_f
										allshpqty -=  lot["qty_stk"].to_f
										shp["qty_shortage"] = 0
									else	
										shp["qty_stk"] = allshpqty
										shp["qty_shortage"] = allshpqty
										allshpqty = 0
										shortcnt += 1
									end
									packnos = Operation.proc_mk_outstks_rec shp,"add"
									packnos.each do |outstk|
										create_r_shpinsts outstk,shp,parent,screenCode
										reset_shpords outstk,shp,parent,screenCode,opeitm["packqty"].to_f
										outcnt += 1
									end
								end
							end
					end
				end
				if allshpqty > 0
					if opeitm["packno_flg"]  == "2"
						shortcnt += 1
						err << "stock short itms_id: #{tmplot["itms_id"]},processseq:#{tmplot["processseq"]}"
					else	
						shp["itms_id"] = inout["itms_id"]  
						shp["processseq"] = inout["processseq"]  
						shp["shelfnos_id_out"] = inout["shelfnos_id_out"]  
						shp["prjnos_id"] = inout["prjnos_id"]
						shp["alloctbls_id"] = inout["alloctbls_id"]
						shp["starttime"] = inout["starttime"]
						shp["lotno"] = ""
						shp["packno"] = if opeitm["packqty"].to_f > 0 then "packno" else "" end
						shp["qty_sch"] = 0
						shp["qty"] = 0
						shp["qty_stk"] = allshpqty
						shp["qty_shortage"] = allshpqty
						shp["expiredate"]  = "2099/12/31"
						packnos = Operation.proc_mk_outstks_rec shp,"add"
						packnos.each do |outstk|
							create_r_shpinsts outstk,shp,parent,screenCode
							reset_shpords outstk,shp,parent,screenCode,opeitm["packqty"].to_f
							outcnt += 1
							shortcnt += 1
						end	
						allshpqty = 0
					end
				end
			end
		end  
		return outcnt,shortcnt,err
	end	

	
	def proc_shpact_confirmall params
		command_all = []
		pagedata = []
		outcnt = 0
		err = ""
		confirm_data = JSON.parse(params["confirm_data"])
		confirm_data.each do |selected|  ###-次のフェーズに進んでないこと。
			command_c = {}
			strsql = %Q&select * from r_shpinsts where id = #{selected["id"]}
			& 
			rec = ActiveRecord::Base.connection.select_one(strsql)
			strsql = %Q&select pobject_code_sfd from r_screenfields where pobject_code_scr = 'r_shpacts'
						and screenfield_expiredate > current_date and screenfield_selection = '1'
						and pobject_code_sfd like 'shpact_%' 
			& 
			fields = ActiveRecord::Base.connection.select_values(strsql)			
			rec.each do |key,val|
				if key !~ /_id/ and key != "id"
					if selected[key]
						commnad_r[key] =  selected[key]
					end
				end
				new_key = key.gsub("shpinst","shpact")
				if !(fields.select{|k| k == new_key}).empty?
					command_c[new_key] = rec[key]
				end
			end
			strsql  = %Q%select * from r_outstks  where  id = #{rec["shpinst_outstk_id"]} %
			r_outstks  = ActiveRecord::Base.connection.select_one(strsql)  ###更新後のr_instks
			strsql = %Q&select id from shelfnos where locas_id_shelfno = #{rec["shpinst_loca_id_to"]}
												and code = 'consume'
				&
			shelfnos_id = ActiveRecord::Base.connection.select_value(strsql)
			stkinout = Operation.proc_rinout_to_inout "outstk",r_outstks 
			stkinout["shelfnos_id_in"] = shelfnos_id
			stkinout["alloctbls_id"] = r_outstks["outstk_alloctbl_id"]
			stkinout["inoutflg"] = "shp"
			packnos =[{:packno=>r_outstks["outstk_packno"]}]
			instk_ids = Operation.proc_mk_instks_rec stkinout,packnos,"add"
			command_c["shpact_instk_id"] = instk_ids[0]
			command_c[:sio_code] =  command_c[:sio_viewname] =  "r_shpacts"
			command_c[:sio_message_contents] = nil
			command_c[:sio_recordcount] = 1
			command_c[:sio_result_f] =   "0"  
			command_c[:sio_classname] = "shpacts_add_"
			command_all << command_c
			outcnt += 1
		end  
		### このケースはバッチでないので results=nil
		RorBlkctl.proc_update_table_json(command_all,command_all.size,nil)
		return outcnt,err
	end	


	def proc_mkshpacts params,grid_columns_info
		tmp = []
		outcnt = 0
		err = ""
		strselect = "("
		(params["clickIndex"]).each do |selected|  ###-次のフェーズに進んでないこと。
			selected = JSON.parse(selected)
			strselect << selected["id"]+","
		end
		strselect = strselect.chop + ")"
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
			strsorting = "  order by paretblid,id desc "
			params[:sortBy] = "[]"
		end
		strsql = "select   #{grid_columns_info["select_fields"]} 
						from (SELECT ROW_NUMBER() OVER (#{strsorting}) , #{grid_columns_info["select_fields"]} 
												 FROM r_shpinsts inst where
												 shpinst_paretblname = '#{params["pareScreenCode"].split("_")[1]}' and
												 shpinst_paretblid = #{strselect} and 
												 not exists(select 1 from shpacts act where
													 paretblname = '#{params["pareScreenCode"].split("_")[1]}' and
													 paretblid = #{strselect} and 
													 act.itms_id = inst.shpinst_itm_id and
													 act.processseq = inst.shpinst_processseq) ) x
													where ROW_NUMBER > #{(params[:pageIndex].to_f)*params[:pageSize].to_f} 
													and ROW_NUMBER <= #{(params[:pageIndex].to_f + 1)*params[:pageSize].to_f} 
															  "
		pagedata = ActiveRecord::Base.connection.select_all(strsql)
		
		strsql = " select count(*) FROM r_shpinsts inst where
					shpinst_paretblname = '#{params["pareScreenCode"].split("_")[1]}' and
					shpinst_paretblid = #{strselect} and 
					not exists(select 1 from shpacts act where
						paretblname = '#{params["pareScreenCode"].split("_")[1]}' and
						paretblid = #{strselect} and 
						act.itms_id = inst.shpinst_itm_id and
						act.processseq = inst.shpinst_processseq)"
		 ###fillterがあるので、table名は抽出条件に合わず使用できない。
		totalCount = ActiveRecord::Base.connection.select_value(strsql)
		params[:pageCount] = (totalCount.to_f/params[:pageSize].to_f).ceil
		params[:totalCount] = totalCount.to_f
		return pagedata 
	end	
	
	def proc_refshpacts params,grid_columns_info
		tmp = []
		outcnt = 0
		err = ""
		strselect = "("
		(params["clickIndex"]).each do |selected|  ###-次のフェーズに進んでないこと。
			selected = JSON.parse(selected)
			strselect << selected["id"]+","
		end
		strselect = strselect.chop + ")"
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
			strsorting = "  order by paretblid,id desc "
			params[:sortBy] = "[]"
		end
		strsql = "select   #{grid_columns_info["select_fields"]} 
						from (SELECT ROW_NUMBER() OVER (#{strsorting}) , #{grid_columns_info["select_fields"]} 
												 FROM r_shpacts inst where
												 shpact_paretblname = '#{params["pareScreenCode"].split("_")[1]}' and
												 shpact_paretblid = #{strselect}  ) x
													where ROW_NUMBER > #{(params[:pageIndex].to_f)*params[:pageSize].to_f} 
													and ROW_NUMBER <= #{(params[:pageIndex].to_f + 1)*params[:pageSize].to_f} 
															  "
		pagedata = ActiveRecord::Base.connection.select_all(strsql)
		
		strsql = " select count(*) FROM r_shpacts act where
					shpact_paretblname = '#{params["pareScreenCode"].split("_")[1]}' and
					shpact_paretblid = #{strselect} "
		 ###fillterがあるので、table名は抽出条件に合わず使用できない。
		totalCount = ActiveRecord::Base.connection.select_value(strsql)
		params[:pageCount] = (totalCount.to_f/params[:pageSize].to_f).ceil
		params[:totalCount] = totalCount.to_f
		return pagedata 
	end	

	def create_r_shpinsts outstk,shp,pare,screenCode
		command_c = {}
		command_c[:sio_code] =  command_c[:sio_viewname] =  "r_shpinsts"
		command_c[:sio_message_contents] = nil
		command_c[:sio_recordcount] = 1
		command_c[:sio_result_f] =   "0"  
		command_c[:sio_classname] = "r_shpinsts_add_"
		command_c["shpinst_isudate"] = Time.now 
		paretblname = screenCode.split("_")[1]
		if screenCode =~ /prd/
			command_c["shpinst_loca_id_to"] = pare["workplace_loca_id_workplace"]
		else
			command_c["shpinst_loca_id_to"] = pare["supplier_loca_id_supplier"]
		end
		###
		command_c["shpinst_transport_id"] = 0   ###社外の時まだ未対応
		###
		command_c["shpinst_duedate"] = pare["#{paretblname.chop}_starttime"]
		command_c["shpinst_sno"] = "" 
		command_c["shpinst_gno"] = pare["#{paretblname.chop}_sno"] 
		command_c["shpinst_paretblname"] = paretblname
		command_c["shpinst_paretblid"] = pare["id"]
		command_c["shpinst_outstk_id"] = outstk[:outstks_id]
		command_c["shpinst_prjno_id"] = pare["#{paretblname.chop}_prjno_id"] 
		command_c["shpinst_chrg_id"] = pare["#{paretblname.chop}_chrg_id"] 
		command_c["shpinst_itm_id"] = shp["itms_id"]
		command_c["shpinst_shelfno_id_fm"] = shp["shelfnos_id_out"]
		command_c["shpinst_processseq"] = shp["processseq"]
		command_c["shpinst_qty_stk"] = shp["qty_stk"]
		command_c["shpinst_qty_shortage"] = if shp["qty_shortage"].to_f >= shp["qty_stk"].to_f
												 shp["qty_stk"] 
											else 
												shp["qty_shortage"] 
											end
		command_c["shpinst_qty"] = shp["qty"]
		command_c["shpinst_qty_case"] = 0
		command_c["shpinst_starttime"] = shp["starttime"]
		command_c["shpinst_expiredate"] = "2099/12/31"
		if pare["paretblname"] =~ /^pur/   ###tblname= 'feepayment'--->有償支給
		else	
			command_c["shpinst_price"] = 0
			command_c["shpinst_tax"] = 0
			command_c["shpinst_amt"] = 0
		end
		reqparams = RorBlkctl.proc_private_aud_rec  command_c,1,nil,nil,nil
	end

	def reset_shpords outstk,shp,pare,screenCode,packqty
		stkinout = {}
		stkinout["lotno"] =  ""   ###shpschs,shpordsの時は何もセットしない。
		stkinout["packno"] =  ""   ###shpschs,shpordsの時は何もセットしない。
		stkinout["alloctbls_id"] =  shp["alloctbls_id"]  
		qty = shp["qty_stk"]
		tblname = screenCode.split("_")[1]
		if screenCode =~ /ords$/
			strsql = %Q&select * from r_shpords 
						where shpord_paretblname = '#{tblname}' and shpord_paretblid = #{pare["id"]}
			&
			command_c = ActiveRecord::Base.connection.select_one(strsql)
			command_c[:sio_code] =  command_c[:sio_viewname] =  "r_shpords"
			command_c[:sio_message_contents] = nil
			command_c[:sio_recordcount] = 1
			command_c[:sio_result_f] =   "0"  
			command_c[:sio_classname] = "shpord_update_"
			command_c["shpord_qty"] = qty
			command_c["shpord_amt"] = qty * command_c["shpsch_price"].to_f
			###tax 未設定
			RorBlkctl.proc_private_aud_rec  command_c,1,nil,nil,nil
			stkinout["processseq"] = command_c["shpord_processseq"]
			stkinout["itms_id"] = command_c["shpord_itm_id"]
			stkinout["prjnos_id"] = command_c["shpord_prjno_id"]
			stkinout["shelfnos_id_out"] = command_c["shpord_shelfno_id_fm"]
			stkinout["expiredate"] = command_c["shpord_expiredate"]
			stkinout["starttime"]  = command_c["shpord_depdate"]
			stkinout["qty"]  = qty
			stkinout["qty_sch"]  = 0
			Operation.proc_mk_outstks_rec stkinout,"update"
		else  # prd,purinstsのもとのprd,purordsを求める。
			if !pare["sno_#{tblname.gsub("insts","ord")}"].nil? and pare["sno_#{tblname.gsub("insts","ord")}"] != ""
				strsql = %Q&select * from '#{tblname.gsub("insts","ord")}' where sno = #{pare["sno_#{tblname.gsub("insts","ord")}"]}
				&
				command_c = ActiveRecord::Base.connection.select_one(strsql)
				command_c[:sio_code] =  command_c[:sio_viewname] =  "r_shpords"
				command_c[:sio_message_contents] = nil
				command_c[:sio_recordcount] = 1
				command_c[:sio_result_f] =   "0"  
				command_c[:sio_classname] = "shpord_update_"
				command_c["shpord_qty"] = qty
				command_c["shpord_amt"] = qty * command_c["shpsch_price"].to_f
				###tax 未設定
				RorBlkctl.proc_private_aud_rec  command_c,1,nil,nil,nil
				stkinout["processseq"] = command_c[tblname.chop+"_processseq"]
				stkinout["itms_id"] = command_c["shpord_itm_id"]
				stkinout["prjnos_id"] = command_c["shpord_prjno_id"]
				stkinout["shelfnos_id_out"] = command_c["shpord_shelfno_id_fm"]
				stkinout["starttime"]  = command_c["shpord_depdate"]
				stkinout["expiredate"] = command_c["shpord_expiredate"]
				stkinout["qty"]  = qty
				stkinout["qty_sch"]  = 0
				Operation.proc_mk_outstks_rec stkinout,"update"
			else  ###ordsをまとめていた時
				if !pare["gno_#{tblname.gsub("insts","ord")}"].nil? and pare["gno_#{tblname.gsub("insts","ord")}"] != ""
					strsql = %Q&select * from '#{tblname.gsub("insts","ord")}' where gno = #{pare["gno_#{tblname.gsub("insts","ord")}"]}
					&
				esle
					Rails.logger.debug"error no detected shpords "
					Rails.logger.debug"error no detected shpords "
					Rails.logger.debug"error no detected shpords "
					raise	
				end
				ActiveRecord::Base.connection.select_all(strsql).each do |ord|
					strsql =  %Q&select * from r_shpords where shpord_paretblname = '#{tblname.gsub("insts","ord")}'
															 and shpord_paretblid = #{ord["id"]}
					&
					ActiveRecord::Base.connection.select_all(strsql).each do |command_c|
						if command_c["shpord_qty"].to_f >= qty
							new_qty = coomand_c["shpord_qty"].to_f - qty
							qty = 0
						else
							new_qty = 0
							qty -= command_c["shpord_qty"].to_f
						end
						command_c["shpord_qty"] = new_qty
						command_c[:sio_code] =  command_c[:sio_viewname] =  "r_shpords"
						command_c[:sio_message_contents] = nil
						command_c[:sio_recordcount] = 1
						command_c[:sio_result_f] =   "0"  
						command_c[:sio_classname] = "shpord_update_"
						command_c["shpord_qty"] = qty
						command_c["shpord_amt"] = qty * command_c["shpord_price"].to_f
						###tax 未設定
						RorBlkctl.proc_private_aud_rec  command_c,1,nil,nil,nil
						stkinout["processseq"] = command_c["shpord_processseq"]
						stkinout["itms_id"] = command_c["shpord_itm_id"]
						stkinout["prjnos_id"] = command_c["shpord_prjno_id"]
						stkinout["shelfnos_id_out"] = command_c["shpord_shelfno_id_fm"]
						stkinout["starttime"]  = command_c["shpord_depdate"]
						stkinout["expiredate"] = command_c["shpord_expiredate"]
						stkinout["qty"]  = new_qty
						stkinout["qty_sch"]  = 0
						Operation.proc_mk_outstks_rec stkinout,"update"
					end
				end	
			end
		end		
	end	
	
end    
