
 create table srctbls (
 qty_src numeric(38,6 )   ,
 id numeric(38,0 )   not null  ,
 srctblname varchar(30)   ,
 sno varchar(40)   ,
 cno varchar(40)   ,
 srctblid numeric(38,0 )   ,
 tblname varchar(30)   ,
 tblid numeric(38,0 )   ,
 contents varchar(4000)   ,
  CONSTRAINT srctbls_id_pk PRIMARY KEY (id));
 create sequence srctbls_seq ;
 --- drop view r_srctbls cascade  
 create or replace view r_srctbls as select  
srctbl.qty_src  srctbl_qty_src,
srctbl.id  srctbl_id,
srctbl.id id,
srctbl.srctblname  srctbl_srctblname,
srctbl.sno  srctbl_sno,
srctbl.cno  srctbl_cno,
srctbl.srctblid  srctbl_srctblid,
srctbl.tblname  srctbl_tblname,
srctbl.tblid  srctbl_tblid,
srctbl.contents  srctbl_contents
 from srctbls   srctbl,
  where  ;
 DROP TABLE IF EXISTS sio.sio_r_srctbls;
 CREATE TABLE sio.sio_r_srctbls (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_srctbls_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,srctbl_sno  varchar (40) 
,srctbl_cno  varchar (40) 
,srctbl_qty_src  numeric (38,6)
,srctbl_srctblname  varchar (30) 
,srctbl_srctblid  numeric (38,0)
,srctbl_tblname  varchar (30) 
,srctbl_tblid  numeric (38,0)
,srctbl_contents  varchar (4000) 
,id  numeric (38,0)
,srctbl_id  numeric (38,0)
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
 CREATE INDEX sio_r_srctbls_uk1 
  ON sio.sio_r_srctbls(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_srctbls_seq ;
 create sequence sio.sio_r_srctbls_seq ;
