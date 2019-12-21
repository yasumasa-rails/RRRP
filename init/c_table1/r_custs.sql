
 --- drop view r_custs cascade  
 create or replace view r_custs as select  
cust.amtdecimal  cust_amtdecimal,
cust.remark  cust_remark,
cust.created_at  cust_created_at,
cust.update_ip  cust_update_ip,
cust.custtype  cust_custtype,
cust.expiredate  cust_expiredate,
cust.updated_at  cust_updated_at,
cust.id id,
cust.id  cust_id,
cust.persons_id_upd   cust_person_id_upd,
cust.contents  cust_contents,
cust.locas_id_cust   cust_loca_id_cust,
cust.contract_price  cust_contract_price,
cust.rule_price  cust_rule_price,
cust.amtround  cust_amtround,
cust.chrgs_id_cust   cust_chrg_id_cust,
cust.personname  cust_personname,
cust.bills_id   cust_bill_id,
cust.crrs_id_cust   cust_crr_id_cust,
cust.autocreate_custact  cust_autocreate_custact,
  crr_cust.crr_contents  crr_contents_cust ,
  crr_cust.crr_name  crr_name_cust ,
  crr_cust.crr_pricedecimal  crr_pricedecimal_cust ,
  crr_cust.crr_amtdecimal  crr_amtdecimal_cust ,
  crr_cust.crr_code  crr_code_cust ,
  loca_cust.loca_code  loca_code_cust ,
  loca_cust.loca_country  loca_country_cust ,
  loca_cust.loca_abbr  loca_abbr_cust ,
  loca_cust.loca_prfct  loca_prfct_cust ,
  loca_cust.loca_tel  loca_tel_cust ,
  loca_cust.loca_mail  loca_mail_cust ,
  loca_cust.loca_addr1  loca_addr1_cust ,
  loca_cust.loca_zip  loca_zip_cust ,
  loca_cust.loca_fax  loca_fax_cust ,
  loca_cust.loca_addr2  loca_addr2_cust ,
  loca_cust.loca_name  loca_name_cust ,
  chrg_cust.chrg_person_id  chrg_person_id_cust ,
  chrg_cust.loca_id_sect  loca_id_sect_cust ,
  chrg_cust.person_code_chrg  person_code_chrg_cust ,
  chrg_cust.usrgrp_name_chrg  usrgrp_name_chrg_cust ,
  chrg_cust.usrgrp_code_chrg  usrgrp_code_chrg_cust ,
  chrg_cust.loca_code_sect  loca_code_sect_cust ,
  chrg_cust.loca_name_sect  loca_name_sect_cust ,
  chrg_cust.person_name_chrg  person_name_chrg_cust ,
  bill.bill_contents  bill_contents ,
  bill.bill_personname  bill_personname ,
  bill.bill_loca_id_bill  bill_loca_id_bill ,
  bill.loca_country_bill  loca_country_bill ,
  bill.loca_abbr_bill  loca_abbr_bill ,
  bill.loca_prfct_bill  loca_prfct_bill ,
  bill.loca_tel_bill  loca_tel_bill ,
  bill.loca_mail_bill  loca_mail_bill ,
  bill.loca_addr1_bill  loca_addr1_bill ,
  bill.loca_zip_bill  loca_zip_bill ,
  bill.loca_fax_bill  loca_fax_bill ,
  bill.loca_addr2_bill  loca_addr2_bill ,
  bill.loca_name_bill  loca_name_bill ,
  bill.loca_code_bill  loca_code_bill ,
  bill.bill_chrg_id_bill  bill_chrg_id_bill ,
  bill.person_code_chrg_bill  person_code_chrg_bill ,
  bill.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  bill.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  bill.loca_code_sect_bill  loca_code_sect_bill ,
  bill.loca_name_sect_bill  loca_name_sect_bill ,
  bill.person_name_chrg_bill  person_name_chrg_bill 
 from custs   cust,
  r_persons  person_upd ,  r_locas  loca_cust ,  r_chrgs  chrg_cust ,  r_bills  bill ,  r_crrs  crr_cust 
  where       cust.persons_id_upd = person_upd.id      and cust.locas_id_cust = loca_cust.id      and cust.chrgs_id_cust = chrg_cust.id      and cust.bills_id = bill.id      and cust.crrs_id_cust = crr_cust.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custs;
 CREATE TABLE sio.sio_r_custs (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_custs_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,person_name_chrg_bill  varchar (100) 
,crr_name_cust  varchar (100) 
,crr_code_cust  varchar (50) 
,loca_code_cust  varchar (50) 
,loca_name_cust  varchar (100) 
,person_code_chrg_cust  varchar (50) 
,usrgrp_name_chrg_cust  varchar (100) 
,usrgrp_code_chrg_cust  varchar (50) 
,loca_code_sect_cust  varchar (50) 
,loca_name_sect_cust  varchar (100) 
,person_name_chrg_cust  varchar (100) 
,loca_name_bill  varchar (100) 
,loca_code_bill  varchar (50) 
,person_code_chrg_bill  varchar (50) 
,usrgrp_name_chrg_bill  varchar (100) 
,usrgrp_code_chrg_bill  varchar (50) 
,loca_code_sect_bill  varchar (50) 
,loca_name_sect_bill  varchar (100) 
,cust_amtround  varchar (2) 
,cust_contents  varchar (4000) 
,cust_amtdecimal  numeric (38,0)
,cust_tel  varchar (20) 
,cust_rule_price  varchar (1) 
,cust_contract_price  varchar (1) 
,cust_expiredate   date 
,cust_autocreate_custact  varchar (1) 
,cust_personname  varchar (30) 
,cust_remark  varchar (4000) 
,cust_fax  varchar (20) 
,cust_custtype  varchar (1) 
,loca_addr1_cust  varchar (50) 
,loca_zip_cust  varchar (10) 
,loca_fax_cust  varchar (20) 
,loca_addr2_cust  varchar (50) 
,loca_zip_bill  varchar (10) 
,loca_fax_bill  varchar (20) 
,loca_addr2_bill  varchar (50) 
,bill_contents  varchar (4000) 
,bill_personname  varchar (30) 
,loca_country_bill  varchar (20) 
,loca_abbr_bill  varchar (50) 
,loca_addr1_bill  varchar (50) 
,crr_contents_cust  varchar (4000) 
,loca_prfct_bill  varchar (20) 
,crr_pricedecimal_cust  numeric (22,0)
,crr_amtdecimal_cust  numeric (22,0)
,loca_tel_bill  varchar (20) 
,loca_mail_bill  varchar (20) 
,loca_country_cust  varchar (20) 
,loca_abbr_cust  varchar (50) 
,loca_prfct_cust  varchar (20) 
,loca_tel_cust  varchar (20) 
,loca_mail_cust  varchar (20) 
,cust_update_ip  varchar (40) 
,cust_created_at   timestamp(6) 
,cust_loca_id_cust  numeric (38,0)
,cust_bill_id  numeric (38,0)
,cust_chrg_id_cust  numeric (38,0)
,cust_crr_id_cust  numeric (38,0)
,cust_updated_at   timestamp(6) 
,id  numeric (38,0)
,cust_id  numeric (38,0)
,cust_person_id_upd  numeric (38,0)
,bill_loca_id_bill  numeric (38,0)
,loca_id_sect_cust  numeric (22,0)
,bill_chrg_id_bill  numeric (22,0)
,chrg_person_id_cust  numeric (22,0)
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
 CREATE INDEX sio_r_custs_uk1 
  ON sio.sio_r_custs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custs_seq ;
 create sequence sio.sio_r_custs_seq ;
