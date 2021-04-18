
  drop view if  exists r_outstks cascade ; 
 create or replace view r_outstks as select  
  alloctbl.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  alloctbl.unit_name_prdpurshp  unit_name_prdpurshp ,
  alloctbl.unit_code_prdpurshp  unit_code_prdpurshp ,
  alloctbl.itm_name  itm_name ,
  alloctbl.itm_code  itm_code ,
  alloctbl.unit_name  unit_name ,
  alloctbl.unit_code  unit_code ,
  alloctbl.loca_code  loca_code ,
  alloctbl.itm_unit_id  itm_unit_id ,
  alloctbl.opeitm_itm_id  opeitm_itm_id ,
  alloctbl.opeitm_loca_id  opeitm_loca_id ,
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
  alloctbl.unit_code_case  unit_code_case ,
  alloctbl.unit_name_case  unit_name_case ,
  alloctbl.opeitm_unit_id_case  opeitm_unit_id_case ,
  alloctbl.shelfno_code  shelfno_code ,
  alloctbl.shelfno_name  shelfno_name ,
  alloctbl.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  alloctbl.loca_code_shelfno  loca_code_shelfno ,
  alloctbl.loca_name_shelfno  loca_name_shelfno ,
  alloctbl.prjno_code  prjno_code ,
  alloctbl.trngantt_prjno_id  trngantt_prjno_id ,
  alloctbl.classlist_code  classlist_code ,
  alloctbl.classlist_name  classlist_name ,
  alloctbl.loca_code_pare  loca_code_pare ,
  alloctbl.loca_name_pare  loca_name_pare ,
  alloctbl.boxe_unit_id_box  boxe_unit_id_box ,
  alloctbl.unit_code_box  unit_code_box ,
  alloctbl.unit_name_box  unit_name_box ,
  alloctbl.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  alloctbl.unit_code_outbox  unit_code_outbox ,
  alloctbl.unit_name_outbox  unit_name_outbox ,
  alloctbl.boxe_code  boxe_code ,
  alloctbl.boxe_name  boxe_name ,
  alloctbl.opeitm_boxe_id  opeitm_boxe_id ,
  alloctbl.prjno_code_chil  prjno_code_chil ,
  alloctbl.opeitm_shelfno_id  opeitm_shelfno_id ,
  alloctbl.itm_classlist_id  itm_classlist_id ,
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
outstk.alloctbls_id   outstk_alloctbl_id
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
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
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
,shelfno_name  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,boxe_name  varchar (100) 
,prjno_code  varchar (50) 
,prjno_code_chil  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,loca_code  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,prjno_name  varchar (100) 
,itm_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,unit_code_pare  varchar (50) 
,unit_name_pare  varchar (100) 
,loca_code_shelfno_fm  varchar (50) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,shelfno_code  varchar (50) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,boxe_code  varchar (50) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,loca_code_pare  varchar (50) 
,loca_name_pare  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,outstk_starttime   timestamp(6) 
,outstk_expiredate   date 
,outstk_remark  varchar (4000) 
,outstk_alloctbl_id  numeric (38,0)
,id  numeric (38,0)
,outstk_created_at   timestamp(6) 
,outstk_update_ip  varchar (40) 
,outstk_updated_at   timestamp(6) 
,outstk_id  numeric (38,0)
,outstk_person_id_upd  numeric (38,0)
,outstk_shelfno_id_out  numeric (22,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,itm_unit_id  numeric (22,0)
,shelfno_loca_id_shelfno_out  numeric (38,0)
,alloctbl_trngantt_id  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,trngantt_itm_id  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
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
  alloctbl.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  alloctbl.unit_name_prdpurshp  unit_name_prdpurshp ,
  alloctbl.unit_code_prdpurshp  unit_code_prdpurshp ,
  alloctbl.itm_name  itm_name ,
  alloctbl.itm_code  itm_code ,
  alloctbl.unit_name  unit_name ,
  alloctbl.unit_code  unit_code ,
  alloctbl.loca_code  loca_code ,
  alloctbl.loca_name  loca_name ,
  alloctbl.itm_unit_id  itm_unit_id ,
  alloctbl.opeitm_itm_id  opeitm_itm_id ,
  alloctbl.opeitm_loca_id  opeitm_loca_id ,
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
  alloctbl.unit_code_case  unit_code_case ,
  alloctbl.unit_name_case  unit_name_case ,
  alloctbl.opeitm_unit_id_case  opeitm_unit_id_case ,
  alloctbl.shelfno_code  shelfno_code ,
  alloctbl.shelfno_name  shelfno_name ,
  alloctbl.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  alloctbl.loca_code_shelfno  loca_code_shelfno ,
  alloctbl.loca_name_shelfno  loca_name_shelfno ,
  alloctbl.prjno_code  prjno_code ,
  alloctbl.trngantt_prjno_id  trngantt_prjno_id ,
  alloctbl.classlist_code  classlist_code ,
  alloctbl.classlist_name  classlist_name ,
  alloctbl.loca_code_pare  loca_code_pare ,
  alloctbl.loca_name_pare  loca_name_pare ,
  alloctbl.boxe_unit_id_box  boxe_unit_id_box ,
  alloctbl.unit_code_box  unit_code_box ,
  alloctbl.unit_name_box  unit_name_box ,
  alloctbl.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  alloctbl.unit_code_outbox  unit_code_outbox ,
  alloctbl.unit_name_outbox  unit_name_outbox ,
  alloctbl.boxe_code  boxe_code ,
  alloctbl.boxe_name  boxe_name ,
  alloctbl.opeitm_boxe_id  opeitm_boxe_id ,
  alloctbl.prjno_code_chil  prjno_code_chil ,
  alloctbl.opeitm_shelfno_id  opeitm_shelfno_id ,
  shelfno_in.shelfno_code  shelfno_code_in ,
  shelfno_in.shelfno_name  shelfno_name_in ,
  shelfno_in.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_in ,
  shelfno_in.loca_code_shelfno  loca_code_shelfno_in ,
  shelfno_in.loca_name_shelfno  loca_name_shelfno_in ,
  alloctbl.itm_classlist_id  itm_classlist_id ,
  alloctbl.trngantt_loca_id_pare  trngantt_loca_id_pare ,
  alloctbl.itm_classlist_id_pare  itm_classlist_id_pare ,
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
instk.alloctbls_id   instk_alloctbl_id
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
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
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
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,boxe_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,prjno_name  varchar (100) 
,itm_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,boxe_code  varchar (50) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,prjno_code  varchar (50) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,loca_code_pare  varchar (50) 
,loca_name_pare  varchar (100) 
,instk_expiredate   date 
,instk_inoutflg  varchar (20) 
,trngantt_duedate   timestamp(6) 
,alloctbl_srctblname  varchar (30) 
,alloctbl_srctblid  numeric (38,0)
,instk_alloctbl_id  numeric (38,0)
,id  numeric (38,0)
,instk_created_at   timestamp(6) 
,instk_update_ip  varchar (40) 
,instk_updated_at   timestamp(6) 
,instk_id  numeric (38,0)
,instk_person_id_upd  numeric (38,0)
,instk_shelfno_id_in  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,alloctbl_trngantt_id  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,itm_unit_id_pare  numeric (22,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,shelfno_loca_id_shelfno_in  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
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
