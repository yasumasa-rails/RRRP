
 --- drop view r_crrs cascade  
 create or replace view r_crrs as select  
  person_upd.person_id  person_id_upd ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
crr.code  crr_code,
crr.expiredate  crr_expiredate,
crr.updated_at  crr_updated_at,
crr.pricedecimal  crr_pricedecimal,
crr.amtdecimal  crr_amtdecimal,
crr.remark  crr_remark,
crr.created_at  crr_created_at,
crr.update_ip  crr_update_ip,
crr.persons_id_upd   crr_person_id_upd,
crr.contents  crr_contents,
crr.id  crr_id,
crr.id id,
crr.name  crr_name
 from crrs   crr,
  r_persons  person_upd 
  where       crr.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_crrs;
 CREATE TABLE sio.sio_r_crrs (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_crrs_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,crr_code  varchar (50) 
,crr_name  varchar (100) 
,crr_pricedecimal  numeric (22,0)
,crr_amtdecimal  numeric (22,0)
,crr_expiredate   date 
,crr_remark  varchar (4000) 
,crr_contents  varchar (4000) 
,crr_created_at   timestamp(6) 
,crr_updated_at   timestamp(6) 
,crr_update_ip  varchar (40) 
,crr_id  numeric (22,0)
,id  numeric (22,0)
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,person_id_upd  numeric (22,0)
,crr_person_id_upd  numeric (22,0)
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
 CREATE INDEX sio_r_crrs_uk1 
  ON sio.sio_r_crrs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_crrs_seq ;
 create sequence sio.sio_r_crrs_seq ;
