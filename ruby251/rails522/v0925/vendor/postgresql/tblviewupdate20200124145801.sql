
 alter table custs DROP COLUMN crrs_id_cust CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'crrs_id_cust'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　crrs_id_custが削除　2020-01-24 14:57:59 +0900' 
 ---- where  pobject_code_sfd = 'crrs_id_cust'
 --- drop view r_custs cascade  
 create or replace view r_custs as select  
cust.bills_id   cust_bill_id,
cust.autocreate_custact  cust_autocreate_custact,
  bill.bill_chrg_id_bill  bill_chrg_id_bill ,
  bill.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  chrg_cust.scrlv_code_chrg  scrlv_code_chrg_cust ,
cust.id id,
cust.id  cust_id,
cust.locas_id_cust   cust_loca_id_cust,
  bill.loca_abbr_bill  loca_abbr_bill ,
  loca_cust.loca_abbr  loca_abbr_cust ,
  loca_cust.loca_zip  loca_zip_cust ,
  loca_cust.loca_country  loca_country_cust ,
  loca_cust.loca_prfct  loca_prfct_cust ,
  loca_cust.loca_addr1  loca_addr1_cust ,
  loca_cust.loca_addr2  loca_addr2_cust ,
  bill.loca_tel_bill  loca_tel_bill ,
  loca_cust.loca_tel  loca_tel_cust ,
  loca_cust.loca_fax  loca_fax_cust ,
  loca_cust.loca_mail  loca_mail_cust ,
  bill.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  bill.loca_code_bill  loca_code_bill ,
  chrg_cust.loca_code_sect_chrg  loca_code_sect_chrg_cust ,
  loca_cust.loca_code  loca_code_cust ,
  bill.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  bill.loca_name_bill  loca_name_bill ,
  chrg_cust.loca_name_sect_chrg  loca_name_sect_chrg_cust ,
  loca_cust.loca_name  loca_name_cust ,
cust.updated_at  cust_updated_at,
  bill.person_code_chrg_bill  person_code_chrg_bill ,
  chrg_cust.person_code_chrg  person_code_chrg_cust ,
  bill.person_name_chrg_bill  person_name_chrg_bill ,
  chrg_cust.person_name_chrg  person_name_chrg_cust ,
  chrg_cust.person_email_chrg  person_email_chrg_cust ,
  chrg_cust.scrlv_level1_chrg  scrlv_level1_chrg_cust ,
cust.contract_price  cust_contract_price,
cust.rule_price  cust_rule_price,
  bill.bill_crr_id_bill  bill_crr_id_bill ,
  bill.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  chrg_cust.usrgrp_name_chrg  usrgrp_name_chrg_cust ,
  bill.crr_code_bill  crr_code_bill ,
cust.personname  cust_personname,
  bill.bill_contents  bill_contents ,
  bill.crr_name_bill  crr_name_bill ,
  bill.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  chrg_cust.person_sect_id_chrg  person_sect_id_chrg_cust ,
cust.chrgs_id_cust   cust_chrg_id_cust,
cust.amtround  cust_amtround,
cust.amtdecimal  cust_amtdecimal,
  bill.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  chrg_cust.usrgrp_code_chrg  usrgrp_code_chrg_cust ,
cust.created_at  cust_created_at,
cust.remark  cust_remark,
cust.custtype  cust_custtype,
cust.expiredate  cust_expiredate,
cust.persons_id_upd   cust_person_id_upd,
cust.update_ip  cust_update_ip,
cust.contents  cust_contents,
  bill.bill_loca_id_bill  bill_loca_id_bill ,
  bill.bill_personname  bill_personname ,
  bill.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  chrg_cust.chrg_person_id_chrg  chrg_person_id_chrg_cust 
 from custs   cust,
  r_bills  bill ,  r_locas  loca_cust ,  r_chrgs  chrg_cust ,  r_persons  person_upd 
  where       cust.bills_id = bill.id      and cust.locas_id_cust = loca_cust.id      and cust.chrgs_id_cust = chrg_cust.id      and cust.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custs;
 CREATE TABLE sio.sio_r_custs (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_custs_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,loca_code_cust  varchar (50) 
,loca_name_cust  varchar (100) 
,person_code_chrg_cust  varchar (50) 
,person_name_chrg_cust  varchar (100) 
,scrlv_code_chrg_cust  varchar (50) 
,loca_code_sect_chrg_cust  varchar (50) 
,loca_name_sect_chrg_cust  varchar (100) 
,usrgrp_code_chrg_cust  varchar (50) 
,usrgrp_name_chrg_cust  varchar (100) 
,loca_code_bill  varchar (50) 
,loca_name_bill  varchar (100) 
,person_code_chrg_bill  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,usrgrp_name_chrg_bill  varchar (100) 
,crr_name_bill  varchar (100) 
,crr_code_bill  varchar (50) 
,cust_amtround  varchar (2) 
,cust_autocreate_custact  varchar (1) 
,cust_contract_price  varchar (1) 
,cust_rule_price  varchar (1) 
,cust_personname  varchar (30) 
,cust_amtdecimal  numeric (38,0)
,cust_custtype  varchar (1) 
,cust_expiredate   date 
,loca_tel_cust  varchar (20) 
,scrlv_level1_chrg_cust  varchar (1) 
,bill_personname  varchar (30) 
,loca_prfct_cust  varchar (20) 
,loca_fax_cust  varchar (20) 
,loca_tel_bill  varchar (20) 
,person_email_chrg_cust  varchar (50) 
,loca_mail_cust  varchar (20) 
,loca_addr1_cust  varchar (50) 
,loca_abbr_cust  varchar (50) 
,loca_abbr_bill  varchar (50) 
,loca_country_cust  varchar (20) 
,loca_addr2_cust  varchar (50) 
,bill_contents  varchar (4000) 
,loca_zip_cust  varchar (10) 
,cust_contents  varchar (4000) 
,cust_remark  varchar (4000) 
,cust_updated_at   timestamp(6) 
,cust_update_ip  varchar (40) 
,cust_loca_id_cust  numeric (38,0)
,cust_id  numeric (38,0)
,cust_chrg_id_cust  numeric (38,0)
,cust_bill_id  numeric (38,0)
,id  numeric (38,0)
,cust_created_at   timestamp(6) 
,cust_person_id_upd  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,bill_chrg_id_bill  numeric (22,0)
,person_sect_id_chrg_cust  numeric (22,0)
,person_sect_id_chrg_bill  numeric (22,0)
,bill_loca_id_bill  numeric (38,0)
,chrg_person_id_chrg_cust  numeric (38,0)
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
 CREATE INDEX sio_r_custs_uk1 
  ON sio.sio_r_custs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custs_seq ;
 create sequence sio.sio_r_custs_seq ;
