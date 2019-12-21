
 --- drop view r_payments cascade  
 create or replace view r_payments as select  
payment.chrgs_id_payment   payment_chrg_id_payment,
  chrg_payment.chrg_person_id  chrg_person_id_payment ,
  chrg_payment.loca_id_sect  loca_id_sect_payment ,
  chrg_payment.person_code_chrg  person_code_chrg_payment ,
  chrg_payment.usrgrp_name_chrg  usrgrp_name_chrg_payment ,
  chrg_payment.usrgrp_code_chrg  usrgrp_code_chrg_payment ,
  chrg_payment.loca_code_sect  loca_code_sect_payment ,
  chrg_payment.loca_name_sect  loca_name_sect_payment ,
  chrg_payment.person_name_chrg  person_name_chrg_payment ,
  loca_payment.loca_mail  loca_mail_payment ,
payment.id  payment_id,
  loca_payment.loca_id  loca_id_payment ,
payment.id id,
payment.persons_id_upd   payment_person_id_upd,
payment.locas_id_payment   payment_loca_id_payment,
payment.contents  payment_contents,
payment.remark  payment_remark,
payment.created_at  payment_created_at,
payment.updated_at  payment_updated_at,
  loca_payment.loca_fax  loca_fax_payment ,
  loca_payment.loca_abbr  loca_abbr_payment ,
  loca_payment.loca_addr1  loca_addr1_payment ,
  loca_payment.loca_addr2  loca_addr2_payment ,
  loca_payment.loca_tel  loca_tel_payment ,
payment.expiredate  payment_expiredate,
payment.update_ip  payment_update_ip,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  loca_payment.loca_code  loca_code_payment ,
payment.personname  payment_personname,
  loca_payment.loca_name  loca_name_payment ,
  loca_payment.loca_zip  loca_zip_payment ,
  loca_payment.loca_country  loca_country_payment ,
  loca_payment.loca_prfct  loca_prfct_payment 
 from payments   payment,
  r_chrgs  chrg_payment ,  r_persons  person_upd ,  r_locas  loca_payment 
  where       payment.chrgs_id_payment = chrg_payment.id      and payment.persons_id_upd = person_upd.id      and payment.locas_id_payment = loca_payment.id     ;
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
,payment_contents  varchar (4000) 
,payment_remark  varchar (4000) 
,payment_expiredate   date 
,usrgrp_name_chrg_payment  varchar (100) 
,usrgrp_code_chrg_payment  varchar (50) 
,loca_code_sect_payment  varchar (50) 
,loca_name_sect_payment  varchar (100) 
,person_name_chrg_payment  varchar (100) 
,person_code_chrg_payment  varchar (50) 
,loca_code_payment  varchar (50) 
,loca_name_payment  varchar (100) 
,payment_personname  varchar (30) 
,payment_chrg_id_payment  numeric (22,0)
,loca_id_sect_payment  numeric (22,0)
,chrg_person_id_payment  numeric (22,0)
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,loca_zip_payment  varchar (10) 
,loca_country_payment  varchar (20) 
,loca_prfct_payment  varchar (20) 
,loca_mail_payment  varchar (20) 
,payment_id  numeric (22,0)
,loca_id_payment  numeric (22,0)
,id  numeric (22,0)
,payment_person_id_upd  numeric (22,0)
,payment_loca_id_payment  numeric (22,0)
,payment_created_at   timestamp(6) 
,payment_updated_at   timestamp(6) 
,loca_fax_payment  varchar (20) 
,loca_abbr_payment  varchar (50) 
,loca_addr1_payment  varchar (50) 
,loca_addr2_payment  varchar (50) 
,loca_tel_payment  varchar (20) 
,payment_update_ip  varchar (40) 
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
