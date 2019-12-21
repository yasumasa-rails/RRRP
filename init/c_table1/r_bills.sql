
 --- drop view r_bills cascade  
 create or replace view r_bills as select  
bill.remark  bill_remark,
bill.created_at  bill_created_at,
bill.update_ip  bill_update_ip,
bill.expiredate  bill_expiredate,
bill.updated_at  bill_updated_at,
bill.id id,
bill.id  bill_id,
bill.persons_id_upd   bill_person_id_upd,
bill.contents  bill_contents,
bill.personname  bill_personname,
bill.locas_id_bill   bill_loca_id_bill,
  loca_bill.loca_country  loca_country_bill ,
  loca_bill.loca_abbr  loca_abbr_bill ,
  loca_bill.loca_prfct  loca_prfct_bill ,
  loca_bill.loca_tel  loca_tel_bill ,
  loca_bill.loca_mail  loca_mail_bill ,
  loca_bill.loca_addr1  loca_addr1_bill ,
  loca_bill.loca_zip  loca_zip_bill ,
  loca_bill.loca_fax  loca_fax_bill ,
  loca_bill.loca_addr2  loca_addr2_bill ,
  loca_bill.loca_name  loca_name_bill ,
  loca_bill.loca_code  loca_code_bill ,
bill.chrgs_id_bill   bill_chrg_id_bill,
  chrg_bill.chrg_person_id  chrg_person_id_bill ,
  chrg_bill.loca_id_sect  loca_id_sect_bill ,
  chrg_bill.person_code_chrg  person_code_chrg_bill ,
  chrg_bill.usrgrp_name_chrg  usrgrp_name_chrg_bill ,
  chrg_bill.usrgrp_code_chrg  usrgrp_code_chrg_bill ,
  chrg_bill.loca_code_sect  loca_code_sect_bill ,
  chrg_bill.loca_name_sect  loca_name_sect_bill ,
  chrg_bill.person_name_chrg  person_name_chrg_bill 
 from bills   bill,
  r_persons  person_upd ,  r_locas  loca_bill ,  r_chrgs  chrg_bill 
  where       bill.persons_id_upd = person_upd.id      and bill.locas_id_bill = loca_bill.id      and bill.chrgs_id_bill = chrg_bill.id     ;
 DROP TABLE IF EXISTS sio.sio_r_bills;
 CREATE TABLE sio.sio_r_bills (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_bills_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,loca_code_bill  varchar (50) 
,loca_name_bill  varchar (100) 
,loca_name_sect_bill  varchar (100) 
,loca_code_sect_bill  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,person_code_chrg_bill  varchar (50) 
,usrgrp_name_chrg_bill  varchar (100) 
,person_name_chrg_bill  varchar (100) 
,bill_personname  varchar (30) 
,loca_country_bill  varchar (20) 
,loca_zip_bill  varchar (10) 
,loca_addr1_bill  varchar (50) 
,loca_addr2_bill  varchar (50) 
,loca_prfct_bill  varchar (20) 
,loca_abbr_bill  varchar (50) 
,bill_contents  varchar (4000) 
,loca_fax_bill  varchar (20) 
,loca_mail_bill  varchar (20) 
,bill_remark  varchar (4000) 
,bill_expiredate   date 
,loca_tel_bill  varchar (20) 
,bill_chrg_id_bill  numeric (22,0)
,bill_id  numeric (38,0)
,id  numeric (38,0)
,bill_updated_at   timestamp(6) 
,bill_created_at   timestamp(6) 
,bill_loca_id_bill  numeric (38,0)
,bill_person_id_upd  numeric (38,0)
,bill_update_ip  varchar (40) 
,chrg_person_id_bill  numeric (22,0)
,loca_id_sect_bill  numeric (22,0)
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
 CREATE INDEX sio_r_bills_uk1 
  ON sio.sio_r_bills(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_bills_seq ;
 create sequence sio.sio_r_bills_seq ;
