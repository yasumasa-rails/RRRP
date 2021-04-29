
  drop view if  exists r_lotstkhists cascade ; 
 create or replace view r_lotstkhists as select  
  itm.itm_name  itm_name ,
  itm.itm_code  itm_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_unit_id  itm_unit_id ,
lotstkhist.id id,
  prjno.prjno_name  prjno_name ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
lotstkhist.expiredate  lotstkhist_expiredate,
lotstkhist.updated_at  lotstkhist_updated_at,
lotstkhist.processseq  lotstkhist_processseq,
lotstkhist.qty  lotstkhist_qty,
lotstkhist.itms_id   lotstkhist_itm_id,
lotstkhist.remark  lotstkhist_remark,
lotstkhist.created_at  lotstkhist_created_at,
lotstkhist.update_ip  lotstkhist_update_ip,
lotstkhist.id  lotstkhist_id,
lotstkhist.persons_id_upd   lotstkhist_person_id_upd,
lotstkhist.lotno  lotstkhist_lotno,
lotstkhist.packno  lotstkhist_packno,
  shelfno.shelfno_code  shelfno_code ,
  shelfno.shelfno_name  shelfno_name ,
  shelfno.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  shelfno.loca_code_shelfno  loca_code_shelfno ,
  shelfno.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
lotstkhist.prjnos_id   lotstkhist_prjno_id,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
lotstkhist.starttime  lotstkhist_starttime,
  prjno.prjno_code_chil  prjno_code_chil ,
lotstkhist.shelfnos_id   lotstkhist_shelfno_id,
lotstkhist.qty_stk  lotstkhist_qty_stk,
  itm.itm_classlist_id  itm_classlist_id ,
lotstkhist.stktaking_proc  lotstkhist_stktaking_proc,
lotstkhist.qty_sch  lotstkhist_qty_sch,
  prjno.prjno_name_chil  prjno_name_chil 
 from lotstkhists   lotstkhist,
  r_itms  itm ,  r_persons  person_upd ,  r_prjnos  prjno ,  r_shelfnos  shelfno 
  where       lotstkhist.itms_id = itm.id      and lotstkhist.persons_id_upd = person_upd.id      and lotstkhist.prjnos_id = prjno.id      and lotstkhist.shelfnos_id = shelfno.id     ;
 DROP TABLE IF EXISTS sio.sio_r_lotstkhists;
 CREATE TABLE sio.sio_r_lotstkhists (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_lotstkhists_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,lotstkhist_starttime   timestamp(6) 
,itm_code  varchar (50) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,itm_name  varchar (100) 
,lotstkhist_processseq  numeric (38,0)
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,lotstkhist_lotno  varchar (50) 
,lotstkhist_packno  varchar (10) 
,lotstkhist_qty_stk  numeric (22,6)
,lotstkhist_qty  numeric (22,6)
,lotstkhist_qty_sch  numeric (22,6)
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,classlist_name  varchar (100) 
,classlist_code  varchar (50) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,lotstkhist_expiredate   date 
,lotstkhist_stktaking_proc  varchar (1) 
,prjno_name_chil  varchar (100) 
,lotstkhist_remark  varchar (4000) 
,itm_unit_id  numeric (22,0)
,lotstkhist_itm_id  numeric (38,0)
,lotstkhist_created_at   timestamp(6) 
,lotstkhist_update_ip  varchar (40) 
,lotstkhist_id  numeric (38,0)
,lotstkhist_person_id_upd  numeric (38,0)
,id  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,lotstkhist_updated_at   timestamp(6) 
,lotstkhist_prjno_id  numeric (38,0)
,lotstkhist_shelfno_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
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
 CREATE INDEX sio_r_lotstkhists_uk1 
  ON sio.sio_r_lotstkhists(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_lotstkhists_seq ;
 create sequence sio.sio_r_lotstkhists_seq ;
  drop view if  exists r_trngantts cascade ; 
 create or replace view r_trngantts as select  
  itm.itm_name  itm_name ,
  itm.itm_code  itm_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  loca.loca_code  loca_code ,
  loca.loca_name  loca_name ,
  itm.itm_unit_id  itm_unit_id ,
trngantt.id id,
  prjno.prjno_name  prjno_name ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  itm_pare.itm_code  itm_code_pare ,
  itm_pare.itm_name  itm_name_pare ,
  itm_pare.itm_unit_id  itm_unit_id_pare ,
  itm_pare.unit_code  unit_code_pare ,
  itm_pare.unit_name  unit_name_pare ,
trngantt.processseq_pare  trngantt_processseq_pare,
trngantt.qty_alloc  trngantt_qty_alloc,
trngantt.orgtblname  trngantt_orgtblname,
trngantt.orgtblid  trngantt_orgtblid,
trngantt.id  trngantt_id,
trngantt.persons_id_upd   trngantt_person_id_upd,
trngantt.itms_id_pare   trngantt_itm_id_pare,
trngantt.parenum  trngantt_parenum,
trngantt.chilnum  trngantt_chilnum,
trngantt.expiredate  trngantt_expiredate,
trngantt.updated_at  trngantt_updated_at,
trngantt.qty  trngantt_qty,
trngantt.remark  trngantt_remark,
trngantt.created_at  trngantt_created_at,
trngantt.update_ip  trngantt_update_ip,
trngantt.duedate  trngantt_duedate,
trngantt.tblid  trngantt_tblid,
trngantt.tblname  trngantt_tblname,
trngantt.key  trngantt_key,
trngantt.mlevel  trngantt_mlevel,
trngantt.qty_stk  trngantt_qty_stk,
trngantt.processseq  trngantt_processseq,
trngantt.itms_id   trngantt_itm_id,
trngantt.locas_id   trngantt_loca_id,
  prjno.prjno_code  prjno_code ,
trngantt.prjnos_id   trngantt_prjno_id,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
  loca_pare.loca_code  loca_code_pare ,
  loca_pare.loca_name  loca_name_pare ,
trngantt.consumtype  trngantt_consumtype,
trngantt.consumauto  trngantt_consumauto,
trngantt.starttime  trngantt_starttime,
  prjno.prjno_code_chil  prjno_code_chil ,
trngantt.shuffle_flg  trngantt_shuffle_flg,
trngantt.consumunitqty  trngantt_consumunitqty,
trngantt.paretblname  trngantt_paretblname,
trngantt.paretblid  trngantt_paretblid,
trngantt.consumminqty  trngantt_consumminqty,
trngantt.consumchgoverqty  trngantt_consumchgoverqty,
  itm.itm_classlist_id  itm_classlist_id ,
trngantt.locas_id_pare   trngantt_loca_id_pare,
  itm_pare.itm_classlist_id  itm_classlist_id_pare ,
  itm_pare.classlist_name  classlist_name_pare ,
  itm_pare.classlist_code  classlist_code_pare ,
trngantt.qty_stk_pare  trngantt_qty_stk_pare,
trngantt.qty_pare  trngantt_qty_pare,
trngantt.shelfnos_id_fm   trngantt_shelfno_id_fm,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
trngantt.qty_pare_alloc  trngantt_qty_pare_alloc,
trngantt.duedate_org  trngantt_duedate_org,
trngantt.qty_bal  trngantt_qty_bal,
trngantt.qty_pare_bal  trngantt_qty_pare_bal,
trngantt.qty_sch  trngantt_qty_sch,
  prjno.prjno_name_chil  prjno_name_chil 
 from trngantts   trngantt,
  r_persons  person_upd ,  r_itms  itm_pare ,  r_itms  itm ,  r_locas  loca ,  r_prjnos  prjno ,  r_locas  loca_pare ,  r_shelfnos  shelfno_fm 
  where       trngantt.persons_id_upd = person_upd.id      and trngantt.itms_id_pare = itm_pare.id      and trngantt.itms_id = itm.id      and trngantt.locas_id = loca.id      and trngantt.prjnos_id = prjno.id      and trngantt.locas_id_pare = loca_pare.id      and trngantt.shelfnos_id_fm = shelfno_fm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_trngantts;
 CREATE TABLE sio.sio_r_trngantts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_trngantts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,trngantt_orgtblname  varchar (30) 
,trngantt_orgtblid  numeric (22,0)
,trngantt_paretblname  varchar (30) 
,trngantt_paretblid  numeric (38,0)
,trngantt_tblname  varchar (30) 
,trngantt_tblid  numeric (38,0)
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,trngantt_processseq  numeric (38,0)
,trngantt_duedate   timestamp(6) 
,trngantt_qty  numeric (18,4)
,trngantt_qty_stk  numeric (22,0)
,trngantt_qty_alloc  numeric (22,6)
,trngantt_qty_pare  numeric (22,6)
,trngantt_qty_stk_pare  numeric (22,6)
,trngantt_qty_pare_alloc  numeric (22,6)
,unit_code  varchar (50) 
,classlist_code  varchar (50) 
,loca_code  varchar (50) 
,trngantt_consumtype  varchar (3) 
,unit_name  varchar (100) 
,loca_name  varchar (100) 
,trngantt_processseq_pare  numeric (38,0)
,classlist_name  varchar (100) 
,trngantt_starttime   timestamp(6) 
,trngantt_consumunitqty  numeric (22,6)
,trngantt_consumminqty  numeric (22,6)
,trngantt_consumchgoverqty  numeric (22,6)
,trngantt_qty_pare_bal  numeric (22,6)
,trngantt_key  varchar (250) 
,trngantt_mlevel  numeric (3,0)
,loca_code_shelfno_fm  varchar (50) 
,classlist_code_pare  varchar (50) 
,loca_code_pare  varchar (50) 
,unit_code_pare  varchar (50) 
,itm_code_pare  varchar (50) 
,shelfno_code_fm  varchar (50) 
,prjno_name_chil  varchar (100) 
,classlist_name_pare  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,shelfno_name_fm  varchar (100) 
,itm_name_pare  varchar (100) 
,unit_name_pare  varchar (100) 
,loca_name_pare  varchar (100) 
,trngantt_duedate_org   timestamp(6) 
,trngantt_qty_sch  numeric (22,6)
,trngantt_qty_bal  numeric (22,6)
,trngantt_parenum  numeric (22,0)
,trngantt_chilnum  numeric (22,0)
,trngantt_shuffle_flg  varchar (1) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,trngantt_consumauto  varchar (1) 
,trngantt_expiredate   date 
,trngantt_remark  varchar (4000) 
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_update_ip  varchar (40) 
,trngantt_person_id_upd  numeric (38,0)
,trngantt_id  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,trngantt_itm_id  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,trngantt_updated_at   timestamp(6) 
,trngantt_itm_id_pare  numeric (38,0)
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,id  numeric (38,0)
,prjno_code_chil  varchar (50) 
,trngantt_created_at  numeric (22,0)
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
 CREATE INDEX sio_r_trngantts_uk1 
  ON sio.sio_r_trngantts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_trngantts_seq ;
 create sequence sio.sio_r_trngantts_seq ;
  drop view if  exists r_alloctbls cascade ; 
 create or replace view r_alloctbls as select  
  trngantt.itm_name  itm_name ,
  trngantt.itm_code  itm_code ,
  trngantt.unit_code  unit_code ,
  trngantt.loca_name  loca_name ,
alloctbl.id id,
  trngantt.prjno_name  prjno_name ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  trngantt.itm_code_pare  itm_code_pare ,
  trngantt.itm_name_pare  itm_name_pare ,
  trngantt.itm_unit_id_pare  itm_unit_id_pare ,
  trngantt.unit_code_pare  unit_code_pare ,
  trngantt.unit_name_pare  unit_name_pare ,
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
  trngantt.prjno_code  prjno_code ,
  trngantt.trngantt_prjno_id  trngantt_prjno_id ,
  trngantt.loca_code_pare  loca_code_pare ,
  trngantt.loca_name_pare  loca_name_pare ,
  trngantt.trngantt_starttime  trngantt_starttime ,
  trngantt.prjno_code_chil  prjno_code_chil ,
alloctbl.qty_stk  alloctbl_qty_stk,
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
  lotstkhist_alloctbl.prjno_name  prjno_name_alloctbl ,
  lotstkhist_alloctbl.lotstkhist_itm_id  lotstkhist_itm_id_alloctbl ,
  lotstkhist_alloctbl.shelfno_code  shelfno_code_alloctbl ,
  lotstkhist_alloctbl.shelfno_name  shelfno_name_alloctbl ,
  lotstkhist_alloctbl.loca_code_shelfno  loca_code_shelfno_alloctbl ,
  lotstkhist_alloctbl.loca_name_shelfno  loca_name_shelfno_alloctbl ,
  lotstkhist_alloctbl.prjno_code  prjno_code_alloctbl ,
  lotstkhist_alloctbl.lotstkhist_prjno_id  lotstkhist_prjno_id_alloctbl ,
  lotstkhist_alloctbl.classlist_code  classlist_code_alloctbl ,
  lotstkhist_alloctbl.classlist_name  classlist_name_alloctbl ,
  lotstkhist_alloctbl.prjno_code_chil  prjno_code_chil_alloctbl ,
  lotstkhist_alloctbl.lotstkhist_shelfno_id  lotstkhist_shelfno_id_alloctbl ,
  trngantt.prjno_name_chil  prjno_name_chil ,
  lotstkhist_alloctbl.prjno_name_chil  prjno_name_chil_alloctbl 
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
,loca_name_shelfno_fm  varchar (100) 
,itm_code  varchar (50) 
,unit_code  varchar (50) 
,loca_name  varchar (100) 
,itm_name  varchar (100) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,loca_name_pare  varchar (100) 
,itm_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,loca_code_pare  varchar (50) 
,unit_code_pare  varchar (50) 
,unit_name_pare  varchar (100) 
,classlist_name_pare  varchar (100) 
,prjno_code  varchar (50) 
,classlist_code_pare  varchar (50) 
,shelfno_code_fm  varchar (50) 
,shelfno_name_fm  varchar (100) 
,loca_code_shelfno_fm  varchar (50) 
,alloctbl_qty_stk  numeric (22,6)
,alloctbl_qty_linkto_alloctbl  numeric (22,0)
,alloctbl_expiredate   date 
,alloctbl_srctblname  varchar (30) 
,alloctbl_srctblid  numeric (38,0)
,alloctbl_qty  numeric (22,6)
,trngantt_processseq  numeric (38,0)
,trngantt_duedate   timestamp(6) 
,trngantt_qty  numeric (18,4)
,classlist_code_alloctbl  varchar (50) 
,trngantt_starttime   timestamp(6) 
,prjno_code_chil_alloctbl  varchar (50) 
,loca_code_shelfno_alloctbl  varchar (50) 
,trngantt_qty_alloc  numeric (22,6)
,unit_code_alloctbl  varchar (50) 
,itm_code_alloctbl  varchar (50) 
,trngantt_processseq_pare  numeric (38,0)
,prjno_code_alloctbl  varchar (50) 
,shelfno_code_alloctbl  varchar (50) 
,prjno_name_chil_alloctbl  varchar (100) 
,itm_name_alloctbl  varchar (100) 
,unit_name_alloctbl  varchar (100) 
,prjno_name_alloctbl  varchar (100) 
,shelfno_name_alloctbl  varchar (100) 
,loca_name_shelfno_alloctbl  varchar (100) 
,classlist_name_alloctbl  varchar (100) 
,prjno_name_chil  varchar (100) 
,alloctbl_qty_sch  numeric (22,6)
,alloctbl_lotstkhist_id_alloctbl  numeric (22,0)
,alloctbl_contents  varchar (4000) 
,alloctbl_remark  varchar (4000) 
,person_name_upd  varchar (100) 
,person_code_upd  varchar (50) 
,lotstkhist_itm_id_alloctbl  numeric (38,0)
,alloctbl_updated_at   timestamp(6) 
,alloctbl_update_ip  varchar (40) 
,alloctbl_trngantt_id  numeric (38,0)
,lotstkhist_prjno_id_alloctbl  numeric (38,0)
,alloctbl_id  numeric (38,0)
,id  numeric (38,0)
,lotstkhist_shelfno_id_alloctbl  numeric (38,0)
,alloctbl_person_id_upd  numeric (38,0)
,alloctbl_created_at   timestamp(6) 
,trngantt_shelfno_id_fm  numeric (22,0)
,itm_unit_id_pare  numeric (22,0)
,trngantt_loca_id_pare  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
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
  drop view if  exists r_outstks cascade ; 
 create or replace view r_outstks as select  
  alloctbl.itm_name  itm_name ,
  alloctbl.itm_code  itm_code ,
  alloctbl.unit_code  unit_code ,
outstk.id id,
  alloctbl.prjno_name  prjno_name ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  alloctbl.itm_code_pare  itm_code_pare ,
  alloctbl.itm_name_pare  itm_name_pare ,
  alloctbl.itm_unit_id_pare  itm_unit_id_pare ,
  alloctbl.unit_code_pare  unit_code_pare ,
  alloctbl.unit_name_pare  unit_name_pare ,
  alloctbl.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  alloctbl.trngantt_duedate  trngantt_duedate ,
  alloctbl.trngantt_processseq  trngantt_processseq ,
  alloctbl.trngantt_itm_id  trngantt_itm_id ,
  alloctbl.trngantt_loca_id  trngantt_loca_id ,
  alloctbl.alloctbl_srctblname  alloctbl_srctblname ,
  alloctbl.alloctbl_srctblid  alloctbl_srctblid ,
  alloctbl.prjno_code  prjno_code ,
  alloctbl.trngantt_prjno_id  trngantt_prjno_id ,
  alloctbl.loca_code_pare  loca_code_pare ,
  alloctbl.loca_name_pare  loca_name_pare ,
  alloctbl.prjno_code_chil  prjno_code_chil ,
  alloctbl.trngantt_loca_id_pare  trngantt_loca_id_pare ,
  alloctbl.itm_classlist_id_pare  itm_classlist_id_pare ,
outstk.remark  outstk_remark,
outstk.created_at  outstk_created_at,
outstk.update_ip  outstk_update_ip,
outstk.expiredate  outstk_expiredate,
outstk.updated_at  outstk_updated_at,
outstk.id  outstk_id,
outstk.persons_id_upd   outstk_person_id_upd,
outstk.starttime  outstk_starttime,
outstk.inoutflg  outstk_inoutflg,
outstk.lotno  outstk_lotno,
outstk.packno  outstk_packno,
  alloctbl.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  alloctbl.shelfno_code_fm  shelfno_code_fm ,
  alloctbl.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  alloctbl.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
outstk.shelfnos_id_out   outstk_shelfno_id_out,
  shelfno_out.shelfno_code  shelfno_code_out ,
  shelfno_out.shelfno_name  shelfno_name_out ,
  shelfno_out.loca_code_shelfno  loca_code_shelfno_out ,
  shelfno_out.loca_name_shelfno  loca_name_shelfno_out ,
  shelfno_out.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_out ,
  alloctbl.alloctbl_trngantt_id  alloctbl_trngantt_id ,
outstk.alloctbls_id   outstk_alloctbl_id,
  alloctbl.itm_name_alloctbl  itm_name_alloctbl ,
  alloctbl.itm_code_alloctbl  itm_code_alloctbl ,
  alloctbl.unit_name_alloctbl  unit_name_alloctbl ,
  alloctbl.unit_code_alloctbl  unit_code_alloctbl ,
  alloctbl.prjno_name_alloctbl  prjno_name_alloctbl ,
  alloctbl.lotstkhist_itm_id_alloctbl  lotstkhist_itm_id_alloctbl ,
  alloctbl.shelfno_code_alloctbl  shelfno_code_alloctbl ,
  alloctbl.shelfno_name_alloctbl  shelfno_name_alloctbl ,
  alloctbl.loca_code_shelfno_alloctbl  loca_code_shelfno_alloctbl ,
  alloctbl.loca_name_shelfno_alloctbl  loca_name_shelfno_alloctbl ,
  alloctbl.prjno_code_alloctbl  prjno_code_alloctbl ,
  alloctbl.lotstkhist_prjno_id_alloctbl  lotstkhist_prjno_id_alloctbl ,
  alloctbl.classlist_code_alloctbl  classlist_code_alloctbl ,
  alloctbl.classlist_name_alloctbl  classlist_name_alloctbl ,
  alloctbl.prjno_code_chil_alloctbl  prjno_code_chil_alloctbl ,
  alloctbl.lotstkhist_shelfno_id_alloctbl  lotstkhist_shelfno_id_alloctbl ,
  alloctbl.prjno_name_chil  prjno_name_chil ,
  alloctbl.prjno_name_chil_alloctbl  prjno_name_chil_alloctbl 
 from outstks   outstk,
  r_persons  person_upd ,  r_shelfnos  shelfno_out ,  r_alloctbls  alloctbl 
  where       outstk.persons_id_upd = person_upd.id      and outstk.shelfnos_id_out = shelfno_out.id      and outstk.alloctbls_id = alloctbl.id     ;
 DROP TABLE IF EXISTS sio.sio_r_outstks;
 CREATE TABLE sio.sio_r_outstks (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_outstks_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,trngantt_duedate   timestamp(6) 
,loca_code_shelfno_out  varchar (50) 
,loca_name_shelfno_out  varchar (100) 
,shelfno_code_out  varchar (50) 
,shelfno_name_out  varchar (100) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,trngantt_processseq  numeric (38,0)
,outstk_lotno  varchar (50) 
,outstk_packno  varchar (10) 
,outstk_inoutflg  varchar (20) 
,alloctbl_srctblname  varchar (30) 
,alloctbl_srctblid  numeric (38,0)
,shelfno_code_fm  varchar (50) 
,unit_code_pare  varchar (50) 
,unit_code  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_pare  varchar (50) 
,loca_name_pare  varchar (100) 
,prjno_code_chil  varchar (50) 
,itm_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,unit_name_pare  varchar (100) 
,outstk_starttime   timestamp(6) 
,outstk_expiredate   date 
,prjno_code_chil_alloctbl  varchar (50) 
,itm_code_alloctbl  varchar (50) 
,loca_code_shelfno_alloctbl  varchar (50) 
,prjno_code_alloctbl  varchar (50) 
,unit_code_alloctbl  varchar (50) 
,shelfno_code_alloctbl  varchar (50) 
,classlist_code_alloctbl  varchar (50) 
,prjno_name_chil_alloctbl  varchar (100) 
,itm_name_alloctbl  varchar (100) 
,unit_name_alloctbl  varchar (100) 
,prjno_name_alloctbl  varchar (100) 
,shelfno_name_alloctbl  varchar (100) 
,loca_name_shelfno_alloctbl  varchar (100) 
,classlist_name_alloctbl  varchar (100) 
,prjno_name_chil  varchar (100) 
,outstk_remark  varchar (4000) 
,person_name_upd  varchar (100) 
,person_code_upd  varchar (50) 
,outstk_shelfno_id_out  numeric (22,0)
,outstk_alloctbl_id  numeric (38,0)
,lotstkhist_prjno_id_alloctbl  numeric (38,0)
,id  numeric (38,0)
,lotstkhist_itm_id_alloctbl  numeric (38,0)
,lotstkhist_shelfno_id_alloctbl  numeric (38,0)
,outstk_person_id_upd  numeric (38,0)
,outstk_id  numeric (38,0)
,outstk_updated_at   timestamp(6) 
,outstk_update_ip  varchar (40) 
,outstk_created_at   timestamp(6) 
,itm_classlist_id_pare  numeric (38,0)
,shelfno_loca_id_shelfno_out  numeric (38,0)
,alloctbl_trngantt_id  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,trngantt_itm_id  numeric (38,0)
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
 CREATE INDEX sio_r_outstks_uk1 
  ON sio.sio_r_outstks(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_outstks_seq ;
 create sequence sio.sio_r_outstks_seq ;
  drop view if  exists r_instks cascade ; 
 create or replace view r_instks as select  
  alloctbl.itm_name  itm_name ,
  alloctbl.itm_code  itm_code ,
  alloctbl.unit_code  unit_code ,
  alloctbl.loca_name  loca_name ,
instk.id id,
  alloctbl.prjno_name  prjno_name ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  alloctbl.itm_code_pare  itm_code_pare ,
  alloctbl.itm_name_pare  itm_name_pare ,
  alloctbl.itm_unit_id_pare  itm_unit_id_pare ,
  alloctbl.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  alloctbl.trngantt_duedate  trngantt_duedate ,
  alloctbl.trngantt_processseq  trngantt_processseq ,
  alloctbl.trngantt_itm_id  trngantt_itm_id ,
  alloctbl.trngantt_loca_id  trngantt_loca_id ,
  alloctbl.alloctbl_srctblname  alloctbl_srctblname ,
  alloctbl.alloctbl_srctblid  alloctbl_srctblid ,
  alloctbl.prjno_code  prjno_code ,
  alloctbl.trngantt_prjno_id  trngantt_prjno_id ,
  alloctbl.loca_code_pare  loca_code_pare ,
  alloctbl.loca_name_pare  loca_name_pare ,
  alloctbl.prjno_code_chil  prjno_code_chil ,
  shelfno_in.shelfno_code  shelfno_code_in ,
  shelfno_in.shelfno_name  shelfno_name_in ,
  shelfno_in.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_in ,
  shelfno_in.loca_code_shelfno  loca_code_shelfno_in ,
  shelfno_in.loca_name_shelfno  loca_name_shelfno_in ,
  alloctbl.trngantt_loca_id_pare  trngantt_loca_id_pare ,
  alloctbl.itm_classlist_id_pare  itm_classlist_id_pare ,
instk.remark  instk_remark,
instk.created_at  instk_created_at,
instk.update_ip  instk_update_ip,
instk.expiredate  instk_expiredate,
instk.updated_at  instk_updated_at,
instk.id  instk_id,
instk.persons_id_upd   instk_person_id_upd,
instk.starttime  instk_starttime,
instk.inoutflg  instk_inoutflg,
instk.lotno  instk_lotno,
instk.packno  instk_packno,
  alloctbl.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  alloctbl.shelfno_code_fm  shelfno_code_fm ,
  alloctbl.shelfno_name_fm  shelfno_name_fm ,
  alloctbl.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  alloctbl.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  alloctbl.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
instk.shelfnos_id_in   instk_shelfno_id_in,
  alloctbl.alloctbl_trngantt_id  alloctbl_trngantt_id ,
instk.alloctbls_id   instk_alloctbl_id,
  alloctbl.itm_name_alloctbl  itm_name_alloctbl ,
  alloctbl.itm_code_alloctbl  itm_code_alloctbl ,
  alloctbl.unit_name_alloctbl  unit_name_alloctbl ,
  alloctbl.unit_code_alloctbl  unit_code_alloctbl ,
  alloctbl.prjno_name_alloctbl  prjno_name_alloctbl ,
  alloctbl.lotstkhist_itm_id_alloctbl  lotstkhist_itm_id_alloctbl ,
  alloctbl.shelfno_code_alloctbl  shelfno_code_alloctbl ,
  alloctbl.shelfno_name_alloctbl  shelfno_name_alloctbl ,
  alloctbl.loca_code_shelfno_alloctbl  loca_code_shelfno_alloctbl ,
  alloctbl.loca_name_shelfno_alloctbl  loca_name_shelfno_alloctbl ,
  alloctbl.prjno_code_alloctbl  prjno_code_alloctbl ,
  alloctbl.lotstkhist_prjno_id_alloctbl  lotstkhist_prjno_id_alloctbl ,
  alloctbl.classlist_code_alloctbl  classlist_code_alloctbl ,
  alloctbl.classlist_name_alloctbl  classlist_name_alloctbl ,
  alloctbl.prjno_code_chil_alloctbl  prjno_code_chil_alloctbl ,
  alloctbl.lotstkhist_shelfno_id_alloctbl  lotstkhist_shelfno_id_alloctbl ,
  alloctbl.prjno_name_chil  prjno_name_chil ,
  alloctbl.prjno_name_chil_alloctbl  prjno_name_chil_alloctbl 
 from instks   instk,
  r_persons  person_upd ,  r_shelfnos  shelfno_in ,  r_alloctbls  alloctbl 
  where       instk.persons_id_upd = person_upd.id      and instk.shelfnos_id_in = shelfno_in.id      and instk.alloctbls_id = alloctbl.id     ;
 DROP TABLE IF EXISTS sio.sio_r_instks;
 CREATE TABLE sio.sio_r_instks (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_instks_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,instk_starttime   timestamp(6) 
,loca_code_shelfno_in  varchar (50) 
,loca_name_shelfno_in  varchar (100) 
,shelfno_code_in  varchar (50) 
,shelfno_name_in  varchar (100) 
,instk_lotno  varchar (50) 
,instk_packno  varchar (10) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,trngantt_processseq  numeric (38,0)
,loca_code_shelfno_fm  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,shelfno_code_fm  varchar (50) 
,shelfno_name_fm  varchar (100) 
,loca_name  varchar (100) 
,itm_code_pare  varchar (50) 
,unit_code  varchar (50) 
,prjno_name  varchar (100) 
,itm_name_pare  varchar (100) 
,prjno_code  varchar (50) 
,loca_code_pare  varchar (50) 
,loca_name_pare  varchar (100) 
,prjno_code_chil  varchar (50) 
,instk_expiredate   date 
,instk_inoutflg  varchar (20) 
,shelfno_code_alloctbl  varchar (50) 
,itm_code_alloctbl  varchar (50) 
,unit_code_alloctbl  varchar (50) 
,alloctbl_srctblid  numeric (38,0)
,alloctbl_srctblname  varchar (30) 
,prjno_code_chil_alloctbl  varchar (50) 
,classlist_code_alloctbl  varchar (50) 
,trngantt_duedate   timestamp(6) 
,prjno_code_alloctbl  varchar (50) 
,loca_code_shelfno_alloctbl  varchar (50) 
,prjno_name_chil  varchar (100) 
,loca_name_shelfno_alloctbl  varchar (100) 
,classlist_name_alloctbl  varchar (100) 
,prjno_name_chil_alloctbl  varchar (100) 
,prjno_name_alloctbl  varchar (100) 
,itm_name_alloctbl  varchar (100) 
,shelfno_name_alloctbl  varchar (100) 
,unit_name_alloctbl  varchar (100) 
,instk_remark  varchar (4000) 
,person_name_upd  varchar (100) 
,person_code_upd  varchar (50) 
,id  numeric (38,0)
,instk_created_at   timestamp(6) 
,instk_update_ip  varchar (40) 
,instk_updated_at   timestamp(6) 
,instk_id  numeric (38,0)
,instk_person_id_upd  numeric (38,0)
,instk_shelfno_id_in  numeric (38,0)
,instk_alloctbl_id  numeric (38,0)
,lotstkhist_itm_id_alloctbl  numeric (38,0)
,lotstkhist_prjno_id_alloctbl  numeric (38,0)
,lotstkhist_shelfno_id_alloctbl  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,alloctbl_trngantt_id  numeric (38,0)
,shelfno_loca_id_shelfno_in  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
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
 CREATE INDEX sio_r_instks_uk1 
  ON sio.sio_r_instks(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_instks_seq ;
 create sequence sio.sio_r_instks_seq ;
  drop view if  exists r_outamts cascade ; 
 create or replace view r_outamts as select  
  alloctbl.itm_name  itm_name ,
  alloctbl.itm_code  itm_code ,
  alloctbl.unit_code  unit_code ,
  alloctbl.loca_name  loca_name ,
outamt.id id,
  alloctbl.prjno_name  prjno_name ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  alloctbl.itm_code_pare  itm_code_pare ,
  alloctbl.itm_name_pare  itm_name_pare ,
  alloctbl.itm_unit_id_pare  itm_unit_id_pare ,
  alloctbl.unit_code_pare  unit_code_pare ,
  alloctbl.unit_name_pare  unit_name_pare ,
  alloctbl.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  alloctbl.trngantt_duedate  trngantt_duedate ,
  alloctbl.trngantt_processseq  trngantt_processseq ,
  alloctbl.trngantt_itm_id  trngantt_itm_id ,
  alloctbl.trngantt_loca_id  trngantt_loca_id ,
  alloctbl.prjno_code  prjno_code ,
  alloctbl.trngantt_prjno_id  trngantt_prjno_id ,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
  alloctbl.loca_code_pare  loca_code_pare ,
  alloctbl.loca_name_pare  loca_name_pare ,
  alloctbl.prjno_code_chil  prjno_code_chil ,
  alloctbl.trngantt_loca_id_pare  trngantt_loca_id_pare ,
  alloctbl.itm_classlist_id_pare  itm_classlist_id_pare ,
outamt.remark  outamt_remark,
outamt.created_at  outamt_created_at,
outamt.update_ip  outamt_update_ip,
outamt.amt  outamt_amt,
outamt.expiredate  outamt_expiredate,
outamt.updated_at  outamt_updated_at,
outamt.id  outamt_id,
outamt.persons_id_upd   outamt_person_id_upd,
outamt.starttime  outamt_starttime,
outamt.inoutflg  outamt_inoutflg,
outamt.crrs_id   outamt_crr_id,
  loca_out.loca_code  loca_code_out ,
  loca_out.loca_name  loca_name_out ,
outamt.locas_id_out   outamt_loca_id_out,
  alloctbl.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  alloctbl.shelfno_code_fm  shelfno_code_fm ,
  alloctbl.shelfno_name_fm  shelfno_name_fm ,
  alloctbl.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  alloctbl.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  alloctbl.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  alloctbl.alloctbl_trngantt_id  alloctbl_trngantt_id ,
outamt.alloctbls_id   outamt_alloctbl_id,
  alloctbl.itm_name_alloctbl  itm_name_alloctbl ,
  alloctbl.itm_code_alloctbl  itm_code_alloctbl ,
  alloctbl.unit_name_alloctbl  unit_name_alloctbl ,
  alloctbl.unit_code_alloctbl  unit_code_alloctbl ,
  alloctbl.prjno_name_alloctbl  prjno_name_alloctbl ,
  alloctbl.lotstkhist_itm_id_alloctbl  lotstkhist_itm_id_alloctbl ,
  alloctbl.shelfno_code_alloctbl  shelfno_code_alloctbl ,
  alloctbl.shelfno_name_alloctbl  shelfno_name_alloctbl ,
  alloctbl.loca_code_shelfno_alloctbl  loca_code_shelfno_alloctbl ,
  alloctbl.loca_name_shelfno_alloctbl  loca_name_shelfno_alloctbl ,
  alloctbl.prjno_code_alloctbl  prjno_code_alloctbl ,
  alloctbl.lotstkhist_prjno_id_alloctbl  lotstkhist_prjno_id_alloctbl ,
  alloctbl.classlist_code_alloctbl  classlist_code_alloctbl ,
  alloctbl.classlist_name_alloctbl  classlist_name_alloctbl ,
  alloctbl.prjno_code_chil_alloctbl  prjno_code_chil_alloctbl ,
  alloctbl.lotstkhist_shelfno_id_alloctbl  lotstkhist_shelfno_id_alloctbl ,
  alloctbl.prjno_name_chil  prjno_name_chil ,
  alloctbl.prjno_name_chil_alloctbl  prjno_name_chil_alloctbl 
 from outamts   outamt,
  r_persons  person_upd ,  r_crrs  crr ,  r_locas  loca_out ,  r_alloctbls  alloctbl 
  where       outamt.persons_id_upd = person_upd.id      and outamt.crrs_id = crr.id      and outamt.locas_id_out = loca_out.id      and outamt.alloctbls_id = alloctbl.id     ;
 DROP TABLE IF EXISTS sio.sio_r_outamts;
 CREATE TABLE sio.sio_r_outamts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_outamts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,crr_name  varchar (100) 
,itm_code  varchar (50) 
,unit_code  varchar (50) 
,loca_name  varchar (100) 
,itm_name  varchar (100) 
,prjno_name  varchar (100) 
,loca_code_out  varchar (50) 
,loca_name_out  varchar (100) 
,itm_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,shelfno_code_fm  varchar (50) 
,unit_code_pare  varchar (50) 
,unit_name_pare  varchar (100) 
,shelfno_name_fm  varchar (100) 
,loca_code_shelfno_fm  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,prjno_code_chil  varchar (50) 
,loca_name_pare  varchar (100) 
,prjno_code  varchar (50) 
,loca_code_pare  varchar (50) 
,crr_code  varchar (50) 
,outamt_starttime   timestamp(6) 
,outamt_amt  numeric (18,4)
,outamt_expiredate   date 
,outamt_inoutflg  varchar (20) 
,trngantt_processseq  numeric (38,0)
,trngantt_duedate   timestamp(6) 
,loca_code_shelfno_alloctbl  varchar (50) 
,prjno_code_alloctbl  varchar (50) 
,classlist_code_alloctbl  varchar (50) 
,prjno_code_chil_alloctbl  varchar (50) 
,itm_code_alloctbl  varchar (50) 
,unit_code_alloctbl  varchar (50) 
,shelfno_code_alloctbl  varchar (50) 
,prjno_name_chil_alloctbl  varchar (100) 
,itm_name_alloctbl  varchar (100) 
,unit_name_alloctbl  varchar (100) 
,prjno_name_alloctbl  varchar (100) 
,shelfno_name_alloctbl  varchar (100) 
,loca_name_shelfno_alloctbl  varchar (100) 
,classlist_name_alloctbl  varchar (100) 
,prjno_name_chil  varchar (100) 
,outamt_remark  varchar (4000) 
,outamt_created_at   timestamp(6) 
,person_name_upd  varchar (100) 
,person_code_upd  varchar (50) 
,lotstkhist_itm_id_alloctbl  numeric (38,0)
,outamt_alloctbl_id  numeric (38,0)
,lotstkhist_prjno_id_alloctbl  numeric (38,0)
,id  numeric (38,0)
,lotstkhist_shelfno_id_alloctbl  numeric (38,0)
,outamt_person_id_upd  numeric (38,0)
,outamt_id  numeric (38,0)
,outamt_crr_id  numeric (22,0)
,outamt_updated_at   timestamp(6) 
,outamt_update_ip  varchar (40) 
,outamt_loca_id_out  numeric (22,0)
,alloctbl_trngantt_id  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,trngantt_prjno_id  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
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
 CREATE INDEX sio_r_outamts_uk1 
  ON sio.sio_r_outamts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_outamts_seq ;
 create sequence sio.sio_r_outamts_seq ;
  drop view if  exists r_inamts cascade ; 
 create or replace view r_inamts as select  
  alloctbl.itm_name  itm_name ,
  alloctbl.itm_code  itm_code ,
  alloctbl.unit_code  unit_code ,
  alloctbl.loca_name  loca_name ,
inamt.id id,
  alloctbl.prjno_name  prjno_name ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  alloctbl.itm_code_pare  itm_code_pare ,
  alloctbl.itm_name_pare  itm_name_pare ,
  alloctbl.itm_unit_id_pare  itm_unit_id_pare ,
  alloctbl.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  alloctbl.trngantt_duedate  trngantt_duedate ,
  alloctbl.trngantt_processseq  trngantt_processseq ,
  alloctbl.trngantt_itm_id  trngantt_itm_id ,
  alloctbl.trngantt_loca_id  trngantt_loca_id ,
  alloctbl.prjno_code  prjno_code ,
  alloctbl.trngantt_prjno_id  trngantt_prjno_id ,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
  alloctbl.loca_code_pare  loca_code_pare ,
  alloctbl.loca_name_pare  loca_name_pare ,
  alloctbl.prjno_code_chil  prjno_code_chil ,
  alloctbl.trngantt_loca_id_pare  trngantt_loca_id_pare ,
  alloctbl.itm_classlist_id_pare  itm_classlist_id_pare ,
inamt.remark  inamt_remark,
inamt.created_at  inamt_created_at,
inamt.update_ip  inamt_update_ip,
inamt.amt  inamt_amt,
inamt.expiredate  inamt_expiredate,
inamt.updated_at  inamt_updated_at,
inamt.id  inamt_id,
inamt.persons_id_upd   inamt_person_id_upd,
inamt.starttime  inamt_starttime,
inamt.inoutflg  inamt_inoutflg,
inamt.crrs_id   inamt_crr_id,
  loca_in.loca_code  loca_code_in ,
  loca_in.loca_name  loca_name_in ,
inamt.locas_id_in   inamt_loca_id_in,
  alloctbl.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  alloctbl.shelfno_code_fm  shelfno_code_fm ,
  alloctbl.shelfno_name_fm  shelfno_name_fm ,
  alloctbl.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  alloctbl.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  alloctbl.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  alloctbl.alloctbl_trngantt_id  alloctbl_trngantt_id ,
inamt.alloctbls_id   inamt_alloctbl_id,
  alloctbl.itm_name_alloctbl  itm_name_alloctbl ,
  alloctbl.itm_code_alloctbl  itm_code_alloctbl ,
  alloctbl.unit_name_alloctbl  unit_name_alloctbl ,
  alloctbl.unit_code_alloctbl  unit_code_alloctbl ,
  alloctbl.prjno_name_alloctbl  prjno_name_alloctbl ,
  alloctbl.lotstkhist_itm_id_alloctbl  lotstkhist_itm_id_alloctbl ,
  alloctbl.shelfno_code_alloctbl  shelfno_code_alloctbl ,
  alloctbl.shelfno_name_alloctbl  shelfno_name_alloctbl ,
  alloctbl.loca_code_shelfno_alloctbl  loca_code_shelfno_alloctbl ,
  alloctbl.loca_name_shelfno_alloctbl  loca_name_shelfno_alloctbl ,
  alloctbl.prjno_code_alloctbl  prjno_code_alloctbl ,
  alloctbl.lotstkhist_prjno_id_alloctbl  lotstkhist_prjno_id_alloctbl ,
  alloctbl.classlist_code_alloctbl  classlist_code_alloctbl ,
  alloctbl.classlist_name_alloctbl  classlist_name_alloctbl ,
  alloctbl.prjno_code_chil_alloctbl  prjno_code_chil_alloctbl ,
  alloctbl.lotstkhist_shelfno_id_alloctbl  lotstkhist_shelfno_id_alloctbl ,
  alloctbl.prjno_name_chil  prjno_name_chil ,
  alloctbl.prjno_name_chil_alloctbl  prjno_name_chil_alloctbl 
 from inamts   inamt,
  r_persons  person_upd ,  r_crrs  crr ,  r_locas  loca_in ,  r_alloctbls  alloctbl 
  where       inamt.persons_id_upd = person_upd.id      and inamt.crrs_id = crr.id      and inamt.locas_id_in = loca_in.id      and inamt.alloctbls_id = alloctbl.id     ;
 DROP TABLE IF EXISTS sio.sio_r_inamts;
 CREATE TABLE sio.sio_r_inamts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_inamts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,crr_name  varchar (100) 
,itm_code  varchar (50) 
,unit_code  varchar (50) 
,loca_name  varchar (100) 
,itm_name  varchar (100) 
,prjno_name  varchar (100) 
,loca_code_in  varchar (50) 
,loca_name_in  varchar (100) 
,itm_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,shelfno_code_fm  varchar (50) 
,shelfno_name_fm  varchar (100) 
,loca_code_shelfno_fm  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,prjno_code_chil  varchar (50) 
,loca_name_pare  varchar (100) 
,prjno_code  varchar (50) 
,loca_code_pare  varchar (50) 
,crr_code  varchar (50) 
,inamt_inoutflg  varchar (20) 
,inamt_amt  numeric (18,4)
,inamt_expiredate   date 
,inamt_starttime   timestamp(6) 
,trngantt_processseq  numeric (38,0)
,trngantt_duedate   timestamp(6) 
,loca_code_shelfno_alloctbl  varchar (50) 
,prjno_code_alloctbl  varchar (50) 
,classlist_code_alloctbl  varchar (50) 
,prjno_code_chil_alloctbl  varchar (50) 
,itm_code_alloctbl  varchar (50) 
,unit_code_alloctbl  varchar (50) 
,shelfno_code_alloctbl  varchar (50) 
,prjno_name_chil_alloctbl  varchar (100) 
,itm_name_alloctbl  varchar (100) 
,unit_name_alloctbl  varchar (100) 
,prjno_name_alloctbl  varchar (100) 
,shelfno_name_alloctbl  varchar (100) 
,loca_name_shelfno_alloctbl  varchar (100) 
,classlist_name_alloctbl  varchar (100) 
,prjno_name_chil  varchar (100) 
,inamt_remark  varchar (4000) 
,inamt_created_at   timestamp(6) 
,person_name_upd  varchar (100) 
,person_code_upd  varchar (50) 
,lotstkhist_itm_id_alloctbl  numeric (38,0)
,inamt_alloctbl_id  numeric (38,0)
,lotstkhist_prjno_id_alloctbl  numeric (38,0)
,id  numeric (38,0)
,lotstkhist_shelfno_id_alloctbl  numeric (38,0)
,inamt_person_id_upd  numeric (38,0)
,inamt_id  numeric (38,0)
,inamt_crr_id  numeric (22,0)
,inamt_updated_at   timestamp(6) 
,inamt_update_ip  varchar (40) 
,inamt_loca_id_in  numeric (22,0)
,alloctbl_trngantt_id  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,trngantt_prjno_id  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
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
 CREATE INDEX sio_r_inamts_uk1 
  ON sio.sio_r_inamts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_inamts_seq ;
 create sequence sio.sio_r_inamts_seq ;
