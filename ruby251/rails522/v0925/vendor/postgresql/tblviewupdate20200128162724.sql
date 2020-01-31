
 --- drop view r_suppliers cascade  
 create or replace view r_suppliers as select  
  payment.scrlv_code_chrg_payment  scrlv_code_chrg_payment ,
  chrg_supplier.scrlv_code_chrg  scrlv_code_chrg_supplier ,
  payment.payment_chrg_id_payment  payment_chrg_id_payment ,
  loca_supplier.loca_abbr  loca_abbr_supplier ,
  loca_supplier.loca_zip  loca_zip_supplier ,
  loca_supplier.loca_country  loca_country_supplier ,
  loca_supplier.loca_prfct  loca_prfct_supplier ,
  loca_supplier.loca_addr1  loca_addr1_supplier ,
  loca_supplier.loca_addr2  loca_addr2_supplier ,
  loca_supplier.loca_tel  loca_tel_supplier ,
  loca_supplier.loca_fax  loca_fax_supplier ,
  loca_supplier.loca_mail  loca_mail_supplier ,
  payment.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment ,
  chrg_supplier.loca_code_sect_chrg  loca_code_sect_chrg_supplier ,
  loca_supplier.loca_code  loca_code_supplier ,
  payment.loca_code_payment  loca_code_payment ,
  payment.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment ,
  chrg_supplier.loca_name_sect_chrg  loca_name_sect_chrg_supplier ,
  loca_supplier.loca_name  loca_name_supplier ,
  payment.loca_name_payment  loca_name_payment ,
  chrg_supplier.person_code_chrg  person_code_chrg_supplier ,
  payment.person_code_chrg_payment  person_code_chrg_payment ,
  chrg_supplier.person_name_chrg  person_name_chrg_supplier ,
  payment.person_name_chrg_payment  person_name_chrg_payment ,
  chrg_supplier.person_email_chrg  person_email_chrg_supplier ,
  chrg_supplier.scrlv_level1_chrg  scrlv_level1_chrg_supplier ,
supplier.amtdecimal  supplier_amtdecimal,
supplier.remark  supplier_remark,
supplier.created_at  supplier_created_at,
supplier.update_ip  supplier_update_ip,
supplier.custtype  supplier_custtype,
supplier.expiredate  supplier_expiredate,
supplier.updated_at  supplier_updated_at,
supplier.id  supplier_id,
supplier.id id,
supplier.persons_id_upd   supplier_person_id_upd,
supplier.contents  supplier_contents,
supplier.locas_id_supplier   supplier_loca_id_supplier,
supplier.contract_price  supplier_contract_price,
supplier.rule_price  supplier_rule_price,
supplier.amtround  supplier_amtround,
supplier.chrgs_id_supplier   supplier_chrg_id_supplier,
supplier.personname  supplier_personname,
supplier.payments_id   supplier_payment_id,
supplier.crrs_id_supplier   supplier_crr_id_supplier,
  chrg_supplier.usrgrp_name_chrg  usrgrp_name_chrg_supplier ,
  payment.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment ,
  crr_supplier.crr_code  crr_code_supplier ,
  crr_supplier.crr_pricedecimal  crr_pricedecimal_supplier ,
  crr_supplier.crr_amtdecimal  crr_amtdecimal_supplier ,
  crr_supplier.crr_contents  crr_contents_supplier ,
  crr_supplier.crr_name  crr_name_supplier ,
  payment.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
  chrg_supplier.person_sect_id_chrg  person_sect_id_chrg_supplier ,
  chrg_supplier.usrgrp_code_chrg  usrgrp_code_chrg_supplier ,
  payment.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment ,
  payment.payment_loca_id_payment  payment_loca_id_payment ,
  payment.payment_contents  payment_contents ,
  payment.payment_personname  payment_personname ,
  payment.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
  chrg_supplier.chrg_person_id_chrg  chrg_person_id_chrg_supplier 
 from suppliers   supplier,
  r_persons  person_upd ,  r_locas  loca_supplier ,  r_chrgs  chrg_supplier ,  r_payments  payment ,  r_crrs  crr_supplier 
  where       supplier.persons_id_upd = person_upd.id      and supplier.locas_id_supplier = loca_supplier.id      and supplier.chrgs_id_supplier = chrg_supplier.id      and supplier.payments_id = payment.id      and supplier.crrs_id_supplier = crr_supplier.id     ;
 DROP TABLE IF EXISTS sio.sio_r_suppliers;
 CREATE TABLE sio.sio_r_suppliers (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_suppliers_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,loca_code_supplier  varchar (50) 
,loca_name_supplier  varchar (100) 
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
,supplier_custtype  varchar (1) 
,supplier_amtdecimal  numeric (38,0)
,supplier_expiredate   date 
,supplier_contract_price  varchar (1) 
,supplier_rule_price  varchar (1) 
,supplier_amtround  varchar (2) 
,supplier_personname  varchar (30) 
,loca_addr1_supplier  varchar (50) 
,loca_prfct_supplier  varchar (20) 
,loca_country_supplier  varchar (20) 
,crr_pricedecimal_supplier  numeric (22,0)
,crr_amtdecimal_supplier  numeric (22,0)
,crr_contents_supplier  varchar (4000) 
,loca_zip_supplier  varchar (10) 
,loca_fax_supplier  varchar (20) 
,loca_mail_supplier  varchar (20) 
,loca_abbr_supplier  varchar (50) 
,loca_addr2_supplier  varchar (50) 
,payment_contents  varchar (4000) 
,payment_personname  varchar (30) 
,person_email_chrg_supplier  varchar (50) 
,scrlv_level1_chrg_supplier  varchar (1) 
,loca_tel_supplier  varchar (20) 
,supplier_contents  varchar (4000) 
,supplier_remark  varchar (4000) 
,supplier_crr_id_supplier  numeric (22,0)
,supplier_created_at   timestamp(6) 
,supplier_update_ip  varchar (40) 
,supplier_updated_at   timestamp(6) 
,supplier_id  numeric (38,0)
,id  numeric (38,0)
,supplier_person_id_upd  numeric (38,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_payment_id  numeric (38,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
,payment_chrg_id_payment  numeric (22,0)
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
 CREATE INDEX sio_r_suppliers_uk1 
  ON sio.sio_r_suppliers(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_suppliers_seq ;
 create sequence sio.sio_r_suppliers_seq ;
