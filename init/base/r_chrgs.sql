
 --- drop view r_chrgs cascade  
 create or replace view r_chrgs as select  
  person_chrg.scrlv_code  scrlv_code_chrg ,
  person_chrg.loca_code_sect  loca_code_sect_chrg ,
  person_chrg.loca_name_sect  loca_name_sect_chrg ,
  person_chrg.person_code  person_code_chrg ,
  person_chrg.person_name  person_name_chrg ,
  person_chrg.person_email  person_email_chrg ,
  person_chrg.scrlv_level1  scrlv_level1_chrg ,
  person_chrg.person_scrlv_id  person_scrlv_id_chrg ,
chrg.id  chrg_id,
chrg.id id,
chrg.expiredate  chrg_expiredate,
chrg.updated_at  chrg_updated_at,
chrg.remark  chrg_remark,
chrg.created_at  chrg_created_at,
chrg.update_ip  chrg_update_ip,
chrg.persons_id_upd   chrg_person_id_upd,
chrg.contents  chrg_contents,
  person_chrg.usrgrp_name  usrgrp_name_chrg ,
  person_chrg.person_sect_id  person_sect_id_chrg ,
  person_chrg.person_usrgrp_id  person_usrgrp_id_chrg ,
  person_chrg.usrgrp_code  usrgrp_code_chrg ,
chrg.persons_id_chrg   chrg_person_id_chrg
 from chrgs   chrg,
  r_persons  person_upd ,  r_persons  person_chrg 
  where       chrg.persons_id_upd = person_upd.id      and chrg.persons_id_chrg = person_chrg.id     ;
 DROP TABLE IF EXISTS sio.sio_r_chrgs;
 CREATE TABLE sio.sio_r_chrgs (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_chrgs_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,chrg_expiredate   date 
,person_email_chrg  varchar (50) 
,scrlv_level1_chrg  varchar (1) 
,chrg_contents  varchar (4000) 
,chrg_remark  varchar (4000) 
,chrg_person_id_chrg  numeric (38,0)
,chrg_id  numeric (38,0)
,id  numeric (38,0)
,chrg_updated_at   timestamp(6) 
,chrg_created_at   timestamp(6) 
,chrg_update_ip  varchar (40) 
,chrg_person_id_upd  numeric (38,0)
,person_usrgrp_id_chrg  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,person_scrlv_id_chrg  numeric (22,0)
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
 CREATE INDEX sio_r_chrgs_uk1 
  ON sio.sio_r_chrgs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_chrgs_seq ;
 create sequence sio.sio_r_chrgs_seq ;
