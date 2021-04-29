
  drop view if  exists r_billschs cascade ; 
 create or replace view r_billschs as select  
  itm.itm_name  itm_name ,
  itm.itm_code  itm_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_unit_id  itm_unit_id ,
billsch.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
  bill.bill_loca_id_bill  bill_loca_id_bill ,
  bill.loca_code_bill  loca_code_bill ,
  bill.loca_name_bill  loca_name_bill ,
billsch.saledate  billsch_saledate,
billsch.remark  billsch_remark,
billsch.expiredate  billsch_expiredate,
billsch.update_ip  billsch_update_ip,
billsch.created_at  billsch_created_at,
billsch.updated_at  billsch_updated_at,
billsch.persons_id_upd   billsch_person_id_upd,
billsch.itms_id   billsch_itm_id,
billsch.price  billsch_price,
billsch.sno  billsch_sno,
billsch.duedate  billsch_duedate,
billsch.isudate  billsch_isudate,
billsch.contents  billsch_contents,
billsch.tax  billsch_tax,
billsch.bills_id   billsch_bill_id,
  bill.bill_chrg_id_bill  bill_chrg_id_bill ,
  bill.person_code_chrg_bill  person_code_chrg_bill ,
  bill.person_name_chrg_bill  person_name_chrg_bill ,
  itm.itm_classlist_id  itm_classlist_id ,
  bill.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  bill.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  bill.bill_crr_id_bill  bill_crr_id_bill ,
  bill.crr_code_bill  crr_code_bill ,
  bill.crr_name_bill  crr_name_bill ,
billsch.qty_sch  billsch_qty_sch,
billsch.amt_sch  billsch_amt_sch,
billsch.processseq  billsch_processseq
 from billschs   billsch,
  r_persons  person_upd ,  r_itms  itm ,  r_bills  bill 
  where       billsch.persons_id_upd = person_upd.id      and billsch.itms_id = itm.id      and billsch.bills_id = bill.id     ;
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
,classlist_code  varchar (50) 
,itm_code  varchar (50) 
,unit_code  varchar (50) 
,classlist_name  varchar (100) 
,itm_name  varchar (100) 
,unit_name  varchar (100) 
,loca_code_bill  varchar (50) 
,crr_code_bill  varchar (50) 
,person_code_chrg_bill  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,loca_name_bill  varchar (100) 
,crr_name_bill  varchar (100) 
,billsch_isudate   timestamp(6) 
,billsch_contents  varchar (4000) 
,billsch_tax  numeric (38,4)
,billsch_bill_id  numeric (38,0)
,billsch_processseq  numeric (38,0)
,id  numeric (38,0)
,billsch_saledate   timestamp(6) 
,billsch_remark  varchar (4000) 
,billsch_expiredate   date 
,billsch_update_ip  varchar (40) 
,billsch_created_at   timestamp(6) 
,billsch_updated_at   timestamp(6) 
,billsch_itm_id  numeric (38,0)
,billsch_price  numeric (38,4)
,billsch_sno  varchar (40) 
,billsch_duedate   timestamp(6) 
,billsch_qty_sch  numeric (22,6)
,billsch_amt_sch  numeric (38,4)
,person_name_upd  varchar (100) 
,person_code_upd  varchar (50) 
,bill_crr_id_bill  numeric (22,0)
,billsch_person_id_upd  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,bill_chrg_id_bill  numeric (22,0)
,bill_loca_id_bill  numeric (38,0)
,itm_unit_id  numeric (22,0)
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
 CREATE INDEX sio_r_billschs_uk1 
  ON sio.sio_r_billschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_billschs_seq ;
 create sequence sio.sio_r_billschs_seq ;
  drop view if  exists r_payschs cascade ; 
 create or replace view r_payschs as select  
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  itm.itm_name  itm_name ,
  itm.itm_code  itm_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_unit_id  itm_unit_id ,
paysch.id id,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
paysch.id  paysch_id,
paysch.remark  paysch_remark,
paysch.expiredate  paysch_expiredate,
paysch.update_ip  paysch_update_ip,
paysch.created_at  paysch_created_at,
paysch.updated_at  paysch_updated_at,
paysch.persons_id_upd   paysch_person_id_upd,
paysch.itms_id   paysch_itm_id,
paysch.price  paysch_price,
paysch.sno  paysch_sno,
paysch.duedate  paysch_duedate,
paysch.isudate  paysch_isudate,
paysch.contents  paysch_contents,
paysch.tax  paysch_tax,
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
paysch.contract_price  paysch_contract_price,
paysch.chrgs_id   paysch_chrg_id,
paysch.itm_code_client  paysch_itm_code_client,
paysch.suppliers_id   paysch_supplier_id,
paysch.payments_id_pay   paysch_payment_id_pay,
  payment_pay.payment_chrg_id_payment  payment_chrg_id_payment_pay ,
  payment_pay.loca_code_payment  loca_code_payment_pay ,
  payment_pay.loca_name_payment  loca_name_payment_pay ,
  payment_pay.person_code_chrg_payment  person_code_chrg_payment_pay ,
  payment_pay.person_name_chrg_payment  person_name_chrg_payment_pay ,
  payment_pay.person_sect_id_chrg_payment  person_sect_id_chrg_payment_pay ,
  payment_pay.payment_loca_id_payment  payment_loca_id_payment_pay ,
  payment_pay.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment_pay ,
paysch.qty_sch  paysch_qty_sch,
  supplier.crr_code_payment  crr_code_payment ,
  supplier.crr_name_payment  crr_name_payment ,
  payment_pay.crr_code_payment  crr_code_payment_pay ,
  payment_pay.crr_name_payment  crr_name_payment_pay ,
paysch.amt_sch  paysch_amt_sch
 from payschs   paysch,
  r_persons  person_upd ,  r_itms  itm ,  r_chrgs  chrg ,  r_suppliers  supplier ,  r_payments  payment_pay 
  where       paysch.persons_id_upd = person_upd.id      and paysch.itms_id = itm.id      and paysch.chrgs_id = chrg.id      and paysch.suppliers_id = supplier.id      and paysch.payments_id_pay = payment_pay.id     ;
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
,person_code_chrg  varchar (50) 
,itm_name  varchar (100) 
,itm_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,person_name_chrg  varchar (100) 
,loca_code_supplier  varchar (50) 
,crr_code_supplier  varchar (50) 
,crr_name_supplier  varchar (100) 
,person_name_chrg_supplier  varchar (100) 
,loca_code_payment  varchar (50) 
,loca_name_payment  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,person_code_chrg_supplier  varchar (50) 
,loca_name_supplier  varchar (100) 
,person_code_chrg_payment  varchar (50) 
,person_name_chrg_payment  varchar (100) 
,person_name_chrg_payment_pay  varchar (100) 
,person_code_chrg_payment_pay  varchar (50) 
,loca_name_payment_pay  varchar (100) 
,loca_code_payment_pay  varchar (50) 
,paysch_tax  numeric (38,4)
,paysch_duedate   timestamp(6) 
,paysch_isudate   timestamp(6) 
,paysch_itm_code_client  varchar (50) 
,paysch_contract_price  varchar (1) 
,paysch_price  numeric (38,4)
,paysch_expiredate   date 
,crr_code_payment  varchar (50) 
,crr_code_payment_pay  varchar (50) 
,crr_name_payment  varchar (100) 
,crr_name_payment_pay  varchar (100) 
,paysch_amt_sch  numeric (38,4)
,paysch_qty_sch  numeric (22,6)
,paysch_contents  varchar (4000) 
,paysch_remark  varchar (4000) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,paysch_person_id_upd  numeric (38,0)
,paysch_chrg_id  numeric (38,0)
,paysch_updated_at   timestamp(6) 
,paysch_supplier_id  numeric (22,0)
,id  numeric (38,0)
,paysch_itm_id  numeric (38,0)
,paysch_payment_id_pay  numeric (22,0)
,paysch_created_at   timestamp(6) 
,paysch_update_ip  varchar (40) 
,paysch_id  numeric (38,0)
,chrg_person_id_chrg_payment_pay  numeric (38,0)
,itm_unit_id  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
,supplier_payment_id  numeric (38,0)
,payment_chrg_id_payment  numeric (22,0)
,payment_loca_id_payment  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,payment_chrg_id_payment_pay  numeric (22,0)
,person_sect_id_chrg_payment_pay  numeric (22,0)
,payment_loca_id_payment_pay  numeric (38,0)
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
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  cust.loca_name_cust  loca_name_cust ,
  cust.loca_code_cust  loca_code_cust ,
custsch.id id,
  cust.cust_loca_id_cust  cust_loca_id_cust ,
  prjno.prjno_name  prjno_name ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
custsch.cno  custsch_cno,
custsch.isudate  custsch_isudate,
custsch.prjnos_id   custsch_prjno_id,
custsch.expiredate  custsch_expiredate,
custsch.updated_at  custsch_updated_at,
custsch.sno  custsch_sno,
custsch.price  custsch_price,
custsch.remark  custsch_remark,
custsch.created_at  custsch_created_at,
custsch.update_ip  custsch_update_ip,
custsch.duedate  custsch_duedate,
custsch.id  custsch_id,
custsch.persons_id_upd   custsch_person_id_upd,
custsch.contents  custsch_contents,
custsch.custs_id   custsch_cust_id,
custsch.contract_price  custsch_contract_price,
  cust.cust_chrg_id_cust  cust_chrg_id_cust ,
  cust.chrg_person_id_chrg_cust  chrg_person_id_chrg_cust ,
  cust.person_code_chrg_cust  person_code_chrg_cust ,
  cust.person_name_chrg_cust  person_name_chrg_cust ,
  cust.person_sect_id_chrg_cust  person_sect_id_chrg_cust ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  cust.bill_loca_id_bill  bill_loca_id_bill ,
  cust.loca_code_bill  loca_code_bill ,
  cust.loca_name_bill  loca_name_bill ,
  cust.cust_bill_id  cust_bill_id ,
  cust.crr_name_cust  crr_name_cust ,
  cust.cust_crr_id_cust  cust_crr_id_cust ,
  cust.crr_code_cust  crr_code_cust ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  prjno.prjno_code_chil  prjno_code_chil ,
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
custsch.opeitms_id   custsch_opeitm_id,
  cust.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  cust.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  cust.bill_crr_id_bill  bill_crr_id_bill ,
  cust.crr_code_bill  crr_code_bill ,
  cust.crr_name_bill  crr_name_bill ,
custsch.starttime  custsch_starttime,
custsch.qty_sch  custsch_qty_sch,
custsch.shelfnos_id_fm   custsch_shelfno_id_fm,
custsch.amt_sch  custsch_amt_sch,
  prjno.prjno_name_chil  prjno_name_chil ,
  opeitm.opeitm_loca_id_opeitm  opeitm_loca_id_opeitm ,
  opeitm.loca_code_opeitm  loca_code_opeitm ,
  opeitm.loca_name_opeitm  loca_name_opeitm 
 from custschs   custsch,
  r_prjnos  prjno ,  r_persons  person_upd ,  r_custs  cust ,  r_opeitms  opeitm ,  r_shelfnos  shelfno_fm 
  where       custsch.prjnos_id = prjno.id      and custsch.persons_id_upd = person_upd.id      and custsch.custs_id = cust.id      and custsch.opeitms_id = opeitm.id      and custsch.shelfnos_id_fm = shelfno_fm.id     ;
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
,custsch_isudate   timestamp(6) 
,custsch_cno  varchar (40) 
,person_code_upd  varchar (50) 
,itm_code  varchar (50) 
,person_name_upd  varchar (100) 
,itm_name  varchar (100) 
,loca_code_cust  varchar (50) 
,loca_name_cust  varchar (100) 
,custsch_duedate   timestamp(6) 
,custsch_price  numeric (38,4)
,custsch_contract_price  varchar (1) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,person_code_chrg_cust  varchar (50) 
,boxe_code  varchar (50) 
,classlist_code  varchar (50) 
,person_name_chrg_cust  varchar (100) 
,person_code_chrg_bill  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,shelfno_code  varchar (50) 
,prjno_code_chil  varchar (50) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,loca_code_bill  varchar (50) 
,custsch_expiredate   date 
,boxe_name  varchar (100) 
,classlist_name  varchar (100) 
,loca_code_opeitm  varchar (50) 
,crr_code_cust  varchar (50) 
,shelfno_code_fm  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,crr_code_bill  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,loca_name_opeitm  varchar (100) 
,prjno_name_chil  varchar (100) 
,crr_name_bill  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_bill  varchar (100) 
,shelfno_name_fm  varchar (100) 
,crr_name_cust  varchar (100) 
,custsch_shelfno_id_fm  numeric (22,0)
,custsch_amt_sch  numeric (38,4)
,custsch_qty_sch  numeric (22,6)
,cust_crr_id_cust  numeric (38,0)
,opeitm_priority  numeric (3,0)
,custsch_sno  varchar (40) 
,custsch_starttime   timestamp(6) 
,custsch_remark  varchar (4000) 
,custsch_contents  varchar (4000) 
,shelfno_name  varchar (100) 
,chrg_person_id_chrg_bill  numeric (38,0)
,itm_unit_id  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,id  numeric (38,0)
,cust_loca_id_cust  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,custsch_prjno_id  numeric (38,0)
,custsch_updated_at   timestamp(6) 
,custsch_created_at   timestamp(6) 
,custsch_update_ip  varchar (40) 
,custsch_id  numeric (38,0)
,custsch_person_id_upd  numeric (38,0)
,custsch_cust_id  numeric (38,0)
,cust_chrg_id_cust  numeric (38,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,person_sect_id_chrg_cust  numeric (22,0)
,bill_loca_id_bill  numeric (38,0)
,cust_bill_id  numeric (38,0)
,boxe_unit_id_box  numeric (22,0)
,boxe_unit_id_outbox  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,bill_chrg_id_bill  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,custsch_opeitm_id  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,opeitm_loca_id_opeitm  numeric (22,0)
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
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
prdsch.id id,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
prdsch.id  prdsch_id,
prdsch.remark  prdsch_remark,
prdsch.expiredate  prdsch_expiredate,
prdsch.update_ip  prdsch_update_ip,
prdsch.created_at  prdsch_created_at,
prdsch.updated_at  prdsch_updated_at,
prdsch.persons_id_upd   prdsch_person_id_upd,
prdsch.sno  prdsch_sno,
prdsch.duedate  prdsch_duedate,
prdsch.toduedate  prdsch_toduedate,
prdsch.isudate  prdsch_isudate,
prdsch.opeitms_id   prdsch_opeitm_id,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
prdsch.prjnos_id   prdsch_prjno_id,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
prdsch.chrgs_id   prdsch_chrg_id,
prdsch.starttime  prdsch_starttime,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  workplace.workplace_loca_id_workplace  workplace_loca_id_workplace ,
  workplace.loca_code_workplace  loca_code_workplace ,
  workplace.loca_name_workplace  loca_name_workplace ,
prdsch.shelfnos_id_to   prdsch_shelfno_id_to,
  workplace.workplace_chrg_id_workplace  workplace_chrg_id_workplace ,
  workplace.person_code_chrg_workplace  person_code_chrg_workplace ,
  workplace.person_name_chrg_workplace  person_name_chrg_workplace ,
  workplace.person_sect_id_chrg_workplace  person_sect_id_chrg_workplace ,
  workplace.chrg_person_id_chrg_workplace  chrg_person_id_chrg_workplace ,
prdsch.workplaces_id   prdsch_workplace_id,
prdsch.qty_sch  prdsch_qty_sch,
  prjno.prjno_name_chil  prjno_name_chil ,
  opeitm.opeitm_loca_id_opeitm  opeitm_loca_id_opeitm ,
  opeitm.loca_code_opeitm  loca_code_opeitm ,
  opeitm.loca_name_opeitm  loca_name_opeitm 
 from prdschs   prdsch,
  r_persons  person_upd ,  r_opeitms  opeitm ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_shelfnos  shelfno_to ,  r_workplaces  workplace 
  where       prdsch.persons_id_upd = person_upd.id      and prdsch.opeitms_id = opeitm.id      and prdsch.prjnos_id = prjno.id      and prdsch.chrgs_id = chrg.id      and prdsch.shelfnos_id_to = shelfno_to.id      and prdsch.workplaces_id = workplace.id     ;
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
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,prdsch_duedate   timestamp(6) 
,opeitm_priority  numeric (3,0)
,loca_code_workplace  varchar (50) 
,loca_name_workplace  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,classlist_code  varchar (50) 
,unit_code  varchar (50) 
,boxe_code  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,prdsch_toduedate   timestamp(6) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,unit_name  varchar (100) 
,prdsch_expiredate   date 
,boxe_name  varchar (100) 
,classlist_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,loca_code_opeitm  varchar (50) 
,unit_code_outbox  varchar (50) 
,person_code_chrg_workplace  varchar (50) 
,unit_code_box  varchar (50) 
,unit_name_outbox  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,unit_name_case  varchar (100) 
,unit_name_box  varchar (100) 
,person_name_chrg_workplace  varchar (100) 
,prjno_name_chil  varchar (100) 
,loca_name_opeitm  varchar (100) 
,prdsch_qty_sch  numeric (22,6)
,prdsch_starttime   timestamp(6) 
,prdsch_isudate   timestamp(6) 
,prjno_code_chil  varchar (50) 
,prdsch_remark  varchar (4000) 
,prdsch_person_id_upd  numeric (38,0)
,prdsch_updated_at   timestamp(6) 
,opeitm_boxe_id  numeric (22,0)
,prdsch_chrg_id  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,prdsch_created_at   timestamp(6) 
,prdsch_update_ip  varchar (40) 
,prdsch_id  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,workplace_loca_id_workplace  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,id  numeric (38,0)
,prdsch_shelfno_id_to  numeric (38,0)
,workplace_chrg_id_workplace  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_loca_id_opeitm  numeric (22,0)
,person_sect_id_chrg_workplace  numeric (22,0)
,chrg_person_id_chrg_workplace  numeric (38,0)
,prdsch_workplace_id  numeric (22,0)
,prdsch_prjno_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,prdsch_opeitm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
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
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
pursch.id id,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
pursch.id  pursch_id,
pursch.remark  pursch_remark,
pursch.expiredate  pursch_expiredate,
pursch.update_ip  pursch_update_ip,
pursch.created_at  pursch_created_at,
pursch.updated_at  pursch_updated_at,
pursch.persons_id_upd   pursch_person_id_upd,
pursch.price  pursch_price,
pursch.sno  pursch_sno,
pursch.duedate  pursch_duedate,
pursch.toduedate  pursch_toduedate,
pursch.isudate  pursch_isudate,
pursch.tax  pursch_tax,
pursch.opeitms_id   pursch_opeitm_id,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
pursch.prjnos_id   pursch_prjno_id,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
  crr.crr_pricedecimal  crr_pricedecimal ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
pursch.chrgs_id   pursch_chrg_id,
pursch.starttime  pursch_starttime,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
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
  opeitm.itm_classlist_id  itm_classlist_id ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
pursch.suppliers_id   pursch_supplier_id,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
pursch.shelfnos_id_to   pursch_shelfno_id_to,
pursch.crrs_id   pursch_crr_id,
pursch.qty_sch  pursch_qty_sch,
  supplier.crr_code_payment  crr_code_payment ,
  supplier.crr_name_payment  crr_name_payment ,
pursch.amt_sch  pursch_amt_sch,
  prjno.prjno_name_chil  prjno_name_chil ,
  opeitm.opeitm_loca_id_opeitm  opeitm_loca_id_opeitm ,
  opeitm.loca_code_opeitm  loca_code_opeitm ,
  opeitm.loca_name_opeitm  loca_name_opeitm 
 from purschs   pursch,
  r_persons  person_upd ,  r_opeitms  opeitm ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_suppliers  supplier ,  r_shelfnos  shelfno_to ,  r_crrs  crr 
  where       pursch.persons_id_upd = person_upd.id      and pursch.opeitms_id = opeitm.id      and pursch.prjnos_id = prjno.id      and pursch.chrgs_id = chrg.id      and pursch.suppliers_id = supplier.id      and pursch.shelfnos_id_to = shelfno_to.id      and pursch.crrs_id = crr.id     ;
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
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,pursch_duedate   timestamp(6) 
,shelfno_code  varchar (50) 
,itm_code  varchar (50) 
,boxe_code  varchar (50) 
,crr_code  varchar (50) 
,classlist_code  varchar (50) 
,prjno_code  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_code_box  varchar (50) 
,unit_name_case  varchar (100) 
,unit_name_outbox  varchar (100) 
,unit_name_box  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,unit_code_case  varchar (50) 
,boxe_name  varchar (100) 
,prjno_name  varchar (100) 
,pursch_starttime   timestamp(6) 
,crr_name  varchar (100) 
,pursch_expiredate   date 
,pursch_toduedate   timestamp(6) 
,classlist_name  varchar (100) 
,pursch_isudate   timestamp(6) 
,shelfno_name  varchar (100) 
,itm_name  varchar (100) 
,person_code_chrg_supplier  varchar (50) 
,person_code_chrg  varchar (50) 
,loca_code_shelfno  varchar (50) 
,loca_code_payment  varchar (50) 
,prjno_code_chil  varchar (50) 
,person_code_chrg_payment  varchar (50) 
,loca_code_supplier  varchar (50) 
,crr_code_supplier  varchar (50) 
,shelfno_code_to  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,crr_code_payment  varchar (50) 
,loca_code_opeitm  varchar (50) 
,person_name_chrg_supplier  varchar (100) 
,crr_name_supplier  varchar (100) 
,loca_name_opeitm  varchar (100) 
,person_name_chrg_payment  varchar (100) 
,loca_name_shelfno_to  varchar (100) 
,person_name_chrg  varchar (100) 
,crr_name_payment  varchar (100) 
,loca_name_supplier  varchar (100) 
,loca_name_shelfno  varchar (100) 
,prjno_name_chil  varchar (100) 
,shelfno_name_to  varchar (100) 
,loca_name_payment  varchar (100) 
,pursch_amt_sch  numeric (38,4)
,opeitm_priority  numeric (3,0)
,pursch_qty_sch  numeric (22,6)
,pursch_tax  numeric (38,4)
,pursch_price  numeric (38,4)
,pursch_crr_id  numeric (22,0)
,crr_pricedecimal  numeric (22,0)
,pursch_remark  varchar (4000) 
,pursch_created_at   timestamp(6) 
,chrg_person_id_chrg_supplier  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,pursch_supplier_id  numeric (22,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,opeitm_loca_id_opeitm  numeric (22,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,pursch_opeitm_id  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,pursch_shelfno_id_to  numeric (38,0)
,pursch_person_id_upd  numeric (38,0)
,pursch_prjno_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,pursch_updated_at   timestamp(6) 
,payment_loca_id_payment  numeric (38,0)
,pursch_update_ip  varchar (40) 
,boxe_unit_id_box  numeric (38,0)
,pursch_id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,pursch_chrg_id  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,payment_chrg_id_payment  numeric (22,0)
,supplier_payment_id  numeric (38,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
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
 CREATE INDEX sio_r_purschs_uk1 
  ON sio.sio_r_purschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purschs_seq ;
 create sequence sio.sio_r_purschs_seq ;
  drop view if  exists r_shpschs cascade ; 
 create or replace view r_shpschs as select  
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  itm.itm_name  itm_name ,
  itm.itm_code  itm_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_unit_id  itm_unit_id ,
  transport.transport_code  transport_code ,
  transport.transport_name  transport_name ,
shpsch.id id,
shpsch.expiredate  shpsch_expiredate,
shpsch.updated_at  shpsch_updated_at,
shpsch.depdate  shpsch_depdate,
shpsch.remark  shpsch_remark,
shpsch.created_at  shpsch_created_at,
shpsch.update_ip  shpsch_update_ip,
shpsch.id  shpsch_id,
shpsch.itms_id   shpsch_itm_id,
shpsch.tax  shpsch_tax,
shpsch.locas_id_to   shpsch_loca_id_to,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to ,
shpsch.sno  shpsch_sno,
shpsch.price  shpsch_price,
shpsch.persons_id_upd   shpsch_person_id_upd,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
shpsch.isudate  shpsch_isudate,
shpsch.processseq  shpsch_processseq,
shpsch.manual  shpsch_manual,
  prjno.prjno_code  prjno_code ,
shpsch.prjnos_id   shpsch_prjno_id,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
shpsch.contract_price  shpsch_contract_price,
shpsch.chrgs_id   shpsch_chrg_id,
shpsch.qty_case  shpsch_qty_case,
  prjno.prjno_code_chil  prjno_code_chil ,
shpsch.transports_id   shpsch_transport_id,
  itm.itm_classlist_id  itm_classlist_id ,
shpsch.gno  shpsch_gno,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
shpsch.lotno  shpsch_lotno,
shpsch.packno  shpsch_packno,
shpsch.paretblname  shpsch_paretblname,
shpsch.paretblid  shpsch_paretblid,
shpsch.shelfnos_id_fm   shpsch_shelfno_id_fm,
shpsch.qty_sch  shpsch_qty_sch,
shpsch.amt_sch  shpsch_amt_sch,
  prjno.prjno_name_chil  prjno_name_chil 
 from shpschs   shpsch,
  r_itms  itm ,  r_locas  loca_to ,  r_persons  person_upd ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_transports  transport ,  r_shelfnos  shelfno_fm 
  where       shpsch.itms_id = itm.id      and shpsch.locas_id_to = loca_to.id      and shpsch.persons_id_upd = person_upd.id      and shpsch.prjnos_id = prjno.id      and shpsch.chrgs_id = chrg.id      and shpsch.transports_id = transport.id      and shpsch.shelfnos_id_fm = shelfno_fm.id     ;
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
,shpsch_isudate   timestamp(6) 
,itm_code  varchar (50) 
,person_code_upd  varchar (50) 
,itm_name  varchar (100) 
,person_name_upd  varchar (100) 
,shpsch_depdate   timestamp(6) 
,loca_code_shelfno_fm  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,shelfno_code_fm  varchar (50) 
,shelfno_name_fm  varchar (100) 
,loca_code_to  varchar (50) 
,loca_name_to  varchar (100) 
,shpsch_lotno  varchar (50) 
,shpsch_packno  varchar (10) 
,shpsch_price  numeric (38,4)
,shpsch_tax  numeric (38,4)
,transport_code  varchar (50) 
,transport_name  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,prjno_code  varchar (50) 
,classlist_code  varchar (50) 
,shpsch_sno  varchar (40) 
,shpsch_gno  varchar (40) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,shpsch_paretblname  varchar (30) 
,shpsch_processseq  numeric (38,0)
,classlist_name  varchar (100) 
,shpsch_manual  varchar (1) 
,shpsch_paretblid  numeric (38,0)
,shpsch_contract_price  varchar (1) 
,shpsch_expiredate   date 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,prjno_name_chil  varchar (100) 
,shpsch_amt_sch  numeric (38,4)
,shpsch_qty_case  numeric (38,0)
,shpsch_qty_sch  numeric (22,6)
,shpsch_remark  varchar (4000) 
,itm_unit_id  numeric (22,0)
,shpsch_shelfno_id_fm  numeric (22,0)
,shpsch_transport_id  numeric (38,0)
,shpsch_person_id_upd  numeric (38,0)
,shpsch_loca_id_to  numeric (38,0)
,shpsch_itm_id  numeric (38,0)
,shpsch_prjno_id  numeric (38,0)
,shpsch_id  numeric (38,0)
,shpsch_chrg_id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,shpsch_update_ip  varchar (40) 
,shpsch_created_at   timestamp(6) 
,shpsch_updated_at   timestamp(6) 
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,id  numeric (38,0)
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
