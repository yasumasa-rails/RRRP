insert into reasons(created_at,id,update_ip,
	expiredate,updated_at,remark,persons_id_upd,code,name) 
values( 
to_timestamp('2020/01/10 18:46:08','yyyy/mm/dd hh24:mi:ss'),'0','',
'2099-12-31',to_timestamp('2020/01/10 18:46:08','yyyy/mm/dd hh24:mi:ss'),'',0,'0','Normal')

 --- drop view r_reasons cascade  
 create or replace view r_reasons as select  
reason.id  reason_id,
reason.id id,
reason.code  reason_code,
reason.name  reason_name,
reason.persons_id_upd   reason_person_id_upd,
reason.contents  reason_contents,
reason.remark  reason_remark,
reason.created_at  reason_created_at,
reason.update_ip  reason_update_ip,
reason.updated_at  reason_updated_at,
reason.expiredate  reason_expiredate
 from reasons   reason,
  r_persons  person_upd 
  where       reason.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_reasons;
 CREATE TABLE sio.sio_r_reasons (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_reasons_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,reason_code  varchar (50) 
,reason_name  varchar (100) 
,reason_expiredate   date 
,reason_contents  varchar (4000) 
,reason_remark  varchar (4000) 
,reason_id  numeric (38,0)
,id  numeric (38,0)
,reason_created_at   timestamp(6) 
,reason_update_ip  varchar (40) 
,reason_updated_at   timestamp(6) 
,reason_person_id_upd  numeric (38,0)
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
 CREATE INDEX sio_r_reasons_uk1 
  ON sio.sio_r_reasons(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_reasons_seq ;
 create sequence sio.sio_r_reasons_seq ;
