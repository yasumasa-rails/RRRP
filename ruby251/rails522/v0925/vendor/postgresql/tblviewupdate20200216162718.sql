
 create table incustwhs (
 custrcvplcs_id numeric(38,0 )   not null ,
 id numeric(38,0 )   not null  ,
 duedate timestamp(6)  ,
 qty_stk numeric(38,4 )   ,
 qty numeric(18,4 )   ,
 lotno varchar(50)   ,
 packno varchar(10)   ,
 inoutflg char(3)   ,
 expiredate date  ,
 remark varchar(4000)   ,
 persons_id_upd numeric(38,0 )   not null ,
 created_at timestamp(6)  ,
 updated_at timestamp(6)  ,
 update_ip varchar(40)   ,
 trngantts_id numeric(38,0 )   not null ,
  CONSTRAINT incustwhs_id_pk PRIMARY KEY (id));
 ALTER TABLE incustwhs ADD CONSTRAINT incustwh_custrcvplcs_id FOREIGN KEY (custrcvplcs_id)
																		 REFERENCES custrcvplcs (id);
 ALTER TABLE incustwhs ADD CONSTRAINT incustwh_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 ALTER TABLE incustwhs ADD CONSTRAINT incustwh_trngantts_id FOREIGN KEY (trngantts_id)
																		 REFERENCES trngantts (id);
 create sequence incustwhs_seq ;
 --- drop view r_incustwhs cascade  
 create or replace view r_incustwhs as select  
  custrcvplc.cust_bill_id_custrcvplc  cust_bill_id_custrcvplc ,
  trngantt.trngantt_consumauto  trngantt_consumauto ,
  trngantt.shelfno_code_fm  shelfno_code_fm ,
  custrcvplc.bill_chrg_id_bill_custrcvplc  bill_chrg_id_bill_custrcvplc ,
  trngantt.trngantt_processseq  trngantt_processseq ,
  trngantt.shelfno_name_fm  shelfno_name_fm ,
  trngantt.prjno_name  prjno_name ,
  trngantt.trngantt_starttime  trngantt_starttime ,
  trngantt.unit_code_pare  unit_code_pare ,
  trngantt.unit_code  unit_code ,
  trngantt.unit_name_pare  unit_name_pare ,
  trngantt.unit_name  unit_name ,
  trngantt.trngantt_consumunitqty  trngantt_consumunitqty ,
  trngantt.trngantt_consumminqty  trngantt_consumminqty ,
  trngantt.trngantt_itm_id  trngantt_itm_id ,
  trngantt.trngantt_shuffle_flg  trngantt_shuffle_flg ,
  trngantt.itm_code_pare  itm_code_pare ,
  trngantt.itm_code  itm_code ,
  trngantt.itm_name_pare  itm_name_pare ,
  trngantt.itm_name  itm_name ,
  trngantt.trngantt_consumchgoverqty  trngantt_consumchgoverqty ,
  trngantt.trngantt_qty_stk  trngantt_qty_stk ,
  custrcvplc.scrlv_code_chrg_cust_custrcvplc  scrlv_code_chrg_cust_custrcvplc ,
  custrcvplc.scrlv_code_chrg_bill_custrcvplc  scrlv_code_chrg_bill_custrcvplc ,
  trngantt.trngantt_tblname  trngantt_tblname ,
  trngantt.trngantt_tblid  trngantt_tblid ,
  custrcvplc.cust_loca_id_cust_custrcvplc  cust_loca_id_cust_custrcvplc ,
  trngantt.loca_tel_pare  loca_tel_pare ,
  custrcvplc.loca_code_cust_custrcvplc  loca_code_cust_custrcvplc ,
  trngantt.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  trngantt.loca_code_pare  loca_code_pare ,
  custrcvplc.loca_name_cust_custrcvplc  loca_name_cust_custrcvplc ,
  trngantt.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  trngantt.loca_name_pare  loca_name_pare ,
  custrcvplc.person_code_chrg_cust_custrcvplc  person_code_chrg_cust_custrcvplc ,
  custrcvplc.person_code_chrg_bill_custrcvplc  person_code_chrg_bill_custrcvplc ,
  custrcvplc.person_name_chrg_cust_custrcvplc  person_name_chrg_cust_custrcvplc ,
  custrcvplc.person_name_chrg_bill_custrcvplc  person_name_chrg_bill_custrcvplc ,
  trngantt.itm_unit_id_pare  itm_unit_id_pare ,
  trngantt.itm_unit_id  itm_unit_id ,
  trngantt.itm_classlist_id_pare  itm_classlist_id_pare ,
  trngantt.itm_classlist_id  itm_classlist_id ,
  trngantt.trngantt_parenum  trngantt_parenum ,
  trngantt.trngantt_chilnum  trngantt_chilnum ,
  trngantt.trngantt_duedate  trngantt_duedate ,
  trngantt.trngantt_qty  trngantt_qty ,
  trngantt.trngantt_mlevel  trngantt_mlevel ,
  trngantt.trngantt_orgtblname  trngantt_orgtblname ,
  trngantt.trngantt_key  trngantt_key ,
  trngantt.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  trngantt.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  trngantt.trngantt_processseq_pare  trngantt_processseq_pare ,
  trngantt.trngantt_loca_id_pare  trngantt_loca_id_pare ,
  custrcvplc.custrcvplc_code  custrcvplc_code ,
  custrcvplc.custrcvplc_name  custrcvplc_name ,
  trngantt.trngantt_qty_pare  trngantt_qty_pare ,
  trngantt.trngantt_qty_stk_pare  trngantt_qty_stk_pare ,
  custrcvplc.custrcvplc_addr1  custrcvplc_addr1 ,
  custrcvplc.custrcvplc_addr2  custrcvplc_addr2 ,
  custrcvplc.custrcvplc_tel  custrcvplc_tel ,
incustwh.duedate  incustwh_duedate,
incustwh.remark  incustwh_remark,
incustwh.created_at  incustwh_created_at,
incustwh.update_ip  incustwh_update_ip,
incustwh.expiredate  incustwh_expiredate,
incustwh.updated_at  incustwh_updated_at,
incustwh.qty  incustwh_qty,
incustwh.id  incustwh_id,
incustwh.id id,
incustwh.persons_id_upd   incustwh_person_id_upd,
incustwh.inoutflg  incustwh_inoutflg,
incustwh.lotno  incustwh_lotno,
incustwh.qty_stk  incustwh_qty_stk,
incustwh.packno  incustwh_packno,
incustwh.trngantts_id   incustwh_trngantt_id,
incustwh.custrcvplcs_id   incustwh_custrcvplc_id,
  custrcvplc.bill_crr_id_bill_custrcvplc  bill_crr_id_bill_custrcvplc ,
  custrcvplc.custrcvplc_stktaking_proc  custrcvplc_stktaking_proc ,
  custrcvplc.usrgrp_name_chrg_cust_custrcvplc  usrgrp_name_chrg_cust_custrcvplc ,
  custrcvplc.usrgrp_name_chrg_bill_custrcvplc  usrgrp_name_chrg_bill_custrcvplc ,
  trngantt.classlist_code_pare  classlist_code_pare ,
  trngantt.classlist_code  classlist_code ,
  custrcvplc.crr_code_bill_custrcvplc  crr_code_bill_custrcvplc ,
  custrcvplc.crr_name_bill_custrcvplc  crr_name_bill_custrcvplc ,
  custrcvplc.person_sect_id_chrg_cust_custrcvplc  person_sect_id_chrg_cust_custrcvplc ,
  custrcvplc.person_sect_id_chrg_bill_custrcvplc  person_sect_id_chrg_bill_custrcvplc ,
  custrcvplc.cust_chrg_id_cust_custrcvplc  cust_chrg_id_cust_custrcvplc ,
  custrcvplc.usrgrp_code_chrg_cust_custrcvplc  usrgrp_code_chrg_cust_custrcvplc ,
  custrcvplc.usrgrp_code_chrg_bill_custrcvplc  usrgrp_code_chrg_bill_custrcvplc ,
  trngantt.classlist_name_pare  classlist_name_pare ,
  trngantt.classlist_name  classlist_name ,
  trngantt.trngantt_paretblname  trngantt_paretblname ,
  trngantt.trngantt_paretblid  trngantt_paretblid ,
  trngantt.prjno_code_chil  prjno_code_chil ,
  trngantt.trngantt_orgtblid  trngantt_orgtblid ,
  trngantt.prjno_code  prjno_code ,
  trngantt.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  trngantt.trngantt_prjno_id  trngantt_prjno_id ,
  custrcvplc.custrcvplc_cust_id_custrcvplc  custrcvplc_cust_id_custrcvplc ,
  custrcvplc.custrcvplc_contents  custrcvplc_contents ,
  custrcvplc.bill_loca_id_bill_custrcvplc  bill_loca_id_bill_custrcvplc ,
  custrcvplc.chrg_person_id_chrg_cust_custrcvplc  chrg_person_id_chrg_cust_custrcvplc ,
  custrcvplc.chrg_person_id_chrg_bill_custrcvplc  chrg_person_id_chrg_bill_custrcvplc 
 from incustwhs   incustwh,
  r_persons  person_upd ,  r_trngantts  trngantt ,  r_custrcvplcs  custrcvplc 
  where       incustwh.persons_id_upd = person_upd.id      and incustwh.trngantts_id = trngantt.id      and incustwh.custrcvplcs_id = custrcvplc.id     ;
 DROP TABLE IF EXISTS sio.sio_r_incustwhs;
 CREATE TABLE sio.sio_r_incustwhs (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_incustwhs_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,shelfno_code_fm  varchar (50) 
,prjno_code_chil  varchar (50) 
,prjno_name  varchar (100) 
,itm_code_pare  varchar (50) 
,itm_code  varchar (50) 
,classlist_code  varchar (50) 
,classlist_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,usrgrp_name_chrg_bill_custrcvplc  varchar (100) 
,custrcvplc_code  varchar (50) 
,custrcvplc_name  varchar (100) 
,itm_name  varchar (100) 
,prjno_code  varchar (50) 
,unit_code_pare  varchar (50) 
,scrlv_code_chrg_cust_custrcvplc  varchar (50) 
,scrlv_code_chrg_bill_custrcvplc  varchar (50) 
,person_name_chrg_bill_custrcvplc  varchar (100) 
,usrgrp_code_chrg_bill_custrcvplc  varchar (50) 
,usrgrp_code_chrg_cust_custrcvplc  varchar (50) 
,crr_name_bill_custrcvplc  varchar (100) 
,crr_code_bill_custrcvplc  varchar (50) 
,unit_name  varchar (100) 
,shelfno_name_fm  varchar (100) 
,usrgrp_name_chrg_cust_custrcvplc  varchar (100) 
,classlist_name  varchar (100) 
,unit_code  varchar (50) 
,classlist_name_pare  varchar (100) 
,unit_name_pare  varchar (100) 
,loca_code_cust_custrcvplc  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_pare  varchar (50) 
,loca_name_cust_custrcvplc  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_pare  varchar (100) 
,person_code_chrg_cust_custrcvplc  varchar (50) 
,person_code_chrg_bill_custrcvplc  varchar (50) 
,person_name_chrg_cust_custrcvplc  varchar (100) 
,incustwh_duedate   timestamp(6) 
,incustwh_inoutflg  varchar (3) 
,incustwh_packno  varchar (10) 
,incustwh_qty_stk  numeric (38,4)
,incustwh_expiredate   date 
,incustwh_lotno  varchar (50) 
,incustwh_qty  numeric (18,4)
,trngantt_tblname  varchar (30) 
,trngantt_consumauto  varchar (1) 
,trngantt_processseq  numeric (38,0)
,trngantt_starttime   timestamp(6) 
,trngantt_consumunitqty  numeric (22,6)
,trngantt_consumminqty  numeric (22,6)
,trngantt_shuffle_flg  varchar (1) 
,trngantt_consumchgoverqty  numeric (22,6)
,trngantt_qty_stk  numeric (22,0)
,trngantt_tblid  numeric (38,0)
,loca_tel_pare  varchar (20) 
,trngantt_parenum  numeric (22,0)
,trngantt_chilnum  numeric (22,0)
,trngantt_duedate   timestamp(6) 
,trngantt_qty  numeric (18,4)
,trngantt_mlevel  numeric (3,0)
,trngantt_orgtblname  varchar (30) 
,trngantt_key  varchar (250) 
,trngantt_processseq_pare  numeric (38,0)
,trngantt_qty_pare  numeric (22,0)
,trngantt_qty_stk_pare  numeric (22,0)
,custrcvplc_addr1  varchar (50) 
,custrcvplc_addr2  varchar (50) 
,custrcvplc_tel  varchar (20) 
,custrcvplc_stktaking_proc  varchar (1) 
,trngantt_paretblname  varchar (30) 
,trngantt_paretblid  numeric (38,0)
,trngantt_orgtblid  numeric (22,0)
,custrcvplc_contents  varchar (4000) 
,incustwh_remark  varchar (4000) 
,incustwh_trngantt_id  numeric (38,0)
,incustwh_custrcvplc_id  numeric (38,0)
,incustwh_created_at   timestamp(6) 
,id  numeric (38,0)
,incustwh_person_id_upd  numeric (38,0)
,incustwh_id  numeric (38,0)
,incustwh_updated_at   timestamp(6) 
,incustwh_update_ip  varchar (40) 
,itm_classlist_id  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,person_sect_id_chrg_cust_custrcvplc  numeric (22,0)
,person_sect_id_chrg_bill_custrcvplc  numeric (22,0)
,cust_chrg_id_cust_custrcvplc  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_unit_id_pare  numeric (22,0)
,cust_loca_id_cust_custrcvplc  numeric (38,0)
,cust_bill_id_custrcvplc  numeric (38,0)
,chrg_person_id_chrg_bill_custrcvplc  numeric (38,0)
,bill_loca_id_bill_custrcvplc  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,chrg_person_id_chrg_cust_custrcvplc  numeric (38,0)
,bill_chrg_id_bill_custrcvplc  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,custrcvplc_cust_id_custrcvplc  numeric (22,0)
,bill_crr_id_bill_custrcvplc  numeric (22,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
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
 CREATE INDEX sio_r_incustwhs_uk1 
  ON sio.sio_r_incustwhs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_incustwhs_seq ;
 create sequence sio.sio_r_incustwhs_seq ;
