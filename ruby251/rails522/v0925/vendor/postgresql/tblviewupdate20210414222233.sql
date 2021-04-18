
  drop view if  exists r_schofmkords cascade ; 
 create or replace view r_schofmkords as select  
  itm.itm_name  itm_name ,
  itm.itm_code  itm_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_unit_id  itm_unit_id ,
schofmkord.id id,
  mkord.loca_code_to  loca_code_to ,
  mkord.loca_name_to  loca_name_to ,
  trngantt.prjno_name  prjno_name ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  mkord.itm_code_pare  itm_code_pare ,
  mkord.itm_name_pare  itm_name_pare ,
  trngantt.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  trngantt.trngantt_itm_id  trngantt_itm_id ,
  trngantt.trngantt_loca_id  trngantt_loca_id ,
  mkord.mkord_message_code  mkord_message_code ,
  mkord.mkord_sno_org  mkord_sno_org ,
  mkord.mkord_loca_id_org  mkord_loca_id_org ,
  mkord.loca_code_org  loca_code_org ,
  mkord.loca_name_org  loca_name_org ,
  mkord.mkord_loca_id_trn  mkord_loca_id_trn ,
  mkord.loca_code_trn  loca_code_trn ,
  mkord.loca_name_trn  loca_name_trn ,
  mkord.mkord_itm_id_org  mkord_itm_id_org ,
  mkord.itm_code_org  itm_code_org ,
  mkord.itm_name_org  itm_name_org ,
  mkord.mkord_itm_id_trn  mkord_itm_id_trn ,
  mkord.itm_code_trn  itm_code_trn ,
  mkord.itm_name_trn  itm_name_trn ,
  trngantt.prjno_code  prjno_code ,
  trngantt.trngantt_prjno_id  trngantt_prjno_id ,
  mkord.mkord_sno_trn  mkord_sno_trn ,
  mkord.mkord_chrg_id_trn  mkord_chrg_id_trn ,
  mkord.person_code_chrg_trn  person_code_chrg_trn ,
  mkord.person_name_chrg_trn  person_name_chrg_trn ,
  mkord.person_sect_id_chrg_trn  person_sect_id_chrg_trn ,
  mkord.loca_code_sect_chrg_trn  loca_code_sect_chrg_trn ,
  mkord.loca_name_sect_chrg_trn  loca_name_sect_chrg_trn ,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
  mkord.mkord_sno_pare  mkord_sno_pare ,
  mkord.loca_code_pare  loca_code_pare ,
  mkord.loca_name_pare  loca_name_pare ,
  mkord.mkord_loca_id_pare  mkord_loca_id_pare ,
  mkord.mkord_itm_id_pare  mkord_itm_id_pare ,
  mkord.mkord_itm_code_pare  mkord_itm_code_pare ,
  trngantt.prjno_code_chil  prjno_code_chil ,
  itm.itm_classlist_id  itm_classlist_id ,
  trngantt.trngantt_loca_id_pare  trngantt_loca_id_pare ,
  mkord.classlist_name_pare  classlist_name_pare ,
  trngantt.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  mkord.mkord_loca_id_to  mkord_loca_id_to ,
  mkord.classlist_code_org  classlist_code_org ,
  mkord.classlist_name_org  classlist_name_org ,
schofmkord.created_at  schofmkord_created_at,
schofmkord.updated_at  schofmkord_updated_at,
schofmkord.persons_id_upd   schofmkord_person_id_upd,
schofmkord.mkords_id   schofmkord_mkord_id,
schofmkord.trngantts_id   schofmkord_trngantt_id,
schofmkord.expiredate  schofmkord_expiredate,
schofmkord.contents  schofmkord_contents,
schofmkord.remark  schofmkord_remark,
schofmkord.processseq  schofmkord_processseq,
schofmkord.itms_id   schofmkord_itm_id,
schofmkord.update_ip  schofmkord_update_ip
 from schofmkords   schofmkord,
  r_persons  person_upd ,  r_mkords  mkord ,  r_trngantts  trngantt ,  r_itms  itm 
  where       schofmkord.persons_id_upd = person_upd.id      and schofmkord.mkords_id = mkord.id      and schofmkord.trngantts_id = trngantt.id      and schofmkord.itms_id = itm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_schofmkords;
 CREATE TABLE sio.sio_r_schofmkords (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_schofmkords_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,person_code_upd  varchar (50) 
,itm_code  varchar (50) 
,person_name_upd  varchar (100) 
,itm_name  varchar (100) 
,itm_code_trn  varchar (50) 
,itm_name_trn  varchar (100) 
,loca_code_trn  varchar (50) 
,loca_name_trn  varchar (100) 
,person_code_chrg_trn  varchar (50) 
,person_name_chrg_trn  varchar (100) 
,loca_code_sect_chrg_trn  varchar (50) 
,loca_name_sect_chrg_trn  varchar (100) 
,loca_code_to  varchar (50) 
,loca_name_to  varchar (100) 
,mkord_sno_trn  varchar (50) 
,mkord_sno_pare  varchar (50) 
,itm_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,mkord_itm_code_pare  varchar (50) 
,loca_code_pare  varchar (50) 
,loca_name_pare  varchar (100) 
,mkord_sno_org  varchar (50) 
,itm_code_org  varchar (50) 
,itm_name_org  varchar (100) 
,loca_code_org  varchar (50) 
,loca_name_org  varchar (100) 
,classlist_name_org  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name_pare  varchar (100) 
,classlist_code_org  varchar (50) 
,classlist_name  varchar (100) 
,mkord_message_code  varchar (256) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,schofmkord_processseq  numeric (38,0)
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,schofmkord_expiredate   date 
,schofmkord_remark  varchar (4000) 
,schofmkord_contents  varchar (4000) 
,trngantt_itm_id_pare  numeric (38,0)
,mkord_loca_id_pare  numeric (38,0)
,mkord_itm_id_pare  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,mkord_loca_id_to  numeric (38,0)
,schofmkord_created_at   timestamp(6) 
,schofmkord_updated_at   timestamp(6) 
,schofmkord_update_ip  varchar (40) 
,mkord_chrg_id_trn  numeric (38,0)
,mkord_itm_id_trn  numeric (38,0)
,mkord_itm_id_org  numeric (38,0)
,mkord_loca_id_trn  numeric (38,0)
,mkord_loca_id_org  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,schofmkord_mkord_id  numeric (22,0)
,schofmkord_trngantt_id  numeric (38,0)
,schofmkord_itm_id  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,person_sect_id_chrg_trn  numeric (22,0)
,prjno_code_chil  varchar (50) 
,schofmkord_person_id_upd  numeric (22,0)
,itm_unit_id  numeric (22,0)
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
 CREATE INDEX sio_r_schofmkords_uk1 
  ON sio.sio_r_schofmkords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_schofmkords_seq ;
 create sequence sio.sio_r_schofmkords_seq ;
