
  drop view if  exists r_alloctbls cascade ; 
 create or replace view r_alloctbls as select  
alloctbl.qty_stk  alloctbl_qty_stk,
alloctbl.qty  alloctbl_qty,
alloctbl.qty_sch  alloctbl_qty_sch,
alloctbl.lotstkhists_id   alloctbl_lotstkhist_id,
alloctbl.id id,
alloctbl.id  alloctbl_id,
alloctbl.trngantts_id   alloctbl_trngantt_id,
alloctbl.srctblname  alloctbl_srctblname,
alloctbl.srctblid  alloctbl_srctblid,
alloctbl.remark  alloctbl_remark,
alloctbl.expiredate  alloctbl_expiredate,
alloctbl.persons_id_upd   alloctbl_person_id_upd,
alloctbl.update_ip  alloctbl_update_ip,
alloctbl.created_at  alloctbl_created_at,
alloctbl.updated_at  alloctbl_updated_at,
alloctbl.contents  alloctbl_contents,
alloctbl.qty_linkto_alloctbl  alloctbl_qty_linkto_alloctbl
 from alloctbls   alloctbl,
  r_lotstkhists  lotstkhist ,  r_trngantts  trngantt ,  r_persons  person_upd 
  where       alloctbl.lotstkhists_id = lotstkhist.id      and alloctbl.trngantts_id = trngantt.id      and alloctbl.persons_id_upd = person_upd.id     ;
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
,alloctbl_qty_linkto_alloctbl  numeric (22,0)
,alloctbl_qty  numeric (22,6)
,alloctbl_qty_sch  numeric (22,6)
,alloctbl_srctblname  varchar (30) 
,alloctbl_srctblid  numeric (38,0)
,alloctbl_expiredate   date 
,alloctbl_qty_stk  numeric (22,6)
,alloctbl_remark  varchar (4000) 
,alloctbl_contents  varchar (4000) 
,alloctbl_person_id_upd  numeric (38,0)
,alloctbl_update_ip  varchar (40) 
,alloctbl_lotstkhist_id  numeric (22,0)
,id  numeric (38,0)
,alloctbl_id  numeric (38,0)
,alloctbl_created_at   timestamp(6) 
,alloctbl_trngantt_id  numeric (38,0)
,alloctbl_updated_at   timestamp(6) 
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
