
 alter table  mkords ALTER COLUMN opeitm_processseq_pare  TYPE numeric(0,0);

 alter table  mkords ALTER COLUMN opeitm_processseq_org  TYPE numeric(0,0);

 --- drop view r_mkords cascade  
 create or replace view r_mkords as select  
mkord.opeitm_processseq_org  mkord_opeitm_processseq_org,
mkord.opeitm_processseq_pare  mkord_opeitm_processseq_pare,
  itm_org.itm_std  itm_std_org ,
  itm_trn.itm_code  itm_code_trn ,
  itm_org.itm_code  itm_code_org ,
  itm_pare.itm_code  itm_code_pare ,
  itm_trn.itm_name  itm_name_trn ,
  itm_org.itm_name  itm_name_org ,
  itm_pare.itm_name  itm_name_pare ,
  loca_pare.loca_code  loca_code_pare ,
  chrg_trn.loca_code_sect_chrg  loca_code_sect_chrg_trn ,
  loca_trn.loca_code  loca_code_trn ,
  loca_org.loca_code  loca_code_org ,
  loca_pare.loca_name  loca_name_pare ,
  chrg_trn.loca_name_sect_chrg  loca_name_sect_chrg_trn ,
  loca_trn.loca_name  loca_name_trn ,
  loca_org.loca_name  loca_name_org ,
  chrg_trn.person_code_chrg  person_code_chrg_trn ,
  chrg_trn.person_name_chrg  person_name_chrg_trn ,
mkord.result_f  mkord_result_f,
mkord.orgtblname  mkord_orgtblname,
mkord.created_at  mkord_created_at,
mkord.update_ip  mkord_update_ip,
mkord.expiredate  mkord_expiredate,
mkord.updated_at  mkord_updated_at,
mkord.persons_id_upd   mkord_person_id_upd,
mkord.message_code  mkord_message_code,
mkord.remark  mkord_remark,
mkord.cmpldate  mkord_cmpldate,
mkord.isudate  mkord_isudate,
mkord.incnt  mkord_incnt,
mkord.inqty  mkord_inqty,
mkord.skipcnt  mkord_skipcnt,
mkord.outcnt  mkord_outcnt,
mkord.sno_org  mkord_sno_org,
mkord.sno_pare  mkord_sno_pare,
mkord.tblname  mkord_tblname,
mkord.confirm  mkord_confirm,
mkord.manual  mkord_manual,
mkord.opeitm_processseq_trn  mkord_opeitm_processseq_trn,
  chrg_trn.person_sect_id_chrg  person_sect_id_chrg_trn ,
  itm_pare.classlist_name  classlist_name_pare ,
mkord.starttime_trn  mkord_starttime_trn,
mkord.runtime  mkord_runtime,
mkord.id  mkord_id,
mkord.id id,
mkord.duedate_trn  mkord_duedate_trn,
mkord.inamt  mkord_inamt,
mkord.outamt  mkord_outamt,
mkord.skipqty  mkord_skipqty,
mkord.skipamt  mkord_skipamt,
mkord.outqty  mkord_outqty,
mkord.duedate_pare  mkord_duedate_pare,
mkord.sno_trn  mkord_sno_trn,
mkord.gno_trn  mkord_gno_trn,
mkord.paretblname  mkord_paretblname
 from mkords   mkord,
  r_persons  person_upd 
  where       mkord.persons_id_upd = person_upd.id     ;
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
,mkord_itm_code_trn  varchar (50) 
,mkord_itm_code_org  varchar (50) 
,mkord_itm_name_trn  varchar (100) 
,mkord_sno_org  varchar (50) 
,mkord_itm_name_org  varchar (100) 
,mkord_loca_code_trn  varchar (50) 
,itm_code_org  varchar (50) 
,itm_name_org  varchar (100) 
,mkord_loca_name_trn  varchar (100) 
,mkord_loca_code_to_trn  varchar (50) 
,mkord_loca_code_org  varchar (50) 
,mkord_loca_name_to_trn  varchar (100) 
,mkord_loca_name_org  varchar (100) 
,itm_std_org  varchar (50) 
,loca_code_org  varchar (50) 
,loca_name_org  varchar (100) 
,mkord_person_code_chrg_trn  varchar (50) 
,mkord_person_name_chrg_trn  varchar (100) 
,mkord_paretblname  varchar (20) 
,mkord_sno_pare  varchar (50) 
,itm_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,mkord_itm_code_pare  varchar (50) 
,loca_code_pare  varchar (50) 
,mkord_itm_name_pare  varchar (100) 
,loca_name_pare  varchar (100) 
,mkord_loca_code_pare  varchar (50) 
,mkord_loca_name_pare  varchar (100) 
,mkord_duedate_pare   timestamp(6) 
,loca_code_to  varchar (50) 
,loca_name_to  varchar (100) 
,mkord_starttime_trn   timestamp(6) 
,mkord_duedate_trn   timestamp(6) 
,itm_code_trn  varchar (50) 
,itm_name_trn  varchar (100) 
,mkord_opeitm_processseq_trn  varchar (3) 
,loca_code_trn  varchar (50) 
,loca_name_trn  varchar (100) 
,person_code_chrg_trn  varchar (50) 
,person_name_chrg_trn  varchar (100) 
,loca_code_sect_chrg_trn  varchar (50) 
,loca_name_sect_chrg_trn  varchar (100) 
,unit_code_pare  varchar (50) 
,unit_name_org  varchar (100) 
,unit_name_trn  varchar (100) 
,classlist_code_trn  varchar (50) 
,classlist_code_pare  varchar (50) 
,unit_code_org  varchar (50) 
,unit_code_trn  varchar (50) 
,classlist_name_trn  varchar (100) 
,classlist_name_pare  varchar (100) 
,unit_name_pare  varchar (100) 
,mkord_fullord_pare  varchar (1) 
,mkord_manual  varchar (1) 
,mkord_outqty  numeric (22,6)
,mkord_skipamt  numeric (38,4)
,mkord_skipqty  numeric (22,6)
,mkord_opeitm_processseq_org  numeric (22,0)
,mkord_outamt  numeric (38,4)
,mkord_outcnt  numeric (38,0)
,mkord_skipcnt  numeric (38,0)
,mkord_inqty  numeric (22,6)
,mkord_incnt  numeric (38,0)
,mkord_opeitm_processseq_pare  numeric (22,0)
,mkord_message_code  varchar (256) 
,mkord_expiredate   date 
,mkord_gno_trn  varchar (50) 
,mkord_sno_trn  varchar (50) 
,mkord_inamt  numeric (38,4)
,usrgrp_code_chrg_trn  varchar (50) 
,usrgrp_name_chrg_trn  varchar (100) 
,scrlv_code_chrg_trn  varchar (50) 
,mkord_remark  varchar (4000) 
,mkord_id  numeric (38,0)
,id  numeric (38,0)
,mkord_created_at   timestamp(6) 
,mkord_update_ip  varchar (40) 
,mkord_updated_at   timestamp(6) 
,mkord_person_id_upd  numeric (38,0)
,person_sect_id_chrg_trn  numeric (22,0)
,itm_classlist_id_org  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,itm_unit_id_trn  numeric (22,0)
,itm_unit_id_org  numeric (22,0)
,itm_unit_id_pare  numeric (22,0)
,itm_classlist_id_trn  numeric (38,0)
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
