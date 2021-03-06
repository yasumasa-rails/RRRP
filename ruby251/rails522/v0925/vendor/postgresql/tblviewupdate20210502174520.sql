
  drop view if  exists r_billords cascade ; 
 create or replace view r_billords as select  
  itm.itm_name  itm_name ,
  itm.itm_code  itm_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_unit_id  itm_unit_id ,
billord.id id,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
  bill.bill_loca_id_bill  bill_loca_id_bill ,
  bill.loca_code_bill  loca_code_bill ,
  bill.loca_name_bill  loca_name_bill ,
billord.orgtblid  billord_orgtblid,
billord.bills_id   billord_bill_id,
billord.saledate  billord_saledate,
billord.remark  billord_remark,
billord.expiredate  billord_expiredate,
billord.update_ip  billord_update_ip,
billord.created_at  billord_created_at,
billord.updated_at  billord_updated_at,
billord.persons_id_upd   billord_person_id_upd,
billord.itms_id   billord_itm_id,
billord.qty  billord_qty,
billord.price  billord_price,
billord.amt  billord_amt,
billord.sno  billord_sno,
billord.duedate  billord_duedate,
billord.isudate  billord_isudate,
billord.contents  billord_contents,
billord.tblname  billord_tblname,
billord.tblid  billord_tblid,
billord.tax  billord_tax,
  bill.bill_chrg_id_bill  bill_chrg_id_bill ,
  bill.person_code_chrg_bill  person_code_chrg_bill ,
  bill.person_name_chrg_bill  person_name_chrg_bill ,
  itm.itm_classlist_id  itm_classlist_id ,
  bill.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  bill.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  bill.bill_crr_id_bill  bill_crr_id_bill ,
  bill.crr_code_bill  crr_code_bill ,
  bill.crr_name_bill  crr_name_bill ,
billord.locas_id_to   billord_loca_id_to,
billord.crrs_id_billord   billord_crr_id_billord,
  crr_billord.crr_code  crr_code_billord ,
  crr_billord.crr_name  crr_name_billord ,
  crr_billord.crr_pricedecimal  crr_pricedecimal_billord ,
billord.gno_billsch  billord_gno_billsch
 from billords   billord,
  r_bills  bill ,  r_persons  person_upd ,  r_itms  itm ,  r_locas  loca_to ,  r_crrs  crr_billord 
  where       billord.bills_id = bill.id      and billord.persons_id_upd = person_upd.id      and billord.itms_id = itm.id      and billord.locas_id_to = loca_to.id      and billord.crrs_id_billord = crr_billord.id     ;
 DROP TABLE IF EXISTS sio.sio_r_billords;
 CREATE TABLE sio.sio_r_billords (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_billords_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,unit_code  varchar (50) 
,classlist_code  varchar (50) 
,itm_code  varchar (50) 
,classlist_name  varchar (100) 
,unit_name  varchar (100) 
,itm_name  varchar (100) 
,loca_code_to  varchar (50) 
,crr_code_billord  varchar (50) 
,loca_code_bill  varchar (50) 
,person_code_chrg_bill  varchar (50) 
,crr_code_bill  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,loca_name_to  varchar (100) 
,loca_name_bill  varchar (100) 
,crr_name_bill  varchar (100) 
,crr_name_billord  varchar (100) 
,billord_orgtblid  numeric (38,0)
,billord_saledate   timestamp(6) 
,billord_remark  varchar (4000) 
,billord_expiredate   date 
,billord_update_ip  varchar (40) 
,billord_created_at   timestamp(6) 
,billord_updated_at   timestamp(6) 
,billord_qty  numeric (22,6)
,billord_price  numeric (38,4)
,billord_amt  numeric (18,4)
,billord_sno  varchar (40) 
,billord_duedate   timestamp(6) 
,billord_isudate   timestamp(6) 
,billord_contents  varchar (4000) 
,billord_tblname  varchar (30) 
,billord_tblid  numeric (38,0)
,billord_tax  numeric (38,4)
,id  numeric (38,0)
,billord_loca_id_to  numeric (38,0)
,billord_bill_id  numeric (38,0)
,billord_itm_id  numeric (38,0)
,billord_gno_billsch  varchar (40) 
,crr_pricedecimal_billord  numeric (22,0)
,billord_crr_id_billord  numeric (22,0)
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,bill_chrg_id_bill  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,bill_loca_id_bill  numeric (38,0)
,itm_unit_id  numeric (22,0)
,billord_person_id_upd  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
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
 CREATE INDEX sio_r_billords_uk1 
  ON sio.sio_r_billords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_billords_seq ;
 create sequence sio.sio_r_billords_seq ;
  drop view if  exists r_payords cascade ; 
 create or replace view r_payords as select  
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  itm.itm_name  itm_name ,
  itm.itm_code  itm_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_unit_id  itm_unit_id ,
payord.id id,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  supplier.payment_chrg_id_payment  payment_chrg_id_payment ,
  supplier.person_code_chrg_payment  person_code_chrg_payment ,
  supplier.person_name_chrg_payment  person_name_chrg_payment ,
  supplier.supplier_payment_id  supplier_payment_id ,
  supplier.supplier_loca_id_supplier  supplier_loca_id_supplier ,
  supplier.supplier_chrg_id_supplier  supplier_chrg_id_supplier ,
  supplier.supplier_crr_id_supplier  supplier_crr_id_supplier ,
  supplier.loca_code_supplier  loca_code_supplier ,
  supplier.loca_name_supplier  loca_name_supplier ,
  supplier.person_code_chrg_supplier  person_code_chrg_supplier ,
  supplier.person_name_chrg_supplier  person_name_chrg_supplier ,
  supplier.crr_name_supplier  crr_name_supplier ,
  supplier.crr_code_supplier  crr_code_supplier ,
  itm.itm_classlist_id  itm_classlist_id ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
  payment_pay.payment_chrg_id_payment  payment_chrg_id_payment_pay ,
  payment_pay.loca_code_payment  loca_code_payment_pay ,
  payment_pay.loca_name_payment  loca_name_payment_pay ,
  payment_pay.person_code_chrg_payment  person_code_chrg_payment_pay ,
  payment_pay.person_name_chrg_payment  person_name_chrg_payment_pay ,
  payment_pay.person_sect_id_chrg_payment  person_sect_id_chrg_payment_pay ,
  payment_pay.payment_loca_id_payment  payment_loca_id_payment_pay ,
  payment_pay.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment_pay ,
payord.price  payord_price,
payord.itms_id   payord_itm_id,
payord.remark  payord_remark,
payord.created_at  payord_created_at,
payord.update_ip  payord_update_ip,
payord.duedate  payord_duedate,
payord.amt  payord_amt,
payord.isudate  payord_isudate,
payord.expiredate  payord_expiredate,
payord.updated_at  payord_updated_at,
payord.qty  payord_qty,
payord.sno  payord_sno,
payord.id  payord_id,
payord.persons_id_upd   payord_person_id_upd,
payord.contents  payord_contents,
payord.tax  payord_tax,
payord.sno_purord  payord_sno_purord,
payord.contract_price  payord_contract_price,
payord.chrgs_id   payord_chrg_id,
payord.itm_code_client  payord_itm_code_client,
payord.suppliers_id   payord_supplier_id,
payord.payments_id_pay   payord_payment_id_pay,
payord.gno  payord_gno,
  supplier.payment_crr_id_payment  payment_crr_id_payment ,
  supplier.crr_code_payment  crr_code_payment ,
  supplier.crr_name_payment  crr_name_payment ,
  payment_pay.payment_crr_id_payment  payment_crr_id_payment_pay ,
  payment_pay.crr_code_payment  crr_code_payment_pay ,
  payment_pay.crr_name_payment  crr_name_payment_pay ,
payord.crrs_id_payord   payord_crr_id_payord,
  crr_payord.crr_code  crr_code_payord ,
  crr_payord.crr_name  crr_name_payord ,
  crr_payord.crr_pricedecimal  crr_pricedecimal_payord ,
payord.gno_paysch  payord_gno_paysch
 from payords   payord,
  r_itms  itm ,  r_persons  person_upd ,  r_chrgs  chrg ,  r_suppliers  supplier ,  r_payments  payment_pay ,  r_crrs  crr_payord 
  where       payord.itms_id = itm.id      and payord.persons_id_upd = person_upd.id      and payord.chrgs_id = chrg.id      and payord.suppliers_id = supplier.id      and payord.payments_id_pay = payment_pay.id      and payord.crrs_id_payord = crr_payord.id     ;
 DROP TABLE IF EXISTS sio.sio_r_payords;
 CREATE TABLE sio.sio_r_payords (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_payords_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,payord_sno  varchar (40) 
,person_code_chrg  varchar (50) 
,itm_name  varchar (100) 
,itm_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,person_name_chrg  varchar (100) 
,loca_code_payment  varchar (50) 
,loca_name_payment  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,person_code_chrg_payment  varchar (50) 
,person_name_chrg_payment  varchar (100) 
,loca_code_supplier  varchar (50) 
,loca_name_supplier  varchar (100) 
,person_code_chrg_supplier  varchar (50) 
,person_name_chrg_supplier  varchar (100) 
,crr_name_supplier  varchar (100) 
,crr_code_supplier  varchar (50) 
,loca_code_payment_pay  varchar (50) 
,loca_name_payment_pay  varchar (100) 
,person_code_chrg_payment_pay  varchar (50) 
,person_name_chrg_payment_pay  varchar (100) 
,payord_sno_purord  varchar (50) 
,payord_contract_price  varchar (1) 
,payord_itm_code_client  varchar (50) 
,payord_price  numeric (38,4)
,payord_duedate   timestamp(6) 
,payord_amt  numeric (18,4)
,payord_isudate   timestamp(6) 
,payord_expiredate   date 
,payord_qty  numeric (18,4)
,payord_tax  numeric (38,4)
,crr_code_payord  varchar (50) 
,crr_code_payment_pay  varchar (50) 
,crr_code_payment  varchar (50) 
,crr_name_payord  varchar (100) 
,crr_name_payment  varchar (100) 
,crr_name_payment_pay  varchar (100) 
,payord_gno_paysch  varchar (40) 
,payord_crr_id_payord  numeric (22,0)
,payord_gno  varchar (40) 
,crr_pricedecimal_payord  numeric (22,0)
,payord_remark  varchar (4000) 
,payord_contents  varchar (4000) 
,person_name_upd  varchar (100) 
,person_code_upd  varchar (50) 
,payord_supplier_id  numeric (22,0)
,payment_crr_id_payment  numeric (22,0)
,payment_crr_id_payment_pay  numeric (22,0)
,payord_updated_at   timestamp(6) 
,payord_itm_id  numeric (38,0)
,payord_created_at   timestamp(6) 
,payord_update_ip  varchar (40) 
,payord_id  numeric (38,0)
,id  numeric (38,0)
,payord_chrg_id  numeric (38,0)
,payord_person_id_upd  numeric (38,0)
,payord_payment_id_pay  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,payment_chrg_id_payment_pay  numeric (22,0)
,person_sect_id_chrg_payment_pay  numeric (22,0)
,payment_loca_id_payment_pay  numeric (38,0)
,chrg_person_id_chrg_payment_pay  numeric (38,0)
,itm_unit_id  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
,payment_chrg_id_payment  numeric (22,0)
,supplier_payment_id  numeric (38,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
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
 CREATE INDEX sio_r_payords_uk1 
  ON sio.sio_r_payords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_payords_seq ;
 create sequence sio.sio_r_payords_seq ;
  drop view if  exists r_mkords cascade ; 
 create or replace view r_mkords as select  
mkord.id id,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  itm_pare.itm_code  itm_code_pare ,
  itm_pare.itm_name  itm_name_pare ,
mkord.runtime  mkord_runtime,
mkord.result_f  mkord_result_f,
mkord.message_code  mkord_message_code,
mkord.orgtblname  mkord_orgtblname,
mkord.sno_org  mkord_sno_org,
mkord.expiredate  mkord_expiredate,
mkord.updated_at  mkord_updated_at,
mkord.remark  mkord_remark,
mkord.created_at  mkord_created_at,
mkord.update_ip  mkord_update_ip,
mkord.tblname  mkord_tblname,
mkord.id  mkord_id,
mkord.persons_id_upd   mkord_person_id_upd,
mkord.locas_id_org   mkord_loca_id_org,
  loca_org.loca_code  loca_code_org ,
  loca_org.loca_name  loca_name_org ,
mkord.locas_id_trn   mkord_loca_id_trn,
  loca_trn.loca_code  loca_code_trn ,
  loca_trn.loca_name  loca_name_trn ,
mkord.itms_id_org   mkord_itm_id_org,
  itm_org.itm_code  itm_code_org ,
  itm_org.itm_std  itm_std_org ,
  itm_org.itm_name  itm_name_org ,
mkord.itms_id_trn   mkord_itm_id_trn,
  itm_trn.itm_code  itm_code_trn ,
  itm_trn.itm_name  itm_name_trn ,
mkord.duedate_trn  mkord_duedate_trn,
mkord.isudate  mkord_isudate,
mkord.cmpldate  mkord_cmpldate,
mkord.incnt  mkord_incnt,
mkord.outcnt  mkord_outcnt,
mkord.inqty  mkord_inqty,
mkord.outqty  mkord_outqty,
mkord.inamt  mkord_inamt,
mkord.outamt  mkord_outamt,
mkord.skipcnt  mkord_skipcnt,
mkord.skipqty  mkord_skipqty,
mkord.skipamt  mkord_skipamt,
mkord.sno_trn  mkord_sno_trn,
mkord.chrgs_id_trn   mkord_chrg_id_trn,
  chrg_trn.person_code_chrg  person_code_chrg_trn ,
  chrg_trn.person_name_chrg  person_name_chrg_trn ,
  chrg_trn.person_sect_id_chrg  person_sect_id_chrg_trn ,
mkord.duedate_pare  mkord_duedate_pare,
mkord.sno_pare  mkord_sno_pare,
mkord.confirm  mkord_confirm,
  loca_pare.loca_code  loca_code_pare ,
  loca_pare.loca_name  loca_name_pare ,
mkord.locas_id_pare   mkord_loca_id_pare,
mkord.itms_id_pare   mkord_itm_id_pare,
mkord.itm_code_pare  mkord_itm_code_pare,
mkord.paretblname  mkord_paretblname,
mkord.starttime_trn  mkord_starttime_trn,
mkord.manual  mkord_manual,
mkord.opeitm_processseq_trn  mkord_opeitm_processseq_trn,
  itm_pare.classlist_name  classlist_name_pare ,
mkord.locas_id_to   mkord_loca_id_to,
  itm_org.classlist_code  classlist_code_org ,
  itm_org.classlist_name  classlist_name_org ,
mkord.opeitm_processseq_pare  mkord_opeitm_processseq_pare,
mkord.opeitm_processseq_org  mkord_opeitm_processseq_org,
mkord.duedate_org  mkord_duedate_org
 from mkords   mkord,
  r_persons  person_upd ,  r_locas  loca_org ,  r_locas  loca_trn ,  r_itms  itm_org ,  r_itms  itm_trn ,  r_chrgs  chrg_trn ,  r_locas  loca_pare ,  r_itms  itm_pare ,  r_locas  loca_to 
  where       mkord.persons_id_upd = person_upd.id      and mkord.locas_id_org = loca_org.id      and mkord.locas_id_trn = loca_trn.id      and mkord.itms_id_org = itm_org.id      and mkord.itms_id_trn = itm_trn.id      and mkord.chrgs_id_trn = chrg_trn.id      and mkord.locas_id_pare = loca_pare.id      and mkord.itms_id_pare = itm_pare.id      and mkord.locas_id_to = loca_to.id     ;
 DROP TABLE IF EXISTS sio.sio_r_mkords;
 CREATE TABLE sio.sio_r_mkords (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_mkords_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,mkord_isudate   timestamp(6) 
,mkord_confirm  varchar (1) 
,mkord_result_f  varchar (1) 
,mkord_tblname  varchar (20) 
,mkord_runtime  numeric (2,0)
,mkord_cmpldate   timestamp(6) 
,itm_code_trn  varchar (50) 
,mkord_opeitm_processseq_trn  varchar (3) 
,itm_name_trn  varchar (100) 
,mkord_duedate_trn   timestamp(6) 
,loca_code_trn  varchar (50) 
,loca_name_trn  varchar (100) 
,person_code_chrg_trn  varchar (50) 
,person_name_chrg_trn  varchar (100) 
,loca_code_to  varchar (50) 
,loca_name_to  varchar (100) 
,mkord_sno_trn  varchar (50) 
,mkord_paretblname  varchar (20) 
,itm_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,loca_code_pare  varchar (50) 
,loca_name_pare  varchar (100) 
,mkord_sno_org  varchar (50) 
,mkord_orgtblname  varchar (20) 
,itm_code_org  varchar (50) 
,mkord_opeitm_processseq_org  varchar (3) 
,itm_name_org  varchar (100) 
,itm_std_org  varchar (50) 
,loca_code_org  varchar (50) 
,loca_name_org  varchar (100) 
,classlist_name_org  varchar (100) 
,classlist_name_pare  varchar (100) 
,classlist_code_org  varchar (50) 
,mkord_duedate_org   timestamp(6) 
,mkord_message_code  varchar (256) 
,mkord_expiredate   date 
,mkord_opeitm_processseq_pare  varchar (3) 
,mkord_manual  varchar (1) 
,mkord_itm_code_pare  varchar (50) 
,mkord_skipcnt  numeric (38,0)
,mkord_incnt  numeric (38,0)
,mkord_outcnt  numeric (38,0)
,mkord_inqty  numeric (22,6)
,mkord_outqty  numeric (22,6)
,mkord_inamt  numeric (38,4)
,mkord_outamt  numeric (38,4)
,mkord_skipqty  numeric (22,6)
,mkord_skipamt  numeric (38,4)
,mkord_duedate_pare   timestamp(6) 
,mkord_sno_pare  varchar (50) 
,mkord_starttime_trn   timestamp(6) 
,mkord_remark  varchar (4000) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,mkord_itm_id_org  numeric (38,0)
,mkord_loca_id_pare  numeric (38,0)
,mkord_itm_id_pare  numeric (38,0)
,mkord_loca_id_trn  numeric (38,0)
,mkord_loca_id_org  numeric (38,0)
,mkord_person_id_upd  numeric (38,0)
,mkord_id  numeric (38,0)
,mkord_update_ip  varchar (40) 
,mkord_loca_id_to  numeric (38,0)
,mkord_created_at   timestamp(6) 
,mkord_chrg_id_trn  numeric (38,0)
,mkord_updated_at   timestamp(6) 
,id  numeric (38,0)
,mkord_itm_id_trn  numeric (38,0)
,person_sect_id_chrg_trn  numeric (22,0)
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
 CREATE INDEX sio_r_mkords_uk1 
  ON sio.sio_r_mkords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_mkords_seq ;
 create sequence sio.sio_r_mkords_seq ;
  drop view if  exists r_prdords cascade ; 
 create or replace view r_prdords as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
prdord.id id,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
prdord.expiredate  prdord_expiredate,
prdord.updated_at  prdord_updated_at,
prdord.qty  prdord_qty,
prdord.sno  prdord_sno,
prdord.remark  prdord_remark,
prdord.created_at  prdord_created_at,
prdord.update_ip  prdord_update_ip,
prdord.duedate  prdord_duedate,
prdord.toduedate  prdord_toduedate,
prdord.id  prdord_id,
prdord.persons_id_upd   prdord_person_id_upd,
prdord.isudate  prdord_isudate,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
prdord.prjnos_id   prdord_prjno_id,
prdord.gno  prdord_gno,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
prdord.opeitms_id   prdord_opeitm_id,
prdord.chrgs_id   prdord_chrg_id,
prdord.starttime  prdord_starttime,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
prdord.confirm  prdord_confirm,
prdord.opt_fixoterm  prdord_opt_fixoterm,
prdord.autocreate_inst  prdord_autocreate_inst,
prdord.autocreate_act  prdord_autocreate_act,
prdord.autoinst_p  prdord_autoinst_p,
prdord.autoact_p  prdord_autoact_p,
prdord.qty_case  prdord_qty_case,
  opeitm.itm_classlist_id  itm_classlist_id ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  workplace.workplace_loca_id_workplace  workplace_loca_id_workplace ,
  workplace.loca_code_workplace  loca_code_workplace ,
  workplace.loca_name_workplace  loca_name_workplace ,
prdord.shelfnos_id_to   prdord_shelfno_id_to,
  workplace.workplace_chrg_id_workplace  workplace_chrg_id_workplace ,
  workplace.person_code_chrg_workplace  person_code_chrg_workplace ,
  workplace.person_name_chrg_workplace  person_name_chrg_workplace ,
  workplace.person_sect_id_chrg_workplace  person_sect_id_chrg_workplace ,
  workplace.chrg_person_id_chrg_workplace  chrg_person_id_chrg_workplace ,
prdord.workplaces_id   prdord_workplace_id,
prdord.sno_prdsch  prdord_sno_prdsch,
prdord.gno_prdsch  prdord_gno_prdsch,
  prjno.prjno_name_chil  prjno_name_chil ,
  opeitm.opeitm_loca_id_opeitm  opeitm_loca_id_opeitm ,
  opeitm.loca_code_opeitm  loca_code_opeitm ,
  opeitm.loca_name_opeitm  loca_name_opeitm ,
prdord.crrs_id_prdord   prdord_crr_id_prdord,
  crr_prdord.crr_code  crr_code_prdord ,
  crr_prdord.crr_name  crr_name_prdord ,
  crr_prdord.crr_pricedecimal  crr_pricedecimal_prdord 
 from prdords   prdord,
  r_persons  person_upd ,  r_prjnos  prjno ,  r_opeitms  opeitm ,  r_chrgs  chrg ,  r_shelfnos  shelfno_to ,  r_workplaces  workplace ,  r_crrs  crr_prdord 
  where       prdord.persons_id_upd = person_upd.id      and prdord.prjnos_id = prjno.id      and prdord.opeitms_id = opeitm.id      and prdord.chrgs_id = chrg.id      and prdord.shelfnos_id_to = shelfno_to.id      and prdord.workplaces_id = workplace.id      and prdord.crrs_id_prdord = crr_prdord.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdords;
 CREATE TABLE sio.sio_r_prdords (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdords_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prdord_confirm  varchar (1) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,prdord_isudate   timestamp(6) 
,prdord_sno  varchar (40) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,opeitm_processseq  numeric (3,0)
,prdord_duedate   timestamp(6) 
,prdord_qty  numeric (18,4)
,loca_code_workplace  varchar (50) 
,loca_name_workplace  varchar (100) 
,opeitm_priority  numeric (3,0)
,prdord_toduedate   timestamp(6) 
,prdord_qty_case  numeric (38,0)
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,prdord_autoact_p  numeric (3,0)
,prdord_opt_fixoterm  numeric (5,2)
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,loca_code_shelfno_to  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,prdord_autocreate_inst  varchar (1) 
,prdord_autocreate_act  varchar (1) 
,prdord_autoinst_p  numeric (3,0)
,prdord_expiredate   date 
,person_name_chrg_workplace  varchar (100) 
,person_code_chrg_workplace  varchar (50) 
,prdord_sno_prdsch  varchar (50) 
,crr_code_prdord  varchar (50) 
,prjno_code_chil  varchar (50) 
,loca_code_opeitm  varchar (50) 
,crr_name_prdord  varchar (100) 
,loca_name_opeitm  varchar (100) 
,prjno_name_chil  varchar (100) 
,unit_code  varchar (50) 
,prdord_gno  varchar (40) 
,prdord_starttime   timestamp(6) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,crr_pricedecimal_prdord  numeric (22,0)
,prdord_gno_prdsch  varchar (50) 
,prdord_crr_id_prdord  numeric (22,0)
,prdord_remark  varchar (4000) 
,opeitm_boxe_id  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,prdord_prjno_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,prdord_person_id_upd  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,workplace_loca_id_workplace  numeric (22,0)
,prdord_id  numeric (38,0)
,prdord_update_ip  varchar (40) 
,prdord_shelfno_id_to  numeric (38,0)
,workplace_chrg_id_workplace  numeric (22,0)
,prdord_created_at   timestamp(6) 
,person_sect_id_chrg_workplace  numeric (22,0)
,chrg_person_id_chrg_workplace  numeric (38,0)
,prdord_workplace_id  numeric (22,0)
,prdord_updated_at   timestamp(6) 
,itm_unit_id  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_loca_id_opeitm  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,id  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,prdord_opeitm_id  numeric (38,0)
,prdord_chrg_id  numeric (38,0)
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
 CREATE INDEX sio_r_prdords_uk1 
  ON sio.sio_r_prdords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdords_seq ;
 create sequence sio.sio_r_prdords_seq ;
  drop view if  exists r_purords cascade ; 
 create or replace view r_purords as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
purord.autoinst_p  purord_autoinst_p,
purord.autocreate_act  purord_autocreate_act,
purord.autoact_p  purord_autoact_p,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
purord.qty  purord_qty,
purord.duedate  purord_duedate,
purord.isudate  purord_isudate,
purord.remark  purord_remark,
purord.update_ip  purord_update_ip,
purord.created_at  purord_created_at,
purord.updated_at  purord_updated_at,
purord.id  purord_id,
purord.sno  purord_sno,
purord.id id,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
purord.amt  purord_amt,
purord.toduedate  purord_toduedate,
purord.persons_id_upd   purord_person_id_upd,
purord.sno_pursch  purord_sno_pursch,
purord.expiredate  purord_expiredate,
purord.price  purord_price,
purord.opt_fixoterm  purord_opt_fixoterm,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
purord.qty_case  purord_qty_case,
purord.confirm  purord_confirm,
purord.opeitms_id   purord_opeitm_id,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
purord.autocreate_inst  purord_autocreate_inst,
  prjno.prjno_code  prjno_code ,
purord.prjnos_id   purord_prjno_id,
purord.contract_price  purord_contract_price,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
purord.chrgs_id   purord_chrg_id,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
purord.tax  purord_tax,
purord.gno  purord_gno,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
purord.itm_code_client  purord_itm_code_client,
purord.starttime  purord_starttime,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  supplier.payment_chrg_id_payment  payment_chrg_id_payment ,
  supplier.person_code_chrg_payment  person_code_chrg_payment ,
  supplier.person_name_chrg_payment  person_name_chrg_payment ,
purord.suppliers_id   purord_supplier_id,
  supplier.supplier_payment_id  supplier_payment_id ,
  supplier.supplier_loca_id_supplier  supplier_loca_id_supplier ,
  supplier.supplier_chrg_id_supplier  supplier_chrg_id_supplier ,
  supplier.supplier_crr_id_supplier  supplier_crr_id_supplier ,
  supplier.loca_code_supplier  loca_code_supplier ,
  supplier.loca_name_supplier  loca_name_supplier ,
  supplier.person_code_chrg_supplier  person_code_chrg_supplier ,
  supplier.person_name_chrg_supplier  person_name_chrg_supplier ,
  supplier.crr_name_supplier  crr_name_supplier ,
  supplier.crr_code_supplier  crr_code_supplier ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
purord.gno_pursch  purord_gno_pursch,
purord.shelfnos_id_to   purord_shelfno_id_to,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  supplier.payment_crr_id_payment  payment_crr_id_payment ,
  supplier.crr_code_payment  crr_code_payment ,
  supplier.crr_name_payment  crr_name_payment ,
  prjno.prjno_name_chil  prjno_name_chil ,
  opeitm.opeitm_loca_id_opeitm  opeitm_loca_id_opeitm ,
  opeitm.loca_code_opeitm  loca_code_opeitm ,
  opeitm.loca_name_opeitm  loca_name_opeitm ,
purord.crrs_id_purord   purord_crr_id_purord,
  crr_purord.crr_code  crr_code_purord ,
  crr_purord.crr_name  crr_name_purord ,
  crr_purord.crr_pricedecimal  crr_pricedecimal_purord 
 from purords   purord,
  r_persons  person_upd ,  r_opeitms  opeitm ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_suppliers  supplier ,  r_shelfnos  shelfno_to ,  r_crrs  crr_purord 
  where       purord.persons_id_upd = person_upd.id      and purord.opeitms_id = opeitm.id      and purord.prjnos_id = prjno.id      and purord.chrgs_id = chrg.id      and purord.suppliers_id = supplier.id      and purord.shelfnos_id_to = shelfno_to.id      and purord.crrs_id_purord = crr_purord.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purords;
 CREATE TABLE sio.sio_r_purords (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purords_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,purord_confirm  char (01) 
,purord_sno  varchar (40) 
,purord_isudate   timestamp(6) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,opeitm_processseq  numeric (3,0)
,purord_starttime   timestamp(6) 
,purord_duedate   timestamp(6) 
,purord_qty  numeric (18,4)
,loca_code_supplier  varchar (50) 
,loca_name_supplier  varchar (100) 
,purord_qty_case  numeric (38,0)
,purord_price  numeric (38,4)
,purord_amt  numeric (18,4)
,purord_tax  numeric (38,4)
,crr_code_supplier  varchar (50) 
,crr_name_supplier  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,loca_code_shelfno_to  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,person_code_chrg_supplier  varchar (50) 
,person_name_chrg_supplier  varchar (100) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,purord_itm_code_client  varchar (50) 
,purord_opt_fixoterm  numeric (5,2)
,purord_autocreate_inst  varchar (1) 
,purord_autoinst_p  numeric (3,0)
,purord_autocreate_act  varchar (1) 
,purord_autoact_p  numeric (3,0)
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_name_outbox  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_box  varchar (100) 
,person_name_chrg_payment  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,prjno_code_chil  varchar (50) 
,boxe_name  varchar (100) 
,boxe_code  varchar (50) 
,person_code_chrg_payment  varchar (50) 
,unit_code_box  varchar (50) 
,loca_code_payment  varchar (50) 
,loca_name_payment  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,purord_toduedate   timestamp(6) 
,purord_expiredate   date 
,purord_sno_pursch  varchar (50) 
,crr_code_purord  varchar (50) 
,opeitm_priority  numeric (3,0)
,crr_code_payment  varchar (50) 
,loca_code_opeitm  varchar (50) 
,prjno_name_chil  varchar (100) 
,loca_name_opeitm  varchar (100) 
,crr_name_payment  varchar (100) 
,crr_name_purord  varchar (100) 
,purord_gno  varchar (40) 
,purord_contract_price  varchar (1) 
,purord_gno_pursch  varchar (50) 
,crr_pricedecimal_purord  numeric (22,0)
,purord_crr_id_purord  numeric (22,0)
,purord_remark  varchar (4000) 
,purord_prjno_id  numeric (38,0)
,purord_person_id_upd  numeric (38,0)
,id  numeric (38,0)
,purord_id  numeric (38,0)
,purord_updated_at   timestamp(6) 
,purord_opeitm_id  numeric (38,0)
,purord_created_at   timestamp(6) 
,purord_update_ip  varchar (40) 
,purord_chrg_id  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,purord_supplier_id  numeric (22,0)
,purord_shelfno_id_to  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,payment_crr_id_payment  numeric (22,0)
,opeitm_loca_id_opeitm  numeric (22,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_payment_id  numeric (38,0)
,payment_chrg_id_payment  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,payment_loca_id_payment  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,itm_unit_id  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
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
 CREATE INDEX sio_r_purords_uk1 
  ON sio.sio_r_purords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purords_seq ;
 create sequence sio.sio_r_purords_seq ;
  drop view if  exists r_shpords cascade ; 
 create or replace view r_shpords as select  
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  itm.itm_name  itm_name ,
  itm.itm_code  itm_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_unit_id  itm_unit_id ,
  transport.transport_code  transport_code ,
  transport.transport_name  transport_name ,
shpord.qty  shpord_qty,
shpord.sno  shpord_sno,
shpord.update_ip  shpord_update_ip,
shpord.updated_at  shpord_updated_at,
shpord.isudate  shpord_isudate,
shpord.persons_id_upd   shpord_person_id_upd,
shpord.id  shpord_id,
shpord.created_at  shpord_created_at,
shpord.id id,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to ,
shpord.expiredate  shpord_expiredate,
shpord.depdate  shpord_depdate,
shpord.locas_id_to   shpord_loca_id_to,
shpord.price  shpord_price,
shpord.itms_id   shpord_itm_id,
shpord.remark  shpord_remark,
shpord.amt  shpord_amt,
shpord.tax  shpord_tax,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  prjno.prjno_code  prjno_code ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
shpord.chrgs_id   shpord_chrg_id,
shpord.gno  shpord_gno,
shpord.processseq  shpord_processseq,
shpord.manual  shpord_manual,
shpord.prjnos_id   shpord_prjno_id,
shpord.contract_price  shpord_contract_price,
shpord.qty_case  shpord_qty_case,
shpord.lotno  shpord_lotno,
shpord.packno  shpord_packno,
  prjno.prjno_code_chil  prjno_code_chil ,
shpord.transports_id   shpord_transport_id,
  itm.itm_classlist_id  itm_classlist_id ,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
shpord.qty_stk  shpord_qty_stk,
shpord.paretblname  shpord_paretblname,
shpord.paretblid  shpord_paretblid,
shpord.shelfnos_id_fm   shpord_shelfno_id_fm,
shpord.sno_shpsch  shpord_sno_shpsch,
shpord.gno_shpsch  shpord_gno_shpsch,
  prjno.prjno_name_chil  prjno_name_chil ,
shpord.crrs_id_shpord   shpord_crr_id_shpord,
  crr_shpord.crr_code  crr_code_shpord ,
  crr_shpord.crr_name  crr_name_shpord ,
  crr_shpord.crr_pricedecimal  crr_pricedecimal_shpord 
 from shpords   shpord,
  r_persons  person_upd ,  r_locas  loca_to ,  r_itms  itm ,  r_chrgs  chrg ,  r_prjnos  prjno ,  r_transports  transport ,  r_shelfnos  shelfno_fm ,  r_crrs  crr_shpord 
  where       shpord.persons_id_upd = person_upd.id      and shpord.locas_id_to = loca_to.id      and shpord.itms_id = itm.id      and shpord.chrgs_id = chrg.id      and shpord.prjnos_id = prjno.id      and shpord.transports_id = transport.id      and shpord.shelfnos_id_fm = shelfno_fm.id      and shpord.crrs_id_shpord = crr_shpord.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shpords;
 CREATE TABLE sio.sio_r_shpords (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shpords_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prjno_code  varchar (50) 
,unit_code  varchar (50) 
,classlist_code  varchar (50) 
,transport_code  varchar (50) 
,shpord_gno  varchar (40) 
,itm_code  varchar (50) 
,shpord_sno  varchar (40) 
,shpord_lotno  varchar (50) 
,itm_name  varchar (100) 
,unit_name  varchar (100) 
,transport_name  varchar (100) 
,shpord_qty  numeric (22,6)
,shpord_isudate   timestamp(6) 
,shpord_depdate   timestamp(6) 
,shpord_paretblname  varchar (30) 
,shpord_price  numeric (38,4)
,shpord_qty_stk  numeric (22,6)
,shpord_amt  numeric (18,4)
,shpord_tax  numeric (38,4)
,prjno_name  varchar (100) 
,classlist_name  varchar (100) 
,shpord_processseq  numeric (38,0)
,shpord_manual  varchar (1) 
,shpord_contract_price  varchar (1) 
,shpord_qty_case  numeric (22,0)
,shpord_packno  varchar (10) 
,shpord_sno_shpsch  varchar (50) 
,shpord_paretblid  numeric (38,0)
,shpord_expiredate   date 
,shelfno_code_fm  varchar (50) 
,person_code_chrg  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_to  varchar (50) 
,crr_code_shpord  varchar (50) 
,prjno_code_chil  varchar (50) 
,person_name_chrg  varchar (100) 
,crr_name_shpord  varchar (100) 
,shelfno_name_fm  varchar (100) 
,prjno_name_chil  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_to  varchar (100) 
,shpord_gno_shpsch  varchar (50) 
,crr_pricedecimal_shpord  numeric (22,0)
,shpord_crr_id_shpord  numeric (22,0)
,shpord_remark  varchar (4000) 
,itm_classlist_id  numeric (38,0)
,shpord_chrg_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,shpord_itm_id  numeric (38,0)
,shpord_loca_id_to  numeric (38,0)
,id  numeric (38,0)
,shpord_shelfno_id_fm  numeric (22,0)
,shpord_created_at   timestamp(6) 
,shpord_id  numeric (38,0)
,shpord_person_id_upd  numeric (38,0)
,itm_unit_id  numeric (22,0)
,shpord_updated_at   timestamp(6) 
,shpord_update_ip  varchar (40) 
,shpord_transport_id  numeric (38,0)
,shpord_prjno_id  numeric (38,0)
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
 CREATE INDEX sio_r_shpords_uk1 
  ON sio.sio_r_shpords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpords_seq ;
 create sequence sio.sio_r_shpords_seq ;
  drop view if  exists r_custords cascade ; 
 create or replace view r_custords as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
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
custord.chrgs_id_custord   custord_chrg_id_custord,
  chrg_custord.person_code_chrg  person_code_chrg_custord ,
  chrg_custord.person_name_chrg  person_name_chrg_custord ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  cust.bill_loca_id_bill  bill_loca_id_bill ,
  cust.loca_code_bill  loca_code_bill ,
  cust.loca_name_bill  loca_name_bill ,
  cust.cust_bill_id  cust_bill_id ,
  cust.crr_name_cust  crr_name_cust ,
  cust.crr_code_cust  crr_code_cust ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
custord.custrcvplcs_id   custord_custrcvplc_id,
custord.itm_code_client  custord_itm_code_client,
custord.contents  custord_contents,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  cust.bill_chrg_id_bill  bill_chrg_id_bill ,
  cust.person_code_chrg_bill  person_code_chrg_bill ,
  cust.person_name_chrg_bill  person_name_chrg_bill ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
  cust.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  cust.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
custord.opeitms_id   custord_opeitm_id,
custord.gno_custsch  custord_gno_custsch,
custord.cno_custsch  custord_cno_custsch,
  cust.crr_code_bill  crr_code_bill ,
  cust.crr_name_bill  crr_name_bill ,
custord.starttime  custord_starttime,
custord.shelfnos_id_fm   custord_shelfno_id_fm,
  prjno.prjno_priority  prjno_priority ,
custord.crrs_id_custord   custord_crr_id_custord,
  crr_custord.crr_code  crr_code_custord ,
  crr_custord.crr_name  crr_name_custord ,
  opeitm.opeitm_loca_id_opeitm  opeitm_loca_id_opeitm ,
  opeitm.loca_code_opeitm  loca_code_opeitm ,
  opeitm.loca_name_opeitm  loca_name_opeitm 
 from custords   custord,
  r_persons  person_upd ,  r_custs  cust ,  r_prjnos  prjno ,  r_chrgs  chrg_custord ,  r_custrcvplcs  custrcvplc ,  r_opeitms  opeitm ,  r_shelfnos  shelfno_fm ,  r_crrs  crr_custord 
  where       custord.persons_id_upd = person_upd.id      and custord.custs_id = cust.id      and custord.prjnos_id = prjno.id      and custord.chrgs_id_custord = chrg_custord.id      and custord.custrcvplcs_id = custrcvplc.id      and custord.opeitms_id = opeitm.id      and custord.shelfnos_id_fm = shelfno_fm.id      and custord.crrs_id_custord = crr_custord.id     ;
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
,opeitm_processseq  numeric (3,0)
,opeitm_priority  numeric (3,0)
,custord_itm_code_client  varchar (50) 
,loca_code_opeitm  varchar (50) 
,loca_name_opeitm  varchar (100) 
,custord_duedate   timestamp(6) 
,custord_qty  numeric (18,4)
,custord_price  numeric (22,0)
,custord_contract_price  varchar (1) 
,custord_amt  numeric (18,4)
,person_code_chrg_bill  varchar (50) 
,loca_code_bill  varchar (50) 
,loca_name_bill  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,crr_code_cust  varchar (50) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,crr_name_cust  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,crr_code_custord  varchar (50) 
,prjno_priority  numeric (38,0)
,crr_name_custord  varchar (100) 
,person_name_chrg_bill  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,crr_code_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,custord_starttime   timestamp(6) 
,custord_cno_custsch  varchar (50) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,custord_sno  varchar (40) 
,loca_code_custrcvplc  varchar (50) 
,person_code_chrg_custord  varchar (50) 
,shelfno_code_fm  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,loca_name_custrcvplc  varchar (100) 
,person_name_chrg_custord  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,shelfno_name_fm  varchar (100) 
,custord_shelfno_id_fm  numeric (22,0)
,custord_gno  varchar (40) 
,custord_gno_custsch  varchar (50) 
,custord_crr_id_custord  numeric (22,0)
,custord_chrg_id_custord  numeric (38,0)
,person_name_upd  varchar (100) 
,person_code_upd  varchar (50) 
,custord_toduedate   timestamp(6) 
,custord_expiredate   date 
,custord_contents  varchar (4000) 
,custord_remark  varchar (4000) 
,opeitm_unit_id_case  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,custord_prjno_id  numeric (38,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,bill_loca_id_bill  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,custord_custrcvplc_id  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,bill_chrg_id_bill  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,custord_opeitm_id  numeric (38,0)
,opeitm_loca_id_opeitm  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,custord_person_id_upd  numeric (22,0)
,custord_updated_at   timestamp(6) 
,custord_created_at   timestamp(6) 
,custord_id  numeric (22,0)
,cust_bill_id  numeric (22,0)
,custord_cust_id  numeric (22,0)
,id  numeric (22,0)
,custord_update_ip  varchar (40) 
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
