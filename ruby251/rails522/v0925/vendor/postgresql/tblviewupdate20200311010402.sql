
 --- drop view r_inamts cascade  
 create or replace view r_inamts as select  
  trngantt.shelfno_code_fm  shelfno_code_fm ,
  trngantt.shelfno_name_fm  shelfno_name_fm ,
  trngantt.prjno_name  prjno_name ,
  trngantt.unit_code_pare  unit_code_pare ,
  trngantt.unit_code  unit_code ,
  trngantt.unit_name_pare  unit_name_pare ,
  trngantt.unit_name  unit_name ,
  trngantt.trngantt_itm_id  trngantt_itm_id ,
  trngantt.itm_code_pare  itm_code_pare ,
  trngantt.itm_code  itm_code ,
  trngantt.itm_name_pare  itm_name_pare ,
  trngantt.itm_name  itm_name ,
  trngantt.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  loca_in.loca_code  loca_code_in ,
  trngantt.loca_code_pare  loca_code_pare ,
  trngantt.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  loca_in.loca_name  loca_name_in ,
  trngantt.loca_name_pare  loca_name_pare ,
  trngantt.itm_unit_id_pare  itm_unit_id_pare ,
  trngantt.itm_unit_id  itm_unit_id ,
  trngantt.itm_classlist_id_pare  itm_classlist_id_pare ,
  trngantt.itm_classlist_id  itm_classlist_id ,
  trngantt.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  trngantt.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  trngantt.trngantt_loca_id_pare  trngantt_loca_id_pare ,
inamt.id  inamt_id,
inamt.id id,
inamt.starttime  inamt_starttime,
inamt.amt  inamt_amt,
inamt.crrs_id   inamt_crr_id,
inamt.inoutflg  inamt_inoutflg,
inamt.expiredate  inamt_expiredate,
inamt.remark  inamt_remark,
inamt.persons_id_upd   inamt_person_id_upd,
inamt.created_at  inamt_created_at,
inamt.updated_at  inamt_updated_at,
inamt.update_ip  inamt_update_ip,
inamt.trngantts_id   inamt_trngantt_id,
inamt.locas_id_in   inamt_loca_id_in,
  trngantt.classlist_code_pare  classlist_code_pare ,
  trngantt.classlist_code  classlist_code ,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
  trngantt.classlist_name_pare  classlist_name_pare ,
  trngantt.classlist_name  classlist_name ,
  trngantt.prjno_code_chil  prjno_code_chil ,
  trngantt.prjno_code  prjno_code ,
  trngantt.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  trngantt.trngantt_prjno_id  trngantt_prjno_id 
 from inamts   inamt,
  r_crrs  crr ,  r_persons  person_upd ,  r_trngantts  trngantt ,  r_locas  loca_in 
  where       inamt.crrs_id = crr.id      and inamt.persons_id_upd = person_upd.id      and inamt.trngantts_id = trngantt.id      and inamt.locas_id_in = loca_in.id     ;
 DROP TABLE IF EXISTS sio.sio_r_inamts;
 CREATE TABLE sio.sio_r_inamts (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_inamts_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,itm_name_pare  varchar (100) 
,unit_code_pare  varchar (50) 
,unit_code  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_in  varchar (50) 
,loca_code_pare  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_in  varchar (100) 
,loca_name_pare  varchar (100) 
,prjno_code_chil  varchar (50) 
,classlist_name  varchar (100) 
,classlist_name_pare  varchar (100) 
,crr_name  varchar (100) 
,unit_name_pare  varchar (100) 
,unit_name  varchar (100) 
,shelfno_name_fm  varchar (100) 
,prjno_name  varchar (100) 
,prjno_code  varchar (50) 
,shelfno_code_fm  varchar (50) 
,itm_code_pare  varchar (50) 
,crr_code  varchar (50) 
,classlist_code  varchar (50) 
,itm_code  varchar (50) 
,classlist_code_pare  varchar (50) 
,itm_name  varchar (100) 
,inamt_inoutflg  varchar (3) 
,inamt_starttime   timestamp(6) 
,inamt_amt  numeric (18,4)
,inamt_expiredate   date 
,trngantt_qty_stk_pare  numeric (22,6)
,trngantt_processseq  numeric (38,0)
,trngantt_starttime   timestamp(6) 
,trngantt_consumunitqty  numeric (22,6)
,trngantt_consumminqty  numeric (22,6)
,trngantt_shuffle_flg  varchar (1) 
,trngantt_consumchgoverqty  numeric (22,6)
,trngantt_qty_stk  numeric (22,0)
,trngantt_tblname  varchar (30) 
,trngantt_tblid  numeric (38,0)
,loca_abbr_in  varchar (50) 
,loca_zip_in  varchar (10) 
,loca_country_in  varchar (20) 
,loca_prfct_in  varchar (20) 
,loca_addr1_in  varchar (50) 
,loca_addr2_in  varchar (50) 
,loca_tel_in  varchar (20) 
,loca_tel_pare  varchar (20) 
,loca_fax_in  varchar (20) 
,loca_mail_in  varchar (20) 
,trngantt_parenum  numeric (22,0)
,trngantt_chilnum  numeric (22,0)
,trngantt_duedate   timestamp(6) 
,trngantt_qty  numeric (18,4)
,trngantt_mlevel  numeric (3,0)
,trngantt_orgtblname  varchar (30) 
,trngantt_key  varchar (250) 
,trngantt_processseq_pare  numeric (38,0)
,trngantt_qty_pare  numeric (22,6)
,trngantt_consumauto  varchar (1) 
,crr_pricedecimal  numeric (22,0)
,crr_amtdecimal  numeric (22,0)
,crr_contents  varchar (4000) 
,trngantt_paretblname  varchar (30) 
,trngantt_paretblid  numeric (38,0)
,trngantt_orgtblid  numeric (22,0)
,inamt_remark  varchar (4000) 
,inamt_trngantt_id  numeric (38,0)
,inamt_crr_id  numeric (22,0)
,id  numeric (38,0)
,inamt_id  numeric (38,0)
,inamt_person_id_upd  numeric (38,0)
,inamt_created_at   timestamp(6) 
,inamt_loca_id_in  numeric (22,0)
,inamt_update_ip  varchar (40) 
,inamt_updated_at   timestamp(6) 
,trngantt_itm_id  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,trngantt_prjno_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,itm_unit_id  numeric (22,0)
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
 CREATE INDEX sio_r_inamts_uk1 
  ON sio.sio_r_inamts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_inamts_seq ;
 create sequence sio.sio_r_inamts_seq ;
 --- drop view r_incustwhs cascade  
 create or replace view r_incustwhs as select  
  custrcvplc.cust_bill_id_custrcvplc  cust_bill_id_custrcvplc ,
  trngantt.shelfno_code_fm  shelfno_code_fm ,
  custrcvplc.bill_chrg_id_bill_custrcvplc  bill_chrg_id_bill_custrcvplc ,
  trngantt.shelfno_name_fm  shelfno_name_fm ,
  trngantt.prjno_name  prjno_name ,
  trngantt.unit_code_pare  unit_code_pare ,
  trngantt.unit_code  unit_code ,
  trngantt.unit_name_pare  unit_name_pare ,
  trngantt.unit_name  unit_name ,
  trngantt.trngantt_itm_id  trngantt_itm_id ,
  trngantt.itm_code_pare  itm_code_pare ,
  trngantt.itm_code  itm_code ,
  trngantt.itm_name_pare  itm_name_pare ,
  trngantt.itm_name  itm_name ,
  custrcvplc.scrlv_code_chrg_cust_custrcvplc  scrlv_code_chrg_cust_custrcvplc ,
  custrcvplc.scrlv_code_chrg_bill_custrcvplc  scrlv_code_chrg_bill_custrcvplc ,
  custrcvplc.cust_loca_id_cust_custrcvplc  cust_loca_id_cust_custrcvplc ,
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
  trngantt.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  trngantt.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  trngantt.trngantt_loca_id_pare  trngantt_loca_id_pare ,
  custrcvplc.custrcvplc_code  custrcvplc_code ,
  custrcvplc.custrcvplc_name  custrcvplc_name ,
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
  trngantt.prjno_code_chil  prjno_code_chil ,
  trngantt.prjno_code  prjno_code ,
  trngantt.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  trngantt.trngantt_prjno_id  trngantt_prjno_id ,
  custrcvplc.custrcvplc_cust_id_custrcvplc  custrcvplc_cust_id_custrcvplc ,
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
,trngantt_qty_pare  numeric (22,6)
,trngantt_qty_stk_pare  numeric (22,6)
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
 --- drop view r_instks cascade  
 create or replace view r_instks as select  
instk.qty  instk_qty,
  trngantt.shelfno_code_fm  shelfno_code_fm ,
  shelfno_in.shelfno_code  shelfno_code_in ,
  trngantt.shelfno_name_fm  shelfno_name_fm ,
  shelfno_in.shelfno_name  shelfno_name_in ,
  trngantt.prjno_name  prjno_name ,
  trngantt.unit_code_pare  unit_code_pare ,
  trngantt.unit_code  unit_code ,
  trngantt.unit_name_pare  unit_name_pare ,
  trngantt.unit_name  unit_name ,
  trngantt.trngantt_itm_id  trngantt_itm_id ,
  trngantt.itm_code_pare  itm_code_pare ,
  trngantt.itm_code  itm_code ,
  trngantt.itm_name_pare  itm_name_pare ,
  trngantt.itm_name  itm_name ,
  trngantt.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  shelfno_in.loca_code_shelfno  loca_code_shelfno_in ,
  trngantt.loca_code_pare  loca_code_pare ,
  trngantt.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  shelfno_in.loca_name_shelfno  loca_name_shelfno_in ,
  trngantt.loca_name_pare  loca_name_pare ,
  trngantt.itm_unit_id_pare  itm_unit_id_pare ,
  trngantt.itm_unit_id  itm_unit_id ,
  trngantt.itm_classlist_id_pare  itm_classlist_id_pare ,
  trngantt.itm_classlist_id  itm_classlist_id ,
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
  trngantt.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  trngantt.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  trngantt.trngantt_loca_id_pare  trngantt_loca_id_pare ,
instk.trngantts_id   instk_trngantt_id,
instk.shelfnos_id_in   instk_shelfno_id_in,
  trngantt.classlist_code_pare  classlist_code_pare ,
  trngantt.classlist_code  classlist_code ,
  trngantt.classlist_name_pare  classlist_name_pare ,
  trngantt.classlist_name  classlist_name ,
  trngantt.prjno_code_chil  prjno_code_chil ,
  trngantt.prjno_code  prjno_code ,
  trngantt.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  shelfno_in.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_in ,
  trngantt.trngantt_prjno_id  trngantt_prjno_id 
 from instks   instk,
  r_persons  person_upd ,  r_trngantts  trngantt ,  r_shelfnos  shelfno_in 
  where       instk.persons_id_upd = person_upd.id      and instk.trngantts_id = trngantt.id      and instk.shelfnos_id_in = shelfno_in.id     ;
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
,loca_code_shelfno_in  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,shelfno_code_fm  varchar (50) 
,shelfno_code_in  varchar (50) 
,prjno_code  varchar (50) 
,shelfno_name_fm  varchar (100) 
,shelfno_name_in  varchar (100) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,unit_code_pare  varchar (50) 
,unit_code  varchar (50) 
,unit_name_pare  varchar (100) 
,unit_name  varchar (100) 
,classlist_name  varchar (100) 
,classlist_name_pare  varchar (100) 
,classlist_code  varchar (50) 
,classlist_code_pare  varchar (50) 
,itm_code_pare  varchar (50) 
,itm_code  varchar (50) 
,itm_name_pare  varchar (100) 
,itm_name  varchar (100) 
,loca_name_pare  varchar (100) 
,loca_name_shelfno_in  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,loca_code_pare  varchar (50) 
,instk_lotno  varchar (50) 
,instk_qty  numeric (18,4)
,instk_starttime   timestamp(6) 
,instk_qty_stk  numeric (38,4)
,instk_packno  varchar (10) 
,instk_inoutflg  varchar (3) 
,instk_expiredate   date 
,trngantt_key  varchar (250) 
,trngantt_mlevel  numeric (3,0)
,trngantt_orgtblname  varchar (30) 
,trngantt_processseq  numeric (38,0)
,trngantt_consumauto  varchar (1) 
,shelfno_contents_in  varchar (4000) 
,trngantt_processseq_pare  numeric (38,0)
,trngantt_qty_pare  numeric (22,6)
,trngantt_qty_stk_pare  numeric (22,6)
,trngantt_shuffle_flg  varchar (1) 
,trngantt_consumminqty  numeric (22,6)
,trngantt_consumunitqty  numeric (22,6)
,trngantt_paretblname  varchar (30) 
,trngantt_paretblid  numeric (38,0)
,trngantt_starttime   timestamp(6) 
,trngantt_orgtblid  numeric (22,0)
,loca_tel_pare  varchar (20) 
,trngantt_tblid  numeric (38,0)
,trngantt_tblname  varchar (30) 
,trngantt_qty_stk  numeric (22,0)
,trngantt_consumchgoverqty  numeric (22,6)
,trngantt_parenum  numeric (22,0)
,trngantt_chilnum  numeric (22,0)
,trngantt_duedate   timestamp(6) 
,trngantt_qty  numeric (18,4)
,instk_remark  varchar (4000) 
,instk_person_id_upd  numeric (38,0)
,instk_created_at   timestamp(6) 
,instk_updated_at   timestamp(6) 
,instk_update_ip  varchar (40) 
,instk_id  numeric (38,0)
,id  numeric (38,0)
,instk_trngantt_id  numeric (38,0)
,instk_shelfno_id_in  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,itm_unit_id  numeric (22,0)
,trngantt_prjno_id  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,shelfno_loca_id_shelfno_in  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
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
 --- drop view r_outamts cascade  
 create or replace view r_outamts as select  
  trngantt.shelfno_code_fm  shelfno_code_fm ,
  trngantt.shelfno_name_fm  shelfno_name_fm ,
  trngantt.prjno_name  prjno_name ,
  trngantt.unit_code_pare  unit_code_pare ,
  trngantt.unit_code  unit_code ,
  trngantt.unit_name_pare  unit_name_pare ,
  trngantt.unit_name  unit_name ,
  trngantt.trngantt_itm_id  trngantt_itm_id ,
  trngantt.itm_code_pare  itm_code_pare ,
  trngantt.itm_code  itm_code ,
  trngantt.itm_name_pare  itm_name_pare ,
  trngantt.itm_name  itm_name ,
  trngantt.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  loca_out.loca_code  loca_code_out ,
  trngantt.loca_code_pare  loca_code_pare ,
  trngantt.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  loca_out.loca_name  loca_name_out ,
  trngantt.loca_name_pare  loca_name_pare ,
  trngantt.itm_unit_id_pare  itm_unit_id_pare ,
  trngantt.itm_unit_id  itm_unit_id ,
  trngantt.itm_classlist_id_pare  itm_classlist_id_pare ,
  trngantt.itm_classlist_id  itm_classlist_id ,
  trngantt.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  trngantt.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  trngantt.trngantt_loca_id_pare  trngantt_loca_id_pare ,
outamt.id  outamt_id,
outamt.id id,
outamt.starttime  outamt_starttime,
outamt.amt  outamt_amt,
outamt.crrs_id   outamt_crr_id,
outamt.inoutflg  outamt_inoutflg,
outamt.expiredate  outamt_expiredate,
outamt.remark  outamt_remark,
outamt.persons_id_upd   outamt_person_id_upd,
outamt.created_at  outamt_created_at,
outamt.updated_at  outamt_updated_at,
outamt.update_ip  outamt_update_ip,
outamt.trngantts_id   outamt_trngantt_id,
outamt.locas_id_out   outamt_loca_id_out,
  trngantt.classlist_code_pare  classlist_code_pare ,
  trngantt.classlist_code  classlist_code ,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
  trngantt.classlist_name_pare  classlist_name_pare ,
  trngantt.classlist_name  classlist_name ,
  trngantt.prjno_code_chil  prjno_code_chil ,
  trngantt.prjno_code  prjno_code ,
  trngantt.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  trngantt.trngantt_prjno_id  trngantt_prjno_id 
 from outamts   outamt,
  r_crrs  crr ,  r_persons  person_upd ,  r_trngantts  trngantt ,  r_locas  loca_out 
  where       outamt.crrs_id = crr.id      and outamt.persons_id_upd = person_upd.id      and outamt.trngantts_id = trngantt.id      and outamt.locas_id_out = loca_out.id     ;
 DROP TABLE IF EXISTS sio.sio_r_outamts;
 CREATE TABLE sio.sio_r_outamts (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_outamts_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,itm_name_pare  varchar (100) 
,unit_code_pare  varchar (50) 
,unit_code  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_out  varchar (50) 
,loca_code_pare  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_out  varchar (100) 
,loca_name_pare  varchar (100) 
,prjno_code_chil  varchar (50) 
,classlist_name  varchar (100) 
,classlist_name_pare  varchar (100) 
,crr_name  varchar (100) 
,unit_name_pare  varchar (100) 
,unit_name  varchar (100) 
,shelfno_name_fm  varchar (100) 
,prjno_name  varchar (100) 
,prjno_code  varchar (50) 
,shelfno_code_fm  varchar (50) 
,itm_code_pare  varchar (50) 
,crr_code  varchar (50) 
,classlist_code  varchar (50) 
,itm_code  varchar (50) 
,classlist_code_pare  varchar (50) 
,itm_name  varchar (100) 
,outamt_inoutflg  varchar (3) 
,outamt_starttime   timestamp(6) 
,outamt_amt  numeric (18,4)
,outamt_expiredate   date 
,trngantt_tblname  varchar (30) 
,trngantt_processseq  numeric (38,0)
,trngantt_starttime   timestamp(6) 
,trngantt_consumunitqty  numeric (22,6)
,trngantt_consumminqty  numeric (22,6)
,trngantt_shuffle_flg  varchar (1) 
,trngantt_consumchgoverqty  numeric (22,6)
,trngantt_qty_stk  numeric (22,0)
,trngantt_consumauto  varchar (1) 
,trngantt_tblid  numeric (38,0)
,loca_abbr_out  varchar (50) 
,loca_zip_out  varchar (10) 
,loca_country_out  varchar (20) 
,loca_prfct_out  varchar (20) 
,loca_addr1_out  varchar (50) 
,loca_addr2_out  varchar (50) 
,loca_tel_out  varchar (20) 
,loca_tel_pare  varchar (20) 
,loca_fax_out  varchar (20) 
,loca_mail_out  varchar (20) 
,trngantt_parenum  numeric (22,0)
,trngantt_chilnum  numeric (22,0)
,trngantt_duedate   timestamp(6) 
,trngantt_qty  numeric (18,4)
,trngantt_mlevel  numeric (3,0)
,trngantt_orgtblname  varchar (30) 
,trngantt_key  varchar (250) 
,trngantt_processseq_pare  numeric (38,0)
,trngantt_qty_pare  numeric (22,6)
,trngantt_qty_stk_pare  numeric (22,6)
,crr_pricedecimal  numeric (22,0)
,crr_amtdecimal  numeric (22,0)
,crr_contents  varchar (4000) 
,trngantt_paretblname  varchar (30) 
,trngantt_paretblid  numeric (38,0)
,trngantt_orgtblid  numeric (22,0)
,outamt_remark  varchar (4000) 
,outamt_trngantt_id  numeric (38,0)
,outamt_loca_id_out  numeric (22,0)
,outamt_crr_id  numeric (22,0)
,id  numeric (38,0)
,outamt_id  numeric (38,0)
,outamt_person_id_upd  numeric (38,0)
,outamt_created_at   timestamp(6) 
,outamt_updated_at   timestamp(6) 
,outamt_update_ip  varchar (40) 
,itm_classlist_id  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,trngantt_prjno_id  numeric (38,0)
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
 CREATE INDEX sio_r_outamts_uk1 
  ON sio.sio_r_outamts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_outamts_seq ;
 create sequence sio.sio_r_outamts_seq ;
 --- drop view r_outstks cascade  
 create or replace view r_outstks as select  
outstk.qty  outstk_qty,
  shelfno_out.shelfno_code  shelfno_code_out ,
  trngantt.shelfno_code_fm  shelfno_code_fm ,
  shelfno_out.shelfno_name  shelfno_name_out ,
  trngantt.shelfno_name_fm  shelfno_name_fm ,
  trngantt.prjno_name  prjno_name ,
  trngantt.unit_code_pare  unit_code_pare ,
  trngantt.unit_code  unit_code ,
  trngantt.unit_name_pare  unit_name_pare ,
  trngantt.unit_name  unit_name ,
  trngantt.trngantt_itm_id  trngantt_itm_id ,
  trngantt.itm_code_pare  itm_code_pare ,
  trngantt.itm_code  itm_code ,
  trngantt.itm_name_pare  itm_name_pare ,
  trngantt.itm_name  itm_name ,
  shelfno_out.loca_code_shelfno  loca_code_shelfno_out ,
  trngantt.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  trngantt.loca_code_pare  loca_code_pare ,
  shelfno_out.loca_name_shelfno  loca_name_shelfno_out ,
  trngantt.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  trngantt.loca_name_pare  loca_name_pare ,
  trngantt.itm_unit_id_pare  itm_unit_id_pare ,
  trngantt.itm_unit_id  itm_unit_id ,
  trngantt.itm_classlist_id_pare  itm_classlist_id_pare ,
  trngantt.itm_classlist_id  itm_classlist_id ,
  trngantt.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  trngantt.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  trngantt.trngantt_loca_id_pare  trngantt_loca_id_pare ,
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
outstk.trngantts_id   outstk_trngantt_id,
outstk.shelfnos_id_out   outstk_shelfno_id_out,
  trngantt.classlist_code_pare  classlist_code_pare ,
  trngantt.classlist_code  classlist_code ,
  trngantt.classlist_name_pare  classlist_name_pare ,
  trngantt.classlist_name  classlist_name ,
  trngantt.prjno_code_chil  prjno_code_chil ,
  trngantt.prjno_code  prjno_code ,
  shelfno_out.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_out ,
  trngantt.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  trngantt.trngantt_prjno_id  trngantt_prjno_id 
 from outstks   outstk,
  r_persons  person_upd ,  r_trngantts  trngantt ,  r_shelfnos  shelfno_out 
  where       outstk.persons_id_upd = person_upd.id      and outstk.trngantts_id = trngantt.id      and outstk.shelfnos_id_out = shelfno_out.id     ;
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
,classlist_code  varchar (50) 
,unit_name_pare  varchar (100) 
,unit_name  varchar (100) 
,shelfno_code_fm  varchar (50) 
,unit_code  varchar (50) 
,loca_code_shelfno_out  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_pare  varchar (50) 
,loca_name_shelfno_out  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_pare  varchar (100) 
,prjno_code  varchar (50) 
,shelfno_name_out  varchar (100) 
,itm_code_pare  varchar (50) 
,classlist_code_pare  varchar (50) 
,itm_code  varchar (50) 
,itm_name_pare  varchar (100) 
,itm_name  varchar (100) 
,shelfno_name_fm  varchar (100) 
,prjno_name  varchar (100) 
,shelfno_code_out  varchar (50) 
,unit_code_pare  varchar (50) 
,outstk_qty  numeric (18,4)
,outstk_inoutflg  varchar (3) 
,outstk_packno  varchar (10) 
,outstk_lotno  varchar (50) 
,outstk_starttime   timestamp(6) 
,outstk_expiredate   date 
,outstk_qty_stk  numeric (38,4)
,trngantt_duedate   timestamp(6) 
,trngantt_processseq  numeric (38,0)
,trngantt_starttime   timestamp(6) 
,trngantt_consumunitqty  numeric (22,6)
,trngantt_consumminqty  numeric (22,6)
,trngantt_shuffle_flg  varchar (1) 
,trngantt_consumchgoverqty  numeric (22,6)
,trngantt_qty_stk  numeric (22,0)
,trngantt_tblname  varchar (30) 
,trngantt_tblid  numeric (38,0)
,loca_tel_pare  varchar (20) 
,trngantt_parenum  numeric (22,0)
,trngantt_chilnum  numeric (22,0)
,trngantt_consumauto  varchar (1) 
,trngantt_qty  numeric (18,4)
,trngantt_mlevel  numeric (3,0)
,trngantt_orgtblname  varchar (30) 
,trngantt_key  varchar (250) 
,trngantt_processseq_pare  numeric (38,0)
,trngantt_qty_pare  numeric (22,6)
,trngantt_qty_stk_pare  numeric (22,6)
,trngantt_paretblname  varchar (30) 
,trngantt_paretblid  numeric (38,0)
,trngantt_orgtblid  numeric (22,0)
,shelfno_contents_out  varchar (4000) 
,outstk_remark  varchar (4000) 
,outstk_updated_at   timestamp(6) 
,outstk_update_ip  varchar (40) 
,outstk_trngantt_id  numeric (38,0)
,outstk_created_at   timestamp(6) 
,outstk_shelfno_id_out  numeric (22,0)
,id  numeric (38,0)
,outstk_id  numeric (38,0)
,outstk_person_id_upd  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,itm_unit_id  numeric (22,0)
,shelfno_loca_id_shelfno_out  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
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
