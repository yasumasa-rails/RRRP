
  drop view if  exists r_prdrsltinputs cascade ; 
 create or replace view r_prdrsltinputs as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
prdrsltinput.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
prdrsltinput.cmpldate  prdrsltinput_cmpldate,
prdrsltinput.result_f  prdrsltinput_result_f,
prdrsltinput.qty_case  prdrsltinput_qty_case,
prdrsltinput.remark  prdrsltinput_remark,
prdrsltinput.expiredate  prdrsltinput_expiredate,
prdrsltinput.update_ip  prdrsltinput_update_ip,
prdrsltinput.created_at  prdrsltinput_created_at,
prdrsltinput.updated_at  prdrsltinput_updated_at,
prdrsltinput.persons_id_upd   prdrsltinput_person_id_upd,
prdrsltinput.qty  prdrsltinput_qty,
prdrsltinput.isudate  prdrsltinput_isudate,
prdrsltinput.contents  prdrsltinput_contents,
prdrsltinput.opeitms_id   prdrsltinput_opeitm_id,
prdrsltinput.message_code  prdrsltinput_message_code,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
prdrsltinput.sno_prdinst  prdrsltinput_sno_prdinst,
prdrsltinput.cno  prdrsltinput_cno,
prdrsltinput.sno  prdrsltinput_sno,
prdrsltinput.sno_prdord  prdrsltinput_sno_prdord,
prdrsltinput.price  prdrsltinput_price,
prdrsltinput.amt  prdrsltinput_amt,
prdrsltinput.tax  prdrsltinput_tax,
prdrsltinput.sno_prdreplyinput  prdrsltinput_sno_prdreplyinput
 from prdrsltinputs   prdrsltinput,
  r_persons  person_upd ,  r_opeitms  opeitm 
  where       prdrsltinput.persons_id_upd = person_upd.id      and prdrsltinput.opeitms_id = opeitm.id     ;
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
,prdrsltinput_message_code  varchar (256) 
,itm_code  varchar (50) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,itm_name  varchar (100) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,prdrsltinput_sno_prdreplyinput  varchar (50) 
,prdrsltinput_cmpldate   timestamp(6) 
,prdrsltinput_result_f  varchar (1) 
,prdrsltinput_qty_case  numeric (22,0)
,prdrsltinput_qty  numeric (22,6)
,prdrsltinput_isudate   timestamp(6) 
,prdrsltinput_sno_prdinst  varchar (50) 
,prdrsltinput_cno  varchar (40) 
,prdrsltinput_sno  varchar (40) 
,prdrsltinput_sno_prdord  varchar (50) 
,prdrsltinput_price  numeric (38,4)
,prdrsltinput_amt  numeric (18,4)
,prdrsltinput_tax  numeric (38,4)
,prdrsltinput_expiredate   date 
,prdrsltinput_remark  varchar (4000) 
,prdrsltinput_contents  varchar (4000) 
,prdrsltinput_updated_at   timestamp(6) 
,prdrsltinput_created_at   timestamp(6) 
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,prdrsltinput_opeitm_id  numeric (38,0)
,prdrsltinput_update_ip  varchar (40) 
,boxe_unit_id_outbox  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,prdrsltinput_person_id_upd  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
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
  drop view if  exists r_prdreplyinputs cascade ; 
 create or replace view r_prdreplyinputs as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
prdreplyinput.id id,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
prdreplyinput.result_f  prdreplyinput_result_f,
prdreplyinput.qty_case  prdreplyinput_qty_case,
prdreplyinput.update_ip  prdreplyinput_update_ip,
prdreplyinput.duedate  prdreplyinput_duedate,
prdreplyinput.persons_id_upd   prdreplyinput_person_id_upd,
prdreplyinput.contents  prdreplyinput_contents,
prdreplyinput.isudate  prdreplyinput_isudate,
prdreplyinput.opeitms_id   prdreplyinput_opeitm_id,
prdreplyinput.expiredate  prdreplyinput_expiredate,
prdreplyinput.updated_at  prdreplyinput_updated_at,
prdreplyinput.qty  prdreplyinput_qty,
prdreplyinput.remark  prdreplyinput_remark,
prdreplyinput.created_at  prdreplyinput_created_at,
prdreplyinput.locas_id_to   prdreplyinput_loca_id_to,
prdreplyinput.message_code  prdreplyinput_message_code,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
prdreplyinput.sno_prdord  prdreplyinput_sno_prdord,
prdreplyinput.sno_prdinst  prdreplyinput_sno_prdinst,
prdreplyinput.replydate  prdreplyinput_replydate,
prdreplyinput.sno_purord  prdreplyinput_sno_purord,
prdreplyinput.cno  prdreplyinput_cno
 from prdreplyinputs   prdreplyinput,
  r_persons  person_upd ,  r_opeitms  opeitm ,  r_locas  loca_to 
  where       prdreplyinput.persons_id_upd = person_upd.id      and prdreplyinput.opeitms_id = opeitm.id      and prdreplyinput.locas_id_to = loca_to.id     ;
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
,prdreplyinput_message_code  varchar (256) 
,itm_code  varchar (50) 
,loca_code_to  varchar (50) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,itm_name  varchar (100) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,loca_name_to  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,prdreplyinput_cno  varchar (40) 
,prdreplyinput_result_f  varchar (1) 
,prdreplyinput_qty_case  numeric (22,0)
,prdreplyinput_duedate   timestamp(6) 
,prdreplyinput_isudate   timestamp(6) 
,prdreplyinput_qty  numeric (22,6)
,prdreplyinput_sno_prdord  varchar (50) 
,prdreplyinput_sno_prdinst  varchar (50) 
,prdreplyinput_replydate   date 
,prdreplyinput_sno_purord  varchar (50) 
,prdreplyinput_expiredate   date 
,prdreplyinput_remark  varchar (4000) 
,prdreplyinput_contents  varchar (4000) 
,prdreplyinput_loca_id_to  numeric (38,0)
,prdreplyinput_update_ip  varchar (40) 
,prdreplyinput_opeitm_id  numeric (38,0)
,prdreplyinput_updated_at   timestamp(6) 
,opeitm_unit_id_prdpurshp  numeric (38,0)
,prdreplyinput_created_at   timestamp(6) 
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,prdreplyinput_person_id_upd  numeric (22,0)
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
  drop view if  exists r_purreplyinputs cascade ; 
 create or replace view r_purreplyinputs as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
purreplyinput.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
purreplyinput.cno  purreplyinput_cno,
purreplyinput.remark  purreplyinput_remark,
purreplyinput.expiredate  purreplyinput_expiredate,
purreplyinput.update_ip  purreplyinput_update_ip,
purreplyinput.created_at  purreplyinput_created_at,
purreplyinput.updated_at  purreplyinput_updated_at,
purreplyinput.persons_id_upd   purreplyinput_person_id_upd,
purreplyinput.qty  purreplyinput_qty,
purreplyinput.duedate  purreplyinput_duedate,
purreplyinput.isudate  purreplyinput_isudate,
purreplyinput.contents  purreplyinput_contents,
purreplyinput.opeitms_id   purreplyinput_opeitm_id,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
purreplyinput.qty_case  purreplyinput_qty_case,
purreplyinput.message_code  purreplyinput_message_code,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
purreplyinput.sno  purreplyinput_sno,
purreplyinput.replydate  purreplyinput_replydate,
purreplyinput.sno_purinst  purreplyinput_sno_purinst
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
,itm_code  varchar (50) 
,purreplyinput_message_code  varchar (256) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,itm_name  varchar (100) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,purreplyinput_duedate   timestamp(6) 
,purreplyinput_sno_purinst  varchar (50) 
,purreplyinput_replydate   date 
,purreplyinput_sno  varchar (40) 
,purreplyinput_qty_case  numeric (22,0)
,purreplyinput_cno  varchar (40) 
,purreplyinput_isudate   timestamp(6) 
,purreplyinput_qty  numeric (22,6)
,purreplyinput_expiredate   date 
,purreplyinput_remark  varchar (4000) 
,purreplyinput_contents  varchar (4000) 
,opeitm_itm_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,purreplyinput_updated_at   timestamp(6) 
,purreplyinput_opeitm_id  numeric (38,0)
,purreplyinput_created_at   timestamp(6) 
,opeitm_unit_id_prdpurshp  numeric (38,0)
,purreplyinput_update_ip  varchar (40) 
,itm_unit_id  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,purreplyinput_person_id_upd  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
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
 CREATE INDEX sio_r_purreplyinputs_uk1 
  ON sio.sio_r_purreplyinputs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purreplyinputs_seq ;
 create sequence sio.sio_r_purreplyinputs_seq ;
  drop view if  exists r_purrsltinputs cascade ; 
 create or replace view r_purrsltinputs as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
purrsltinput.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
purrsltinput.opeitms_id   purrsltinput_opeitm_id,
purrsltinput.result_f  purrsltinput_result_f,
purrsltinput.rcptdate  purrsltinput_rcptdate,
purrsltinput.remark  purrsltinput_remark,
purrsltinput.expiredate  purrsltinput_expiredate,
purrsltinput.update_ip  purrsltinput_update_ip,
purrsltinput.created_at  purrsltinput_created_at,
purrsltinput.updated_at  purrsltinput_updated_at,
purrsltinput.persons_id_upd   purrsltinput_person_id_upd,
purrsltinput.qty  purrsltinput_qty,
purrsltinput.isudate  purrsltinput_isudate,
purrsltinput.contents  purrsltinput_contents,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
purrsltinput.qty_case  purrsltinput_qty_case,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
purrsltinput.message_code  purrsltinput_message_code,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
purrsltinput.sno_purord  purrsltinput_sno_purord,
purrsltinput.sno_purinst  purrsltinput_sno_purinst,
purrsltinput.cno_purinst  purrsltinput_cno_purinst,
purrsltinput.sno  purrsltinput_sno,
purrsltinput.crrs_id   purrsltinput_crr_id,
purrsltinput.sno_purreplyinput  purrsltinput_sno_purreplyinput
 from purrsltinputs   purrsltinput,
  r_opeitms  opeitm ,  r_persons  person_upd ,  r_crrs  crr 
  where       purrsltinput.opeitms_id = opeitm.id      and purrsltinput.persons_id_upd = person_upd.id      and purrsltinput.crrs_id = crr.id     ;
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
,crr_code  varchar (50) 
,purrsltinput_message_code  varchar (256) 
,itm_code  varchar (50) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,itm_name  varchar (100) 
,crr_name  varchar (100) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,purrsltinput_sno_purreplyinput  varchar (50) 
,purrsltinput_cno_purinst  varchar (50) 
,purrsltinput_sno_purord  varchar (50) 
,purrsltinput_sno  varchar (40) 
,purrsltinput_result_f  varchar (1) 
,purrsltinput_rcptdate   timestamp(6) 
,purrsltinput_qty_case  numeric (22,0)
,purrsltinput_qty  numeric (22,6)
,purrsltinput_isudate   timestamp(6) 
,purrsltinput_sno_purinst  varchar (50) 
,purrsltinput_expiredate   date 
,purrsltinput_remark  varchar (4000) 
,purrsltinput_contents  varchar (4000) 
,opeitm_loca_id  numeric (38,0)
,purrsltinput_updated_at   timestamp(6) 
,purrsltinput_created_at   timestamp(6) 
,purrsltinput_update_ip  varchar (40) 
,opeitm_unit_id_prdpurshp  numeric (38,0)
,purrsltinput_crr_id  numeric (22,0)
,purrsltinput_opeitm_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,purrsltinput_person_id_upd  numeric (22,0)
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
 CREATE INDEX sio_r_purrsltinputs_uk1 
  ON sio.sio_r_purrsltinputs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purrsltinputs_seq ;
 create sequence sio.sio_r_purrsltinputs_seq ;
