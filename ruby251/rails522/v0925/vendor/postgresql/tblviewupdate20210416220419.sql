
  drop view if  exists r_custdlvs cascade ; 
 create or replace view r_custdlvs as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  cust.loca_name_cust  loca_name_cust ,
  cust.loca_code_cust  loca_code_cust ,
  custrcvplc.loca_code_custrcvplc  loca_code_custrcvplc ,
  custrcvplc.loca_name_custrcvplc  loca_name_custrcvplc ,
custdlv.id id,
  cust.cust_loca_id_cust  cust_loca_id_cust ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  asstwh.asstwh_loca_id_asstwh  asstwh_loca_id_asstwh ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  custrcvplc.custrcvplc_loca_id_custrcvplc  custrcvplc_loca_id_custrcvplc ,
  cust.scrlv_code_chrg_cust  scrlv_code_chrg_cust ,
  cust.cust_chrg_id_cust  cust_chrg_id_cust ,
  cust.chrg_person_id_chrg_cust  chrg_person_id_chrg_cust ,
  cust.person_code_chrg_cust  person_code_chrg_cust ,
  cust.person_name_chrg_cust  person_name_chrg_cust ,
  cust.person_sect_id_chrg_cust  person_sect_id_chrg_cust ,
  cust.loca_code_sect_chrg_cust  loca_code_sect_chrg_cust ,
  cust.loca_name_sect_chrg_cust  loca_name_sect_chrg_cust ,
  cust.usrgrp_code_chrg_cust  usrgrp_code_chrg_cust ,
  cust.usrgrp_name_chrg_cust  usrgrp_name_chrg_cust ,
  chrg_cpo.scrlv_code_chrg  scrlv_code_chrg_cpo ,
  chrg_cpo.usrgrp_code_chrg  usrgrp_code_chrg_cpo ,
  chrg_cpo.usrgrp_name_chrg  usrgrp_name_chrg_cpo ,
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
  asstwh.asstwh_chrg_id_asstwh  asstwh_chrg_id_asstwh ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  cust.bill_chrg_id_bill  bill_chrg_id_bill ,
  cust.person_code_chrg_bill  person_code_chrg_bill ,
  cust.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  cust.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  cust.person_name_chrg_bill  person_name_chrg_bill ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
  cust.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  cust.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  cust.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  cust.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  cust.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  cust.bill_crr_id_bill  bill_crr_id_bill ,
  cust.crr_code_bill  crr_code_bill ,
  cust.crr_name_bill  crr_name_bill ,
custdlv.custs_id   custdlv_cust_id,
custdlv.itm_code_client  custdlv_itm_code_client,
custdlv.cno  custdlv_cno,
custdlv.custrcvplcs_id   custdlv_custrcvplc_id,
custdlv.asstwhs_id   custdlv_asstwh_id,
custdlv.gno  custdlv_gno,
custdlv.contract_price  custdlv_contract_price,
custdlv.starttime  custdlv_starttime,
custdlv.chrgs_id_cpo   custdlv_chrg_id_cpo,
custdlv.qty  custdlv_qty,
custdlv.price  custdlv_price,
custdlv.expiredate  custdlv_expiredate,
custdlv.duedate  custdlv_duedate,
custdlv.amt  custdlv_amt,
custdlv.isudate  custdlv_isudate,
custdlv.sno  custdlv_sno,
custdlv.remark  custdlv_remark,
custdlv.persons_id_upd   custdlv_person_id_upd,
custdlv.update_ip  custdlv_update_ip,
custdlv.created_at  custdlv_created_at,
custdlv.updated_at  custdlv_updated_at,
custdlv.shelfnos_id_fm   custdlv_shelfno_id_fm,
custdlv.opeitms_id   custdlv_opeitm_id
 from custdlvs   custdlv,
  r_custs  cust ,  r_custrcvplcs  custrcvplc ,  r_asstwhs  asstwh ,  r_chrgs  chrg_cpo ,  r_persons  person_upd ,  r_shelfnos  shelfno_fm ,  r_opeitms  opeitm 
  where       custdlv.custs_id = cust.id      and custdlv.custrcvplcs_id = custrcvplc.id      and custdlv.asstwhs_id = asstwh.id      and custdlv.chrgs_id_cpo = chrg_cpo.id      and custdlv.persons_id_upd = person_upd.id      and custdlv.shelfnos_id_fm = shelfno_fm.id      and custdlv.opeitms_id = opeitm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custdlvs;
 CREATE TABLE sio.sio_r_custdlvs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custdlvs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,loca_code  varchar (50) 
,person_code_upd  varchar (50) 
,itm_code  varchar (50) 
,classlist_code  varchar (50) 
,shelfno_code  varchar (50) 
,unit_code  varchar (50) 
,boxe_code  varchar (50) 
,loca_code_sect_chrg_cpo  varchar (50) 
,person_code_chrg_cpo  varchar (50) 
,crr_name_bill  varchar (100) 
,crr_code_bill  varchar (50) 
,usrgrp_name_chrg_cpo  varchar (100) 
,usrgrp_code_chrg_cpo  varchar (50) 
,scrlv_code_chrg_cpo  varchar (50) 
,loca_name_sect_chrg_cpo  varchar (100) 
,person_name_chrg_cpo  varchar (100) 
,shelfno_name  varchar (100) 
,boxe_name  varchar (100) 
,loca_name  varchar (100) 
,person_name_upd  varchar (100) 
,unit_name  varchar (100) 
,itm_name  varchar (100) 
,classlist_name  varchar (100) 
,loca_code_custrcvplc  varchar (50) 
,unit_code_outbox  varchar (50) 
,loca_code_cust  varchar (50) 
,unit_code_box  varchar (50) 
,loca_code_sect_chrg_bill  varchar (50) 
,scrlv_code_chrg_bill  varchar (50) 
,unit_code_case  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_shelfno  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,scrlv_code_chrg_cust  varchar (50) 
,shelfno_code_fm  varchar (50) 
,person_code_chrg_cust  varchar (50) 
,loca_code_sect_chrg_cust  varchar (50) 
,usrgrp_code_chrg_cust  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,loca_code_bill  varchar (50) 
,person_code_chrg_bill  varchar (50) 
,person_name_chrg_cust  varchar (100) 
,shelfno_name_fm  varchar (100) 
,loca_name_shelfno  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,unit_name_case  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,loca_name_custrcvplc  varchar (100) 
,loca_name_cust  varchar (100) 
,loca_name_sect_chrg_bill  varchar (100) 
,usrgrp_name_chrg_bill  varchar (100) 
,unit_name_box  varchar (100) 
,loca_name_bill  varchar (100) 
,loca_name_sect_chrg_cust  varchar (100) 
,unit_name_outbox  varchar (100) 
,usrgrp_name_chrg_cust  varchar (100) 
,person_name_chrg_bill  varchar (100) 
,custdlv_opeitm_id  numeric (38,0)
,id  numeric (38,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,custdlv_cust_id  numeric (38,0)
,custdlv_itm_code_client  varchar (50) 
,custdlv_cno  varchar (40) 
,custdlv_custrcvplc_id  numeric (38,0)
,custdlv_asstwh_id  numeric (38,0)
,custdlv_gno  varchar (40) 
,custdlv_contract_price  varchar (1) 
,custdlv_starttime   timestamp(6) 
,custdlv_chrg_id_cpo  numeric (38,0)
,custdlv_qty  numeric (22,6)
,custdlv_price  numeric (38,4)
,custdlv_expiredate   date 
,custdlv_duedate   timestamp(6) 
,custdlv_amt  numeric (18,4)
,custdlv_isudate   timestamp(6) 
,custdlv_sno  varchar (40) 
,custdlv_remark  varchar (4000) 
,custdlv_update_ip  varchar (40) 
,custdlv_created_at   timestamp(6) 
,custdlv_updated_at   timestamp(6) 
,custdlv_shelfno_id_fm  numeric (22,0)
,cust_bill_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,person_sect_id_chrg_cpo  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,cust_loca_id_cust  numeric (38,0)
,chrg_person_id_chrg_cpo  numeric (38,0)
,cust_chrg_id_cust  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,opeitm_loca_id  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,bill_crr_id_bill  numeric (22,0)
,itm_unit_id  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,bill_chrg_id_bill  numeric (22,0)
,bill_loca_id_bill  numeric (38,0)
,person_sect_id_chrg_cust  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,asstwh_chrg_id_asstwh  numeric (22,0)
,custdlv_person_id_upd  numeric (22,0)
,asstwh_loca_id_asstwh  numeric (22,0)
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
 CREATE INDEX sio_r_custdlvs_uk1 
  ON sio.sio_r_custdlvs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custdlvs_seq ;
 create sequence sio.sio_r_custdlvs_seq ;
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
,person_code_chrg_cpo  varchar (50) 
,person_name_chrg_cpo  varchar (100) 
,loca_code_sect_chrg_cpo  varchar (50) 
,loca_name_sect_chrg_cpo  varchar (100) 
,loca_code_bill  varchar (50) 
,loca_name_bill  varchar (100) 
,person_code_upd  varchar (50) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,boxe_name  varchar (100) 
,boxe_code  varchar (50) 
,crr_code_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,custord_cno_custsch  varchar (50) 
,custord_starttime   timestamp(6) 
,person_name_upd  varchar (100) 
,classlist_code  varchar (50) 
,prjno_name_chil  varchar (100) 
,classlist_name  varchar (100) 
,custord_sno  varchar (40) 
,opeitm_packqty  numeric (38,0)
,shelfno_code_fm  varchar (50) 
,loca_code_custrcvplc  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,custrcvplc_stktaking_proc  varchar (1) 
,shelfno_name_fm  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_custrcvplc  varchar (100) 
,custord_gno  varchar (40) 
,custord_shelfno_id_fm  numeric (22,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,custord_toduedate   timestamp(6) 
,custord_expiredate   date 
,custord_contents  varchar (4000) 
,custord_remark  varchar (4000) 
,custord_custrcvplc_id  numeric (38,0)
,custord_chrg_id_cpo  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,custord_opeitm_id  numeric (38,0)
,custord_prjno_id  numeric (38,0)
,bill_loca_id_bill  numeric (38,0)
,itm_unit_id  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,cust_loca_id_cust  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,cust_chrg_id_cust  numeric (38,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,person_sect_id_chrg_cust  numeric (22,0)
,person_sect_id_chrg_cpo  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,chrg_person_id_chrg_cpo  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,bill_chrg_id_bill  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,custord_cust_id  numeric (22,0)
,custord_update_ip  varchar (40) 
,id  numeric (22,0)
,custord_created_at   timestamp(6) 
,custord_person_id_upd  numeric (22,0)
,custord_id  numeric (22,0)
,custord_updated_at   timestamp(6) 
,cust_bill_id  numeric (22,0)
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
  drop view if  exists r_purdlvs cascade ; 
 create or replace view r_purdlvs as select  
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_std  itm_std ,
  opeitm.itm_code  itm_code ,
  chrg.person_email_chrg  person_email_chrg ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_duration  opeitm_duration ,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  opeitm.opeitm_operation  opeitm_operation ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_level1_chrg  scrlv_level1_chrg ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  opeitm.opeitm_opt_fixoterm  opeitm_opt_fixoterm ,
  opeitm.opeitm_autocreate_ord  opeitm_autocreate_ord ,
  opeitm.opeitm_autocreate_inst  opeitm_autocreate_inst ,
  opeitm.opeitm_prdpurshp  opeitm_prdpurshp ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.opeitm_contents  opeitm_contents ,
  opeitm.opeitm_autocreate_act  opeitm_autocreate_act ,
  opeitm.opeitm_shuffle_flg  opeitm_shuffle_flg ,
  opeitm.opeitm_chkord_proc  opeitm_chkord_proc ,
  prjno.prjno_code  prjno_code ,
  opeitm.opeitm_esttosch  opeitm_esttosch ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  opeitm.opeitm_rule_price  opeitm_rule_price ,
  opeitm.opeitm_mold  opeitm_mold ,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  opeitm.boxe_boxtype  boxe_boxtype ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_opt_fix_flg  opeitm_opt_fix_flg ,
  opeitm.opeitm_prjalloc_flg  opeitm_prjalloc_flg ,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_units_lttime  opeitm_units_lttime ,
  opeitm.opeitm_autoord_p  opeitm_autoord_p ,
  opeitm.opeitm_autoinst_p  opeitm_autoinst_p ,
  opeitm.opeitm_autoact_p  opeitm_autoact_p ,
  supplier.payment_chrg_id_payment  payment_chrg_id_payment ,
  supplier.person_code_chrg_payment  person_code_chrg_payment ,
  supplier.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment ,
  supplier.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment ,
  supplier.person_name_chrg_payment  person_name_chrg_payment ,
  supplier.supplier_payment_id  supplier_payment_id ,
  supplier.supplier_loca_id_supplier  supplier_loca_id_supplier ,
  supplier.supplier_chrg_id_supplier  supplier_chrg_id_supplier ,
  supplier.supplier_crr_id_supplier  supplier_crr_id_supplier ,
  supplier.loca_code_supplier  loca_code_supplier ,
  supplier.loca_name_supplier  loca_name_supplier ,
  supplier.person_code_chrg_supplier  person_code_chrg_supplier ,
  supplier.usrgrp_name_chrg_supplier  usrgrp_name_chrg_supplier ,
  supplier.usrgrp_code_chrg_supplier  usrgrp_code_chrg_supplier ,
  supplier.person_name_chrg_supplier  person_name_chrg_supplier ,
  supplier.crr_name_supplier  crr_name_supplier ,
  supplier.crr_code_supplier  crr_code_supplier ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  supplier.scrlv_code_chrg_supplier  scrlv_code_chrg_supplier ,
  supplier.loca_name_sect_chrg_supplier  loca_name_sect_chrg_supplier ,
  supplier.loca_code_sect_chrg_supplier  loca_code_sect_chrg_supplier ,
  supplier.scrlv_code_chrg_payment  scrlv_code_chrg_payment ,
  supplier.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment ,
  supplier.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
purdlv.qty  purdlv_qty,
purdlv.locas_id_to   purdlv_loca_id_to,
purdlv.qty_case  purdlv_qty_case,
purdlv.gno  purdlv_gno,
  opeitm.opeitm_stktaking_proc  opeitm_stktaking_proc ,
  opeitm.opeitm_acceptance_proc  opeitm_acceptance_proc ,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
purdlv.sno_purinst  purdlv_sno_purinst,
purdlv.cno_purinst  purdlv_cno_purinst,
purdlv.shelfnos_id_to   purdlv_shelfno_id_to,
  prjno.prjno_name_chil  prjno_name_chil 
 from purdlvs   purdlv,
  r_locas  loca_to ,  r_shelfnos  shelfno_to 
  where       purdlv.locas_id_to = loca_to.id      and purdlv.shelfnos_id_to = shelfno_to.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purdlvs;
 CREATE TABLE sio.sio_r_purdlvs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purdlvs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,purdlv_qty  numeric (18,4)
,opeitm_packqty  numeric (38,0)
,purdlv_qty_case  numeric (38,0)
,purdlv_gno  varchar (40) 
,person_code_upd  varchar (50) 
,itm_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,crr_code_supplier  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,person_name_chrg  varchar (100) 
,person_code_chrg  varchar (50) 
,itm_name  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,prjno_name  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,prjno_code  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,loca_code_payment  varchar (50) 
,loca_name_payment  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,person_code_chrg_payment  varchar (50) 
,usrgrp_name_chrg_payment  varchar (100) 
,usrgrp_code_chrg_payment  varchar (50) 
,person_name_chrg_payment  varchar (100) 
,loca_code_supplier  varchar (50) 
,loca_name_supplier  varchar (100) 
,person_code_chrg_supplier  varchar (50) 
,usrgrp_name_chrg_supplier  varchar (100) 
,usrgrp_code_chrg_supplier  varchar (50) 
,person_name_chrg_supplier  varchar (100) 
,crr_name_supplier  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,scrlv_code_chrg_supplier  varchar (50) 
,loca_name_sect_chrg_supplier  varchar (100) 
,loca_code_sect_chrg_supplier  varchar (50) 
,scrlv_code_chrg_payment  varchar (50) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_code_sect_chrg_payment  varchar (50) 
,person_name_upd  varchar (100) 
,prjno_name_chil  varchar (100) 
,opeitm_autoact_p  numeric (3,0)
,opeitm_esttosch  numeric (22,0)
,shelfno_code_to  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_chkord_proc  numeric (3,0)
,opeitm_units_lttime  varchar (4) 
,opeitm_autoord_p  numeric (3,0)
,itm_std  varchar (50) 
,opeitm_stktaking_proc  varchar (1) 
,opeitm_acceptance_proc  varchar (1) 
,opeitm_autoinst_p  numeric (3,0)
,opeitm_contents  varchar (4000) 
,opeitm_shuffle_flg  varchar (1) 
,opeitm_rule_price  varchar (1) 
,opeitm_mold  varchar (1) 
,boxe_boxtype  varchar (20) 
,opeitm_priority  numeric (3,0)
,opeitm_duration  numeric (38,2)
,loca_code_to  varchar (50) 
,person_email_chrg  varchar (50) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_operation  varchar (20) 
,opeitm_processseq  numeric (3,0)
,scrlv_level1_chrg  varchar (1) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_prdpurshp  varchar (20) 
,loca_name_shelfno_to  varchar (100) 
,loca_name_to  varchar (100) 
,shelfno_name_to  varchar (100) 
,purdlv_cno_purinst  varchar (50) 
,purdlv_loca_id_to  numeric (38,0)
,purdlv_sno_purinst  varchar (50) 
,purdlv_shelfno_id_to  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,payment_chrg_id_payment  numeric (22,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,itm_unit_id  numeric (22,0)
,supplier_payment_id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
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
 CREATE INDEX sio_r_purdlvs_uk1 
  ON sio.sio_r_purdlvs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purdlvs_seq ;
 create sequence sio.sio_r_purdlvs_seq ;
  drop view if  exists r_purschs cascade ; 
 create or replace view r_purschs as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
pursch.id id,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
pursch.id  pursch_id,
pursch.remark  pursch_remark,
pursch.expiredate  pursch_expiredate,
pursch.update_ip  pursch_update_ip,
pursch.created_at  pursch_created_at,
pursch.updated_at  pursch_updated_at,
pursch.persons_id_upd   pursch_person_id_upd,
pursch.price  pursch_price,
pursch.sno  pursch_sno,
pursch.duedate  pursch_duedate,
pursch.toduedate  pursch_toduedate,
pursch.isudate  pursch_isudate,
pursch.tax  pursch_tax,
pursch.opeitms_id   pursch_opeitm_id,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
pursch.prjnos_id   pursch_prjno_id,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
pursch.chrgs_id   pursch_chrg_id,
pursch.starttime  pursch_starttime,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  supplier.payment_chrg_id_payment  payment_chrg_id_payment ,
  supplier.person_code_chrg_payment  person_code_chrg_payment ,
  supplier.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment ,
  supplier.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment ,
  supplier.person_name_chrg_payment  person_name_chrg_payment ,
  supplier.supplier_payment_id  supplier_payment_id ,
  supplier.supplier_loca_id_supplier  supplier_loca_id_supplier ,
  supplier.supplier_chrg_id_supplier  supplier_chrg_id_supplier ,
  supplier.supplier_crr_id_supplier  supplier_crr_id_supplier ,
  supplier.loca_code_supplier  loca_code_supplier ,
  supplier.loca_name_supplier  loca_name_supplier ,
  supplier.person_code_chrg_supplier  person_code_chrg_supplier ,
  supplier.usrgrp_name_chrg_supplier  usrgrp_name_chrg_supplier ,
  supplier.usrgrp_code_chrg_supplier  usrgrp_code_chrg_supplier ,
  supplier.person_name_chrg_supplier  person_name_chrg_supplier ,
  supplier.crr_name_supplier  crr_name_supplier ,
  supplier.crr_code_supplier  crr_code_supplier ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  supplier.scrlv_code_chrg_supplier  scrlv_code_chrg_supplier ,
  supplier.loca_name_sect_chrg_supplier  loca_name_sect_chrg_supplier ,
  supplier.loca_code_sect_chrg_supplier  loca_code_sect_chrg_supplier ,
  supplier.scrlv_code_chrg_payment  scrlv_code_chrg_payment ,
  supplier.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment ,
  supplier.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
pursch.suppliers_id   pursch_supplier_id,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
pursch.shelfnos_id_to   pursch_shelfno_id_to,
pursch.qty_sch  pursch_qty_sch,
pursch.crrs_id_pursch   pursch_crr_id_pursch,
  crr_pursch.crr_code  crr_code_pursch ,
  crr_pursch.crr_name  crr_name_pursch ,
pursch.amt_sch  pursch_amt_sch,
  prjno.prjno_name_chil  prjno_name_chil 
 from purschs   pursch,
  r_persons  person_upd ,  r_opeitms  opeitm ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_suppliers  supplier ,  r_shelfnos  shelfno_to ,  r_crrs  crr_pursch 
  where       pursch.persons_id_upd = person_upd.id      and pursch.opeitms_id = opeitm.id      and pursch.prjnos_id = prjno.id      and pursch.chrgs_id = chrg.id      and pursch.suppliers_id = supplier.id      and pursch.shelfnos_id_to = shelfno_to.id      and pursch.crrs_id_pursch = crr_pursch.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purschs;
 CREATE TABLE sio.sio_r_purschs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purschs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,pursch_sno  varchar (40) 
,pursch_duedate   timestamp(6) 
,opeitm_processseq  numeric (3,0)
,person_code_upd  varchar (50) 
,prjno_code_chil  varchar (50) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,loca_name_shelfno_to  varchar (100) 
,loca_code_shelfno_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,shelfno_code_to  varchar (50) 
,loca_code_sect_chrg_payment  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,prjno_name  varchar (100) 
,loca_name_sect_chrg_payment  varchar (100) 
,person_name_chrg  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,scrlv_code_chrg_payment  varchar (50) 
,loca_code_sect_chrg_supplier  varchar (50) 
,person_code_chrg  varchar (50) 
,loca_name_sect_chrg_supplier  varchar (100) 
,scrlv_code_chrg_supplier  varchar (50) 
,crr_code_supplier  varchar (50) 
,crr_name_supplier  varchar (100) 
,person_name_chrg_supplier  varchar (100) 
,itm_name  varchar (100) 
,itm_code  varchar (50) 
,usrgrp_code_chrg_supplier  varchar (50) 
,usrgrp_name_chrg_supplier  varchar (100) 
,unit_code_case  varchar (50) 
,person_code_chrg_supplier  varchar (50) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,loca_name_supplier  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,prjno_code  varchar (50) 
,loca_code_supplier  varchar (50) 
,person_name_chrg_payment  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,loca_code_payment  varchar (50) 
,loca_name_payment  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,usrgrp_name_chrg_payment  varchar (100) 
,usrgrp_code_chrg_payment  varchar (50) 
,person_code_chrg_payment  varchar (50) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,prjno_name_chil  varchar (100) 
,person_name_upd  varchar (100) 
,pursch_expiredate   date 
,pursch_toduedate   timestamp(6) 
,pursch_isudate   timestamp(6) 
,pursch_starttime   timestamp(6) 
,crr_code_pursch  varchar (50) 
,opeitm_packqty  numeric (38,0)
,crr_name_pursch  varchar (100) 
,pursch_qty_sch  numeric (22,6)
,pursch_price  numeric (38,4)
,pursch_amt_sch  numeric (38,4)
,pursch_crr_id_pursch  numeric (22,0)
,pursch_tax  numeric (38,4)
,pursch_remark  varchar (4000) 
,pursch_created_at   timestamp(6) 
,pursch_chrg_id  numeric (38,0)
,pursch_prjno_id  numeric (38,0)
,pursch_opeitm_id  numeric (38,0)
,pursch_person_id_upd  numeric (38,0)
,pursch_updated_at   timestamp(6) 
,pursch_update_ip  varchar (40) 
,pursch_id  numeric (38,0)
,id  numeric (38,0)
,pursch_supplier_id  numeric (22,0)
,pursch_shelfno_id_to  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,supplier_payment_id  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,payment_chrg_id_payment  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
,supplier_crr_id_supplier  numeric (22,0)
,itm_unit_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_loca_id_supplier  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
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
 CREATE INDEX sio_r_purschs_uk1 
  ON sio.sio_r_purschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purschs_seq ;
 create sequence sio.sio_r_purschs_seq ;
  drop view if  exists r_prdreplyinputs cascade ; 
 create or replace view r_prdreplyinputs as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
prdreplyinput.id id,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
prdreplyinput.result_f  prdreplyinput_result_f,
prdreplyinput.qty_case  prdreplyinput_qty_case,
prdreplyinput.update_ip  prdreplyinput_update_ip,
prdreplyinput.duedate  prdreplyinput_duedate,
prdreplyinput.id  prdreplyinput_id,
prdreplyinput.persons_id_upd   prdreplyinput_person_id_upd,
prdreplyinput.contents  prdreplyinput_contents,
prdreplyinput.isudate  prdreplyinput_isudate,
prdreplyinput.opeitms_id   prdreplyinput_opeitm_id,
prdreplyinput.expiredate  prdreplyinput_expiredate,
prdreplyinput.updated_at  prdreplyinput_updated_at,
prdreplyinput.qty  prdreplyinput_qty,
prdreplyinput.remark  prdreplyinput_remark,
prdreplyinput.created_at  prdreplyinput_created_at,
prdreplyinput.locas_id_to   prdreplyinput_loca_id_to,
prdreplyinput.message_code  prdreplyinput_message_code,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
prdreplyinput.sno_prdord  prdreplyinput_sno_prdord,
prdreplyinput.sno_prdinst  prdreplyinput_sno_prdinst,
prdreplyinput.replydate  prdreplyinput_replydate,
prdreplyinput.sno_purord  prdreplyinput_sno_purord,
prdreplyinput.cno  prdreplyinput_cno
 from prdreplyinputs   prdreplyinput,
  r_persons  person_upd ,  r_opeitms  opeitm ,  r_locas  loca_to 
  where       prdreplyinput.persons_id_upd = person_upd.id      and prdreplyinput.opeitms_id = opeitm.id      and prdreplyinput.locas_id_to = loca_to.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdreplyinputs;
 CREATE TABLE sio.sio_r_prdreplyinputs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdreplyinputs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prdreplyinput_result_f  varchar (20) 
,itm_code  varchar (50) 
,boxe_code  varchar (50) 
,person_code_upd  varchar (50) 
,shelfno_code  varchar (50) 
,unit_code  varchar (50) 
,classlist_code  varchar (50) 
,loca_code  varchar (50) 
,boxe_name  varchar (100) 
,itm_name  varchar (100) 
,unit_name  varchar (100) 
,loca_name  varchar (100) 
,shelfno_name  varchar (100) 
,person_name_upd  varchar (100) 
,classlist_name  varchar (100) 
,unit_code_outbox  varchar (50) 
,loca_code_shelfno  varchar (50) 
,unit_code_case  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,loca_code_to  varchar (50) 
,unit_code_box  varchar (50) 
,loca_name_to  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,unit_name_case  varchar (100) 
,loca_name_shelfno  varchar (100) 
,unit_name_box  varchar (100) 
,unit_name_outbox  varchar (100) 
,prdreplyinput_duedate  varchar (0) 
,prdreplyinput_qty  numeric (18,4)
,prdreplyinput_replydate   date 
,prdreplyinput_sno_prdinst  varchar (50) 
,prdreplyinput_sno_prdord  varchar (50) 
,prdreplyinput_qty_case  numeric (22,0)
,prdreplyinput_isudate  varchar (0) 
,prdreplyinput_cno  varchar (40) 
,prdreplyinput_sno_purord  varchar (50) 
,prdreplyinput_expiredate   date 
,prdreplyinput_remark  varchar (4000) 
,prdreplyinput_contents  varchar (4000) 
,prdreplyinput_message_code  varchar (256) 
,opeitm_unit_id_case  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,prdreplyinput_update_ip  varchar (40) 
,id  numeric (22,0)
,prdreplyinput_opeitm_id  numeric (22,0)
,prdreplyinput_person_id_upd  numeric (22,0)
,prdreplyinput_updated_at   timestamp(6) 
,prdreplyinput_id  numeric (22,0)
,prdreplyinput_created_at   timestamp(6) 
,prdreplyinput_loca_id_to  numeric (22,0)
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
 CREATE INDEX sio_r_prdreplyinputs_uk1 
  ON sio.sio_r_prdreplyinputs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdreplyinputs_seq ;
 create sequence sio.sio_r_prdreplyinputs_seq ;
  drop view if  exists r_prdrsltinputs cascade ; 
 create or replace view r_prdrsltinputs as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
prdrsltinput.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
prdrsltinput.cmpldate  prdrsltinput_cmpldate,
prdrsltinput.result_f  prdrsltinput_result_f,
prdrsltinput.qty_case  prdrsltinput_qty_case,
prdrsltinput.id  prdrsltinput_id,
prdrsltinput.remark  prdrsltinput_remark,
prdrsltinput.expiredate  prdrsltinput_expiredate,
prdrsltinput.update_ip  prdrsltinput_update_ip,
prdrsltinput.created_at  prdrsltinput_created_at,
prdrsltinput.updated_at  prdrsltinput_updated_at,
prdrsltinput.persons_id_upd   prdrsltinput_person_id_upd,
prdrsltinput.qty  prdrsltinput_qty,
prdrsltinput.isudate  prdrsltinput_isudate,
prdrsltinput.contents  prdrsltinput_contents,
prdrsltinput.opeitms_id   prdrsltinput_opeitm_id,
prdrsltinput.message_code  prdrsltinput_message_code,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
prdrsltinput.sno_prdinst  prdrsltinput_sno_prdinst,
prdrsltinput.cno  prdrsltinput_cno,
prdrsltinput.sno  prdrsltinput_sno,
prdrsltinput.sno_prdord  prdrsltinput_sno_prdord,
prdrsltinput.price  prdrsltinput_price,
prdrsltinput.amt  prdrsltinput_amt,
prdrsltinput.tax  prdrsltinput_tax,
prdrsltinput.sno_prdreplyinput  prdrsltinput_sno_prdreplyinput
 from prdrsltinputs   prdrsltinput,
  r_persons  person_upd ,  r_opeitms  opeitm 
  where       prdrsltinput.persons_id_upd = person_upd.id      and prdrsltinput.opeitms_id = opeitm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdrsltinputs;
 CREATE TABLE sio.sio_r_prdrsltinputs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdrsltinputs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,classlist_code  varchar (50) 
,loca_code  varchar (50) 
,shelfno_code  varchar (50) 
,boxe_code  varchar (50) 
,person_code_upd  varchar (50) 
,unit_code  varchar (50) 
,prdrsltinput_result_f  varchar (20) 
,prdrsltinput_isudate  varchar (0) 
,classlist_name  varchar (100) 
,itm_name  varchar (100) 
,shelfno_name  varchar (100) 
,unit_name  varchar (100) 
,loca_name  varchar (100) 
,boxe_name  varchar (100) 
,person_name_upd  varchar (100) 
,unit_code_box  varchar (50) 
,unit_code_case  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,unit_code_outbox  varchar (50) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,unit_name_case  varchar (100) 
,unit_name_box  varchar (100) 
,unit_name_outbox  varchar (100) 
,prdrsltinput_amt  numeric (18,4)
,prdrsltinput_cno  varchar (40) 
,prdrsltinput_sno_prdinst  varchar (50) 
,prdrsltinput_sno_prdreplyinput  varchar (50) 
,prdrsltinput_tax  numeric (38,4)
,prdrsltinput_sno  varchar (40) 
,prdrsltinput_sno_prdord  varchar (50) 
,prdrsltinput_price  numeric (38,4)
,prdrsltinput_cmpldate  varchar (0) 
,prdrsltinput_qty  numeric (18,4)
,prdrsltinput_qty_case  numeric (22,0)
,prdrsltinput_expiredate   date 
,prdrsltinput_contents  varchar (4000) 
,prdrsltinput_remark  varchar (4000) 
,prdrsltinput_message_code  varchar (256) 
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_loca_id  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,prdrsltinput_opeitm_id  numeric (22,0)
,prdrsltinput_person_id_upd  numeric (22,0)
,prdrsltinput_updated_at   timestamp(6) 
,prdrsltinput_created_at   timestamp(6) 
,prdrsltinput_update_ip  varchar (40) 
,prdrsltinput_id  numeric (22,0)
,id  numeric (22,0)
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
 CREATE INDEX sio_r_prdrsltinputs_uk1 
  ON sio.sio_r_prdrsltinputs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdrsltinputs_seq ;
 create sequence sio.sio_r_prdrsltinputs_seq ;
  drop view if  exists r_purrsltinputs cascade ; 
 create or replace view r_purrsltinputs as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
purrsltinput.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
purrsltinput.opeitms_id   purrsltinput_opeitm_id,
purrsltinput.result_f  purrsltinput_result_f,
purrsltinput.rcptdate  purrsltinput_rcptdate,
purrsltinput.id  purrsltinput_id,
purrsltinput.remark  purrsltinput_remark,
purrsltinput.expiredate  purrsltinput_expiredate,
purrsltinput.update_ip  purrsltinput_update_ip,
purrsltinput.created_at  purrsltinput_created_at,
purrsltinput.updated_at  purrsltinput_updated_at,
purrsltinput.persons_id_upd   purrsltinput_person_id_upd,
purrsltinput.qty  purrsltinput_qty,
purrsltinput.isudate  purrsltinput_isudate,
purrsltinput.contents  purrsltinput_contents,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
purrsltinput.qty_case  purrsltinput_qty_case,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
purrsltinput.message_code  purrsltinput_message_code,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
purrsltinput.sno_purord  purrsltinput_sno_purord,
purrsltinput.sno_purinst  purrsltinput_sno_purinst,
purrsltinput.cno_purinst  purrsltinput_cno_purinst,
purrsltinput.sno  purrsltinput_sno,
purrsltinput.crrs_id   purrsltinput_crr_id,
purrsltinput.sno_purreplyinput  purrsltinput_sno_purreplyinput
 from purrsltinputs   purrsltinput,
  r_opeitms  opeitm ,  r_persons  person_upd ,  r_crrs  crr 
  where       purrsltinput.opeitms_id = opeitm.id      and purrsltinput.persons_id_upd = person_upd.id      and purrsltinput.crrs_id = crr.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purrsltinputs;
 CREATE TABLE sio.sio_r_purrsltinputs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purrsltinputs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,purrsltinput_result_f  varchar (20) 
,crr_code  varchar (50) 
,shelfno_code  varchar (50) 
,person_code_upd  varchar (50) 
,itm_code  varchar (50) 
,unit_code  varchar (50) 
,loca_code  varchar (50) 
,classlist_code  varchar (50) 
,boxe_code  varchar (50) 
,shelfno_name  varchar (100) 
,itm_name  varchar (100) 
,unit_name  varchar (100) 
,loca_name  varchar (100) 
,person_name_upd  varchar (100) 
,classlist_name  varchar (100) 
,boxe_name  varchar (100) 
,crr_name  varchar (100) 
,purrsltinput_qty  numeric (18,4)
,loca_code_shelfno  varchar (50) 
,unit_code_case  varchar (50) 
,unit_code_outbox  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,unit_code_box  varchar (50) 
,purrsltinput_qty_case  numeric (22,0)
,loca_name_shelfno  varchar (100) 
,unit_name_case  varchar (100) 
,unit_name_box  varchar (100) 
,unit_name_outbox  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,purrsltinput_sno_purinst  varchar (50) 
,purrsltinput_sno  varchar (40) 
,purrsltinput_crr_id  numeric (22,0)
,purrsltinput_sno_purord  varchar (50) 
,purrsltinput_sno_purreplyinput  varchar (50) 
,purrsltinput_cno_purinst  varchar (50) 
,purrsltinput_rcptdate   date 
,purrsltinput_message_code  varchar (256) 
,purrsltinput_contents  varchar (4000) 
,purrsltinput_remark  varchar (4000) 
,purrsltinput_expiredate   date 
,purrsltinput_isudate   timestamp(6) 
,opeitm_boxe_id  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,itm_unit_id  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,purrsltinput_created_at   timestamp(6) 
,purrsltinput_update_ip  varchar (40) 
,purrsltinput_id  numeric (22,0)
,id  numeric (22,0)
,purrsltinput_person_id_upd  numeric (22,0)
,purrsltinput_opeitm_id  numeric (22,0)
,purrsltinput_updated_at   timestamp(6) 
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
 CREATE INDEX sio_r_purrsltinputs_uk1 
  ON sio.sio_r_purrsltinputs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purrsltinputs_seq ;
 create sequence sio.sio_r_purrsltinputs_seq ;
  drop view if  exists r_purreplyinputs cascade ; 
 create or replace view r_purreplyinputs as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
purreplyinput.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
purreplyinput.cno  purreplyinput_cno,
purreplyinput.id  purreplyinput_id,
purreplyinput.remark  purreplyinput_remark,
purreplyinput.expiredate  purreplyinput_expiredate,
purreplyinput.update_ip  purreplyinput_update_ip,
purreplyinput.created_at  purreplyinput_created_at,
purreplyinput.updated_at  purreplyinput_updated_at,
purreplyinput.persons_id_upd   purreplyinput_person_id_upd,
purreplyinput.qty  purreplyinput_qty,
purreplyinput.duedate  purreplyinput_duedate,
purreplyinput.isudate  purreplyinput_isudate,
purreplyinput.contents  purreplyinput_contents,
purreplyinput.opeitms_id   purreplyinput_opeitm_id,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
purreplyinput.qty_case  purreplyinput_qty_case,
purreplyinput.message_code  purreplyinput_message_code,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
purreplyinput.sno  purreplyinput_sno,
purreplyinput.replydate  purreplyinput_replydate,
purreplyinput.sno_purinst  purreplyinput_sno_purinst
 from purreplyinputs   purreplyinput,
  r_persons  person_upd ,  r_opeitms  opeitm 
  where       purreplyinput.persons_id_upd = person_upd.id      and purreplyinput.opeitms_id = opeitm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purreplyinputs;
 CREATE TABLE sio.sio_r_purreplyinputs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purreplyinputs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,purreplyinput_isudate  varchar (0) 
,boxe_code  varchar (50) 
,person_code_upd  varchar (50) 
,shelfno_code  varchar (50) 
,itm_code  varchar (50) 
,unit_code  varchar (50) 
,classlist_code  varchar (50) 
,loca_code  varchar (50) 
,classlist_name  varchar (100) 
,unit_name  varchar (100) 
,loca_name  varchar (100) 
,itm_name  varchar (100) 
,boxe_name  varchar (100) 
,person_name_upd  varchar (100) 
,shelfno_name  varchar (100) 
,unit_code_box  varchar (50) 
,loca_code_shelfno  varchar (50) 
,unit_code_outbox  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,unit_code_case  varchar (50) 
,unit_name_box  varchar (100) 
,unit_name_case  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,unit_name_outbox  varchar (100) 
,loca_name_shelfno  varchar (100) 
,purreplyinput_duedate   date 
,purreplyinput_sno_purinst  varchar (50) 
,purreplyinput_replydate   date 
,purreplyinput_sno  varchar (40) 
,purreplyinput_cno  varchar (40) 
,purreplyinput_qty  numeric (18,4)
,purreplyinput_qty_case  numeric (22,0)
,purreplyinput_contents  varchar (4000) 
,purreplyinput_remark  varchar (4000) 
,purreplyinput_message_code  varchar (256) 
,purreplyinput_updated_at   timestamp 
,purreplyinput_created_at   timestamp 
,purreplyinput_expiredate   date 
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,purreplyinput_id  numeric (22,0)
,purreplyinput_person_id_upd  numeric (22,0)
,purreplyinput_opeitm_id  numeric (22,0)
,purreplyinput_update_ip  varchar (40) 
,id  numeric (22,0)
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
 CREATE INDEX sio_r_purreplyinputs_uk1 
  ON sio.sio_r_purreplyinputs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purreplyinputs_seq ;
 create sequence sio.sio_r_purreplyinputs_seq ;
  drop view if  exists r_prdacts cascade ; 
 create or replace view r_prdacts as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
prdact.id id,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
prdact.remark  prdact_remark,
prdact.created_at  prdact_created_at,
prdact.update_ip  prdact_update_ip,
prdact.id  prdact_id,
prdact.persons_id_upd   prdact_person_id_upd,
prdact.contents  prdact_contents,
prdact.cmpldate  prdact_cmpldate,
prdact.chrgs_id   prdact_chrg_id,
prdact.isudate  prdact_isudate,
prdact.prjnos_id   prdact_prjno_id,
prdact.opeitms_id   prdact_opeitm_id,
prdact.expiredate  prdact_expiredate,
prdact.updated_at  prdact_updated_at,
prdact.sno  prdact_sno,
prdact.cno  prdact_cno,
prdact.gno  prdact_gno,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
prdact.lotno  prdact_lotno,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  workplace.workplace_loca_id_workplace  workplace_loca_id_workplace ,
  workplace.loca_code_workplace  loca_code_workplace ,
  workplace.loca_name_workplace  loca_name_workplace ,
prdact.shelfnos_id_to   prdact_shelfno_id_to,
prdact.qty_stk  prdact_qty_stk,
prdact.sno_prdord  prdact_sno_prdord,
prdact.sno_prdinst  prdact_sno_prdinst,
prdact.cno_prdinst  prdact_cno_prdinst,
  workplace.workplace_chrg_id_workplace  workplace_chrg_id_workplace ,
  workplace.scrlv_code_chrg_workplace  scrlv_code_chrg_workplace ,
  workplace.loca_code_sect_chrg_workplace  loca_code_sect_chrg_workplace ,
  workplace.loca_name_sect_chrg_workplace  loca_name_sect_chrg_workplace ,
  workplace.person_code_chrg_workplace  person_code_chrg_workplace ,
  workplace.person_name_chrg_workplace  person_name_chrg_workplace ,
  workplace.usrgrp_name_chrg_workplace  usrgrp_name_chrg_workplace ,
  workplace.person_sect_id_chrg_workplace  person_sect_id_chrg_workplace ,
  workplace.usrgrp_code_chrg_workplace  usrgrp_code_chrg_workplace ,
  workplace.chrg_person_id_chrg_workplace  chrg_person_id_chrg_workplace ,
prdact.workplaces_id   prdact_workplace_id,
prdact.packno  prdact_packno,
  prjno.prjno_name_chil  prjno_name_chil 
 from prdacts   prdact,
  r_persons  person_upd ,  r_chrgs  chrg ,  r_prjnos  prjno ,  r_opeitms  opeitm ,  r_shelfnos  shelfno_to ,  r_workplaces  workplace 
  where       prdact.persons_id_upd = person_upd.id      and prdact.chrgs_id = chrg.id      and prdact.prjnos_id = prjno.id      and prdact.opeitms_id = opeitm.id      and prdact.shelfnos_id_to = shelfno_to.id      and prdact.workplaces_id = workplace.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdacts;
 CREATE TABLE sio.sio_r_prdacts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdacts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prdact_sno_prdord  varchar (50) 
,prdact_isudate   timestamp(6) 
,loca_code_workplace  varchar (50) 
,loca_name_workplace  varchar (100) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,prdact_qty_stk  numeric (22,6)
,opeitm_packqty  numeric (38,0)
,prdact_cmpldate   timestamp(6) 
,loca_code_shelfno_to  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,prdact_cno  varchar (40) 
,person_code_upd  varchar (50) 
,prdact_sno  varchar (40) 
,prdact_gno  varchar (40) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,prjno_code  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,scrlv_code_chrg_workplace  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,person_name_chrg  varchar (100) 
,person_code_chrg  varchar (50) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,prjno_name  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,loca_code_sect_chrg_workplace  varchar (50) 
,loca_name_sect_chrg_workplace  varchar (100) 
,person_code_chrg_workplace  varchar (50) 
,person_name_chrg_workplace  varchar (100) 
,usrgrp_name_chrg_workplace  varchar (100) 
,usrgrp_code_chrg_workplace  varchar (50) 
,prdact_lotno  varchar (50) 
,prdact_cno_prdinst  varchar (50) 
,person_name_upd  varchar (100) 
,prjno_name_chil  varchar (100) 
,prdact_sno_prdinst  varchar (50) 
,prdact_expiredate   date 
,opeitm_processseq  numeric (3,0)
,prdact_packno  varchar (10) 
,prdact_contents  varchar (4000) 
,prdact_remark  varchar (4000) 
,prdact_shelfno_id_to  numeric (38,0)
,prdact_workplace_id  numeric (22,0)
,prdact_created_at   timestamp(6) 
,prdact_update_ip  varchar (40) 
,prdact_id  numeric (38,0)
,prdact_person_id_upd  numeric (38,0)
,prdact_chrg_id  numeric (38,0)
,prdact_prjno_id  numeric (38,0)
,prdact_opeitm_id  numeric (38,0)
,prdact_updated_at   timestamp(6) 
,id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,workplace_chrg_id_workplace  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,person_sect_id_chrg_workplace  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,chrg_person_id_chrg_workplace  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,workplace_loca_id_workplace  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
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
 CREATE INDEX sio_r_prdacts_uk1 
  ON sio.sio_r_prdacts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdacts_seq ;
 create sequence sio.sio_r_prdacts_seq ;
  drop view if  exists r_purrets cascade ; 
 create or replace view r_purrets as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
purret.id id,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
purret.qty_case  purret_qty_case,
purret.contract_price  purret_contract_price,
purret.chrgs_id   purret_chrg_id,
purret.id  purret_id,
purret.remark  purret_remark,
purret.expiredate  purret_expiredate,
purret.update_ip  purret_update_ip,
purret.created_at  purret_created_at,
purret.updated_at  purret_updated_at,
purret.persons_id_upd   purret_person_id_upd,
purret.qty  purret_qty,
purret.price  purret_price,
purret.amt  purret_amt,
purret.isudate  purret_isudate,
purret.contents  purret_contents,
purret.tax  purret_tax,
purret.prjnos_id   purret_prjno_id,
purret.opeitms_id   purret_opeitm_id,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
purret.retdate  purret_retdate,
purret.locas_id_fm   purret_loca_id_fm,
  loca_fm.loca_code  loca_code_fm ,
  loca_fm.loca_name  loca_name_fm ,
purret.sno  purret_sno,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  supplier.payment_chrg_id_payment  payment_chrg_id_payment ,
  supplier.person_code_chrg_payment  person_code_chrg_payment ,
  supplier.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment ,
  supplier.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment ,
  supplier.person_name_chrg_payment  person_name_chrg_payment ,
  supplier.supplier_payment_id  supplier_payment_id ,
  supplier.supplier_loca_id_supplier  supplier_loca_id_supplier ,
  supplier.supplier_chrg_id_supplier  supplier_chrg_id_supplier ,
  supplier.supplier_crr_id_supplier  supplier_crr_id_supplier ,
  supplier.loca_code_supplier  loca_code_supplier ,
  supplier.loca_name_supplier  loca_name_supplier ,
  supplier.person_code_chrg_supplier  person_code_chrg_supplier ,
  supplier.usrgrp_name_chrg_supplier  usrgrp_name_chrg_supplier ,
  supplier.usrgrp_code_chrg_supplier  usrgrp_code_chrg_supplier ,
  supplier.person_name_chrg_supplier  person_name_chrg_supplier ,
  supplier.crr_name_supplier  crr_name_supplier ,
  supplier.crr_code_supplier  crr_code_supplier ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  supplier.scrlv_code_chrg_supplier  scrlv_code_chrg_supplier ,
  supplier.loca_name_sect_chrg_supplier  loca_name_sect_chrg_supplier ,
  supplier.loca_code_sect_chrg_supplier  loca_code_sect_chrg_supplier ,
  supplier.scrlv_code_chrg_payment  scrlv_code_chrg_payment ,
  supplier.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment ,
  supplier.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
purret.suppliers_id   purret_supplier_id,
purret.crrs_id   purret_crr_id,
  prjno.prjno_name_chil  prjno_name_chil ,
purret.sno_puract  purret_sno_puract
 from purrets   purret,
  r_chrgs  chrg ,  r_persons  person_upd ,  r_prjnos  prjno ,  r_opeitms  opeitm ,  r_locas  loca_fm ,  r_suppliers  supplier ,  r_crrs  crr 
  where       purret.chrgs_id = chrg.id      and purret.persons_id_upd = person_upd.id      and purret.prjnos_id = prjno.id      and purret.opeitms_id = opeitm.id      and purret.locas_id_fm = loca_fm.id      and purret.suppliers_id = supplier.id      and purret.crrs_id = crr.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purrets;
 CREATE TABLE sio.sio_r_purrets (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purrets_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,shelfno_code  varchar (50) 
,crr_code  varchar (50) 
,person_code_upd  varchar (50) 
,unit_code  varchar (50) 
,itm_code  varchar (50) 
,loca_code  varchar (50) 
,classlist_code  varchar (50) 
,boxe_code  varchar (50) 
,prjno_code_chil  varchar (50) 
,prjno_code  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,person_code_chrg  varchar (50) 
,shelfno_name  varchar (100) 
,boxe_name  varchar (100) 
,unit_name  varchar (100) 
,loca_name  varchar (100) 
,prjno_name_chil  varchar (100) 
,crr_name  varchar (100) 
,classlist_name  varchar (100) 
,prjno_name  varchar (100) 
,person_name_upd  varchar (100) 
,itm_name  varchar (100) 
,scrlv_code_chrg_payment  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,loca_code_sect_chrg_payment  varchar (50) 
,loca_code_sect_chrg_supplier  varchar (50) 
,unit_code_case  varchar (50) 
,scrlv_code_chrg_supplier  varchar (50) 
,loca_code_shelfno  varchar (50) 
,crr_code_supplier  varchar (50) 
,usrgrp_code_chrg_supplier  varchar (50) 
,person_code_chrg_supplier  varchar (50) 
,loca_code_supplier  varchar (50) 
,usrgrp_code_chrg_payment  varchar (50) 
,person_code_chrg_payment  varchar (50) 
,loca_code_fm  varchar (50) 
,loca_code_payment  varchar (50) 
,unit_code_outbox  varchar (50) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,usrgrp_name_chrg_payment  varchar (100) 
,unit_name_outbox  varchar (100) 
,unit_name_case  varchar (100) 
,person_name_chrg_payment  varchar (100) 
,loca_name_fm  varchar (100) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_name_shelfno  varchar (100) 
,loca_name_sect_chrg_supplier  varchar (100) 
,crr_name_supplier  varchar (100) 
,person_name_chrg_supplier  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,usrgrp_name_chrg_supplier  varchar (100) 
,loca_name_payment  varchar (100) 
,loca_name_supplier  varchar (100) 
,purret_qty_case  numeric (22,0)
,purret_contract_price  varchar (1) 
,purret_sno_puract  varchar (50) 
,purret_loca_id_fm  numeric (38,0)
,purret_supplier_id  numeric (22,0)
,purret_crr_id  numeric (22,0)
,purret_retdate   date 
,purret_remark  varchar (4000) 
,purret_expiredate   date 
,purret_qty  numeric (18,4)
,purret_price  numeric (22,0)
,purret_amt  numeric (18,4)
,purret_sno  varchar (40) 
,purret_isudate   timestamp(6) 
,purret_contents  varchar (4000) 
,purret_tax  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,supplier_payment_id  numeric (38,0)
,supplier_loca_id_supplier  numeric (22,0)
,payment_loca_id_payment  numeric (38,0)
,payment_chrg_id_payment  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,itm_unit_id  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,purret_prjno_id  numeric (22,0)
,purret_chrg_id  numeric (22,0)
,purret_id  numeric (22,0)
,purret_opeitm_id  numeric (22,0)
,purret_update_ip  varchar (40) 
,purret_created_at   timestamp(6) 
,purret_updated_at   timestamp(6) 
,id  numeric (38,0)
,purret_person_id_upd  numeric (22,0)
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
 CREATE INDEX sio_r_purrets_uk1 
  ON sio.sio_r_purrets(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purrets_seq ;
 create sequence sio.sio_r_purrets_seq ;
  drop view if  exists r_custschs cascade ; 
 create or replace view r_custschs as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  cust.loca_name_cust  loca_name_cust ,
  cust.loca_code_cust  loca_code_cust ,
  opeitm.opeitm_duration  opeitm_duration ,
custsch.id id,
  cust.cust_loca_id_cust  cust_loca_id_cust ,
  prjno.prjno_name  prjno_name ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  prjno.prjno_code  prjno_code ,
custsch.cno  custsch_cno,
custsch.isudate  custsch_isudate,
custsch.prjnos_id   custsch_prjno_id,
custsch.expiredate  custsch_expiredate,
custsch.updated_at  custsch_updated_at,
custsch.sno  custsch_sno,
custsch.price  custsch_price,
custsch.remark  custsch_remark,
custsch.created_at  custsch_created_at,
custsch.update_ip  custsch_update_ip,
custsch.duedate  custsch_duedate,
custsch.id  custsch_id,
custsch.persons_id_upd   custsch_person_id_upd,
custsch.contents  custsch_contents,
custsch.custs_id   custsch_cust_id,
  cust.cust_contract_price  cust_contract_price ,
custsch.contract_price  custsch_contract_price,
  cust.scrlv_code_chrg_cust  scrlv_code_chrg_cust ,
  cust.cust_chrg_id_cust  cust_chrg_id_cust ,
  cust.chrg_person_id_chrg_cust  chrg_person_id_chrg_cust ,
  cust.person_code_chrg_cust  person_code_chrg_cust ,
  cust.person_name_chrg_cust  person_name_chrg_cust ,
  cust.person_sect_id_chrg_cust  person_sect_id_chrg_cust ,
  cust.loca_code_sect_chrg_cust  loca_code_sect_chrg_cust ,
  cust.loca_name_sect_chrg_cust  loca_name_sect_chrg_cust ,
  cust.usrgrp_code_chrg_cust  usrgrp_code_chrg_cust ,
  cust.usrgrp_name_chrg_cust  usrgrp_name_chrg_cust ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  cust.bill_loca_id_bill  bill_loca_id_bill ,
  cust.loca_code_bill  loca_code_bill ,
  cust.loca_name_bill  loca_name_bill ,
  cust.cust_bill_id  cust_bill_id ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  cust.bill_chrg_id_bill  bill_chrg_id_bill ,
  cust.person_code_chrg_bill  person_code_chrg_bill ,
  cust.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  cust.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  cust.person_name_chrg_bill  person_name_chrg_bill ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
custsch.opeitms_id   custsch_opeitm_id,
  cust.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  cust.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  cust.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  cust.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  cust.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  cust.bill_crr_id_bill  bill_crr_id_bill ,
  cust.crr_code_bill  crr_code_bill ,
  cust.crr_name_bill  crr_name_bill ,
custsch.starttime  custsch_starttime,
custsch.qty_sch  custsch_qty_sch,
custsch.shelfnos_id_fm   custsch_shelfno_id_fm,
custsch.amt_sch  custsch_amt_sch,
  prjno.prjno_name_chil  prjno_name_chil 
 from custschs   custsch,
  r_prjnos  prjno ,  r_persons  person_upd ,  r_custs  cust ,  r_opeitms  opeitm ,  r_shelfnos  shelfno_fm 
  where       custsch.prjnos_id = prjno.id      and custsch.persons_id_upd = person_upd.id      and custsch.custs_id = cust.id      and custsch.opeitms_id = opeitm.id      and custsch.shelfnos_id_fm = shelfno_fm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custschs;
 CREATE TABLE sio.sio_r_custschs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custschs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,custsch_isudate   timestamp(6) 
,custsch_cno  varchar (40) 
,itm_code  varchar (50) 
,opeitm_processseq  numeric (3,0)
,itm_name  varchar (100) 
,loca_code_cust  varchar (50) 
,loca_name_cust  varchar (100) 
,custsch_duedate   timestamp(6) 
,custsch_price  numeric (38,4)
,cust_contract_price  varchar (1) 
,custsch_contract_price  varchar (1) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,person_code_chrg_cust  varchar (50) 
,person_code_upd  varchar (50) 
,person_name_chrg_cust  varchar (100) 
,scrlv_code_chrg_cust  varchar (50) 
,loca_code_sect_chrg_cust  varchar (50) 
,usrgrp_code_chrg_cust  varchar (50) 
,usrgrp_name_chrg_cust  varchar (100) 
,loca_name_sect_chrg_cust  varchar (100) 
,person_code_chrg_bill  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,usrgrp_code_chrg_bill  varchar (50) 
,usrgrp_name_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,loca_name  varchar (100) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,crr_name_bill  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,crr_code_bill  varchar (50) 
,loca_code  varchar (50) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,loca_code_bill  varchar (50) 
,loca_name_bill  varchar (100) 
,person_name_upd  varchar (100) 
,prjno_name_chil  varchar (100) 
,custsch_expiredate   date 
,shelfno_code_fm  varchar (50) 
,opeitm_duration  numeric (38,2)
,opeitm_packqty  numeric (38,0)
,loca_code_shelfno_fm  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,shelfno_name_fm  varchar (100) 
,custsch_amt_sch  numeric (38,4)
,custsch_starttime   timestamp(6) 
,custsch_sno  varchar (40) 
,custsch_shelfno_id_fm  numeric (22,0)
,custsch_qty_sch  numeric (22,6)
,custsch_contents  varchar (4000) 
,custsch_remark  varchar (4000) 
,custsch_update_ip  varchar (40) 
,id  numeric (38,0)
,custsch_prjno_id  numeric (38,0)
,custsch_updated_at   timestamp(6) 
,custsch_created_at   timestamp(6) 
,custsch_id  numeric (38,0)
,custsch_person_id_upd  numeric (38,0)
,custsch_cust_id  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,custsch_opeitm_id  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,boxe_unit_id_outbox  numeric (22,0)
,boxe_unit_id_box  numeric (22,0)
,cust_bill_id  numeric (38,0)
,bill_loca_id_bill  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,person_sect_id_chrg_cust  numeric (22,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,cust_chrg_id_cust  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,cust_loca_id_cust  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,bill_chrg_id_bill  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
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
 CREATE INDEX sio_r_custschs_uk1 
  ON sio.sio_r_custschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custschs_seq ;
 create sequence sio.sio_r_custschs_seq ;
  drop view if  exists r_prdinsts cascade ; 
 create or replace view r_prdinsts as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
prdinst.id id,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
prdinst.prjnos_id   prdinst_prjno_id,
prdinst.cno  prdinst_cno,
prdinst.opeitms_id   prdinst_opeitm_id,
prdinst.contents  prdinst_contents,
prdinst.id  prdinst_id,
prdinst.remark  prdinst_remark,
prdinst.expiredate  prdinst_expiredate,
prdinst.update_ip  prdinst_update_ip,
prdinst.created_at  prdinst_created_at,
prdinst.updated_at  prdinst_updated_at,
prdinst.persons_id_upd   prdinst_person_id_upd,
prdinst.qty  prdinst_qty,
prdinst.sno  prdinst_sno,
prdinst.duedate  prdinst_duedate,
prdinst.isudate  prdinst_isudate,
prdinst.locas_id_to   prdinst_loca_id_to,
prdinst.qty_case  prdinst_qty_case,
prdinst.commencementdate  prdinst_commencementdate,
prdinst.commencement_f  prdinst_commencement_f,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
prdinst.chrgs_id   prdinst_chrg_id,
prdinst.gno  prdinst_gno,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
prdinst.starttime  prdinst_starttime,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  workplace.workplace_loca_id_workplace  workplace_loca_id_workplace ,
  workplace.loca_code_workplace  loca_code_workplace ,
  workplace.loca_name_workplace  loca_name_workplace ,
  workplace.workplace_chrg_id_workplace  workplace_chrg_id_workplace ,
  workplace.scrlv_code_chrg_workplace  scrlv_code_chrg_workplace ,
  workplace.loca_code_sect_chrg_workplace  loca_code_sect_chrg_workplace ,
  workplace.loca_name_sect_chrg_workplace  loca_name_sect_chrg_workplace ,
  workplace.person_code_chrg_workplace  person_code_chrg_workplace ,
  workplace.person_name_chrg_workplace  person_name_chrg_workplace ,
  workplace.usrgrp_name_chrg_workplace  usrgrp_name_chrg_workplace ,
  workplace.person_sect_id_chrg_workplace  person_sect_id_chrg_workplace ,
  workplace.usrgrp_code_chrg_workplace  usrgrp_code_chrg_workplace ,
  workplace.chrg_person_id_chrg_workplace  chrg_person_id_chrg_workplace ,
prdinst.sno_prdord  prdinst_sno_prdord,
prdinst.shelfnos_id_to   prdinst_shelfno_id_to,
prdinst.workplaces_id   prdinst_workplace_id,
  prjno.prjno_name_chil  prjno_name_chil 
 from prdinsts   prdinst,
  r_prjnos  prjno ,  r_opeitms  opeitm ,  r_persons  person_upd ,  r_locas  loca_to ,  r_chrgs  chrg ,  r_shelfnos  shelfno_to ,  r_workplaces  workplace 
  where       prdinst.prjnos_id = prjno.id      and prdinst.opeitms_id = opeitm.id      and prdinst.persons_id_upd = person_upd.id      and prdinst.locas_id_to = loca_to.id      and prdinst.chrgs_id = chrg.id      and prdinst.shelfnos_id_to = shelfno_to.id      and prdinst.workplaces_id = workplace.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdinsts;
 CREATE TABLE sio.sio_r_prdinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prdinst_sno  varchar (40) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,loca_name  varchar (100) 
,prdinst_isudate   timestamp(6) 
,loca_code_to  varchar (50) 
,prdinst_duedate   timestamp(6) 
,prdinst_qty  numeric (18,4)
,prdinst_qty_case  numeric (38,0)
,person_name_chrg  varchar (100) 
,person_code_upd  varchar (50) 
,loca_name_to  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,prjno_name  varchar (100) 
,person_name_chrg_workplace  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,person_code_chrg_workplace  varchar (50) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,loca_name_sect_chrg_workplace  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,prjno_code  varchar (50) 
,loca_code_sect_chrg_workplace  varchar (50) 
,scrlv_code_chrg_workplace  varchar (50) 
,loca_name_workplace  varchar (100) 
,loca_code_workplace  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,loca_code_shelfno_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,shelfno_code_to  varchar (50) 
,prjno_code_chil  varchar (50) 
,unit_code_outbox  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_box  varchar (50) 
,person_code_chrg  varchar (50) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,loca_code  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,usrgrp_code_chrg_workplace  varchar (50) 
,usrgrp_name_chrg_workplace  varchar (100) 
,boxe_name  varchar (100) 
,boxe_code  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,unit_name_outbox  varchar (100) 
,prdinst_starttime   timestamp(6) 
,prdinst_expiredate   date 
,person_name_upd  varchar (100) 
,prdinst_sno_prdord  varchar (50) 
,prdinst_commencement_f  varchar (1) 
,prjno_name_chil  varchar (100) 
,prdinst_commencementdate   timestamp(6) 
,prdinst_cno  varchar (40) 
,opeitm_processseq  numeric (3,0)
,opeitm_packqty  numeric (38,0)
,prdinst_gno  varchar (40) 
,prdinst_remark  varchar (4000) 
,prdinst_contents  varchar (4000) 
,prdinst_loca_id_to  numeric (38,0)
,prdinst_created_at   timestamp(6) 
,prdinst_update_ip  varchar (40) 
,prdinst_opeitm_id  numeric (38,0)
,prdinst_id  numeric (38,0)
,prdinst_chrg_id  numeric (38,0)
,prdinst_person_id_upd  numeric (38,0)
,prdinst_shelfno_id_to  numeric (38,0)
,prdinst_workplace_id  numeric (22,0)
,id  numeric (38,0)
,prdinst_updated_at   timestamp(6) 
,prdinst_prjno_id  numeric (38,0)
,chrg_person_id_chrg_workplace  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,itm_unit_id  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,workplace_loca_id_workplace  numeric (22,0)
,workplace_chrg_id_workplace  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,person_sect_id_chrg_workplace  numeric (22,0)
,opeitm_loca_id  numeric (38,0)
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
 CREATE INDEX sio_r_prdinsts_uk1 
  ON sio.sio_r_prdinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdinsts_seq ;
 create sequence sio.sio_r_prdinsts_seq ;
  drop view if  exists r_puracts cascade ; 
 create or replace view r_puracts as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
puract.id id,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
puract.opeitms_id   puract_opeitm_id,
puract.id  puract_id,
puract.remark  puract_remark,
puract.expiredate  puract_expiredate,
puract.update_ip  puract_update_ip,
puract.created_at  puract_created_at,
puract.updated_at  puract_updated_at,
puract.persons_id_upd   puract_person_id_upd,
puract.isudate  puract_isudate,
puract.contents  puract_contents,
puract.rcptdate  puract_rcptdate,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
puract.chrgs_id   puract_chrg_id,
puract.prjnos_id   puract_prjno_id,
puract.sno  puract_sno,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
puract.cno  puract_cno,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
puract.lotno  puract_lotno,
puract.itm_code_client  puract_itm_code_client,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  supplier.payment_chrg_id_payment  payment_chrg_id_payment ,
  supplier.person_code_chrg_payment  person_code_chrg_payment ,
  supplier.person_name_chrg_payment  person_name_chrg_payment ,
  supplier.supplier_payment_id  supplier_payment_id ,
  supplier.supplier_loca_id_supplier  supplier_loca_id_supplier ,
  supplier.supplier_chrg_id_supplier  supplier_chrg_id_supplier ,
  supplier.supplier_crr_id_supplier  supplier_crr_id_supplier ,
  supplier.loca_code_supplier  loca_code_supplier ,
  supplier.loca_name_supplier  loca_name_supplier ,
  supplier.person_code_chrg_supplier  person_code_chrg_supplier ,
  supplier.person_name_chrg_supplier  person_name_chrg_supplier ,
  supplier.crr_name_supplier  crr_name_supplier ,
  supplier.crr_code_supplier  crr_code_supplier ,
  crr_pur.crr_name  crr_name_pur ,
  crr_pur.crr_code  crr_code_pur ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
  opeitm.opeitm_stktaking_proc  opeitm_stktaking_proc ,
  opeitm.opeitm_acceptance_proc  opeitm_acceptance_proc ,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
puract.suppliers_id   puract_supplier_id,
puract.sno_purinst  puract_sno_purinst,
puract.sno_purord  puract_sno_purord,
puract.sno_purdlv  puract_sno_purdlv,
puract.cno_purinst  puract_cno_purinst,
puract.cno_purdlv  puract_cno_purdlv,
puract.qty_stk  puract_qty_stk,
puract.crrs_id_pur   puract_crr_id_pur,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
puract.shelfnos_id_to   puract_shelfno_id_to,
puract.packno  puract_packno,
puract.crrs_id   puract_crr_id,
  prjno.prjno_name_chil  prjno_name_chil 
 from puracts   puract,
  r_opeitms  opeitm ,  r_persons  person_upd ,  r_chrgs  chrg ,  r_prjnos  prjno ,  r_suppliers  supplier ,  r_crrs  crr_pur ,  r_shelfnos  shelfno_to ,  r_crrs  crr 
  where       puract.opeitms_id = opeitm.id      and puract.persons_id_upd = person_upd.id      and puract.chrgs_id = chrg.id      and puract.prjnos_id = prjno.id      and puract.suppliers_id = supplier.id      and puract.crrs_id_pur = crr_pur.id      and puract.shelfnos_id_to = shelfno_to.id      and puract.crrs_id = crr.id     ;
 DROP TABLE IF EXISTS sio.sio_r_puracts;
 CREATE TABLE sio.sio_r_puracts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_puracts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,puract_sno_purord  varchar (50) 
,puract_isudate   timestamp(6) 
,puract_rcptdate   timestamp(6) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,puract_itm_code_client  varchar (50) 
,puract_qty_stk  numeric (38,4)
,opeitm_packqty  numeric (38,0)
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,crr_code_supplier  varchar (50) 
,crr_name_supplier  varchar (100) 
,crr_code_pur  varchar (50) 
,crr_name_pur  varchar (100) 
,loca_name_shelfno  varchar (100) 
,loca_code_shelfno  varchar (50) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,crr_code  varchar (50) 
,person_code_upd  varchar (50) 
,loca_code_supplier  varchar (50) 
,loca_name_supplier  varchar (100) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,person_code_chrg_supplier  varchar (50) 
,person_name_chrg_supplier  varchar (100) 
,person_code_chrg_payment  varchar (50) 
,person_name_chrg_payment  varchar (100) 
,classlist_name  varchar (100) 
,prjno_name  varchar (100) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,loca_code_shelfno_to  varchar (50) 
,prjno_code_chil  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,loca_code_payment  varchar (50) 
,prjno_code  varchar (50) 
,classlist_code  varchar (50) 
,loca_name_payment  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,prjno_name_chil  varchar (100) 
,person_name_upd  varchar (100) 
,puract_expiredate   date 
,crr_name  varchar (100) 
,puract_lotno  varchar (50) 
,puract_cno_purinst  varchar (50) 
,puract_cno_purdlv  varchar (50) 
,opeitm_stktaking_proc  varchar (1) 
,opeitm_processseq  numeric (3,0)
,opeitm_acceptance_proc  varchar (1) 
,puract_sno_purdlv  varchar (50) 
,puract_sno_purinst  varchar (50) 
,puract_packno  varchar (10) 
,puract_crr_id  numeric (22,0)
,puract_cno  varchar (40) 
,puract_sno  varchar (40) 
,puract_remark  varchar (4000) 
,puract_contents  varchar (4000) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,puract_updated_at   timestamp(6) 
,puract_chrg_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,puract_person_id_upd  numeric (38,0)
,puract_shelfno_id_to  numeric (38,0)
,puract_created_at   timestamp(6) 
,puract_update_ip  varchar (40) 
,puract_opeitm_id  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,puract_supplier_id  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,puract_crr_id_pur  numeric (22,0)
,puract_prjno_id  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,supplier_crr_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,supplier_loca_id_supplier  numeric (22,0)
,opeitm_loca_id  numeric (38,0)
,supplier_payment_id  numeric (38,0)
,payment_chrg_id_payment  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,itm_unit_id  numeric (22,0)
,puract_id  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
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
 CREATE INDEX sio_r_puracts_uk1 
  ON sio.sio_r_puracts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_puracts_seq ;
 create sequence sio.sio_r_puracts_seq ;
  drop view if  exists r_purinsts cascade ; 
 create or replace view r_purinsts as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  opeitm.opeitm_duration  opeitm_duration ,
purinst.id id,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
purinst.qty_case  purinst_qty_case,
purinst.cno  purinst_cno,
purinst.isudate  purinst_isudate,
purinst.opeitms_id   purinst_opeitm_id,
purinst.expiredate  purinst_expiredate,
purinst.updated_at  purinst_updated_at,
purinst.qty  purinst_qty,
purinst.sno  purinst_sno,
purinst.price  purinst_price,
purinst.remark  purinst_remark,
purinst.created_at  purinst_created_at,
purinst.update_ip  purinst_update_ip,
purinst.duedate  purinst_duedate,
purinst.amt  purinst_amt,
purinst.id  purinst_id,
purinst.persons_id_upd   purinst_person_id_upd,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
purinst.prjnos_id   purinst_prjno_id,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
purinst.contract_price  purinst_contract_price,
purinst.chrgs_id   purinst_chrg_id,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
purinst.tax  purinst_tax,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
purinst.starttime  purinst_starttime,
purinst.itm_code_client  purinst_itm_code_client,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_autoact_p  opeitm_autoact_p ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  supplier.payment_chrg_id_payment  payment_chrg_id_payment ,
  supplier.person_code_chrg_payment  person_code_chrg_payment ,
  supplier.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment ,
  supplier.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment ,
  supplier.person_name_chrg_payment  person_name_chrg_payment ,
  supplier.supplier_payment_id  supplier_payment_id ,
  supplier.supplier_loca_id_supplier  supplier_loca_id_supplier ,
  supplier.supplier_chrg_id_supplier  supplier_chrg_id_supplier ,
  supplier.supplier_crr_id_supplier  supplier_crr_id_supplier ,
  supplier.loca_code_supplier  loca_code_supplier ,
  supplier.loca_name_supplier  loca_name_supplier ,
  supplier.person_code_chrg_supplier  person_code_chrg_supplier ,
  supplier.usrgrp_name_chrg_supplier  usrgrp_name_chrg_supplier ,
  supplier.usrgrp_code_chrg_supplier  usrgrp_code_chrg_supplier ,
  supplier.person_name_chrg_supplier  person_name_chrg_supplier ,
  supplier.crr_name_supplier  crr_name_supplier ,
  supplier.crr_code_supplier  crr_code_supplier ,
  opeitm.itm_classlist_id  itm_classlist_id ,
purinst.autocreate_act  purinst_autocreate_act,
purinst.autoact_p  purinst_autoact_p,
purinst.suppliers_id   purinst_supplier_id,
  supplier.scrlv_code_chrg_supplier  scrlv_code_chrg_supplier ,
  supplier.loca_name_sect_chrg_supplier  loca_name_sect_chrg_supplier ,
  supplier.loca_code_sect_chrg_supplier  loca_code_sect_chrg_supplier ,
  supplier.scrlv_code_chrg_payment  scrlv_code_chrg_payment ,
  supplier.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment ,
  supplier.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
purinst.sno_purord  purinst_sno_purord,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
purinst.shelfnos_id_to   purinst_shelfno_id_to,
purinst.crrs_id   purinst_crr_id,
  prjno.prjno_name_chil  prjno_name_chil 
 from purinsts   purinst,
  r_opeitms  opeitm ,  r_persons  person_upd ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_suppliers  supplier ,  r_shelfnos  shelfno_to ,  r_crrs  crr 
  where       purinst.opeitms_id = opeitm.id      and purinst.persons_id_upd = person_upd.id      and purinst.prjnos_id = prjno.id      and purinst.chrgs_id = chrg.id      and purinst.suppliers_id = supplier.id      and purinst.shelfnos_id_to = shelfno_to.id      and purinst.crrs_id = crr.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purinsts;
 CREATE TABLE sio.sio_r_purinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,purinst_sno_purord  varchar (50) 
,purinst_isudate   timestamp(6) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,purinst_qty  numeric (18,4)
,purinst_qty_case  numeric (38,0)
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,person_code_chrg  varchar (50) 
,purinst_sno  varchar (40) 
,purinst_cno  varchar (40) 
,person_code_upd  varchar (50) 
,crr_code  varchar (50) 
,person_code_chrg_supplier  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,person_name_chrg  varchar (100) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,loca_code_payment  varchar (50) 
,loca_name_payment  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,person_code_chrg_payment  varchar (50) 
,usrgrp_name_chrg_payment  varchar (100) 
,usrgrp_code_chrg_payment  varchar (50) 
,person_name_chrg_payment  varchar (100) 
,loca_code_supplier  varchar (50) 
,loca_name_supplier  varchar (100) 
,usrgrp_name_chrg_supplier  varchar (100) 
,usrgrp_code_chrg_supplier  varchar (50) 
,person_name_chrg_supplier  varchar (100) 
,crr_name_supplier  varchar (100) 
,crr_code_supplier  varchar (50) 
,scrlv_code_chrg_supplier  varchar (50) 
,loca_name_sect_chrg_supplier  varchar (100) 
,loca_code_sect_chrg_supplier  varchar (50) 
,scrlv_code_chrg_payment  varchar (50) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_code_sect_chrg_payment  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,purinst_expiredate   date 
,person_name_upd  varchar (100) 
,crr_name  varchar (100) 
,purinst_contract_price  varchar (1) 
,purinst_autocreate_act  varchar (1) 
,purinst_autoact_p  numeric (3,0)
,purinst_starttime   timestamp(6) 
,purinst_itm_code_client  varchar (50) 
,prjno_name_chil  varchar (100) 
,opeitm_priority  numeric (3,0)
,opeitm_autoact_p  numeric (3,0)
,opeitm_processseq  numeric (3,0)
,opeitm_packqty  numeric (38,0)
,opeitm_duration  numeric (38,2)
,purinst_amt  numeric (18,4)
,purinst_crr_id  numeric (22,0)
,purinst_price  numeric (38,4)
,purinst_tax  numeric (38,4)
,purinst_duedate   timestamp(6) 
,purinst_remark  varchar (4000) 
,purinst_created_at   timestamp(6) 
,purinst_shelfno_id_to  numeric (38,0)
,purinst_supplier_id  numeric (22,0)
,purinst_opeitm_id  numeric (38,0)
,purinst_updated_at   timestamp(6) 
,id  numeric (38,0)
,purinst_update_ip  varchar (40) 
,purinst_id  numeric (38,0)
,purinst_person_id_upd  numeric (38,0)
,purinst_prjno_id  numeric (38,0)
,purinst_chrg_id  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,supplier_crr_id_supplier  numeric (22,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,boxe_unit_id_outbox  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,person_sect_id_chrg_payment  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,supplier_payment_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,payment_chrg_id_payment  numeric (22,0)
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
 CREATE INDEX sio_r_purinsts_uk1 
  ON sio.sio_r_purinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purinsts_seq ;
 create sequence sio.sio_r_purinsts_seq ;
  drop view if  exists r_purords cascade ; 
 create or replace view r_purords as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
purord.autoinst_p  purord_autoinst_p,
purord.autocreate_act  purord_autocreate_act,
purord.autoact_p  purord_autoact_p,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_std  itm_std ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
purord.qty  purord_qty,
purord.duedate  purord_duedate,
purord.isudate  purord_isudate,
purord.remark  purord_remark,
purord.update_ip  purord_update_ip,
purord.created_at  purord_created_at,
purord.updated_at  purord_updated_at,
purord.id  purord_id,
purord.sno  purord_sno,
  opeitm.opeitm_duration  opeitm_duration ,
purord.id id,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  opeitm.opeitm_autocreate_inst  opeitm_autocreate_inst ,
purord.amt  purord_amt,
purord.toduedate  purord_toduedate,
purord.persons_id_upd   purord_person_id_upd,
purord.sno_pursch  purord_sno_pursch,
purord.expiredate  purord_expiredate,
purord.price  purord_price,
purord.opt_fixoterm  purord_opt_fixoterm,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
purord.qty_case  purord_qty_case,
purord.confirm  purord_confirm,
purord.opeitms_id   purord_opeitm_id,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
purord.autocreate_inst  purord_autocreate_inst,
  prjno.prjno_code  prjno_code ,
purord.prjnos_id   purord_prjno_id,
purord.contract_price  purord_contract_price,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
purord.chrgs_id   purord_chrg_id,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
purord.tax  purord_tax,
purord.gno  purord_gno,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
purord.itm_code_client  purord_itm_code_client,
purord.starttime  purord_starttime,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_autoinst_p  opeitm_autoinst_p ,
  opeitm.opeitm_autoact_p  opeitm_autoact_p ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  supplier.payment_chrg_id_payment  payment_chrg_id_payment ,
  supplier.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment ,
purord.suppliers_id   purord_supplier_id,
  supplier.supplier_payment_id  supplier_payment_id ,
  supplier.supplier_loca_id_supplier  supplier_loca_id_supplier ,
  supplier.supplier_chrg_id_supplier  supplier_chrg_id_supplier ,
  supplier.supplier_crr_id_supplier  supplier_crr_id_supplier ,
  supplier.loca_code_supplier  loca_code_supplier ,
  supplier.loca_name_supplier  loca_name_supplier ,
  supplier.person_code_chrg_supplier  person_code_chrg_supplier ,
  supplier.person_name_chrg_supplier  person_name_chrg_supplier ,
  supplier.crr_name_supplier  crr_name_supplier ,
  supplier.crr_code_supplier  crr_code_supplier ,
purord.crrs_id_pur   purord_crr_id_pur,
  crr_pur.crr_name  crr_name_pur ,
  crr_pur.crr_code  crr_code_pur ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
  opeitm.opeitm_stktaking_proc  opeitm_stktaking_proc ,
  opeitm.opeitm_acceptance_proc  opeitm_acceptance_proc ,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
purord.shelfnos_id_to   purord_shelfno_id_to,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
purord.crrs_id   purord_crr_id,
  prjno.prjno_name_chil  prjno_name_chil 
 from purords   purord,
  r_persons  person_upd ,  r_opeitms  opeitm ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_suppliers  supplier ,  r_crrs  crr_pur ,  r_shelfnos  shelfno_to ,  r_crrs  crr 
  where       purord.persons_id_upd = person_upd.id      and purord.opeitms_id = opeitm.id      and purord.prjnos_id = prjno.id      and purord.chrgs_id = chrg.id      and purord.suppliers_id = supplier.id      and purord.crrs_id_pur = crr_pur.id      and purord.shelfnos_id_to = shelfno_to.id      and purord.crrs_id = crr.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purords;
 CREATE TABLE sio.sio_r_purords (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purords_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,purord_confirm  char (01) 
,purord_sno  varchar (40) 
,purord_isudate   timestamp(6) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,itm_std  varchar (50) 
,opeitm_processseq  numeric (3,0)
,purord_starttime   timestamp(6) 
,purord_duedate   timestamp(6) 
,purord_qty  numeric (18,4)
,opeitm_packqty  numeric (38,0)
,loca_code_supplier  varchar (50) 
,loca_name_supplier  varchar (100) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,purord_qty_case  numeric (38,0)
,purord_price  numeric (38,4)
,purord_amt  numeric (18,4)
,purord_tax  numeric (38,4)
,crr_code_supplier  varchar (50) 
,crr_name_supplier  varchar (100) 
,crr_code_pur  varchar (50) 
,crr_name_pur  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,loca_code_shelfno_to  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,crr_code  varchar (50) 
,person_code_upd  varchar (50) 
,person_code_chrg_supplier  varchar (50) 
,person_name_chrg_supplier  varchar (100) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,purord_itm_code_client  varchar (50) 
,purord_opt_fixoterm  numeric (5,2)
,purord_autocreate_inst  varchar (1) 
,purord_autoinst_p  numeric (3,0)
,purord_autocreate_act  varchar (1) 
,purord_autoact_p  numeric (3,0)
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,classlist_name  varchar (100) 
,usrgrp_name_chrg_payment  varchar (100) 
,classlist_code  varchar (50) 
,loca_code_payment  varchar (50) 
,loca_name_payment  varchar (100) 
,prjno_code_chil  varchar (50) 
,purord_toduedate   timestamp(6) 
,purord_expiredate   date 
,crr_name  varchar (100) 
,prjno_name_chil  varchar (100) 
,person_name_upd  varchar (100) 
,purord_sno_pursch  varchar (50) 
,opeitm_duration  numeric (38,2)
,opeitm_autoinst_p  numeric (3,0)
,opeitm_autoact_p  numeric (3,0)
,opeitm_priority  numeric (3,0)
,opeitm_autocreate_inst  varchar (1) 
,purord_gno  varchar (40) 
,purord_contract_price  varchar (1) 
,purord_crr_id  numeric (22,0)
,opeitm_stktaking_proc  varchar (1) 
,opeitm_acceptance_proc  varchar (1) 
,purord_remark  varchar (4000) 
,purord_chrg_id  numeric (38,0)
,purord_update_ip  varchar (40) 
,purord_prjno_id  numeric (38,0)
,purord_opeitm_id  numeric (38,0)
,purord_person_id_upd  numeric (38,0)
,purord_crr_id_pur  numeric (22,0)
,id  numeric (38,0)
,purord_shelfno_id_to  numeric (38,0)
,purord_id  numeric (38,0)
,purord_updated_at   timestamp(6) 
,purord_supplier_id  numeric (22,0)
,purord_created_at   timestamp(6) 
,chrg_person_id_chrg_supplier  numeric (38,0)
,itm_unit_id  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,payment_chrg_id_payment  numeric (22,0)
,supplier_payment_id  numeric (38,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
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
 CREATE INDEX sio_r_purords_uk1 
  ON sio.sio_r_purords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purords_seq ;
 create sequence sio.sio_r_purords_seq ;
  drop view if  exists r_prdschs cascade ; 
 create or replace view r_prdschs as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_std  itm_std ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
prdsch.id id,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
prdsch.id  prdsch_id,
prdsch.remark  prdsch_remark,
prdsch.expiredate  prdsch_expiredate,
prdsch.update_ip  prdsch_update_ip,
prdsch.created_at  prdsch_created_at,
prdsch.updated_at  prdsch_updated_at,
prdsch.persons_id_upd   prdsch_person_id_upd,
prdsch.sno  prdsch_sno,
prdsch.duedate  prdsch_duedate,
prdsch.toduedate  prdsch_toduedate,
prdsch.isudate  prdsch_isudate,
prdsch.opeitms_id   prdsch_opeitm_id,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
prdsch.prjnos_id   prdsch_prjno_id,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
prdsch.chrgs_id   prdsch_chrg_id,
prdsch.starttime  prdsch_starttime,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  workplace.workplace_loca_id_workplace  workplace_loca_id_workplace ,
  workplace.loca_code_workplace  loca_code_workplace ,
  workplace.loca_name_workplace  loca_name_workplace ,
prdsch.shelfnos_id_to   prdsch_shelfno_id_to,
  workplace.workplace_chrg_id_workplace  workplace_chrg_id_workplace ,
  workplace.scrlv_code_chrg_workplace  scrlv_code_chrg_workplace ,
  workplace.loca_code_sect_chrg_workplace  loca_code_sect_chrg_workplace ,
  workplace.loca_name_sect_chrg_workplace  loca_name_sect_chrg_workplace ,
  workplace.person_code_chrg_workplace  person_code_chrg_workplace ,
  workplace.person_name_chrg_workplace  person_name_chrg_workplace ,
  workplace.usrgrp_name_chrg_workplace  usrgrp_name_chrg_workplace ,
  workplace.person_sect_id_chrg_workplace  person_sect_id_chrg_workplace ,
  workplace.usrgrp_code_chrg_workplace  usrgrp_code_chrg_workplace ,
  workplace.chrg_person_id_chrg_workplace  chrg_person_id_chrg_workplace ,
prdsch.workplaces_id   prdsch_workplace_id,
prdsch.qty_sch  prdsch_qty_sch,
  prjno.prjno_name_chil  prjno_name_chil 
 from prdschs   prdsch,
  r_persons  person_upd ,  r_opeitms  opeitm ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_shelfnos  shelfno_to ,  r_workplaces  workplace 
  where       prdsch.persons_id_upd = person_upd.id      and prdsch.opeitms_id = opeitm.id      and prdsch.prjnos_id = prjno.id      and prdsch.chrgs_id = chrg.id      and prdsch.shelfnos_id_to = shelfno_to.id      and prdsch.workplaces_id = workplace.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdschs;
 CREATE TABLE sio.sio_r_prdschs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdschs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prdsch_sno  varchar (40) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,itm_std  varchar (50) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,prdsch_duedate   timestamp(6) 
,opeitm_processseq  numeric (3,0)
,opeitm_priority  numeric (3,0)
,loca_code_workplace  varchar (50) 
,loca_name_workplace  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,person_code_upd  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,prdsch_toduedate   timestamp(6) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,classlist_name  varchar (100) 
,classlist_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,usrgrp_code_chrg_workplace  varchar (50) 
,usrgrp_name_chrg_workplace  varchar (100) 
,person_name_chrg_workplace  varchar (100) 
,person_code_chrg_workplace  varchar (50) 
,loca_name_sect_chrg_workplace  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,loca_code_sect_chrg_workplace  varchar (50) 
,unit_code_box  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,scrlv_code_chrg_workplace  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,boxe_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,boxe_code  varchar (50) 
,unit_name_outbox  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_box  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,prjno_name_chil  varchar (100) 
,person_name_upd  varchar (100) 
,prdsch_expiredate   date 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,opeitm_packqty  numeric (38,0)
,prdsch_isudate   timestamp(6) 
,prdsch_starttime   timestamp(6) 
,prdsch_qty_sch  numeric (22,6)
,prjno_code_chil  varchar (50) 
,prdsch_remark  varchar (4000) 
,prdsch_created_at   timestamp(6) 
,prdsch_prjno_id  numeric (38,0)
,prdsch_opeitm_id  numeric (38,0)
,prdsch_chrg_id  numeric (38,0)
,prdsch_person_id_upd  numeric (38,0)
,prdsch_updated_at   timestamp(6) 
,prdsch_update_ip  varchar (40) 
,prdsch_shelfno_id_to  numeric (38,0)
,prdsch_id  numeric (38,0)
,id  numeric (38,0)
,prdsch_workplace_id  numeric (22,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,workplace_loca_id_workplace  numeric (22,0)
,itm_unit_id  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,chrg_person_id_chrg_workplace  numeric (38,0)
,workplace_chrg_id_workplace  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,person_sect_id_chrg_workplace  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
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
 CREATE INDEX sio_r_prdschs_uk1 
  ON sio.sio_r_prdschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdschs_seq ;
 create sequence sio.sio_r_prdschs_seq ;
  drop view if  exists r_nditms cascade ; 
 create or replace view r_nditms as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
nditm.contents  nditm_contents,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
nditm.parenum  nditm_parenum,
nditm.created_at  nditm_created_at,
nditm.opeitms_id   nditm_opeitm_id,
nditm.consumunitqty  nditm_consumunitqty,
nditm.persons_id_upd   nditm_person_id_upd,
nditm.updated_at  nditm_updated_at,
nditm.id  nditm_id,
nditm.remark  nditm_remark,
nditm.expiredate  nditm_expiredate,
nditm.update_ip  nditm_update_ip,
nditm.consumtype  nditm_consumtype,
  itm_nditm.itm_code  itm_code_nditm ,
  itm_nditm.itm_design  itm_design_nditm ,
  itm_nditm.itm_deth  itm_deth_nditm ,
  itm_nditm.itm_length  itm_length_nditm ,
  itm_nditm.itm_material  itm_material_nditm ,
  itm_nditm.itm_model  itm_model_nditm ,
  itm_nditm.itm_name  itm_name_nditm ,
  itm_nditm.itm_std  itm_std_nditm ,
  itm_nditm.itm_weight  itm_weight_nditm ,
nditm.itms_id_nditm   nditm_itm_id_nditm,
  itm_nditm.unit_code  unit_code_nditm ,
  itm_nditm.unit_name  unit_name_nditm ,
nditm.chilnum  nditm_chilnum,
  opeitm.opeitm_duration  opeitm_duration ,
  itm_nditm.itm_wide  itm_wide_nditm ,
nditm.id id,
  itm_nditm.itm_unit_id  itm_unit_id_nditm ,
  opeitm.opeitm_operation  opeitm_operation ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  opeitm.opeitm_prdpurshp  opeitm_prdpurshp ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.opeitm_chkord_proc  opeitm_chkord_proc ,
  opeitm.opeitm_esttosch  opeitm_esttosch ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  opeitm.opeitm_mold  opeitm_mold ,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  loca_fm.loca_code  loca_code_fm ,
  loca_fm.loca_name  loca_name_fm ,
nditm.consumauto  nditm_consumauto,
nditm.processseq_nditm  nditm_processseq_nditm,
  opeitm.opeitm_opt_fix_flg  opeitm_opt_fix_flg ,
  opeitm.opeitm_prjalloc_flg  opeitm_prjalloc_flg ,
  opeitm.opeitm_autoord_p  opeitm_autoord_p ,
nditm.byproduct  nditm_byproduct,
nditm.consumminqty  nditm_consumminqty,
nditm.consumchgoverqty  nditm_consumchgoverqty,
  opeitm.itm_classlist_id  itm_classlist_id ,
  itm_nditm.itm_classlist_id  itm_classlist_id_nditm ,
  itm_nditm.classlist_name  classlist_name_nditm ,
  itm_nditm.classlist_code  classlist_code_nditm ,
nditm.locas_id_fm   nditm_loca_id_fm,
nditm.price  nditm_price,
nditm.crrs_id   nditm_crr_id
 from nditms   nditm,
  r_opeitms  opeitm ,  r_persons  person_upd ,  r_itms  itm_nditm ,  r_locas  loca_fm ,  r_crrs  crr 
  where       nditm.opeitms_id = opeitm.id      and nditm.persons_id_upd = person_upd.id      and nditm.itms_id_nditm = itm_nditm.id      and nditm.locas_id_fm = loca_fm.id      and nditm.crrs_id = crr.id     ;
 DROP TABLE IF EXISTS sio.sio_r_nditms;
 CREATE TABLE sio.sio_r_nditms (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_nditms_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,itm_name  varchar (100) 
,opeitm_processseq  numeric (3,0)
,opeitm_priority  numeric (3,0)
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,itm_code_nditm  varchar (50) 
,itm_name_nditm  varchar (100) 
,nditm_processseq_nditm  numeric (38,0)
,person_code_upd  varchar (50) 
,nditm_parenum  numeric (38,0)
,nditm_chilnum  numeric (38,0)
,opeitm_packqty  numeric (38,0)
,nditm_consumtype  varchar (3) 
,loca_code_fm  varchar (50) 
,loca_name_fm  varchar (100) 
,nditm_consumunitqty  numeric (38,0)
,nditm_consumauto  varchar (1) 
,classlist_code  varchar (50) 
,boxe_name  varchar (100) 
,boxe_code  varchar (50) 
,crr_name  varchar (100) 
,crr_code  varchar (50) 
,classlist_code_nditm  varchar (50) 
,classlist_name  varchar (100) 
,classlist_name_nditm  varchar (100) 
,nditm_expiredate   date 
,nditm_byproduct  varchar (1) 
,nditm_consumminqty  numeric (22,6)
,nditm_consumchgoverqty  numeric (22,6)
,person_name_upd  varchar (100) 
,nditm_price  numeric (38,4)
,opeitm_autoord_p  numeric (3,0)
,loca_name_shelfno  varchar (100) 
,loca_code_shelfno  varchar (50) 
,shelfno_name  varchar (100) 
,opeitm_prdpurshp  varchar (20) 
,itm_material_nditm  varchar (50) 
,shelfno_code  varchar (50) 
,itm_std_nditm  varchar (50) 
,unit_code_nditm  varchar (50) 
,itm_model_nditm  varchar (50) 
,itm_design_nditm  varchar (50) 
,itm_weight_nditm  numeric (22,0)
,itm_length_nditm  numeric (22,0)
,itm_wide_nditm  numeric (22,0)
,itm_deth_nditm  numeric (22,0)
,unit_name_nditm  varchar (100) 
,nditm_remark  varchar (4000) 
,nditm_contents  varchar (4000) 
,nditm_crr_id  numeric (22,0)
,nditm_opeitm_id  numeric (38,0)
,nditm_loca_id_fm  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,itm_unit_id_nditm  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_classlist_id_nditm  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_operation  varchar (20) 
,opeitm_esttosch  numeric (22,0)
,opeitm_chkord_proc  numeric (3,0)
,opeitm_mold  varchar (1) 
,nditm_itm_id_nditm  numeric (38,0)
,opeitm_duration  numeric (38,2)
,nditm_update_ip  varchar (40) 
,id  numeric (38,0)
,nditm_id  numeric (38,0)
,nditm_updated_at   timestamp(6) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_prjalloc_flg  numeric (22,0)
,nditm_person_id_upd  numeric (38,0)
,nditm_created_at   timestamp(6) 
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
 CREATE INDEX sio_r_nditms_uk1 
  ON sio.sio_r_nditms(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_nditms_seq ;
 create sequence sio.sio_r_nditms_seq ;
  drop view if  exists r_custinsts cascade ; 
 create or replace view r_custinsts as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  cust.loca_name_cust  loca_name_cust ,
  cust.loca_code_cust  loca_code_cust ,
custinst.isudate  custinst_isudate,
custinst.created_at  custinst_created_at,
custinst.sno  custinst_sno,
custinst.amt  custinst_amt,
  custrcvplc.loca_code_custrcvplc  loca_code_custrcvplc ,
custinst.updated_at  custinst_updated_at,
custinst.remark  custinst_remark,
custinst.update_ip  custinst_update_ip,
custinst.price  custinst_price,
custinst.qty  custinst_qty,
custinst.duedate  custinst_duedate,
custinst.persons_id_upd   custinst_person_id_upd,
custinst.id  custinst_id,
  custrcvplc.loca_name_custrcvplc  loca_name_custrcvplc ,
custinst.id id,
  cust.cust_loca_id_cust  cust_loca_id_cust ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  asstwh.asstwh_loca_id_asstwh  asstwh_loca_id_asstwh ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
custinst.expiredate  custinst_expiredate,
custinst.cno  custinst_cno,
custinst.custs_id   custinst_cust_id,
custinst.gno  custinst_gno,
custinst.asstwhs_id   custinst_asstwh_id,
  custrcvplc.custrcvplc_loca_id_custrcvplc  custrcvplc_loca_id_custrcvplc ,
custinst.custrcvplcs_id   custinst_custrcvplc_id,
  cust.scrlv_code_chrg_cust  scrlv_code_chrg_cust ,
  cust.cust_chrg_id_cust  cust_chrg_id_cust ,
  cust.chrg_person_id_chrg_cust  chrg_person_id_chrg_cust ,
  cust.person_code_chrg_cust  person_code_chrg_cust ,
  cust.person_name_chrg_cust  person_name_chrg_cust ,
  cust.person_sect_id_chrg_cust  person_sect_id_chrg_cust ,
  cust.loca_code_sect_chrg_cust  loca_code_sect_chrg_cust ,
  cust.loca_name_sect_chrg_cust  loca_name_sect_chrg_cust ,
  cust.usrgrp_code_chrg_cust  usrgrp_code_chrg_cust ,
  cust.usrgrp_name_chrg_cust  usrgrp_name_chrg_cust ,
  chrg_cpo.scrlv_code_chrg  scrlv_code_chrg_cpo ,
  chrg_cpo.usrgrp_code_chrg  usrgrp_code_chrg_cpo ,
  chrg_cpo.usrgrp_name_chrg  usrgrp_name_chrg_cpo ,
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
  asstwh.asstwh_chrg_id_asstwh  asstwh_chrg_id_asstwh ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
custinst.contract_price  custinst_contract_price,
custinst.itm_code_client  custinst_itm_code_client,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  cust.bill_chrg_id_bill  bill_chrg_id_bill ,
  cust.person_code_chrg_bill  person_code_chrg_bill ,
  cust.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  cust.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  cust.person_name_chrg_bill  person_name_chrg_bill ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
  cust.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  cust.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  cust.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  cust.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  cust.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  cust.bill_crr_id_bill  bill_crr_id_bill ,
  cust.crr_code_bill  crr_code_bill ,
  cust.crr_name_bill  crr_name_bill ,
custinst.starttime  custinst_starttime,
custinst.chrgs_id_cpo   custinst_chrg_id_cpo,
custinst.shelfnos_id_fm   custinst_shelfno_id_fm,
custinst.opeitms_id   custinst_opeitm_id
 from custinsts   custinst,
  r_persons  person_upd ,  r_custs  cust ,  r_asstwhs  asstwh ,  r_custrcvplcs  custrcvplc ,  r_chrgs  chrg_cpo ,  r_shelfnos  shelfno_fm ,  r_opeitms  opeitm 
  where       custinst.persons_id_upd = person_upd.id      and custinst.custs_id = cust.id      and custinst.asstwhs_id = asstwh.id      and custinst.custrcvplcs_id = custrcvplc.id      and custinst.chrgs_id_cpo = chrg_cpo.id      and custinst.shelfnos_id_fm = shelfno_fm.id      and custinst.opeitms_id = opeitm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custinsts;
 CREATE TABLE sio.sio_r_custinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,unit_code  varchar (50) 
,itm_code  varchar (50) 
,loca_code  varchar (50) 
,boxe_code  varchar (50) 
,person_code_upd  varchar (50) 
,classlist_code  varchar (50) 
,shelfno_code  varchar (50) 
,person_name_chrg_cpo  varchar (100) 
,crr_name_bill  varchar (100) 
,loca_name_sect_chrg_cpo  varchar (100) 
,loca_code_sect_chrg_cpo  varchar (50) 
,crr_code_bill  varchar (50) 
,scrlv_code_chrg_cpo  varchar (50) 
,usrgrp_code_chrg_cpo  varchar (50) 
,usrgrp_name_chrg_cpo  varchar (100) 
,person_code_chrg_cpo  varchar (50) 
,loca_name  varchar (100) 
,boxe_name  varchar (100) 
,classlist_name  varchar (100) 
,itm_name  varchar (100) 
,unit_name  varchar (100) 
,person_name_upd  varchar (100) 
,shelfno_name  varchar (100) 
,loca_code_cust  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,scrlv_code_chrg_bill  varchar (50) 
,person_code_chrg_cust  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,unit_code_outbox  varchar (50) 
,scrlv_code_chrg_cust  varchar (50) 
,loca_code_shelfno  varchar (50) 
,shelfno_code_fm  varchar (50) 
,unit_code_case  varchar (50) 
,usrgrp_code_chrg_cust  varchar (50) 
,unit_code_box  varchar (50) 
,person_code_chrg_bill  varchar (50) 
,loca_code_custrcvplc  varchar (50) 
,loca_code_bill  varchar (50) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_code_sect_chrg_cust  varchar (50) 
,loca_name_bill  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,loca_name_cust  varchar (100) 
,loca_name_sect_chrg_bill  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_custrcvplc  varchar (100) 
,shelfno_name_fm  varchar (100) 
,unit_name_case  varchar (100) 
,person_name_chrg_bill  varchar (100) 
,loca_name_shelfno  varchar (100) 
,usrgrp_name_chrg_bill  varchar (100) 
,unit_name_outbox  varchar (100) 
,person_name_chrg_cust  varchar (100) 
,unit_name_box  varchar (100) 
,loca_name_sect_chrg_cust  varchar (100) 
,usrgrp_name_chrg_cust  varchar (100) 
,custinst_opeitm_id  numeric (38,0)
,custinst_gno  varchar (40) 
,custinst_starttime   timestamp(6) 
,custinst_chrg_id_cpo  numeric (38,0)
,custinst_shelfno_id_fm  numeric (22,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,custinst_isudate   timestamp 
,custinst_duedate   timestamp 
,custinst_qty  numeric (38,4)
,custinst_price  numeric (38,4)
,custinst_amt  numeric (38,4)
,custinst_contract_price  varchar (1) 
,custinst_expiredate   date 
,custinst_sno  varchar (40) 
,custinst_remark  varchar (4000) 
,custinst_itm_code_client  varchar (50) 
,custinst_cno  varchar (40) 
,chrg_person_id_chrg_cpo  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,cust_loca_id_cust  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,cust_bill_id  numeric (38,0)
,cust_chrg_id_cust  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,person_sect_id_chrg_cpo  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,itm_unit_id  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,person_sect_id_chrg_cust  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,bill_chrg_id_bill  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,bill_loca_id_bill  numeric (38,0)
,custinst_update_ip  varchar (40) 
,custinst_cust_id  numeric (22,0)
,custinst_created_at   timestamp(6) 
,custinst_custrcvplc_id  numeric (22,0)
,asstwh_chrg_id_asstwh  numeric (22,0)
,custinst_updated_at   timestamp(6) 
,custinst_asstwh_id  numeric (22,0)
,id  numeric (22,0)
,custinst_id  numeric (22,0)
,asstwh_loca_id_asstwh  numeric (22,0)
,custinst_person_id_upd  numeric (22,0)
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
 CREATE INDEX sio_r_custinsts_uk1 
  ON sio.sio_r_custinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custinsts_seq ;
 create sequence sio.sio_r_custinsts_seq ;
  drop view if  exists r_custacts cascade ; 
 create or replace view r_custacts as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  cust.loca_name_cust  loca_name_cust ,
  cust.loca_code_cust  loca_code_cust ,
  custrcvplc.loca_code_custrcvplc  loca_code_custrcvplc ,
  custrcvplc.loca_name_custrcvplc  loca_name_custrcvplc ,
custact.id id,
  cust.cust_loca_id_cust  cust_loca_id_cust ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  asstwh.asstwh_loca_id_asstwh  asstwh_loca_id_asstwh ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  custrcvplc.custrcvplc_loca_id_custrcvplc  custrcvplc_loca_id_custrcvplc ,
  cust.scrlv_code_chrg_cust  scrlv_code_chrg_cust ,
  cust.cust_chrg_id_cust  cust_chrg_id_cust ,
  cust.chrg_person_id_chrg_cust  chrg_person_id_chrg_cust ,
  cust.person_code_chrg_cust  person_code_chrg_cust ,
  cust.person_name_chrg_cust  person_name_chrg_cust ,
  cust.person_sect_id_chrg_cust  person_sect_id_chrg_cust ,
  cust.loca_code_sect_chrg_cust  loca_code_sect_chrg_cust ,
  cust.loca_name_sect_chrg_cust  loca_name_sect_chrg_cust ,
  cust.usrgrp_code_chrg_cust  usrgrp_code_chrg_cust ,
  cust.usrgrp_name_chrg_cust  usrgrp_name_chrg_cust ,
  chrg_cpo.scrlv_code_chrg  scrlv_code_chrg_cpo ,
  chrg_cpo.usrgrp_code_chrg  usrgrp_code_chrg_cpo ,
  chrg_cpo.usrgrp_name_chrg  usrgrp_name_chrg_cpo ,
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
  asstwh.asstwh_chrg_id_asstwh  asstwh_chrg_id_asstwh ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
custact.custrcvplcs_id   custact_custrcvplc_id,
custact.itm_code_client  custact_itm_code_client,
custact.isudate  custact_isudate,
custact.expiredate  custact_expiredate,
custact.updated_at  custact_updated_at,
custact.qty  custact_qty,
custact.sno  custact_sno,
custact.price  custact_price,
custact.remark  custact_remark,
custact.created_at  custact_created_at,
custact.update_ip  custact_update_ip,
custact.amt  custact_amt,
custact.id  custact_id,
custact.persons_id_upd   custact_person_id_upd,
custact.custs_id   custact_cust_id,
custact.contract_price  custact_contract_price,
custact.asstwhs_id   custact_asstwh_id,
custact.tblid  custact_tblid,
custact.tblname  custact_tblname,
custact.saledate  custact_saledate,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  cust.bill_chrg_id_bill  bill_chrg_id_bill ,
  cust.person_code_chrg_bill  person_code_chrg_bill ,
  cust.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  cust.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  cust.person_name_chrg_bill  person_name_chrg_bill ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
  cust.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  cust.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  cust.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  cust.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  cust.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  cust.bill_crr_id_bill  bill_crr_id_bill ,
  cust.crr_code_bill  crr_code_bill ,
  cust.crr_name_bill  crr_name_bill ,
custact.chrgs_id_cpo   custact_chrg_id_cpo,
custact.shelfnos_id_fm   custact_shelfno_id_fm,
custact.opeitms_id   custact_opeitm_id
 from custacts   custact,
  r_custrcvplcs  custrcvplc ,  r_persons  person_upd ,  r_custs  cust ,  r_asstwhs  asstwh ,  r_chrgs  chrg_cpo ,  r_shelfnos  shelfno_fm ,  r_opeitms  opeitm 
  where       custact.custrcvplcs_id = custrcvplc.id      and custact.persons_id_upd = person_upd.id      and custact.custs_id = cust.id      and custact.asstwhs_id = asstwh.id      and custact.chrgs_id_cpo = chrg_cpo.id      and custact.shelfnos_id_fm = shelfno_fm.id      and custact.opeitms_id = opeitm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custacts;
 CREATE TABLE sio.sio_r_custacts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custacts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,unit_code  varchar (50) 
,boxe_code  varchar (50) 
,classlist_code  varchar (50) 
,loca_code  varchar (50) 
,shelfno_code  varchar (50) 
,itm_code  varchar (50) 
,person_code_chrg_cpo  varchar (50) 
,usrgrp_name_chrg_cpo  varchar (100) 
,usrgrp_code_chrg_cpo  varchar (50) 
,scrlv_code_chrg_cpo  varchar (50) 
,loca_name_sect_chrg_cpo  varchar (100) 
,loca_code_sect_chrg_cpo  varchar (50) 
,crr_name_bill  varchar (100) 
,crr_code_bill  varchar (50) 
,person_name_chrg_cpo  varchar (100) 
,unit_name  varchar (100) 
,shelfno_name  varchar (100) 
,classlist_name  varchar (100) 
,loca_name  varchar (100) 
,boxe_name  varchar (100) 
,itm_name  varchar (100) 
,person_name_upd  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,loca_code_cust  varchar (50) 
,loca_code_custrcvplc  varchar (50) 
,unit_code_case  varchar (50) 
,loca_code_sect_chrg_bill  varchar (50) 
,scrlv_code_chrg_bill  varchar (50) 
,loca_code_shelfno  varchar (50) 
,scrlv_code_chrg_cust  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,person_code_chrg_cust  varchar (50) 
,loca_code_sect_chrg_cust  varchar (50) 
,usrgrp_code_chrg_cust  varchar (50) 
,shelfno_code_fm  varchar (50) 
,loca_code_bill  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,person_code_chrg_bill  varchar (50) 
,unit_code_box  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_shelfno  varchar (100) 
,unit_name_case  varchar (100) 
,loca_name_sect_chrg_bill  varchar (100) 
,loca_name_custrcvplc  varchar (100) 
,loca_name_cust  varchar (100) 
,usrgrp_name_chrg_bill  varchar (100) 
,loca_name_sect_chrg_cust  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,usrgrp_name_chrg_cust  varchar (100) 
,person_name_chrg_bill  varchar (100) 
,unit_name_outbox  varchar (100) 
,loca_name_bill  varchar (100) 
,unit_name_box  varchar (100) 
,person_name_chrg_cust  varchar (100) 
,shelfno_name_fm  varchar (100) 
,custact_chrg_id_cpo  numeric (38,0)
,custact_shelfno_id_fm  numeric (22,0)
,custact_opeitm_id  numeric (38,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,custact_isudate   timestamp(6) 
,custact_itm_code_client  varchar (50) 
,custact_expiredate   date 
,custact_qty  numeric (18,4)
,custact_sno  varchar (40) 
,custact_price  numeric (22,0)
,custact_remark  varchar (4000) 
,custact_amt  numeric (18,4)
,custact_contract_price  varchar (1) 
,custact_tblid  numeric (22,0)
,custact_tblname  varchar (30) 
,custact_saledate   timestamp(6) 
,opeitm_unit_id_prdpurshp  numeric (38,0)
,cust_bill_id  numeric (38,0)
,chrg_person_id_chrg_cpo  numeric (38,0)
,cust_loca_id_cust  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,cust_chrg_id_cust  numeric (38,0)
,person_sect_id_chrg_cpo  numeric (22,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,itm_unit_id  numeric (22,0)
,bill_chrg_id_bill  numeric (22,0)
,bill_loca_id_bill  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,person_sect_id_chrg_cust  numeric (22,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,bill_crr_id_bill  numeric (22,0)
,custact_updated_at   timestamp(6) 
,asstwh_loca_id_asstwh  numeric (22,0)
,custact_person_id_upd  numeric (22,0)
,asstwh_chrg_id_asstwh  numeric (22,0)
,custact_custrcvplc_id  numeric (22,0)
,custact_id  numeric (22,0)
,custact_asstwh_id  numeric (22,0)
,custact_update_ip  varchar (40) 
,custact_created_at   timestamp(6) 
,id  numeric (22,0)
,custact_cust_id  numeric (22,0)
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
 CREATE INDEX sio_r_custacts_uk1 
  ON sio.sio_r_custacts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custacts_seq ;
 create sequence sio.sio_r_custacts_seq ;
  drop view if  exists r_prdrets cascade ; 
 create or replace view r_prdrets as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
prdret.id id,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  loca_fm.loca_code  loca_code_fm ,
  loca_fm.loca_name  loca_name_fm ,
prdret.qty_case  prdret_qty_case,
prdret.retdate  prdret_retdate,
prdret.locas_id_fm   prdret_loca_id_fm,
prdret.id  prdret_id,
prdret.remark  prdret_remark,
prdret.expiredate  prdret_expiredate,
prdret.update_ip  prdret_update_ip,
prdret.created_at  prdret_created_at,
prdret.updated_at  prdret_updated_at,
prdret.persons_id_upd   prdret_person_id_upd,
prdret.qty  prdret_qty,
prdret.sno  prdret_sno,
prdret.isudate  prdret_isudate,
prdret.contents  prdret_contents,
prdret.locas_id_to   prdret_loca_id_to,
prdret.tax  prdret_tax,
prdret.prjnos_id   prdret_prjno_id,
prdret.opeitms_id   prdret_opeitm_id,
  prjno.prjno_code_chil  prjno_code_chil ,
prdret.chrgs_id   prdret_chrg_id,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  prjno.prjno_name_chil  prjno_name_chil ,
prdret.sno_prdact  prdret_sno_prdact
 from prdrets   prdret,
  r_locas  loca_fm ,  r_persons  person_upd ,  r_locas  loca_to ,  r_prjnos  prjno ,  r_opeitms  opeitm ,  r_chrgs  chrg 
  where       prdret.locas_id_fm = loca_fm.id      and prdret.persons_id_upd = person_upd.id      and prdret.locas_id_to = loca_to.id      and prdret.prjnos_id = prjno.id      and prdret.opeitms_id = opeitm.id      and prdret.chrgs_id = chrg.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdrets;
 CREATE TABLE sio.sio_r_prdrets (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdrets_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,unit_code  varchar (50) 
,shelfno_code  varchar (50) 
,person_code_upd  varchar (50) 
,itm_code  varchar (50) 
,loca_code  varchar (50) 
,boxe_code  varchar (50) 
,classlist_code  varchar (50) 
,prjno_code_chil  varchar (50) 
,prjno_code  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,person_name_chrg  varchar (100) 
,person_code_chrg  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,loca_name  varchar (100) 
,prjno_name  varchar (100) 
,boxe_name  varchar (100) 
,shelfno_name  varchar (100) 
,unit_name  varchar (100) 
,person_name_upd  varchar (100) 
,prjno_name_chil  varchar (100) 
,itm_name  varchar (100) 
,classlist_name  varchar (100) 
,prdret_expiredate   date 
,prdret_qty  numeric (18,4)
,prdret_sno  varchar (40) 
,loca_code_to  varchar (50) 
,loca_code_fm  varchar (50) 
,unit_code_case  varchar (50) 
,unit_code_box  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,loca_code_shelfno  varchar (50) 
,unit_code_outbox  varchar (50) 
,loca_name_to  varchar (100) 
,unit_name_case  varchar (100) 
,loca_name_shelfno  varchar (100) 
,unit_name_box  varchar (100) 
,unit_name_outbox  varchar (100) 
,loca_name_fm  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,prdret_remark  varchar (4000) 
,prdret_tax  numeric (22,0)
,prdret_sno_prdact  varchar (50) 
,prdret_loca_id_fm  numeric (38,0)
,prdret_contents  varchar (4000) 
,prdret_qty_case  numeric (22,0)
,prdret_retdate   date 
,prdret_isudate   timestamp(6) 
,person_sect_id_chrg  numeric (22,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,prdret_loca_id_to  numeric (22,0)
,prdret_updated_at   timestamp(6) 
,prdret_prjno_id  numeric (22,0)
,prdret_opeitm_id  numeric (22,0)
,prdret_created_at   timestamp(6) 
,prdret_chrg_id  numeric (22,0)
,id  numeric (22,0)
,prdret_update_ip  varchar (40) 
,prdret_id  numeric (22,0)
,prdret_person_id_upd  numeric (22,0)
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
 CREATE INDEX sio_r_prdrets_uk1 
  ON sio.sio_r_prdrets(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdrets_seq ;
 create sequence sio.sio_r_prdrets_seq ;
 ALTER TABLE custdlvs ADD CONSTRAINT custdlv_opeitms_id FOREIGN KEY (opeitms_id)
																		 REFERENCES opeitms (id);
 ALTER TABLE purdlvs ADD CONSTRAINT purdlv_shelfnos_id_to FOREIGN KEY (shelfnos_id_to)
																		 REFERENCES shelfnos (id);
 ALTER TABLE purrets ADD CONSTRAINT purret_suppliers_id FOREIGN KEY (suppliers_id)
																		 REFERENCES suppliers (id);
 ALTER TABLE purrets ADD CONSTRAINT purret_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 ALTER TABLE purrets ADD CONSTRAINT purret_prjnos_id FOREIGN KEY (prjnos_id)
																		 REFERENCES prjnos (id);
 ALTER TABLE purrets ADD CONSTRAINT purret_opeitms_id FOREIGN KEY (opeitms_id)
																		 REFERENCES opeitms (id);
 ALTER TABLE purrets ADD CONSTRAINT purret_chrgs_id FOREIGN KEY (chrgs_id)
																		 REFERENCES chrgs (id);
 ALTER TABLE purrets ADD CONSTRAINT purret_crrs_id FOREIGN KEY (crrs_id)
																		 REFERENCES crrs (id);
 ALTER TABLE purrets ADD CONSTRAINT purret_locas_id_fm FOREIGN KEY (locas_id_fm)
																		 REFERENCES locas (id);
 ALTER TABLE prdrets ADD CONSTRAINT prdret_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 ALTER TABLE prdrets ADD CONSTRAINT prdret_locas_id_to FOREIGN KEY (locas_id_to)
																		 REFERENCES locas (id);
 ALTER TABLE prdrets ADD CONSTRAINT prdret_prjnos_id FOREIGN KEY (prjnos_id)
																		 REFERENCES prjnos (id);
 ALTER TABLE prdrets ADD CONSTRAINT prdret_opeitms_id FOREIGN KEY (opeitms_id)
																		 REFERENCES opeitms (id);
 ALTER TABLE prdrets ADD CONSTRAINT prdret_chrgs_id FOREIGN KEY (chrgs_id)
																		 REFERENCES chrgs (id);
 ALTER TABLE prdrets ADD CONSTRAINT prdret_locas_id_fm FOREIGN KEY (locas_id_fm)
																		 REFERENCES locas (id);
