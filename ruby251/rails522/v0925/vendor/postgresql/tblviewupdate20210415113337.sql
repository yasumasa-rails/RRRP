
  drop view if  exists r_alloctbls cascade ; 
 create or replace view r_alloctbls as select  
  trngantt.itm_name  itm_name ,
  trngantt.itm_code  itm_code ,
  trngantt.unit_name  unit_name ,
  trngantt.unit_code  unit_code ,
  trngantt.loca_code  loca_code ,
  trngantt.loca_name  loca_name ,
  trngantt.itm_unit_id  itm_unit_id ,
alloctbl.id id,
  trngantt.prjno_name  prjno_name ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  trngantt.itm_code_pare  itm_code_pare ,
  trngantt.itm_name_pare  itm_name_pare ,
  trngantt.itm_unit_id_pare  itm_unit_id_pare ,
  trngantt.unit_code_pare  unit_code_pare ,
  trngantt.unit_name_pare  unit_name_pare ,
  trngantt.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  trngantt.trngantt_itm_id  trngantt_itm_id ,
  trngantt.trngantt_loca_id  trngantt_loca_id ,
alloctbl.remark  alloctbl_remark,
alloctbl.expiredate  alloctbl_expiredate,
alloctbl.update_ip  alloctbl_update_ip,
alloctbl.created_at  alloctbl_created_at,
alloctbl.updated_at  alloctbl_updated_at,
alloctbl.persons_id_upd   alloctbl_person_id_upd,
alloctbl.srctblname  alloctbl_srctblname,
alloctbl.srctblid  alloctbl_srctblid,
alloctbl.qty  alloctbl_qty,
alloctbl.contents  alloctbl_contents,
  trngantt.prjno_code  prjno_code ,
  trngantt.trngantt_prjno_id  trngantt_prjno_id ,
  trngantt.classlist_code  classlist_code ,
  trngantt.classlist_name  classlist_name ,
  trngantt.loca_code_pare  loca_code_pare ,
  trngantt.loca_name_pare  loca_name_pare ,
  trngantt.prjno_code_chil  prjno_code_chil ,
alloctbl.qty_stk  alloctbl_qty_stk,
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
alloctbl.trngantts_id   alloctbl_trngantt_id,
alloctbl.qty_linkto_alloctbl  alloctbl_qty_linkto_alloctbl,
alloctbl.qty_sch  alloctbl_qty_sch,
alloctbl.lotstkhists_id_alloctbl   alloctbl_lotstkhist_id_alloctbl,
  lotstkhist_alloctbl.itm_name  itm_name_alloctbl ,
  lotstkhist_alloctbl.itm_code  itm_code_alloctbl ,
  lotstkhist_alloctbl.unit_name  unit_name_alloctbl ,
  lotstkhist_alloctbl.unit_code  unit_code_alloctbl ,
  lotstkhist_alloctbl.itm_unit_id  itm_unit_id_alloctbl ,
  lotstkhist_alloctbl.prjno_name  prjno_name_alloctbl ,
  lotstkhist_alloctbl.lotstkhist_itm_id  lotstkhist_itm_id_alloctbl ,
  lotstkhist_alloctbl.shelfno_code  shelfno_code_alloctbl ,
  lotstkhist_alloctbl.shelfno_name  shelfno_name_alloctbl ,
  lotstkhist_alloctbl.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_alloctbl ,
  lotstkhist_alloctbl.loca_code_shelfno  loca_code_shelfno_alloctbl ,
  lotstkhist_alloctbl.loca_name_shelfno  loca_name_shelfno_alloctbl ,
  lotstkhist_alloctbl.prjno_code  prjno_code_alloctbl ,
  lotstkhist_alloctbl.lotstkhist_prjno_id  lotstkhist_prjno_id_alloctbl ,
  lotstkhist_alloctbl.classlist_code  classlist_code_alloctbl ,
  lotstkhist_alloctbl.classlist_name  classlist_name_alloctbl ,
  lotstkhist_alloctbl.prjno_code_chil  prjno_code_chil_alloctbl ,
  lotstkhist_alloctbl.lotstkhist_shelfno_id  lotstkhist_shelfno_id_alloctbl ,
  lotstkhist_alloctbl.itm_classlist_id  itm_classlist_id_alloctbl 
 from alloctbls   alloctbl,
  r_persons  person_upd ,  r_trngantts  trngantt ,  r_lotstkhists  lotstkhist_alloctbl 
  where       alloctbl.persons_id_upd = person_upd.id      and alloctbl.trngantts_id = trngantt.id      and alloctbl.lotstkhists_id_alloctbl = lotstkhist_alloctbl.id     ;
 DROP TABLE IF EXISTS sio.sio_r_alloctbls;
 CREATE TABLE sio.sio_r_alloctbls (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_alloctbls_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,itm_code_alloctbl  varchar (50) 
,itm_code_pare  varchar (50) 
,loca_code  varchar (50) 
,loca_code_pare  varchar (50) 
,person_code_upd  varchar (50) 
,itm_name_pare  varchar (100) 
,person_name_upd  varchar (100) 
,itm_name_alloctbl  varchar (100) 
,loca_code_shelfno_alloctbl  varchar (50) 
,loca_name_pare  varchar (100) 
,loca_name  varchar (100) 
,loca_name_shelfno_alloctbl  varchar (100) 
,shelfno_code_alloctbl  varchar (50) 
,shelfno_name_alloctbl  varchar (100) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,prjno_code_alloctbl  varchar (50) 
,prjno_name_alloctbl  varchar (100) 
,prjno_code_chil_alloctbl  varchar (50) 
,shelfno_code_fm  varchar (50) 
,shelfno_name_fm  varchar (100) 
,loca_code_shelfno_fm  varchar (50) 
,classlist_code_alloctbl  varchar (50) 
,unit_code_alloctbl  varchar (50) 
,unit_name_alloctbl  varchar (100) 
,classlist_name_pare  varchar (100) 
,classlist_code_pare  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,classlist_name_alloctbl  varchar (100) 
,unit_code  varchar (50) 
,unit_code_pare  varchar (50) 
,unit_name  varchar (100) 
,unit_name_pare  varchar (100) 
,alloctbl_qty  numeric (22,6)
,alloctbl_srctblname  varchar (30) 
,alloctbl_srctblid  numeric (38,0)
,alloctbl_qty_stk  numeric (22,6)
,alloctbl_qty_linkto_alloctbl  numeric (22,0)
,alloctbl_qty_sch  numeric (22,6)
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,alloctbl_expiredate   date 
,alloctbl_remark  varchar (4000) 
,alloctbl_contents  varchar (4000) 
,lotstkhist_shelfno_id_alloctbl  numeric (38,0)
,alloctbl_lotstkhist_id_alloctbl  numeric (22,0)
,alloctbl_updated_at   timestamp(6) 
,alloctbl_created_at   timestamp(6) 
,alloctbl_update_ip  varchar (40) 
,itm_classlist_id  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,trngantt_prjno_id  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,alloctbl_trngantt_id  numeric (38,0)
,lotstkhist_itm_id_alloctbl  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,lotstkhist_prjno_id_alloctbl  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,itm_classlist_id_alloctbl  numeric (38,0)
,itm_unit_id_alloctbl  numeric (22,0)
,shelfno_loca_id_shelfno_alloctbl  numeric (38,0)
,itm_unit_id  numeric (22,0)
,prjno_code_chil  varchar (50) 
,alloctbl_person_id_upd  numeric (22,0)
,itm_unit_id_pare  numeric (22,0)
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
 CREATE INDEX sio_r_alloctbls_uk1 
  ON sio.sio_r_alloctbls(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_alloctbls_seq ;
 create sequence sio.sio_r_alloctbls_seq ;
 ALTER TABLE alloctbls ADD CONSTRAINT alloctbl_lotstkhists_id_alloctbl FOREIGN KEY (lotstkhists_id_alloctbl)
																		 REFERENCES lotstkhists (id);
