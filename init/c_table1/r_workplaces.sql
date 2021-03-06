 --- drop view r_workplaces cascade  
 create or replace view r_workplaces as select  
  chrg_workplace.scrlv_code_chrg  scrlv_code_chrg_workplace ,
  chrg_workplace.loca_code_sect_chrg  loca_code_sect_chrg_workplace ,
  loca_workplace.loca_code  loca_code_workplace ,
  chrg_workplace.loca_name_sect_chrg  loca_name_sect_chrg_workplace ,
  loca_workplace.loca_name  loca_name_workplace ,
  chrg_workplace.person_code_chrg  person_code_chrg_workplace ,
  chrg_workplace.person_name_chrg  person_name_chrg_workplace ,
workplace.remark  workplace_remark,
workplace.created_at  workplace_created_at,
workplace.update_ip  workplace_update_ip,
workplace.expiredate  workplace_expiredate,
workplace.updated_at  workplace_updated_at,
workplace.id  workplace_id,
workplace.id id,
workplace.persons_id_upd   workplace_person_id_upd,
workplace.contents  workplace_contents,
workplace.locas_id_workplace   workplace_loca_id_workplace,
workplace.chrgs_id_workplace   workplace_chrg_id_workplace,
  chrg_workplace.usrgrp_name_chrg  usrgrp_name_chrg_workplace ,
  chrg_workplace.person_sect_id_chrg  person_sect_id_chrg_workplace ,
  chrg_workplace.usrgrp_code_chrg  usrgrp_code_chrg_workplace ,
  chrg_workplace.chrg_person_id_chrg  chrg_person_id_chrg_workplace 
 from workplaces   workplace,
  r_persons  person_upd ,  r_locas  loca_workplace ,  r_chrgs  chrg_workplace 
  where       workplace.persons_id_upd = person_upd.id      and workplace.locas_id_workplace = loca_workplace.id      and workplace.chrgs_id_workplace = chrg_workplace.id     ;
 DROP TABLE IF EXISTS sio.sio_r_workplaces;
 CREATE TABLE sio.sio_r_workplaces (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_workplaces_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,loca_name_workplace  varchar (100) 
,person_code_chrg_workplaces  varchar (50) 
,person_name_chrg_workplace  varchar (100) 
,person_name_chrg_workplaces  varchar (100) 
,scrlv_code_chrg_workplaces  varchar (50) 
,scrlv_code_chrg_workplace  varchar (50) 
,loca_code_sect_chrg_workplace  varchar (50) 
,loca_code_sect_chrg_workplaces  varchar (50) 
,usrgrp_code_chrg_workplaces  varchar (50) 
,usrgrp_code_chrg_workplace  varchar (50) 
,usrgrp_name_chrg_workplaces  varchar (100) 
,person_code_chrg_workplace  varchar (50) 
,usrgrp_name_chrg_workplace  varchar (100) 
,loca_code_workplace  varchar (50) 
,loca_name_sect_chrg_workplace  varchar (100) 
,loca_name_sect_chrg_workplaces  varchar (100) 
,workplace_expiredate   date 
,loca_mail_workplace  varchar (20) 
,loca_abbr_workplace  varchar (50) 
,loca_zip_workplace  varchar (10) 
,loca_country_workplace  varchar (20) 
,loca_prfct_workplace  varchar (20) 
,loca_addr1_workplace  varchar (50) 
,loca_addr2_workplace  varchar (50) 
,loca_tel_workplace  varchar (20) 
,loca_fax_workplace  varchar (20) 
,person_email_chrg_workplace  varchar (50) 
,person_email_chrg_workplaces  varchar (50) 
,scrlv_level1_chrg_workplace  varchar (1) 
,scrlv_level1_chrg_workplaces  varchar (1) 
,workplace_contents  varchar (4000) 
,workplace_remark  varchar (4000) 
,workplace_person_id_upd  numeric (38,0)
,workplace_loca_id_workplace  numeric (22,0)
,workplace_chrg_id_workplace  numeric (22,0)
,workplace_chrg_id_workplaces  numeric (22,0)
,workplace_updated_at   timestamp(6) 
,workplace_update_ip  varchar (40) 
,workplace_id  numeric (38,0)
,id  numeric (38,0)
,workplace_created_at   timestamp(6) 
,chrg_person_id_chrg_workplaces  numeric (38,0)
,person_sect_id_chrg_workplace  numeric (22,0)
,chrg_person_id_chrg_workplace  numeric (38,0)
,person_sect_id_chrg_workplaces  numeric (22,0)
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
 CREATE INDEX sio_r_workplaces_uk1 
  ON sio.sio_r_workplaces(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_workplaces_seq ;
 create sequence sio.sio_r_workplaces_seq ;
