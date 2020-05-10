
 --- drop view r_lotstkhists cascade  
 create or replace view r_lotstkhists as select  
lotstkhist.shelfnos_id   lotstkhist_shelfno_id,
  shelfno.shelfno_code  shelfno_code ,
  shelfno.shelfno_name  shelfno_name ,
  prjno.prjno_name  prjno_name ,
lotstkhist.starttime  lotstkhist_starttime,
  itm.unit_code  unit_code ,
  itm.unit_name  unit_name ,
  itm.itm_model  itm_model ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name ,
lotstkhist.qty_stk  lotstkhist_qty_stk,
lotstkhist.stktaking_proc  lotstkhist_stktaking_proc,
  shelfno.loca_code_shelfno  loca_code_shelfno ,
  shelfno.loca_name_shelfno  loca_name_shelfno ,
  itm.itm_unit_id  itm_unit_id ,
lotstkhist.expiredate  lotstkhist_expiredate,
lotstkhist.remark  lotstkhist_remark,
lotstkhist.persons_id_upd   lotstkhist_person_id_upd,
lotstkhist.update_ip  lotstkhist_update_ip,
lotstkhist.created_at  lotstkhist_created_at,
lotstkhist.updated_at  lotstkhist_updated_at,
lotstkhist.qty  lotstkhist_qty,
lotstkhist.id  lotstkhist_id,
lotstkhist.id id,
  itm.itm_classlist_id  itm_classlist_id ,
lotstkhist.itms_id   lotstkhist_itm_id,
lotstkhist.lotno  lotstkhist_lotno,
lotstkhist.packno  lotstkhist_packno,
lotstkhist.prjnos_id   lotstkhist_prjno_id,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
  prjno.prjno_code_chil  prjno_code_chil ,
lotstkhist.processseq  lotstkhist_processseq,
  prjno.prjno_code  prjno_code ,
  shelfno.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
lotstkhist.qty_sch  lotstkhist_qty_sch
 from lotstkhists   lotstkhist,
  r_shelfnos  shelfno ,  r_persons  person_upd ,  r_itms  itm ,  r_prjnos  prjno 
  where       lotstkhist.shelfnos_id = shelfno.id      and lotstkhist.persons_id_upd = person_upd.id      and lotstkhist.itms_id = itm.id      and lotstkhist.prjnos_id = prjno.id     ;
 DROP TABLE IF EXISTS sio.sio_r_lotstkhists;
 CREATE TABLE sio.sio_r_lotstkhists (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_lotstkhists_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,lotstkhist_processseq  numeric (38,0)
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,lotstkhist_lotno  varchar (50) 
,lotstkhist_packno  varchar (10) 
,lotstkhist_qty_stk  numeric (22,6)
,lotstkhist_qty  numeric (22,6)
,lotstkhist_qty_sch  numeric (22,6)
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,unit_code  varchar (50) 
,classlist_code  varchar (50) 
,unit_name  varchar (100) 
,classlist_name  varchar (100) 
,lotstkhist_stktaking_proc  varchar (1) 
,lotstkhist_starttime   timestamp(6) 
,lotstkhist_expiredate   date 
,itm_std  varchar (50) 
,itm_datascale  numeric (22,0)
,itm_deth  numeric (22,0)
,itm_wide  numeric (22,0)
,unit_contents  varchar (4000) 
,itm_length  numeric (22,0)
,itm_weight  numeric (22,0)
,itm_design  varchar (50) 
,itm_material  varchar (50) 
,itm_model  varchar (50) 
,shelfno_contents  varchar (4000) 
,lotstkhist_remark  varchar (4000) 
,lotstkhist_prjno_id  numeric (38,0)
,lotstkhist_id  numeric (38,0)
,id  numeric (38,0)
,lotstkhist_itm_id  numeric (38,0)
,lotstkhist_person_id_upd  numeric (38,0)
,lotstkhist_update_ip  varchar (40) 
,lotstkhist_created_at   timestamp(6) 
,lotstkhist_updated_at   timestamp(6) 
,lotstkhist_shelfno_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,itm_classlist_id  numeric (38,0)
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
 CREATE INDEX sio_r_lotstkhists_uk1 
  ON sio.sio_r_lotstkhists(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_lotstkhists_seq ;
 create sequence sio.sio_r_lotstkhists_seq ;
