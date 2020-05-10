
--- drop view r_instks cascade  
 create or replace view r_instks as select  
instk.qty  instk_qty,
  alloctbl.shelfno_code_fm  shelfno_code_fm ,
  shelfno_in.shelfno_code  shelfno_code_in ,
  alloctbl.trngantt_processseq  trngantt_processseq ,
  alloctbl.shelfno_name_fm  shelfno_name_fm ,
  shelfno_in.shelfno_name  shelfno_name_in ,
  alloctbl.prjno_name  prjno_name ,
  alloctbl.unit_code  unit_code ,
  alloctbl.unit_name  unit_name ,
  alloctbl.trngantt_itm_id  trngantt_itm_id ,
  alloctbl.trngantt_loca_id  trngantt_loca_id ,
  alloctbl.itm_code_pare  itm_code_pare ,
  alloctbl.itm_code  itm_code ,
  alloctbl.itm_name_pare  itm_name_pare ,
  alloctbl.itm_name  itm_name ,
  alloctbl.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  shelfno_in.loca_code_shelfno  loca_code_shelfno_in ,
  alloctbl.loca_code_pare  loca_code_pare ,
  alloctbl.loca_code  loca_code ,
  alloctbl.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  shelfno_in.loca_name_shelfno  loca_name_shelfno_in ,
  alloctbl.loca_name_pare  loca_name_pare ,
  alloctbl.loca_name  loca_name ,
  alloctbl.itm_unit_id_pare  itm_unit_id_pare ,
  alloctbl.itm_unit_id  itm_unit_id ,
  alloctbl.itm_classlist_id_pare  itm_classlist_id_pare ,
  alloctbl.itm_classlist_id  itm_classlist_id ,
  alloctbl.trngantt_duedate  trngantt_duedate ,
instk.id  instk_id,
instk.id id,
instk.starttime  instk_starttime,
instk.qty_stk  instk_qty_stk,
instk.lotno  instk_lotno,
instk.packno  instk_packno,
instk.inoutflg  instk_inoutflg,
instk.expiredate  instk_expiredate,
instk.persons_id_upd   instk_person_id_upd,
instk.created_at  instk_created_at,
instk.updated_at  instk_updated_at,
instk.update_ip  instk_update_ip,
  alloctbl.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  alloctbl.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  alloctbl.trngantt_loca_id_pare  trngantt_loca_id_pare ,
instk.alloctbls_id   instk_alloctbl_id,
instk.shelfnos_id_in   instk_shelfno_id_in,
  alloctbl.classlist_code  classlist_code ,
  alloctbl.alloctbl_trngantt_id  alloctbl_trngantt_id ,
  alloctbl.classlist_name  classlist_name ,
  alloctbl.prjno_code_chil  prjno_code_chil ,
  alloctbl.alloctbl_srctblname  alloctbl_srctblname ,
  alloctbl.alloctbl_srctblid  alloctbl_srctblid ,
  alloctbl.prjno_code  prjno_code ,
  alloctbl.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  shelfno_in.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_in ,
  alloctbl.trngantt_prjno_id  trngantt_prjno_id ,
instk.qty_sch  instk_qty_sch
 from instks   instk,
  r_persons  person_upd ,  r_alloctbls  alloctbl ,  r_shelfnos  shelfno_in 
  where       instk.persons_id_upd = person_upd.id      and instk.alloctbls_id = alloctbl.id      and instk.shelfnos_id_in = shelfno_in.id     ;
 DROP TABLE IF EXISTS sio.sio_r_instks;
 CREATE TABLE sio.sio_r_instks (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_instks_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,prjno_code_chil  varchar (50) 
,classlist_name  varchar (100) 
,classlist_name_pare  varchar (100) 
,shelfno_code_fm  varchar (50) 
,classlist_code  varchar (50) 
,classlist_code_pare  varchar (50) 
,prjno_name  varchar (100) 
,shelfno_code_in  varchar (50) 
,unit_code_pare  varchar (50) 
,unit_code  varchar (50) 
,unit_name_pare  varchar (100) 
,unit_name  varchar (100) 
,shelfno_name_fm  varchar (100) 
,prjno_code  varchar (50) 
,itm_code_pare  varchar (50) 
,itm_code  varchar (50) 
,itm_name_pare  varchar (100) 
,itm_name  varchar (100) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_shelfno_in  varchar (50) 
,loca_code_pare  varchar (50) 
,loca_code  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_shelfno_in  varchar (100) 
,loca_name_pare  varchar (100) 
,loca_name  varchar (100) 
,shelfno_name_in  varchar (100) 
,instk_qty_stk  numeric (22,6)
,instk_packno  varchar (10) 
,instk_inoutflg  varchar (3) 
,instk_expiredate   date 
,instk_qty_sch  numeric (22,6)
,instk_qty  numeric (22,6)
,instk_starttime   timestamp(6) 
,instk_lotno  varchar (50) 
,alloctbl_srctblid  numeric (38,0)
,trngantt_processseq  numeric (38,0)
,trngantt_starttime   timestamp(6) 
,trngantt_duedate   timestamp(6) 
,trngantt_qty_alloc  numeric (22,6)
,trngantt_qty  numeric (18,4)
,alloctbl_qty_linkto_alloctbl  numeric (22,0)
,alloctbl_qty_stk  numeric (22,6)
,alloctbl_srctblname  varchar (30) 
,alloctbl_contents  varchar (4000) 
,alloctbl_qty  numeric (22,6)
,shelfno_contents_in  varchar (4000) 
,instk_remark  varchar (4000) 
,instk_person_id_upd  numeric (38,0)
,instk_created_at   timestamp(6) 
,instk_updated_at   timestamp(6) 
,instk_update_ip  varchar (40) 
,id  numeric (38,0)
,instk_id  numeric (38,0)
,instk_shelfno_id_in  numeric (38,0)
,instk_alloctbl_id  numeric (38,0)
,shelfno_loca_id_shelfno_in  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,alloctbl_trngantt_id  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,itm_unit_id  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
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
 CREATE INDEX sio_r_instks_uk1 
  ON sio.sio_r_instks(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_instks_seq ;
 create sequence sio.sio_r_instks_seq ;
 --- drop view r_lotstkhists cascade  
 create or replace view r_lotstkhists as select  
lotstkhist.shelfnos_id   lotstkhist_shelfno_id,
  shelfno.shelfno_code  shelfno_code ,
  shelfno.shelfno_name  shelfno_name ,
  prjno.prjno_name  prjno_name ,
lotstkhist.starttime  lotstkhist_starttime,
  itm.unit_code  unit_code ,
  itm.unit_name  unit_name ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name ,
lotstkhist.qty_stk  lotstkhist_qty_stk,
lotstkhist.stktaking_proc  lotstkhist_stktaking_proc,
  shelfno.loca_code_shelfno  loca_code_shelfno ,
  shelfno.loca_name_shelfno  loca_name_shelfno ,
  itm.itm_unit_id  itm_unit_id ,
lotstkhist.expiredate  lotstkhist_expiredate,
lotstkhist.remark  lotstkhist_remark,
lotstkhist.persons_id_upd   lotstkhist_person_id_upd,
lotstkhist.update_ip  lotstkhist_update_ip,
lotstkhist.created_at  lotstkhist_created_at,
lotstkhist.updated_at  lotstkhist_updated_at,
lotstkhist.qty  lotstkhist_qty,
lotstkhist.id  lotstkhist_id,
lotstkhist.id id,
  itm.itm_classlist_id  itm_classlist_id ,
lotstkhist.itms_id   lotstkhist_itm_id,
lotstkhist.lotno  lotstkhist_lotno,
lotstkhist.packno  lotstkhist_packno,
lotstkhist.prjnos_id   lotstkhist_prjno_id,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
  prjno.prjno_code_chil  prjno_code_chil ,
lotstkhist.processseq  lotstkhist_processseq,
  prjno.prjno_code  prjno_code ,
  shelfno.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
lotstkhist.qty_sch  lotstkhist_qty_sch
 from lotstkhists   lotstkhist,
  r_shelfnos  shelfno ,  r_persons  person_upd ,  r_itms  itm ,  r_prjnos  prjno 
  where       lotstkhist.shelfnos_id = shelfno.id      and lotstkhist.persons_id_upd = person_upd.id      and lotstkhist.itms_id = itm.id      and lotstkhist.prjnos_id = prjno.id     ;
 DROP TABLE IF EXISTS sio.sio_r_lotstkhists;
 CREATE TABLE sio.sio_r_lotstkhists (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_lotstkhists_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,itm_name  varchar (100) 
,itm_code  varchar (50) 
,shelfno_name  varchar (100) 
,prjno_name  varchar (100) 
,shelfno_code  varchar (50) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,prjno_code  varchar (50) 
,prjno_code_chil  varchar (50) 
,classlist_name  varchar (100) 
,classlist_code  varchar (50) 
,loca_name_shelfno  varchar (100) 
,loca_code_shelfno  varchar (50) 
,lotstkhist_qty_sch  numeric (22,6)
,lotstkhist_starttime   timestamp(6) 
,lotstkhist_qty_stk  numeric (22,6)
,lotstkhist_stktaking_proc  varchar (1) 
,lotstkhist_expiredate   date 
,lotstkhist_qty  numeric (22,6)
,lotstkhist_lotno  varchar (50) 
,lotstkhist_packno  varchar (10) 
,lotstkhist_processseq  numeric (38,0)
,itm_model  varchar (50) 
,itm_weight  numeric (22,0)
,itm_std  varchar (50) 
,itm_datascale  numeric (22,0)
,shelfno_contents  varchar (4000) 
,unit_contents  varchar (4000) 
,itm_design  varchar (50) 
,itm_deth  numeric (22,0)
,itm_wide  numeric (22,0)
,itm_material  varchar (50) 
,itm_length  numeric (22,0)
,lotstkhist_remark  varchar (4000) 
,lotstkhist_shelfno_id  numeric (38,0)
,lotstkhist_update_ip  varchar (40) 
,lotstkhist_created_at   timestamp(6) 
,lotstkhist_updated_at   timestamp(6) 
,lotstkhist_person_id_upd  numeric (38,0)
,lotstkhist_id  numeric (38,0)
,id  numeric (38,0)
,lotstkhist_itm_id  numeric (38,0)
,lotstkhist_prjno_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
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
 CREATE INDEX sio_r_lotstkhists_uk1 
  ON sio.sio_r_lotstkhists(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_lotstkhists_seq ;
 create sequence sio.sio_r_lotstkhists_seq ;
 --- drop view r_outstks cascade  
 create or replace view r_outstks as select  
outstk.qty  outstk_qty,
  shelfno_out.shelfno_code  shelfno_code_out ,
  alloctbl.shelfno_code_fm  shelfno_code_fm ,
  alloctbl.trngantt_processseq  trngantt_processseq ,
  shelfno_out.shelfno_name  shelfno_name_out ,
  alloctbl.shelfno_name_fm  shelfno_name_fm ,
  alloctbl.prjno_name  prjno_name ,
  alloctbl.unit_code_pare  unit_code_pare ,
  alloctbl.unit_code  unit_code ,
  alloctbl.unit_name_pare  unit_name_pare ,
  alloctbl.unit_name  unit_name ,
  alloctbl.trngantt_itm_id  trngantt_itm_id ,
  alloctbl.trngantt_loca_id  trngantt_loca_id ,
  alloctbl.itm_code_pare  itm_code_pare ,
  alloctbl.itm_code  itm_code ,
  alloctbl.itm_name_pare  itm_name_pare ,
  alloctbl.itm_name  itm_name ,
  shelfno_out.loca_code_shelfno  loca_code_shelfno_out ,
  alloctbl.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  alloctbl.loca_code_pare  loca_code_pare ,
  alloctbl.loca_code  loca_code ,
  shelfno_out.loca_name_shelfno  loca_name_shelfno_out ,
  alloctbl.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  alloctbl.loca_name_pare  loca_name_pare ,
  alloctbl.loca_name  loca_name ,
  alloctbl.itm_unit_id_pare  itm_unit_id_pare ,
  alloctbl.itm_unit_id  itm_unit_id ,
  alloctbl.itm_classlist_id_pare  itm_classlist_id_pare ,
  alloctbl.itm_classlist_id  itm_classlist_id ,
  alloctbl.trngantt_duedate  trngantt_duedate ,
  alloctbl.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  alloctbl.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  alloctbl.trngantt_loca_id_pare  trngantt_loca_id_pare ,
outstk.id  outstk_id,
outstk.id id,
outstk.starttime  outstk_starttime,
outstk.qty_stk  outstk_qty_stk,
outstk.lotno  outstk_lotno,
outstk.packno  outstk_packno,
outstk.inoutflg  outstk_inoutflg,
outstk.expiredate  outstk_expiredate,
outstk.remark  outstk_remark,
outstk.persons_id_upd   outstk_person_id_upd,
outstk.created_at  outstk_created_at,
outstk.updated_at  outstk_updated_at,
outstk.update_ip  outstk_update_ip,
outstk.alloctbls_id   outstk_alloctbl_id,
outstk.shelfnos_id_out   outstk_shelfno_id_out,
  alloctbl.classlist_code  classlist_code ,
  alloctbl.alloctbl_trngantt_id  alloctbl_trngantt_id ,
  alloctbl.classlist_name  classlist_name ,
  alloctbl.prjno_code_chil  prjno_code_chil ,
  alloctbl.alloctbl_srctblname  alloctbl_srctblname ,
  alloctbl.alloctbl_srctblid  alloctbl_srctblid ,
  alloctbl.prjno_code  prjno_code ,
  shelfno_out.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_out ,
  alloctbl.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  alloctbl.trngantt_prjno_id  trngantt_prjno_id ,
outstk.qty_sch  outstk_qty_sch
 from outstks   outstk,
  r_persons  person_upd ,  r_alloctbls  alloctbl ,  r_shelfnos  shelfno_out 
  where       outstk.persons_id_upd = person_upd.id      and outstk.alloctbls_id = alloctbl.id      and outstk.shelfnos_id_out = shelfno_out.id     ;
 DROP TABLE IF EXISTS sio.sio_r_outstks;
 CREATE TABLE sio.sio_r_outstks (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_outstks_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,prjno_code_chil  varchar (50) 
,classlist_name  varchar (100) 
,classlist_name_pare  varchar (100) 
,shelfno_code_out  varchar (50) 
,classlist_code  varchar (50) 
,classlist_code_pare  varchar (50) 
,prjno_name  varchar (100) 
,shelfno_code_fm  varchar (50) 
,unit_code_pare  varchar (50) 
,unit_code  varchar (50) 
,unit_name_pare  varchar (100) 
,unit_name  varchar (100) 
,shelfno_name_out  varchar (100) 
,prjno_code  varchar (50) 
,itm_code_pare  varchar (50) 
,itm_code  varchar (50) 
,itm_name_pare  varchar (100) 
,itm_name  varchar (100) 
,loca_code_shelfno_out  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_pare  varchar (50) 
,loca_code  varchar (50) 
,loca_name_shelfno_out  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_pare  varchar (100) 
,loca_name  varchar (100) 
,shelfno_name_fm  varchar (100) 
,outstk_inoutflg  varchar (3) 
,outstk_starttime   timestamp(6) 
,outstk_qty_stk  numeric (22,6)
,outstk_lotno  varchar (50) 
,outstk_qty_sch  numeric (22,6)
,outstk_qty  numeric (22,6)
,outstk_expiredate   date 
,outstk_packno  varchar (10) 
,alloctbl_srctblid  numeric (38,0)
,trngantt_processseq  numeric (38,0)
,trngantt_starttime   timestamp(6) 
,trngantt_duedate   timestamp(6) 
,trngantt_qty_alloc  numeric (22,6)
,trngantt_qty  numeric (18,4)
,alloctbl_qty_linkto_alloctbl  numeric (22,0)
,alloctbl_qty_stk  numeric (22,6)
,alloctbl_srctblname  varchar (30) 
,alloctbl_contents  varchar (4000) 
,alloctbl_qty  numeric (22,6)
,shelfno_contents_out  varchar (4000) 
,outstk_remark  varchar (4000) 
,outstk_shelfno_id_out  numeric (22,0)
,outstk_alloctbl_id  numeric (38,0)
,id  numeric (38,0)
,outstk_id  numeric (38,0)
,outstk_person_id_upd  numeric (38,0)
,outstk_created_at   timestamp(6) 
,outstk_updated_at   timestamp(6) 
,outstk_update_ip  varchar (40) 
,itm_classlist_id_pare  numeric (38,0)
,itm_unit_id  numeric (22,0)
,shelfno_loca_id_shelfno_out  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,trngantt_itm_id  numeric (38,0)
,alloctbl_trngantt_id  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
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
 CREATE INDEX sio_r_outstks_uk1 
  ON sio.sio_r_outstks(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_outstks_seq ;
 create sequence sio.sio_r_outstks_seq ;
