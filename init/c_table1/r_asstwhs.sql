
 --- drop view r_asstwhs cascade  
 create or replace view r_asstwhs as select  
asstwh.autocreate_inst  asstwh_autocreate_inst,
asstwh.id id,
asstwh.id  asstwh_id,
asstwh.locas_id_asstwh   asstwh_loca_id_asstwh,
asstwh.remark  asstwh_remark,
asstwh.stktaking_proc  asstwh_stktaking_proc,
asstwh.contents  asstwh_contents,
asstwh.chrgs_id_asstwh   asstwh_chrg_id_asstwh,
asstwh.expiredate  asstwh_expiredate,
asstwh.persons_id_upd   asstwh_person_id_upd,
asstwh.update_ip  asstwh_update_ip,
asstwh.created_at  asstwh_created_at,
asstwh.updated_at  asstwh_updated_at,
asstwh.acceptance_proc  asstwh_acceptance_proc,
  loca_asstwh.loca_code  loca_code_asstwh ,
  loca_asstwh.loca_name  loca_name_asstwh ,
  chrg_asstwh.person_sect_id_chrg  person_sect_id_chrg_asstwh ,
  chrg_asstwh.scrlv_code_chrg  scrlv_code_chrg_asstwh ,
  chrg_asstwh.person_name_chrg  person_name_chrg_asstwh ,
  chrg_asstwh.loca_name_sect_chrg  loca_name_sect_chrg_asstwh ,
  chrg_asstwh.loca_code_sect_chrg  loca_code_sect_chrg_asstwh ,
  chrg_asstwh.person_code_chrg  person_code_chrg_asstwh ,
  chrg_asstwh.usrgrp_code_chrg  usrgrp_code_chrg_asstwh ,
  chrg_asstwh.usrgrp_name_chrg  usrgrp_name_chrg_asstwh ,
  chrg_asstwh.chrg_person_id_chrg  chrg_person_id_chrg_asstwh 
 from asstwhs   asstwh,
  r_locas  loca_asstwh ,  r_chrgs  chrg_asstwh ,  r_persons  person_upd 
  where       asstwh.locas_id_asstwh = loca_asstwh.id      and asstwh.chrgs_id_asstwh = chrg_asstwh.id      and asstwh.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_asstwhs;
 CREATE TABLE sio.sio_r_asstwhs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_asstwhs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,loca_code_asstwh  varchar (50) 
,usrgrp_name_chrg_asstwh  varchar (100) 
,usrgrp_code_chrg_asstwh  varchar (50) 
,person_code_chrg_asstwh  varchar (50) 
,loca_code_sect_chrg_asstwh  varchar (50) 
,loca_name_sect_chrg_asstwh  varchar (100) 
,person_name_chrg_asstwh  varchar (100) 
,scrlv_code_chrg_asstwh  varchar (50) 
,loca_name_asstwh  varchar (100) 
,asstwh_stktaking_proc  varchar (1) 
,asstwh_autocreate_inst  varchar (1) 
,asstwh_acceptance_proc  varchar (1) 
,asstwh_expiredate   date 
,loca_tel_asstwh  varchar (20) 
,loca_country_asstwh  varchar (20) 
,loca_abbr_asstwh  varchar (50) 
,loca_prfct_asstwh  varchar (20) 
,loca_mail_asstwh  varchar (20) 
,loca_addr1_asstwh  varchar (50) 
,loca_zip_asstwh  varchar (10) 
,loca_fax_asstwh  varchar (20) 
,loca_addr2_asstwh  varchar (50) 
,scrlv_level1_chrg_asstwh  varchar (1) 
,person_email_chrg_asstwh  varchar (50) 
,asstwh_remark  varchar (4000) 
,asstwh_contents  varchar (4000) 
,asstwh_person_id_upd  numeric (38,0)
,id  numeric (38,0)
,asstwh_chrg_id_asstwh  numeric (38,0)
,asstwh_created_at   timestamp(6) 
,asstwh_id  numeric (38,0)
,asstwh_updated_at   timestamp(6) 
,asstwh_loca_id_asstwh  numeric (38,0)
,asstwh_update_ip  varchar (40) 
,chrg_person_id_chrg_asstwh  numeric (38,0)
,person_sect_id_chrg_asstwh  numeric (22,0)
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
 CREATE INDEX sio_r_asstwhs_uk1 
  ON sio.sio_r_asstwhs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_asstwhs_seq ;
 create sequence sio.sio_r_asstwhs_seq ;
