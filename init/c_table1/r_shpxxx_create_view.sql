
  drop view if  exists r_shprsltinputs cascade ; 
 create or replace view r_shprsltinputs as select  
shprsltinput.transports_id   shprsltinput_transport_id,
shprsltinput.shelfnos_id_fm   shprsltinput_shelfno_id_fm,
shprsltinput.crrs_id   shprsltinput_crr_id,
shprsltinput.id id,
shprsltinput.id  shprsltinput_id,
shprsltinput.sno  shprsltinput_sno,
shprsltinput.starttime  shprsltinput_starttime,
shprsltinput.qty_case_bal  shprsltinput_qty_case_bal,
shprsltinput.qty_case  shprsltinput_qty_case,
shprsltinput.isudate  shprsltinput_isudate,
shprsltinput.expiredate  shprsltinput_expiredate,
shprsltinput.qty  shprsltinput_qty,
shprsltinput.remark  shprsltinput_remark,
shprsltinput.created_at  shprsltinput_created_at,
shprsltinput.update_ip  shprsltinput_update_ip,
shprsltinput.persons_id_upd   shprsltinput_person_id_upd,
shprsltinput.contents  shprsltinput_contents,
shprsltinput.result_f  shprsltinput_result_f,
shprsltinput.updated_at  shprsltinput_updated_at,
shprsltinput.box  shprsltinput_box,
shprsltinput.locas_id_to   shprsltinput_loca_id_to,
shprsltinput.duedate  shprsltinput_duedate,
shprsltinput.message_code  shprsltinput_message_code,
shprsltinput.cartonno  shprsltinput_cartonno,
shprsltinput.siosession  shprsltinput_siosession,
shprsltinput.opeitms_id   shprsltinput_opeitm_id
 from shprsltinputs   shprsltinput,
  r_transports  transport ,  r_shelfnos  shelfno_fm ,  r_crrs  crr ,  r_persons  person_upd ,  r_locas  loca_to ,  r_opeitms  opeitm 
  where       shprsltinput.transports_id = transport.id      and shprsltinput.shelfnos_id_fm = shelfno_fm.id      and shprsltinput.crrs_id = crr.id      and shprsltinput.persons_id_upd = person_upd.id      and shprsltinput.locas_id_to = loca_to.id      and shprsltinput.opeitms_id = opeitm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shprsltinputs;
 CREATE TABLE sio.sio_r_shprsltinputs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shprsltinputs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,shprsltinput_sno  varchar (40) 
,shprsltinput_result_f  varchar (1) 
,shprsltinput_qty_case  numeric (22,0)
,shprsltinput_box  varchar (50) 
,shprsltinput_isudate   timestamp(6) 
,shprsltinput_duedate   timestamp(6) 
,shprsltinput_message_code  varchar (256) 
,shprsltinput_cartonno  varchar (20) 
,shprsltinput_siosession  varchar (20) 
,shprsltinput_expiredate   date 
,shprsltinput_qty  numeric (22,6)
,shprsltinput_starttime   timestamp(6) 
,shprsltinput_qty_case_bal  numeric (38,0)
,shprsltinput_contents  varchar (4000) 
,shprsltinput_remark  varchar (4000) 
,shprsltinput_opeitm_id  numeric (38,0)
,shprsltinput_shelfno_id_fm  numeric (22,0)
,shprsltinput_crr_id  numeric (22,0)
,id  numeric (38,0)
,shprsltinput_id  numeric (38,0)
,shprsltinput_created_at   timestamp(6) 
,shprsltinput_update_ip  varchar (40) 
,shprsltinput_person_id_upd  numeric (38,0)
,shprsltinput_updated_at   timestamp(6) 
,shprsltinput_loca_id_to  numeric (38,0)
,shprsltinput_transport_id  numeric (38,0)
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
 CREATE INDEX sio_r_shprsltinputs_uk1 
  ON sio.sio_r_shprsltinputs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shprsltinputs_seq ;
 create sequence sio.sio_r_shprsltinputs_seq ;
  drop view if  exists r_shprets cascade ; 
 create or replace view r_shprets as select  
shpret.retdate  shpret_retdate,
shpret.locas_id_fm   shpret_loca_id_fm,
shpret.locas_id_to   shpret_loca_id_to,
shpret.prjnos_id   shpret_prjno_id,
shpret.opeitms_id   shpret_opeitm_id,
shpret.crrs_id   shpret_crr_id,
shpret.id id,
shpret.id  shpret_id,
shpret.isudate  shpret_isudate,
shpret.sno  shpret_sno,
shpret.contract_price  shpret_contract_price,
shpret.persons_id_upd   shpret_person_id_upd,
shpret.qty_case  shpret_qty_case,
shpret.qty  shpret_qty,
shpret.price  shpret_price,
shpret.amt  shpret_amt,
shpret.tax  shpret_tax,
shpret.contents  shpret_contents,
shpret.remark  shpret_remark,
shpret.expiredate  shpret_expiredate,
shpret.update_ip  shpret_update_ip,
shpret.created_at  shpret_created_at,
shpret.updated_at  shpret_updated_at,
shpret.chrgs_id   shpret_chrg_id
 from shprets   shpret,
  r_locas  loca_fm ,  r_locas  loca_to ,  r_prjnos  prjno ,  r_opeitms  opeitm ,  r_crrs  crr ,  r_persons  person_upd ,  r_chrgs  chrg 
  where       shpret.locas_id_fm = loca_fm.id      and shpret.locas_id_to = loca_to.id      and shpret.prjnos_id = prjno.id      and shpret.opeitms_id = opeitm.id      and shpret.crrs_id = crr.id      and shpret.persons_id_upd = person_upd.id      and shpret.chrgs_id = chrg.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shprets;
 CREATE TABLE sio.sio_r_shprets (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shprets_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,shpret_sno  varchar (40) 
,shpret_retdate   date 
,shpret_isudate   timestamp(6) 
,shpret_contract_price  varchar (1) 
,shpret_qty_case  numeric (22,0)
,shpret_qty  numeric (22,6)
,shpret_price  numeric (38,4)
,shpret_amt  numeric (18,4)
,shpret_tax  numeric (38,4)
,shpret_expiredate   date 
,shpret_remark  varchar (4000) 
,shpret_contents  varchar (4000) 
,shpret_chrg_id  numeric (38,0)
,shpret_update_ip  varchar (40) 
,shpret_created_at   timestamp(6) 
,shpret_loca_id_to  numeric (38,0)
,shpret_prjno_id  numeric (38,0)
,shpret_opeitm_id  numeric (38,0)
,shpret_crr_id  numeric (22,0)
,id  numeric (38,0)
,shpret_id  numeric (38,0)
,shpret_updated_at   timestamp(6) 
,shpret_loca_id_fm  numeric (38,0)
,shpret_person_id_upd  numeric (38,0)
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
 CREATE INDEX sio_r_shprets_uk1 
  ON sio.sio_r_shprets(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shprets_seq ;
 create sequence sio.sio_r_shprets_seq ;
 drop sequence  if exists  shpreplyinputs_seq ;
 create sequence shpreplyinputs_seq ;
  drop view if  exists r_shpreplyinputs cascade ; 
 create or replace view r_shpreplyinputs as select  
shpreplyinput.transports_id   shpreplyinput_transport_id,
shpreplyinput.id id,
shpreplyinput.id  shpreplyinput_id,
shpreplyinput.starttime  shpreplyinput_starttime,
shpreplyinput.message_code  shpreplyinput_message_code,
shpreplyinput.isudate  shpreplyinput_isudate,
shpreplyinput.locas_id_to   shpreplyinput_loca_id_to,
shpreplyinput.expiredate  shpreplyinput_expiredate,
shpreplyinput.updated_at  shpreplyinput_updated_at,
shpreplyinput.qty  shpreplyinput_qty,
shpreplyinput.remark  shpreplyinput_remark,
shpreplyinput.created_at  shpreplyinput_created_at,
shpreplyinput.update_ip  shpreplyinput_update_ip,
shpreplyinput.duedate  shpreplyinput_duedate,
shpreplyinput.persons_id_upd   shpreplyinput_person_id_upd,
shpreplyinput.contents  shpreplyinput_contents,
shpreplyinput.result_f  shpreplyinput_result_f,
shpreplyinput.qty_case  shpreplyinput_qty_case,
shpreplyinput.qty_case_bal  shpreplyinput_qty_case_bal,
shpreplyinput.box  shpreplyinput_box,
shpreplyinput.cartonno  shpreplyinput_cartonno,
shpreplyinput.siosession  shpreplyinput_siosession,
shpreplyinput.sno  shpreplyinput_sno,
shpreplyinput.opeitms_id   shpreplyinput_opeitm_id
 from shpreplyinputs   shpreplyinput,
  r_transports  transport ,  r_locas  loca_to ,  r_persons  person_upd ,  r_opeitms  opeitm 
  where       shpreplyinput.transports_id = transport.id      and shpreplyinput.locas_id_to = loca_to.id      and shpreplyinput.persons_id_upd = person_upd.id      and shpreplyinput.opeitms_id = opeitm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shpreplyinputs;
 CREATE TABLE sio.sio_r_shpreplyinputs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shpreplyinputs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,shpreplyinput_sno  varchar (40) 
,shpreplyinput_result_f  varchar (1) 
,shpreplyinput_qty_case  numeric (22,0)
,shpreplyinput_qty_case_bal  numeric (38,0)
,shpreplyinput_box  varchar (50) 
,shpreplyinput_cartonno  varchar (20) 
,shpreplyinput_siosession  varchar (20) 
,shpreplyinput_message_code  varchar (256) 
,shpreplyinput_qty  numeric (22,6)
,shpreplyinput_expiredate   date 
,shpreplyinput_starttime   timestamp(6) 
,shpreplyinput_duedate   timestamp(6) 
,shpreplyinput_isudate   timestamp(6) 
,shpreplyinput_remark  varchar (4000) 
,shpreplyinput_contents  varchar (4000) 
,shpreplyinput_opeitm_id  numeric (38,0)
,id  numeric (38,0)
,shpreplyinput_id  numeric (38,0)
,shpreplyinput_loca_id_to  numeric (38,0)
,shpreplyinput_updated_at   timestamp(6) 
,shpreplyinput_created_at   timestamp(6) 
,shpreplyinput_update_ip  varchar (40) 
,shpreplyinput_person_id_upd  numeric (38,0)
,shpreplyinput_transport_id  numeric (38,0)
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
 CREATE INDEX sio_r_shpreplyinputs_uk1 
  ON sio.sio_r_shpreplyinputs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpreplyinputs_seq ;
 create sequence sio.sio_r_shpreplyinputs_seq ;
 drop sequence  if exists  shpests_seq ;
 create sequence shpests_seq ;
  drop view if  exists r_shpests cascade ; 
 create or replace view r_shpests as select  
shpest.prjnos_id   shpest_prjno_id,
shpest.id id,
shpest.id  shpest_id,
shpest.amt  shpest_amt,
shpest.update_ip  shpest_update_ip,
shpest.created_at  shpest_created_at,
shpest.updated_at  shpest_updated_at,
shpest.expiredate  shpest_expiredate,
shpest.persons_id_upd   shpest_person_id_upd,
shpest.locas_id_to   shpest_loca_id_to,
shpest.price  shpest_price,
shpest.sno  shpest_sno,
shpest.qty  shpest_qty,
shpest.tax  shpest_tax,
shpest.isudate  shpest_isudate,
shpest.contents  shpest_contents,
shpest.opeitms_id   shpest_opeitm_id,
shpest.chrgs_id   shpest_chrg_id,
shpest.starttime  shpest_starttime,
shpest.remark  shpest_remark,
shpest.duedate  shpest_duedate,
shpest.contract_price  shpest_contract_price,
shpest.toduedate  shpest_toduedate
 from shpests   shpest,
  r_prjnos  prjno ,  r_persons  person_upd ,  r_locas  loca_to ,  r_opeitms  opeitm ,  r_chrgs  chrg 
  where       shpest.prjnos_id = prjno.id      and shpest.persons_id_upd = person_upd.id      and shpest.locas_id_to = loca_to.id      and shpest.opeitms_id = opeitm.id      and shpest.chrgs_id = chrg.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shpests;
 CREATE TABLE sio.sio_r_shpests (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shpests_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,shpest_sno  varchar (40) 
,shpest_toduedate   timestamp(6) 
,shpest_amt  numeric (18,4)
,shpest_expiredate   date 
,shpest_price  numeric (38,4)
,shpest_qty  numeric (22,6)
,shpest_tax  numeric (38,4)
,shpest_isudate   timestamp(6) 
,shpest_starttime   timestamp(6) 
,shpest_duedate   timestamp(6) 
,shpest_contract_price  varchar (1) 
,shpest_contents  varchar (4000) 
,shpest_remark  varchar (4000) 
,shpest_prjno_id  numeric (38,0)
,shpest_id  numeric (38,0)
,shpest_update_ip  varchar (40) 
,shpest_created_at   timestamp(6) 
,shpest_updated_at   timestamp(6) 
,shpest_person_id_upd  numeric (38,0)
,shpest_loca_id_to  numeric (38,0)
,id  numeric (38,0)
,shpest_opeitm_id  numeric (38,0)
,shpest_chrg_id  numeric (38,0)
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
 CREATE INDEX sio_r_shpests_uk1 
  ON sio.sio_r_shpests(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpests_seq ;
 create sequence sio.sio_r_shpests_seq ;
  drop view if  exists r_shpacts cascade ; 
 create or replace view r_shpacts as select  
shpact.transports_id   shpact_transport_id,
shpact.prjnos_id   shpact_prjno_id,
shpact.itms_id   shpact_itm_id,
shpact.paretblname  shpact_paretblname,
shpact.paretblid  shpact_paretblid,
shpact.qty_stk  shpact_qty_stk,
shpact.crrs_id   shpact_crr_id,
shpact.id id,
shpact.id  shpact_id,
shpact.qty  shpact_qty,
shpact.amt  shpact_amt,
shpact.remark  shpact_remark,
shpact.expiredate  shpact_expiredate,
shpact.update_ip  shpact_update_ip,
shpact.created_at  shpact_created_at,
shpact.updated_at  shpact_updated_at,
shpact.persons_id_upd   shpact_person_id_upd,
shpact.tax  shpact_tax,
shpact.price  shpact_price,
shpact.chrgs_id   shpact_chrg_id,
shpact.sno  shpact_sno,
shpact.box  shpact_box,
shpact.duedate  shpact_duedate,
shpact.starttime  shpact_starttime,
shpact.sno_shpord  shpact_sno_shpord,
shpact.gno_shpord  shpact_gno_shpord,
shpact.processseq  shpact_processseq,
shpact.gno  shpact_gno,
shpact.contents  shpact_contents,
shpact.contract_price  shpact_contract_price,
shpact.isudate  shpact_isudate,
shpact.cno  shpact_cno,
shpact.qty_case  shpact_qty_case,
shpact.cartonno  shpact_cartonno
 from shpacts   shpact,
  r_transports  transport ,  r_prjnos  prjno ,  r_itms  itm ,  r_crrs  crr ,  r_persons  person_upd ,  r_chrgs  chrg 
  where       shpact.transports_id = transport.id      and shpact.prjnos_id = prjno.id      and shpact.itms_id = itm.id      and shpact.crrs_id = crr.id      and shpact.persons_id_upd = person_upd.id      and shpact.chrgs_id = chrg.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shpacts;
 CREATE TABLE sio.sio_r_shpacts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shpacts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,shpact_gno  varchar (40) 
,shpact_cno  varchar (40) 
,shpact_sno  varchar (40) 
,shpact_qty_stk  numeric (22,6)
,shpact_cartonno  varchar (20) 
,shpact_paretblname  varchar (30) 
,shpact_paretblid  numeric (38,0)
,shpact_amt  numeric (18,4)
,shpact_expiredate   date 
,shpact_tax  numeric (38,4)
,shpact_price  numeric (38,4)
,shpact_box  varchar (50) 
,shpact_duedate   timestamp(6) 
,shpact_starttime   timestamp(6) 
,shpact_sno_shpord  varchar (50) 
,shpact_gno_shpord  varchar (50) 
,shpact_processseq  numeric (38,0)
,shpact_contract_price  varchar (1) 
,shpact_isudate   timestamp(6) 
,shpact_qty_case  numeric (22,0)
,shpact_qty  numeric (22,6)
,shpact_contents  varchar (4000) 
,shpact_remark  varchar (4000) 
,shpact_crr_id  numeric (22,0)
,shpact_prjno_id  numeric (38,0)
,shpact_transport_id  numeric (38,0)
,shpact_update_ip  varchar (40) 
,shpact_created_at   timestamp(6) 
,shpact_updated_at   timestamp(6) 
,shpact_person_id_upd  numeric (38,0)
,shpact_itm_id  numeric (38,0)
,id  numeric (38,0)
,shpact_chrg_id  numeric (38,0)
,shpact_id  numeric (38,0)
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
 CREATE INDEX sio_r_shpacts_uk1 
  ON sio.sio_r_shpacts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpacts_seq ;
 create sequence sio.sio_r_shpacts_seq ;
  drop view if  exists r_shpinsts cascade ; 
 create or replace view r_shpinsts as select  
shpinst.prjnos_id   shpinst_prjno_id,
shpinst.transports_id   shpinst_transport_id,
shpinst.paretblid  shpinst_paretblid,
shpinst.paretblname  shpinst_paretblname,
shpinst.itms_id   shpinst_itm_id,
shpinst.qty_shortage  shpinst_qty_shortage,
shpinst.qty_stk  shpinst_qty_stk,
shpinst.shelfnos_id_fm   shpinst_shelfno_id_fm,
shpinst.id id,
shpinst.id  shpinst_id,
shpinst.starttime  shpinst_starttime,
shpinst.locas_id_to   shpinst_loca_id_to,
shpinst.sno  shpinst_sno,
shpinst.remark  shpinst_remark,
shpinst.expiredate  shpinst_expiredate,
shpinst.update_ip  shpinst_update_ip,
shpinst.created_at  shpinst_created_at,
shpinst.updated_at  shpinst_updated_at,
shpinst.persons_id_upd   shpinst_person_id_upd,
shpinst.amt  shpinst_amt,
shpinst.qty  shpinst_qty,
shpinst.tax  shpinst_tax,
shpinst.price  shpinst_price,
shpinst.chrgs_id   shpinst_chrg_id,
shpinst.processseq  shpinst_processseq,
shpinst.contents  shpinst_contents,
shpinst.contract_price  shpinst_contract_price,
shpinst.gno  shpinst_gno,
shpinst.isudate  shpinst_isudate,
shpinst.box  shpinst_box,
shpinst.duedate  shpinst_duedate,
shpinst.cno  shpinst_cno,
shpinst.qty_case  shpinst_qty_case,
shpinst.cartonno  shpinst_cartonno
 from shpinsts   shpinst,
  r_prjnos  prjno ,  r_transports  transport ,  r_itms  itm ,  r_shelfnos  shelfno_fm ,  r_locas  loca_to ,  r_persons  person_upd ,  r_chrgs  chrg 
  where       shpinst.prjnos_id = prjno.id      and shpinst.transports_id = transport.id      and shpinst.itms_id = itm.id      and shpinst.shelfnos_id_fm = shelfno_fm.id      and shpinst.locas_id_to = loca_to.id      and shpinst.persons_id_upd = person_upd.id      and shpinst.chrgs_id = chrg.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shpinsts;
 CREATE TABLE sio.sio_r_shpinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shpinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,shpinst_cno  varchar (40) 
,shpinst_gno  varchar (40) 
,shpinst_sno  varchar (40) 
,shpinst_contract_price  varchar (1) 
,shpinst_isudate   timestamp(6) 
,shpinst_box  varchar (50) 
,shpinst_duedate   timestamp(6) 
,shpinst_qty_case  numeric (22,0)
,shpinst_cartonno  varchar (20) 
,shpinst_tax  numeric (38,4)
,shpinst_qty_stk  numeric (22,6)
,shpinst_processseq  numeric (38,0)
,shpinst_qty  numeric (22,6)
,shpinst_price  numeric (38,4)
,shpinst_expiredate   date 
,shpinst_paretblname  varchar (30) 
,shpinst_paretblid  numeric (38,0)
,shpinst_qty_shortage  numeric (22,5)
,shpinst_starttime   timestamp(6) 
,shpinst_amt  numeric (18,4)
,shpinst_contents  varchar (4000) 
,shpinst_remark  varchar (4000) 
,shpinst_updated_at   timestamp(6) 
,shpinst_transport_id  numeric (38,0)
,shpinst_itm_id  numeric (38,0)
,shpinst_shelfno_id_fm  numeric (22,0)
,id  numeric (38,0)
,shpinst_id  numeric (38,0)
,shpinst_loca_id_to  numeric (38,0)
,shpinst_update_ip  varchar (40) 
,shpinst_created_at   timestamp(6) 
,shpinst_prjno_id  numeric (38,0)
,shpinst_person_id_upd  numeric (38,0)
,shpinst_chrg_id  numeric (38,0)
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
 CREATE INDEX sio_r_shpinsts_uk1 
  ON sio.sio_r_shpinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpinsts_seq ;
 create sequence sio.sio_r_shpinsts_seq ;
  drop view if  exists r_shpords cascade ; 
 create or replace view r_shpords as select  
shpord.id id,
shpord.id  shpord_id,
shpord.isudate  shpord_isudate,
shpord.itms_id   shpord_itm_id,
shpord.shelfnos_id_fm   shpord_shelfno_id_fm,
shpord.transports_id   shpord_transport_id,
shpord.expiredate  shpord_expiredate,
shpord.depdate  shpord_depdate,
shpord.qty  shpord_qty,
shpord.price  shpord_price,
shpord.locas_id_to   shpord_loca_id_to,
shpord.tax  shpord_tax,
shpord.contract_price  shpord_contract_price,
shpord.prjnos_id   shpord_prjno_id,
shpord.manual  shpord_manual,
shpord.lotno  shpord_lotno,
shpord.qty_stk  shpord_qty_stk,
shpord.qty_case  shpord_qty_case,
shpord.packno  shpord_packno,
shpord.gno  shpord_gno,
shpord.sno  shpord_sno,
shpord.chrgs_id   shpord_chrg_id,
shpord.crrs_id   shpord_crr_id,
shpord.paretblname  shpord_paretblname,
shpord.paretblid  shpord_paretblid,
shpord.remark  shpord_remark,
shpord.persons_id_upd   shpord_person_id_upd,
shpord.created_at  shpord_created_at,
shpord.updated_at  shpord_updated_at,
shpord.update_ip  shpord_update_ip,
shpord.sno_shpsch  shpord_sno_shpsch,
shpord.processseq  shpord_processseq,
shpord.amt  shpord_amt
 from shpords   shpord,
  r_itms  itm ,  r_shelfnos  shelfno_fm ,  r_transports  transport ,  r_locas  loca_to ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_crrs  crr ,  r_persons  person_upd 
  where       shpord.itms_id = itm.id      and shpord.shelfnos_id_fm = shelfno_fm.id      and shpord.transports_id = transport.id      and shpord.locas_id_to = loca_to.id      and shpord.prjnos_id = prjno.id      and shpord.chrgs_id = chrg.id      and shpord.crrs_id = crr.id      and shpord.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shpords;
 CREATE TABLE sio.sio_r_shpords (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shpords_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,shpord_sno  varchar (40) 
,shpord_gno  varchar (40) 
,shpord_amt  numeric (18,4)
,shpord_isudate   timestamp(6) 
,shpord_depdate   timestamp(6) 
,shpord_qty  numeric (22,6)
,shpord_price  numeric (38,4)
,shpord_tax  numeric (38,4)
,shpord_contract_price  varchar (1) 
,shpord_manual  varchar (1) 
,shpord_lotno  varchar (50) 
,shpord_qty_stk  numeric (22,6)
,shpord_qty_case  numeric (22,0)
,shpord_packno  varchar (10) 
,shpord_paretblname  varchar (30) 
,shpord_paretblid  numeric (38,0)
,shpord_sno_shpsch  varchar (50) 
,shpord_processseq  numeric (38,0)
,shpord_expiredate   date 
,shpord_remark  varchar (4000) 
,shpord_transport_id  numeric (38,0)
,shpord_updated_at   timestamp(6) 
,shpord_itm_id  numeric (38,0)
,shpord_id  numeric (38,0)
,shpord_chrg_id  numeric (38,0)
,shpord_loca_id_to  numeric (38,0)
,shpord_crr_id  numeric (22,0)
,shpord_update_ip  varchar (40) 
,shpord_prjno_id  numeric (38,0)
,id  numeric (38,0)
,shpord_person_id_upd  numeric (38,0)
,shpord_shelfno_id_fm  numeric (22,0)
,shpord_created_at   timestamp(6) 
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
 CREATE INDEX sio_r_shpords_uk1 
  ON sio.sio_r_shpords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpords_seq ;
 create sequence sio.sio_r_shpords_seq ;
  drop view if  exists r_shpschs cascade ; 
 create or replace view r_shpschs as select  
shpsch.id id,
shpsch.id  shpsch_id,
shpsch.transports_id   shpsch_transport_id,
shpsch.chrgs_id   shpsch_chrg_id,
shpsch.prjnos_id   shpsch_prjno_id,
shpsch.expiredate  shpsch_expiredate,
shpsch.persons_id_upd   shpsch_person_id_upd,
shpsch.remark  shpsch_remark,
shpsch.update_ip  shpsch_update_ip,
shpsch.created_at  shpsch_created_at,
shpsch.updated_at  shpsch_updated_at,
shpsch.qty  shpsch_qty,
shpsch.amt  shpsch_amt,
shpsch.tax  shpsch_tax,
shpsch.price  shpsch_price,
shpsch.locas_id_to   shpsch_loca_id_to,
shpsch.sno  shpsch_sno,
shpsch.isudate  shpsch_isudate,
shpsch.gno  shpsch_gno,
shpsch.crrs_id   shpsch_crr_id,
shpsch.depdate  shpsch_depdate,
shpsch.lotno  shpsch_lotno,
shpsch.packno  shpsch_packno,
shpsch.qty_stk  shpsch_qty_stk,
shpsch.itms_id   shpsch_itm_id,
shpsch.paretblname  shpsch_paretblname,
shpsch.paretblid  shpsch_paretblid,
shpsch.shelfnos_id_fm   shpsch_shelfno_id_fm,
shpsch.qty_case  shpsch_qty_case,
shpsch.contract_price  shpsch_contract_price,
shpsch.processseq  shpsch_processseq,
shpsch.manual  shpsch_manual
 from shpschs   shpsch,
  r_transports  transport ,  r_chrgs  chrg ,  r_prjnos  prjno ,  r_persons  person_upd ,  r_locas  loca_to ,  r_crrs  crr ,  r_itms  itm ,  r_shelfnos  shelfno_fm 
  where       shpsch.transports_id = transport.id      and shpsch.chrgs_id = chrg.id      and shpsch.prjnos_id = prjno.id      and shpsch.persons_id_upd = person_upd.id      and shpsch.locas_id_to = loca_to.id      and shpsch.crrs_id = crr.id      and shpsch.itms_id = itm.id      and shpsch.shelfnos_id_fm = shelfno_fm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shpschs;
 CREATE TABLE sio.sio_r_shpschs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shpschs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,shpsch_sno  varchar (40) 
,shpsch_gno  varchar (40) 
,shpsch_manual  varchar (1) 
,shpsch_qty  numeric (22,6)
,shpsch_amt  numeric (18,4)
,shpsch_tax  numeric (38,4)
,shpsch_price  numeric (38,4)
,shpsch_isudate   timestamp(6) 
,shpsch_depdate   timestamp(6) 
,shpsch_lotno  varchar (50) 
,shpsch_packno  varchar (10) 
,shpsch_qty_stk  numeric (22,6)
,shpsch_paretblname  varchar (30) 
,shpsch_paretblid  numeric (38,0)
,shpsch_qty_case  numeric (22,0)
,shpsch_contract_price  varchar (1) 
,shpsch_processseq  numeric (38,0)
,shpsch_expiredate   date 
,shpsch_remark  varchar (4000) 
,shpsch_prjno_id  numeric (38,0)
,shpsch_shelfno_id_fm  numeric (22,0)
,shpsch_person_id_upd  numeric (38,0)
,shpsch_update_ip  varchar (40) 
,shpsch_created_at   timestamp(6) 
,shpsch_updated_at   timestamp(6) 
,shpsch_id  numeric (38,0)
,shpsch_crr_id  numeric (22,0)
,id  numeric (38,0)
,shpsch_itm_id  numeric (38,0)
,shpsch_loca_id_to  numeric (38,0)
,shpsch_chrg_id  numeric (38,0)
,shpsch_transport_id  numeric (38,0)
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
 CREATE INDEX sio_r_shpschs_uk1 
  ON sio.sio_r_shpschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpschs_seq ;
 create sequence sio.sio_r_shpschs_seq ;
