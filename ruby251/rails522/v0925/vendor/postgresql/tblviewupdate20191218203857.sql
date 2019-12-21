
 create table purdlvs (
 id numeric(38,0 )   not null  ,
 isudate timestamp(6)  ,
 suppliers_id numeric(22,0 )   not null ,
 locas_id_to numeric(38,0 )   not null ,
 depdate timestamp(6)  ,
 qty numeric(18,4 )   ,
 qty_case numeric(38,0 )   ,
 itm_code_client varchar(50)   ,
 sno varchar(40)   ,
 sno_inst varchar(40)   ,
 cno varchar(40)   ,
 gno varchar(40)   ,
 replydate date  ,
 autoact_p numeric(3,0 )   ,
 remark varchar(4000)   ,
 expiredate date  ,
 chrgs_id numeric(38,0 )   not null ,
 prjnos_id numeric(38,0 )   not null ,
 opeitms_id numeric(38,0 )   not null ,
 persons_id_upd numeric(38,0 )   not null ,
 update_ip varchar(40)   ,
 created_at timestamp(6)  ,
 updated_at timestamp(6)  ,
  CONSTRAINT purdlvs_id_pk PRIMARY KEY (id));
 ALTER TABLE purdlvs ADD CONSTRAINT purdlv_suppliers_id FOREIGN KEY (suppliers_id)
																		 REFERENCES suppliers (id);
 ALTER TABLE purdlvs ADD CONSTRAINT purdlv_locas_id_to FOREIGN KEY (locas_id_to)
																		 REFERENCES locas (id);
 ALTER TABLE purdlvs ADD CONSTRAINT purdlv_chrgs_id FOREIGN KEY (chrgs_id)
																		 REFERENCES chrgs (id);
 ALTER TABLE purdlvs ADD CONSTRAINT purdlv_prjnos_id FOREIGN KEY (prjnos_id)
																		 REFERENCES prjnos (id);
 ALTER TABLE purdlvs ADD CONSTRAINT purdlv_opeitms_id FOREIGN KEY (opeitms_id)
																		 REFERENCES opeitms (id);
 ALTER TABLE purdlvs ADD CONSTRAINT purdlv_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 create sequence purdlvs_seq ;
 DROP TABLE IF EXISTS sio.sio_r_purdlvs;
 CREATE TABLE sio.sio_r_purdlvs (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_purdlvs_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
 CREATE INDEX sio_r_purdlvs_uk1 
  ON sio.sio_r_purdlvs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purdlvs_seq ;
 create sequence sio.sio_r_purdlvs_seq ;
