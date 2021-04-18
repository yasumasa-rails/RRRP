
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
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,itm_code  varchar (50) 
,shelfno_code  varchar (50) 
,unit_code  varchar (50) 
,loca_code  varchar (50) 
,boxe_code  varchar (50) 
,classlist_code  varchar (50) 
,loca_name  varchar (100) 
,boxe_name  varchar (100) 
,unit_name  varchar (100) 
,shelfno_name  varchar (100) 
,itm_name  varchar (100) 
,classlist_name  varchar (100) 
,loca_code_custrcvplc  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,crr_code_bill  varchar (50) 
,loca_code_cust  varchar (50) 
,unit_code_box  varchar (50) 
,loca_code_sect_chrg_bill  varchar (50) 
,scrlv_code_chrg_bill  varchar (50) 
,unit_code_case  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_shelfno  varchar (50) 
,scrlv_code_chrg_cust  varchar (50) 
,shelfno_code_fm  varchar (50) 
,person_code_chrg_cust  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,loca_code_sect_chrg_cust  varchar (50) 
,usrgrp_code_chrg_cust  varchar (50) 
,scrlv_code_chrg_cpo  varchar (50) 
,usrgrp_code_chrg_cpo  varchar (50) 
,person_code_chrg_cpo  varchar (50) 
,loca_code_sect_chrg_cpo  varchar (50) 
,person_code_chrg_bill  varchar (50) 
,loca_code_bill  varchar (50) 
,unit_code_outbox  varchar (50) 
,loca_name_sect_chrg_cust  varchar (100) 
,usrgrp_name_chrg_bill  varchar (100) 
,usrgrp_name_chrg_cust  varchar (100) 
,unit_name_box  varchar (100) 
,unit_name_outbox  varchar (100) 
,unit_name_case  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,loca_name_custrcvplc  varchar (100) 
,usrgrp_name_chrg_cpo  varchar (100) 
,loca_name_bill  varchar (100) 
,loca_name_shelfno  varchar (100) 
,shelfno_name_fm  varchar (100) 
,person_name_chrg_cpo  varchar (100) 
,crr_name_bill  varchar (100) 
,person_name_chrg_bill  varchar (100) 
,loca_name_sect_chrg_cpo  varchar (100) 
,person_name_chrg_cust  varchar (100) 
,loca_name_cust  varchar (100) 
,loca_name_sect_chrg_bill  varchar (100) 
,custdlv_opeitm_id  numeric (38,0)
,id  numeric (38,0)
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
,opeitm_loca_id  numeric (38,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,asstwh_chrg_id_asstwh  numeric (22,0)
,chrg_person_id_chrg_cpo  numeric (38,0)
,cust_bill_id  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,bill_chrg_id_bill  numeric (22,0)
,bill_loca_id_bill  numeric (38,0)
,person_sect_id_chrg_cpo  numeric (22,0)
,person_sect_id_chrg_cust  numeric (22,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,cust_chrg_id_cust  numeric (38,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,asstwh_loca_id_asstwh  numeric (22,0)
,cust_loca_id_cust  numeric (38,0)
,custdlv_person_id_upd  numeric (22,0)
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
  drop view if  exists r_custwhs cascade ; 
 create or replace view r_custwhs as select  
  custrcvplc.loca_code_custrcvplc  loca_code_custrcvplc ,
  custrcvplc.loca_name_custrcvplc  loca_name_custrcvplc ,
custwh.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  custrcvplc.custrcvplc_loca_id_custrcvplc  custrcvplc_loca_id_custrcvplc ,
custwh.qty_sch  custwh_qty_sch,
custwh.duedate  custwh_duedate,
custwh.remark  custwh_remark,
custwh.created_at  custwh_created_at,
custwh.update_ip  custwh_update_ip,
custwh.expiredate  custwh_expiredate,
custwh.updated_at  custwh_updated_at,
custwh.qty  custwh_qty,
custwh.persons_id_upd   custwh_person_id_upd,
custwh.inoutflg  custwh_inoutflg,
custwh.lotno  custwh_lotno,
custwh.qty_stk  custwh_qty_stk,
custwh.packno  custwh_packno,
custwh.custrcvplcs_id   custwh_custrcvplc_id
 from custwhs   custwh,
  r_persons  person_upd ,  r_custrcvplcs  custrcvplc 
  where       custwh.persons_id_upd = person_upd.id      and custwh.custrcvplcs_id = custrcvplc.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custwhs;
 CREATE TABLE sio.sio_r_custwhs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custwhs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,person_name_upd  varchar (100) 
,loca_code_custrcvplc  varchar (50) 
,loca_name_custrcvplc  varchar (100) 
,custwh_custrcvplc_id  numeric (38,0)
,custwh_lotno  varchar (50) 
,custwh_qty_stk  numeric (22,6)
,custwh_packno  varchar (10) 
,custwh_qty_sch  numeric (22,6)
,custwh_duedate   timestamp(6) 
,custwh_remark  varchar (4000) 
,custwh_created_at   timestamp(6) 
,custwh_update_ip  varchar (40) 
,custwh_expiredate   date 
,custwh_updated_at   timestamp(6) 
,custwh_qty  numeric (22,6)
,custwh_inoutflg  varchar (20) 
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,id  numeric (38,0)
,custwh_person_id_upd  numeric (22,0)
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
 CREATE INDEX sio_r_custwhs_uk1 
  ON sio.sio_r_custwhs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custwhs_seq ;
 create sequence sio.sio_r_custwhs_seq ;
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
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,shelfno_code  varchar (50) 
,itm_code  varchar (50) 
,unit_code  varchar (50) 
,loca_code  varchar (50) 
,classlist_code  varchar (50) 
,boxe_code  varchar (50) 
,loca_name  varchar (100) 
,itm_name  varchar (100) 
,shelfno_name  varchar (100) 
,unit_name  varchar (100) 
,classlist_name  varchar (100) 
,boxe_name  varchar (100) 
,loca_code_bill  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,loca_code_cust  varchar (50) 
,loca_code_custrcvplc  varchar (50) 
,crr_code_bill  varchar (50) 
,loca_code_sect_chrg_bill  varchar (50) 
,scrlv_code_chrg_bill  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,shelfno_code_fm  varchar (50) 
,unit_code_case  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,loca_code_shelfno  varchar (50) 
,person_code_chrg_bill  varchar (50) 
,scrlv_code_chrg_cust  varchar (50) 
,unit_code_outbox  varchar (50) 
,person_code_chrg_cust  varchar (50) 
,unit_code_box  varchar (50) 
,loca_code_sect_chrg_cust  varchar (50) 
,usrgrp_code_chrg_cust  varchar (50) 
,scrlv_code_chrg_cpo  varchar (50) 
,usrgrp_code_chrg_cpo  varchar (50) 
,person_code_chrg_cpo  varchar (50) 
,loca_code_sect_chrg_cpo  varchar (50) 
,loca_name_cust  varchar (100) 
,loca_name_sect_chrg_cust  varchar (100) 
,loca_name_bill  varchar (100) 
,loca_name_shelfno  varchar (100) 
,usrgrp_name_chrg_bill  varchar (100) 
,usrgrp_name_chrg_cust  varchar (100) 
,unit_name_box  varchar (100) 
,usrgrp_name_chrg_cpo  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_custrcvplc  varchar (100) 
,person_name_chrg_cust  varchar (100) 
,shelfno_name_fm  varchar (100) 
,crr_name_bill  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,person_name_chrg_cpo  varchar (100) 
,unit_name_case  varchar (100) 
,person_name_chrg_bill  varchar (100) 
,unit_name_outbox  varchar (100) 
,loca_name_sect_chrg_cpo  varchar (100) 
,loca_name_sect_chrg_bill  varchar (100) 
,custinst_opeitm_id  numeric (38,0)
,custinst_gno  varchar (40) 
,custinst_chrg_id_cpo  numeric (38,0)
,custinst_shelfno_id_fm  numeric (22,0)
,custinst_starttime   timestamp(6) 
,custinst_isudate   timestamp 
,custinst_duedate   timestamp 
,custinst_qty  numeric (38,4)
,custinst_price  numeric (38,4)
,custinst_amt  numeric (38,4)
,custinst_contract_price  varchar (1) 
,custinst_expiredate   date 
,custinst_sno  varchar (40) 
,custinst_remark  varchar (4000) 
,custinst_cno  varchar (40) 
,custinst_itm_code_client  varchar (50) 
,asstwh_chrg_id_asstwh  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,person_sect_id_chrg_cust  numeric (22,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,cust_chrg_id_cust  numeric (38,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,bill_chrg_id_bill  numeric (22,0)
,itm_unit_id  numeric (22,0)
,person_sect_id_chrg_cpo  numeric (22,0)
,cust_bill_id  numeric (38,0)
,chrg_person_id_chrg_cpo  numeric (38,0)
,asstwh_loca_id_asstwh  numeric (22,0)
,cust_loca_id_cust  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,bill_loca_id_bill  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,custinst_cust_id  numeric (22,0)
,custinst_created_at   timestamp(6) 
,custinst_person_id_upd  numeric (22,0)
,custinst_update_ip  varchar (40) 
,custinst_asstwh_id  numeric (22,0)
,custinst_updated_at   timestamp(6) 
,custinst_custrcvplc_id  numeric (22,0)
,id  numeric (22,0)
,custinst_id  numeric (22,0)
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
  drop view if  exists r_custords cascade ; 
 create or replace view r_custords as select  
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
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
custord.prjnos_id   custord_prjno_id,
custord.gno  custord_gno,
  custrcvplc.custrcvplc_loca_id_custrcvplc  custrcvplc_loca_id_custrcvplc ,
custord.contract_price  custord_contract_price,
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
custord.opeitms_id   custord_opeitm_id,
custord.cno_custsch  custord_cno_custsch,
  cust.bill_crr_id_bill  bill_crr_id_bill ,
  cust.crr_code_bill  crr_code_bill ,
  cust.crr_name_bill  crr_name_bill ,
custord.starttime  custord_starttime,
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
,custord_duedate   timestamp(6) 
,custord_qty  numeric (18,4)
,custord_price  numeric (22,0)
,custord_contract_price  varchar (1) 
,custord_itm_code_client  varchar (50) 
,custord_amt  numeric (18,4)
,person_code_chrg_cust  varchar (50) 
,person_name_chrg_cust  varchar (100) 
,loca_code_sect_chrg_cust  varchar (50) 
,loca_name_sect_chrg_cust  varchar (100) 
,person_code_chrg_bill  varchar (50) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,loca_code_bill  varchar (50) 
,loca_name_bill  varchar (100) 
,boxe_code  varchar (50) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,loca_code  varchar (50) 
,scrlv_code_chrg_cust  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,boxe_name  varchar (100) 
,usrgrp_name_chrg_bill  varchar (100) 
,loca_name  varchar (100) 
,usrgrp_code_chrg_cust  varchar (50) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,usrgrp_name_chrg_cust  varchar (100) 
,crr_code_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,classlist_code  varchar (50) 
,custord_starttime   timestamp(6) 
,custord_cno_custsch  varchar (50) 
,classlist_name  varchar (100) 
,custord_sno  varchar (40) 
,loca_code_custrcvplc  varchar (50) 
,scrlv_code_chrg_cpo  varchar (50) 
,usrgrp_code_chrg_cpo  varchar (50) 
,person_code_chrg_cpo  varchar (50) 
,loca_code_sect_chrg_cpo  varchar (50) 
,shelfno_code_fm  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,prjno_name_chil  varchar (100) 
,usrgrp_name_chrg_cpo  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,person_name_chrg_cpo  varchar (100) 
,loca_name_sect_chrg_cpo  varchar (100) 
,loca_name_custrcvplc  varchar (100) 
,shelfno_name_fm  varchar (100) 
,custord_shelfno_id_fm  numeric (22,0)
,custord_gno  varchar (40) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,custord_toduedate   timestamp(6) 
,custord_expiredate   date 
,custord_contents  varchar (4000) 
,custord_remark  varchar (4000) 
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,bill_chrg_id_bill  numeric (22,0)
,chrg_person_id_chrg_cpo  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,person_sect_id_chrg_cpo  numeric (22,0)
,bill_loca_id_bill  numeric (38,0)
,custord_prjno_id  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,custord_chrg_id_cpo  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,cust_loca_id_cust  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,custord_custrcvplc_id  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,custord_opeitm_id  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,opeitm_loca_id  numeric (38,0)
,cust_chrg_id_cust  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,person_sect_id_chrg_cust  numeric (22,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,custord_person_id_upd  numeric (22,0)
,custord_created_at   timestamp(6) 
,id  numeric (22,0)
,custord_updated_at   timestamp(6) 
,custord_id  numeric (22,0)
,custord_update_ip  varchar (40) 
,cust_bill_id  numeric (22,0)
,custord_cust_id  numeric (22,0)
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
,person_name_upd  varchar (100) 
,itm_code  varchar (50) 
,boxe_code  varchar (50) 
,shelfno_code  varchar (50) 
,unit_code  varchar (50) 
,loca_code  varchar (50) 
,classlist_code  varchar (50) 
,loca_name  varchar (100) 
,boxe_name  varchar (100) 
,classlist_name  varchar (100) 
,unit_name  varchar (100) 
,itm_name  varchar (100) 
,shelfno_name  varchar (100) 
,loca_code_custrcvplc  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,loca_code_cust  varchar (50) 
,unit_code_outbox  varchar (50) 
,crr_code_bill  varchar (50) 
,unit_code_case  varchar (50) 
,loca_code_sect_chrg_bill  varchar (50) 
,scrlv_code_chrg_bill  varchar (50) 
,loca_code_shelfno  varchar (50) 
,scrlv_code_chrg_cust  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,person_code_chrg_cust  varchar (50) 
,shelfno_code_fm  varchar (50) 
,loca_code_sect_chrg_cust  varchar (50) 
,usrgrp_code_chrg_cust  varchar (50) 
,scrlv_code_chrg_cpo  varchar (50) 
,usrgrp_code_chrg_cpo  varchar (50) 
,person_code_chrg_cpo  varchar (50) 
,loca_code_sect_chrg_cpo  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,loca_code_bill  varchar (50) 
,person_code_chrg_bill  varchar (50) 
,unit_code_box  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,unit_name_outbox  varchar (100) 
,usrgrp_name_chrg_cust  varchar (100) 
,loca_name_bill  varchar (100) 
,usrgrp_name_chrg_bill  varchar (100) 
,crr_name_bill  varchar (100) 
,loca_name_sect_chrg_bill  varchar (100) 
,usrgrp_name_chrg_cpo  varchar (100) 
,unit_name_case  varchar (100) 
,unit_name_box  varchar (100) 
,loca_name_custrcvplc  varchar (100) 
,loca_name_cust  varchar (100) 
,person_name_chrg_cpo  varchar (100) 
,person_name_chrg_cust  varchar (100) 
,person_name_chrg_bill  varchar (100) 
,loca_name_sect_chrg_cust  varchar (100) 
,loca_name_shelfno  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_sect_chrg_cpo  varchar (100) 
,shelfno_name_fm  varchar (100) 
,custact_opeitm_id  numeric (38,0)
,custact_shelfno_id_fm  numeric (22,0)
,custact_chrg_id_cpo  numeric (38,0)
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
,person_sect_id_chrg_bill  numeric (22,0)
,bill_crr_id_bill  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,asstwh_chrg_id_asstwh  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,asstwh_loca_id_asstwh  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,cust_loca_id_cust  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,bill_chrg_id_bill  numeric (22,0)
,chrg_person_id_chrg_cpo  numeric (38,0)
,cust_bill_id  numeric (38,0)
,bill_loca_id_bill  numeric (38,0)
,person_sect_id_chrg_cpo  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,person_sect_id_chrg_cust  numeric (22,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,cust_chrg_id_cust  numeric (38,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,custact_created_at   timestamp(6) 
,custact_update_ip  varchar (40) 
,custact_custrcvplc_id  numeric (22,0)
,custact_id  numeric (22,0)
,custact_person_id_upd  numeric (22,0)
,custact_cust_id  numeric (22,0)
,id  numeric (22,0)
,custact_asstwh_id  numeric (22,0)
,custact_updated_at   timestamp(6) 
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
