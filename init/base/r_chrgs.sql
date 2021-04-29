
  drop view if  exists r_chrgs cascade ; 
 create or replace view r_chrgs as select  
  person_chrg.person_name  person_name_chrg ,
  person_chrg.person_code  person_code_chrg ,
  person_chrg.person_email  person_email_chrg ,
chrg.id id,
  person_chrg.person_sect_id  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
chrg.id  chrg_id,
chrg.persons_id_upd   chrg_person_id_upd,
chrg.persons_id_chrg   chrg_person_id_chrg
 from chrgs   chrg,
  r_persons  person_upd ,  r_persons  person_chrg 
  where       chrg.persons_id_upd = person_upd.id      and chrg.persons_id_chrg = person_chrg.id     ;
 DROP TABLE IF EXISTS sio.sio_r_chrgs;
 CREATE TABLE sio.sio_r_chrgs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_chrgs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,person_name_chrg  varchar (100) 
,person_code_chrg  varchar (50) 
,person_email_chrg  varchar (50) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,chrg_id  numeric (38,0)
,chrg_person_id_upd  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
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
 CREATE INDEX sio_r_chrgs_uk1 
  ON sio.sio_r_chrgs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_chrgs_seq ;
 create sequence sio.sio_r_chrgs_seq ;
