
 create table  (
 id numeric(38,0 )   not null  ,
 remark varchar(4000)   ,
 expiredate date  ,
 update_ip varchar(40)   ,
 created_at timestamp(6)  ,
 updated_at timestamp(6)  ,
 persons_id_upd numeric(38,0 )   not null ,
 sno varchar(40)   ,
 contents varchar(4000)   ,
 tblname varchar(30)   ,
 tblid numeric(38,0 )   ,
 srctblname varchar(30)   ,
 srctblid numeric(38,0 )   ,
 qty_src numeric(38,6 )   ,
 cno varchar(40)   ,
  CONSTRAINT _id_pk PRIMARY KEY (id));
 DROP TABLE IF EXISTS sio.sio_r_linktbls;
 CREATE TABLE sio.sio_r_linktbls (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_linktbls_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
 CREATE INDEX sio_r_linktbls_uk1 
  ON sio.sio_r_linktbls(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_linktbls_seq ;
 create sequence sio.sio_r_linktbls_seq ;
 create sequence linktbls_seq ;
