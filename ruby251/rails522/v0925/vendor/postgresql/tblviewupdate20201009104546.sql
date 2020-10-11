
 create table mkordopeitms (
 id numeric(38,0 )   not null  ,
 mkords_id numeric(22,0 )   not null ,
 locas_id numeric(38,0 )   not null ,
 processseq numeric(38,0 )   ,
 prjnos_id numeric(38,0 )   not null ,
 shelfnos_id_to numeric(38,0 )   not null ,
 expiredate date  ,
 persons_id_upd numeric(38,0 )   not null ,
 created_at timestamp(6)  ,
 updated_at timestamp(6)  ,
 remark varchar(4000)   ,
 contents varchar(4000)   ,
  CONSTRAINT mkordopeitms_id_pk PRIMARY KEY (id));
 ALTER TABLE mkordopeitms ADD CONSTRAINT mkordopeitm_mkords_id FOREIGN KEY (mkords_id)
																		 REFERENCES mkords (id);
 ALTER TABLE mkordopeitms ADD CONSTRAINT mkordopeitm_locas_id FOREIGN KEY (locas_id)
																		 REFERENCES locas (id);
 ALTER TABLE mkordopeitms ADD CONSTRAINT mkordopeitm_prjnos_id FOREIGN KEY (prjnos_id)
																		 REFERENCES prjnos (id);
 ALTER TABLE mkordopeitms ADD CONSTRAINT mkordopeitm_shelfnos_id_to FOREIGN KEY (shelfnos_id_to)
																		 REFERENCES shelfnos (id);
 ALTER TABLE mkordopeitms ADD CONSTRAINT mkordopeitm_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 create sequence mkordopeitms_seq ;
 DROP TABLE IF EXISTS sio.sio_r_mkordopeitms;
 CREATE TABLE sio.sio_r_mkordopeitms (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_mkordopeitms_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
 CREATE INDEX sio_r_mkordopeitms_uk1 
  ON sio.sio_r_mkordopeitms(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_mkordopeitms_seq ;
 create sequence sio.sio_r_mkordopeitms_seq ;
