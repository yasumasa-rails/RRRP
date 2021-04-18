
  drop view if  exists r_alloctbls cascade ; 
 create or replace view r_alloctbls as select  
  trngantt.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  trngantt.unit_code  unit_code ,
  opeitm.itm_unit_id  itm_unit_id ,
alloctbl.id id,
  prjno.prjno_name  prjno_name ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  trngantt.trngantt_processseq_pare  trngantt_processseq_pare ,
  trngantt.trngantt_qty_alloc  trngantt_qty_alloc ,
  trngantt.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  trngantt.trngantt_qty  trngantt_qty ,
  trngantt.trngantt_duedate  trngantt_duedate ,
  trngantt.trngantt_processseq  trngantt_processseq ,
  trngantt.trngantt_itm_id  trngantt_itm_id ,
  trngantt.trngantt_loca_id  trngantt_loca_id ,
alloctbl.id  alloctbl_id,
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
  lotstkhist.lotstkhist_itm_id  lotstkhist_itm_id ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
  trngantt.trngantt_prjno_id  trngantt_prjno_id ,
  lotstkhist.lotstkhist_prjno_id  lotstkhist_prjno_id ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  trngantt.trngantt_starttime  trngantt_starttime ,
  prjno.prjno_code_chil  prjno_code_chil ,
  lotstkhist.lotstkhist_shelfno_id  lotstkhist_shelfno_id ,
alloctbl.qty_stk  alloctbl_qty_stk,
  opeitm.itm_classlist_id  itm_classlist_id ,
  trngantt.trngantt_loca_id_pare  trngantt_loca_id_pare ,
  trngantt.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
alloctbl.trngantts_id   alloctbl_trngantt_id,
alloctbl.qty_linkto_alloctbl  alloctbl_qty_linkto_alloctbl,
alloctbl.qty_sch  alloctbl_qty_sch,
alloctbl.lotstkhists_id   alloctbl_lotstkhist_id
 from alloctbls   alloctbl,
  r_persons  person_upd ,  r_trngantts  trngantt ,  r_lotstkhists  lotstkhist 
  where       alloctbl.persons_id_upd = person_upd.id      and alloctbl.trngantts_id = trngantt.id      and alloctbl.lotstkhists_id = lotstkhist.id     ;
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
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,prjno_code_chil  varchar (50) 
,classlist_name  varchar (100) 
,prjno_name  varchar (100) 
,classlist_code  varchar (50) 
,prjno_code  varchar (50) 
,loca_name_shelfno  varchar (100) 
,loca_code_shelfno  varchar (50) 
,shelfno_name  varchar (100) 
,itm_name  varchar (100) 
,shelfno_code  varchar (50) 
,itm_code  varchar (50) 
,alloctbl_expiredate   date 
,alloctbl_srctblname  varchar (30) 
,alloctbl_srctblid  numeric (38,0)
,alloctbl_qty  numeric (22,6)
,alloctbl_qty_stk  numeric (22,6)
,alloctbl_qty_linkto_alloctbl  numeric (22,0)
,trngantt_processseq  numeric (38,0)
,trngantt_qty_alloc  numeric (22,6)
,trngantt_processseq_pare  numeric (38,0)
,trngantt_duedate   timestamp(6) 
,trngantt_qty  numeric (18,4)
,trngantt_starttime   timestamp(6) 
,alloctbl_qty_sch  numeric (22,6)
,alloctbl_contents  varchar (4000) 
,alloctbl_remark  varchar (4000) 
,alloctbl_created_at   timestamp(6) 
,alloctbl_updated_at   timestamp(6) 
,alloctbl_person_id_upd  numeric (38,0)
,alloctbl_trngantt_id  numeric (38,0)
,alloctbl_lotstkhist_id  numeric (22,0)
,lotstkhist_itm_id  numeric (38,0)
,lotstkhist_prjno_id  numeric (38,0)
,id  numeric (38,0)
,lotstkhist_shelfno_id  numeric (38,0)
,alloctbl_id  numeric (38,0)
,alloctbl_update_ip  varchar (40) 
,trngantt_shelfno_id_fm  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,itm_unit_id  numeric (22,0)
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
 ALTER TABLE alloctbls ADD CONSTRAINT alloctbl_lotstkhists_id FOREIGN KEY (lotstkhists_id)
																		 REFERENCES lotstkhists (id);
