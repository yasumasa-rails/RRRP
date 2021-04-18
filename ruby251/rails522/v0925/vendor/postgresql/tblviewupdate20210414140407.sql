
  drop view if  exists r_units cascade ; 
 create or replace view r_units as select  
unit.expiredate  unit_expiredate,
unit.persons_id_upd   unit_person_id_upd,
unit.created_at  unit_created_at,
unit.updated_at  unit_updated_at,
unit.remark  unit_remark,
unit.name  unit_name,
unit.code  unit_code,
unit.update_ip  unit_update_ip,
unit.id  unit_id,
unit.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
unit.contents  unit_contents,
unit.dataprecision  unit_dataprecision
 from units   unit,
  r_persons  person_upd 
  where       unit.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_units;
 CREATE TABLE sio.sio_r_units (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_units_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,person_name_upd  varchar (100) 
,unit_dataprecision  numeric (38,0)
,unit_expiredate   date 
,unit_remark  varchar (4000) 
,unit_contents  varchar (4000) 
,unit_id  numeric (38,0)
,unit_updated_at   timestamp(6) 
,unit_created_at   timestamp(6) 
,unit_person_id_upd  numeric (38,0)
,unit_update_ip  varchar (40) 
,id  numeric (22,0)
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
 CREATE INDEX sio_r_units_uk1 
  ON sio.sio_r_units(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_units_seq ;
 create sequence sio.sio_r_units_seq ;
