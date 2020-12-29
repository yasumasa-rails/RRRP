
 create table schofmkords (
 id numeric(38,0 )   not null  ,
 mkords_id numeric(22,0 )   not null ,
 trngantts_id numeric(38,0 )   not null ,
 itms_id numeric(38,0 )   not null ,
 processseq numeric(38,0 )   ,
 expiredate date  ,
 update_ip varchar(40)   ,
 updated_at timestamp(6)  ,
 persons_id_upd numeric(38,0 )   not null ,
 contents varchar(4000)   ,
 remark varchar(4000)   ,
 created_at timestamp(6)  ,
  CONSTRAINT schofmkords_id_pk PRIMARY KEY (id));
 ALTER TABLE schofmkords ADD CONSTRAINT schofmkord_mkords_id FOREIGN KEY (mkords_id)
																		 REFERENCES mkords (id);
 ALTER TABLE schofmkords ADD CONSTRAINT schofmkord_trngantts_id FOREIGN KEY (trngantts_id)
																		 REFERENCES trngantts (id);
 ALTER TABLE schofmkords ADD CONSTRAINT schofmkord_itms_id FOREIGN KEY (itms_id)
																		 REFERENCES itms (id);
 ALTER TABLE schofmkords ADD CONSTRAINT schofmkord_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 create sequence schofmkords_seq ;
 --- drop view r_schofmkords cascade  
 create or replace view r_schofmkords as select  
schofmkord.created_at  schofmkord_created_at,
schofmkord.updated_at  schofmkord_updated_at,
schofmkord.persons_id_upd   schofmkord_person_id_upd,
schofmkord.id id,
schofmkord.id  schofmkord_id,
schofmkord.mkords_id   schofmkord_mkord_id,
schofmkord.trngantts_id   schofmkord_trngantt_id,
schofmkord.expiredate  schofmkord_expiredate,
schofmkord.contents  schofmkord_contents,
schofmkord.remark  schofmkord_remark,
schofmkord.processseq  schofmkord_processseq,
schofmkord.itms_id   schofmkord_itm_id,
schofmkord.update_ip  schofmkord_update_ip,
  mkord.loca_name_sect_chrg_trn  loca_name_sect_chrg_trn ,
  mkord.loca_code_sect_chrg_trn  loca_code_sect_chrg_trn ,
  mkord.person_name_chrg_trn  person_name_chrg_trn ,
  mkord.person_code_chrg_trn  person_code_chrg_trn ,
  mkord.loca_name_org  loca_name_org ,
  mkord.loca_code_org  loca_code_org ,
  mkord.itm_name_pare  itm_name_pare ,
  mkord.loca_name_pare  loca_name_pare ,
  mkord.loca_name_trn  loca_name_trn ,
  mkord.itm_name_trn  itm_name_trn ,
  mkord.loca_code_trn  loca_code_trn ,
  mkord.itm_code_pare  itm_code_pare ,
  mkord.itm_name_org  itm_name_org ,
  mkord.loca_code_pare  loca_code_pare ,
  mkord.loca_name_to  loca_name_to ,
  mkord.loca_code_to  loca_code_to ,
  mkord.mkord_loca_id_to  mkord_loca_id_to ,
  mkord.classlist_name_pare  classlist_name_pare ,
  mkord.person_sect_id_chrg_trn  person_sect_id_chrg_trn ,
  mkord.itm_code_trn  itm_code_trn ,
  mkord.itm_code_org  itm_code_org ,
  mkord.mkord_message_code  mkord_message_code ,
  mkord.mkord_loca_id_trn  mkord_loca_id_trn ,
  mkord.mkord_itm_id_org  mkord_itm_id_org ,
  mkord.mkord_itm_id_trn  mkord_itm_id_trn ,
  mkord.mkord_loca_id_org  mkord_loca_id_org ,
  mkord.mkord_loca_id_pare  mkord_loca_id_pare ,
  mkord.mkord_itm_id_pare  mkord_itm_id_pare ,
  mkord.mkord_chrg_id_trn  mkord_chrg_id_trn ,
  mkord.classlist_code_org  classlist_code_org ,
  mkord.classlist_name_org  classlist_name_org ,
  trngantt.itm_code  itm_code ,
  trngantt.itm_name  itm_name ,
  trngantt.trngantt_itm_id  trngantt_itm_id ,
  trngantt.trngantt_loca_id  trngantt_loca_id ,
  trngantt.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  trngantt.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  trngantt.trngantt_loca_id_pare  trngantt_loca_id_pare ,
  trngantt.trngantt_prjno_id  trngantt_prjno_id ,
  trngantt.itm_classlist_id  itm_classlist_id ,
  trngantt.itm_unit_id  itm_unit_id ,
  trngantt.classlist_name  classlist_name ,
  trngantt.classlist_code  classlist_code ,
  trngantt.unit_name  unit_name ,
  trngantt.unit_code  unit_code ,
  trngantt.loca_code  loca_code ,
  trngantt.loca_name  loca_name ,
  trngantt.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  trngantt.shelfno_name_fm  shelfno_name_fm ,
  trngantt.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  trngantt.shelfno_code_fm  shelfno_code_fm ,
  trngantt.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  trngantt.itm_classlist_id_pare  itm_classlist_id_pare ,
  trngantt.itm_unit_id_pare  itm_unit_id_pare ,
  trngantt.classlist_code_pare  classlist_code_pare ,
  trngantt.unit_name_pare  unit_name_pare ,
  trngantt.unit_code_pare  unit_code_pare ,
  trngantt.prjno_name  prjno_name ,
  trngantt.prjno_code  prjno_code ,
  trngantt.prjno_code_chil  prjno_code_chil 
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
,loca_name_pare  varchar (100) 
,itm_name_trn  varchar (100) 
,loca_code_trn  varchar (50) 
,itm_code_pare  varchar (50) 
,itm_name_org  varchar (100) 
,loca_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,loca_name_trn  varchar (100) 
,shelfno_name_fm  varchar (100) 
,loca_name_to  varchar (100) 
,loca_code_to  varchar (50) 
,loca_name_sect_chrg_trn  varchar (100) 
,loca_name  varchar (100) 
,classlist_name_pare  varchar (100) 
,loca_code  varchar (50) 
,loca_code_sect_chrg_trn  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,itm_code_trn  varchar (50) 
,itm_code_org  varchar (50) 
,mkord_message_code  varchar (256) 
,prjno_code_chil  varchar (50) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,itm_name  varchar (100) 
,person_name_chrg_trn  varchar (100) 
,itm_code  varchar (50) 
,person_code_chrg_trn  varchar (50) 
,prjno_code  varchar (50) 
,classlist_name_org  varchar (100) 
,classlist_code_org  varchar (50) 
,prjno_name  varchar (100) 
,unit_code_pare  varchar (50) 
,unit_name_pare  varchar (100) 
,classlist_code_pare  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,shelfno_code_fm  varchar (50) 
,loca_name_org  varchar (100) 
,loca_code_org  varchar (50) 
,schofmkord_processseq  numeric (38,0)
,schofmkord_expiredate   date 
,itm_datascale  numeric (22,0)
,mkord_gno_trn  varchar (50) 
,itm_std_org  varchar (50) 
,mkord_sno_org  varchar (50) 
,mkord_orgtblname  varchar (20) 
,mkord_duedate_trn   timestamp(6) 
,mkord_confirm  varchar (1) 
,mkord_isudate   timestamp(6) 
,mkord_cmpldate   timestamp(6) 
,mkord_result_f  varchar (1) 
,mkord_runtime  numeric (2,0)
,mkord_opeitm_processseq_trn  varchar (3) 
,mkord_duedate_pare   timestamp(6) 
,mkord_starttime_trn   timestamp(6) 
,mkord_sno_pare  varchar (50) 
,mkord_outcnt  numeric (38,0)
,mkord_incnt  numeric (38,0)
,mkord_outqty  numeric (22,6)
,mkord_inamt  numeric (38,4)
,mkord_outamt  numeric (38,4)
,mkord_skipamt  numeric (38,4)
,mkord_skipcnt  numeric (38,0)
,mkord_skipqty  numeric (22,6)
,mkord_inqty  numeric (22,6)
,mkord_opeitm_processseq_org  varchar (3) 
,mkord_paretblname  varchar (20) 
,mkord_tblname  varchar (20) 
,mkord_manual  varchar (1) 
,mkord_duedate_org   timestamp(6) 
,mkord_opeitm_processseq_pare  varchar (3) 
,mkord_sno_trn  varchar (50) 
,trngantt_qty_pare_bal  numeric (22,6)
,trngantt_processseq_pare  numeric (38,0)
,trngantt_duedate_org   timestamp(6) 
,trngantt_consumtype  varchar (3) 
,loca_tel_pare  varchar (20) 
,trngantt_tblid  numeric (38,0)
,trngantt_qty_pare  numeric (22,6)
,trngantt_paretblname  varchar (30) 
,trngantt_paretblid  numeric (38,0)
,trngantt_qty_alloc  numeric (22,6)
,trngantt_qty_stk_pare  numeric (22,6)
,trngantt_qty_pare_alloc  numeric (22,6)
,trngantt_orgtblid  numeric (22,0)
,trngantt_mlevel  numeric (3,0)
,trngantt_consumauto  varchar (1) 
,trngantt_shuffle_flg  varchar (1) 
,trngantt_key  varchar (250) 
,trngantt_parenum  numeric (22,0)
,trngantt_chilnum  numeric (22,0)
,trngantt_qty  numeric (18,4)
,trngantt_qty_stk  numeric (22,0)
,trngantt_orgtblname  varchar (30) 
,itm_weight  numeric (22,0)
,unit_contents  varchar (4000) 
,itm_length  numeric (22,0)
,itm_design  varchar (50) 
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,itm_material  varchar (50) 
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,trngantt_qty_linkto_alloctbl  numeric (22,0)
,trngantt_tblname  varchar (30) 
,trngantt_processseq  numeric (38,0)
,trngantt_duedate   timestamp(6) 
,trngantt_consumchgoverqty  numeric (22,6)
,trngantt_starttime   timestamp(6) 
,trngantt_consumminqty  numeric (22,6)
,trngantt_consumunitqty  numeric (22,6)
,trngantt_qty_bal  numeric (22,6)
,schofmkord_remark  varchar (4000) 
,schofmkord_contents  varchar (4000) 
,schofmkord_mkord_id  numeric (22,0)
,schofmkord_id  numeric (38,0)
,schofmkord_updated_at   timestamp(6) 
,schofmkord_itm_id  numeric (38,0)
,schofmkord_created_at   timestamp(6) 
,id  numeric (38,0)
,schofmkord_person_id_upd  numeric (38,0)
,schofmkord_update_ip  varchar (40) 
,schofmkord_trngantt_id  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,mkord_loca_id_org  numeric (38,0)
,mkord_itm_id_trn  numeric (38,0)
,mkord_itm_id_org  numeric (38,0)
,mkord_loca_id_trn  numeric (38,0)
,person_sect_id_chrg_trn  numeric (22,0)
,mkord_loca_id_to  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,mkord_itm_id_pare  numeric (38,0)
,mkord_loca_id_pare  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,trngantt_itm_id  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,mkord_chrg_id_trn  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
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
