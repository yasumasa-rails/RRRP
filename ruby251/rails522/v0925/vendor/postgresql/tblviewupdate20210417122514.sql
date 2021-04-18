
  drop view if  exists r_custords cascade ; 
 create or replace view r_custords as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
custord.remark  custord_remark,
custord.update_ip  custord_update_ip,
custord.duedate  custord_duedate,
custord.updated_at  custord_updated_at,
custord.price  custord_price,
custord.id  custord_id,
custord.persons_id_upd   custord_person_id_upd,
custord.created_at  custord_created_at,
custord.toduedate  custord_toduedate,
custord.expiredate  custord_expiredate,
custord.sno  custord_sno,
  cust.loca_name_cust  loca_name_cust ,
custord.amt  custord_amt,
custord.qty  custord_qty,
custord.isudate  custord_isudate,
  cust.loca_code_cust  loca_code_cust ,
  custrcvplc.loca_code_custrcvplc  loca_code_custrcvplc ,
  custrcvplc.loca_name_custrcvplc  loca_name_custrcvplc ,
custord.id id,
custord.custs_id   custord_cust_id,
  cust.cust_loca_id_cust  cust_loca_id_cust ,
  prjno.prjno_name  prjno_name ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
custord.cno  custord_cno,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  prjno.prjno_code  prjno_code ,
custord.prjnos_id   custord_prjno_id,
custord.gno  custord_gno,
  custrcvplc.custrcvplc_loca_id_custrcvplc  custrcvplc_loca_id_custrcvplc ,
  cust.cust_contract_price  cust_contract_price ,
custord.contract_price  custord_contract_price,
  cust.cust_chrg_id_cust  cust_chrg_id_cust ,
  cust.chrg_person_id_chrg_cust  chrg_person_id_chrg_cust ,
  cust.person_code_chrg_cust  person_code_chrg_cust ,
  cust.person_name_chrg_cust  person_name_chrg_cust ,
  cust.person_sect_id_chrg_cust  person_sect_id_chrg_cust ,
  chrg_cpo.scrlv_code_chrg  scrlv_code_chrg_cpo ,
  chrg_cpo.usrgrp_code_chrg  usrgrp_code_chrg_cpo ,
  chrg_cpo.usrgrp_name_chrg  usrgrp_name_chrg_cpo ,
custord.chrgs_id_cpo   custord_chrg_id_cpo,
  chrg_cpo.person_code_chrg  person_code_chrg_cpo ,
  chrg_cpo.person_name_chrg  person_name_chrg_cpo ,
  chrg_cpo.loca_code_sect_chrg  loca_code_sect_chrg_cpo ,
  chrg_cpo.loca_name_sect_chrg  loca_name_sect_chrg_cpo ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  chrg_cpo.person_sect_id_chrg  person_sect_id_chrg_cpo ,
  cust.bill_loca_id_bill  bill_loca_id_bill ,
  cust.loca_code_bill  loca_code_bill ,
  cust.loca_name_bill  loca_name_bill ,
  cust.cust_bill_id  cust_bill_id ,
  chrg_cpo.chrg_person_id_chrg  chrg_person_id_chrg_cpo ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
custord.custrcvplcs_id   custord_custrcvplc_id,
custord.itm_code_client  custord_itm_code_client,
custord.contents  custord_contents,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  cust.bill_chrg_id_bill  bill_chrg_id_bill ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
  cust.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  cust.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
custord.opeitms_id   custord_opeitm_id,
custord.cno_custsch  custord_cno_custsch,
  cust.bill_crr_id_bill  bill_crr_id_bill ,
  cust.crr_code_bill  crr_code_bill ,
  cust.crr_name_bill  crr_name_bill ,
custord.starttime  custord_starttime,
  custrcvplc.custrcvplc_stktaking_proc  custrcvplc_stktaking_proc ,
custord.shelfnos_id_fm   custord_shelfno_id_fm,
  prjno.prjno_name_chil  prjno_name_chil 
 from custords   custord,
  r_persons  person_upd ,  r_custs  cust ,  r_prjnos  prjno ,  r_chrgs  chrg_cpo ,  r_custrcvplcs  custrcvplc ,  r_opeitms  opeitm ,  r_shelfnos  shelfno_fm 
  where       custord.persons_id_upd = person_upd.id      and custord.custs_id = cust.id      and custord.prjnos_id = prjno.id      and custord.chrgs_id_cpo = chrg_cpo.id      and custord.custrcvplcs_id = custrcvplc.id      and custord.opeitms_id = opeitm.id      and custord.shelfnos_id_fm = shelfno_fm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custords;
 CREATE TABLE sio.sio_r_custords (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custords_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,custord_isudate   date 
,custord_cno  varchar (40) 
,loca_code_cust  varchar (50) 
,loca_name_cust  varchar (100) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,opeitm_processseq  numeric (3,0)
,custord_duedate   timestamp(6) 
,custord_qty  numeric (18,4)
,custord_price  numeric (22,0)
,cust_contract_price  varchar (1) 
,custord_contract_price  varchar (1) 
,custord_itm_code_client  varchar (50) 
,custord_amt  numeric (18,4)
,person_code_chrg_cust  varchar (50) 
,person_name_chrg_cust  varchar (100) 
,loca_code_bill  varchar (50) 
,loca_name_bill  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,loca_name_sect_chrg_cpo  varchar (100) 
,boxe_name  varchar (100) 
,boxe_code  varchar (50) 
,loca_code_sect_chrg_cpo  varchar (50) 
,person_name_chrg_cpo  varchar (100) 
,person_code_chrg_cpo  varchar (50) 
,usrgrp_name_chrg_cpo  varchar (100) 
,usrgrp_code_chrg_cpo  varchar (50) 
,scrlv_code_chrg_cpo  varchar (50) 
,crr_code_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,prjno_name_chil  varchar (100) 
,classlist_code  varchar (50) 
,custord_cno_custsch  varchar (50) 
,custord_starttime   timestamp(6) 
,classlist_name  varchar (100) 
,custord_sno  varchar (40) 
,opeitm_packqty  numeric (38,0)
,custrcvplc_stktaking_proc  varchar (1) 
,shelfno_code_fm  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_custrcvplc  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,shelfno_name_fm  varchar (100) 
,loca_name_custrcvplc  varchar (100) 
,custord_shelfno_id_fm  numeric (22,0)
,custord_gno  varchar (40) 
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,custord_toduedate   timestamp(6) 
,custord_expiredate   date 
,custord_contents  varchar (4000) 
,custord_remark  varchar (4000) 
,custord_prjno_id  numeric (38,0)
,custord_chrg_id_cpo  numeric (38,0)
,person_sect_id_chrg_cpo  numeric (22,0)
,chrg_person_id_chrg_cpo  numeric (38,0)
,custord_custrcvplc_id  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,custord_opeitm_id  numeric (38,0)
,person_sect_id_chrg_cust  numeric (22,0)
,bill_crr_id_bill  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
,itm_unit_id  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,bill_chrg_id_bill  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,bill_loca_id_bill  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,cust_loca_id_cust  numeric (38,0)
,cust_chrg_id_cust  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,custord_cust_id  numeric (22,0)
,custord_updated_at   timestamp(6) 
,custord_update_ip  varchar (40) 
,cust_bill_id  numeric (22,0)
,id  numeric (22,0)
,custord_id  numeric (22,0)
,custord_created_at   timestamp(6) 
,custord_person_id_upd  numeric (22,0)
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
 CREATE INDEX sio_r_custords_uk1 
  ON sio.sio_r_custords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custords_seq ;
 create sequence sio.sio_r_custords_seq ;
