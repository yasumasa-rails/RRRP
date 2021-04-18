
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
  asstwh.loca_code_asstwh  loca_code_asstwh ,
  asstwh.loca_name_asstwh  loca_name_asstwh ,
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
  asstwh.usrgrp_code_chrg_asstwh  usrgrp_code_chrg_asstwh ,
  asstwh.usrgrp_name_chrg_asstwh  usrgrp_name_chrg_asstwh ,
  asstwh.person_code_chrg_asstwh  person_code_chrg_asstwh ,
  asstwh.person_name_chrg_asstwh  person_name_chrg_asstwh ,
  asstwh.person_sect_id_chrg_asstwh  person_sect_id_chrg_asstwh ,
  asstwh.loca_code_sect_chrg_asstwh  loca_code_sect_chrg_asstwh ,
  asstwh.loca_name_sect_chrg_asstwh  loca_name_sect_chrg_asstwh ,
  asstwh.scrlv_code_chrg_asstwh  scrlv_code_chrg_asstwh ,
  cust.bill_loca_id_bill  bill_loca_id_bill ,
  cust.loca_code_bill  loca_code_bill ,
  cust.loca_name_bill  loca_name_bill ,
  cust.cust_bill_id  cust_bill_id ,
  chrg_cpo.chrg_person_id_chrg  chrg_person_id_chrg_cpo ,
  cust.crr_name_cust  crr_name_cust ,
  cust.cust_crr_id_cust  cust_crr_id_cust ,
  cust.crr_code_cust  crr_code_cust ,
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
  asstwh.chrg_person_id_chrg_asstwh  chrg_person_id_chrg_asstwh ,
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
,itm_code  varchar (50) 
,loca_code_bill  varchar (50) 
,custact_itm_code_client  varchar (50) 
,crr_code_cust  varchar (50) 
,loca_code_custrcvplc  varchar (50) 
,loca_name_bill  varchar (100) 
,loca_code_asstwh  varchar (50) 
,person_code_upd  varchar (50) 
,loca_code_cust  varchar (50) 
,person_name_upd  varchar (100) 
,itm_name  varchar (100) 
,person_code_chrg_bill  varchar (50) 
,crr_name_cust  varchar (100) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,loca_name_cust  varchar (100) 
,loca_name_custrcvplc  varchar (100) 
,loca_name_asstwh  varchar (100) 
,person_name_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,usrgrp_name_chrg_bill  varchar (100) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,crr_code_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,shelfno_code_fm  varchar (50) 
,shelfno_name_fm  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_sect_chrg_cpo  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,scrlv_code_chrg_cust  varchar (50) 
,person_code_chrg_cust  varchar (50) 
,person_name_chrg_cust  varchar (100) 
,loca_code_sect_chrg_cust  varchar (50) 
,loca_name_sect_chrg_cust  varchar (100) 
,usrgrp_code_chrg_cust  varchar (50) 
,usrgrp_name_chrg_cust  varchar (100) 
,scrlv_code_chrg_cpo  varchar (50) 
,usrgrp_code_chrg_cpo  varchar (50) 
,usrgrp_name_chrg_cpo  varchar (100) 
,person_code_chrg_cpo  varchar (50) 
,person_name_chrg_cpo  varchar (100) 
,loca_name_sect_chrg_cpo  varchar (100) 
,boxe_code  varchar (50) 
,usrgrp_code_chrg_asstwh  varchar (50) 
,usrgrp_name_chrg_asstwh  varchar (100) 
,person_code_chrg_asstwh  varchar (50) 
,person_name_chrg_asstwh  varchar (100) 
,loca_code_sect_chrg_asstwh  varchar (50) 
,loca_name_sect_chrg_asstwh  varchar (100) 
,scrlv_code_chrg_asstwh  varchar (50) 
,boxe_name  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,custact_qty  numeric (22,6)
,custact_sno  varchar (40) 
,custact_price  numeric (38,4)
,custact_tblid  numeric (38,0)
,custact_contract_price  varchar (1) 
,custact_isudate   timestamp(6) 
,custact_saledate   timestamp(6) 
,custact_amt  numeric (18,4)
,custact_tblname  varchar (30) 
,custact_expiredate   date 
,custact_remark  varchar (4000) 
,custact_opeitm_id  numeric (38,0)
,asstwh_chrg_id_asstwh  numeric (38,0)
,chrg_person_id_chrg_cpo  numeric (38,0)
,cust_bill_id  numeric (38,0)
,bill_loca_id_bill  numeric (38,0)
,custact_custrcvplc_id  numeric (38,0)
,custact_updated_at   timestamp(6) 
,custact_created_at   timestamp(6) 
,custact_update_ip  varchar (40) 
,bill_chrg_id_bill  numeric (22,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,cust_chrg_id_cust  numeric (38,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,asstwh_loca_id_asstwh  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,cust_loca_id_cust  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,chrg_person_id_chrg_asstwh  numeric (38,0)
,custact_chrg_id_cpo  numeric (38,0)
,custact_shelfno_id_fm  numeric (22,0)
,cust_crr_id_cust  numeric (38,0)
,custact_cust_id  numeric (38,0)
,custact_asstwh_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,person_sect_id_chrg_cust  numeric (22,0)
,itm_unit_id  numeric (22,0)
,person_sect_id_chrg_bill  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,person_sect_id_chrg_cpo  numeric (22,0)
,person_sect_id_chrg_asstwh  numeric (22,0)
,custact_person_id_upd  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
,id  numeric (38,0)
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
prdact.packno  prdact_packno
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
,itm_code  varchar (50) 
,loca_code_workplace  varchar (50) 
,loca_name_workplace  varchar (100) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,itm_name  varchar (100) 
,person_code_chrg_workplace  varchar (50) 
,loca_code  varchar (50) 
,person_name_chrg_workplace  varchar (100) 
,loca_name  varchar (100) 
,scrlv_code_chrg_workplace  varchar (50) 
,loca_code_sect_chrg_workplace  varchar (50) 
,loca_name_sect_chrg_workplace  varchar (100) 
,usrgrp_code_chrg_workplace  varchar (50) 
,usrgrp_name_chrg_workplace  varchar (100) 
,shelfno_code_to  varchar (50) 
,prjno_name  varchar (100) 
,shelfno_name_to  varchar (100) 
,unit_code  varchar (50) 
,prjno_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,loca_code_shelfno_to  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,boxe_code  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,boxe_name  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,prdact_packno  varchar (10) 
,prdact_cmpldate   timestamp(6) 
,prdact_isudate   timestamp(6) 
,prdact_sno  varchar (40) 
,prdact_cno  varchar (40) 
,prdact_gno  varchar (40) 
,prdact_lotno  varchar (50) 
,prdact_qty_stk  numeric (22,6)
,prdact_sno_prdord  varchar (50) 
,prdact_sno_prdinst  varchar (50) 
,prdact_cno_prdinst  varchar (50) 
,prdact_expiredate   date 
,prdact_remark  varchar (4000) 
,prdact_contents  varchar (4000) 
,prjno_code_chil  varchar (50) 
,prdact_prjno_id  numeric (38,0)
,prdact_chrg_id  numeric (38,0)
,prdact_update_ip  varchar (40) 
,prdact_created_at   timestamp(6) 
,shelfno_loca_id_shelfno_to  numeric (38,0)
,workplace_loca_id_workplace  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,prdact_shelfno_id_to  numeric (38,0)
,prdact_workplace_id  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,workplace_chrg_id_workplace  numeric (22,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,prdact_updated_at   timestamp(6) 
,prdact_opeitm_id  numeric (38,0)
,person_sect_id_chrg_workplace  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,chrg_person_id_chrg_workplace  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,prdact_person_id_upd  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,id  numeric (38,0)
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
  drop view if  exists r_billacts cascade ; 
 create or replace view r_billacts as select  
  itm.itm_name  itm_name ,
  itm.itm_code  itm_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_unit_id  itm_unit_id ,
billact.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
  bill.bill_loca_id_bill  bill_loca_id_bill ,
  bill.loca_code_bill  loca_code_bill ,
  bill.loca_name_bill  loca_name_bill ,
billact.isudate  billact_isudate,
billact.expiredate  billact_expiredate,
billact.updated_at  billact_updated_at,
billact.qty  billact_qty,
billact.sno  billact_sno,
billact.price  billact_price,
billact.itms_id   billact_itm_id,
billact.remark  billact_remark,
billact.created_at  billact_created_at,
billact.update_ip  billact_update_ip,
billact.amt  billact_amt,
billact.tblid  billact_tblid,
billact.tblname  billact_tblname,
billact.tax  billact_tax,
billact.persons_id_upd   billact_person_id_upd,
billact.contents  billact_contents,
billact.orgtblname  billact_orgtblname,
billact.orgtblid  billact_orgtblid,
billact.bills_id   billact_bill_id,
billact.saledate  billact_saledate,
billact.paymentdate  billact_paymentdate,
  bill.bill_chrg_id_bill  bill_chrg_id_bill ,
  bill.person_code_chrg_bill  person_code_chrg_bill ,
  bill.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  bill.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  bill.person_name_chrg_bill  person_name_chrg_bill ,
  itm.itm_classlist_id  itm_classlist_id ,
  bill.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  bill.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  bill.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  bill.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  bill.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  bill.bill_crr_id_bill  bill_crr_id_bill ,
  bill.crr_code_bill  crr_code_bill ,
  bill.crr_name_bill  crr_name_bill 
 from billacts   billact,
  r_itms  itm ,  r_persons  person_upd ,  r_bills  bill 
  where       billact.itms_id = itm.id      and billact.persons_id_upd = person_upd.id      and billact.bills_id = bill.id     ;
 DROP TABLE IF EXISTS sio.sio_r_billacts;
 CREATE TABLE sio.sio_r_billacts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_billacts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,loca_code_bill  varchar (50) 
,itm_code  varchar (50) 
,loca_name_bill  varchar (100) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,itm_name  varchar (100) 
,person_code_chrg_bill  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,usrgrp_name_chrg_bill  varchar (100) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,crr_code_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,billact_tblname  varchar (30) 
,billact_tax  numeric (38,4)
,billact_orgtblid  numeric (38,0)
,billact_isudate   timestamp(6) 
,billact_qty  numeric (22,6)
,billact_sno  varchar (40) 
,billact_price  numeric (38,4)
,billact_amt  numeric (18,4)
,billact_tblid  numeric (38,0)
,billact_orgtblname  varchar (30) 
,billact_saledate   timestamp(6) 
,billact_paymentdate   timestamp(6) 
,billact_expiredate   date 
,billact_remark  varchar (4000) 
,billact_contents  varchar (4000) 
,billact_update_ip  varchar (40) 
,bill_loca_id_bill  numeric (38,0)
,billact_updated_at   timestamp(6) 
,bill_chrg_id_bill  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,billact_created_at   timestamp(6) 
,billact_itm_id  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,billact_bill_id  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,itm_unit_id  numeric (22,0)
,billact_person_id_upd  numeric (22,0)
,id  numeric (38,0)
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
 CREATE INDEX sio_r_billacts_uk1 
  ON sio.sio_r_billacts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_billacts_seq ;
 create sequence sio.sio_r_billacts_seq ;
  drop view if  exists r_payacts cascade ; 
 create or replace view r_payacts as select  
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
payact.id id,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
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
  crr_pur.crr_name  crr_name_pur ,
  crr_pur.crr_code  crr_code_pur ,
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
  payment_pay.scrlv_code_chrg_payment  scrlv_code_chrg_payment_pay ,
  payment_pay.payment_chrg_id_payment  payment_chrg_id_payment_pay ,
  payment_pay.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment_pay ,
  payment_pay.loca_code_payment  loca_code_payment_pay ,
  payment_pay.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment_pay ,
  payment_pay.loca_name_payment  loca_name_payment_pay ,
  payment_pay.person_code_chrg_payment  person_code_chrg_payment_pay ,
  payment_pay.person_name_chrg_payment  person_name_chrg_payment_pay ,
  payment_pay.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment_pay ,
  payment_pay.person_sect_id_chrg_payment  person_sect_id_chrg_payment_pay ,
  payment_pay.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment_pay ,
  payment_pay.payment_loca_id_payment  payment_loca_id_payment_pay ,
  payment_pay.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment_pay ,
payact.price  payact_price,
payact.remark  payact_remark,
payact.created_at  payact_created_at,
payact.update_ip  payact_update_ip,
payact.duedate  payact_duedate,
payact.amt  payact_amt,
payact.isudate  payact_isudate,
payact.expiredate  payact_expiredate,
payact.updated_at  payact_updated_at,
payact.persons_id_upd   payact_person_id_upd,
payact.contents  payact_contents,
payact.tax  payact_tax,
payact.contract_price  payact_contract_price,
payact.sno_payinst  payact_sno_payinst,
payact.chrgs_id   payact_chrg_id,
payact.itm_code_client  payact_itm_code_client,
payact.suppliers_id   payact_supplier_id,
payact.crrs_id_pur   payact_crr_id_pur,
payact.payments_id_pay   payact_payment_id_pay,
payact.sno  payact_sno,
  supplier.payment_crr_id_payment  payment_crr_id_payment ,
  supplier.crr_code_payment  crr_code_payment ,
  supplier.crr_name_payment  crr_name_payment ,
  payment_pay.payment_crr_id_payment  payment_crr_id_payment_pay ,
  payment_pay.crr_code_payment  crr_code_payment_pay ,
  payment_pay.crr_name_payment  crr_name_payment_pay 
 from payacts   payact,
  r_persons  person_upd ,  r_chrgs  chrg ,  r_suppliers  supplier ,  r_crrs  crr_pur ,  r_payments  payment_pay 
  where       payact.persons_id_upd = person_upd.id      and payact.chrgs_id = chrg.id      and payact.suppliers_id = supplier.id      and payact.crrs_id_pur = crr_pur.id      and payact.payments_id_pay = payment_pay.id     ;
 DROP TABLE IF EXISTS sio.sio_r_payacts;
 CREATE TABLE sio.sio_r_payacts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_payacts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,loca_code_supplier  varchar (50) 
,crr_code_payment_pay  varchar (50) 
,loca_code_payment_pay  varchar (50) 
,crr_code_payment  varchar (50) 
,payact_itm_code_client  varchar (50) 
,crr_code_pur  varchar (50) 
,loca_name_payment_pay  varchar (100) 
,person_code_upd  varchar (50) 
,loca_name_supplier  varchar (100) 
,person_name_upd  varchar (100) 
,crr_name_pur  varchar (100) 
,crr_name_payment_pay  varchar (100) 
,crr_name_payment  varchar (100) 
,person_code_chrg_payment_pay  varchar (50) 
,person_name_chrg_payment_pay  varchar (100) 
,loca_code_sect_chrg_payment_pay  varchar (50) 
,loca_name_sect_chrg_payment_pay  varchar (100) 
,usrgrp_code_chrg_payment_pay  varchar (50) 
,usrgrp_name_chrg_payment_pay  varchar (100) 
,scrlv_code_chrg_payment_pay  varchar (50) 
,person_code_chrg_supplier  varchar (50) 
,person_name_chrg_supplier  varchar (100) 
,usrgrp_code_chrg_supplier  varchar (50) 
,usrgrp_name_chrg_payment  varchar (100) 
,loca_code_sect_chrg_supplier  varchar (50) 
,loca_name_sect_chrg_supplier  varchar (100) 
,scrlv_code_chrg_supplier  varchar (50) 
,crr_code_supplier  varchar (50) 
,crr_name_supplier  varchar (100) 
,loca_code_payment  varchar (50) 
,loca_name_payment  varchar (100) 
,person_code_chrg_payment  varchar (50) 
,person_name_chrg_payment  varchar (100) 
,scrlv_code_chrg_payment  varchar (50) 
,usrgrp_code_chrg_payment  varchar (50) 
,usrgrp_name_chrg_supplier  varchar (100) 
,loca_code_sect_chrg_payment  varchar (50) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,person_code_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,person_name_chrg  varchar (100) 
,payact_sno  varchar (40) 
,payact_price  numeric (38,4)
,payact_duedate   timestamp(6) 
,payact_amt  numeric (18,4)
,payact_isudate   timestamp(6) 
,payact_tax  numeric (38,4)
,payact_contract_price  varchar (1) 
,payact_sno_payinst  varchar (50) 
,payact_expiredate   date 
,payact_remark  varchar (4000) 
,payact_contents  varchar (4000) 
,payact_created_at   timestamp(6) 
,payact_update_ip  varchar (40) 
,payment_crr_id_payment  numeric (22,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,payment_loca_id_payment_pay  numeric (38,0)
,supplier_payment_id  numeric (38,0)
,payact_updated_at   timestamp(6) 
,payment_crr_id_payment_pay  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
,payact_chrg_id  numeric (38,0)
,payact_supplier_id  numeric (22,0)
,payact_crr_id_pur  numeric (22,0)
,payact_payment_id_pay  numeric (22,0)
,payment_chrg_id_payment_pay  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,chrg_person_id_chrg_payment_pay  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
,person_sect_id_chrg_payment_pay  numeric (22,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,payment_chrg_id_payment  numeric (22,0)
,payact_person_id_upd  numeric (22,0)
,id  numeric (38,0)
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
 CREATE INDEX sio_r_payacts_uk1 
  ON sio.sio_r_payacts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_payacts_seq ;
 create sequence sio.sio_r_payacts_seq ;
  drop view if  exists r_puracts cascade ; 
 create or replace view r_puracts as select  
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
puract.id id,
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
puract.opeitms_id   puract_opeitm_id,
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
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
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
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
puract.lotno  puract_lotno,
puract.itm_code_client  puract_itm_code_client,
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
  crr_pur.crr_name  crr_name_pur ,
  crr_pur.crr_code  crr_code_pur ,
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
  supplier.payment_crr_id_payment  payment_crr_id_payment ,
  supplier.crr_code_payment  crr_code_payment ,
  supplier.crr_name_payment  crr_name_payment 
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
,crr_code_pur  varchar (50) 
,crr_code_payment  varchar (50) 
,crr_code  varchar (50) 
,loca_code_supplier  varchar (50) 
,itm_code  varchar (50) 
,puract_itm_code_client  varchar (50) 
,person_code_upd  varchar (50) 
,loca_name_supplier  varchar (100) 
,person_name_upd  varchar (100) 
,itm_name  varchar (100) 
,crr_name_payment  varchar (100) 
,loca_code  varchar (50) 
,crr_name_pur  varchar (100) 
,crr_name  varchar (100) 
,loca_name  varchar (100) 
,person_code_chrg_supplier  varchar (50) 
,person_name_chrg_supplier  varchar (100) 
,usrgrp_code_chrg_supplier  varchar (50) 
,usrgrp_name_chrg_payment  varchar (100) 
,loca_code_sect_chrg_supplier  varchar (50) 
,loca_name_sect_chrg_supplier  varchar (100) 
,scrlv_code_chrg_supplier  varchar (50) 
,crr_code_supplier  varchar (50) 
,crr_name_supplier  varchar (100) 
,loca_code_payment  varchar (50) 
,loca_name_payment  varchar (100) 
,person_code_chrg_payment  varchar (50) 
,person_name_chrg_payment  varchar (100) 
,scrlv_code_chrg_payment  varchar (50) 
,usrgrp_code_chrg_payment  varchar (50) 
,usrgrp_name_chrg_supplier  varchar (100) 
,loca_code_sect_chrg_payment  varchar (50) 
,loca_name_sect_chrg_payment  varchar (100) 
,shelfno_code_to  varchar (50) 
,prjno_name  varchar (100) 
,shelfno_name_to  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,prjno_code  varchar (50) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,loca_code_shelfno_to  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,boxe_code  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,loca_name_shelfno_to  varchar (100) 
,person_name_chrg  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,person_code_chrg  varchar (50) 
,boxe_name  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,puract_sno_purinst  varchar (50) 
,puract_isudate   timestamp(6) 
,puract_rcptdate   timestamp(6) 
,puract_sno  varchar (40) 
,puract_cno  varchar (40) 
,puract_packno  varchar (10) 
,puract_qty_stk  numeric (22,6)
,puract_cno_purdlv  varchar (50) 
,puract_cno_purinst  varchar (50) 
,puract_lotno  varchar (50) 
,puract_sno_purdlv  varchar (50) 
,puract_sno_purord  varchar (50) 
,puract_expiredate   date 
,puract_remark  varchar (4000) 
,puract_contents  varchar (4000) 
,prjno_code_chil  varchar (50) 
,puract_chrg_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,puract_opeitm_id  numeric (38,0)
,puract_update_ip  varchar (40) 
,puract_created_at   timestamp(6) 
,puract_updated_at   timestamp(6) 
,chrg_person_id_chrg  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,puract_prjno_id  numeric (38,0)
,supplier_payment_id  numeric (38,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
,puract_supplier_id  numeric (22,0)
,puract_crr_id_pur  numeric (22,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,puract_shelfno_id_to  numeric (38,0)
,puract_crr_id  numeric (22,0)
,payment_crr_id_payment  numeric (22,0)
,payment_chrg_id_payment  numeric (22,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,itm_unit_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,payment_loca_id_payment  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,puract_person_id_upd  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
,id  numeric (38,0)
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
  drop view if  exists r_shpacts cascade ; 
 create or replace view r_shpacts as select  
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  itm.itm_name  itm_name ,
  itm.itm_code  itm_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_unit_id  itm_unit_id ,
  transport.transport_code  transport_code ,
  transport.transport_name  transport_name ,
shpact.id id,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  prjno.prjno_code  prjno_code ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
shpact.qty  shpact_qty,
shpact.sno  shpact_sno,
shpact.price  shpact_price,
shpact.remark  shpact_remark,
shpact.created_at  shpact_created_at,
shpact.update_ip  shpact_update_ip,
shpact.amt  shpact_amt,
shpact.tax  shpact_tax,
shpact.persons_id_upd   shpact_person_id_upd,
shpact.contents  shpact_contents,
shpact.contract_price  shpact_contract_price,
shpact.chrgs_id   shpact_chrg_id,
shpact.gno  shpact_gno,
shpact.isudate  shpact_isudate,
shpact.cartonno  shpact_cartonno,
shpact.prjnos_id   shpact_prjno_id,
shpact.expiredate  shpact_expiredate,
shpact.updated_at  shpact_updated_at,
shpact.box  shpact_box,
shpact.duedate  shpact_duedate,
shpact.qty_case  shpact_qty_case,
shpact.cno  shpact_cno,
  prjno.prjno_code_chil  prjno_code_chil ,
shpact.transports_id   shpact_transport_id,
  itm.itm_classlist_id  itm_classlist_id ,
shpact.starttime  shpact_starttime,
shpact.processseq  shpact_processseq,
shpact.sno_shpord  shpact_sno_shpord,
shpact.gno_shpord  shpact_gno_shpord,
shpact.itms_id   shpact_itm_id,
shpact.paretblname  shpact_paretblname,
shpact.paretblid  shpact_paretblid,
shpact.qty_stk  shpact_qty_stk,
shpact.crrs_id   shpact_crr_id,
shpact.gno_shpinst  shpact_gno_shpinst
 from shpacts   shpact,
  r_persons  person_upd ,  r_chrgs  chrg ,  r_prjnos  prjno ,  r_transports  transport ,  r_itms  itm ,  r_crrs  crr 
  where       shpact.persons_id_upd = person_upd.id      and shpact.chrgs_id = chrg.id      and shpact.prjnos_id = prjno.id      and shpact.transports_id = transport.id      and shpact.itms_id = itm.id      and shpact.crrs_id = crr.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shpacts;
 CREATE TABLE sio.sio_r_shpacts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shpacts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,crr_code  varchar (50) 
,itm_code  varchar (50) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,itm_name  varchar (100) 
,crr_name  varchar (100) 
,transport_code  varchar (50) 
,transport_name  varchar (100) 
,prjno_name  varchar (100) 
,prjno_code  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,classlist_code  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,classlist_name  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,shpact_gno_shpinst  varchar (50) 
,shpact_price  numeric (38,4)
,shpact_amt  numeric (18,4)
,shpact_tax  numeric (38,4)
,shpact_contract_price  varchar (1) 
,shpact_gno  varchar (40) 
,shpact_isudate   timestamp(6) 
,shpact_cartonno  varchar (20) 
,shpact_box  varchar (50) 
,shpact_duedate   timestamp(6) 
,shpact_qty_case  numeric (22,0)
,shpact_cno  varchar (40) 
,shpact_starttime   timestamp(6) 
,shpact_processseq  numeric (38,0)
,shpact_sno_shpord  varchar (50) 
,shpact_gno_shpord  varchar (50) 
,shpact_paretblname  varchar (30) 
,shpact_paretblid  numeric (38,0)
,shpact_qty_stk  numeric (22,6)
,shpact_qty  numeric (22,6)
,shpact_sno  varchar (40) 
,shpact_expiredate   date 
,shpact_remark  varchar (4000) 
,shpact_contents  varchar (4000) 
,prjno_code_chil  varchar (50) 
,shpact_update_ip  varchar (40) 
,itm_classlist_id  numeric (38,0)
,shpact_crr_id  numeric (22,0)
,shpact_transport_id  numeric (38,0)
,shpact_prjno_id  numeric (38,0)
,shpact_updated_at   timestamp(6) 
,shpact_created_at   timestamp(6) 
,shpact_itm_id  numeric (38,0)
,shpact_chrg_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,shpact_person_id_upd  numeric (22,0)
,itm_unit_id  numeric (22,0)
,id  numeric (38,0)
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
 CREATE INDEX sio_r_shpacts_uk1 
  ON sio.sio_r_shpacts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpacts_seq ;
 create sequence sio.sio_r_shpacts_seq ;
