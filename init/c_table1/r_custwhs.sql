
 --- drop view r_custwhs cascade  
 create or replace view r_custwhs as select  
custwh.qty_sch  custwh_qty_sch,
custwh.duedate  custwh_duedate,
custwh.remark  custwh_remark,
custwh.created_at  custwh_created_at,
custwh.update_ip  custwh_update_ip,
custwh.expiredate  custwh_expiredate,
custwh.updated_at  custwh_updated_at,
custwh.qty  custwh_qty,
custwh.id id,
custwh.id  custwh_id,
custwh.persons_id_upd   custwh_person_id_upd,
custwh.inoutflg  custwh_inoutflg,
custwh.lotno  custwh_lotno,
custwh.qty_stk  custwh_qty_stk,
custwh.packno  custwh_packno,
custwh.custrcvplcs_id   custwh_custrcvplc_id,
custwh.alloctbls_id   custwh_alloctbl_id,
  custrcvplc.custrcvplc_name  custrcvplc_name ,
  custrcvplc.custrcvplc_code  custrcvplc_code ,
  custrcvplc.loca_code_cust_custrcvplc  loca_code_cust_custrcvplc ,
  custrcvplc.loca_name_cust_custrcvplc  loca_name_cust_custrcvplc ,
  custrcvplc.bill_loca_id_bill_custrcvplc  bill_loca_id_bill_custrcvplc ,
  custrcvplc.cust_loca_id_cust_custrcvplc  cust_loca_id_cust_custrcvplc ,
  custrcvplc.custrcvplc_cust_id_custrcvplc  custrcvplc_cust_id_custrcvplc ,
  custrcvplc.cust_bill_id_custrcvplc  cust_bill_id_custrcvplc ,
  custrcvplc.bill_chrg_id_bill_custrcvplc  bill_chrg_id_bill_custrcvplc ,
  custrcvplc.scrlv_code_chrg_bill_custrcvplc  scrlv_code_chrg_bill_custrcvplc ,
  custrcvplc.scrlv_code_chrg_cust_custrcvplc  scrlv_code_chrg_cust_custrcvplc ,
  custrcvplc.person_code_chrg_bill_custrcvplc  person_code_chrg_bill_custrcvplc ,
  custrcvplc.person_code_chrg_cust_custrcvplc  person_code_chrg_cust_custrcvplc ,
  custrcvplc.person_name_chrg_bill_custrcvplc  person_name_chrg_bill_custrcvplc ,
  custrcvplc.person_name_chrg_cust_custrcvplc  person_name_chrg_cust_custrcvplc ,
  custrcvplc.bill_crr_id_bill_custrcvplc  bill_crr_id_bill_custrcvplc ,
  custrcvplc.usrgrp_name_chrg_bill_custrcvplc  usrgrp_name_chrg_bill_custrcvplc ,
  custrcvplc.usrgrp_name_chrg_cust_custrcvplc  usrgrp_name_chrg_cust_custrcvplc ,
  custrcvplc.crr_code_bill_custrcvplc  crr_code_bill_custrcvplc ,
  custrcvplc.crr_name_bill_custrcvplc  crr_name_bill_custrcvplc ,
  custrcvplc.person_sect_id_chrg_bill_custrcvplc  person_sect_id_chrg_bill_custrcvplc ,
  custrcvplc.person_sect_id_chrg_cust_custrcvplc  person_sect_id_chrg_cust_custrcvplc ,
  custrcvplc.cust_chrg_id_cust_custrcvplc  cust_chrg_id_cust_custrcvplc ,
  custrcvplc.usrgrp_code_chrg_bill_custrcvplc  usrgrp_code_chrg_bill_custrcvplc ,
  custrcvplc.usrgrp_code_chrg_cust_custrcvplc  usrgrp_code_chrg_cust_custrcvplc ,
  custrcvplc.chrg_person_id_chrg_bill_custrcvplc  chrg_person_id_chrg_bill_custrcvplc ,
  custrcvplc.chrg_person_id_chrg_cust_custrcvplc  chrg_person_id_chrg_cust_custrcvplc ,
  alloctbl.unit_code  unit_code ,
  alloctbl.alloctbl_trngantt_id  alloctbl_trngantt_id ,
  alloctbl.itm_code  itm_code ,
  alloctbl.trngantt_itm_id  trngantt_itm_id ,
  alloctbl.trngantt_loca_id  trngantt_loca_id ,
  alloctbl.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  alloctbl.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  alloctbl.trngantt_loca_id_pare  trngantt_loca_id_pare ,
  alloctbl.trngantt_prjno_id  trngantt_prjno_id ,
  alloctbl.itm_classlist_id  itm_classlist_id ,
  alloctbl.itm_unit_id  itm_unit_id ,
  alloctbl.classlist_name  classlist_name ,
  alloctbl.classlist_code  classlist_code ,
  alloctbl.unit_name  unit_name ,
  alloctbl.loca_code  loca_code ,
  alloctbl.loca_name  loca_name ,
  alloctbl.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  alloctbl.shelfno_name_fm  shelfno_name_fm ,
  alloctbl.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  alloctbl.shelfno_code_fm  shelfno_code_fm ,
  alloctbl.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  alloctbl.itm_classlist_id_pare  itm_classlist_id_pare ,
  alloctbl.itm_unit_id_pare  itm_unit_id_pare ,
  alloctbl.classlist_name_pare  classlist_name_pare ,
  alloctbl.classlist_code_pare  classlist_code_pare ,
  alloctbl.unit_name_pare  unit_name_pare ,
  alloctbl.unit_code_pare  unit_code_pare ,
  alloctbl.itm_code_pare  itm_code_pare ,
  alloctbl.itm_name_pare  itm_name_pare ,
  alloctbl.loca_code_pare  loca_code_pare ,
  alloctbl.loca_name_pare  loca_name_pare ,
  alloctbl.prjno_name  prjno_name ,
  alloctbl.prjno_code  prjno_code ,
  alloctbl.prjno_code_chil  prjno_code_chil ,
  alloctbl.itm_name  itm_name 
 from custwhs   custwh,
  r_persons  person_upd ,  r_custrcvplcs  custrcvplc ,  r_alloctbls  alloctbl 
  where       custwh.persons_id_upd = person_upd.id      and custwh.custrcvplcs_id = custrcvplc.id      and custwh.alloctbls_id = alloctbl.id     ;
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
,usrgrp_name_chrg_cust_custrcvplc  varchar (100) 
,crr_code_bill_custrcvplc  varchar (50) 
,crr_name_bill_custrcvplc  varchar (100) 
,classlist_name  varchar (100) 
,itm_code  varchar (50) 
,unit_code  varchar (50) 
,usrgrp_code_chrg_bill_custrcvplc  varchar (50) 
,usrgrp_code_chrg_cust_custrcvplc  varchar (50) 
,loca_name_pare  varchar (100) 
,loca_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,prjno_code  varchar (50) 
,itm_name  varchar (100) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,itm_code_pare  varchar (50) 
,unit_code_pare  varchar (50) 
,unit_name_pare  varchar (100) 
,classlist_code_pare  varchar (50) 
,classlist_name_pare  varchar (100) 
,custrcvplc_name  varchar (100) 
,custrcvplc_code  varchar (50) 
,loca_code_cust_custrcvplc  varchar (50) 
,loca_name_cust_custrcvplc  varchar (100) 
,loca_code_shelfno_fm  varchar (50) 
,shelfno_code_fm  varchar (50) 
,shelfno_name_fm  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name  varchar (100) 
,loca_code  varchar (50) 
,unit_name  varchar (100) 
,scrlv_code_chrg_bill_custrcvplc  varchar (50) 
,scrlv_code_chrg_cust_custrcvplc  varchar (50) 
,person_code_chrg_bill_custrcvplc  varchar (50) 
,person_code_chrg_cust_custrcvplc  varchar (50) 
,person_name_chrg_bill_custrcvplc  varchar (100) 
,person_name_chrg_cust_custrcvplc  varchar (100) 
,classlist_code  varchar (50) 
,usrgrp_name_chrg_bill_custrcvplc  varchar (100) 
,custwh_qty_sch  numeric (22,6)
,custwh_duedate   timestamp(6) 
,custwh_expiredate   date 
,custwh_qty  numeric (22,6)
,custwh_inoutflg  varchar (20) 
,custwh_lotno  varchar (50) 
,custwh_qty_stk  numeric (22,6)
,custwh_packno  varchar (10) 
,alloctbl_contents  varchar (4000) 
,trngantt_processseq  numeric (38,0)
,trngantt_qty  numeric (18,4)
,trngantt_starttime   timestamp(6) 
,trngantt_qty_alloc  numeric (22,6)
,trngantt_duedate   timestamp(6) 
,alloctbl_qty_alloc  numeric (22,6)
,alloctbl_srctblname  varchar (30) 
,alloctbl_srctblid  numeric (38,0)
,alloctbl_qty_stk  numeric (22,6)
,alloctbl_qty_linkto_alloctbl  numeric (22,0)
,alloctbl_qty  numeric (22,6)
,custrcvplc_stktaking_proc  varchar (1) 
,custrcvplc_contents  varchar (4000) 
,custrcvplc_tel  varchar (20) 
,custrcvplc_addr2  varchar (50) 
,custrcvplc_addr1  varchar (50) 
,trngantt_processseq_pare  numeric (38,0)
,custwh_remark  varchar (4000) 
,custwh_alloctbl_id  numeric (38,0)
,id  numeric (38,0)
,custwh_custrcvplc_id  numeric (38,0)
,custwh_person_id_upd  numeric (38,0)
,custwh_update_ip  varchar (40) 
,custwh_updated_at   timestamp(6) 
,custwh_created_at   timestamp(6) 
,custwh_id  numeric (38,0)
,bill_chrg_id_bill_custrcvplc  numeric (22,0)
,cust_bill_id_custrcvplc  numeric (38,0)
,custrcvplc_cust_id_custrcvplc  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,chrg_person_id_chrg_cust_custrcvplc  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,bill_loca_id_bill_custrcvplc  numeric (38,0)
,cust_chrg_id_cust_custrcvplc  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,alloctbl_trngantt_id  numeric (38,0)
,chrg_person_id_chrg_bill_custrcvplc  numeric (38,0)
,person_sect_id_chrg_cust_custrcvplc  numeric (22,0)
,trngantt_itm_id  numeric (38,0)
,cust_loca_id_cust_custrcvplc  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,person_sect_id_chrg_bill_custrcvplc  numeric (22,0)
,bill_crr_id_bill_custrcvplc  numeric (22,0)
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
