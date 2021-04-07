
  drop view if  exists r_dlvschs cascade ; 
 create or replace view r_dlvschs as select  
dlvsch.sno  dlvsch_sno,
dlvsch.prjnos_id   dlvsch_prjno_id,
dlvsch.itms_id   dlvsch_itm_id,
dlvsch.depdate  dlvsch_depdate,
dlvsch.isudate  dlvsch_isudate,
dlvsch.id id,
dlvsch.id  dlvsch_id,
dlvsch.updated_at  dlvsch_updated_at,
dlvsch.update_ip  dlvsch_update_ip,
dlvsch.expiredate  dlvsch_expiredate,
dlvsch.price  dlvsch_price,
dlvsch.amt  dlvsch_amt,
dlvsch.qty_sch  dlvsch_qty_sch,
dlvsch.locas_id_fm   dlvsch_loca_id_fm,
dlvsch.locas_id_to   dlvsch_loca_id_to,
dlvsch.transports_id   dlvsch_transport_id,
dlvsch.toduedate  dlvsch_toduedate,
dlvsch.duedate  dlvsch_duedate,
dlvsch.persons_id_upd   dlvsch_person_id_upd,
dlvsch.created_at  dlvsch_created_at,
dlvsch.remark  dlvsch_remark,
dlvsch.contents  dlvsch_contents,
dlvsch.tblname  dlvsch_tblname,
dlvsch.tblid  dlvsch_tblid,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code  prjno_code ,
  itm.itm_classlist_id  itm_classlist_id ,
  itm.itm_unit_id  itm_unit_id ,
  itm.classlist_name  classlist_name ,
  itm.classlist_code  classlist_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name ,
  loca_fm.loca_code  loca_code_fm ,
  loca_fm.loca_name  loca_name_fm ,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to ,
  transport.transport_code  transport_code ,
  transport.transport_name  transport_name 
 from dlvschs   dlvsch,
  r_prjnos  prjno ,  r_itms  itm ,  r_locas  loca_fm ,  r_locas  loca_to ,  r_transports  transport ,  r_persons  person_upd 
  where       dlvsch.prjnos_id = prjno.id      and dlvsch.itms_id = itm.id      and dlvsch.locas_id_fm = loca_fm.id      and dlvsch.locas_id_to = loca_to.id      and dlvsch.transports_id = transport.id      and dlvsch.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_dlvschs;
 CREATE TABLE sio.sio_r_dlvschs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_dlvschs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,dlvsch_sno  varchar (40) 
,prjno_code  varchar (50) 
,transport_name  varchar (100) 
,prjno_name  varchar (100) 
,loca_code_to  varchar (50) 
,loca_name_fm  varchar (100) 
,loca_code_fm  varchar (50) 
,itm_name  varchar (100) 
,itm_code  varchar (50) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,transport_code  varchar (50) 
,loca_name_to  varchar (100) 
,dlvsch_depdate   timestamp(6) 
,dlvsch_isudate   timestamp(6) 
,dlvsch_duedate   timestamp(6) 
,dlvsch_tblname  varchar (30) 
,dlvsch_tblid  numeric (38,0)
,dlvsch_toduedate   timestamp(6) 
,dlvsch_expiredate   date 
,dlvsch_price  numeric (38,4)
,dlvsch_amt  numeric (18,4)
,dlvsch_qty_sch  numeric (22,6)
,transport_contents  varchar (4000) 
,opeitm_packno_proc  varchar (1) 
,itm_weight  numeric (22,0)
,loca_tel_fm  varchar (20) 
,loca_mail_fm  varchar (20) 
,loca_addr1_fm  varchar (50) 
,loca_zip_fm  varchar (10) 
,loca_fax_fm  varchar (20) 
,loca_addr2_fm  varchar (50) 
,loca_country_to  varchar (20) 
,loca_abbr_to  varchar (50) 
,loca_prfct_to  varchar (20) 
,loca_tel_to  varchar (20) 
,loca_mail_to  varchar (20) 
,loca_addr1_to  varchar (50) 
,loca_zip_to  varchar (10) 
,loca_fax_to  varchar (20) 
,loca_addr2_to  varchar (50) 
,unit_contents  varchar (4000) 
,itm_length  numeric (22,0)
,itm_design  varchar (50) 
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,itm_material  varchar (50) 
,itm_model  varchar (50) 
,itm_datascale  numeric (22,0)
,loca_country_fm  varchar (20) 
,loca_abbr_fm  varchar (50) 
,loca_prfct_fm  varchar (20) 
,dlvsch_contents  varchar (4000) 
,dlvsch_remark  varchar (4000) 
,dlvsch_loca_id_fm  numeric (38,0)
,dlvsch_id  numeric (38,0)
,id  numeric (38,0)
,dlvsch_itm_id  numeric (38,0)
,dlvsch_update_ip  varchar (40) 
,dlvsch_updated_at   timestamp(6) 
,dlvsch_transport_id  numeric (38,0)
,dlvsch_loca_id_to  numeric (38,0)
,dlvsch_created_at   timestamp(6) 
,dlvsch_person_id_upd  numeric (38,0)
,dlvsch_prjno_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
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
 CREATE INDEX sio_r_dlvschs_uk1 
  ON sio.sio_r_dlvschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_dlvschs_seq ;
 create sequence sio.sio_r_dlvschs_seq ;
  drop view if  exists r_billschs cascade ; 
 create or replace view r_billschs as select  
billsch.duedate  billsch_duedate,
billsch.bills_id   billsch_bill_id,
billsch.tblname  billsch_tblname,
billsch.tblid  billsch_tblid,
billsch.saledate  billsch_saledate,
billsch.id id,
billsch.id  billsch_id,
billsch.itms_id   billsch_itm_id,
billsch.isudate  billsch_isudate,
billsch.expiredate  billsch_expiredate,
billsch.updated_at  billsch_updated_at,
billsch.sno  billsch_sno,
billsch.price  billsch_price,
billsch.created_at  billsch_created_at,
billsch.update_ip  billsch_update_ip,
billsch.amt  billsch_amt,
billsch.qty_sch  billsch_qty_sch,
billsch.tax  billsch_tax,
billsch.persons_id_upd   billsch_person_id_upd,
billsch.remark  billsch_remark,
billsch.contents  billsch_contents,
  bill.loca_name_bill  loca_name_bill ,
  bill.loca_code_bill  loca_code_bill ,
  bill.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  bill.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  bill.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  bill.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  bill.person_name_chrg_bill  person_name_chrg_bill ,
  bill.person_code_chrg_bill  person_code_chrg_bill ,
  bill.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  bill.crr_name_bill  crr_name_bill ,
  bill.crr_code_bill  crr_code_bill ,
  bill.bill_chrg_id_bill  bill_chrg_id_bill ,
  bill.bill_crr_id_bill  bill_crr_id_bill ,
  bill.bill_loca_id_bill  bill_loca_id_bill ,
  bill.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  bill.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  itm.itm_classlist_id  itm_classlist_id ,
  itm.itm_unit_id  itm_unit_id ,
  itm.classlist_name  classlist_name ,
  itm.classlist_code  classlist_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name 
 from billschs   billsch,
  r_bills  bill ,  r_itms  itm ,  r_persons  person_upd 
  where       billsch.bills_id = bill.id      and billsch.itms_id = itm.id      and billsch.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_billschs;
 CREATE TABLE sio.sio_r_billschs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_billschs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,billsch_sno  varchar (40) 
,usrgrp_name_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,person_code_chrg_bill  varchar (50) 
,itm_code  varchar (50) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,loca_code_sect_chrg_bill  varchar (50) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,crr_code_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,usrgrp_code_chrg_bill  varchar (50) 
,itm_name  varchar (100) 
,loca_name_bill  varchar (100) 
,loca_code_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,billsch_tblid  numeric (38,0)
,billsch_expiredate   date 
,billsch_saledate   timestamp(6) 
,billsch_isudate   timestamp(6) 
,billsch_price  numeric (38,4)
,billsch_duedate   timestamp(6) 
,billsch_tblname  varchar (30) 
,billsch_amt  numeric (18,4)
,billsch_qty_sch  numeric (22,6)
,billsch_tax  numeric (38,4)
,itm_material  varchar (50) 
,loca_tel_bill  varchar (20) 
,bill_personname  varchar (30) 
,loca_abbr_bill  varchar (50) 
,bill_contents  varchar (4000) 
,itm_weight  numeric (22,0)
,unit_contents  varchar (4000) 
,itm_length  numeric (22,0)
,itm_design  varchar (50) 
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,itm_model  varchar (50) 
,itm_datascale  numeric (22,0)
,billsch_remark  varchar (4000) 
,billsch_contents  varchar (4000) 
,billsch_updated_at   timestamp(6) 
,billsch_update_ip  varchar (40) 
,billsch_bill_id  numeric (38,0)
,billsch_itm_id  numeric (38,0)
,billsch_id  numeric (38,0)
,billsch_created_at   timestamp(6) 
,id  numeric (38,0)
,billsch_person_id_upd  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,bill_chrg_id_bill  numeric (22,0)
,bill_crr_id_bill  numeric (22,0)
,bill_loca_id_bill  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,itm_unit_id  numeric (22,0)
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
 CREATE INDEX sio_r_billschs_uk1 
  ON sio.sio_r_billschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_billschs_seq ;
 create sequence sio.sio_r_billschs_seq ;
  drop view if  exists r_payschs cascade ; 
 create or replace view r_payschs as select  
paysch.sno  paysch_sno,
paysch.chrgs_id   paysch_chrg_id,
paysch.crrs_id_pur   paysch_crr_id_pur,
paysch.contract_price  paysch_contract_price,
paysch.suppliers_id   paysch_supplier_id,
paysch.payments_id_pay   paysch_payment_id_pay,
paysch.itm_code_client  paysch_itm_code_client,
paysch.isudate  paysch_isudate,
paysch.duedate  paysch_duedate,
paysch.price  paysch_price,
paysch.amt  paysch_amt,
paysch.tax  paysch_tax,
paysch.expiredate  paysch_expiredate,
paysch.persons_id_upd   paysch_person_id_upd,
paysch.created_at  paysch_created_at,
paysch.update_ip  paysch_update_ip,
paysch.id id,
paysch.id  paysch_id,
paysch.itms_id   paysch_itm_id,
paysch.qty_sch  paysch_qty_sch,
paysch.remark  paysch_remark,
paysch.contents  paysch_contents,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  crr_pur.crr_name  crr_name_pur ,
  crr_pur.crr_code  crr_code_pur ,
  supplier.scrlv_code_chrg_supplier  scrlv_code_chrg_supplier ,
  supplier.loca_code_supplier  loca_code_supplier ,
  supplier.loca_name_supplier  loca_name_supplier ,
  supplier.supplier_payment_id  supplier_payment_id ,
  supplier.supplier_loca_id_supplier  supplier_loca_id_supplier ,
  supplier.supplier_chrg_id_supplier  supplier_chrg_id_supplier ,
  supplier.supplier_crr_id_supplier  supplier_crr_id_supplier ,
  supplier.payment_chrg_id_payment  payment_chrg_id_payment ,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  supplier.loca_code_sect_chrg_supplier  loca_code_sect_chrg_supplier ,
  supplier.person_code_chrg_supplier  person_code_chrg_supplier ,
  supplier.usrgrp_name_chrg_supplier  usrgrp_name_chrg_supplier ,
  supplier.person_name_chrg_supplier  person_name_chrg_supplier ,
  supplier.loca_name_sect_chrg_supplier  loca_name_sect_chrg_supplier ,
  supplier.scrlv_code_chrg_payment  scrlv_code_chrg_payment ,
  supplier.usrgrp_code_chrg_supplier  usrgrp_code_chrg_supplier ,
  supplier.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment ,
  supplier.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment ,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.person_code_chrg_payment  person_code_chrg_payment ,
  supplier.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment ,
  supplier.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment ,
  supplier.person_name_chrg_payment  person_name_chrg_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  supplier.crr_code_supplier  crr_code_supplier ,
  supplier.crr_name_supplier  crr_name_supplier ,
  payment_pay.person_sect_id_chrg_payment  person_sect_id_chrg_payment_pay ,
  payment_pay.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment_pay ,
  payment_pay.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment_pay ,
  payment_pay.scrlv_code_chrg_payment  scrlv_code_chrg_payment_pay ,
  payment_pay.person_name_chrg_payment  person_name_chrg_payment_pay ,
  payment_pay.loca_name_payment  loca_name_payment_pay ,
  payment_pay.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment_pay ,
  payment_pay.person_code_chrg_payment  person_code_chrg_payment_pay ,
  payment_pay.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment_pay ,
  payment_pay.loca_code_payment  loca_code_payment_pay ,
  payment_pay.payment_chrg_id_payment  payment_chrg_id_payment_pay ,
  payment_pay.payment_loca_id_payment  payment_loca_id_payment_pay ,
  payment_pay.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment_pay ,
  itm.itm_classlist_id  itm_classlist_id ,
  itm.itm_unit_id  itm_unit_id ,
  itm.classlist_name  classlist_name ,
  itm.classlist_code  classlist_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name ,
paysch.updated_at  paysch_updated_at
 from payschs   paysch,
  r_chrgs  chrg ,  r_crrs  crr_pur ,  r_suppliers  supplier ,  r_payments  payment_pay ,  r_persons  person_upd ,  r_itms  itm 
  where       paysch.chrgs_id = chrg.id      and paysch.crrs_id_pur = crr_pur.id      and paysch.suppliers_id = supplier.id      and paysch.payments_id_pay = payment_pay.id      and paysch.persons_id_upd = person_upd.id      and paysch.itms_id = itm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_payschs;
 CREATE TABLE sio.sio_r_payschs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_payschs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,paysch_sno  varchar (40) 
,person_code_chrg_payment  varchar (50) 
,loca_code_payment  varchar (50) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_code_sect_chrg_supplier  varchar (50) 
,person_code_chrg_supplier  varchar (50) 
,usrgrp_name_chrg_supplier  varchar (100) 
,person_name_chrg_supplier  varchar (100) 
,loca_name_sect_chrg_supplier  varchar (100) 
,scrlv_code_chrg_payment  varchar (50) 
,usrgrp_code_chrg_supplier  varchar (50) 
,loca_code_sect_chrg_payment  varchar (50) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,loca_code_payment_pay  varchar (50) 
,usrgrp_name_chrg_payment_pay  varchar (100) 
,person_code_chrg_payment_pay  varchar (50) 
,loca_name_sect_chrg_payment_pay  varchar (100) 
,usrgrp_name_chrg_payment  varchar (100) 
,loca_code_supplier  varchar (50) 
,loca_name_supplier  varchar (100) 
,unit_name  varchar (100) 
,loca_code_sect_chrg_payment_pay  varchar (50) 
,crr_name_supplier  varchar (100) 
,crr_code_supplier  varchar (50) 
,loca_name_payment  varchar (100) 
,person_name_chrg_payment  varchar (100) 
,usrgrp_code_chrg_payment  varchar (50) 
,loca_name_payment_pay  varchar (100) 
,person_name_chrg_payment_pay  varchar (100) 
,scrlv_code_chrg_payment_pay  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,itm_name  varchar (100) 
,person_name_chrg  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,person_code_chrg  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,usrgrp_code_chrg_payment_pay  varchar (50) 
,itm_code  varchar (50) 
,crr_name_pur  varchar (100) 
,unit_code  varchar (50) 
,crr_code_pur  varchar (50) 
,scrlv_code_chrg_supplier  varchar (50) 
,paysch_qty_sch  numeric (22,6)
,paysch_contract_price  varchar (1) 
,paysch_itm_code_client  varchar (50) 
,paysch_isudate   timestamp(6) 
,paysch_duedate   timestamp(6) 
,paysch_price  numeric (38,4)
,paysch_amt  numeric (18,4)
,paysch_expiredate   date 
,paysch_tax  numeric (38,4)
,person_email_chrg  varchar (50) 
,scrlv_level1_chrg  varchar (1) 
,crr_contents_pur  varchar (4000) 
,crr_amtdecimal_pur  numeric (22,0)
,crr_pricedecimal_pur  numeric (22,0)
,supplier_amtdecimal  numeric (38,0)
,supplier_custtype  varchar (1) 
,supplier_contents  varchar (4000) 
,supplier_contract_price  varchar (1) 
,supplier_rule_price  varchar (1) 
,supplier_amtround  varchar (2) 
,supplier_personname  varchar (30) 
,payment_contents_pay  varchar (4000) 
,payment_personname_pay  varchar (30) 
,itm_weight  numeric (22,0)
,unit_contents  varchar (4000) 
,itm_length  numeric (22,0)
,itm_design  varchar (50) 
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,itm_material  varchar (50) 
,itm_model  varchar (50) 
,itm_datascale  numeric (22,0)
,paysch_remark  varchar (4000) 
,paysch_contents  varchar (4000) 
,paysch_update_ip  varchar (40) 
,paysch_payment_id_pay  numeric (22,0)
,paysch_supplier_id  numeric (22,0)
,paysch_itm_id  numeric (38,0)
,paysch_crr_id_pur  numeric (22,0)
,paysch_id  numeric (38,0)
,paysch_chrg_id  numeric (38,0)
,paysch_person_id_upd  numeric (38,0)
,paysch_created_at   timestamp(6) 
,id  numeric (38,0)
,paysch_updated_at   timestamp(6) 
,supplier_crr_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_loca_id_supplier  numeric (22,0)
,person_sect_id_chrg_payment_pay  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,supplier_payment_id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,payment_chrg_id_payment_pay  numeric (22,0)
,payment_loca_id_payment_pay  numeric (38,0)
,chrg_person_id_chrg_payment_pay  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
,person_sect_id_chrg_payment  numeric (22,0)
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
 CREATE INDEX sio_r_payschs_uk1 
  ON sio.sio_r_payschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_payschs_seq ;
 create sequence sio.sio_r_payschs_seq ;
  drop view if  exists r_custschs cascade ; 
 create or replace view r_custschs as select  
custsch.id id,
custsch.id  custsch_id,
custsch.custs_id   custsch_cust_id,
custsch.duedate  custsch_duedate,
custsch.isudate  custsch_isudate,
custsch.price  custsch_price,
custsch.amt  custsch_amt,
custsch.cno  custsch_cno,
custsch.remark  custsch_remark,
custsch.expiredate  custsch_expiredate,
custsch.persons_id_upd   custsch_person_id_upd,
custsch.update_ip  custsch_update_ip,
custsch.created_at  custsch_created_at,
custsch.updated_at  custsch_updated_at,
custsch.contents  custsch_contents,
custsch.opeitms_id   custsch_opeitm_id,
custsch.qty_sch  custsch_qty_sch,
custsch.gno  custsch_gno,
custsch.contract_price  custsch_contract_price,
custsch.starttime  custsch_starttime,
custsch.sno  custsch_sno,
custsch.prjnos_id   custsch_prjno_id,
  cust.cust_bill_id  cust_bill_id ,
  cust.cust_loca_id_cust  cust_loca_id_cust ,
  cust.cust_chrg_id_cust  cust_chrg_id_cust ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code  prjno_code 
 from custschs   custsch,
  r_custs  cust ,  r_persons  person_upd ,  r_opeitms  opeitm ,  r_prjnos  prjno 
  where       custsch.custs_id = cust.id      and custsch.persons_id_upd = person_upd.id      and custsch.opeitms_id = opeitm.id      and custsch.prjnos_id = prjno.id     ;
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
,custsch_gno  varchar (40) 
,custsch_cno  varchar (40) 
,custsch_sno  varchar (40) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,prjno_code  varchar (50) 
,custsch_amt  numeric (18,4)
,custsch_contract_price  varchar (1) 
,custsch_duedate   timestamp(6) 
,custsch_expiredate   date 
,custsch_qty_sch  numeric (22,6)
,custsch_starttime   timestamp(6) 
,custsch_isudate   timestamp(6) 
,custsch_price  numeric (38,4)
,opeitm_acceptance_proc  varchar (1) 
,opeitm_safestkqty  numeric (22,0)
,opeitm_packqty  numeric (18,2)
,opeitm_shuffle_flg  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_chkinst_proc  varchar (1) 
,opeitm_esttosch  numeric (38,0)
,opeitm_stktaking_proc  varchar (1) 
,opeitm_rule_price  varchar (1) 
,opeitm_mold  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_packno_proc  varchar (1) 
,opeitm_processseq  numeric (38,0)
,opeitm_priority  numeric (38,0)
,opeitm_contents  varchar (4000) 
,opeitm_chkord_proc  varchar (3) 
,opeitm_maxqty  numeric (22,6)
,opeitm_prjalloc_flg  numeric (38,0)
,opeitm_prdpurshp  varchar (5) 
,itm_std  varchar (50) 
,cust_autocreate_custact  varchar (1) 
,cust_contract_price  varchar (1) 
,cust_rule_price  varchar (1) 
,cust_personname  varchar (30) 
,cust_amtround  varchar (2) 
,cust_amtdecimal  numeric (38,0)
,cust_custtype  varchar (1) 
,cust_contents  varchar (4000) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autoinst_p  numeric (3,0)
,opeitm_lotno_proc  varchar (3) 
,opeitm_autoact_p  numeric (3,0)
,opeitm_autoord_p  numeric (3,0)
,opeitm_duration  numeric (38,2)
,opeitm_units_lttime  varchar (4) 
,opeitm_minqty  numeric (22,6)
,opeitm_operation  varchar (40) 
,opeitm_opt_fixoterm  numeric (5,2)
,custsch_remark  varchar (4000) 
,custsch_contents  varchar (4000) 
,custsch_prjno_id  numeric (38,0)
,id  numeric (38,0)
,custsch_cust_id  numeric (38,0)
,custsch_updated_at   timestamp(6) 
,custsch_opeitm_id  numeric (38,0)
,custsch_created_at   timestamp(6) 
,custsch_person_id_upd  numeric (38,0)
,custsch_update_ip  varchar (40) 
,custsch_id  numeric (38,0)
,opeitm_shelfno_id  numeric (38,0)
,cust_bill_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,cust_loca_id_cust  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,cust_chrg_id_cust  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_boxe_id  numeric (38,0)
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
  drop view if  exists r_prdschs cascade ; 
 create or replace view r_prdschs as select  
prdsch.gno  prdsch_gno,
prdsch.chrgs_id   prdsch_chrg_id,
prdsch.starttime  prdsch_starttime,
prdsch.qty_bal  prdsch_qty_bal,
prdsch.isudate  prdsch_isudate,
prdsch.qty_sch  prdsch_qty_sch,
prdsch.duedate  prdsch_duedate,
prdsch.toduedate  prdsch_toduedate,
prdsch.sno  prdsch_sno,
prdsch.expiredate  prdsch_expiredate,
prdsch.persons_id_upd   prdsch_person_id_upd,
prdsch.update_ip  prdsch_update_ip,
prdsch.created_at  prdsch_created_at,
prdsch.updated_at  prdsch_updated_at,
prdsch.id id,
prdsch.id  prdsch_id,
prdsch.opeitms_id   prdsch_opeitm_id,
prdsch.shelfnos_id_to   prdsch_shelfno_id_to,
prdsch.remark  prdsch_remark,
prdsch.prjnos_id   prdsch_prjno_id,
prdsch.workplaces_id   prdsch_workplace_id,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code  prjno_code ,
  workplace.loca_code_workplace  loca_code_workplace ,
  workplace.workplace_loca_id_workplace  workplace_loca_id_workplace ,
  workplace.workplace_chrg_id_workplace  workplace_chrg_id_workplace ,
  workplace.loca_code_sect_chrg_workplace  loca_code_sect_chrg_workplace ,
  workplace.scrlv_code_chrg_workplace  scrlv_code_chrg_workplace ,
  workplace.person_code_chrg_workplace  person_code_chrg_workplace ,
  workplace.person_sect_id_chrg_workplace  person_sect_id_chrg_workplace ,
  workplace.chrg_person_id_chrg_workplace  chrg_person_id_chrg_workplace ,
  workplace.usrgrp_code_chrg_workplace  usrgrp_code_chrg_workplace ,
  workplace.usrgrp_name_chrg_workplace  usrgrp_name_chrg_workplace ,
  workplace.person_name_chrg_workplace  person_name_chrg_workplace ,
  workplace.loca_name_sect_chrg_workplace  loca_name_sect_chrg_workplace ,
  workplace.loca_name_workplace  loca_name_workplace 
 from prdschs   prdsch,
  r_chrgs  chrg ,  r_persons  person_upd ,  r_opeitms  opeitm ,  r_shelfnos  shelfno_to ,  r_prjnos  prjno ,  r_workplaces  workplace 
  where       prdsch.chrgs_id = chrg.id      and prdsch.persons_id_upd = person_upd.id      and prdsch.opeitms_id = opeitm.id      and prdsch.shelfnos_id_to = shelfno_to.id      and prdsch.prjnos_id = prjno.id      and prdsch.workplaces_id = workplace.id     ;
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
,prdsch_gno  varchar (40) 
,scrlv_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,person_code_chrg  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,loca_name_shelfno_to  varchar (100) 
,shelfno_name_to  varchar (100) 
,shelfno_code_to  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,prjno_code_chil  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code  varchar (50) 
,loca_code_workplace  varchar (50) 
,loca_code_sect_chrg_workplace  varchar (50) 
,scrlv_code_chrg_workplace  varchar (50) 
,person_code_chrg_workplace  varchar (50) 
,usrgrp_code_chrg_workplace  varchar (50) 
,usrgrp_name_chrg_workplace  varchar (100) 
,person_name_chrg_workplace  varchar (100) 
,loca_name_sect_chrg_workplace  varchar (100) 
,loca_name_workplace  varchar (100) 
,prdsch_toduedate   timestamp(6) 
,prdsch_duedate   timestamp(6) 
,prdsch_qty_sch  numeric (22,6)
,prdsch_isudate   timestamp(6) 
,prdsch_starttime   timestamp(6) 
,prdsch_expiredate   date 
,prdsch_qty_bal  numeric (22,6)
,opeitm_autoact_p  numeric (3,0)
,opeitm_autoord_p  numeric (3,0)
,opeitm_duration  numeric (38,2)
,opeitm_units_lttime  varchar (4) 
,person_email_chrg  varchar (50) 
,shelfno_contents_to  varchar (4000) 
,workplace_contents  varchar (4000) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autoinst_p  numeric (3,0)
,opeitm_lotno_proc  varchar (3) 
,opeitm_minqty  numeric (22,6)
,opeitm_operation  varchar (40) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_safestkqty  numeric (22,0)
,opeitm_packqty  numeric (18,2)
,opeitm_shuffle_flg  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_chkinst_proc  varchar (1) 
,opeitm_esttosch  numeric (38,0)
,opeitm_stktaking_proc  varchar (1) 
,opeitm_rule_price  varchar (1) 
,opeitm_mold  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_packno_proc  varchar (1) 
,opeitm_processseq  numeric (38,0)
,opeitm_priority  numeric (38,0)
,opeitm_contents  varchar (4000) 
,opeitm_acceptance_proc  varchar (1) 
,opeitm_chkord_proc  varchar (3) 
,opeitm_maxqty  numeric (22,6)
,opeitm_prjalloc_flg  numeric (38,0)
,opeitm_prdpurshp  varchar (5) 
,itm_std  varchar (50) 
,scrlv_level1_chrg  varchar (1) 
,prdsch_remark  varchar (4000) 
,prdsch_created_at   timestamp(6) 
,prdsch_updated_at   timestamp(6) 
,id  numeric (38,0)
,prdsch_id  numeric (38,0)
,prdsch_opeitm_id  numeric (38,0)
,prdsch_shelfno_id_to  numeric (38,0)
,prdsch_prjno_id  numeric (38,0)
,prdsch_chrg_id  numeric (38,0)
,prdsch_workplace_id  numeric (22,0)
,prdsch_update_ip  varchar (40) 
,prdsch_person_id_upd  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,chrg_person_id_chrg_workplace  numeric (38,0)
,workplace_chrg_id_workplace  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_shelfno_id  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_boxe_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,workplace_loca_id_workplace  numeric (22,0)
,person_sect_id_chrg_workplace  numeric (22,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
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
  drop view if  exists r_purschs cascade ; 
 create or replace view r_purschs as select  
pursch.crrs_id_pur   pursch_crr_id_pur,
pursch.crrs_id   pursch_crr_id,
pursch.qty_bal  pursch_qty_bal,
pursch.price  pursch_price,
pursch.remark  pursch_remark,
pursch.created_at  pursch_created_at,
pursch.update_ip  pursch_update_ip,
pursch.toduedate  pursch_toduedate,
pursch.isudate  pursch_isudate,
pursch.expiredate  pursch_expiredate,
pursch.duedate  pursch_duedate,
pursch.amt  pursch_amt,
pursch.updated_at  pursch_updated_at,
pursch.sno  pursch_sno,
pursch.id id,
pursch.id  pursch_id,
pursch.persons_id_upd   pursch_person_id_upd,
pursch.prjnos_id   pursch_prjno_id,
pursch.starttime  pursch_starttime,
pursch.tax  pursch_tax,
pursch.shelfnos_id_to   pursch_shelfno_id_to,
pursch.qty_sch  pursch_qty_sch,
pursch.opeitms_id   pursch_opeitm_id,
pursch.gno  pursch_gno,
pursch.suppliers_id   pursch_supplier_id,
pursch.chrgs_id   pursch_chrg_id,
  crr_pur.crr_name  crr_name_pur ,
  crr_pur.crr_code  crr_code_pur ,
  crr.crr_name  crr_name ,
  crr.crr_code  crr_code ,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code  prjno_code ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  supplier.scrlv_code_chrg_supplier  scrlv_code_chrg_supplier ,
  supplier.loca_code_supplier  loca_code_supplier ,
  supplier.loca_name_supplier  loca_name_supplier ,
  supplier.supplier_payment_id  supplier_payment_id ,
  supplier.supplier_loca_id_supplier  supplier_loca_id_supplier ,
  supplier.supplier_chrg_id_supplier  supplier_chrg_id_supplier ,
  supplier.supplier_crr_id_supplier  supplier_crr_id_supplier ,
  supplier.payment_chrg_id_payment  payment_chrg_id_payment ,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  supplier.loca_code_sect_chrg_supplier  loca_code_sect_chrg_supplier ,
  supplier.person_code_chrg_supplier  person_code_chrg_supplier ,
  supplier.usrgrp_name_chrg_supplier  usrgrp_name_chrg_supplier ,
  supplier.person_name_chrg_supplier  person_name_chrg_supplier ,
  supplier.loca_name_sect_chrg_supplier  loca_name_sect_chrg_supplier ,
  supplier.scrlv_code_chrg_payment  scrlv_code_chrg_payment ,
  supplier.usrgrp_code_chrg_supplier  usrgrp_code_chrg_supplier ,
  supplier.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment ,
  supplier.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment ,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.person_code_chrg_payment  person_code_chrg_payment ,
  supplier.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment ,
  supplier.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment ,
  supplier.person_name_chrg_payment  person_name_chrg_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  supplier.crr_code_supplier  crr_code_supplier ,
  supplier.crr_name_supplier  crr_name_supplier ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg 
 from purschs   pursch,
  r_crrs  crr_pur ,  r_crrs  crr ,  r_persons  person_upd ,  r_prjnos  prjno ,  r_shelfnos  shelfno_to ,  r_opeitms  opeitm ,  r_suppliers  supplier ,  r_chrgs  chrg 
  where       pursch.crrs_id_pur = crr_pur.id      and pursch.crrs_id = crr.id      and pursch.persons_id_upd = person_upd.id      and pursch.prjnos_id = prjno.id      and pursch.shelfnos_id_to = shelfno_to.id      and pursch.opeitms_id = opeitm.id      and pursch.suppliers_id = supplier.id      and pursch.chrgs_id = chrg.id     ;
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
,pursch_gno  varchar (40) 
,usrgrp_code_chrg_supplier  varchar (50) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_code_shelfno_to  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,person_code_chrg  varchar (50) 
,loca_name_sect_chrg_supplier  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,crr_name_supplier  varchar (100) 
,crr_code_supplier  varchar (50) 
,loca_name_payment  varchar (100) 
,scrlv_code_chrg_payment  varchar (50) 
,loca_code_sect_chrg_payment  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,person_name_chrg_payment  varchar (100) 
,usrgrp_code_chrg_payment  varchar (50) 
,crr_name_pur  varchar (100) 
,person_code_chrg_payment  varchar (50) 
,loca_code_payment  varchar (50) 
,crr_code_pur  varchar (50) 
,loca_code_sect_chrg_supplier  varchar (50) 
,crr_name  varchar (100) 
,person_code_chrg_supplier  varchar (50) 
,usrgrp_name_chrg_supplier  varchar (100) 
,crr_code  varchar (50) 
,prjno_code_chil  varchar (50) 
,person_name_chrg  varchar (100) 
,prjno_name  varchar (100) 
,prjno_code  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,shelfno_name_to  varchar (100) 
,scrlv_code_chrg_supplier  varchar (50) 
,loca_code_supplier  varchar (50) 
,loca_name_supplier  varchar (100) 
,usrgrp_name_chrg_payment  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,person_name_chrg_supplier  varchar (100) 
,shelfno_code_to  varchar (50) 
,pursch_price  numeric (38,4)
,pursch_qty_bal  numeric (22,6)
,pursch_amt  numeric (18,4)
,pursch_toduedate   timestamp(6) 
,pursch_isudate   timestamp(6) 
,pursch_starttime   timestamp(6) 
,pursch_tax  numeric (38,4)
,pursch_expiredate   date 
,pursch_qty_sch  numeric (22,6)
,pursch_duedate   timestamp(6) 
,supplier_amtdecimal  numeric (38,0)
,crr_contents_pur  varchar (4000) 
,crr_amtdecimal_pur  numeric (22,0)
,crr_pricedecimal_pur  numeric (22,0)
,crr_contents  varchar (4000) 
,crr_amtdecimal  numeric (22,0)
,crr_pricedecimal  numeric (22,0)
,shelfno_contents_to  varchar (4000) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autoinst_p  numeric (3,0)
,opeitm_lotno_proc  varchar (3) 
,opeitm_autoact_p  numeric (3,0)
,opeitm_autoord_p  numeric (3,0)
,opeitm_duration  numeric (38,2)
,opeitm_units_lttime  varchar (4) 
,opeitm_minqty  numeric (22,6)
,opeitm_operation  varchar (40) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_safestkqty  numeric (22,0)
,opeitm_packqty  numeric (18,2)
,person_email_chrg  varchar (50) 
,opeitm_shuffle_flg  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_chkinst_proc  varchar (1) 
,opeitm_esttosch  numeric (38,0)
,opeitm_stktaking_proc  varchar (1) 
,opeitm_rule_price  varchar (1) 
,opeitm_mold  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_packno_proc  varchar (1) 
,opeitm_processseq  numeric (38,0)
,opeitm_priority  numeric (38,0)
,opeitm_contents  varchar (4000) 
,opeitm_acceptance_proc  varchar (1) 
,opeitm_chkord_proc  varchar (3) 
,opeitm_maxqty  numeric (22,6)
,opeitm_prjalloc_flg  numeric (38,0)
,opeitm_prdpurshp  varchar (5) 
,itm_std  varchar (50) 
,supplier_custtype  varchar (1) 
,supplier_contents  varchar (4000) 
,supplier_contract_price  varchar (1) 
,supplier_rule_price  varchar (1) 
,supplier_amtround  varchar (2) 
,scrlv_level1_chrg  varchar (1) 
,supplier_personname  varchar (30) 
,pursch_remark  varchar (4000) 
,pursch_person_id_upd  numeric (38,0)
,pursch_crr_id  numeric (22,0)
,pursch_created_at   timestamp(6) 
,pursch_update_ip  varchar (40) 
,pursch_updated_at   timestamp(6) 
,id  numeric (38,0)
,pursch_id  numeric (38,0)
,pursch_crr_id_pur  numeric (22,0)
,pursch_prjno_id  numeric (38,0)
,pursch_shelfno_id_to  numeric (38,0)
,pursch_opeitm_id  numeric (38,0)
,pursch_supplier_id  numeric (22,0)
,pursch_chrg_id  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
,person_sect_id_chrg_payment  numeric (22,0)
,payment_chrg_id_payment  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_payment_id  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_shelfno_id  numeric (38,0)
,opeitm_boxe_id  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
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
  drop view if  exists r_shpschs cascade ; 
 create or replace view r_shpschs as select  
shpsch.id id,
shpsch.id  shpsch_id,
shpsch.transports_id   shpsch_transport_id,
shpsch.chrgs_id   shpsch_chrg_id,
shpsch.prjnos_id   shpsch_prjno_id,
shpsch.expiredate  shpsch_expiredate,
shpsch.persons_id_upd   shpsch_person_id_upd,
shpsch.remark  shpsch_remark,
shpsch.update_ip  shpsch_update_ip,
shpsch.created_at  shpsch_created_at,
shpsch.updated_at  shpsch_updated_at,
shpsch.amt  shpsch_amt,
shpsch.tax  shpsch_tax,
shpsch.price  shpsch_price,
shpsch.locas_id_to   shpsch_loca_id_to,
shpsch.sno  shpsch_sno,
shpsch.qty_sch  shpsch_qty_sch,
shpsch.isudate  shpsch_isudate,
shpsch.gno  shpsch_gno,
shpsch.crrs_id   shpsch_crr_id,
shpsch.depdate  shpsch_depdate,
shpsch.lotno  shpsch_lotno,
shpsch.packno  shpsch_packno,
shpsch.qty_stk  shpsch_qty_stk,
shpsch.itms_id   shpsch_itm_id,
shpsch.paretblname  shpsch_paretblname,
shpsch.paretblid  shpsch_paretblid,
shpsch.shelfnos_id_fm   shpsch_shelfno_id_fm,
shpsch.contract_price  shpsch_contract_price,
shpsch.processseq  shpsch_processseq,
shpsch.manual  shpsch_manual,
  transport.transport_code  transport_code ,
  transport.transport_name  transport_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code  prjno_code ,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to ,
  crr.crr_name  crr_name ,
  crr.crr_code  crr_code ,
  itm.itm_classlist_id  itm_classlist_id ,
  itm.itm_unit_id  itm_unit_id ,
  itm.classlist_name  classlist_name ,
  itm.classlist_code  classlist_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm 
 from shpschs   shpsch,
  r_transports  transport ,  r_chrgs  chrg ,  r_prjnos  prjno ,  r_persons  person_upd ,  r_locas  loca_to ,  r_crrs  crr ,  r_itms  itm ,  r_shelfnos  shelfno_fm 
  where       shpsch.transports_id = transport.id      and shpsch.chrgs_id = chrg.id      and shpsch.prjnos_id = prjno.id      and shpsch.persons_id_upd = person_upd.id      and shpsch.locas_id_to = loca_to.id      and shpsch.crrs_id = crr.id      and shpsch.itms_id = itm.id      and shpsch.shelfnos_id_fm = shelfno_fm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shpschs;
 CREATE TABLE sio.sio_r_shpschs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shpschs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,shpsch_gno  varchar (40) 
,shpsch_sno  varchar (40) 
,prjno_code_chil  varchar (50) 
,prjno_name  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,itm_name  varchar (100) 
,itm_code  varchar (50) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,classlist_code  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,prjno_code  varchar (50) 
,crr_code  varchar (50) 
,crr_name  varchar (100) 
,loca_name_to  varchar (100) 
,transport_code  varchar (50) 
,transport_name  varchar (100) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_to  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,shelfno_code_fm  varchar (50) 
,person_name_chrg  varchar (100) 
,shelfno_name_fm  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,person_code_chrg  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,classlist_name  varchar (100) 
,shpsch_tax  numeric (38,4)
,shpsch_price  numeric (38,4)
,shpsch_manual  varchar (1) 
,shpsch_amt  numeric (18,4)
,shpsch_qty_sch  numeric (22,6)
,shpsch_isudate   timestamp(6) 
,shpsch_expiredate   date 
,shpsch_contract_price  varchar (1) 
,shpsch_depdate   timestamp(6) 
,shpsch_lotno  varchar (50) 
,shpsch_packno  varchar (10) 
,shpsch_qty_stk  numeric (22,6)
,shpsch_processseq  numeric (38,0)
,shpsch_paretblname  varchar (30) 
,shpsch_paretblid  numeric (38,0)
,itm_datascale  numeric (22,0)
,transport_contents  varchar (4000) 
,scrlv_level1_chrg  varchar (1) 
,person_email_chrg  varchar (50) 
,loca_prfct_to  varchar (20) 
,loca_tel_to  varchar (20) 
,loca_mail_to  varchar (20) 
,loca_addr1_to  varchar (50) 
,loca_zip_to  varchar (10) 
,loca_fax_to  varchar (20) 
,loca_addr2_to  varchar (50) 
,crr_contents  varchar (4000) 
,crr_amtdecimal  numeric (22,0)
,crr_pricedecimal  numeric (22,0)
,itm_weight  numeric (22,0)
,unit_contents  varchar (4000) 
,itm_length  numeric (22,0)
,itm_design  varchar (50) 
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,itm_material  varchar (50) 
,itm_model  varchar (50) 
,shelfno_contents_fm  varchar (4000) 
,loca_country_to  varchar (20) 
,loca_abbr_to  varchar (50) 
,shpsch_remark  varchar (4000) 
,shpsch_created_at   timestamp(6) 
,shpsch_crr_id  numeric (22,0)
,shpsch_update_ip  varchar (40) 
,shpsch_loca_id_to  numeric (38,0)
,shpsch_prjno_id  numeric (38,0)
,shpsch_chrg_id  numeric (38,0)
,shpsch_person_id_upd  numeric (38,0)
,shpsch_id  numeric (38,0)
,shpsch_transport_id  numeric (38,0)
,shpsch_shelfno_id_fm  numeric (22,0)
,shpsch_updated_at   timestamp(6) 
,id  numeric (38,0)
,shpsch_itm_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,itm_unit_id  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
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
 CREATE INDEX sio_r_shpschs_uk1 
  ON sio.sio_r_shpschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpschs_seq ;
 create sequence sio.sio_r_shpschs_seq ;
 ALTER TABLE purschs ADD CONSTRAINT pursch_crrs_id FOREIGN KEY (crrs_id)
																		 REFERENCES crrs (id);
