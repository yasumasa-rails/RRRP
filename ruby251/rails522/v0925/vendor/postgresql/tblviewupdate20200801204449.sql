
 create table pricemsts (
 id numeric(38,0 )   not null  ,
 tblname varchar(30)   ,
 expiredate date  ,
 maxqty numeric(22,6 )   ,
 price numeric(38,4 )   ,
 amtdecimal numeric(38,0 )   ,
 amtround varchar(2)   ,
 contract_price char(1)   ,
 rule_price char(1)   ,
 over_f char(1)   ,
 itm_code_client varchar(50)   ,
 contents varchar(4000)   ,
 update_ip varchar(40)   ,
 itms_id numeric(38,0 )   not null ,
 locas_id numeric(38,0 )   not null ,
 chrgs_id numeric(38,0 )   not null ,
 persons_id_upd numeric(38,0 )   not null ,
 remark varchar(4000)   ,
 created_at timestamp(6)  ,
 updated_at timestamp(6)  ,
  CONSTRAINT pricemsts_id_pk PRIMARY KEY (id));
 ALTER TABLE pricemsts ADD CONSTRAINT pricemst_itms_id FOREIGN KEY (itms_id)
																		 REFERENCES itms (id);
 ALTER TABLE pricemsts ADD CONSTRAINT pricemst_locas_id FOREIGN KEY (locas_id)
																		 REFERENCES locas (id);
 ALTER TABLE pricemsts ADD CONSTRAINT pricemst_chrgs_id FOREIGN KEY (chrgs_id)
																		 REFERENCES chrgs (id);
 ALTER TABLE pricemsts ADD CONSTRAINT pricemst_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 create sequence pricemsts_seq ;
 --- drop view r_pricemsts cascade  
 create or replace view r_pricemsts as select  
pricemst.chrgs_id   pricemst_chrg_id,
pricemst.itms_id   pricemst_itm_id,
pricemst.over_f  pricemst_over_f,
  itm.unit_code  unit_code ,
  itm.unit_name  unit_name ,
  .itm_weight  itm_weight ,
  .itm_code  itm_code ,
  .itm_name  itm_name ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  .loca_code  loca_code ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  .loca_name  loca_name ,
  .person_code_chrg  person_code_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
pricemst.rule_price  pricemst_rule_price,
pricemst.contract_price  pricemst_contract_price,
pricemst.locas_id   pricemst_loca_id,
  itm.itm_unit_id  itm_unit_id ,
  itm.itm_classlist_id  itm_classlist_id ,
pricemst.tblname  pricemst_tblname,
pricemst.expiredate  pricemst_expiredate,
pricemst.maxqty  pricemst_maxqty,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  itm.classlist_code  classlist_code ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  itm.classlist_name  classlist_name ,
pricemst.itm_code_client  pricemst_itm_code_client,
pricemst.price  pricemst_price,
pricemst.contents  pricemst_contents,
pricemst.remark  pricemst_remark,
pricemst.persons_id_upd   pricemst_person_id_upd,
pricemst.update_ip  pricemst_update_ip,
pricemst.created_at  pricemst_created_at,
pricemst.updated_at  pricemst_updated_at,
pricemst.amtround  pricemst_amtround,
pricemst.amtdecimal  pricemst_amtdecimal,
pricemst.id  pricemst_id,
pricemst.id id,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg 
 from pricemsts   pricemst,
  r_chrgs  chrg ,  r_itms  itm ,  r_locas  loca ,  r_persons  person_upd 
  where       pricemst.chrgs_id = chrg.id      and pricemst.itms_id = itm.id      and pricemst.locas_id = loca.id      and pricemst.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_pricemsts;
 CREATE TABLE sio.sio_r_pricemsts (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_pricemsts_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,pricemst_tblname  varchar (20) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,unit_name  varchar (100) 
,classlist_code  varchar (50) 
,person_name_chrg  varchar (100) 
,classlist_name  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,unit_code  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,pricemst_itm_code_client  varchar (50) 
,pricemst_over_f  varchar (1) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,itm_material  varchar (50) 
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,itm_design  varchar (50) 
,itm_length  numeric (22,0)
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,loca_abbr  varchar (50) 
,loca_zip  varchar (10) 
,loca_country  varchar (20) 
,loca_prfct  varchar (20) 
,loca_addr1  varchar (50) 
,loca_addr2  varchar (50) 
,loca_tel  varchar (20) 
,loca_fax  varchar (20) 
,loca_mail  varchar (20) 
,person_email_chrg  varchar (50) 
,scrlv_level1_chrg  varchar (1) 
,itm_datascale  numeric (22,0)
,unit_contents  varchar (4000) 
,pricemst_expiredate   date 
,pricemst_maxqty  numeric (38,4)
,pricemst_price  numeric (38,4)
,pricemst_rule_price  varchar (0) 
,pricemst_amtdecimal  numeric (38,0)
,pricemst_amtround  varchar (2) 
,pricemst_contract_price  varchar (0) 
,pricemst_contents  varchar (4000) 
,pricemst_remark  varchar (4000) 
,pricemst_id  numeric (38,0)
,id  numeric (38,0)
,pricemst_chrg_id  numeric (38,0)
,pricemst_itm_id  numeric (38,0)
,pricemst_person_id_upd  numeric (38,0)
,pricemst_update_ip  varchar (40) 
,pricemst_created_at   timestamp(6) 
,pricemst_updated_at   timestamp(6) 
,person_sect_id_chrg  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_weight  numeric (38,6)
,person_code_chrg  varchar (50) 
,pricemst_loca_id  numeric (38,0)
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
 CREATE INDEX sio_r_pricemsts_uk1 
  ON sio.sio_r_pricemsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_pricemsts_seq ;
 create sequence sio.sio_r_pricemsts_seq ;
