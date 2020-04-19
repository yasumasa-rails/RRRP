
 create table incustwhs (
 custrcvplcs_id numeric(38,0 )   not null ,
 id numeric(38,0 )   not null  ,
 duedate timestamp(6)  ,
 qty_stk numeric(38,4 )   ,
 qty numeric(18,4 )   ,
 lotno varchar(50)   ,
 packno varchar(10)   ,
 inoutflg char(3)   ,
 expiredate date  ,
 remark varchar(4000)   ,
 persons_id_upd numeric(38,0 )   not null ,
 created_at timestamp(6)  ,
 updated_at timestamp(6)  ,
 update_ip varchar(40)   ,
 trngantts_id numeric(38,0 )   not null ,
  CONSTRAINT incustwhs_id_pk PRIMARY KEY (id));
 ALTER TABLE incustwhs ADD CONSTRAINT incustwh_custrcvplcs_id FOREIGN KEY (custrcvplcs_id)
																		 REFERENCES custrcvplcs (id);
 ALTER TABLE incustwhs ADD CONSTRAINT incustwh_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 ALTER TABLE incustwhs ADD CONSTRAINT incustwh_trngantts_id FOREIGN KEY (trngantts_id)
																		 REFERENCES trngantts (id);
 create sequence incustwhs_seq ;
 DROP TABLE IF EXISTS sio.sio_r_incustwhs;
 CREATE TABLE sio.sio_r_incustwhs (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_incustwhs_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
 CREATE INDEX sio_r_incustwhs_uk1 
  ON sio.sio_r_incustwhs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_incustwhs_seq ;
 create sequence sio.sio_r_incustwhs_seq ;
