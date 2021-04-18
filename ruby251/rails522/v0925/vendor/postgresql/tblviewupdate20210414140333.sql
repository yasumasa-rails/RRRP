
 alter table  billschs  ADD COLUMN processseq numeric(38,0) ;

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
,loca_code_bill  varchar (50) 
,loca_name_bill  varchar (100) 
,itm_code  varchar (50) 
,person_code_upd  varchar (50) 
,itm_name  varchar (100) 
,person_name_upd  varchar (100) 
,person_code_chrg_bill  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,usrgrp_name_chrg_bill  varchar (100) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,crr_code_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,billsch_processseq  numeric (38,0)
,billsch_saledate   timestamp(6) 
,billsch_price  numeric (38,4)
,billsch_sno  varchar (40) 
,billsch_duedate   timestamp(6) 
,billsch_isudate   timestamp(6) 
,billsch_tax  numeric (38,4)
,billsch_qty_sch  numeric (22,6)
,billsch_amt_sch  numeric (38,4)
,billsch_expiredate   date 
,billsch_remark  varchar (4000) 
,billsch_contents  varchar (4000) 
,itm_code  varchar (50) 
,billsch_qty  numeric (18,4)
,billsch_price  numeric (22,0)
,billsch_saledate   timestamp(6) 
,billsch_isudate   timestamp(6) 
,billsch_remark  varchar (4000) 
,billsch_amt  numeric (18,4)
,billsch_contents  varchar (4000) 
,billsch_sno  varchar (40) 
,billsch_duedate   timestamp(6) 
,billsch_tblname  varchar (30) 
,billsch_expiredate   date 
,billsch_tblid  numeric (22,0)
,itm_name  varchar (100) 
,billsch_tax  numeric (22,0)
,billsch_update_ip  varchar (40) 
,billsch_updated_at   timestamp(6) 
,billsch_itm_id  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,billsch_bill_id  numeric (38,0)
,bill_chrg_id_bill  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,bill_loca_id_bill  numeric (38,0)
,billsch_created_at   timestamp(6) 
,person_sect_id_chrg_bill  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,billsch_person_id_upd  numeric (22,0)
,billsch_bill_id  numeric (22,0)
,loca_code_to_bill  varchar (50) 
,loca_name_to_bill  varchar (100) 
,itm_datascale  numeric (22,0)
,loca_name_bill  varchar (100) 
,loca_code_bill  varchar (50) 
,person_name_upd  varchar (100) 
,itm_unit_id  numeric (22,0)
,person_code_upd  varchar (50) 
,id  numeric (22,0)
,itm_id  numeric (22,0)
,itm_unit_id  numeric (22,0)
,itm_material  varchar (50) 
,itm_weight  numeric (7,2)
,billsch_person_id_upd  numeric (22,0)
,itm_deth  numeric (22,0)
,itm_model  varchar (50) 
,itm_length  numeric (22,0)
,unit_code  varchar (50) 
,itm_wide  numeric (7,2)
,unit_name  varchar (100) 
,itm_std  varchar (50) 
,itm_design  varchar (50) 
,billsch_id  numeric (22,0)
,billsch_itm_id  numeric (22,0)
,billsch_update_ip  varchar (40) 
,billsch_created_at   timestamp(6) 
,billsch_updated_at   timestamp(6) 
,id  numeric (38,0)
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
