
  drop view if  exists r_billinsts cascade ; 
 create or replace view r_billinsts as select  
billinst.id id,
billinst.id  billinst_id,
billinst.itms_id   billinst_itm_id,
billinst.expiredate  billinst_expiredate,
billinst.update_ip  billinst_update_ip,
billinst.created_at  billinst_created_at,
billinst.updated_at  billinst_updated_at,
billinst.persons_id_upd   billinst_person_id_upd,
billinst.qty  billinst_qty,
billinst.price  billinst_price,
billinst.amt  billinst_amt,
billinst.sno  billinst_sno,
billinst.duedate  billinst_duedate,
billinst.isudate  billinst_isudate,
billinst.tblname  billinst_tblname,
billinst.tblid  billinst_tblid,
billinst.tax  billinst_tax,
billinst.saledate  billinst_saledate,
billinst.orgtblname  billinst_orgtblname,
billinst.orgtblid  billinst_orgtblid,
billinst.contents  billinst_contents,
billinst.remark  billinst_remark,
billinst.gno  billinst_gno,
billinst.bills_id   billinst_bill_id,
  itm.itm_classlist_id  itm_classlist_id ,
  itm.itm_unit_id  itm_unit_id ,
  itm.classlist_name  classlist_name ,
  itm.classlist_code  classlist_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name ,
  bill.loca_name_bill  loca_name_bill ,
  bill.loca_code_bill  loca_code_bill ,
  bill.bill_chrg_id_bill  bill_chrg_id_bill ,
  bill.bill_crr_id_bill  bill_crr_id_bill ,
  bill.bill_loca_id_bill  bill_loca_id_bill ,
  bill.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  bill.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  bill.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  bill.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  bill.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  bill.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  bill.person_name_chrg_bill  person_name_chrg_bill ,
  bill.person_code_chrg_bill  person_code_chrg_bill ,
  bill.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  bill.crr_name_bill  crr_name_bill ,
  bill.crr_code_bill  crr_code_bill 
 from billinsts   billinst,
  r_itms  itm ,  r_persons  person_upd ,  r_bills  bill 
  where       billinst.itms_id = itm.id      and billinst.persons_id_upd = person_upd.id      and billinst.bills_id = bill.id     ;
 DROP TABLE IF EXISTS sio.sio_r_billinsts;
 CREATE TABLE sio.sio_r_billinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_billinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,billinst_gno  varchar (40) 
,billinst_sno  varchar (40) 
,person_name_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,classlist_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,itm_code  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,person_code_chrg_bill  varchar (50) 
,usrgrp_name_chrg_bill  varchar (100) 
,loca_name_sect_chrg_bill  varchar (100) 
,loca_code_sect_chrg_bill  varchar (50) 
,crr_code_bill  varchar (50) 
,loca_code_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,loca_name_bill  varchar (100) 
,classlist_name  varchar (100) 
,itm_name  varchar (100) 
,billinst_orgtblid  numeric (38,0)
,billinst_qty  numeric (22,6)
,billinst_expiredate   date 
,billinst_amt  numeric (18,4)
,billinst_price  numeric (38,4)
,billinst_duedate   timestamp(6) 
,billinst_isudate   timestamp(6) 
,billinst_tblname  varchar (30) 
,billinst_tblid  numeric (38,0)
,billinst_tax  numeric (38,4)
,billinst_saledate   timestamp(6) 
,billinst_orgtblname  varchar (30) 
,itm_design  varchar (50) 
,itm_weight  numeric (22,0)
,unit_contents  varchar (4000) 
,itm_length  numeric (22,0)
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,itm_material  varchar (50) 
,itm_model  varchar (50) 
,itm_datascale  numeric (22,0)
,loca_tel_bill  varchar (20) 
,bill_personname  varchar (30) 
,loca_abbr_bill  varchar (50) 
,bill_contents  varchar (4000) 
,billinst_contents  varchar (4000) 
,billinst_remark  varchar (4000) 
,billinst_update_ip  varchar (40) 
,billinst_id  numeric (38,0)
,billinst_bill_id  numeric (38,0)
,billinst_person_id_upd  numeric (38,0)
,billinst_updated_at   timestamp(6) 
,id  numeric (38,0)
,billinst_created_at   timestamp(6) 
,billinst_itm_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,bill_loca_id_bill  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,itm_unit_id  numeric (22,0)
,bill_chrg_id_bill  numeric (22,0)
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
 CREATE INDEX sio_r_billinsts_uk1 
  ON sio.sio_r_billinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_billinsts_seq ;
 create sequence sio.sio_r_billinsts_seq ;
  drop view if  exists r_dlvinsts cascade ; 
 create or replace view r_dlvinsts as select  
dlvinst.id id,
dlvinst.id  dlvinst_id,
dlvinst.itms_id   dlvinst_itm_id,
dlvinst.asstwhs_id   dlvinst_asstwh_id,
dlvinst.custrcvplcs_id   dlvinst_custrcvplc_id,
dlvinst.expiredate  dlvinst_expiredate,
dlvinst.update_ip  dlvinst_update_ip,
dlvinst.created_at  dlvinst_created_at,
dlvinst.updated_at  dlvinst_updated_at,
dlvinst.persons_id_upd   dlvinst_person_id_upd,
dlvinst.qty  dlvinst_qty,
dlvinst.cno  dlvinst_cno,
dlvinst.gno  dlvinst_gno,
dlvinst.sno  dlvinst_sno,
dlvinst.isudate  dlvinst_isudate,
dlvinst.depdate  dlvinst_depdate,
dlvinst.qty_case  dlvinst_qty_case,
dlvinst.orgtblname  dlvinst_orgtblname,
dlvinst.orgtblid  dlvinst_orgtblid,
dlvinst.transports_id   dlvinst_transport_id,
dlvinst.locas_id_to   dlvinst_loca_id_to,
dlvinst.prjnos_id   dlvinst_prjno_id,
dlvinst.contents  dlvinst_contents,
dlvinst.remark  dlvinst_remark,
dlvinst.duedate  dlvinst_duedate,
dlvinst.toduedate  dlvinst_toduedate,
  itm.itm_classlist_id  itm_classlist_id ,
  itm.itm_unit_id  itm_unit_id ,
  itm.classlist_name  classlist_name ,
  itm.classlist_code  classlist_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name ,
  custrcvplc.custrcvplc_loca_id_custrcvplc  custrcvplc_loca_id_custrcvplc ,
  custrcvplc.loca_code_custrcvplc  loca_code_custrcvplc ,
  custrcvplc.loca_name_custrcvplc  loca_name_custrcvplc ,
  transport.transport_code  transport_code ,
  transport.transport_name  transport_name ,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to ,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code  prjno_code 
 from dlvinsts   dlvinst,
  r_itms  itm ,  r_asstwhs  asstwh ,  r_custrcvplcs  custrcvplc ,  r_persons  person_upd ,  r_transports  transport ,  r_locas  loca_to ,  r_prjnos  prjno 
  where       dlvinst.itms_id = itm.id      and dlvinst.asstwhs_id = asstwh.id      and dlvinst.custrcvplcs_id = custrcvplc.id      and dlvinst.persons_id_upd = person_upd.id      and dlvinst.transports_id = transport.id      and dlvinst.locas_id_to = loca_to.id      and dlvinst.prjnos_id = prjno.id     ;
 DROP TABLE IF EXISTS sio.sio_r_dlvinsts;
 CREATE TABLE sio.sio_r_dlvinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_dlvinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,dlvinst_gno  varchar (40) 
,dlvinst_sno  varchar (40) 
,dlvinst_cno  varchar (40) 
,itm_code  varchar (50) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,classlist_code  varchar (50) 
,transport_code  varchar (50) 
,classlist_name  varchar (100) 
,loca_name_custrcvplc  varchar (100) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,loca_name_to  varchar (100) 
,prjno_code  varchar (50) 
,transport_name  varchar (100) 
,loca_code_to  varchar (50) 
,loca_code_custrcvplc  varchar (50) 
,itm_name  varchar (100) 
,dlvinst_duedate   timestamp(6) 
,dlvinst_expiredate   date 
,dlvinst_qty  numeric (22,6)
,dlvinst_isudate   timestamp(6) 
,dlvinst_depdate   timestamp(6) 
,dlvinst_qty_case  numeric (22,0)
,dlvinst_orgtblname  varchar (30) 
,dlvinst_orgtblid  numeric (38,0)
,dlvinst_toduedate   timestamp(6) 
,itm_deth  numeric (22,0)
,itm_material  varchar (50) 
,loca_country_to  varchar (20) 
,loca_abbr_to  varchar (50) 
,loca_prfct_to  varchar (20) 
,loca_tel_to  varchar (20) 
,loca_mail_to  varchar (20) 
,loca_addr1_to  varchar (50) 
,loca_zip_to  varchar (10) 
,itm_model  varchar (50) 
,unit_contents  varchar (4000) 
,itm_datascale  numeric (22,0)
,itm_wide  numeric (22,0)
,transport_contents  varchar (4000) 
,itm_length  numeric (22,0)
,loca_addr2_to  varchar (50) 
,loca_fax_to  varchar (20) 
,custrcvplc_stktaking_proc  varchar (1) 
,custrcvplc_contents  varchar (4000) 
,itm_weight  numeric (22,0)
,itm_design  varchar (50) 
,dlvinst_remark  varchar (4000) 
,dlvinst_contents  varchar (4000) 
,dlvinst_id  numeric (38,0)
,id  numeric (38,0)
,dlvinst_prjno_id  numeric (38,0)
,dlvinst_loca_id_to  numeric (38,0)
,dlvinst_transport_id  numeric (38,0)
,dlvinst_person_id_upd  numeric (38,0)
,dlvinst_updated_at   timestamp(6) 
,dlvinst_created_at   timestamp(6) 
,dlvinst_update_ip  varchar (40) 
,dlvinst_custrcvplc_id  numeric (38,0)
,dlvinst_asstwh_id  numeric (38,0)
,dlvinst_itm_id  numeric (38,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
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
 CREATE INDEX sio_r_dlvinsts_uk1 
  ON sio.sio_r_dlvinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_dlvinsts_seq ;
 create sequence sio.sio_r_dlvinsts_seq ;
  drop view if  exists r_payinsts cascade ; 
 create or replace view r_payinsts as select  
payinst.price  payinst_price,
payinst.remark  payinst_remark,
payinst.created_at  payinst_created_at,
payinst.update_ip  payinst_update_ip,
payinst.duedate  payinst_duedate,
payinst.amt  payinst_amt,
payinst.isudate  payinst_isudate,
payinst.expiredate  payinst_expiredate,
payinst.updated_at  payinst_updated_at,
payinst.id id,
payinst.id  payinst_id,
payinst.persons_id_upd   payinst_person_id_upd,
payinst.contents  payinst_contents,
payinst.tax  payinst_tax,
payinst.contract_price  payinst_contract_price,
payinst.gno  payinst_gno,
payinst.gno_payord  payinst_gno_payord,
payinst.chrgs_id   payinst_chrg_id,
payinst.itm_code_client  payinst_itm_code_client,
payinst.suppliers_id   payinst_supplier_id,
payinst.crrs_id_pur   payinst_crr_id_pur,
payinst.payments_id_pay   payinst_payment_id_pay,
payinst.sno  payinst_sno,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
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
  crr_pur.crr_name  crr_name_pur ,
  crr_pur.crr_code  crr_code_pur ,
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
  payment_pay.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment_pay 
 from payinsts   payinst,
  r_persons  person_upd ,  r_chrgs  chrg ,  r_suppliers  supplier ,  r_crrs  crr_pur ,  r_payments  payment_pay 
  where       payinst.persons_id_upd = person_upd.id      and payinst.chrgs_id = chrg.id      and payinst.suppliers_id = supplier.id      and payinst.crrs_id_pur = crr_pur.id      and payinst.payments_id_pay = payment_pay.id     ;
 DROP TABLE IF EXISTS sio.sio_r_payinsts;
 CREATE TABLE sio.sio_r_payinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_payinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,payinst_gno  varchar (40) 
,payinst_sno  varchar (40) 
,scrlv_code_chrg_payment_pay  varchar (50) 
,loca_code_payment_pay  varchar (50) 
,person_name_chrg_payment_pay  varchar (100) 
,usrgrp_name_chrg_payment_pay  varchar (100) 
,person_code_chrg_payment_pay  varchar (50) 
,loca_name_sect_chrg_payment_pay  varchar (100) 
,loca_name_payment_pay  varchar (100) 
,loca_name_sect_chrg_payment  varchar (100) 
,usrgrp_name_chrg_payment  varchar (100) 
,person_name_chrg_payment  varchar (100) 
,loca_code_sect_chrg_payment  varchar (50) 
,loca_name_payment  varchar (100) 
,crr_code_supplier  varchar (50) 
,usrgrp_code_chrg_payment  varchar (50) 
,crr_name_supplier  varchar (100) 
,usrgrp_code_chrg_supplier  varchar (50) 
,person_code_chrg_payment  varchar (50) 
,scrlv_code_chrg_payment  varchar (50) 
,crr_name_pur  varchar (100) 
,loca_code_payment  varchar (50) 
,loca_name_sect_chrg_supplier  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,person_name_chrg_supplier  varchar (100) 
,person_name_chrg  varchar (100) 
,usrgrp_name_chrg_supplier  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,person_code_chrg  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,person_code_chrg_supplier  varchar (50) 
,scrlv_code_chrg_supplier  varchar (50) 
,loca_code_supplier  varchar (50) 
,loca_name_supplier  varchar (100) 
,loca_code_sect_chrg_supplier  varchar (50) 
,loca_code_sect_chrg_payment_pay  varchar (50) 
,crr_code_pur  varchar (50) 
,usrgrp_code_chrg_payment_pay  varchar (50) 
,payinst_gno_payord  varchar (50) 
,payinst_amt  numeric (18,4)
,payinst_isudate   timestamp(6) 
,payinst_tax  numeric (38,4)
,payinst_contract_price  varchar (1) 
,payinst_expiredate   date 
,payinst_itm_code_client  varchar (50) 
,payinst_duedate   timestamp(6) 
,payinst_price  numeric (38,4)
,crr_contents_pur  varchar (4000) 
,supplier_amtround  varchar (2) 
,supplier_rule_price  varchar (1) 
,supplier_contract_price  varchar (1) 
,supplier_contents  varchar (4000) 
,supplier_amtdecimal  numeric (38,0)
,payment_contents_pay  varchar (4000) 
,person_email_chrg  varchar (50) 
,scrlv_level1_chrg  varchar (1) 
,payment_personname_pay  varchar (30) 
,crr_amtdecimal_pur  numeric (22,0)
,supplier_personname  varchar (30) 
,supplier_custtype  varchar (1) 
,crr_pricedecimal_pur  numeric (22,0)
,payinst_remark  varchar (4000) 
,payinst_contents  varchar (4000) 
,payinst_payment_id_pay  numeric (22,0)
,payinst_created_at   timestamp(6) 
,payinst_update_ip  varchar (40) 
,payinst_updated_at   timestamp(6) 
,id  numeric (38,0)
,payinst_id  numeric (38,0)
,payinst_person_id_upd  numeric (38,0)
,payinst_chrg_id  numeric (38,0)
,payinst_supplier_id  numeric (22,0)
,payinst_crr_id_pur  numeric (22,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,person_sect_id_chrg_payment_pay  numeric (22,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
,person_sect_id_chrg_payment  numeric (22,0)
,payment_chrg_id_payment  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_payment_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,payment_chrg_id_payment_pay  numeric (22,0)
,payment_loca_id_payment_pay  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,chrg_person_id_chrg_payment_pay  numeric (38,0)
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
 CREATE INDEX sio_r_payinsts_uk1 
  ON sio.sio_r_payinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_payinsts_seq ;
 create sequence sio.sio_r_payinsts_seq ;
  drop view if  exists r_prdinsts cascade ; 
 create or replace view r_prdinsts as select  
prdinst.chrgs_id   prdinst_chrg_id,
prdinst.opeitms_id   prdinst_opeitm_id,
prdinst.prjnos_id   prdinst_prjno_id,
prdinst.starttime  prdinst_starttime,
prdinst.shelfnos_id_to   prdinst_shelfno_id_to,
prdinst.commencementdate  prdinst_commencementdate,
prdinst.id id,
prdinst.id  prdinst_id,
prdinst.contents  prdinst_contents,
prdinst.persons_id_upd   prdinst_person_id_upd,
prdinst.cno_prdord  prdinst_cno_prdord,
prdinst.sno_prdord  prdinst_sno_prdord,
prdinst.workplaces_id   prdinst_workplace_id,
prdinst.isudate  prdinst_isudate,
prdinst.expiredate  prdinst_expiredate,
prdinst.updated_at  prdinst_updated_at,
prdinst.qty  prdinst_qty,
prdinst.sno  prdinst_sno,
prdinst.locas_id_to   prdinst_loca_id_to,
prdinst.remark  prdinst_remark,
prdinst.created_at  prdinst_created_at,
prdinst.update_ip  prdinst_update_ip,
prdinst.duedate  prdinst_duedate,
prdinst.qty_case  prdinst_qty_case,
prdinst.commencement_f  prdinst_commencement_f,
prdinst.cno  prdinst_cno,
prdinst.gno  prdinst_gno,
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
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code  prjno_code ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
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
  workplace.loca_name_workplace  loca_name_workplace ,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to 
 from prdinsts   prdinst,
  r_chrgs  chrg ,  r_opeitms  opeitm ,  r_prjnos  prjno ,  r_shelfnos  shelfno_to ,  r_persons  person_upd ,  r_workplaces  workplace ,  r_locas  loca_to 
  where       prdinst.chrgs_id = chrg.id      and prdinst.opeitms_id = opeitm.id      and prdinst.prjnos_id = prjno.id      and prdinst.shelfnos_id_to = shelfno_to.id      and prdinst.persons_id_upd = person_upd.id      and prdinst.workplaces_id = workplace.id      and prdinst.locas_id_to = loca_to.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdinsts;
 CREATE TABLE sio.sio_r_prdinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prdinst_cno  varchar (40) 
,prdinst_gno  varchar (40) 
,prdinst_sno  varchar (40) 
,prjno_name  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,person_code_chrg  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,prjno_code_chil  varchar (50) 
,loca_name_to  varchar (100) 
,loca_name_workplace  varchar (100) 
,person_code_chrg_workplace  varchar (50) 
,scrlv_code_chrg_workplace  varchar (50) 
,loca_code_to  varchar (50) 
,loca_code_sect_chrg_workplace  varchar (50) 
,loca_name_sect_chrg_workplace  varchar (100) 
,loca_code_workplace  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,person_name_chrg_workplace  varchar (100) 
,usrgrp_name_chrg_workplace  varchar (100) 
,usrgrp_code_chrg_workplace  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,prjno_code  varchar (50) 
,person_name_chrg  varchar (100) 
,prdinst_isudate   timestamp(6) 
,prdinst_starttime   timestamp(6) 
,prdinst_commencementdate   timestamp(6) 
,prdinst_cno_prdord  varchar (50) 
,prdinst_sno_prdord  varchar (50) 
,prdinst_expiredate   date 
,prdinst_qty  numeric (22,6)
,prdinst_duedate   timestamp(6) 
,prdinst_qty_case  numeric (22,0)
,prdinst_commencement_f  varchar (1) 
,opeitm_shuffle_flg  varchar (1) 
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
,person_email_chrg  varchar (50) 
,scrlv_level1_chrg  varchar (1) 
,shelfno_contents_to  varchar (4000) 
,workplace_contents  varchar (4000) 
,loca_country_to  varchar (20) 
,loca_abbr_to  varchar (50) 
,loca_prfct_to  varchar (20) 
,loca_tel_to  varchar (20) 
,loca_mail_to  varchar (20) 
,loca_addr1_to  varchar (50) 
,loca_zip_to  varchar (10) 
,loca_fax_to  varchar (20) 
,loca_addr2_to  varchar (50) 
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
,opeitm_autocreate_act  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_chkinst_proc  varchar (1) 
,opeitm_esttosch  numeric (38,0)
,prdinst_contents  varchar (4000) 
,prdinst_remark  varchar (4000) 
,prdinst_person_id_upd  numeric (38,0)
,prdinst_updated_at   timestamp(6) 
,prdinst_chrg_id  numeric (38,0)
,prdinst_update_ip  varchar (40) 
,prdinst_prjno_id  numeric (38,0)
,prdinst_created_at   timestamp(6) 
,prdinst_loca_id_to  numeric (38,0)
,prdinst_opeitm_id  numeric (38,0)
,prdinst_id  numeric (38,0)
,id  numeric (38,0)
,prdinst_workplace_id  numeric (22,0)
,prdinst_shelfno_id_to  numeric (38,0)
,workplace_loca_id_workplace  numeric (22,0)
,workplace_chrg_id_workplace  numeric (22,0)
,person_sect_id_chrg_workplace  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,chrg_person_id_chrg_workplace  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_boxe_id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,opeitm_shelfno_id  numeric (38,0)
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
 CREATE INDEX sio_r_prdinsts_uk1 
  ON sio.sio_r_prdinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdinsts_seq ;
 create sequence sio.sio_r_prdinsts_seq ;
  drop view if  exists r_purinsts cascade ; 
 create or replace view r_purinsts as select  
purinst.sno_purord  purinst_sno_purord,
purinst.prjnos_id   purinst_prjno_id,
purinst.chrgs_id   purinst_chrg_id,
purinst.itm_code_client  purinst_itm_code_client,
purinst.starttime  purinst_starttime,
purinst.autoact_p  purinst_autoact_p,
purinst.autocreate_act  purinst_autocreate_act,
purinst.crrs_id   purinst_crr_id,
purinst.shelfnos_id_to   purinst_shelfno_id_to,
purinst.suppliers_id   purinst_supplier_id,
purinst.id id,
purinst.id  purinst_id,
purinst.qty_case  purinst_qty_case,
purinst.persons_id_upd   purinst_person_id_upd,
purinst.contract_price  purinst_contract_price,
purinst.cno  purinst_cno,
purinst.gno  purinst_gno,
purinst.tax  purinst_tax,
purinst.isudate  purinst_isudate,
purinst.expiredate  purinst_expiredate,
purinst.updated_at  purinst_updated_at,
purinst.opeitms_id   purinst_opeitm_id,
purinst.qty  purinst_qty,
purinst.sno  purinst_sno,
purinst.remark  purinst_remark,
purinst.created_at  purinst_created_at,
purinst.update_ip  purinst_update_ip,
purinst.price  purinst_price,
purinst.amt  purinst_amt,
purinst.duedate  purinst_duedate,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code  prjno_code ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  crr.crr_name  crr_name ,
  crr.crr_code  crr_code ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
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
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp 
 from purinsts   purinst,
  r_prjnos  prjno ,  r_chrgs  chrg ,  r_crrs  crr ,  r_shelfnos  shelfno_to ,  r_suppliers  supplier ,  r_persons  person_upd ,  r_opeitms  opeitm 
  where       purinst.prjnos_id = prjno.id      and purinst.chrgs_id = chrg.id      and purinst.crrs_id = crr.id      and purinst.shelfnos_id_to = shelfno_to.id      and purinst.suppliers_id = supplier.id      and purinst.persons_id_upd = person_upd.id      and purinst.opeitms_id = opeitm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purinsts;
 CREATE TABLE sio.sio_r_purinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,purinst_cno  varchar (40) 
,purinst_sno  varchar (40) 
,purinst_gno  varchar (40) 
,prjno_code  varchar (50) 
,prjno_code_chil  varchar (50) 
,prjno_name  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,person_code_chrg  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,crr_name  varchar (100) 
,crr_code  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,shelfno_name_to  varchar (100) 
,shelfno_code_to  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,scrlv_code_chrg_supplier  varchar (50) 
,loca_code_supplier  varchar (50) 
,loca_name_supplier  varchar (100) 
,loca_code_sect_chrg_supplier  varchar (50) 
,person_code_chrg_supplier  varchar (50) 
,usrgrp_name_chrg_supplier  varchar (100) 
,person_name_chrg_supplier  varchar (100) 
,loca_name_sect_chrg_supplier  varchar (100) 
,scrlv_code_chrg_payment  varchar (50) 
,usrgrp_code_chrg_supplier  varchar (50) 
,loca_code_sect_chrg_payment  varchar (50) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_code_payment  varchar (50) 
,person_code_chrg_payment  varchar (50) 
,usrgrp_code_chrg_payment  varchar (50) 
,usrgrp_name_chrg_payment  varchar (100) 
,person_name_chrg_payment  varchar (100) 
,loca_name_payment  varchar (100) 
,crr_code_supplier  varchar (50) 
,crr_name_supplier  varchar (100) 
,purinst_sno_purord  varchar (50) 
,purinst_price  numeric (38,4)
,purinst_duedate   timestamp(6) 
,purinst_amt  numeric (18,4)
,purinst_expiredate   date 
,purinst_qty  numeric (22,6)
,purinst_isudate   timestamp(6) 
,purinst_tax  numeric (38,4)
,purinst_itm_code_client  varchar (50) 
,purinst_contract_price  varchar (1) 
,purinst_qty_case  numeric (22,0)
,purinst_autocreate_act  varchar (1) 
,purinst_autoact_p  numeric (3,0)
,purinst_starttime   timestamp(6) 
,supplier_amtdecimal  numeric (38,0)
,supplier_custtype  varchar (1) 
,supplier_contents  varchar (4000) 
,supplier_contract_price  varchar (1) 
,supplier_rule_price  varchar (1) 
,supplier_amtround  varchar (2) 
,supplier_personname  varchar (30) 
,opeitm_autoord_p  numeric (3,0)
,opeitm_units_lttime  varchar (4) 
,crr_contents  varchar (4000) 
,opeitm_minqty  numeric (22,6)
,crr_amtdecimal  numeric (22,0)
,crr_pricedecimal  numeric (22,0)
,opeitm_operation  varchar (40) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_safestkqty  numeric (22,0)
,shelfno_contents_to  varchar (4000) 
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
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autoinst_p  numeric (3,0)
,opeitm_lotno_proc  varchar (3) 
,scrlv_level1_chrg  varchar (1) 
,opeitm_autoact_p  numeric (3,0)
,person_email_chrg  varchar (50) 
,opeitm_duration  numeric (38,2)
,purinst_remark  varchar (4000) 
,purinst_update_ip  varchar (40) 
,purinst_id  numeric (38,0)
,purinst_chrg_id  numeric (38,0)
,purinst_shelfno_id_to  numeric (38,0)
,purinst_person_id_upd  numeric (38,0)
,purinst_supplier_id  numeric (22,0)
,purinst_updated_at   timestamp(6) 
,purinst_opeitm_id  numeric (38,0)
,id  numeric (38,0)
,purinst_prjno_id  numeric (38,0)
,purinst_created_at   timestamp(6) 
,purinst_crr_id  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_boxe_id  numeric (38,0)
,opeitm_shelfno_id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
,person_sect_id_chrg_payment  numeric (22,0)
,payment_chrg_id_payment  numeric (22,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,supplier_crr_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_payment_id  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
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
 CREATE INDEX sio_r_purinsts_uk1 
  ON sio.sio_r_purinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purinsts_seq ;
 create sequence sio.sio_r_purinsts_seq ;
  drop view if  exists r_shpinsts cascade ; 
 create or replace view r_shpinsts as select  
  itm.classlist_code  classlist_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
shpinst.prjnos_id   shpinst_prjno_id,
shpinst.transports_id   shpinst_transport_id,
shpinst.paretblid  shpinst_paretblid,
shpinst.paretblname  shpinst_paretblname,
shpinst.itms_id   shpinst_itm_id,
shpinst.qty_shortage  shpinst_qty_shortage,
shpinst.qty_stk  shpinst_qty_stk,
shpinst.shelfnos_id_fm   shpinst_shelfno_id_fm,
shpinst.id id,
shpinst.id  shpinst_id,
shpinst.starttime  shpinst_starttime,
shpinst.locas_id_to   shpinst_loca_id_to,
shpinst.sno  shpinst_sno,
shpinst.remark  shpinst_remark,
shpinst.expiredate  shpinst_expiredate,
shpinst.update_ip  shpinst_update_ip,
shpinst.created_at  shpinst_created_at,
shpinst.updated_at  shpinst_updated_at,
shpinst.persons_id_upd   shpinst_person_id_upd,
shpinst.amt  shpinst_amt,
shpinst.qty  shpinst_qty,
shpinst.tax  shpinst_tax,
shpinst.price  shpinst_price,
shpinst.chrgs_id   shpinst_chrg_id,
shpinst.processseq  shpinst_processseq,
shpinst.contents  shpinst_contents,
shpinst.contract_price  shpinst_contract_price,
shpinst.gno  shpinst_gno,
shpinst.isudate  shpinst_isudate,
shpinst.box  shpinst_box,
shpinst.duedate  shpinst_duedate,
shpinst.cno  shpinst_cno,
shpinst.qty_case  shpinst_qty_case,
shpinst.cartonno  shpinst_cartonno,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code  prjno_code ,
  transport.transport_code  transport_code ,
  transport.transport_name  transport_name ,
  itm.itm_classlist_id  itm_classlist_id ,
  itm.itm_unit_id  itm_unit_id ,
  itm.classlist_name  classlist_name 
 from shpinsts   shpinst,
  r_prjnos  prjno ,  r_transports  transport ,  r_itms  itm ,  r_shelfnos  shelfno_fm ,  r_locas  loca_to ,  r_persons  person_upd ,  r_chrgs  chrg 
  where       shpinst.prjnos_id = prjno.id      and shpinst.transports_id = transport.id      and shpinst.itms_id = itm.id      and shpinst.shelfnos_id_fm = shelfno_fm.id      and shpinst.locas_id_to = loca_to.id      and shpinst.persons_id_upd = person_upd.id      and shpinst.chrgs_id = chrg.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shpinsts;
 CREATE TABLE sio.sio_r_shpinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shpinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,shpinst_gno  varchar (40) 
,shpinst_cno  varchar (40) 
,shpinst_sno  varchar (40) 
,loca_code_sect_chrg  varchar (50) 
,person_code_chrg  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,transport_code  varchar (50) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,shelfno_name_fm  varchar (100) 
,classlist_name  varchar (100) 
,classlist_code  varchar (50) 
,shelfno_code_fm  varchar (50) 
,loca_name_to  varchar (100) 
,transport_name  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_to  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,shpinst_qty_case  numeric (22,0)
,shpinst_starttime   timestamp(6) 
,shpinst_duedate   timestamp(6) 
,shpinst_box  varchar (50) 
,shpinst_expiredate   date 
,shpinst_isudate   timestamp(6) 
,shpinst_contract_price  varchar (1) 
,shpinst_processseq  numeric (38,0)
,shpinst_amt  numeric (18,4)
,shpinst_qty  numeric (22,6)
,shpinst_tax  numeric (38,4)
,shpinst_price  numeric (38,4)
,shpinst_paretblid  numeric (38,0)
,shpinst_paretblname  varchar (30) 
,shpinst_qty_shortage  numeric (22,5)
,shpinst_qty_stk  numeric (22,6)
,shpinst_cartonno  varchar (20) 
,loca_zip_to  varchar (10) 
,itm_datascale  numeric (22,0)
,shelfno_contents_fm  varchar (4000) 
,loca_country_to  varchar (20) 
,loca_abbr_to  varchar (50) 
,loca_prfct_to  varchar (20) 
,loca_tel_to  varchar (20) 
,loca_mail_to  varchar (20) 
,loca_addr1_to  varchar (50) 
,itm_model  varchar (50) 
,loca_fax_to  varchar (20) 
,loca_addr2_to  varchar (50) 
,scrlv_level1_chrg  varchar (1) 
,person_email_chrg  varchar (50) 
,transport_contents  varchar (4000) 
,itm_weight  numeric (22,0)
,unit_contents  varchar (4000) 
,itm_length  numeric (22,0)
,itm_design  varchar (50) 
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,itm_material  varchar (50) 
,shpinst_remark  varchar (4000) 
,shpinst_contents  varchar (4000) 
,shpinst_shelfno_id_fm  numeric (22,0)
,shpinst_itm_id  numeric (38,0)
,shpinst_transport_id  numeric (38,0)
,shpinst_prjno_id  numeric (38,0)
,shpinst_id  numeric (38,0)
,id  numeric (38,0)
,shpinst_person_id_upd  numeric (38,0)
,shpinst_updated_at   timestamp(6) 
,shpinst_created_at   timestamp(6) 
,shpinst_update_ip  varchar (40) 
,shpinst_loca_id_to  numeric (38,0)
,shpinst_chrg_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
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
 CREATE INDEX sio_r_shpinsts_uk1 
  ON sio.sio_r_shpinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpinsts_seq ;
 create sequence sio.sio_r_shpinsts_seq ;
  drop view if  exists r_custinsts cascade ; 
 create or replace view r_custinsts as select  
custinst.custs_id   custinst_cust_id,
custinst.itms_id   custinst_itm_id,
custinst.itm_code_client  custinst_itm_code_client,
custinst.cno  custinst_cno,
custinst.custrcvplcs_id   custinst_custrcvplc_id,
custinst.id id,
custinst.id  custinst_id,
custinst.asstwhs_id   custinst_asstwh_id,
custinst.gno  custinst_gno,
custinst.contract_price  custinst_contract_price,
custinst.starttime  custinst_starttime,
custinst.chrgs_id_cpo   custinst_chrg_id_cpo,
custinst.expiredate  custinst_expiredate,
custinst.duedate  custinst_duedate,
custinst.isudate  custinst_isudate,
custinst.qty  custinst_qty,
custinst.price  custinst_price,
custinst.amt  custinst_amt,
custinst.sno  custinst_sno,
custinst.remark  custinst_remark,
custinst.persons_id_upd   custinst_person_id_upd,
custinst.update_ip  custinst_update_ip,
custinst.created_at  custinst_created_at,
custinst.updated_at  custinst_updated_at,
  cust.cust_bill_id  cust_bill_id ,
  cust.cust_loca_id_cust  cust_loca_id_cust ,
  cust.cust_chrg_id_cust  cust_chrg_id_cust ,
  cust.loca_name_bill  loca_name_bill ,
  cust.loca_code_bill  loca_code_bill ,
  cust.bill_chrg_id_bill  bill_chrg_id_bill ,
  cust.bill_crr_id_bill  bill_crr_id_bill ,
  cust.bill_loca_id_bill  bill_loca_id_bill ,
  cust.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  cust.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  cust.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  cust.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  cust.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  cust.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  cust.person_name_chrg_bill  person_name_chrg_bill ,
  cust.person_code_chrg_bill  person_code_chrg_bill ,
  cust.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  cust.crr_name_bill  crr_name_bill ,
  cust.crr_code_bill  crr_code_bill ,
  cust.loca_code_cust  loca_code_cust ,
  cust.loca_name_cust  loca_name_cust ,
  cust.person_sect_id_chrg_cust  person_sect_id_chrg_cust ,
  cust.scrlv_code_chrg_cust  scrlv_code_chrg_cust ,
  cust.person_name_chrg_cust  person_name_chrg_cust ,
  cust.loca_name_sect_chrg_cust  loca_name_sect_chrg_cust ,
  cust.loca_code_sect_chrg_cust  loca_code_sect_chrg_cust ,
  cust.person_code_chrg_cust  person_code_chrg_cust ,
  cust.usrgrp_code_chrg_cust  usrgrp_code_chrg_cust ,
  cust.usrgrp_name_chrg_cust  usrgrp_name_chrg_cust ,
  cust.chrg_person_id_chrg_cust  chrg_person_id_chrg_cust ,
  itm.itm_classlist_id  itm_classlist_id ,
  itm.itm_unit_id  itm_unit_id ,
  itm.classlist_name  classlist_name ,
  itm.classlist_code  classlist_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name ,
  custrcvplc.custrcvplc_loca_id_custrcvplc  custrcvplc_loca_id_custrcvplc ,
  custrcvplc.loca_code_custrcvplc  loca_code_custrcvplc ,
  custrcvplc.loca_name_custrcvplc  loca_name_custrcvplc ,
  chrg_cpo.person_sect_id_chrg  person_sect_id_chrg_cpo ,
  chrg_cpo.scrlv_code_chrg  scrlv_code_chrg_cpo ,
  chrg_cpo.person_name_chrg  person_name_chrg_cpo ,
  chrg_cpo.loca_name_sect_chrg  loca_name_sect_chrg_cpo ,
  chrg_cpo.loca_code_sect_chrg  loca_code_sect_chrg_cpo ,
  chrg_cpo.person_code_chrg  person_code_chrg_cpo ,
  chrg_cpo.usrgrp_code_chrg  usrgrp_code_chrg_cpo ,
  chrg_cpo.usrgrp_name_chrg  usrgrp_name_chrg_cpo ,
  chrg_cpo.chrg_person_id_chrg  chrg_person_id_chrg_cpo 
 from custinsts   custinst,
  r_custs  cust ,  r_itms  itm ,  r_custrcvplcs  custrcvplc ,  r_asstwhs  asstwh ,  r_chrgs  chrg_cpo ,  r_persons  person_upd 
  where       custinst.custs_id = cust.id      and custinst.itms_id = itm.id      and custinst.custrcvplcs_id = custrcvplc.id      and custinst.asstwhs_id = asstwh.id      and custinst.chrgs_id_cpo = chrg_cpo.id      and custinst.persons_id_upd = person_upd.id     ;
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
,custinst_cno  varchar (40) 
,custinst_gno  varchar (40) 
,custinst_sno  varchar (40) 
,crr_code_bill  varchar (50) 
,loca_code_cust  varchar (50) 
,loca_name_cust  varchar (100) 
,loca_name_sect_chrg_cust  varchar (100) 
,scrlv_code_chrg_cust  varchar (50) 
,person_name_chrg_cust  varchar (100) 
,person_name_chrg_cpo  varchar (100) 
,person_name_chrg_bill  varchar (100) 
,usrgrp_code_chrg_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,usrgrp_name_chrg_cust  varchar (100) 
,usrgrp_code_chrg_cust  varchar (50) 
,person_code_chrg_cust  varchar (50) 
,loca_code_sect_chrg_cust  varchar (50) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,usrgrp_name_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,person_code_chrg_bill  varchar (50) 
,scrlv_code_chrg_cpo  varchar (50) 
,loca_name_custrcvplc  varchar (100) 
,loca_code_custrcvplc  varchar (50) 
,itm_name  varchar (100) 
,itm_code  varchar (50) 
,unit_code  varchar (50) 
,usrgrp_name_chrg_cpo  varchar (100) 
,unit_name  varchar (100) 
,usrgrp_code_chrg_cpo  varchar (50) 
,classlist_code  varchar (50) 
,person_code_chrg_cpo  varchar (50) 
,loca_code_sect_chrg_cpo  varchar (50) 
,loca_name_sect_chrg_cpo  varchar (100) 
,loca_name_bill  varchar (100) 
,loca_code_bill  varchar (50) 
,classlist_name  varchar (100) 
,custinst_duedate   timestamp(6) 
,custinst_isudate   timestamp(6) 
,custinst_qty  numeric (22,6)
,custinst_price  numeric (38,4)
,custinst_amt  numeric (18,4)
,custinst_expiredate   date 
,custinst_starttime   timestamp(6) 
,custinst_contract_price  varchar (1) 
,custinst_itm_code_client  varchar (50) 
,itm_model  varchar (50) 
,cust_autocreate_custact  varchar (1) 
,cust_contract_price  varchar (1) 
,cust_rule_price  varchar (1) 
,cust_personname  varchar (30) 
,cust_amtround  varchar (2) 
,cust_amtdecimal  numeric (38,0)
,cust_custtype  varchar (1) 
,cust_contents  varchar (4000) 
,itm_weight  numeric (22,0)
,unit_contents  varchar (4000) 
,itm_length  numeric (22,0)
,itm_design  varchar (50) 
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,itm_material  varchar (50) 
,itm_datascale  numeric (22,0)
,custrcvplc_stktaking_proc  varchar (1) 
,custrcvplc_contents  varchar (4000) 
,scrlv_level1_chrg_cpo  varchar (1) 
,person_email_chrg_cpo  varchar (50) 
,custinst_remark  varchar (4000) 
,custinst_chrg_id_cpo  numeric (38,0)
,custinst_asstwh_id  numeric (38,0)
,custinst_cust_id  numeric (38,0)
,custinst_itm_id  numeric (38,0)
,custinst_id  numeric (38,0)
,custinst_updated_at   timestamp(6) 
,custinst_created_at   timestamp(6) 
,id  numeric (38,0)
,custinst_custrcvplc_id  numeric (38,0)
,custinst_update_ip  varchar (40) 
,custinst_person_id_upd  numeric (38,0)
,person_sect_id_chrg_cpo  numeric (22,0)
,chrg_person_id_chrg_cpo  numeric (38,0)
,itm_unit_id  numeric (22,0)
,person_sect_id_chrg_cust  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,bill_loca_id_bill  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,cust_chrg_id_cust  numeric (38,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,cust_loca_id_cust  numeric (38,0)
,cust_bill_id  numeric (38,0)
,bill_chrg_id_bill  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
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
 ALTER TABLE dlvinsts ADD CONSTRAINT dlvinst_itms_id FOREIGN KEY (itms_id)
																		 REFERENCES itms (id);
 ALTER TABLE dlvinsts ADD CONSTRAINT dlvinst_asstwhs_id FOREIGN KEY (asstwhs_id)
																		 REFERENCES asstwhs (id);
 ALTER TABLE dlvinsts ADD CONSTRAINT dlvinst_custrcvplcs_id FOREIGN KEY (custrcvplcs_id)
																		 REFERENCES custrcvplcs (id);
 ALTER TABLE dlvinsts ADD CONSTRAINT dlvinst_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 ALTER TABLE dlvinsts ADD CONSTRAINT dlvinst_transports_id FOREIGN KEY (transports_id)
																		 REFERENCES transports (id);
 ALTER TABLE dlvinsts ADD CONSTRAINT dlvinst_locas_id_to FOREIGN KEY (locas_id_to)
																		 REFERENCES locas (id);
 ALTER TABLE dlvinsts ADD CONSTRAINT dlvinst_prjnos_id FOREIGN KEY (prjnos_id)
																		 REFERENCES prjnos (id);
 ALTER TABLE purinsts ADD CONSTRAINT purinst_crrs_id FOREIGN KEY (crrs_id)
																		 REFERENCES crrs (id);
