
  drop view if  exists r_purreplyinputs cascade ; 
 create or replace view r_purreplyinputs as select  
purreplyinput.starttime  purreplyinput_starttime,
purreplyinput.id id,
purreplyinput.id  purreplyinput_id,
purreplyinput.duedate  purreplyinput_duedate,
purreplyinput.message_code  purreplyinput_message_code,
purreplyinput.isudate  purreplyinput_isudate,
purreplyinput.expiredate  purreplyinput_expiredate,
purreplyinput.updated_at  purreplyinput_updated_at,
purreplyinput.qty  purreplyinput_qty,
purreplyinput.remark  purreplyinput_remark,
purreplyinput.created_at  purreplyinput_created_at,
purreplyinput.update_ip  purreplyinput_update_ip,
purreplyinput.persons_id_upd   purreplyinput_person_id_upd,
purreplyinput.contents  purreplyinput_contents,
purreplyinput.result_f  purreplyinput_result_f,
purreplyinput.qty_case  purreplyinput_qty_case,
purreplyinput.qty_case_bal  purreplyinput_qty_case_bal,
purreplyinput.confirm_ord  purreplyinput_confirm_ord,
purreplyinput.siosession  purreplyinput_siosession,
purreplyinput.sno  purreplyinput_sno,
purreplyinput.opeitms_id   purreplyinput_opeitm_id
 from purreplyinputs   purreplyinput,
  r_persons  person_upd ,  r_opeitms  opeitm 
  where       purreplyinput.persons_id_upd = person_upd.id      and purreplyinput.opeitms_id = opeitm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purreplyinputs;
 CREATE TABLE sio.sio_r_purreplyinputs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purreplyinputs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
          ,sio_Term_id varchar(30)
          ,sio_session_id numeric(22,0)
          ,sio_Command_Response char(1)
          ,sio_session_counter numeric(22,0)
          ,sio_classname varchar(50)
          ,sio_viewname varchar(30)
          ,sio_code varchar(30)
          ,sio_strsql varchar(4000)
          ,sio_totalcount numeric(22,0)
          ,sio_recordcount numeric(22,0)
          ,sio_start_record numeric(22,0)
          ,sio_end_record numeric(22,0)
          ,sio_sord varchar(256)
          ,sio_search varchar(10)
          ,sio_sidx varchar(256)
,purreplyinput_sno  varchar (40) 
,purreplyinput_qty_case  numeric (22,0)
,purreplyinput_qty_case_bal  numeric (38,0)
,purreplyinput_confirm_ord  varchar (1) 
,purreplyinput_siosession  varchar (20) 
,purreplyinput_starttime   timestamp(6) 
,purreplyinput_duedate   timestamp(6) 
,purreplyinput_qty  numeric (22,6)
,purreplyinput_result_f  varchar (1) 
,purreplyinput_isudate   timestamp(6) 
,purreplyinput_expiredate   date 
,purreplyinput_message_code  varchar (256) 
,purreplyinput_remark  varchar (4000) 
,purreplyinput_contents  varchar (4000) 
,purreplyinput_opeitm_id  numeric (38,0)
,id  numeric (38,0)
,purreplyinput_id  numeric (38,0)
,purreplyinput_updated_at   timestamp(6) 
,purreplyinput_created_at   timestamp(6) 
,purreplyinput_update_ip  varchar (40) 
,purreplyinput_person_id_upd  numeric (38,0)
          ,sio_errline varchar(4000)
          ,sio_org_tblname varchar(30)
          ,sio_org_tblid numeric(22,0)
          ,sio_add_time date
          ,sio_replay_time date
          ,sio_result_f char(1)
          ,sio_message_code char(10)
          ,sio_message_contents varchar(4000)
          ,sio_chk_done char(1)
);
 CREATE INDEX sio_r_purreplyinputs_uk1 
  ON sio.sio_r_purreplyinputs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purreplyinputs_seq ;
 create sequence sio.sio_r_purreplyinputs_seq ;
  drop view if  exists r_purrsltinputs cascade ; 
 create or replace view r_purrsltinputs as select  
purrsltinput.message_code  purrsltinput_message_code,
purrsltinput.shelfnos_id_in   purrsltinput_shelfno_id_in,
purrsltinput.sno_purord  purrsltinput_sno_purord,
purrsltinput.sno_purinst  purrsltinput_sno_purinst,
purrsltinput.cno_purinst  purrsltinput_cno_purinst,
purrsltinput.crrs_id   purrsltinput_crr_id,
purrsltinput.id id,
purrsltinput.id  purrsltinput_id,
purrsltinput.rcptdate  purrsltinput_rcptdate,
purrsltinput.sno  purrsltinput_sno,
purrsltinput.isudate  purrsltinput_isudate,
purrsltinput.expiredate  purrsltinput_expiredate,
purrsltinput.updated_at  purrsltinput_updated_at,
purrsltinput.qty  purrsltinput_qty,
purrsltinput.remark  purrsltinput_remark,
purrsltinput.created_at  purrsltinput_created_at,
purrsltinput.update_ip  purrsltinput_update_ip,
purrsltinput.persons_id_upd   purrsltinput_person_id_upd,
purrsltinput.contents  purrsltinput_contents,
purrsltinput.result_f  purrsltinput_result_f,
purrsltinput.qty_case  purrsltinput_qty_case,
purrsltinput.opeitms_id   purrsltinput_opeitm_id
 from purrsltinputs   purrsltinput,
  r_shelfnos  shelfno_in ,  r_crrs  crr ,  r_persons  person_upd ,  r_opeitms  opeitm 
  where       purrsltinput.shelfnos_id_in = shelfno_in.id      and purrsltinput.crrs_id = crr.id      and purrsltinput.persons_id_upd = person_upd.id      and purrsltinput.opeitms_id = opeitm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purrsltinputs;
 CREATE TABLE sio.sio_r_purrsltinputs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purrsltinputs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
          ,sio_Term_id varchar(30)
          ,sio_session_id numeric(22,0)
          ,sio_Command_Response char(1)
          ,sio_session_counter numeric(22,0)
          ,sio_classname varchar(50)
          ,sio_viewname varchar(30)
          ,sio_code varchar(30)
          ,sio_strsql varchar(4000)
          ,sio_totalcount numeric(22,0)
          ,sio_recordcount numeric(22,0)
          ,sio_start_record numeric(22,0)
          ,sio_end_record numeric(22,0)
          ,sio_sord varchar(256)
          ,sio_search varchar(10)
          ,sio_sidx varchar(256)
,purrsltinput_sno  varchar (40) 
,purrsltinput_sno_purord  varchar (50) 
,purrsltinput_sno_purinst  varchar (50) 
,purrsltinput_cno_purinst  varchar (50) 
,purrsltinput_message_code  varchar (256) 
,purrsltinput_rcptdate   timestamp(6) 
,purrsltinput_isudate   timestamp(6) 
,purrsltinput_expiredate   date 
,purrsltinput_qty  numeric (22,6)
,purrsltinput_result_f  varchar (1) 
,purrsltinput_qty_case  numeric (22,0)
,purrsltinput_remark  varchar (4000) 
,purrsltinput_contents  varchar (4000) 
,purrsltinput_opeitm_id  numeric (38,0)
,purrsltinput_created_at   timestamp(6) 
,purrsltinput_crr_id  numeric (22,0)
,id  numeric (38,0)
,purrsltinput_id  numeric (38,0)
,purrsltinput_update_ip  varchar (40) 
,purrsltinput_shelfno_id_in  numeric (38,0)
,purrsltinput_person_id_upd  numeric (38,0)
,purrsltinput_updated_at   timestamp(6) 
          ,sio_errline varchar(4000)
          ,sio_org_tblname varchar(30)
          ,sio_org_tblid numeric(22,0)
          ,sio_add_time date
          ,sio_replay_time date
          ,sio_result_f char(1)
          ,sio_message_code char(10)
          ,sio_message_contents varchar(4000)
          ,sio_chk_done char(1)
);
 CREATE INDEX sio_r_purrsltinputs_uk1 
  ON sio.sio_r_purrsltinputs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purrsltinputs_seq ;
 create sequence sio.sio_r_purrsltinputs_seq ;
  drop view if  exists r_purrets cascade ; 
 create or replace view r_purrets as select  
purret.retdate  purret_retdate,
purret.locas_id_fm   purret_loca_id_fm,
purret.suppliers_id   purret_supplier_id,
purret.crrs_id   purret_crr_id,
purret.id id,
purret.id  purret_id,
purret.opeitms_id   purret_opeitm_id,
purret.isudate  purret_isudate,
purret.contract_price  purret_contract_price,
purret.sno  purret_sno,
purret.prjnos_id   purret_prjno_id,
purret.chrgs_id   purret_chrg_id,
purret.qty_case  purret_qty_case,
purret.qty  purret_qty,
purret.price  purret_price,
purret.amt  purret_amt,
purret.tax  purret_tax,
purret.contents  purret_contents,
purret.remark  purret_remark,
purret.expiredate  purret_expiredate,
purret.persons_id_upd   purret_person_id_upd,
purret.update_ip  purret_update_ip,
purret.created_at  purret_created_at,
purret.updated_at  purret_updated_at
 from purrets   purret,
  r_locas  loca_fm ,  r_suppliers  supplier ,  r_crrs  crr ,  r_opeitms  opeitm ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_persons  person_upd 
  where       purret.locas_id_fm = loca_fm.id      and purret.suppliers_id = supplier.id      and purret.crrs_id = crr.id      and purret.opeitms_id = opeitm.id      and purret.prjnos_id = prjno.id      and purret.chrgs_id = chrg.id      and purret.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purrets;
 CREATE TABLE sio.sio_r_purrets (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purrets_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
          ,sio_Term_id varchar(30)
          ,sio_session_id numeric(22,0)
          ,sio_Command_Response char(1)
          ,sio_session_counter numeric(22,0)
          ,sio_classname varchar(50)
          ,sio_viewname varchar(30)
          ,sio_code varchar(30)
          ,sio_strsql varchar(4000)
          ,sio_totalcount numeric(22,0)
          ,sio_recordcount numeric(22,0)
          ,sio_start_record numeric(22,0)
          ,sio_end_record numeric(22,0)
          ,sio_sord varchar(256)
          ,sio_search varchar(10)
          ,sio_sidx varchar(256)
,purret_sno  varchar (40) 
,purret_retdate   date 
,purret_isudate   timestamp(6) 
,purret_contract_price  varchar (1) 
,purret_qty_case  numeric (22,0)
,purret_qty  numeric (22,6)
,purret_price  numeric (38,4)
,purret_amt  numeric (18,4)
,purret_tax  numeric (38,4)
,purret_expiredate   date 
,purret_contents  varchar (4000) 
,purret_remark  varchar (4000) 
,purret_updated_at   timestamp(6) 
,purret_person_id_upd  numeric (38,0)
,purret_update_ip  varchar (40) 
,purret_supplier_id  numeric (22,0)
,purret_crr_id  numeric (22,0)
,id  numeric (38,0)
,purret_id  numeric (38,0)
,purret_opeitm_id  numeric (38,0)
,purret_created_at   timestamp(6) 
,purret_prjno_id  numeric (38,0)
,purret_loca_id_fm  numeric (38,0)
,purret_chrg_id  numeric (38,0)
          ,sio_errline varchar(4000)
          ,sio_org_tblname varchar(30)
          ,sio_org_tblid numeric(22,0)
          ,sio_add_time date
          ,sio_replay_time date
          ,sio_result_f char(1)
          ,sio_message_code char(10)
          ,sio_message_contents varchar(4000)
          ,sio_chk_done char(1)
);
 CREATE INDEX sio_r_purrets_uk1 
  ON sio.sio_r_purrets(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purrets_seq ;
 create sequence sio.sio_r_purrets_seq ;
  drop view if  exists r_purests cascade ; 
 create or replace view r_purests as select  
purest.prjnos_id   purest_prjno_id,
purest.starttime  purest_starttime,
purest.crrs_id   purest_crr_id,
purest.id id,
purest.id  purest_id,
purest.confirm  purest_confirm,
purest.created_at  purest_created_at,
purest.updated_at  purest_updated_at,
purest.isudate  purest_isudate,
purest.duedate  purest_duedate,
purest.toduedate  purest_toduedate,
purest.qty  purest_qty,
purest.price  purest_price,
purest.amt  purest_amt,
purest.sno  purest_sno,
purest.suppliers_id   purest_supplier_id,
purest.expiredate  purest_expiredate,
purest.persons_id_upd   purest_person_id_upd,
purest.update_ip  purest_update_ip,
purest.tax  purest_tax,
purest.locas_id_to   purest_loca_id_to,
purest.processseq_pare  purest_processseq_pare,
purest.contents  purest_contents,
purest.opeitms_id   purest_opeitm_id,
purest.remark  purest_remark,
purest.chrgs_id   purest_chrg_id
 from purests   purest,
  r_prjnos  prjno ,  r_crrs  crr ,  r_suppliers  supplier ,  r_persons  person_upd ,  r_locas  loca_to ,  r_opeitms  opeitm ,  r_chrgs  chrg 
  where       purest.prjnos_id = prjno.id      and purest.crrs_id = crr.id      and purest.suppliers_id = supplier.id      and purest.persons_id_upd = person_upd.id      and purest.locas_id_to = loca_to.id      and purest.opeitms_id = opeitm.id      and purest.chrgs_id = chrg.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purests;
 CREATE TABLE sio.sio_r_purests (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purests_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
          ,sio_Term_id varchar(30)
          ,sio_session_id numeric(22,0)
          ,sio_Command_Response char(1)
          ,sio_session_counter numeric(22,0)
          ,sio_classname varchar(50)
          ,sio_viewname varchar(30)
          ,sio_code varchar(30)
          ,sio_strsql varchar(4000)
          ,sio_totalcount numeric(22,0)
          ,sio_recordcount numeric(22,0)
          ,sio_start_record numeric(22,0)
          ,sio_end_record numeric(22,0)
          ,sio_sord varchar(256)
          ,sio_search varchar(10)
          ,sio_sidx varchar(256)
,purest_sno  varchar (40) 
,purest_starttime   timestamp(6) 
,purest_expiredate   date 
,purest_confirm  varchar (1) 
,purest_isudate   timestamp(6) 
,purest_tax  numeric (38,4)
,purest_duedate   timestamp(6) 
,purest_processseq_pare  numeric (38,0)
,purest_toduedate   timestamp(6) 
,purest_amt  numeric (18,4)
,purest_qty  numeric (22,6)
,purest_price  numeric (38,4)
,purest_remark  varchar (4000) 
,purest_contents  varchar (4000) 
,purest_chrg_id  numeric (38,0)
,purest_crr_id  numeric (22,0)
,id  numeric (38,0)
,purest_id  numeric (38,0)
,purest_created_at   timestamp(6) 
,purest_updated_at   timestamp(6) 
,purest_supplier_id  numeric (22,0)
,purest_person_id_upd  numeric (38,0)
,purest_update_ip  varchar (40) 
,purest_loca_id_to  numeric (38,0)
,purest_opeitm_id  numeric (38,0)
,purest_prjno_id  numeric (38,0)
          ,sio_errline varchar(4000)
          ,sio_org_tblname varchar(30)
          ,sio_org_tblid numeric(22,0)
          ,sio_add_time date
          ,sio_replay_time date
          ,sio_result_f char(1)
          ,sio_message_code char(10)
          ,sio_message_contents varchar(4000)
          ,sio_chk_done char(1)
);
 CREATE INDEX sio_r_purests_uk1 
  ON sio.sio_r_purests(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purests_seq ;
 create sequence sio.sio_r_purests_seq ;
  drop view if  exists r_puracts cascade ; 
 create or replace view r_puracts as select  
puract.sno_purdlv  puract_sno_purdlv,
puract.sno_purord  puract_sno_purord,
puract.sno_purinst  puract_sno_purinst,
puract.cno_purinst  puract_cno_purinst,
puract.cno_purdlv  puract_cno_purdlv,
puract.chrgs_id   puract_chrg_id,
puract.itm_code_client  puract_itm_code_client,
puract.gno_purord  puract_gno_purord,
puract.gno_purinst  puract_gno_purinst,
puract.prjnos_id   puract_prjno_id,
puract.suppliers_id   puract_supplier_id,
puract.packno  puract_packno,
puract.crrs_id   puract_crr_id,
puract.crrs_id_pur   puract_crr_id_pur,
puract.shelfnos_id_to   puract_shelfno_id_to,
puract.id id,
puract.id  puract_id,
puract.qty_stk  puract_qty_stk,
puract.isudate  puract_isudate,
puract.sno  puract_sno,
puract.lotno  puract_lotno,
puract.cno  puract_cno,
puract.gno  puract_gno,
puract.expiredate  puract_expiredate,
puract.updated_at  puract_updated_at,
puract.remark  puract_remark,
puract.created_at  puract_created_at,
puract.update_ip  puract_update_ip,
puract.persons_id_upd   puract_person_id_upd,
puract.contents  puract_contents,
puract.rcptdate  puract_rcptdate,
puract.opeitms_id   puract_opeitm_id
 from puracts   puract,
  r_chrgs  chrg ,  r_prjnos  prjno ,  r_suppliers  supplier ,  r_crrs  crr ,  r_crrs  crr_pur ,  r_shelfnos  shelfno_to ,  r_persons  person_upd ,  r_opeitms  opeitm 
  where       puract.chrgs_id = chrg.id      and puract.prjnos_id = prjno.id      and puract.suppliers_id = supplier.id      and puract.crrs_id = crr.id      and puract.crrs_id_pur = crr_pur.id      and puract.shelfnos_id_to = shelfno_to.id      and puract.persons_id_upd = person_upd.id      and puract.opeitms_id = opeitm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_puracts;
 CREATE TABLE sio.sio_r_puracts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_puracts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
          ,sio_Term_id varchar(30)
          ,sio_session_id numeric(22,0)
          ,sio_Command_Response char(1)
          ,sio_session_counter numeric(22,0)
          ,sio_classname varchar(50)
          ,sio_viewname varchar(30)
          ,sio_code varchar(30)
          ,sio_strsql varchar(4000)
          ,sio_totalcount numeric(22,0)
          ,sio_recordcount numeric(22,0)
          ,sio_start_record numeric(22,0)
          ,sio_end_record numeric(22,0)
          ,sio_sord varchar(256)
          ,sio_search varchar(10)
          ,sio_sidx varchar(256)
,puract_cno  varchar (40) 
,puract_gno  varchar (40) 
,puract_sno  varchar (40) 
,puract_sno_purinst  varchar (50) 
,puract_cno_purinst  varchar (50) 
,puract_packno  varchar (10) 
,puract_cno_purdlv  varchar (50) 
,puract_isudate   timestamp(6) 
,puract_lotno  varchar (50) 
,puract_expiredate   date 
,puract_gno_purinst  varchar (50) 
,puract_qty_stk  numeric (22,6)
,puract_rcptdate   timestamp(6) 
,puract_sno_purdlv  varchar (50) 
,puract_sno_purord  varchar (50) 
,puract_itm_code_client  varchar (50) 
,puract_gno_purord  varchar (50) 
,puract_contents  varchar (4000) 
,puract_remark  varchar (4000) 
,puract_opeitm_id  numeric (38,0)
,puract_chrg_id  numeric (38,0)
,puract_prjno_id  numeric (38,0)
,puract_supplier_id  numeric (22,0)
,puract_crr_id  numeric (22,0)
,puract_crr_id_pur  numeric (22,0)
,puract_shelfno_id_to  numeric (38,0)
,id  numeric (38,0)
,puract_id  numeric (38,0)
,puract_updated_at   timestamp(6) 
,puract_created_at   timestamp(6) 
,puract_update_ip  varchar (40) 
,puract_person_id_upd  numeric (38,0)
          ,sio_errline varchar(4000)
          ,sio_org_tblname varchar(30)
          ,sio_org_tblid numeric(22,0)
          ,sio_add_time date
          ,sio_replay_time date
          ,sio_result_f char(1)
          ,sio_message_code char(10)
          ,sio_message_contents varchar(4000)
          ,sio_chk_done char(1)
);
 CREATE INDEX sio_r_puracts_uk1 
  ON sio.sio_r_puracts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_puracts_seq ;
 create sequence sio.sio_r_puracts_seq ;
  drop view if  exists r_purinsts cascade ; 
 create or replace view r_purinsts as select  
purinst.sno_purord  purinst_sno_purord,
purinst.prjnos_id   purinst_prjno_id,
purinst.chrgs_id   purinst_chrg_id,
purinst.itm_code_client  purinst_itm_code_client,
purinst.starttime  purinst_starttime,
purinst.autoact_p  purinst_autoact_p,
purinst.autocreate_act  purinst_autocreate_act,
purinst.crrs_id   purinst_crr_id,
purinst.replydate  purinst_replydate,
purinst.shelfnos_id_to   purinst_shelfno_id_to,
purinst.suppliers_id   purinst_supplier_id,
purinst.id id,
purinst.id  purinst_id,
purinst.qty_case  purinst_qty_case,
purinst.persons_id_upd   purinst_person_id_upd,
purinst.contract_price  purinst_contract_price,
purinst.cno  purinst_cno,
purinst.gno  purinst_gno,
purinst.tax  purinst_tax,
purinst.isudate  purinst_isudate,
purinst.expiredate  purinst_expiredate,
purinst.updated_at  purinst_updated_at,
purinst.opeitms_id   purinst_opeitm_id,
purinst.qty  purinst_qty,
purinst.sno  purinst_sno,
purinst.remark  purinst_remark,
purinst.created_at  purinst_created_at,
purinst.update_ip  purinst_update_ip,
purinst.price  purinst_price,
purinst.amt  purinst_amt,
purinst.duedate  purinst_duedate
 from purinsts   purinst,
  r_prjnos  prjno ,  r_chrgs  chrg ,  r_crrs  crr ,  r_shelfnos  shelfno_to ,  r_suppliers  supplier ,  r_persons  person_upd ,  r_opeitms  opeitm 
  where       purinst.prjnos_id = prjno.id      and purinst.chrgs_id = chrg.id      and purinst.crrs_id = crr.id      and purinst.shelfnos_id_to = shelfno_to.id      and purinst.suppliers_id = supplier.id      and purinst.persons_id_upd = person_upd.id      and purinst.opeitms_id = opeitm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purinsts;
 CREATE TABLE sio.sio_r_purinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
          ,sio_Term_id varchar(30)
          ,sio_session_id numeric(22,0)
          ,sio_Command_Response char(1)
          ,sio_session_counter numeric(22,0)
          ,sio_classname varchar(50)
          ,sio_viewname varchar(30)
          ,sio_code varchar(30)
          ,sio_strsql varchar(4000)
          ,sio_totalcount numeric(22,0)
          ,sio_recordcount numeric(22,0)
          ,sio_start_record numeric(22,0)
          ,sio_end_record numeric(22,0)
          ,sio_sord varchar(256)
          ,sio_search varchar(10)
          ,sio_sidx varchar(256)
,purinst_gno  varchar (40) 
,purinst_cno  varchar (40) 
,purinst_sno  varchar (40) 
,purinst_autoact_p  numeric (3,0)
,purinst_autocreate_act  varchar (1) 
,purinst_replydate   date 
,purinst_duedate   timestamp(6) 
,purinst_itm_code_client  varchar (50) 
,purinst_starttime   timestamp(6) 
,purinst_qty_case  numeric (22,0)
,purinst_contract_price  varchar (1) 
,purinst_tax  numeric (38,4)
,purinst_isudate   timestamp(6) 
,purinst_expiredate   date 
,purinst_qty  numeric (22,6)
,purinst_price  numeric (38,4)
,purinst_amt  numeric (18,4)
,purinst_sno_purord  varchar (50) 
,purinst_remark  varchar (4000) 
,purinst_created_at   timestamp(6) 
,purinst_updated_at   timestamp(6) 
,purinst_shelfno_id_to  numeric (38,0)
,purinst_supplier_id  numeric (22,0)
,id  numeric (38,0)
,purinst_id  numeric (38,0)
,purinst_opeitm_id  numeric (38,0)
,purinst_person_id_upd  numeric (38,0)
,purinst_update_ip  varchar (40) 
,purinst_crr_id  numeric (22,0)
,purinst_prjno_id  numeric (38,0)
,purinst_chrg_id  numeric (38,0)
          ,sio_errline varchar(4000)
          ,sio_org_tblname varchar(30)
          ,sio_org_tblid numeric(22,0)
          ,sio_add_time date
          ,sio_replay_time date
          ,sio_result_f char(1)
          ,sio_message_code char(10)
          ,sio_message_contents varchar(4000)
          ,sio_chk_done char(1)
);
 CREATE INDEX sio_r_purinsts_uk1 
  ON sio.sio_r_purinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purinsts_seq ;
 create sequence sio.sio_r_purinsts_seq ;
  drop view if  exists r_purschs cascade ; 
 create or replace view r_purschs as select  
pursch.crrs_id_pur   pursch_crr_id_pur,
pursch.crrs_id   pursch_crr_id,
pursch.qty_bal  pursch_qty_bal,
pursch.price  pursch_price,
pursch.remark  pursch_remark,
pursch.created_at  pursch_created_at,
pursch.update_ip  pursch_update_ip,
pursch.toduedate  pursch_toduedate,
pursch.isudate  pursch_isudate,
pursch.expiredate  pursch_expiredate,
pursch.duedate  pursch_duedate,
pursch.amt  pursch_amt,
pursch.updated_at  pursch_updated_at,
pursch.sno  pursch_sno,
pursch.id id,
pursch.id  pursch_id,
pursch.persons_id_upd   pursch_person_id_upd,
pursch.prjnos_id   pursch_prjno_id,
pursch.starttime  pursch_starttime,
pursch.qty  pursch_qty,
pursch.tax  pursch_tax,
pursch.shelfnos_id_to   pursch_shelfno_id_to,
pursch.opeitms_id   pursch_opeitm_id,
pursch.gno  pursch_gno,
pursch.qty_case  pursch_qty_case,
pursch.suppliers_id   pursch_supplier_id,
pursch.chrgs_id   pursch_chrg_id
 from purschs   pursch,
  r_crrs  crr_pur ,  r_crrs  crr ,  r_persons  person_upd ,  r_prjnos  prjno ,  r_shelfnos  shelfno_to ,  r_opeitms  opeitm ,  r_suppliers  supplier ,  r_chrgs  chrg 
  where       pursch.crrs_id_pur = crr_pur.id      and pursch.crrs_id = crr.id      and pursch.persons_id_upd = person_upd.id      and pursch.prjnos_id = prjno.id      and pursch.shelfnos_id_to = shelfno_to.id      and pursch.opeitms_id = opeitm.id      and pursch.suppliers_id = supplier.id      and pursch.chrgs_id = chrg.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purschs;
 CREATE TABLE sio.sio_r_purschs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purschs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
          ,sio_Term_id varchar(30)
          ,sio_session_id numeric(22,0)
          ,sio_Command_Response char(1)
          ,sio_session_counter numeric(22,0)
          ,sio_classname varchar(50)
          ,sio_viewname varchar(30)
          ,sio_code varchar(30)
          ,sio_strsql varchar(4000)
          ,sio_totalcount numeric(22,0)
          ,sio_recordcount numeric(22,0)
          ,sio_start_record numeric(22,0)
          ,sio_end_record numeric(22,0)
          ,sio_sord varchar(256)
          ,sio_search varchar(10)
          ,sio_sidx varchar(256)
,pursch_gno  varchar (40) 
,pursch_sno  varchar (40) 
,pursch_toduedate   timestamp(6) 
,pursch_isudate   timestamp(6) 
,pursch_starttime   timestamp(6) 
,pursch_qty  numeric (22,6)
,pursch_tax  numeric (38,4)
,pursch_qty_bal  numeric (22,6)
,pursch_duedate   timestamp(6) 
,pursch_qty_case  numeric (22,0)
,pursch_amt  numeric (18,4)
,pursch_expiredate   date 
,pursch_price  numeric (38,4)
,pursch_remark  varchar (4000) 
,pursch_chrg_id  numeric (38,0)
,pursch_crr_id  numeric (22,0)
,pursch_created_at   timestamp(6) 
,pursch_update_ip  varchar (40) 
,pursch_updated_at   timestamp(6) 
,id  numeric (38,0)
,pursch_id  numeric (38,0)
,pursch_person_id_upd  numeric (38,0)
,pursch_prjno_id  numeric (38,0)
,pursch_shelfno_id_to  numeric (38,0)
,pursch_opeitm_id  numeric (38,0)
,pursch_supplier_id  numeric (22,0)
,pursch_crr_id_pur  numeric (22,0)
          ,sio_errline varchar(4000)
          ,sio_org_tblname varchar(30)
          ,sio_org_tblid numeric(22,0)
          ,sio_add_time date
          ,sio_replay_time date
          ,sio_result_f char(1)
          ,sio_message_code char(10)
          ,sio_message_contents varchar(4000)
          ,sio_chk_done char(1)
);
 CREATE INDEX sio_r_purschs_uk1 
  ON sio.sio_r_purschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purschs_seq ;
 create sequence sio.sio_r_purschs_seq ;
  drop view if  exists r_purords cascade ; 
 create or replace view r_purords as select  
purord.itm_code_client  purord_itm_code_client,
purord.prjnos_id   purord_prjno_id,
purord.crrs_id   purord_crr_id,
purord.id id,
purord.id  purord_id,
purord.created_at  purord_created_at,
purord.duedate  purord_duedate,
purord.amt  purord_amt,
purord.toduedate  purord_toduedate,
purord.update_ip  purord_update_ip,
purord.gno_pursch  purord_gno_pursch,
purord.sno_pursch  purord_sno_pursch,
purord.confirm  purord_confirm,
purord.suppliers_id   purord_supplier_id,
purord.crrs_id_pur   purord_crr_id_pur,
purord.contract_price  purord_contract_price,
purord.gno  purord_gno,
purord.chrgs_id   purord_chrg_id,
purord.tax  purord_tax,
purord.starttime  purord_starttime,
purord.price  purord_price,
purord.autoinst_p  purord_autoinst_p,
purord.autocreate_inst  purord_autocreate_inst,
purord.autocreate_act  purord_autocreate_act,
purord.autoact_p  purord_autoact_p,
purord.expiredate  purord_expiredate,
purord.updated_at  purord_updated_at,
purord.qty  purord_qty,
purord.sno  purord_sno,
purord.remark  purord_remark,
purord.persons_id_upd   purord_person_id_upd,
purord.opeitms_id   purord_opeitm_id,
purord.shelfnos_id_to   purord_shelfno_id_to,
purord.opt_fixoterm  purord_opt_fixoterm,
purord.qty_case  purord_qty_case,
purord.isudate  purord_isudate,
purord.cno  purord_cno
 from purords   purord,
  r_prjnos  prjno ,  r_crrs  crr ,  r_suppliers  supplier ,  r_crrs  crr_pur ,  r_chrgs  chrg ,  r_persons  person_upd ,  r_opeitms  opeitm ,  r_shelfnos  shelfno_to 
  where       purord.prjnos_id = prjno.id      and purord.crrs_id = crr.id      and purord.suppliers_id = supplier.id      and purord.crrs_id_pur = crr_pur.id      and purord.chrgs_id = chrg.id      and purord.persons_id_upd = person_upd.id      and purord.opeitms_id = opeitm.id      and purord.shelfnos_id_to = shelfno_to.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purords;
 CREATE TABLE sio.sio_r_purords (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purords_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
          ,sio_Term_id varchar(30)
          ,sio_session_id numeric(22,0)
          ,sio_Command_Response char(1)
          ,sio_session_counter numeric(22,0)
          ,sio_classname varchar(50)
          ,sio_viewname varchar(30)
          ,sio_code varchar(30)
          ,sio_strsql varchar(4000)
          ,sio_totalcount numeric(22,0)
          ,sio_recordcount numeric(22,0)
          ,sio_start_record numeric(22,0)
          ,sio_end_record numeric(22,0)
          ,sio_sord varchar(256)
          ,sio_search varchar(10)
          ,sio_sidx varchar(256)
,purord_gno  varchar (40) 
,purord_cno  varchar (40) 
,purord_sno  varchar (40) 
,purord_tax  numeric (38,4)
,purord_confirm  varchar (1) 
,purord_contract_price  varchar (1) 
,purord_itm_code_client  varchar (50) 
,purord_starttime   timestamp(6) 
,purord_price  numeric (38,4)
,purord_autoinst_p  numeric (3,0)
,purord_autocreate_inst  varchar (1) 
,purord_autocreate_act  varchar (1) 
,purord_autoact_p  numeric (3,0)
,purord_expiredate   date 
,purord_qty  numeric (22,6)
,purord_opt_fixoterm  numeric (5,2)
,purord_qty_case  numeric (22,0)
,purord_isudate   timestamp(6) 
,purord_duedate   timestamp(6) 
,purord_amt  numeric (18,4)
,purord_toduedate   timestamp(6) 
,purord_gno_pursch  varchar (50) 
,purord_sno_pursch  varchar (50) 
,purord_remark  varchar (4000) 
,purord_created_at   timestamp(6) 
,purord_shelfno_id_to  numeric (38,0)
,purord_updated_at   timestamp(6) 
,purord_prjno_id  numeric (38,0)
,purord_update_ip  varchar (40) 
,purord_crr_id  numeric (22,0)
,purord_person_id_upd  numeric (38,0)
,purord_supplier_id  numeric (22,0)
,purord_crr_id_pur  numeric (22,0)
,purord_opeitm_id  numeric (38,0)
,id  numeric (38,0)
,purord_id  numeric (38,0)
,purord_chrg_id  numeric (38,0)
          ,sio_errline varchar(4000)
          ,sio_org_tblname varchar(30)
          ,sio_org_tblid numeric(22,0)
          ,sio_add_time date
          ,sio_replay_time date
          ,sio_result_f char(1)
          ,sio_message_code char(10)
          ,sio_message_contents varchar(4000)
          ,sio_chk_done char(1)
);
 CREATE INDEX sio_r_purords_uk1 
  ON sio.sio_r_purords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purords_seq ;
 create sequence sio.sio_r_purords_seq ;
  drop view if  exists r_purdlvs cascade ; 
 create or replace view r_purdlvs as select  
purdlv.sno_purinst  purdlv_sno_purinst,
purdlv.cno_purinst  purdlv_cno_purinst,
purdlv.replydate  purdlv_replydate,
purdlv.shelfnos_id_to   purdlv_shelfno_id_to,
purdlv.remark  purdlv_remark,
purdlv.created_at  purdlv_created_at,
purdlv.update_ip  purdlv_update_ip,
purdlv.depdate  purdlv_depdate,
purdlv.isudate  purdlv_isudate,
purdlv.expiredate  purdlv_expiredate,
purdlv.updated_at  purdlv_updated_at,
purdlv.qty  purdlv_qty,
purdlv.sno  purdlv_sno,
purdlv.id id,
purdlv.id  purdlv_id,
purdlv.persons_id_upd   purdlv_person_id_upd,
purdlv.locas_id_to   purdlv_loca_id_to,
purdlv.prjnos_id   purdlv_prjno_id,
purdlv.opeitms_id   purdlv_opeitm_id,
purdlv.qty_case  purdlv_qty_case,
purdlv.cno  purdlv_cno,
purdlv.gno  purdlv_gno,
purdlv.chrgs_id   purdlv_chrg_id,
purdlv.itm_code_client  purdlv_itm_code_client,
purdlv.autoact_p  purdlv_autoact_p,
purdlv.suppliers_id   purdlv_supplier_id
 from purdlvs   purdlv,
  r_shelfnos  shelfno_to ,  r_persons  person_upd ,  r_locas  loca_to ,  r_prjnos  prjno ,  r_opeitms  opeitm ,  r_chrgs  chrg ,  r_suppliers  supplier 
  where       purdlv.shelfnos_id_to = shelfno_to.id      and purdlv.persons_id_upd = person_upd.id      and purdlv.locas_id_to = loca_to.id      and purdlv.prjnos_id = prjno.id      and purdlv.opeitms_id = opeitm.id      and purdlv.chrgs_id = chrg.id      and purdlv.suppliers_id = supplier.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purdlvs;
 CREATE TABLE sio.sio_r_purdlvs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purdlvs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
          ,sio_Term_id varchar(30)
          ,sio_session_id numeric(22,0)
          ,sio_Command_Response char(1)
          ,sio_session_counter numeric(22,0)
          ,sio_classname varchar(50)
          ,sio_viewname varchar(30)
          ,sio_code varchar(30)
          ,sio_strsql varchar(4000)
          ,sio_totalcount numeric(22,0)
          ,sio_recordcount numeric(22,0)
          ,sio_start_record numeric(22,0)
          ,sio_end_record numeric(22,0)
          ,sio_sord varchar(256)
          ,sio_search varchar(10)
          ,sio_sidx varchar(256)
,purdlv_cno  varchar (40) 
,purdlv_gno  varchar (40) 
,purdlv_sno  varchar (40) 
,purdlv_expiredate   date 
,purdlv_qty_case  numeric (22,0)
,purdlv_qty  numeric (22,6)
,purdlv_itm_code_client  varchar (50) 
,purdlv_autoact_p  numeric (3,0)
,purdlv_sno_purinst  varchar (50) 
,purdlv_replydate   date 
,purdlv_depdate   timestamp(6) 
,purdlv_isudate   timestamp(6) 
,purdlv_cno_purinst  varchar (50) 
,purdlv_remark  varchar (4000) 
,purdlv_supplier_id  numeric (22,0)
,purdlv_shelfno_id_to  numeric (38,0)
,purdlv_created_at   timestamp(6) 
,purdlv_update_ip  varchar (40) 
,purdlv_updated_at   timestamp(6) 
,id  numeric (38,0)
,purdlv_id  numeric (38,0)
,purdlv_person_id_upd  numeric (38,0)
,purdlv_loca_id_to  numeric (38,0)
,purdlv_prjno_id  numeric (38,0)
,purdlv_opeitm_id  numeric (38,0)
,purdlv_chrg_id  numeric (38,0)
          ,sio_errline varchar(4000)
          ,sio_org_tblname varchar(30)
          ,sio_org_tblid numeric(22,0)
          ,sio_add_time date
          ,sio_replay_time date
          ,sio_result_f char(1)
          ,sio_message_code char(10)
          ,sio_message_contents varchar(4000)
          ,sio_chk_done char(1)
);
 CREATE INDEX sio_r_purdlvs_uk1 
  ON sio.sio_r_purdlvs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purdlvs_seq ;
 create sequence sio.sio_r_purdlvs_seq ;
