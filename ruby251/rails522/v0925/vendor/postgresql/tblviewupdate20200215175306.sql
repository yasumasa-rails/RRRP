
 --- drop view r_custrcvplcs cascade  
 create or replace view r_custrcvplcs as select  
  cust_custrcvplc.cust_bill_id  cust_bill_id_custrcvplc ,
  cust_custrcvplc.cust_autocreate_custact  cust_autocreate_custact_custrcvplc ,
  cust_custrcvplc.bill_chrg_id_bill  bill_chrg_id_bill_custrcvplc ,
  cust_custrcvplc.scrlv_code_chrg_cust  scrlv_code_chrg_cust_custrcvplc ,
  cust_custrcvplc.scrlv_code_chrg_bill  scrlv_code_chrg_bill_custrcvplc ,
  cust_custrcvplc.cust_loca_id_cust  cust_loca_id_cust_custrcvplc ,
  cust_custrcvplc.loca_code_cust  loca_code_cust_custrcvplc ,
  cust_custrcvplc.loca_code_sect_chrg_cust  loca_code_sect_chrg_cust_custrcvplc ,
  cust_custrcvplc.loca_code_bill  loca_code_bill_custrcvplc ,
  cust_custrcvplc.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill_custrcvplc ,
  cust_custrcvplc.loca_name_cust  loca_name_cust_custrcvplc ,
  cust_custrcvplc.loca_name_sect_chrg_cust  loca_name_sect_chrg_cust_custrcvplc ,
  cust_custrcvplc.loca_name_bill  loca_name_bill_custrcvplc ,
  cust_custrcvplc.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill_custrcvplc ,
  cust_custrcvplc.person_code_chrg_cust  person_code_chrg_cust_custrcvplc ,
  cust_custrcvplc.person_code_chrg_bill  person_code_chrg_bill_custrcvplc ,
  cust_custrcvplc.person_name_chrg_cust  person_name_chrg_cust_custrcvplc ,
  cust_custrcvplc.person_name_chrg_bill  person_name_chrg_bill_custrcvplc ,
  cust_custrcvplc.cust_contract_price  cust_contract_price_custrcvplc ,
  cust_custrcvplc.cust_rule_price  cust_rule_price_custrcvplc ,
custrcvplc.code  custrcvplc_code,
custrcvplc.name  custrcvplc_name,
custrcvplc.addr1  custrcvplc_addr1,
custrcvplc.addr2  custrcvplc_addr2,
custrcvplc.tel  custrcvplc_tel,
  cust_custrcvplc.bill_crr_id_bill  bill_crr_id_bill_custrcvplc ,
  cust_custrcvplc.usrgrp_name_chrg_cust  usrgrp_name_chrg_cust_custrcvplc ,
  cust_custrcvplc.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill_custrcvplc ,
  cust_custrcvplc.crr_code_bill  crr_code_bill_custrcvplc ,
  cust_custrcvplc.cust_personname  cust_personname_custrcvplc ,
  cust_custrcvplc.crr_name_bill  crr_name_bill_custrcvplc ,
  cust_custrcvplc.person_sect_id_chrg_cust  person_sect_id_chrg_cust_custrcvplc ,
  cust_custrcvplc.person_sect_id_chrg_bill  person_sect_id_chrg_bill_custrcvplc ,
  cust_custrcvplc.cust_chrg_id_cust  cust_chrg_id_cust_custrcvplc ,
  cust_custrcvplc.cust_amtround  cust_amtround_custrcvplc ,
  cust_custrcvplc.cust_amtdecimal  cust_amtdecimal_custrcvplc ,
  cust_custrcvplc.usrgrp_code_chrg_cust  usrgrp_code_chrg_cust_custrcvplc ,
  cust_custrcvplc.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill_custrcvplc ,
  cust_custrcvplc.cust_custtype  cust_custtype_custrcvplc ,
custrcvplc.custs_id_custrcvplc   custrcvplc_cust_id_custrcvplc,
custrcvplc.contents  custrcvplc_contents,
custrcvplc.remark  custrcvplc_remark,
custrcvplc.expiredate  custrcvplc_expiredate,
custrcvplc.persons_id_upd   custrcvplc_person_id_upd,
custrcvplc.update_ip  custrcvplc_update_ip,
custrcvplc.created_at  custrcvplc_created_at,
custrcvplc.updated_at  custrcvplc_updated_at,
  cust_custrcvplc.cust_contents  cust_contents_custrcvplc ,
custrcvplc.id  custrcvplc_id,
custrcvplc.id id,
  cust_custrcvplc.bill_loca_id_bill  bill_loca_id_bill_custrcvplc ,
  cust_custrcvplc.chrg_person_id_chrg_cust  chrg_person_id_chrg_cust_custrcvplc ,
  cust_custrcvplc.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill_custrcvplc 
 from custrcvplcs   custrcvplc,
  r_custs  cust_custrcvplc ,  r_persons  person_upd 
  where       custrcvplc.custs_id_custrcvplc = cust_custrcvplc.id      and custrcvplc.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custrcvplcs;
 CREATE TABLE sio.sio_r_custrcvplcs (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_custrcvplcs_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,custrcvplc_code  varchar (50) 
,custrcvplc_name  varchar (100) 
,custrcvplc_addr1  varchar (50) 
,custrcvplc_addr2  varchar (50) 
,custrcvplc_tel  varchar (20) 
,loca_code_bill_custrcvplc  varchar (50) 
,loca_code_sect_chrg_bill_custrcvplc  varchar (50) 
,loca_name_cust_custrcvplc  varchar (100) 
,loca_name_sect_chrg_cust_custrcvplc  varchar (100) 
,loca_name_sect_chrg_bill_custrcvplc  varchar (100) 
,person_code_chrg_cust_custrcvplc  varchar (50) 
,person_code_chrg_bill_custrcvplc  varchar (50) 
,person_name_chrg_cust_custrcvplc  varchar (100) 
,person_name_chrg_bill_custrcvplc  varchar (100) 
,loca_name_bill_custrcvplc  varchar (100) 
,scrlv_code_chrg_cust_custrcvplc  varchar (50) 
,scrlv_code_chrg_bill_custrcvplc  varchar (50) 
,loca_code_cust_custrcvplc  varchar (50) 
,loca_code_sect_chrg_cust_custrcvplc  varchar (50) 
,usrgrp_name_chrg_cust_custrcvplc  varchar (100) 
,usrgrp_name_chrg_bill_custrcvplc  varchar (100) 
,crr_code_bill_custrcvplc  varchar (50) 
,crr_name_bill_custrcvplc  varchar (100) 
,usrgrp_code_chrg_cust_custrcvplc  varchar (50) 
,usrgrp_code_chrg_bill_custrcvplc  varchar (50) 
,custrcvplc_expiredate   date 
,cust_custtype_custrcvplc  varchar (1) 
,cust_contents_custrcvplc  varchar (4000) 
,cust_personname_custrcvplc  varchar (30) 
,cust_autocreate_custact_custrcvplc  varchar (1) 
,cust_contract_price_custrcvplc  varchar (1) 
,cust_rule_price_custrcvplc  varchar (1) 
,cust_amtdecimal_custrcvplc  numeric (38,0)
,cust_amtround_custrcvplc  varchar (2) 
,custrcvplc_remark  varchar (4000) 
,custrcvplc_contents  varchar (4000) 
,custrcvplc_cust_id_custrcvplc  numeric (22,0)
,custrcvplc_id  numeric (38,0)
,id  numeric (38,0)
,custrcvplc_person_id_upd  numeric (38,0)
,custrcvplc_update_ip  varchar (40) 
,custrcvplc_created_at   timestamp(6) 
,custrcvplc_updated_at   timestamp(6) 
,cust_bill_id_custrcvplc  numeric (38,0)
,cust_loca_id_cust_custrcvplc  numeric (38,0)
,bill_chrg_id_bill_custrcvplc  numeric (22,0)
,bill_loca_id_bill_custrcvplc  numeric (38,0)
,person_sect_id_chrg_bill_custrcvplc  numeric (22,0)
,person_sect_id_chrg_cust_custrcvplc  numeric (22,0)
,bill_crr_id_bill_custrcvplc  numeric (22,0)
,chrg_person_id_chrg_bill_custrcvplc  numeric (38,0)
,chrg_person_id_chrg_cust_custrcvplc  numeric (38,0)
,cust_chrg_id_cust_custrcvplc  numeric (38,0)
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
 CREATE INDEX sio_r_custrcvplcs_uk1 
  ON sio.sio_r_custrcvplcs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custrcvplcs_seq ;
 create sequence sio.sio_r_custrcvplcs_seq ;
