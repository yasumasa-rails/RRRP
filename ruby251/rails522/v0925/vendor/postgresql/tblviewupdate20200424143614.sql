
 --- drop view r_mkords cascade  
 create or replace view r_mkords as select  
  chrg_trn.scrlv_code_chrg  scrlv_code_chrg_trn ,
  chrg_trn.loca_code_sect_chrg  loca_code_sect_chrg_trn ,
  chrg_trn.loca_name_sect_chrg  loca_name_sect_chrg_trn ,
  chrg_trn.person_code_chrg  person_code_chrg_trn ,
  chrg_trn.person_name_chrg  person_name_chrg_trn ,
mkord.created_at  mkord_created_at,
mkord.expiredate  mkord_expiredate,
mkord.message_code  mkord_message_code,
mkord.persons_id_upd   mkord_person_id_upd,
mkord.remark  mkord_remark,
mkord.result_f  mkord_result_f,
mkord.update_ip  mkord_update_ip,
mkord.updated_at  mkord_updated_at,
mkord.orgtblname  mkord_orgtblname,
mkord.cmpldate  mkord_cmpldate,
mkord.isudate  mkord_isudate,
mkord.incnt  mkord_incnt,
mkord.outcnt  mkord_outcnt,
mkord.skipcnt  mkord_skipcnt,
mkord.inqty  mkord_inqty,
mkord.outqty  mkord_outqty,
  chrg_trn.usrgrp_name_chrg  usrgrp_name_chrg_trn ,
mkord.chrgs_id_trn   mkord_chrg_id_trn,
mkord.sno_pare  mkord_sno_pare,
mkord.sno_org  mkord_sno_org,
mkord.tblname  mkord_tblname,
mkord.confirm  mkord_confirm,
mkord.itm_code_org  mkord_itm_code_org,
mkord.itm_name_org  mkord_itm_name_org,
mkord.itm_code_trn  mkord_itm_code_trn,
mkord.itm_name_trn  mkord_itm_name_trn,
mkord.person_code_chrg_trn  mkord_person_code_chrg_trn,
mkord.person_name_chrg_trn  mkord_person_name_chrg_trn,
mkord.loca_code_trn  mkord_loca_code_trn,
mkord.loca_name_trn  mkord_loca_name_trn,
mkord.manual  mkord_manual,
mkord.opeitm_processseq_trn  mkord_opeitm_processseq_trn,
mkord.loca_name_org  mkord_loca_name_org,
mkord.loca_code_to_trn  mkord_loca_code_to_trn,
mkord.loca_name_to_trn  mkord_loca_name_to_trn,
mkord.loca_code_org  mkord_loca_code_org,
  chrg_trn.person_sect_id_chrg  person_sect_id_chrg_trn ,
  chrg_trn.usrgrp_code_chrg  usrgrp_code_chrg_trn ,
mkord.starttime_trn  mkord_starttime_trn,
mkord.runtime  mkord_runtime,
mkord.duedate_trn  mkord_duedate_trn,
mkord.skipqty  mkord_skipqty,
mkord.skipamt  mkord_skipamt,
mkord.outamt  mkord_outamt,
mkord.inamt  mkord_inamt,
mkord.id  mkord_id,
mkord.id id,
mkord.duedate_pare  mkord_duedate_pare,
  chrg_trn.chrg_person_id_chrg  chrg_person_id_chrg_trn ,
mkord.fullord_pare  mkord_fullord_pare,
mkord.loca_code_pare  mkord_loca_code_pare,
mkord.loca_name_pare  mkord_loca_name_pare,
mkord.itm_name_pare  mkord_itm_name_pare,
mkord.itm_code_pare  mkord_itm_code_pare,
mkord.paretblname  mkord_paretblname
 from mkords   mkord,
  r_persons  person_upd ,  r_chrgs  chrg_trn 
  where       mkord.persons_id_upd = person_upd.id      and mkord.chrgs_id_trn = chrg_trn.id     ;
 DROP TABLE IF EXISTS sio.sio_r_mkords;
 CREATE TABLE sio.sio_r_mkords (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_mkords_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
          ,sio_Term_id varchar(30)
          ,sio_session_id numeric(38,0)
          ,sio_Command_Response char(1)
          ,sio_session_counter numeric(38,0)
          ,sio_classname varchar(50)
          ,sio_viewname varchar(30)
          ,sio_code varchar(30)
          ,sio_strsql varchar(4000)
          ,sio_totalcount numeric(38,0)
          ,sio_recordcount numeric(38,0)
          ,sio_start_record numeric(38,0)
          ,sio_end_record numeric(38,0)
          ,sio_sord varchar(256)
          ,sio_search varchar(10)
          ,sio_sidx varchar(256)
,mkord_isudate   timestamp(6) 
,mkord_confirm  varchar (1) 
,mkord_result_f  varchar (1) 
,mkord_tblname  varchar (20) 
,mkord_runtime  numeric (2,0)
,mkord_cmpldate   timestamp(6) 
,mkord_orgtblname  varchar (20) 
,mkord_sno_org  varchar (42) 
,mkord_itm_code_org  varchar (50) 
,mkord_itm_name_org  varchar (100) 
,mkord_loca_code_org  varchar (50) 
,mkord_loca_name_org  varchar (100) 
,mkord_paretblname  varchar (20) 
,mkord_sno_pare  varchar (42) 
,mkord_itm_code_trn  varchar (50) 
,mkord_itm_name_trn  varchar (100) 
,mkord_loca_code_trn  varchar (50) 
,mkord_loca_name_trn  varchar (100) 
,mkord_loca_code_to_trn  varchar (50) 
,mkord_loca_name_to_trn  varchar (100) 
,mkord_starttime_trn  varchar (18) 
,mkord_duedate_trn  varchar (18) 
,person_code_chrg_trn  varchar (50) 
,usrgrp_code_chrg_trn  varchar (50) 
,usrgrp_name_chrg_trn  varchar (100) 
,loca_code_sect_chrg_trn  varchar (50) 
,loca_name_sect_chrg_trn  varchar (100) 
,scrlv_code_chrg_trn  varchar (50) 
,mkord_person_code_chrg_trn  varchar (50) 
,mkord_opeitm_processseq_trn  varchar (3) 
,mkord_person_name_chrg_trn  varchar (100) 
,mkord_itm_code_pare  varchar (50) 
,mkord_itm_name_pare  varchar (100) 
,mkord_loca_code_pare  varchar (50) 
,mkord_loca_name_pare  varchar (100) 
,mkord_duedate_pare  varchar (18) 
,person_name_chrg_trn  varchar (100) 
,mkord_message_code  varchar (256) 
,mkord_expiredate   date 
,mkord_fullord_pare  varchar (1) 
,mkord_outqty  numeric (22,6)
,mkord_skipqty  numeric (22,6)
,mkord_outamt  numeric (38,4)
,mkord_skipamt  numeric (38,4)
,mkord_inamt  numeric (38,4)
,mkord_inqty  numeric (22,6)
,mkord_skipcnt  numeric (38,0)
,mkord_outcnt  numeric (38,0)
,mkord_incnt  numeric (38,0)
,mkord_manual  varchar (1) 
,scrlv_level1_chrg_trn  varchar (1) 
,person_email_chrg_trn  varchar (50) 
,mkord_remark  varchar (4000) 
,id  numeric (38,0)
,mkord_chrg_id_trn  numeric (38,0)
,mkord_created_at   timestamp(6) 
,mkord_id  numeric (38,0)
,mkord_update_ip  varchar (40) 
,mkord_updated_at   timestamp(6) 
,mkord_person_id_upd  numeric (38,0)
,person_sect_id_chrg_trn  numeric (22,0)
,chrg_person_id_chrg_trn  numeric (38,0)
          ,sio_errline varchar(4000)
          ,sio_org_tblname varchar(30)
          ,sio_org_tblid numeric(38,0)
          ,sio_add_time date
          ,sio_replay_time date
          ,sio_result_f char(1)
          ,sio_message_code char(10)
          ,sio_message_contents varchar(4000)
          ,sio_chk_done char(1)
);
 CREATE INDEX sio_r_mkords_uk1 
  ON sio.sio_r_mkords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_mkords_seq ;
 create sequence sio.sio_r_mkords_seq ;
