
 create table shpacts (
 id numeric(38,0 )   not null  ,
 sno varchar(40)   ,
 starttime timestamp(6)  ,
 duedate timestamp(6)  ,
 isudate timestamp(6)  ,
 gno varchar(40)   ,
 shelfnos_id_fm numeric(22,0 )   not null ,
 qty numeric(22,6 )   ,
 locas_id_to numeric(38,0 )   not null ,
 qty_case numeric(22,0 )   ,
 cno varchar(40)   ,
 cartonno varchar(20)   ,
 price numeric(38,4 )   ,
 contract_price char(1)   ,
 amt numeric(18,4 )   ,
 tax numeric(38,4 )   ,
 box varchar(50)   ,
 contents varchar(4000)   ,
 expiredate date  ,
 remark varchar(4000)   ,
 transports_id numeric(38,0 )   not null ,
 persons_id_upd numeric(38,0 )   not null ,
 prjnos_id numeric(38,0 )   not null ,
 opeitms_id numeric(38,0 )   not null ,
 chrgs_id numeric(38,0 )   not null ,
 created_at timestamp(6)  ,
 update_ip varchar(40)   ,
 updated_at timestamp(6)  ,
  CONSTRAINT shpacts_id_pk PRIMARY KEY (id));
 ALTER TABLE shpacts ADD CONSTRAINT shpact_shelfnos_id_fm FOREIGN KEY (shelfnos_id_fm)
																		 REFERENCES shelfnos (id);
 ALTER TABLE shpacts ADD CONSTRAINT shpact_locas_id_to FOREIGN KEY (locas_id_to)
																		 REFERENCES locas (id);
 ALTER TABLE shpacts ADD CONSTRAINT shpact_transports_id FOREIGN KEY (transports_id)
																		 REFERENCES transports (id);
 ALTER TABLE shpacts ADD CONSTRAINT shpact_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 ALTER TABLE shpacts ADD CONSTRAINT shpact_prjnos_id FOREIGN KEY (prjnos_id)
																		 REFERENCES prjnos (id);
 ALTER TABLE shpacts ADD CONSTRAINT shpact_opeitms_id FOREIGN KEY (opeitms_id)
																		 REFERENCES opeitms (id);
 ALTER TABLE shpacts ADD CONSTRAINT shpact_chrgs_id FOREIGN KEY (chrgs_id)
																		 REFERENCES chrgs (id);
 create sequence shpacts_seq ;
 --- drop view r_shpacts cascade  
 create or replace view r_shpacts as select  
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
shpact.opeitms_id   shpact_opeitm_id,
shpact.transports_id   shpact_transport_id,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
shpact.prjnos_id   shpact_prjno_id,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.boxe_code  boxe_code ,
  transport.transport_code  transport_code ,
  opeitm.boxe_name  boxe_name ,
  transport.transport_name  transport_name ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  opeitm.shelfno_name  shelfno_name ,
  prjno.prjno_name  prjno_name ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_code  unit_code ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  .itm_code  itm_code ,
  .itm_name  itm_name ,
shpact.shelfnos_id_fm   shpact_shelfno_id_fm,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
shpact.id  shpact_id,
shpact.id id,
shpact.locas_id_to   shpact_loca_id_to,
shpact.qty  shpact_qty,
shpact.amt  shpact_amt,
shpact.remark  shpact_remark,
shpact.expiredate  shpact_expiredate,
shpact.update_ip  shpact_update_ip,
shpact.created_at  shpact_created_at,
shpact.updated_at  shpact_updated_at,
shpact.persons_id_upd   shpact_person_id_upd,
shpact.tax  shpact_tax,
shpact.price  shpact_price,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  .loca_code_to  loca_code_to ,
  .loca_code  loca_code ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  .loca_name_to  loca_name_to ,
  .loca_name  loca_name ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  .person_code_chrg  person_code_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
shpact.chrgs_id   shpact_chrg_id,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  opeitm.classlist_code  classlist_code ,
shpact.sno  shpact_sno,
shpact.box  shpact_box,
shpact.duedate  shpact_duedate,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
shpact.starttime  shpact_starttime,
  opeitm.classlist_name  classlist_name ,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_code  prjno_code ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
  .shelfno_loca_id_shelfno_act  shelfno_loca_id_shelfno_act ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
shpact.contents  shpact_contents,
shpact.contract_price  shpact_contract_price,
shpact.gno  shpact_gno,
shpact.isudate  shpact_isudate,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
shpact.cno  shpact_cno,
shpact.qty_case  shpact_qty_case,
shpact.cartonno  shpact_cartonno
 from shpacts   shpact,
  r_opeitms  opeitm ,  r_transports  transport ,  r_prjnos  prjno ,  r_shelfnos  shelfno_fm ,  r_locas  loca_to ,  r_persons  person_upd ,  r_chrgs  chrg 
  where       shpact.opeitms_id = opeitm.id      and shpact.transports_id = transport.id      and shpact.prjnos_id = prjno.id      and shpact.shelfnos_id_fm = shelfno_fm.id      and shpact.locas_id_to = loca_to.id      and shpact.persons_id_upd = person_upd.id      and shpact.chrgs_id = chrg.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shpacts;
 CREATE TABLE sio.sio_r_shpacts (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_shpacts_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,shpact_cno  varchar (40) 
,shpact_gno  varchar (40) 
,shpact_sno  varchar (40) 
,unit_code_prdpurshp  varchar (50) 
,prjno_name  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,classlist_name  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,prjno_code_chil  varchar (50) 
,transport_name  varchar (100) 
,shelfno_name_fm  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,boxe_name  varchar (100) 
,shelfno_code_fm  varchar (50) 
,shelfno_code  varchar (50) 
,boxe_code  varchar (50) 
,transport_code  varchar (50) 
,unit_code_outbox  varchar (50) 
,unit_code_box  varchar (50) 
,unit_code_case  varchar (50) 
,unit_code  varchar (50) 
,shelfno_name  varchar (100) 
,unit_name_outbox  varchar (100) 
,unit_name_box  varchar (100) 
,unit_name_case  varchar (100) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_shelfno  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,classlist_code  varchar (50) 
,prjno_code  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_shelfno  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,person_name_chrg  varchar (100) 
,unit_name  varchar (100) 
,shpact_box  varchar (50) 
,shpact_amt  numeric (18,4)
,shpact_price  numeric (38,4)
,shpact_isudate   timestamp(6) 
,shpact_starttime   timestamp(6) 
,shpact_duedate   timestamp(6) 
,shpact_cartonno  varchar (20) 
,shpact_tax  numeric (38,4)
,shpact_expiredate   date 
,shpact_contract_price  varchar (1) 
,shpact_qty_case  numeric (22,0)
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,opeitm_packqty  numeric (38,0)
,opeitm_mold  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,transport_contents  varchar (4000) 
,opeitm_packno_flg  varchar (1) 
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autoinst_p  numeric (3,0)
,opeitm_maxqty  numeric (22,0)
,itm_std  varchar (50) 
,opeitm_autoact_p  numeric (3,0)
,opeitm_autoord_p  numeric (3,0)
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_prdpurshp  varchar (20) 
,loca_abbr_to  varchar (50) 
,loca_zip_to  varchar (10) 
,loca_country_to  varchar (20) 
,loca_prfct_to  varchar (20) 
,boxe_boxtype  varchar (20) 
,loca_addr1_to  varchar (50) 
,loca_addr2_to  varchar (50) 
,loca_tel_to  varchar (20) 
,loca_fax_to  varchar (20) 
,loca_mail_to  varchar (20) 
,opeitm_duration  numeric (38,2)
,opeitm_units_lttime  varchar (4) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_chkord_prc  numeric (3,0)
,opeitm_chkord  varchar (1) 
,opeitm_esttosch  numeric (22,0)
,opeitm_stktaking_proc  varchar (1) 
,opeitm_rule_price  varchar (1) 
,opeitm_processseq  numeric (3,0)
,opeitm_chkinst  varchar (1) 
,opeitm_minqty  numeric (38,6)
,opeitm_acceptance_proc  varchar (1) 
,person_email_chrg  varchar (50) 
,shelfno_contents_fm  varchar (4000) 
,opeitm_contents  varchar (4000) 
,scrlv_level1_chrg  varchar (1) 
,opeitm_operation  varchar (20) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_safestkqty  numeric (38,0)
,opeitm_priority  numeric (3,0)
,opeitm_shuffle_flg  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,loca_code_to  varchar (50) 
,loca_name_to  varchar (100) 
,shpact_qty  numeric (18,4)
,shpact_contents  varchar (4000) 
,shpact_remark  varchar (4000) 
,shpact_shelfno_id_fm  numeric (22,0)
,shpact_opeitm_id  numeric (38,0)
,shpact_transport_id  numeric (38,0)
,shpact_prjno_id  numeric (38,0)
,shpact_id  numeric (38,0)
,id  numeric (38,0)
,shpact_loca_id_to  numeric (38,0)
,shpact_update_ip  varchar (40) 
,shpact_created_at   timestamp(6) 
,shpact_updated_at   timestamp(6) 
,shpact_person_id_upd  numeric (38,0)
,shpact_chrg_id  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,loca_addr2  varchar (50) 
,loca_addr1  varchar (50) 
,loca_prfct  varchar (20) 
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,loca_zip  varchar (10) 
,loca_abbr  varchar (50) 
,opeitm_boxe_id  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,opeitm_consumauto  varchar (1) 
,transport_expiredate   date 
,chrg_expiredate   date 
,shelfno_expiredate   date 
,prjno_expiredate   date 
,person_code_chrg  varchar (50) 
,boxe_expiredate   date 
,loca_expiredate   date 
,shelfno_loca_id_shelfno_act  numeric (22,0)
,opeitm_consumtype  varchar (3) 
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
 CREATE INDEX sio_r_shpacts_uk1 
  ON sio.sio_r_shpacts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpacts_seq ;
 create sequence sio.sio_r_shpacts_seq ;
