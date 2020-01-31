
 --- drop view r_shelfnos cascade  
 create or replace view r_shelfnos as select  
shelfno.code  shelfno_code,
shelfno.name  shelfno_name,
  loca_shelfno.loca_abbr  loca_abbr_shelfno ,
  loca_shelfno.loca_zip  loca_zip_shelfno ,
  loca_shelfno.loca_country  loca_country_shelfno ,
  loca_shelfno.loca_prfct  loca_prfct_shelfno ,
  loca_shelfno.loca_addr1  loca_addr1_shelfno ,
  loca_shelfno.loca_addr2  loca_addr2_shelfno ,
  loca_shelfno.loca_tel  loca_tel_shelfno ,
  loca_shelfno.loca_fax  loca_fax_shelfno ,
  loca_shelfno.loca_mail  loca_mail_shelfno ,
  loca_shelfno.loca_code  loca_code_shelfno ,
  loca_shelfno.loca_name  loca_name_shelfno ,
shelfno.locas_id_shelfno   shelfno_loca_id_shelfno,
shelfno.update_ip  shelfno_update_ip,
shelfno.contents  shelfno_contents,
shelfno.remark  shelfno_remark,
shelfno.expiredate  shelfno_expiredate,
shelfno.persons_id_upd   shelfno_person_id_upd,
shelfno.created_at  shelfno_created_at,
shelfno.updated_at  shelfno_updated_at,
shelfno.id  shelfno_id,
shelfno.id id
 from shelfnos   shelfno,
  r_locas  loca_shelfno ,  r_persons  person_upd 
  where       shelfno.locas_id_shelfno = loca_shelfno.id      and shelfno.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shelfnos;
 CREATE TABLE sio.sio_r_shelfnos (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_shelfnos_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,shelfno_name  varchar (100) 
,shelfno_code  varchar (50) 
,loca_name_shelfno  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_prfct_shelfno  varchar (20) 
,loca_addr1_shelfno  varchar (50) 
,loca_addr2_shelfno  varchar (50) 
,loca_tel_shelfno  varchar (20) 
,loca_fax_shelfno  varchar (20) 
,loca_mail_shelfno  varchar (20) 
,loca_country_shelfno  varchar (20) 
,loca_zip_shelfno  varchar (10) 
,loca_abbr_shelfno  varchar (50) 
,shelfno_remark  varchar (4000) 
,shelfno_contents  varchar (4000) 
,shelfno_expiredate   date 
,id  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,shelfno_update_ip  varchar (40) 
,shelfno_person_id_upd  numeric (38,0)
,shelfno_created_at   timestamp(6) 
,shelfno_updated_at   timestamp(6) 
,shelfno_id  numeric (38,0)
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
 CREATE INDEX sio_r_shelfnos_uk1 
  ON sio.sio_r_shelfnos(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shelfnos_seq ;
 create sequence sio.sio_r_shelfnos_seq ;
