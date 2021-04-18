
  drop view if  exists r_billschs cascade ; 
 create or replace view r_billschs as select  
  .itm_model  itm_model ,
  .itm_deth  itm_deth ,
  .itm_name  itm_name ,
  .itm_design  itm_design ,
  .itm_std  itm_std ,
  .itm_code  itm_code ,
  .unit_name  unit_name ,
  .itm_wide  itm_wide ,
  .unit_code  unit_code ,
  .itm_length  itm_length ,
  .itm_weight  itm_weight ,
  .itm_material  itm_material ,
  .itm_unit_id  itm_unit_id ,
billsch.id id,
  .person_code_upd  person_code_upd ,
  .person_name_upd  person_name_upd ,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
  .loca_code_bill  loca_code_bill ,
  .loca_name_bill  loca_name_bill ,
  .itm_datascale  itm_datascale ,
billsch.saledate  billsch_saledate,
billsch.id  billsch_id,
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
  bill.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  bill.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  bill.person_name_chrg_bill  person_name_chrg_bill ,
  itm.itm_classlist_id  itm_classlist_id ,
  bill.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  bill.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  bill.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
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
,classlist_name  varchar (100) 
,person_code_chrg_bill  varchar (50) 
,crr_code_bill  varchar (50) 
,loca_code_sect_chrg_bill  varchar (50) 
,scrlv_code_chrg_bill  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,person_name_chrg_bill  varchar (100) 
,crr_name_bill  varchar (100) 
,usrgrp_name_chrg_bill  varchar (100) 
,billsch_amt_sch  numeric (38,4)
,billsch_qty_sch  numeric (22,6)
,billsch_processseq  numeric (38,0)
,billsch_saledate   timestamp(6) 
,itm_name  varchar (100) 
,itm_code  varchar (50) 
,billsch_remark  varchar (4000) 
,billsch_expiredate   date 
,billsch_price  numeric (22,0)
,billsch_sno  varchar (40) 
,billsch_duedate   timestamp(6) 
,billsch_isudate   timestamp(6) 
,billsch_contents  varchar (4000) 
,billsch_tax  numeric (22,0)
,bill_crr_id_bill  numeric (22,0)
,bill_chrg_id_bill  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,itm_wide  numeric (7,2)
,unit_name  varchar (100) 
,itm_std  varchar (50) 
,itm_design  varchar (50) 
,itm_deth  numeric (22,0)
,billsch_bill_id  numeric (22,0)
,person_code_upd  varchar (50) 
,billsch_update_ip  varchar (40) 
,itm_unit_id  numeric (22,0)
,itm_material  varchar (50) 
,itm_weight  numeric (7,2)
,itm_length  numeric (22,0)
,unit_code  varchar (50) 
,person_name_upd  varchar (100) 
,loca_code_bill  varchar (50) 
,loca_name_bill  varchar (100) 
,itm_datascale  numeric (22,0)
,itm_model  varchar (50) 
,billsch_id  numeric (22,0)
,id  numeric (22,0)
,billsch_created_at   timestamp(6) 
,billsch_updated_at   timestamp(6) 
,billsch_person_id_upd  numeric (22,0)
,billsch_itm_id  numeric (22,0)
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
