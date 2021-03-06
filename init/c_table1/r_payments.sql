﻿
 --- drop view r_payments cascade  
 create or replace view r_payments as select  
  chrg_payment.scrlv_code_chrg  scrlv_code_chrg_payment ,
payment.chrgs_id_payment   payment_chrg_id_payment,
  loca_payment.loca_abbr  loca_abbr_payment ,
  loca_payment.loca_zip  loca_zip_payment ,
  loca_payment.loca_country  loca_country_payment ,
  loca_payment.loca_prfct  loca_prfct_payment ,
  loca_payment.loca_addr1  loca_addr1_payment ,
  loca_payment.loca_addr2  loca_addr2_payment ,
  loca_payment.loca_tel  loca_tel_payment ,
  loca_payment.loca_fax  loca_fax_payment ,
  loca_payment.loca_mail  loca_mail_payment ,
  chrg_payment.loca_code_sect_chrg  loca_code_sect_chrg_payment ,
  loca_payment.loca_code  loca_code_payment ,
  chrg_payment.loca_name_sect_chrg  loca_name_sect_chrg_payment ,
  loca_payment.loca_name  loca_name_payment ,
  chrg_payment.person_code_chrg  person_code_chrg_payment ,
  chrg_payment.person_name_chrg  person_name_chrg_payment ,
  chrg_payment.person_email_chrg  person_email_chrg_payment ,
  chrg_payment.scrlv_level1_chrg  scrlv_level1_chrg_payment ,
payment.id  payment_id,
payment.id id,
  chrg_payment.usrgrp_name_chrg  usrgrp_name_chrg_payment ,
  chrg_payment.person_sect_id_chrg  person_sect_id_chrg_payment ,
  chrg_payment.usrgrp_code_chrg  usrgrp_code_chrg_payment ,
payment.locas_id_payment   payment_loca_id_payment,
payment.expiredate  payment_expiredate,
payment.updated_at  payment_updated_at,
payment.remark  payment_remark,
payment.created_at  payment_created_at,
payment.update_ip  payment_update_ip,
payment.persons_id_upd   payment_person_id_upd,
payment.contents  payment_contents,
payment.personname  payment_personname,
  chrg_payment.chrg_person_id_chrg  chrg_person_id_chrg_payment 
 from payments   payment,
  r_chrgs  chrg_payment ,  r_locas  loca_payment ,  r_persons  person_upd 
  where       payment.chrgs_id_payment = chrg_payment.id      and payment.locas_id_payment = loca_payment.id      and payment.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_payments;
 CREATE TABLE sio.sio_r_payments (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_payments_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,usrgrp_name_chrg_payment  varchar (100) 
,loca_code_payment  varchar (50) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_name_payment  varchar (100) 
,person_code_chrg_payment  varchar (50) 
,person_name_chrg_payment  varchar (100) 
,scrlv_code_chrg_payment  varchar (50) 
,usrgrp_code_chrg_payment  varchar (50) 
,loca_code_sect_chrg_payment  varchar (50) 
,payment_personname  varchar (30) 
,payment_expiredate   date 
,person_email_chrg_payment  varchar (50) 
,loca_abbr_payment  varchar (50) 
,loca_zip_payment  varchar (10) 
,loca_country_payment  varchar (20) 
,loca_prfct_payment  varchar (20) 
,loca_addr1_payment  varchar (50) 
,loca_addr2_payment  varchar (50) 
,loca_tel_payment  varchar (20) 
,loca_fax_payment  varchar (20) 
,loca_mail_payment  varchar (20) 
,scrlv_level1_chrg_payment  varchar (1) 
,payment_contents  varchar (4000) 
,payment_remark  varchar (4000) 
,payment_loca_id_payment  numeric (38,0)
,payment_id  numeric (38,0)
,payment_updated_at   timestamp(6) 
,payment_chrg_id_payment  numeric (22,0)
,payment_created_at   timestamp(6) 
,payment_update_ip  varchar (40) 
,payment_person_id_upd  numeric (38,0)
,id  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,person_sect_id_chrg_payment  numeric (22,0)
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
 CREATE INDEX sio_r_payments_uk1 
  ON sio.sio_r_payments(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_payments_seq ;
 create sequence sio.sio_r_payments_seq ;
