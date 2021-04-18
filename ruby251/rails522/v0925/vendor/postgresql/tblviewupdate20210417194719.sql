
  drop view if  exists r_shprets cascade ; 
 create or replace view r_shprets as select  
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
shpret.id id,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  prjno.prjno_code  prjno_code ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
shpret.expiredate  shpret_expiredate,
shpret.updated_at  shpret_updated_at,
shpret.qty  shpret_qty,
shpret.sno  shpret_sno,
shpret.price  shpret_price,
shpret.remark  shpret_remark,
shpret.created_at  shpret_created_at,
shpret.update_ip  shpret_update_ip,
shpret.amt  shpret_amt,
shpret.id  shpret_id,
shpret.tax  shpret_tax,
shpret.persons_id_upd   shpret_person_id_upd,
shpret.contents  shpret_contents,
shpret.qty_case  shpret_qty_case,
shpret.contract_price  shpret_contract_price,
shpret.chrgs_id   shpret_chrg_id,
shpret.isudate  shpret_isudate,
shpret.prjnos_id   shpret_prjno_id,
  loca_fm.loca_code  loca_code_fm ,
  loca_fm.loca_name  loca_name_fm ,
shpret.retdate  shpret_retdate,
shpret.locas_id_to   shpret_loca_id_to,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name_chil  prjno_name_chil 
 from shprets   shpret,
  r_persons  person_upd ,  r_chrgs  chrg ,  r_prjnos  prjno ,  r_locas  loca_to 
  where       shpret.persons_id_upd = person_upd.id      and shpret.chrgs_id = chrg.id      and shpret.prjnos_id = prjno.id      and shpret.locas_id_to = loca_to.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shprets;
 CREATE TABLE sio.sio_r_shprets (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shprets_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,prjno_code  varchar (50) 
,crr_code  varchar (50) 
,crr_name  varchar (100) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,loca_code_fm  varchar (50) 
,person_code_chrg  varchar (50) 
,loca_code_to  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,prjno_name_chil  varchar (100) 
,loca_name_to  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,loca_name_fm  varchar (100) 
,person_name_chrg  varchar (100) 
,shpret_retdate   date 
,shpret_qty_case  numeric (22,0)
,shpret_contract_price  varchar (1) 
,shpret_remark  varchar (4000) 
,shpret_expiredate   date 
,shpret_qty  numeric (18,4)
,shpret_price  numeric (22,0)
,shpret_amt  numeric (18,4)
,shpret_sno  varchar (40) 
,shpret_isudate   timestamp(6) 
,shpret_contents  varchar (4000) 
,shpret_tax  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,shpret_id  numeric (22,0)
,shpret_prjno_id  numeric (22,0)
,id  numeric (22,0)
,shpret_update_ip  varchar (40) 
,shpret_loca_id_to  numeric (22,0)
,shpret_updated_at   timestamp(6) 
,shpret_created_at   timestamp(6) 
,shpret_person_id_upd  numeric (22,0)
,shpret_chrg_id  numeric (22,0)
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
 CREATE INDEX sio_r_shprets_uk1 
  ON sio.sio_r_shprets(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shprets_seq ;
 create sequence sio.sio_r_shprets_seq ;
 ALTER TABLE shprets ADD CONSTRAINT shpret_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 ALTER TABLE shprets ADD CONSTRAINT shpret_locas_id_to FOREIGN KEY (locas_id_to)
																		 REFERENCES locas (id);
 ALTER TABLE shprets ADD CONSTRAINT shpret_prjnos_id FOREIGN KEY (prjnos_id)
																		 REFERENCES prjnos (id);
 ALTER TABLE shprets ADD CONSTRAINT shpret_chrgs_id FOREIGN KEY (chrgs_id)
																		 REFERENCES chrgs (id);
 ALTER TABLE shprets ADD CONSTRAINT shpret_crrs_id FOREIGN KEY (crrs_id)
																		 REFERENCES crrs (id);
 ALTER TABLE shprets ADD CONSTRAINT shpret_locas_id_fm FOREIGN KEY (locas_id_fm)
																		 REFERENCES locas (id);
