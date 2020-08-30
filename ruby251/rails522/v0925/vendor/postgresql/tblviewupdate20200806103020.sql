
 create table acpschs (
 id numeric(38,0 )   not null  ,
 contents varchar(4000)   ,
 isudate timestamp(6)  ,
 processseq_pare numeric(38,0 )   ,
 acpdate timestamp(6)  ,
 qty numeric(22,6 )   ,
 price numeric(38,4 )   ,
 amt numeric(18,4 )   ,
 tax numeric(38,4 )   ,
 updated_at timestamp(6)  ,
 sno varchar(40)   ,
 manual char(1)   ,
 expiredate date  ,
 persons_id_upd numeric(38,0 )   not null ,
 remark varchar(4000)   ,
 update_ip varchar(40)   ,
 created_at timestamp(6)  ,
 prjnos_id numeric(38,0 )   not null ,
 opeitms_id numeric(38,0 )   not null ,
  CONSTRAINT acpschs_id_pk PRIMARY KEY (id));
 ALTER TABLE acpschs ADD CONSTRAINT acpsch_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 ALTER TABLE acpschs ADD CONSTRAINT acpsch_prjnos_id FOREIGN KEY (prjnos_id)
																		 REFERENCES prjnos (id);
 ALTER TABLE acpschs ADD CONSTRAINT acpsch_opeitms_id FOREIGN KEY (opeitms_id)
																		 REFERENCES opeitms (id);
 create sequence acpschs_seq ;
 DROP TABLE IF EXISTS sio.sio_r_acpschs;
 CREATE TABLE sio.sio_r_acpschs (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_acpschs_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
 CREATE INDEX sio_r_acpschs_uk1 
  ON sio.sio_r_acpschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_acpschs_seq ;
 create sequence sio.sio_r_acpschs_seq ;
 ALTER TABLE acpschs ADD CONSTRAINT acpsch_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 ALTER TABLE acpschs ADD CONSTRAINT acpsch_prjnos_id FOREIGN KEY (prjnos_id)
																		 REFERENCES prjnos (id);
 ALTER TABLE acpschs ADD CONSTRAINT acpsch_opeitms_id FOREIGN KEY (opeitms_id)
																		 REFERENCES opeitms (id);
 --- drop view r_alloctbls cascade  
 create or replace view r_alloctbls as select  
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  trngantt.shelfno_code_fm  shelfno_code_fm ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.boxe_code  boxe_code ,
  trngantt.trngantt_processseq  trngantt_processseq ,
  opeitm.boxe_name  boxe_name ,
  trngantt.shelfno_name_fm  shelfno_name_fm ,
  opeitm.shelfno_name  shelfno_name ,
  prjno.prjno_name  prjno_name ,
  trngantt.trngantt_starttime  trngantt_starttime ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_code_case  unit_code_case ,
  trngantt.unit_code_pare  unit_code_pare ,
  trngantt.unit_code  unit_code ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.unit_name_case  unit_name_case ,
  trngantt.unit_name_pare  unit_name_pare ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  trngantt.trngantt_itm_id  trngantt_itm_id ,
  trngantt.trngantt_loca_id  trngantt_loca_id ,
  trngantt.itm_code_pare  itm_code_pare ,
  opeitm.itm_code  itm_code ,
  trngantt.itm_name_pare  itm_name_pare ,
  trngantt.itm_name  itm_name ,
  trngantt.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  trngantt.loca_code_pare  loca_code_pare ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_code  loca_code ,
  trngantt.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  trngantt.loca_name_pare  loca_name_pare ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.loca_name  loca_name ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  trngantt.itm_unit_id_pare  itm_unit_id_pare ,
  opeitm.itm_unit_id  itm_unit_id ,
  trngantt.itm_classlist_id_pare  itm_classlist_id_pare ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  trngantt.trngantt_duedate  trngantt_duedate ,
  opeitm.opeitm_packqty  opeitm_packqty ,
alloctbl.id  alloctbl_id,
alloctbl.id id,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  trngantt.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  trngantt.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  trngantt.trngantt_processseq_pare  trngantt_processseq_pare ,
  trngantt.trngantt_loca_id_pare  trngantt_loca_id_pare ,
  trngantt.classlist_code_pare  classlist_code_pare ,
  opeitm.classlist_code  classlist_code ,
  trngantt.trngantt_qty_alloc  trngantt_qty_alloc ,
alloctbl.trngantts_id   alloctbl_trngantt_id,
alloctbl.qty_alloc  alloctbl_qty_alloc,
  trngantt.trngantt_qty  trngantt_qty ,
  trngantt.classlist_name_pare  classlist_name_pare ,
  opeitm.classlist_name  classlist_name ,
  prjno.prjno_code_chil  prjno_code_chil ,
alloctbl.srctblname  alloctbl_srctblname,
alloctbl.srctblid  alloctbl_srctblid,
alloctbl.remark  alloctbl_remark,
alloctbl.expiredate  alloctbl_expiredate,
alloctbl.persons_id_upd   alloctbl_person_id_upd,
alloctbl.update_ip  alloctbl_update_ip,
alloctbl.created_at  alloctbl_created_at,
alloctbl.updated_at  alloctbl_updated_at,
alloctbl.contents  alloctbl_contents,
  prjno.prjno_code  prjno_code ,
alloctbl.qty  alloctbl_qty,
  trngantt.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
alloctbl.qty_stk  alloctbl_qty_stk,
  trngantt.trngantt_prjno_id  trngantt_prjno_id ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
alloctbl.qty_linkto_alloctbl  alloctbl_qty_linkto_alloctbl,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox 
 from alloctbls   alloctbl,
  r_trngantts  trngantt ,  r_persons  person_upd 
  where       alloctbl.trngantts_id = trngantt.id      and alloctbl.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_alloctbls;
 CREATE TABLE sio.sio_r_alloctbls (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_alloctbls_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,unit_code_box  varchar (50) 
,itm_name  varchar (100) 
,prjno_name  varchar (100) 
,shelfno_code_fm  varchar (50) 
,shelfno_code  varchar (50) 
,boxe_code  varchar (50) 
,unit_code_outbox  varchar (50) 
,prjno_code  varchar (50) 
,prjno_code_chil  varchar (50) 
,unit_code_case  varchar (50) 
,unit_code_pare  varchar (50) 
,unit_code  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_pare  varchar (50) 
,loca_code_shelfno  varchar (50) 
,loca_code  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_pare  varchar (100) 
,loca_name_shelfno  varchar (100) 
,loca_name  varchar (100) 
,classlist_name  varchar (100) 
,classlist_name_pare  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,classlist_code  varchar (50) 
,classlist_code_pare  varchar (50) 
,unit_name_outbox  varchar (100) 
,unit_name_box  varchar (100) 
,unit_name_case  varchar (100) 
,unit_name_pare  varchar (100) 
,unit_name  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,boxe_name  varchar (100) 
,shelfno_name_fm  varchar (100) 
,shelfno_name  varchar (100) 
,itm_code_pare  varchar (50) 
,itm_code  varchar (50) 
,itm_name_pare  varchar (100) 
,alloctbl_expiredate   date 
,alloctbl_srctblid  numeric (38,0)
,alloctbl_srctblname  varchar (30) 
,alloctbl_qty_linkto_alloctbl  numeric (22,0)
,alloctbl_qty  numeric (22,6)
,alloctbl_qty_stk  numeric (22,6)
,alloctbl_qty_alloc  numeric (22,6)
,trngantt_qty  numeric (18,4)
,opeitm_prdpurshp  varchar (20) 
,opeitm_opt_fix_flg  varchar (1) 
,trngantt_consumauto  varchar (1) 
,trngantt_processseq  numeric (38,0)
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autoinst_p  numeric (3,0)
,trngantt_starttime   timestamp(6) 
,trngantt_shuffle_flg  varchar (1) 
,trngantt_consumminqty  numeric (22,6)
,trngantt_consumunitqty  numeric (22,6)
,itm_std  varchar (50) 
,trngantt_consumchgoverqty  numeric (22,6)
,opeitm_autoact_p  numeric (3,0)
,opeitm_autoord_p  numeric (3,0)
,trngantt_qty_stk  numeric (22,0)
,trngantt_tblname  varchar (30) 
,trngantt_tblid  numeric (38,0)
,loca_tel_pare  varchar (20) 
,opeitm_duration  numeric (38,2)
,opeitm_units_lttime  varchar (4) 
,opeitm_minqty  numeric (38,6)
,opeitm_operation  varchar (20) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_packqty  numeric (38,0)
,trngantt_mlevel  numeric (3,0)
,trngantt_orgtblname  varchar (30) 
,trngantt_key  varchar (250) 
,opeitm_shuffle_flg  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,trngantt_processseq_pare  numeric (38,0)
,opeitm_shuffle_loca  varchar (1) 
,opeitm_chkord_prc  numeric (3,0)
,opeitm_chkord  varchar (1) 
,trngantt_qty_stk_pare  numeric (22,6)
,trngantt_qty_pare  numeric (22,6)
,opeitm_esttosch  numeric (22,0)
,opeitm_stktaking_proc  varchar (1) 
,opeitm_rule_price  varchar (1) 
,trngantt_qty_alloc  numeric (22,6)
,opeitm_mold  varchar (1) 
,trngantt_qty_pare_alloc  numeric (22,6)
,trngantt_duedate_org   timestamp(6) 
,opeitm_autocreate_inst  varchar (1) 
,trngantt_qty_linkto_alloctbl  numeric (22,0)
,opeitm_packno_flg  varchar (1) 
,trngantt_consumtype  varchar (3) 
,trngantt_paretblname  varchar (30) 
,trngantt_paretblid  numeric (38,0)
,opeitm_processseq  numeric (3,0)
,opeitm_priority  numeric (3,0)
,trngantt_orgtblid  numeric (22,0)
,opeitm_contents  varchar (4000) 
,opeitm_acceptance_proc  varchar (1) 
,opeitm_chkinst  varchar (1) 
,boxe_boxtype  varchar (20) 
,opeitm_maxqty  numeric (22,0)
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_safestkqty  numeric (38,0)
,trngantt_parenum  numeric (22,0)
,trngantt_chilnum  numeric (22,0)
,trngantt_duedate   timestamp(6) 
,alloctbl_contents  varchar (4000) 
,alloctbl_remark  varchar (4000) 
,id  numeric (38,0)
,alloctbl_update_ip  varchar (40) 
,alloctbl_created_at   timestamp(6) 
,alloctbl_updated_at   timestamp(6) 
,alloctbl_id  numeric (38,0)
,alloctbl_trngantt_id  numeric (38,0)
,alloctbl_person_id_upd  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,trngantt_itm_id  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,loca_addr1  varchar (50) 
,loca_prfct  varchar (20) 
,loca_zip  varchar (10) 
,itm_unit_id  numeric (22,0)
,itm_unit_id_pare  numeric (22,0)
,loca_addr2  varchar (50) 
,itm_classlist_id  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,loca_abbr  varchar (50) 
,trngantt_loca_id  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
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
 CREATE INDEX sio_r_alloctbls_uk1 
  ON sio.sio_r_alloctbls(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_alloctbls_seq ;
 create sequence sio.sio_r_alloctbls_seq ;
