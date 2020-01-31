
 --- drop view r_blkukys cascade  
 create or replace view r_blkukys as select  
  tblfield.pobject_code_fld  pobject_code_fld ,
  tblfield.pobject_code_tbl  pobject_code_tbl ,
  tblfield.pobject_id_fld  pobject_id_fld ,
  tblfield.pobject_id_tbl  pobject_id_tbl ,
blkuky.remark  blkuky_remark,
blkuky.expiredate  blkuky_expiredate,
blkuky.persons_id_upd   blkuky_person_id_upd,
blkuky.id  blkuky_id,
blkuky.id id,
blkuky.grp  blkuky_grp,
blkuky.tblfields_id   blkuky_tblfield_id,
blkuky.updated_at  blkuky_updated_at,
blkuky.created_at  blkuky_created_at,
blkuky.update_ip  blkuky_update_ip,
  tblfield.tblfield_id  tblfield_id ,
  tblfield.tblfield_fieldcode_id  tblfield_fieldcode_id ,
  tblfield.tblfield_blktb_id  tblfield_blktb_id ,
  tblfield.tblfield_seqno  tblfield_seqno ,
  tblfield.tblfield_contents  tblfield_contents ,
  tblfield.tblfield_viewflmk  tblfield_viewflmk ,
  tblfield.fieldcode_ftype  fieldcode_ftype ,
  tblfield.fieldcode_fieldlength  fieldcode_fieldlength ,
  tblfield.fieldcode_datascale  fieldcode_datascale ,
  tblfield.fieldcode_dataprecision  fieldcode_dataprecision ,
  tblfield.fieldcode_contents  fieldcode_contents ,
blkuky.contents  blkuky_contents,
blkuky.seqno  blkuky_seqno
 from blkukys   blkuky,
  r_persons  person_upd ,  r_tblfields  tblfield 
  where       blkuky.persons_id_upd = person_upd.id      and blkuky.tblfields_id = tblfield.id     ;
 DROP TABLE IF EXISTS sio.sio_r_blkukys;
 CREATE TABLE sio.sio_r_blkukys (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_blkukys_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,pobject_code_tbl  varchar (50) 
,blkuky_grp  varchar (10) 
,blkuky_seqno  numeric (22,0)
,pobject_code_fld  varchar (50) 
,fieldcode_ftype  varchar (15) 
,blkuky_expiredate   date 
,blkuky_contents  varchar (4000) 
,fieldcode_contents  varchar (4000) 
,pobject_id_fld  numeric (22,0)
,fieldcode_fieldlength  numeric (22,0)
,fieldcode_datascale  numeric (22,0)
,blkuky_remark  varchar (4000) 
,fieldcode_dataprecision  numeric (38,0)
,id  numeric (38,0)
,tblfield_id  numeric (22,0)
,tblfield_fieldcode_id  numeric (22,0)
,tblfield_blktb_id  numeric (22,0)
,tblfield_seqno  numeric (22,0)
,tblfield_contents  varchar (4000) 
,tblfield_viewflmk  varchar (4000) 
,blkuky_updated_at   timestamp 
,blkuky_tblfield_id  numeric (22,0)
,pobject_id_tbl  numeric (22,0)
,blkuky_id  numeric (22,0)
,blkuky_created_at   timestamp 
,blkuky_person_id_upd  numeric (22,0)
,blkuky_update_ip  varchar (50) 
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
 CREATE INDEX sio_r_blkukys_uk1 
  ON sio.sio_r_blkukys(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_blkukys_seq ;
 create sequence sio.sio_r_blkukys_seq ;
