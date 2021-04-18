
  drop view if  exists r_custs cascade ; 
 create or replace view r_custs as select  
cust.updated_at  cust_updated_at,
cust.custtype  cust_custtype,
cust.remark  cust_remark,
cust.persons_id_upd   cust_person_id_upd,
cust.expiredate  cust_expiredate,
cust.update_ip  cust_update_ip,
cust.id  cust_id,
cust.created_at  cust_created_at,
  loca_cust.loca_name  loca_name_cust ,
  loca_cust.loca_code  loca_code_cust ,
cust.id id,
cust.locas_id_cust   cust_loca_id_cust,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
cust.contract_price  cust_contract_price,
cust.rule_price  cust_rule_price,
cust.contents  cust_contents,
  chrg_cust.scrlv_code_chrg  scrlv_code_chrg_cust ,
cust.chrgs_id_cust   cust_chrg_id_cust,
  chrg_cust.chrg_person_id_chrg  chrg_person_id_chrg_cust ,
  chrg_cust.person_code_chrg  person_code_chrg_cust ,
  chrg_cust.person_name_chrg  person_name_chrg_cust ,
  chrg_cust.person_sect_id_chrg  person_sect_id_chrg_cust ,
  chrg_cust.loca_code_sect_chrg  loca_code_sect_chrg_cust ,
  chrg_cust.loca_name_sect_chrg  loca_name_sect_chrg_cust ,
  chrg_cust.usrgrp_code_chrg  usrgrp_code_chrg_cust ,
  chrg_cust.usrgrp_name_chrg  usrgrp_name_chrg_cust ,
cust.amtdecimal  cust_amtdecimal,
cust.amtround  cust_amtround,
  bill.bill_loca_id_bill  bill_loca_id_bill ,
  bill.loca_code_bill  loca_code_bill ,
  bill.loca_name_bill  loca_name_bill ,
cust.personname  cust_personname,
cust.bills_id   cust_bill_id,
  crr_cust.crr_name  crr_name_cust ,
cust.crrs_id_cust   cust_crr_id_cust,
  crr_cust.crr_code  crr_code_cust ,
cust.autocreate_custact  cust_autocreate_custact,
  bill.bill_chrg_id_bill  bill_chrg_id_bill ,
  bill.person_code_chrg_bill  person_code_chrg_bill ,
  bill.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  bill.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  bill.person_name_chrg_bill  person_name_chrg_bill ,
  bill.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  bill.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  bill.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  bill.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  bill.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  bill.bill_crr_id_bill  bill_crr_id_bill ,
  bill.crr_code_bill  crr_code_bill ,
  bill.crr_name_bill  crr_name_bill 
 from custs   cust,
  r_persons  person_upd ,  r_locas  loca_cust ,  r_chrgs  chrg_cust ,  r_bills  bill ,  r_crrs  crr_cust 
  where       cust.persons_id_upd = person_upd.id      and cust.locas_id_cust = loca_cust.id      and cust.chrgs_id_cust = chrg_cust.id      and cust.bills_id = bill.id      and cust.crrs_id_cust = crr_cust.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custs;
 CREATE TABLE sio.sio_r_custs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,loca_code_cust  varchar (50) 
,loca_name_cust  varchar (100) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,person_code_chrg_cust  varchar (50) 
,person_name_chrg_cust  varchar (100) 
,scrlv_code_chrg_cust  varchar (50) 
,loca_code_sect_chrg_cust  varchar (50) 
,loca_name_sect_chrg_cust  varchar (100) 
,usrgrp_code_chrg_cust  varchar (50) 
,usrgrp_name_chrg_cust  varchar (100) 
,loca_code_bill  varchar (50) 
,loca_name_bill  varchar (100) 
,person_code_chrg_bill  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,usrgrp_name_chrg_bill  varchar (100) 
,crr_code_cust  varchar (50) 
,crr_code_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,crr_name_cust  varchar (100) 
,cust_personname  varchar (30) 
,cust_amtdecimal  numeric (38,0)
,cust_amtround  varchar (2) 
,cust_rule_price  varchar (1) 
,cust_custtype  varchar (1) 
,cust_contract_price  varchar (1) 
,cust_crr_id_cust  numeric (38,0)
,cust_autocreate_custact  varchar (1) 
,cust_expiredate   date 
,cust_remark  varchar (4000) 
,cust_contents  varchar (4000) 
,cust_person_id_upd  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,person_sect_id_chrg_cust  numeric (22,0)
,cust_chrg_id_cust  numeric (38,0)
,bill_loca_id_bill  numeric (38,0)
,cust_bill_id  numeric (38,0)
,cust_updated_at   timestamp(6) 
,cust_loca_id_cust  numeric (38,0)
,bill_chrg_id_bill  numeric (22,0)
,id  numeric (38,0)
,cust_created_at   timestamp(6) 
,cust_id  numeric (38,0)
,cust_update_ip  varchar (40) 
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
 CREATE INDEX sio_r_custs_uk1 
  ON sio.sio_r_custs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custs_seq ;
 create sequence sio.sio_r_custs_seq ;
