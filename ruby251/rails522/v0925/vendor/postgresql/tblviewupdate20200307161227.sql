
 --- drop view r_transports cascade  
 create or replace view r_transports as select  
transport.code  transport_code,
transport.name  transport_name,
transport.contents  transport_contents,
transport.remark  transport_remark,
transport.expiredate  transport_expiredate,
transport.persons_id_upd   transport_person_id_upd,
transport.update_ip  transport_update_ip,
transport.created_at  transport_created_at,
transport.updated_at  transport_updated_at,
transport.id  transport_id,
transport.id id
 from transports   transport,
  r_persons  person_upd 
  where       transport.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_transports;
 CREATE TABLE sio.sio_r_transports (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_transports_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,transport_code  varchar (50) 
,transport_name  varchar (100) 
,transport_expiredate   date 
,transport_contents  varchar (4000) 
,transport_remark  varchar (4000) 
,transport_id  numeric (38,0)
,id  numeric (38,0)
,transport_person_id_upd  numeric (38,0)
,transport_update_ip  varchar (40) 
,transport_created_at   timestamp(6) 
,transport_updated_at   timestamp(6) 
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
 CREATE INDEX sio_r_transports_uk1 
  ON sio.sio_r_transports(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_transports_seq ;
 create sequence sio.sio_r_transports_seq ;
