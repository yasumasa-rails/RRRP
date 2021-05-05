class CreateOtherTableRecordJob < ApplicationJob
    queue_as :default 
    def perform(pid)
        # 後で実行したい作業をここに書く
        begin
        ActiveRecord::Base.connection.begin_db_transaction()
            check = 1
            parent = {}
            until check.to_i < 1 do
                perform_strsql = "select * from  processreqs t 
                                where t.result_f = '0'  and t.seqno = #{pid} 
                                and not exists(select 1 from processreqs c where t.seqno = c.seqno and t.id > c.id
                                            and c.result_f != '1')
                                order by t.id limit 1 for update"
                processreq = ActiveRecord::Base.connection.select_one(perform_strsql)
                if processreq
                    strsql = %Q%update processreqs set result_f = '5'  where id = #{processreq["id"]}
                    %
                    ActiveRecord::Base.connection.update(strsql)
                    if processreq["paretblname"].size > 0
                        paretblname = processreq["paretblname"]
                        strsql = %Q%select * from  #{paretblname} where id = #{processreq["paretblid"]}%
                        ActiveRecord::Base.connection.select_one(strsql).each do |key,val| ###依頼元
                            parent[paretblname.chop + "_" + key.sub("s_id","_id")] = val   
                        end
                        if parent[paretblname.chop + "_opeitm_id"]
                            strsql = %Q&
                                select * from opeitms where id = #{parent[paretblname.chop + "_opeitm_id"]}
                            &
                            ActiveRecord::Base.connection.select_one(strsql).each do |key,val| ###依頼元
                                parent["opeitm_" + key.sub("s_id","_id")] = val   
                            end
                        end
                    else
                        parent = {}
                    end
                    reqparams = JSON.parse(processreq["reqparams"])
                    tbldata = reqparams["tbldata"]
                    strsql = %Q% select email from persons where id = #{tbldata["persons_id_upd"]}
                    %
                    email = ActiveRecord::Base.connection.select_value(strsql) ###
                    result_f = '1'
                    remark = "perform 26"
                    case reqparams["segment"]
                        when "skip" 
                        when "trngantts" ###prd,purのとき
                            reqparams = Operation.proc_trngantts processreq["tblname"],processreq["tblid"],
                                                    processreq["paretblname"],processreq["paretblid"],reqparams
                        when "opeitm_acceptance_proc"  ### opeitmsのフラグ処理
                            if parent.size > 0 
                                case processreq["tblname"]
                                    when "purords"  
                                        if parent["opeitm_acceptance_proc"] == "1"
                                            Operation.proc_createtable("purords","payschs",parent,email)
                                        end
                                    when "purrsltinputs"
                                        if parent["opeitm_acceptance_proc"] == "1"
                                            Operation.proc_createtable("purrsltinputs","payords",parent,email)
                                        end
                                end
                            else
                                result_f = '7'
                                remark = "opeitm_acceptance_proc parent table data nothing. delete #{processreq["paretblname"]} id= #{processreq["paretblid"]} ?" 
                            end
                        when "mkschs"  ### XXXXschs,ordsの時XXXschsを作成
                            ###依頼されたテーブルから子供を作成する。
                            strsql = %Q%select * from  #{processreq["tblname"]} where id = #{processreq["tblid"]}%
                            sch_parent = ActiveRecord::Base.connection.select_one(strsql) ###依頼元
                            strsql =%Q&
                                    select * from opeitms where id = #{sch_parent["opeitms_id"]}
                            &
                            ActiveRecord::Base.connection.select_one(strsql).each do |key,val|
                                sch_parent["opeitm_" + key.sub("s_id","_id")] = val
                            end
                            strsql = %Q%select * from nditms where expiredate > current_date and opeitms_id = #{tbldata["opeitms_id"]}%  
                            trnganttkey ||= 0  ###keyのカウンター
                            key = reqparams["trnganttkey"]
                            if key
                                reqparams["orgtrnganttkey"] = key 
                            else
                                reqparams["orgtrnganttkey"] = "00000"
                                key = ""
                            end   
                            ActiveRecord::Base.connection.select_all(strsql).each do |child|
                                command_r,opeitm = add_update_table_from_nditm  child,sch_parent,processreq["tblname"]
                                trnganttkey += 1
                                reqparams["trnganttkey"] = key + format('%05d', trnganttkey)
                                reqparams["child"] = child
                                reqparams["opeitm"] = opeitm  ###子部品のopeitms

                                RorBlkctl.proc_private_aud_rec(command_r,1,processreq["tblname"],processreq["tblid"],reqparams) 
                                command_r[:sio_result_f] =  "1"   ## 1 normal end
                                command_r[:sio_message_contents] = nil
                                tblname = command_r[:sio_viewname].split("_")[1]
                                tblid = command_r[(tblname.chop + "_id")] =  command_r["id"]
                                RorBlkctl.proc_insert_sio_r(command_r) #### if @pare_class != "batch"    ## 結果のsio書き込み
                            end 
                        when "sumrequest" 
                        when "splitrequest"  
                        when "createtable"
                            if parent.size > 0 
                                case processreq["tblname"]
                            ### 仕入れ先登録時仕入れ先の棚番自動登録
                                    when "suppliers"
                                        Operation.proc_createtable("suppliers","shelfnos",parent,email)
                            ### 作業場所の棚番自動登録
                                    when "workplaces"
                                        Operation.proc_createtable("workplaces","shelfnos",parent,email)
                                    when "custs"
                                        Operation.proc_createtable("custs","custrcvplcs",parent,email)
                                end
                            else
                                result_f = '7'
                                remark = "createtable parent table data nothing. delete #{processreq["paretblname"]} id= #{processreq["paretblid"]} ?" 
                            end    

                        when "mkords"  ###  xxxschsからxxxordsを作成。
                            mkordparams = {}
                            strsql = "select * from mkords where id =  #{reqparams["mkords_id"]} "
                            mkord = ActiveRecord::Base.connection.select_one(strsql)
                            mkordparams[:incnt] = mkord["incnt"].to_f
                            mkordparams[:inqty] = mkord["inqty"].to_f
                            mkordparams[:inamt] = mkord["inamt"].to_f
                            mkordparams[:outcnt] = mkord["outcnt"].to_f
                            mkordparams[:outqty] = mkord["outqty"].to_f
                            mkordparams[:outamt] = mkord["outamt"].to_f
                                mkordparams = Operation.proc_mkords email,reqparams,mkordparams
                                mkordparams[:message_code] = ""
                                mkordparams[:remark] = ""
                                strsql = %Q%update mkords set incnt = #{mkordparams[:incnt]},inqty = #{mkordparams[:inqty]},
                                                inamt = #{mkordparams[:inamt]},outcnt = #{mkordparams[:outcnt]},
                                                outqty = #{mkordparams[:outqty]},outamt = #{mkordparams[:outamt]} ,
                                                message_code = '#{mkordparams[:message_code]}',remark = '#{mkordparams[:remark]}'
                                                where id = #{reqparams["mkords_id"]}
                                %
                                ActiveRecord::Base.connection.update(strsql)
                        when "consume_child_parts"  ###qty_act子部品の消費 ###金型返却　###装置の解放
                            act_qty = tbldata["qty_stk"].to_f
                            strsql =%Q& select gantt.* ,c_alloc.id alloc_id, '#{processreq["tblname"]}' act_tblname,#{processreq["tblid"]} acttblid,
                                                ope.packqty packqty
                                            from trngantts gantt 
                                            inner join((alloctbls p_alloc inner join linktbls src 
                                                on p_alloc.srctblname = src.srctblname and p_alloc.srctblid = src.srctblid
                                                    and  src.tblname = '#{processreq["tblname"]}' and src.tblid =  #{processreq["tblid"]})
                                                    --- xxxactsからxxxords(insts)を求める p_alloc親のalloctbls
                                                    inner join trngantts  pare_trn on p_alloc.trngantts_id = pare_trn.id 
                                                        and pare_trn.paretblname = p_alloc.srctblname and pare_trn.paretblid = p_alloc.srctblid
                                                        and pare_trn.paretblname = pare_trn.orgtblname and pare_trn.paretblid = pare_trn.orgtblid )
                                                        --- 消費する親のords(insts)のfreeのtrnganttsを求める。xxxschsのtrnganttsを除く
                                                        on gantt.paretblid = p_alloc.srctblid  and gantt.paretblname = p_alloc.srctblname
                                            inner join alloctbls c_alloc on gantt.id = c_alloc.trngantts_id 
                                                --- c_alloc消費される子部品のalloctbls
                                            inner join opeitms ope on gantt.itms_id = ope.itms_id and gantt.processseq = ope.processseq     
                                                where ((c_alloc.qty - c_alloc.qty_linkto_alloctbl) > 0 and c_alloc.srctblname like '%schs') or
                                                        ( c_alloc.qty_linkto_alloctbl > 0 and c_alloc.srctblname not like '%schs') 
                                                and gantt.orgtblname = gantt.paretblname and gantt.orgtblid = gantt.paretblid
                                                and (gantt.tblname != gantt.paretblname or gantt.tblid != gantt.paretblid)
                                                for update    
                           &
                            ActiveRecord::Base.connection.select_all(strsql).each do |rec|
                                consumtype = (rec["consumtype"]||="")
                                consumtype = consumtype.gsub(" ","")
                                case consumtype
                                    when "con" ###子部品の消費
                                        Shipment.proc_consume_child_parts rec,act_qty,processreq["tblname"],processreq["tblid"]
                                    when "" ###子部品の消費
                                        Shipment.proc_consume_child_parts rec,act_qty,processreq["tblname"],processreq["tblid"]
                                end
                            end

                        when "consume_self_sch_parts"  ###qty_sch消費予定 ・・・
                            ###schs -->新規時親から作成するので親登録時には、まだ子供のtrnganttsはないので子供作成時に、消費を作成する。
                            strsql =%Q& select gantt.*  from trngantts gantt 
                                                where gantt.tblname = '#{processreq["tblname"]}' and gantt.tblid = #{processreq["tblid"]}
                                                and (gantt.tblname != gantt.paretblname or gantt.tblid != gantt.paretblid )
                                                and gantt.tblname like '%schs'
                                                and (gantt.paretblname like 'prd%' or gantt.paretblname like 'pur%') 
                                                ---and (gantt.qty - gantt.qty_linkto_alloctbl ) > 0 
                                                and (gantt.qty - gantt.qty_alloc) > 0 for update
                            &
                            ActiveRecord::Base.connection.select_all(strsql).each do |rec|
                                consumtype = (rec["consumtype"]||="con")
                                case consumtype  ###
                                when "con" ###子部品消費
                                    ###消費
                                    Shipment.proc_consume_self_sch_parts rec,processreq["paretblname"],parent
                                end
                            end
                    
                        when "consume_self_ord_parts"  ###ords,insts 自身の消費予定 ・・・
                            ###schs -->新規時親から作成するのでまだ子供のtrnganttsはないので子供作成時に、消費を作成する。
                            strsql =%Q& 
                                        select gantt.itms_id ,gantt.processseq,gantt.prjnos_id ,gantt.consumtype,
                                            (alloc.qty - alloc.qty_linkto_alloctbl  - alloc.qty_allocend)  qty,
                                            alloc.id alloctbls_id,
                                            gantt.paretblname,gantt.paretblid,gantt.expiredate
                                            from trngantts gantt 
                                            inner join alloctbls alloc 	on gantt.id = alloc.trngantts_id 
                                            where alloc.srctblname = '#{processreq["tblname"]}'  and alloc.srctblid = #{processreq["tblid"]}
                                            and		alloc.qty  > (alloc.qty_alloc + alloc.qty_linkto_alloctbl) 
                                            and (gantt.paretblname != gantt.tblname or gantt.paretblid != gantt.tblid) 
                                            and gantt.paretblname = gantt.orgtblname and gantt.paretblid = gantt.orgtblid
                                            and gantt.paretblname not like '%acts'  ---actsは除く"consume_child_parts"で対応
                                            and gantt.paretblname not like '%schs'  
                                            and gantt.paretblname not like 'cust%'  
                                &
                            ActiveRecord::Base.connection.select_all(strsql).each do |stkinout|
                                qty_case = tbldata["qty_case"].to_f
                                stkinout["packno"] =  if qty_case == 0 then "" else "packno" end
                                consumtype = (stkinout["consumtype"]||="con")
                                case consumtype  ###
                                when "con" ###子部品消費
                                    ###消費
                                    Shipment.proc_consume_self_ord_parts stkinout
                                end
                            end
                        when "consume_exception"
                            ###出庫の前の完成,完成時の員数可変による消費数対応

                    
                        when "mk_shpsch_by_prd_pursch"  ###qty_sch 自身の出庫 ・・・
                            ###schs -->新規時親から作成するので親登録時には、まだ子供のtrnganttsはないので子供作成時に、出庫を作成する。
                            strsql =%Q% select gantt.*,alloc.id alloc_id  from trngantts  gantt
                                                    inner join alloctbls alloc on gantt.id = alloc.trngantts_id 
                                                    where alloc.srctblname = '#{processreq["tblname"]}' and alloc.srctblid = #{processreq["tblid"]}
                                                    and (gantt.tblname != gantt.paretblname or gantt.tblid != gantt.paretblid)
                                                    ---and (alloc.qty - alloc.qty_linkto_alloctbl) > 0
                                                    ---child_trngantts でxxxordsを作成済　 alloc.qty_linkto_alloctbl > 0
                                                    for update
                               %
                            ActiveRecord::Base.connection.select_all(strsql).each do |rec|                                
                                consumtype = (rec["consumtype"]||="con")
                                consumtype = consumtype.gsub(/\s+/,"con")
                                processreq["alloc_id"] = rec["alloc_id"]
                                strsql = %Q& select locas_id_shelfno  from shelfnos shelf where shelf.id = #{tbldata["shelfnos_id_to"]}
                                    &
                                locas_id_shelfno = ActiveRecord::Base.connection.select_value(strsql)
                                case processreq["paretblname"]
                                    when /^prd/
                                        strsql =%Q&
                                            select locas_id_workplace from workplaces 
                                                    where id = #{parent[paretblname.chop+"_workplace_id"]}
                                        &
                                        pare_loca_id = ActiveRecord::Base.connection.select_value(strsql)
                                    when /^pur/      
                                        strsql =%Q&
                                            select locas_id_supplier from suppliers 
                                                    where id = #{parent[paretblname.chop+"_supplier_id"]}
                                        &
                                        pare_loca_id = ActiveRecord::Base.connection.select_value(strsql)
                                    when /^cust/    
                                        strsql =%Q&
                                            select locas_id_cust from custs
                                                    where id = #{parent[paretblname.chop+"_cust_id"]}
                                        &      
                                        pare_loca_id = ActiveRecord::Base.connection.select_value(strsql)
                                end 
                                case consumtype  ###
                                    when "con" ###消費のための子部品出庫
                                        if locas_id_shelfno != pare_loca_id 
                                            case  processreq["paretblname"]
                                                when /schs$/
                                                    Shipment.proc_create_shp processreq,email,pare_loca_id,parent,tbldata["shelfnos_id_to"] do
                                                        "sch"
                                                    end
                                                when  /ords$/   
                                                    Shipment.proc_create_shp processreq,email,pare_loca_id,parent,tbldata["shelfnos_id_to"] do
                                                        "ord"
                                                    end
                                                ##
                                                ##  alloctblsの変化で対応
                                                ##  
                                               ### Operation.proc_reset_shp processreq,reqparams
                                            end
                                        end
                                end
                            end
                        when "inputs"
                            fmtbl = processreq["tblname"]
                            case processreq["tblname"] 
                                when /pur/
                                    totbl = "puracts"
                                    qty_stk = parent["purrsltinput_qty"].to_f
                                    sym_qty_stk = "purrsltinput_qty_stk"
                                    sym_packno = "purrsltinput_packno"
                                when /prd/
                                    totbl = "prdacts"
                                    qty_stk = parent["prdsltinput_qty"].to_f
                                    sym_qty_stk = "prdrsltinput_qty_stk"
                                    sym_packno = "prdrsltinput_packno"
                            end    
                            packqty = parent["opeitm_packqty"].to_f
                            parent["opeitm_packno_proc"] = 0 if packqty <= 0  ###保険　画面でチェック済
                            case parent["opeitm_packno_proc"]
                                when "1"
                                    idx = 0
	 			                    packqty = parent["opeitm_packqty"].to_f
	 			                    until qty_stk <= 0 do
	 				                    parent[sym_packno] = format('%03d', idx)
                                        parent[sym_qty_stk] = packqty
                                       Operation.proc_createtable fmtbl,totbl,parent,email 
                                       qty_stk -=  packqty 
                                       idx += 1
	 			                    end
                            else
                                parent[sym_qty_stk] = qty_stk
                                Operation.proc_createtable fmtbl,totbl,parent,email
                            end
                    else  
                        result_f = '6'
                        remark = " program nothing for #{reqparams["segment"]} "  
                    end ## process   
                    strsql = %Q%update processreqs set result_f = '#{result_f}',remark = '#{remark}' where id = #{processreq["id"]}
                    %
                    ActiveRecord::Base.connection.update(strsql)
                end    
                check_strsql = "select id from  processreqs t 
                                where t.result_f = '0'  and t.seqno = #{pid} "
                check = ActiveRecord::Base.connection.select_value(check_strsql)
            end
        rescue
            ActiveRecord::Base.connection.rollback_db_transaction()
            ActiveRecord::Base.connection.begin_db_transaction()
            if processreq 
                strsql = %Q%update processreqs set result_f = '5'  where seqno = #{pid} and id < #{processreq["id"]}
                %
                ActiveRecord::Base.connection.update(strsql)
            end
            remark =  %Q% $@: #{$@[0..200]} :class #{self} : LINE #{__LINE__} $!: #{$!} %  ###evar not defined
            Rails.logger.debug"error rollback "
            Rails.logger.debug"error rollback "
            Rails.logger.debug"error rollback "
            Rails.logger.debug"error class #{self} : #{Time.now}: #{$@} "
            Rails.logger.debug"error class #{self} : $!: #{$!} "
            if processreq
                strsql = %Q%update processreqs set result_f = '9'  where seqno = #{pid} and id = #{processreq["id"]}
                %
                ActiveRecord::Base.connection.update(strsql)

                strsql = %Q%update processreqs set result_f = '8'  where seqno = #{pid} and id > #{processreq["id"]}
                %
                ActiveRecord::Base.connection.update(strsql)
            end
            if reqparams
                if reqparams["mkords"]
                    strsql = %Q%update mkords set incnt = #{mkordparams[:incnt]},inqty = #{mkordparams[:inqty]},
                            inamt = #{mkordparams[:inamt]},outcnt = #{mkordparams[:outcnt]},
                            outqty = #{mkordparams[:outqty]},outamt = #{mkordparams[:outamt]} ,
                            message_code = '#{mkordparams[:message_code]}',remark = ' error ===>rollback'
                            where id = #{reqparams["mkords_id"]}
                        %
                    ActiveRecord::Base.connection.update(strsql)
                end
            end
            ActiveRecord::Base.connection.commit_db_transaction()
        else
            ActiveRecord::Base.connection.commit_db_transaction()
        end  
    end
    
 
	###schsの追加	paretblname =~ /schs$|ords$/の時呼ばれる 
	def add_update_table_from_nditm  child,sch_parent,paretblname ### id processreqsのid child-->nditms  sch_parent ===> r_prd,pur XXXs
		opeitm  = RorBlkctl.proc_get_opeitms_rec(child["itms_id_nditm"],nil,child["processseq_nditm"],999)
        if paretblname =~ /ords/   ###ordsから schsを作成
            sch_parent["qty_sch"] = sch_parent["qty"] 
            sch_parent["amt_sch"] = sch_parent["amt"] 
            sch_parent.delete("qty") 
            sch_parent.delete("amt") 
        end
		command_r = ControlFields.proc_fields_update sch_parent,paretblname do |command_c,para|
			command_c[:sio_viewname] =  "r_"+ opeitm["prdpurshp"]+"schs" 
			command_c["id"]=""
			command_c["opeitm_loca_id_opeitm"] = opeitm["locas_id_opeitm"]
			para["opeitms_id"] = opeitm["id"]
			para["duration"] =  opeitm["duration"].to_f
			para["packqty"] =  opeitm["packqty"].to_f
			para["shelfnos_id_to"] = opeitm["shelfnos_id"]
			para["locas_id"] = opeitm["locas_id_opeitm"]  ###発注の時の作業場所
			para["parenum"] = child["parenum"].to_f
			para["chilnum"] = child["chilnum"].to_f
			para["locas_id_fm"] = child["locas_id_fm"]
			para["consumunitqty"] = child["consumunitqty"].to_f
			para["consumminqty"] = child["consumminqty"].to_f
			para["crrs_id"] = child["crrs_id"]  
		end
		return command_r,opeitm
    end
        
    def  custxxx_strsql tbldata
        strsql = %Q%select id from r_opeitms where itm_code = 'dummyship' and opeitm_processseq = 999
            %
        val  = ActiveRecord::Base.connection.select_value(strsql)
        if val.nil? ###nditmは自動作成
            p " missing item 'dummyship' please entry"
            p " missing item 'dummyship' please entry"
            p " missing item 'dummyship' please entry"
            raise
        end    ###opeitms itm_code : dummyship
        strsql = %Q&select itms_id,processseq from opeitms where id = #{tbldata["opeitms_id"]}
        &
        opeitm  = ActiveRecord::Base.connection.select_one(strsql)
        strsql = %Q%select * from nditms where expiredate > current_date and 
                opeitms_id = #{val} and itms_id_nditm = #{opeitm["itms_id"]} 
                and processseq_nditm = #{opeitm["processseq"]} limit 1
        %
        return strsql
    end
end