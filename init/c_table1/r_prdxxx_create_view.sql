
  drop view if  exists r_prdschs cascade ; 
 create or replace view r_prdschs as select  
prdsch.chrgs_id   prdsch_chrg_id,
prdsch.starttime  prdsch_starttime,
prdsch.qty_bal  prdsch_qty_bal,
prdsch.isudate  prdsch_isudate,
prdsch.duedate  prdsch_duedate,
prdsch.toduedate  prdsch_toduedate,
prdsch.qty  prdsch_qty,
prdsch.sno  prdsch_sno,
prdsch.expiredate  prdsch_expiredate,
prdsch.persons_id_upd   prdsch_person_id_upd,
prdsch.update_ip  prdsch_update_ip,
prdsch.created_at  prdsch_created_at,
prdsch.updated_at  prdsch_updated_at,
prdsch.id id,
prdsch.id  prdsch_id,
prdsch.opeitms_id   prdsch_opeitm_id,
prdsch.shelfnos_id_to   prdsch_shelfno_id_to,
prdsch.gno  prdsch_gno,
prdsch.qty_case  prdsch_qty_case,
prdsch.remark  prdsch_remark,
prdsch.prjnos_id   prdsch_prjno_id,
prdsch.workplaces_id   prdsch_workplace_id
 from prdschs   prdsch,
  r_chrgs  chrg ,  r_persons  person_upd ,  r_opeitms  opeitm ,  r_shelfnos  shelfno_to ,  r_prjnos  prjno ,  r_workplaces  workplace 
  where       prdsch.chrgs_id = chrg.id      and prdsch.persons_id_upd = person_upd.id      and prdsch.opeitms_id = opeitm.id      and prdsch.shelfnos_id_to = shelfno_to.id      and prdsch.prjnos_id = prjno.id      and prdsch.workplaces_id = workplace.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdschs;
 CREATE TABLE sio.sio_r_prdschs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdschs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prdsch_gno  varchar (40) 
,prdsch_sno  varchar (40) 
,prdsch_toduedate   timestamp(6) 
,prdsch_qty  numeric (22,6)
,prdsch_expiredate   date 
,prdsch_qty_case  numeric (22,0)
,prdsch_qty_bal  numeric (22,6)
,prdsch_duedate   timestamp(6) 
,prdsch_isudate   timestamp(6) 
,prdsch_starttime   timestamp(6) 
,prdsch_remark  varchar (4000) 
,prdsch_workplace_id  numeric (22,0)
,prdsch_person_id_upd  numeric (38,0)
,prdsch_update_ip  varchar (40) 
,prdsch_created_at   timestamp(6) 
,prdsch_updated_at   timestamp(6) 
,id  numeric (38,0)
,prdsch_id  numeric (38,0)
,prdsch_opeitm_id  numeric (38,0)
,prdsch_shelfno_id_to  numeric (38,0)
,prdsch_prjno_id  numeric (38,0)
,prdsch_chrg_id  numeric (38,0)
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
 CREATE INDEX sio_r_prdschs_uk1 
  ON sio.sio_r_prdschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdschs_seq ;
 create sequence sio.sio_r_prdschs_seq ;
  drop view if  exists r_prdords cascade ; 
 create or replace view r_prdords as select  
prdord.opeitms_id   prdord_opeitm_id,
prdord.chrgs_id   prdord_chrg_id,
prdord.starttime  prdord_starttime,
prdord.qty_case  prdord_qty_case,
prdord.id id,
prdord.id  prdord_id,
prdord.qty  prdord_qty,
prdord.persons_id_upd   prdord_person_id_upd,
prdord.duedate  prdord_duedate,
prdord.sno  prdord_sno,
prdord.expiredate  prdord_expiredate,
prdord.isudate  prdord_isudate,
prdord.remark  prdord_remark,
prdord.toduedate  prdord_toduedate,
prdord.created_at  prdord_created_at,
prdord.updated_at  prdord_updated_at,
prdord.update_ip  prdord_update_ip,
prdord.shelfnos_id_to   prdord_shelfno_id_to,
prdord.prjnos_id   prdord_prjno_id,
prdord.workplaces_id   prdord_workplace_id,
prdord.confirm  prdord_confirm,
prdord.autocreate_inst  prdord_autocreate_inst,
prdord.autoinst_p  prdord_autoinst_p,
prdord.autocreate_act  prdord_autocreate_act,
prdord.autoact_p  prdord_autoact_p,
prdord.opt_fixoterm  prdord_opt_fixoterm,
prdord.gno  prdord_gno,
prdord.sno_prdsch  prdord_sno_prdsch,
prdord.gno_prdsch  prdord_gno_prdsch,
prdord.cno  prdord_cno
 from prdords   prdord,
  r_opeitms  opeitm ,  r_chrgs  chrg ,  r_persons  person_upd ,  r_shelfnos  shelfno_to ,  r_prjnos  prjno ,  r_workplaces  workplace 
  where       prdord.opeitms_id = opeitm.id      and prdord.chrgs_id = chrg.id      and prdord.persons_id_upd = person_upd.id      and prdord.shelfnos_id_to = shelfno_to.id      and prdord.prjnos_id = prjno.id      and prdord.workplaces_id = workplace.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdords;
 CREATE TABLE sio.sio_r_prdords (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdords_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prdord_sno  varchar (40) 
,prdord_cno  varchar (40) 
,prdord_gno  varchar (40) 
,prdord_autoinst_p  numeric (3,0)
,prdord_autocreate_act  varchar (1) 
,prdord_autoact_p  numeric (3,0)
,prdord_opt_fixoterm  numeric (5,2)
,prdord_sno_prdsch  varchar (50) 
,prdord_expiredate   date 
,prdord_isudate   timestamp(6) 
,prdord_toduedate   timestamp(6) 
,prdord_qty_case  numeric (22,0)
,prdord_qty  numeric (22,6)
,prdord_starttime   timestamp(6) 
,prdord_duedate   timestamp(6) 
,prdord_gno_prdsch  varchar (50) 
,prdord_confirm  varchar (1) 
,prdord_autocreate_inst  varchar (1) 
,prdord_remark  varchar (4000) 
,prdord_updated_at   timestamp(6) 
,prdord_chrg_id  numeric (38,0)
,id  numeric (38,0)
,prdord_id  numeric (38,0)
,prdord_person_id_upd  numeric (38,0)
,prdord_created_at   timestamp(6) 
,prdord_opeitm_id  numeric (38,0)
,prdord_update_ip  varchar (40) 
,prdord_shelfno_id_to  numeric (38,0)
,prdord_prjno_id  numeric (38,0)
,prdord_workplace_id  numeric (22,0)
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
 CREATE INDEX sio_r_prdords_uk1 
  ON sio.sio_r_prdords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdords_seq ;
 create sequence sio.sio_r_prdords_seq ;
  drop view if  exists r_prdinsts cascade ; 
 create or replace view r_prdinsts as select  
prdinst.chrgs_id   prdinst_chrg_id,
prdinst.opeitms_id   prdinst_opeitm_id,
prdinst.prjnos_id   prdinst_prjno_id,
prdinst.starttime  prdinst_starttime,
prdinst.shelfnos_id_to   prdinst_shelfno_id_to,
prdinst.replydate  prdinst_replydate,
prdinst.commencementdate  prdinst_commencementdate,
prdinst.id id,
prdinst.id  prdinst_id,
prdinst.contents  prdinst_contents,
prdinst.persons_id_upd   prdinst_person_id_upd,
prdinst.cno_prdord  prdinst_cno_prdord,
prdinst.sno_prdord  prdinst_sno_prdord,
prdinst.workplaces_id   prdinst_workplace_id,
prdinst.isudate  prdinst_isudate,
prdinst.expiredate  prdinst_expiredate,
prdinst.updated_at  prdinst_updated_at,
prdinst.qty  prdinst_qty,
prdinst.sno  prdinst_sno,
prdinst.locas_id_to   prdinst_loca_id_to,
prdinst.remark  prdinst_remark,
prdinst.created_at  prdinst_created_at,
prdinst.update_ip  prdinst_update_ip,
prdinst.duedate  prdinst_duedate,
prdinst.qty_case  prdinst_qty_case,
prdinst.commencement_f  prdinst_commencement_f,
prdinst.cno  prdinst_cno,
prdinst.gno  prdinst_gno
 from prdinsts   prdinst,
  r_chrgs  chrg ,  r_opeitms  opeitm ,  r_prjnos  prjno ,  r_shelfnos  shelfno_to ,  r_persons  person_upd ,  r_workplaces  workplace ,  r_locas  loca_to 
  where       prdinst.chrgs_id = chrg.id      and prdinst.opeitms_id = opeitm.id      and prdinst.prjnos_id = prjno.id      and prdinst.shelfnos_id_to = shelfno_to.id      and prdinst.persons_id_upd = person_upd.id      and prdinst.workplaces_id = workplace.id      and prdinst.locas_id_to = loca_to.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdinsts;
 CREATE TABLE sio.sio_r_prdinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prdinst_sno  varchar (40) 
,prdinst_cno  varchar (40) 
,prdinst_gno  varchar (40) 
,prdinst_commencementdate   timestamp(6) 
,prdinst_isudate   timestamp(6) 
,prdinst_starttime   timestamp(6) 
,prdinst_replydate   date 
,prdinst_cno_prdord  varchar (50) 
,prdinst_sno_prdord  varchar (50) 
,prdinst_expiredate   date 
,prdinst_qty  numeric (22,6)
,prdinst_duedate   timestamp(6) 
,prdinst_qty_case  numeric (22,0)
,prdinst_commencement_f  varchar (1) 
,prdinst_remark  varchar (4000) 
,prdinst_contents  varchar (4000) 
,prdinst_updated_at   timestamp(6) 
,prdinst_prjno_id  numeric (38,0)
,prdinst_shelfno_id_to  numeric (38,0)
,prdinst_loca_id_to  numeric (38,0)
,id  numeric (38,0)
,prdinst_id  numeric (38,0)
,prdinst_person_id_upd  numeric (38,0)
,prdinst_created_at   timestamp(6) 
,prdinst_update_ip  varchar (40) 
,prdinst_chrg_id  numeric (38,0)
,prdinst_workplace_id  numeric (22,0)
,prdinst_opeitm_id  numeric (38,0)
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
 CREATE INDEX sio_r_prdinsts_uk1 
  ON sio.sio_r_prdinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdinsts_seq ;
 create sequence sio.sio_r_prdinsts_seq ;
  drop view if  exists r_prdacts cascade ; 
 create or replace view r_prdacts as select  
prdact.prjnos_id   prdact_prjno_id,
prdact.opeitms_id   prdact_opeitm_id,
prdact.lotno  prdact_lotno,
prdact.chrgs_id   prdact_chrg_id,
prdact.packno  prdact_packno,
prdact.shelfnos_id_to   prdact_shelfno_id_to,
prdact.cno_prdinst  prdact_cno_prdinst,
prdact.cno_prdord  prdact_cno_prdord,
prdact.qty_stk  prdact_qty_stk,
prdact.sno_prdinst  prdact_sno_prdinst,
prdact.sno_prdord  prdact_sno_prdord,
prdact.id id,
prdact.id  prdact_id,
prdact.contents  prdact_contents,
prdact.workplaces_id   prdact_workplace_id,
prdact.isudate  prdact_isudate,
prdact.cmpldate  prdact_cmpldate,
prdact.sno  prdact_sno,
prdact.remark  prdact_remark,
prdact.expiredate  prdact_expiredate,
prdact.persons_id_upd   prdact_person_id_upd,
prdact.update_ip  prdact_update_ip,
prdact.created_at  prdact_created_at,
prdact.updated_at  prdact_updated_at,
prdact.cno  prdact_cno,
prdact.gno  prdact_gno
 from prdacts   prdact,
  r_prjnos  prjno ,  r_opeitms  opeitm ,  r_chrgs  chrg ,  r_shelfnos  shelfno_to ,  r_workplaces  workplace ,  r_persons  person_upd 
  where       prdact.prjnos_id = prjno.id      and prdact.opeitms_id = opeitm.id      and prdact.chrgs_id = chrg.id      and prdact.shelfnos_id_to = shelfno_to.id      and prdact.workplaces_id = workplace.id      and prdact.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdacts;
 CREATE TABLE sio.sio_r_prdacts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdacts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prdact_gno  varchar (40) 
,prdact_sno  varchar (40) 
,prdact_cno  varchar (40) 
,prdact_expiredate   date 
,prdact_cno_prdinst  varchar (50) 
,prdact_cno_prdord  varchar (50) 
,prdact_qty_stk  numeric (22,6)
,prdact_sno_prdinst  varchar (50) 
,prdact_sno_prdord  varchar (50) 
,prdact_isudate   timestamp(6) 
,prdact_cmpldate   timestamp(6) 
,prdact_lotno  varchar (50) 
,prdact_packno  varchar (10) 
,prdact_contents  varchar (4000) 
,prdact_remark  varchar (4000) 
,prdact_prjno_id  numeric (38,0)
,prdact_id  numeric (38,0)
,id  numeric (38,0)
,prdact_opeitm_id  numeric (38,0)
,prdact_shelfno_id_to  numeric (38,0)
,prdact_person_id_upd  numeric (38,0)
,prdact_update_ip  varchar (40) 
,prdact_created_at   timestamp(6) 
,prdact_updated_at   timestamp(6) 
,prdact_chrg_id  numeric (38,0)
,prdact_workplace_id  numeric (22,0)
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
 CREATE INDEX sio_r_prdacts_uk1 
  ON sio.sio_r_prdacts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdacts_seq ;
 create sequence sio.sio_r_prdacts_seq ;
  drop view if  exists r_prdrsltinputs cascade ; 
 create or replace view r_prdrsltinputs as select  
prdrsltinput.id id,
prdrsltinput.id  prdrsltinput_id,
prdrsltinput.cmpldate  prdrsltinput_cmpldate,
prdrsltinput.message_code  prdrsltinput_message_code,
prdrsltinput.sno_prdinst  prdrsltinput_sno_prdinst,
prdrsltinput.cno  prdrsltinput_cno,
prdrsltinput.sno  prdrsltinput_sno,
prdrsltinput.sno_prdord  prdrsltinput_sno_prdord,
prdrsltinput.shelfnos_id_in   prdrsltinput_shelfno_id_in,
prdrsltinput.price  prdrsltinput_price,
prdrsltinput.amt  prdrsltinput_amt,
prdrsltinput.tax  prdrsltinput_tax,
prdrsltinput.result_f  prdrsltinput_result_f,
prdrsltinput.qty_case  prdrsltinput_qty_case,
prdrsltinput.isudate  prdrsltinput_isudate,
prdrsltinput.qty  prdrsltinput_qty,
prdrsltinput.persons_id_upd   prdrsltinput_person_id_upd,
prdrsltinput.updated_at  prdrsltinput_updated_at,
prdrsltinput.created_at  prdrsltinput_created_at,
prdrsltinput.update_ip  prdrsltinput_update_ip,
prdrsltinput.expiredate  prdrsltinput_expiredate,
prdrsltinput.remark  prdrsltinput_remark,
prdrsltinput.contents  prdrsltinput_contents,
prdrsltinput.opeitms_id   prdrsltinput_opeitm_id
 from prdrsltinputs   prdrsltinput,
  r_shelfnos  shelfno_in ,  r_persons  person_upd ,  r_opeitms  opeitm 
  where       prdrsltinput.shelfnos_id_in = shelfno_in.id      and prdrsltinput.persons_id_upd = person_upd.id      and prdrsltinput.opeitms_id = opeitm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdrsltinputs;
 CREATE TABLE sio.sio_r_prdrsltinputs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdrsltinputs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prdrsltinput_sno  varchar (40) 
,prdrsltinput_cno  varchar (40) 
,prdrsltinput_expiredate   date 
,prdrsltinput_qty  numeric (22,6)
,prdrsltinput_sno_prdinst  varchar (50) 
,prdrsltinput_isudate   timestamp(6) 
,prdrsltinput_message_code  varchar (256) 
,prdrsltinput_sno_prdord  varchar (50) 
,prdrsltinput_cmpldate   timestamp(6) 
,prdrsltinput_price  numeric (38,4)
,prdrsltinput_amt  numeric (18,4)
,prdrsltinput_tax  numeric (38,4)
,prdrsltinput_result_f  varchar (1) 
,prdrsltinput_qty_case  numeric (22,0)
,prdrsltinput_remark  varchar (4000) 
,prdrsltinput_contents  varchar (4000) 
,prdrsltinput_opeitm_id  numeric (38,0)
,prdrsltinput_id  numeric (38,0)
,prdrsltinput_shelfno_id_in  numeric (38,0)
,prdrsltinput_person_id_upd  numeric (38,0)
,prdrsltinput_updated_at   timestamp(6) 
,prdrsltinput_created_at   timestamp(6) 
,prdrsltinput_update_ip  varchar (40) 
,id  numeric (38,0)
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
 CREATE INDEX sio_r_prdrsltinputs_uk1 
  ON sio.sio_r_prdrsltinputs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdrsltinputs_seq ;
 create sequence sio.sio_r_prdrsltinputs_seq ;
 drop sequence  if exists  prdreplyinputs_seq ;
 create sequence prdreplyinputs_seq ;
  drop view if  exists r_prdreplyinputs cascade ; 
 create or replace view r_prdreplyinputs as select  
prdreplyinput.id id,
prdreplyinput.id  prdreplyinput_id,
prdreplyinput.qty_case_bal  prdreplyinput_qty_case_bal,
prdreplyinput.starttime  prdreplyinput_starttime,
prdreplyinput.result_f  prdreplyinput_result_f,
prdreplyinput.qty_case  prdreplyinput_qty_case,
prdreplyinput.isudate  prdreplyinput_isudate,
prdreplyinput.duedate  prdreplyinput_duedate,
prdreplyinput.qty  prdreplyinput_qty,
prdreplyinput.persons_id_upd   prdreplyinput_person_id_upd,
prdreplyinput.updated_at  prdreplyinput_updated_at,
prdreplyinput.created_at  prdreplyinput_created_at,
prdreplyinput.update_ip  prdreplyinput_update_ip,
prdreplyinput.expiredate  prdreplyinput_expiredate,
prdreplyinput.remark  prdreplyinput_remark,
prdreplyinput.contents  prdreplyinput_contents,
prdreplyinput.locas_id_to   prdreplyinput_loca_id_to,
prdreplyinput.message_code  prdreplyinput_message_code,
prdreplyinput.siosession  prdreplyinput_siosession,
prdreplyinput.opeitms_id   prdreplyinput_opeitm_id
 from prdreplyinputs   prdreplyinput,
  r_persons  person_upd ,  r_locas  loca_to ,  r_opeitms  opeitm 
  where       prdreplyinput.persons_id_upd = person_upd.id      and prdreplyinput.locas_id_to = loca_to.id      and prdreplyinput.opeitms_id = opeitm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdreplyinputs;
 CREATE TABLE sio.sio_r_prdreplyinputs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdreplyinputs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prdreplyinput_result_f  varchar (1) 
,prdreplyinput_expiredate   date 
,prdreplyinput_starttime   timestamp(6) 
,prdreplyinput_qty_case  numeric (22,0)
,prdreplyinput_isudate   timestamp(6) 
,prdreplyinput_message_code  varchar (256) 
,prdreplyinput_siosession  varchar (20) 
,prdreplyinput_duedate   timestamp(6) 
,prdreplyinput_qty  numeric (22,6)
,prdreplyinput_qty_case_bal  numeric (38,0)
,prdreplyinput_remark  varchar (4000) 
,prdreplyinput_contents  varchar (4000) 
,prdreplyinput_opeitm_id  numeric (38,0)
,prdreplyinput_id  numeric (38,0)
,prdreplyinput_person_id_upd  numeric (38,0)
,prdreplyinput_updated_at   timestamp(6) 
,prdreplyinput_created_at   timestamp(6) 
,prdreplyinput_update_ip  varchar (40) 
,prdreplyinput_loca_id_to  numeric (38,0)
,id  numeric (38,0)
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
 CREATE INDEX sio_r_prdreplyinputs_uk1 
  ON sio.sio_r_prdreplyinputs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdreplyinputs_seq ;
 create sequence sio.sio_r_prdreplyinputs_seq ;
 drop sequence  if exists  prdrets_seq ;
 create sequence prdrets_seq ;
  drop view if  exists r_prdrets cascade ; 
 create or replace view r_prdrets as select  
prdret.id id,
prdret.id  prdret_id,
prdret.sno  prdret_sno,
prdret.isudate  prdret_isudate,
prdret.locas_id_to   prdret_loca_id_to,
prdret.retdate  prdret_retdate,
prdret.locas_id_fm   prdret_loca_id_fm,
prdret.chrgs_id   prdret_chrg_id,
prdret.opeitms_id   prdret_opeitm_id,
prdret.contents  prdret_contents,
prdret.remark  prdret_remark,
prdret.expiredate  prdret_expiredate,
prdret.update_ip  prdret_update_ip,
prdret.created_at  prdret_created_at,
prdret.updated_at  prdret_updated_at,
prdret.persons_id_upd   prdret_person_id_upd,
prdret.qty  prdret_qty,
prdret.tax  prdret_tax,
prdret.qty_case  prdret_qty_case,
prdret.prjnos_id   prdret_prjno_id
 from prdrets   prdret,
  r_locas  loca_to ,  r_locas  loca_fm ,  r_chrgs  chrg ,  r_opeitms  opeitm ,  r_persons  person_upd ,  r_prjnos  prjno 
  where       prdret.locas_id_to = loca_to.id      and prdret.locas_id_fm = loca_fm.id      and prdret.chrgs_id = chrg.id      and prdret.opeitms_id = opeitm.id      and prdret.persons_id_upd = person_upd.id      and prdret.prjnos_id = prjno.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdrets;
 CREATE TABLE sio.sio_r_prdrets (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdrets_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prdret_sno  varchar (40) 
,prdret_expiredate   date 
,prdret_qty_case  numeric (22,0)
,prdret_isudate   timestamp(6) 
,prdret_qty  numeric (22,6)
,prdret_tax  numeric (38,4)
,prdret_retdate   date 
,prdret_remark  varchar (4000) 
,prdret_contents  varchar (4000) 
,prdret_person_id_upd  numeric (38,0)
,id  numeric (38,0)
,prdret_prjno_id  numeric (38,0)
,prdret_id  numeric (38,0)
,prdret_loca_id_to  numeric (38,0)
,prdret_loca_id_fm  numeric (38,0)
,prdret_chrg_id  numeric (38,0)
,prdret_opeitm_id  numeric (38,0)
,prdret_update_ip  varchar (40) 
,prdret_created_at   timestamp(6) 
,prdret_updated_at   timestamp(6) 
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
 CREATE INDEX sio_r_prdrets_uk1 
  ON sio.sio_r_prdrets(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdrets_seq ;
 create sequence sio.sio_r_prdrets_seq ;
  drop view if  exists r_prdstrs cascade ; 
 create or replace view r_prdstrs as select  
prdstr.chrgs_id   prdstr_chrg_id,
prdstr.contents  prdstr_contents,
prdstr.id id,
prdstr.id  prdstr_id,
prdstr.remark  prdstr_remark,
prdstr.expiredate  prdstr_expiredate,
prdstr.sno_prdord  prdstr_sno_prdord,
prdstr.update_ip  prdstr_update_ip,
prdstr.created_at  prdstr_created_at,
prdstr.updated_at  prdstr_updated_at,
prdstr.persons_id_upd   prdstr_person_id_upd,
prdstr.qty  prdstr_qty,
prdstr.sno  prdstr_sno,
prdstr.isudate  prdstr_isudate,
prdstr.qty_case  prdstr_qty_case,
prdstr.gno  prdstr_gno,
prdstr.cno  prdstr_cno,
prdstr.starttime  prdstr_starttime
 from prdstrs   prdstr,
  r_chrgs  chrg ,  r_persons  person_upd 
  where       prdstr.chrgs_id = chrg.id      and prdstr.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdstrs;
 CREATE TABLE sio.sio_r_prdstrs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdstrs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prdstr_gno  varchar (40) 
,prdstr_cno  varchar (40) 
,prdstr_sno  varchar (40) 
,prdstr_starttime   timestamp(6) 
,prdstr_sno_prdord  varchar (50) 
,prdstr_isudate   timestamp(6) 
,prdstr_qty_case  numeric (22,0)
,prdstr_expiredate   date 
,prdstr_qty  numeric (22,6)
,prdstr_contents  varchar (4000) 
,prdstr_remark  varchar (4000) 
,prdstr_updated_at   timestamp(6) 
,id  numeric (38,0)
,prdstr_id  numeric (38,0)
,prdstr_update_ip  varchar (40) 
,prdstr_created_at   timestamp(6) 
,prdstr_chrg_id  numeric (38,0)
,prdstr_person_id_upd  numeric (38,0)
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
 CREATE INDEX sio_r_prdstrs_uk1 
  ON sio.sio_r_prdstrs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdstrs_seq ;
 create sequence sio.sio_r_prdstrs_seq ;
 drop sequence  if exists  prdests_seq ;
 create sequence prdests_seq ;
  drop view if  exists r_prdests cascade ; 
 create or replace view r_prdests as select  
prdest.prjnos_id   prdest_prjno_id,
prdest.starttime  prdest_starttime,
prdest.isudate  prdest_isudate,
prdest.duedate  prdest_duedate,
prdest.toduedate  prdest_toduedate,
prdest.qty  prdest_qty,
prdest.sno  prdest_sno,
prdest.expiredate  prdest_expiredate,
prdest.persons_id_upd   prdest_person_id_upd,
prdest.update_ip  prdest_update_ip,
prdest.created_at  prdest_created_at,
prdest.updated_at  prdest_updated_at,
prdest.tax  prdest_tax,
prdest.id id,
prdest.id  prdest_id,
prdest.locas_id_to   prdest_loca_id_to,
prdest.processseq_pare  prdest_processseq_pare,
prdest.contents  prdest_contents,
prdest.opeitms_id   prdest_opeitm_id,
prdest.remark  prdest_remark,
prdest.chrgs_id   prdest_chrg_id
 from prdests   prdest,
  r_prjnos  prjno ,  r_persons  person_upd ,  r_locas  loca_to ,  r_opeitms  opeitm ,  r_chrgs  chrg 
  where       prdest.prjnos_id = prjno.id      and prdest.persons_id_upd = person_upd.id      and prdest.locas_id_to = loca_to.id      and prdest.opeitms_id = opeitm.id      and prdest.chrgs_id = chrg.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdests;
 CREATE TABLE sio.sio_r_prdests (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdests_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prdest_sno  varchar (40) 
,prdest_tax  numeric (38,4)
,prdest_qty  numeric (22,6)
,prdest_expiredate   date 
,prdest_processseq_pare  numeric (38,0)
,prdest_duedate   timestamp(6) 
,prdest_isudate   timestamp(6) 
,prdest_toduedate   timestamp(6) 
,prdest_starttime   timestamp(6) 
,prdest_contents  varchar (4000) 
,prdest_remark  varchar (4000) 
,prdest_chrg_id  numeric (38,0)
,prdest_person_id_upd  numeric (38,0)
,prdest_update_ip  varchar (40) 
,prdest_created_at   timestamp(6) 
,prdest_updated_at   timestamp(6) 
,id  numeric (38,0)
,prdest_id  numeric (38,0)
,prdest_loca_id_to  numeric (38,0)
,prdest_opeitm_id  numeric (38,0)
,prdest_prjno_id  numeric (38,0)
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
 CREATE INDEX sio_r_prdests_uk1 
  ON sio.sio_r_prdests(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdests_seq ;
 create sequence sio.sio_r_prdests_seq ;
