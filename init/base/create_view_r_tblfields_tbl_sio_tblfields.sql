
 --- drop view r_tblfields cascade  
 create or replace view r_tblfields as select  
tblfield.id id,
  blktb.pobject_code_tbl  pobject_code_tbl ,
  fieldcode.fieldcode_fieldlength  fieldcode_fieldlength ,
  fieldcode.fieldcode_datascale  fieldcode_datascale ,
tblfield.blktbs_id   tblfield_blktb_id,
tblfield.fieldcodes_id   tblfield_fieldcode_id,
  blktb.pobject_id_tbl  pobject_id_tbl ,
tblfield.created_at  tblfield_created_at,
tblfield.updated_at  tblfield_updated_at,
tblfield.id  tblfield_id,
  fieldcode.pobject_id_fld  pobject_id_fld ,
  fieldcode.fieldcode_dataprecision  fieldcode_dataprecision ,
tblfield.seqno  tblfield_seqno,
tblfield.persons_id_upd   tblfield_person_id_upd,
  person_upd.person_name  person_name_upd ,
  person_upd.person_code  person_code_upd ,
tblfield.update_ip  tblfield_update_ip,
  fieldcode.fieldcode_contents  fieldcode_contents ,
tblfield.viewflmk  tblfield_viewflmk,
  fieldcode.pobject_code_fld  pobject_code_fld ,
  fieldcode.fieldcode_ftype  fieldcode_ftype ,
tblfield.contents  tblfield_contents,
tblfield.remark  tblfield_remark,
tblfield.expiredate  tblfield_expiredate
 from tblfields   tblfield,
  r_blktbs  blktb ,  r_fieldcodes  fieldcode ,  r_persons  person_upd 
  where       tblfield.blktbs_id = blktb.id      and tblfield.fieldcodes_id = fieldcode.id      and tblfield.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_tblfields;
 CREATE TABLE sio.sio_r_tblfields (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_tblfields_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,tblfield_seqno  numeric (22,0)
,pobject_code_tbl  varchar (50) 
,pobject_code_fld  varchar (50) 
,fieldcode_ftype  varchar (15) 
,fieldcode_fieldlength  numeric (22,0)
,fieldcode_dataprecision  numeric (38,0)
,fieldcode_datascale  numeric (22,0)
,tblfield_contents  varchar (4000) 
,fieldcode_contents  varchar (4000) 
,tblfield_remark  varchar (4000) 
,tblfield_expiredate   date 
,tblfield_viewflmk  varchar (4000) 
,pobject_id_fld  numeric (22,0)
,blktb_contents  varchar (4000) 
,pobject_contents_tbl  varchar (4000) 
,pobject_rubycode_fld  varchar (4000) 
,pobject_contents_fld  varchar (4000) 
,tblfield_person_id_upd  numeric (22,0)
,person_id_upd  numeric (22,0)
,person_name_upd  varchar (100) 
,person_code_upd  varchar (50) 
,tblfield_update_ip  varchar (40) 
,blktb_seltbls  varchar (4000) 
,pobject_objecttype_fld  varchar (20) 
,pobject_rubycode_tbl  varchar (4000) 
,id  numeric (38,0)
,fieldcode_seqno  numeric (22,0)
,pobject_objecttype_tbl  varchar (20) 
,tblfield_blktb_id  numeric (22,0)
,tblfield_fieldcode_id  numeric (22,0)
,blktb_pobject_id_tbl  numeric (22,0)
,pobject_id_tbl  numeric (22,0)
,blktb_id  numeric (22,0)
,tblfield_created_at   timestamp(6) 
,tblfield_updated_at   timestamp(6) 
,tblfield_id  numeric (22,0)
,fieldcode_pobject_id_fld  numeric (22,0)
,fieldcode_id  numeric (22,0)
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
 CREATE INDEX sio_r_tblfields_uk1 
  ON sio.sio_r_tblfields(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_tblfields_seq ;
 create sequence sio.sio_r_tblfields_seq ;
