
 create table linktbls (
 id numeric(38,0 )   not null  ,
 remark varchar(4000)   ,
 expiredate date  ,
 update_ip varchar(40)   ,
 created_at timestamp(6)  ,
 updated_at timestamp(6)  ,
 persons_id_upd numeric(38,0 )   not null ,
 sno varchar(40)   ,
 contents varchar(4000)   ,
 tblname varchar(30)   ,
 tblid numeric(38,0 )   ,
 srctblname varchar(30)   ,
 srctblid numeric(38,0 )   ,
 qty_src numeric(38,6 )   ,
 cno varchar(40)   ,
 trngantts_id numeric(38,0 )   not null ,
  CONSTRAINT linktbls_id_pk PRIMARY KEY (id));
  drop view if  exists r_linktbls cascade ; 
 create or replace view r_linktbls as select  
  trngantt.itm_name  itm_name ,
  trngantt.itm_code  itm_code ,
  trngantt.unit_name  unit_name ,
  trngantt.unit_code  unit_code ,
  trngantt.loca_code  loca_code ,
  trngantt.loca_name  loca_name ,
linktbl.id id,
  trngantt.prjno_name  prjno_name ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  trngantt.itm_code_pare  itm_code_pare ,
  trngantt.itm_name_pare  itm_name_pare ,
  trngantt.unit_code_pare  unit_code_pare ,
  trngantt.unit_name_pare  unit_name_pare ,
  trngantt.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  trngantt.trngantt_itm_id  trngantt_itm_id ,
  trngantt.trngantt_loca_id  trngantt_loca_id ,
  trngantt.prjno_code  prjno_code ,
  trngantt.trngantt_prjno_id  trngantt_prjno_id ,
  trngantt.classlist_code  classlist_code ,
  trngantt.classlist_name  classlist_name ,
  trngantt.loca_code_pare  loca_code_pare ,
  trngantt.loca_name_pare  loca_name_pare ,
  trngantt.trngantt_consumauto  trngantt_consumauto ,
  trngantt.prjno_code_chil  prjno_code_chil ,
  trngantt.itm_classlist_id  itm_classlist_id ,
  trngantt.trngantt_loca_id_pare  trngantt_loca_id_pare ,
  trngantt.itm_classlist_id_pare  itm_classlist_id_pare ,
  trngantt.classlist_name_pare  classlist_name_pare ,
  trngantt.classlist_code_pare  classlist_code_pare ,
  trngantt.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  trngantt.shelfno_code_fm  shelfno_code_fm ,
  trngantt.shelfno_name_fm  shelfno_name_fm ,
  trngantt.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  trngantt.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  trngantt.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
linktbl.remark  linktbl_remark,
linktbl.expiredate  linktbl_expiredate,
linktbl.update_ip  linktbl_update_ip,
linktbl.created_at  linktbl_created_at,
linktbl.updated_at  linktbl_updated_at,
linktbl.sno  linktbl_sno,
linktbl.contents  linktbl_contents,
linktbl.tblname  linktbl_tblname,
linktbl.tblid  linktbl_tblid,
linktbl.srctblname  linktbl_srctblname,
linktbl.srctblid  linktbl_srctblid,
linktbl.qty_src  linktbl_qty_src,
linktbl.cno  linktbl_cno,
  trngantt.prjno_name_chil  prjno_name_chil ,
linktbl.trngantts_id   linktbl_trngantt_id
 from linktbls   linktbl,
  r_trngantts  trngantt 
  where       linktbl.trngantts_id = trngantt.id     ;
 DROP TABLE IF EXISTS sio.sio_r_linktbls;
 CREATE TABLE sio.sio_r_linktbls (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_linktbls_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,unit_code  varchar (50) 
,loca_code  varchar (50) 
,classlist_code  varchar (50) 
,prjno_code  varchar (50) 
,loca_name  varchar (100) 
,itm_name  varchar (100) 
,unit_name  varchar (100) 
,classlist_name  varchar (100) 
,prjno_name  varchar (100) 
,unit_code_pare  varchar (50) 
,itm_code_pare  varchar (50) 
,loca_code_pare  varchar (50) 
,prjno_code_chil  varchar (50) 
,classlist_code_pare  varchar (50) 
,shelfno_code_fm  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,shelfno_name_fm  varchar (100) 
,unit_name_pare  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,classlist_name_pare  varchar (100) 
,loca_name_pare  varchar (100) 
,itm_name_pare  varchar (100) 
,prjno_name_chil  varchar (100) 
,linktbl_tblname  varchar (30) 
,linktbl_cno  varchar (40) 
,linktbl_contents  varchar (4000) 
,linktbl_trngantt_id  numeric (38,0)
,linktbl_sno  varchar (40) 
,linktbl_remark  varchar (4000) 
,linktbl_expiredate   date 
,linktbl_created_at   timestamp(6) 
,linktbl_update_ip  varchar (40) 
,linktbl_updated_at   timestamp(6) 
,linktbl_srctblid  numeric (38,0)
,trngantt_consumauto  varchar (1) 
,linktbl_qty_src  numeric (38,6)
,linktbl_srctblname  varchar (30) 
,linktbl_tblid  numeric (38,0)
,person_name_upd  varchar (100) 
,person_code_upd  varchar (50) 
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,itm_classlist_id_pare  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,id  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
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
 CREATE INDEX sio_r_linktbls_uk1 
  ON sio.sio_r_linktbls(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_linktbls_seq ;
 create sequence sio.sio_r_linktbls_seq ;
 ALTER TABLE linktbls ADD CONSTRAINT linktbl_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 ALTER TABLE linktbls ADD CONSTRAINT linktbl_trngantts_id FOREIGN KEY (trngantts_id)
																		 REFERENCES trngantts (id);
