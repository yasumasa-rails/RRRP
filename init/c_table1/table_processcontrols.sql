
 create table processcontrols (
 id numeric(38,0 ) ,
 tblname varchar(30) ,
 seqno numeric(38,0 ) ,
 destblname varchar(30) ,
 segment varchar(10) ,
 rubycode varchar(4000) ,
 contents varchar(4000) ,
 remark varchar(4000) ,
 persons_id_upd numeric(38,0 ) ,
 created_at timestamp(6),
 updated_at timestamp(6),
  CONSTRAINT processcontrols_id_pk PRIMARY KEY (id));
 ALTER TABLE processcontrols ADD CONSTRAINT processcontrol_persons_id_upd FOREIGN KEY (persons_id_upd) REFERENCES persons (id);
 create sequence processcontrols_seq ;
 --- drop view r_processcontrols cascade  
 create or replace view r_processcontrols as select  
processcontrol.remark  processcontrol_remark,
processcontrol.created_at  processcontrol_created_at,
processcontrol.rubycode  processcontrol_rubycode,
processcontrol.updated_at  processcontrol_updated_at,
processcontrol.seqno  processcontrol_seqno,
processcontrol.id id,
processcontrol.id  processcontrol_id,
processcontrol.persons_id_upd   processcontrol_person_id_upd,
processcontrol.contents  processcontrol_contents,
processcontrol.tblname  processcontrol_tblname,
processcontrol.destblname  processcontrol_destblname,
processcontrol.segment  processcontrol_segment,
  person_upd.person_code_upd  person_code_upd ,
  person_upd.person_name_upd  person_name_upd 
 from processcontrols   processcontrol,
  r_persons  person_upd 
  where       processcontrol.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_processcontrols;
 CREATE TABLE sio.sio_r_processcontrols (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_processcontrols_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,processcontrol_tblname  varchar (30) 
,processcontrol_seqno  numeric (38,0)
,processcontrol_segment  varchar (10) 
,processcontrol_rubycode  varchar (4000) 
,processcontrol_destblname  varchar (30) 
,processcontrol_remark  varchar (4000) 
,processcontrol_contents  varchar (4000) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (50) 
,processcontrol_updated_at   timestamp(6) 
,processcontrol_created_at   timestamp(6) 
,processcontrol_person_id_upd  numeric (38,0)
,processcontrol_id  numeric (38,0)
,id  numeric (38,0)
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
 CREATE INDEX sio_r_processcontrols_uk1 
  ON sio.sio_r_processcontrols(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_processcontrols_seq ;
 create sequence sio.sio_r_processcontrols_seq ;
