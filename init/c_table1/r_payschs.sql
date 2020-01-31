
--- drop view r_payschs cascade  
 create or replace view r_payschs as select  
paysch.chrgs_id   paysch_chrg_id,
paysch.crrs_id_pur   paysch_crr_id_pur,
paysch.contract_price  paysch_contract_price,
paysch.suppliers_id   paysch_supplier_id,
paysch.payments_id_pay   paysch_payment_id_pay,
  itm.unit_code  unit_code ,
  itm.unit_name  unit_name ,
paysch.itm_code_client  paysch_itm_code_client,
  itm.itm_std  itm_std ,
  itm.itm_model  itm_model ,
  itm.itm_material  itm_material ,
  itm.itm_design  itm_design ,
  itm.itm_weight  itm_weight ,
  itm.itm_length  itm_length ,
  itm.itm_wide  itm_wide ,
  itm.itm_deth  itm_deth ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name ,
  payment_pay.scrlv_code_chrg_payment  scrlv_code_chrg_payment_pay ,
  supplier.scrlv_code_chrg_payment  scrlv_code_chrg_payment ,
  supplier.scrlv_code_chrg_supplier  scrlv_code_chrg_supplier ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  payment_pay.payment_chrg_id_payment  payment_chrg_id_payment_pay ,
  supplier.payment_chrg_id_payment  payment_chrg_id_payment ,
  supplier.loca_abbr_supplier  loca_abbr_supplier ,
  supplier.loca_zip_supplier  loca_zip_supplier ,
  supplier.loca_country_supplier  loca_country_supplier ,
  supplier.loca_prfct_supplier  loca_prfct_supplier ,
  supplier.loca_addr1_supplier  loca_addr1_supplier ,
  supplier.loca_addr2_supplier  loca_addr2_supplier ,
  supplier.loca_tel_supplier  loca_tel_supplier ,
  supplier.loca_fax_supplier  loca_fax_supplier ,
  supplier.loca_mail_supplier  loca_mail_supplier ,
  payment_pay.loca_code_payment  loca_code_payment_pay ,
  payment_pay.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment_pay ,
  supplier.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment ,
  supplier.loca_code_sect_chrg_supplier  loca_code_sect_chrg_supplier ,
  supplier.loca_code_supplier  loca_code_supplier ,
  supplier.loca_code_payment  loca_code_payment ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  payment_pay.loca_name_payment  loca_name_payment_pay ,
  payment_pay.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment_pay ,
  supplier.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment ,
  supplier.loca_name_sect_chrg_supplier  loca_name_sect_chrg_supplier ,
  supplier.loca_name_supplier  loca_name_supplier ,
  supplier.loca_name_payment  loca_name_payment ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  payment_pay.person_code_chrg_payment  person_code_chrg_payment_pay ,
  supplier.person_code_chrg_supplier  person_code_chrg_supplier ,
  supplier.person_code_chrg_payment  person_code_chrg_payment ,
  chrg.person_code_chrg  person_code_chrg ,
  payment_pay.person_name_chrg_payment  person_name_chrg_payment_pay ,
  supplier.person_name_chrg_supplier  person_name_chrg_supplier ,
  supplier.person_name_chrg_payment  person_name_chrg_payment ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_email_chrg  person_email_chrg ,
  itm.itm_unit_id  itm_unit_id ,
  chrg.scrlv_level1_chrg  scrlv_level1_chrg ,
  itm.itm_classlist_id  itm_classlist_id ,
  itm.itm_datascale  itm_datascale ,
  supplier.supplier_amtdecimal  supplier_amtdecimal ,
  supplier.supplier_custtype  supplier_custtype ,
  supplier.supplier_contents  supplier_contents ,
  supplier.supplier_loca_id_supplier  supplier_loca_id_supplier ,
  supplier.supplier_contract_price  supplier_contract_price ,
  supplier.supplier_rule_price  supplier_rule_price ,
  supplier.supplier_amtround  supplier_amtround ,
  supplier.supplier_chrg_id_supplier  supplier_chrg_id_supplier ,
  supplier.supplier_personname  supplier_personname ,
  supplier.supplier_payment_id  supplier_payment_id ,
  supplier.supplier_crr_id_supplier  supplier_crr_id_supplier ,
  itm.unit_contents  unit_contents ,
paysch.isudate  paysch_isudate,
paysch.duedate  paysch_duedate,
paysch.qty  paysch_qty,
paysch.price  paysch_price,
paysch.amt  paysch_amt,
paysch.tax  paysch_tax,
paysch.expiredate  paysch_expiredate,
paysch.persons_id_upd   paysch_person_id_upd,
paysch.updated_at  paysch_updated_at,
paysch.created_at  paysch_created_at,
paysch.update_ip  paysch_update_ip,
paysch.id  paysch_id,
paysch.id id,
paysch.sno  paysch_sno,
paysch.itms_id   paysch_itm_id,
  payment_pay.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment_pay ,
  supplier.usrgrp_name_chrg_supplier  usrgrp_name_chrg_supplier ,
  supplier.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  itm.classlist_code  classlist_code ,
  crr_pur.crr_code  crr_code_pur ,
  supplier.crr_code_supplier  crr_code_supplier ,
  crr_pur.crr_pricedecimal  crr_pricedecimal_pur ,
  crr_pur.crr_amtdecimal  crr_amtdecimal_pur ,
  crr_pur.crr_contents  crr_contents_pur ,
  crr_pur.crr_name  crr_name_pur ,
  supplier.crr_name_supplier  crr_name_supplier ,
  payment_pay.person_sect_id_chrg_payment  person_sect_id_chrg_payment_pay ,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  payment_pay.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment_pay ,
  supplier.usrgrp_code_chrg_supplier  usrgrp_code_chrg_supplier ,
  supplier.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  itm.classlist_name  classlist_name ,
  payment_pay.payment_loca_id_payment  payment_loca_id_payment_pay ,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
paysch.remark  paysch_remark,
paysch.contents  paysch_contents,
  payment_pay.payment_contents  payment_contents_pay ,
  payment_pay.payment_personname  payment_personname_pay ,
  payment_pay.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment_pay ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg 
 from payschs   paysch,
  r_chrgs  chrg ,  r_crrs  crr_pur ,  r_suppliers  supplier ,  r_payments  payment_pay ,  r_persons  person_upd ,  r_itms  itm 
  where       paysch.chrgs_id = chrg.id      and paysch.crrs_id_pur = crr_pur.id      and paysch.suppliers_id = supplier.id      and paysch.payments_id_pay = payment_pay.id      and paysch.persons_id_upd = person_upd.id      and paysch.itms_id = itm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_payschs;
 CREATE TABLE sio.sio_r_payschs (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_payschs_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,paysch_sno  varchar (40) 
,loca_name_sect_chrg  varchar (100) 
,person_code_chrg_payment_pay  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_code_chrg_payment  varchar (50) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,classlist_name  varchar (100) 
,usrgrp_code_chrg_supplier  varchar (50) 
,usrgrp_code_chrg_payment_pay  varchar (50) 
,crr_name_supplier  varchar (100) 
,crr_name_pur  varchar (100) 
,crr_code_supplier  varchar (50) 
,crr_code_pur  varchar (50) 
,classlist_code  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,scrlv_code_chrg_payment_pay  varchar (50) 
,scrlv_code_chrg_payment  varchar (50) 
,scrlv_code_chrg_supplier  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,usrgrp_name_chrg_payment  varchar (100) 
,usrgrp_name_chrg_supplier  varchar (100) 
,usrgrp_name_chrg_payment_pay  varchar (100) 
,person_name_chrg  varchar (100) 
,person_name_chrg_payment  varchar (100) 
,person_name_chrg_supplier  varchar (100) 
,person_name_chrg_payment_pay  varchar (100) 
,person_code_chrg  varchar (50) 
,person_code_chrg_payment  varchar (50) 
,person_code_chrg_supplier  varchar (50) 
,loca_code_payment_pay  varchar (50) 
,loca_code_sect_chrg_payment_pay  varchar (50) 
,loca_code_sect_chrg_payment  varchar (50) 
,loca_code_sect_chrg_supplier  varchar (50) 
,loca_code_supplier  varchar (50) 
,loca_code_payment  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_payment_pay  varchar (100) 
,loca_name_sect_chrg_payment_pay  varchar (100) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_name_sect_chrg_supplier  varchar (100) 
,loca_name_payment  varchar (100) 
,loca_name_supplier  varchar (100) 
,paysch_duedate   timestamp(6) 
,paysch_contract_price  varchar (1) 
,paysch_itm_code_client  varchar (50) 
,paysch_isudate   timestamp(6) 
,paysch_qty  numeric (18,4)
,paysch_price  numeric (38,4)
,paysch_amt  numeric (18,4)
,paysch_tax  numeric (38,4)
,paysch_expiredate   date 
,itm_material  varchar (50) 
,itm_deth  numeric (22,0)
,itm_wide  numeric (22,0)
,itm_length  numeric (22,0)
,itm_weight  numeric (22,0)
,crr_pricedecimal_pur  numeric (22,0)
,crr_amtdecimal_pur  numeric (22,0)
,crr_contents_pur  varchar (4000) 
,supplier_contents  varchar (4000) 
,loca_addr2_supplier  varchar (50) 
,supplier_contract_price  varchar (1) 
,supplier_rule_price  varchar (1) 
,supplier_amtround  varchar (2) 
,loca_tel_supplier  varchar (20) 
,supplier_personname  varchar (30) 
,loca_fax_supplier  varchar (20) 
,loca_mail_supplier  varchar (20) 
,unit_contents  varchar (4000) 
,payment_contents_pay  varchar (4000) 
,person_email_chrg  varchar (50) 
,payment_personname_pay  varchar (30) 
,loca_abbr_supplier  varchar (50) 
,itm_design  varchar (50) 
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,loca_prfct_supplier  varchar (20) 
,scrlv_level1_chrg  varchar (1) 
,loca_addr1_supplier  varchar (50) 
,itm_datascale  numeric (22,0)
,supplier_amtdecimal  numeric (38,0)
,supplier_custtype  varchar (1) 
,loca_zip_supplier  varchar (10) 
,loca_country_supplier  varchar (20) 
,paysch_contents  varchar (4000) 
,paysch_remark  varchar (4000) 
,paysch_itm_id  numeric (38,0)
,paysch_chrg_id  numeric (38,0)
,paysch_person_id_upd  numeric (38,0)
,paysch_updated_at   timestamp(6) 
,paysch_created_at   timestamp(6) 
,paysch_update_ip  varchar (40) 
,paysch_id  numeric (38,0)
,id  numeric (38,0)
,paysch_payment_id_pay  numeric (22,0)
,paysch_supplier_id  numeric (22,0)
,paysch_crr_id_pur  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,supplier_loca_id_supplier  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,payment_loca_id_payment_pay  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,chrg_person_id_chrg_payment_pay  numeric (38,0)
,supplier_crr_id_supplier  numeric (22,0)
,supplier_payment_id  numeric (38,0)
,supplier_chrg_id_supplier  numeric (22,0)
,payment_chrg_id_payment_pay  numeric (22,0)
,payment_chrg_id_payment  numeric (22,0)
,person_sect_id_chrg_payment_pay  numeric (22,0)
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
 CREATE INDEX sio_r_payschs_uk1 
  ON sio.sio_r_payschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_payschs_seq ;
 create sequence sio.sio_r_payschs_seq ;
