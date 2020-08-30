
 create table mkshps (
 id numeric(38,0 )   not null  ,
 cmpldate timestamp(6)  ,
 result_f char(1)   ,
 runtime numeric(2,0 )   ,
 isudate timestamp(6)  ,
 confirm char(1)   ,
 manual char(1)   ,
 orgtblname varchar(30)   ,
 sno_org varchar(50)   ,
 itms_id_org numeric(38,0 )   not null ,
 locas_id_org numeric(38,0 )   not null ,
 paretblname varchar(30)   ,
 duedate_pare varchar(18)   ,
 sno_pare varchar(50)   ,
 itms_id_pare numeric(38,0 )   not null ,
 locas_id_pare numeric(38,0 )   not null ,
 tblname varchar(30)   ,
 incnt numeric(38,0 )   ,
 inqty numeric(22,6 )   ,
 inamt numeric(38,4 )   ,
 outcnt numeric(38,0 )   ,
 outqty numeric(22,6 )   ,
 outamt numeric(38,4 )   ,
 skipcnt numeric(38,0 )   ,
 skipqty numeric(22,6 )   ,
 skipamt numeric(38,4 )   ,
 remark varchar(4000)   ,
 message_code varchar(256)   ,
 persons_id_upd numeric(38,0 )   not null ,
 created_at timestamp(6)  ,
 updated_at timestamp(6)  ,
 expiredate date  ,
 update_ip varchar(40)   ,
  CONSTRAINT mkshps_id_pk PRIMARY KEY (id));
 ALTER TABLE mkshps ADD CONSTRAINT mkshp_itms_id_org FOREIGN KEY (itms_id_org)
																		 REFERENCES itms (id);
 ALTER TABLE mkshps ADD CONSTRAINT mkshp_locas_id_org FOREIGN KEY (locas_id_org)
																		 REFERENCES locas (id);
 ALTER TABLE mkshps ADD CONSTRAINT mkshp_itms_id_pare FOREIGN KEY (itms_id_pare)
																		 REFERENCES itms (id);
 ALTER TABLE mkshps ADD CONSTRAINT mkshp_locas_id_pare FOREIGN KEY (locas_id_pare)
																		 REFERENCES locas (id);
 ALTER TABLE mkshps ADD CONSTRAINT mkshp_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 create sequence mkshps_seq ;
 DROP TABLE IF EXISTS sio.sio_r_mkshps;
 CREATE TABLE sio.sio_r_mkshps (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_mkshps_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
 CREATE INDEX sio_r_mkshps_uk1 
  ON sio.sio_r_mkshps(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_mkshps_seq ;
 create sequence sio.sio_r_mkshps_seq ;
