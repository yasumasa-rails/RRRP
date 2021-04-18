
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
  drop view if  exists r_linktbls cascade ; 
 create or replace view r_linktbls as select  
linktbl.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
linktbl.remark  linktbl_remark,
linktbl.expiredate  linktbl_expiredate,
linktbl.update_ip  linktbl_update_ip,
linktbl.created_at  linktbl_created_at,
linktbl.updated_at  linktbl_updated_at,
linktbl.persons_id_upd   linktbl_person_id_upd,
linktbl.sno  linktbl_sno,
linktbl.contents  linktbl_contents,
linktbl.tblname  linktbl_tblname,
linktbl.tblid  linktbl_tblid,
linktbl.srctblname  linktbl_srctblname,
linktbl.srctblid  linktbl_srctblid,
linktbl.qty_src  linktbl_qty_src,
linktbl.cno  linktbl_cno
 from linktbls   linktbl,
  r_persons  person_upd 
  where       linktbl.persons_id_upd = person_upd.id     ;
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
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,linktbl_srctblid  numeric (38,0)
,linktbl_qty_src  numeric (38,6)
,linktbl_tblname  varchar (30) 
,linktbl_srctblname  varchar (30) 
,linktbl_cno  varchar (40) 
,linktbl_sno  varchar (40) 
,linktbl_tblid  numeric (38,0)
,linktbl_expiredate   date 
,linktbl_remark  varchar (4000) 
,linktbl_contents  varchar (4000) 
,id  numeric (38,0)
,linktbl_update_ip  varchar (40) 
,linktbl_created_at   timestamp(6) 
,linktbl_updated_at   timestamp(6) 
,linktbl_person_id_upd  numeric (22,0)
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
