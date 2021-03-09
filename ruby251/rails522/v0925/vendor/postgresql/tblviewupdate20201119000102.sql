
 --- drop view r_alloctbls cascade  
 create or replace view r_alloctbls as select  
  trngantt.trngantt_processseq  trngantt_processseq ,
  trngantt.trngantt_qty  trngantt_qty ,
  trngantt.unit_code  unit_code ,
  trngantt.trngantt_starttime  trngantt_starttime ,
  trngantt.trngantt_qty_alloc  trngantt_qty_alloc ,
alloctbl.persons_id_upd   alloctbl_person_id_upd,
  trngantt.trngantt_duedate  trngantt_duedate ,
alloctbl.id id,
alloctbl.id  alloctbl_id,
alloctbl.trngantts_id   alloctbl_trngantt_id,
alloctbl.qty_alloc  alloctbl_qty_alloc,
alloctbl.srctblname  alloctbl_srctblname,
alloctbl.srctblid  alloctbl_srctblid,
alloctbl.remark  alloctbl_remark,
alloctbl.expiredate  alloctbl_expiredate,
alloctbl.update_ip  alloctbl_update_ip,
alloctbl.created_at  alloctbl_created_at,
alloctbl.contents  alloctbl_contents,
alloctbl.qty_stk  alloctbl_qty_stk,
alloctbl.qty_linkto_alloctbl  alloctbl_qty_linkto_alloctbl,
  trngantt.itm_code  itm_code ,
  trngantt.trngantt_itm_id  trngantt_itm_id ,
alloctbl.qty  alloctbl_qty,
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
  trngantt.loca_code  loca_code ,
  trngantt.loca_name  loca_name ,
  trngantt.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  trngantt.shelfno_name_fm  shelfno_name_fm ,
  trngantt.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  trngantt.shelfno_code_fm  shelfno_code_fm ,
  trngantt.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  trngantt.itm_classlist_id_pare  itm_classlist_id_pare ,
  trngantt.itm_unit_id_pare  itm_unit_id_pare ,
  trngantt.classlist_name_pare  classlist_name_pare ,
  trngantt.classlist_code_pare  classlist_code_pare ,
  trngantt.unit_name_pare  unit_name_pare ,
  trngantt.unit_code_pare  unit_code_pare ,
  trngantt.itm_code_pare  itm_code_pare ,
  trngantt.itm_name_pare  itm_name_pare ,
  trngantt.loca_code_pare  loca_code_pare ,
  trngantt.loca_name_pare  loca_name_pare ,
  trngantt.prjno_name  prjno_name ,
  trngantt.prjno_code  prjno_code ,
  trngantt.prjno_code_chil  prjno_code_chil ,
  trngantt.itm_name  itm_name ,
alloctbl.updated_at  alloctbl_updated_at,
  trngantt.trngantt_processseq_pare  trngantt_processseq_pare 
 from alloctbls   alloctbl,
  r_persons  person_upd ,  r_trngantts  trngantt 
  where       alloctbl.persons_id_upd = person_upd.id      and alloctbl.trngantts_id = trngantt.id     ;
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
,itm_code  varchar (50) 
,prjno_code_chil  varchar (50) 
,unit_code_pare  varchar (50) 
,loca_name_pare  varchar (100) 
,unit_name_pare  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,shelfno_code_fm  varchar (50) 
,shelfno_name_fm  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,classlist_name  varchar (100) 
,classlist_code  varchar (50) 
,unit_name  varchar (100) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,classlist_name_pare  varchar (100) 
,loca_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,itm_code_pare  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,classlist_code_pare  varchar (50) 
,itm_name  varchar (100) 
,unit_code  varchar (50) 
,alloctbl_expiredate   date 
,alloctbl_srctblname  varchar (30) 
,alloctbl_srctblid  numeric (38,0)
,alloctbl_qty_alloc  numeric (22,6)
,alloctbl_qty_stk  numeric (22,6)
,alloctbl_qty_linkto_alloctbl  numeric (22,0)
,alloctbl_qty  numeric (22,6)
,trngantt_processseq_pare  numeric (38,0)
,trngantt_qty  numeric (18,4)
,trngantt_qty_pare_alloc  numeric (22,6)
,trngantt_starttime   timestamp(6) 
,trngantt_qty_alloc  numeric (22,6)
,trngantt_duedate   timestamp(6) 
,trngantt_qty_linkto_alloctbl  numeric (22,0)
,trngantt_tblname  varchar (30) 
,trngantt_consumchgoverqty  numeric (22,6)
,trngantt_consumminqty  numeric (22,6)
,trngantt_consumunitqty  numeric (22,6)
,trngantt_qty_bal  numeric (22,6)
,trngantt_qty_pare_bal  numeric (22,6)
,trngantt_duedate_org   timestamp(6) 
,trngantt_consumtype  varchar (3) 
,loca_tel_pare  varchar (20) 
,trngantt_tblid  numeric (38,0)
,trngantt_qty_pare  numeric (22,6)
,trngantt_paretblname  varchar (30) 
,trngantt_paretblid  numeric (38,0)
,trngantt_qty_stk_pare  numeric (22,6)
,trngantt_orgtblid  numeric (22,0)
,trngantt_mlevel  numeric (3,0)
,trngantt_consumauto  varchar (1) 
,trngantt_shuffle_flg  varchar (1) 
,trngantt_key  varchar (250) 
,trngantt_parenum  numeric (22,0)
,trngantt_chilnum  numeric (22,0)
,trngantt_qty_stk  numeric (22,0)
,trngantt_orgtblname  varchar (30) 
,trngantt_processseq  numeric (38,0)
,alloctbl_remark  varchar (4000) 
,alloctbl_contents  varchar (4000) 
,alloctbl_id  numeric (38,0)
,id  numeric (38,0)
,alloctbl_updated_at   timestamp(6) 
,alloctbl_trngantt_id  numeric (38,0)
,alloctbl_created_at   timestamp(6) 
,alloctbl_update_ip  varchar (40) 
,alloctbl_person_id_upd  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,trngantt_loca_id  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
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
 CREATE INDEX sio_r_alloctbls_uk1 
  ON sio.sio_r_alloctbls(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_alloctbls_seq ;
 create sequence sio.sio_r_alloctbls_seq ;