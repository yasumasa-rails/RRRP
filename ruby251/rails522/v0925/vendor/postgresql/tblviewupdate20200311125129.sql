
 --- drop view r_boxes cascade  
 create or replace view r_boxes as select  
boxe.code  boxe_code,
boxe.name  boxe_name,
  unit_outbox.unit_code  unit_code_outbox ,
  unit_box.unit_code  unit_code_box ,
  unit_outbox.unit_name  unit_name_outbox ,
  unit_box.unit_name  unit_name_box ,
boxe.id  boxe_id,
boxe.id id,
boxe.boxtype  boxe_boxtype,
boxe.depth  boxe_depth,
boxe.wide  boxe_wide,
boxe.height  boxe_height,
boxe.units_id_box   boxe_unit_id_box,
boxe.outdepth  boxe_outdepth,
boxe.outwide  boxe_outwide,
boxe.outheight  boxe_outheight,
boxe.units_id_outbox   boxe_unit_id_outbox,
boxe.remark  boxe_remark,
boxe.contents  boxe_contents,
boxe.expiredate  boxe_expiredate,
boxe.persons_id_upd   boxe_person_id_upd,
boxe.update_ip  boxe_update_ip,
boxe.created_at  boxe_created_at,
boxe.updated_at  boxe_updated_at
 from boxes   boxe,
  r_units  unit_box ,  r_units  unit_outbox ,  r_persons  person_upd 
  where       boxe.units_id_box = unit_box.id      and boxe.units_id_outbox = unit_outbox.id      and boxe.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_boxes;
 CREATE TABLE sio.sio_r_boxes (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_boxes_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,boxe_boxtype  varchar (20) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,boxe_depth  numeric (7,2)
,boxe_wide  numeric (7,2)
,boxe_height  numeric (7,2)
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_code_box  varchar (50) 
,unit_name_outbox  varchar (100) 
,boxe_outdepth  numeric (7,2)
,boxe_outwide  numeric (7,2)
,boxe_outheight  numeric (7,2)
,unit_dataprecision_outbox  numeric (38,0)
,unit_contents_outbox  varchar (4000) 
,unit_contents_box  varchar (4000) 
,unit_dataprecision_box  numeric (38,0)
,boxe_contents  varchar (4000) 
,boxe_remark  varchar (4000) 
,boxe_expiredate   date 
,boxe_updated_at   timestamp(6) 
,boxe_id  numeric (38,0)
,id  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,boxe_person_id_upd  numeric (38,0)
,boxe_update_ip  varchar (40) 
,boxe_created_at   timestamp(6) 
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
 CREATE INDEX sio_r_boxes_uk1 
  ON sio.sio_r_boxes(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_boxes_seq ;
 create sequence sio.sio_r_boxes_seq ;
