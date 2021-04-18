
  drop view if  exists r_bills cascade ; 
 create or replace view r_bills as select  
bill.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
bill.personname  bill_personname,
bill.locas_id_bill   bill_loca_id_bill,
  loca_bill.loca_code  loca_code_bill ,
  loca_bill.loca_name  loca_name_bill ,
  loca_bill.loca_abbr  loca_abbr_bill ,
  loca_bill.loca_tel  loca_tel_bill ,
bill.contents  bill_contents,
bill.id  bill_id,
bill.remark  bill_remark,
bill.expiredate  bill_expiredate,
bill.update_ip  bill_update_ip,
bill.created_at  bill_created_at,
bill.updated_at  bill_updated_at,
bill.persons_id_upd   bill_person_id_upd,
bill.chrgs_id_bill   bill_chrg_id_bill,
  chrg_bill.person_code_chrg  person_code_chrg_bill ,
  chrg_bill.usrgrp_name_chrg  usrgrp_name_chrg_bill ,
  chrg_bill.usrgrp_code_chrg  usrgrp_code_chrg_bill ,
  chrg_bill.person_name_chrg  person_name_chrg_bill ,
  chrg_bill.scrlv_code_chrg  scrlv_code_chrg_bill ,
  chrg_bill.loca_code_sect_chrg  loca_code_sect_chrg_bill ,
  chrg_bill.loca_name_sect_chrg  loca_name_sect_chrg_bill ,
  chrg_bill.person_sect_id_chrg  person_sect_id_chrg_bill ,
  chrg_bill.chrg_person_id_chrg  chrg_person_id_chrg_bill ,
bill.crrs_id_bill   bill_crr_id_bill,
  crr_bill.crr_code  crr_code_bill ,
  crr_bill.crr_name  crr_name_bill 
 from bills   bill,
  r_locas  loca_bill ,  r_persons  person_upd ,  r_chrgs  chrg_bill ,  r_crrs  crr_bill 
  where       bill.locas_id_bill = loca_bill.id      and bill.persons_id_upd = person_upd.id      and bill.chrgs_id_bill = chrg_bill.id      and bill.crrs_id_bill = crr_bill.id     ;
 DROP TABLE IF EXISTS sio.sio_r_bills;
 CREATE TABLE sio.sio_r_bills (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_bills_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,loca_abbr_bill  varchar (50) 
,person_code_chrg_bill  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,usrgrp_name_chrg_bill  varchar (100) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,bill_personname  varchar (30) 
,crr_code_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,bill_contents  varchar (4000) 
,bill_expiredate   date 
,bill_remark  varchar (4000) 
,loca_tel_bill  varchar (20) 
,bill_updated_at   timestamp(6) 
,bill_loca_id_bill  numeric (38,0)
,bill_id  numeric (38,0)
,bill_update_ip  varchar (40) 
,bill_created_at   timestamp(6) 
,id  numeric (38,0)
,bill_person_id_upd  numeric (38,0)
,bill_chrg_id_bill  numeric (22,0)
,bill_crr_id_bill  numeric (22,0)
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
 CREATE INDEX sio_r_bills_uk1 
  ON sio.sio_r_bills(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_bills_seq ;
 create sequence sio.sio_r_bills_seq ;
