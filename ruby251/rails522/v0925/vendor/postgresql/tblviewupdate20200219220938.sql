
 create table acpschs (
 id numeric(38,0 )   not null  ,
 contents varchar(4000)   ,
 isudate timestamp(6)  ,
 locas_id_to numeric(38,0 )   not null ,
 processseq_pare numeric(38,0 )   ,
 acpdate timestamp(6)  ,
 qty numeric(18,4 )   ,
 price numeric(38,4 )   ,
 amt numeric(18,4 )   ,
 tax numeric(38,4 )   ,
 updated_at timestamp(6)  ,
 sno varchar(40)   ,
 manual char(1)   ,
 expiredate date  ,
 persons_id_upd numeric(38,0 )   not null ,
 created_at timestamp(6)  ,
 update_ip varchar(40)   ,
 remark varchar(4000)   ,
 prjnos_id numeric(38,0 )   not null ,
 opeitms_id numeric(38,0 )   not null ,
  CONSTRAINT acpschs_id_pk PRIMARY KEY (id));
 ALTER TABLE acpschs ADD CONSTRAINT acpsch_locas_id_to FOREIGN KEY (locas_id_to)
																		 REFERENCES locas (id);
 ALTER TABLE acpschs ADD CONSTRAINT acpsch_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 ALTER TABLE acpschs ADD CONSTRAINT acpsch_prjnos_id FOREIGN KEY (prjnos_id)
																		 REFERENCES prjnos (id);
 ALTER TABLE acpschs ADD CONSTRAINT acpsch_opeitms_id FOREIGN KEY (opeitms_id)
																		 REFERENCES opeitms (id);
 create sequence acpschs_seq ;
 DROP TABLE IF EXISTS sio.sio_r_acpschs;
 CREATE TABLE sio.sio_r_acpschs (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_acpschs_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
 CREATE INDEX sio_r_acpschs_uk1 
  ON sio.sio_r_acpschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_acpschs_seq ;
 create sequence sio.sio_r_acpschs_seq ;
