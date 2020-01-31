
 --- drop view r_custrcvplcs cascade  
 create or replace view r_custrcvplcs as select  
  loca_custrcvplc.loca_abbr  loca_abbr_custrcvplc ,
  loca_custrcvplc.loca_zip  loca_zip_custrcvplc ,
  loca_custrcvplc.loca_country  loca_country_custrcvplc ,
  loca_custrcvplc.loca_prfct  loca_prfct_custrcvplc ,
  loca_custrcvplc.loca_addr1  loca_addr1_custrcvplc ,
  loca_custrcvplc.loca_addr2  loca_addr2_custrcvplc ,
  loca_custrcvplc.loca_tel  loca_tel_custrcvplc ,
  loca_custrcvplc.loca_fax  loca_fax_custrcvplc ,
  loca_custrcvplc.loca_mail  loca_mail_custrcvplc ,
  loca_custrcvplc.loca_code  loca_code_custrcvplc ,
  loca_custrcvplc.loca_name  loca_name_custrcvplc ,
custrcvplc.locas_id_custrcvplc   custrcvplc_loca_id_custrcvplc,
custrcvplc.contents  custrcvplc_contents,
custrcvplc.remark  custrcvplc_remark,
custrcvplc.expiredate  custrcvplc_expiredate,
custrcvplc.persons_id_upd   custrcvplc_person_id_upd,
custrcvplc.update_ip  custrcvplc_update_ip,
custrcvplc.created_at  custrcvplc_created_at,
custrcvplc.updated_at  custrcvplc_updated_at,
custrcvplc.id  custrcvplc_id,
custrcvplc.id id
 from custrcvplcs   custrcvplc,
  r_locas  loca_custrcvplc ,  r_persons  person_upd 
  where       custrcvplc.locas_id_custrcvplc = loca_custrcvplc.id      and custrcvplc.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custrcvplcs;
 CREATE TABLE sio.sio_r_custrcvplcs (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_custrcvplcs_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,loca_code_custrcvplc  varchar (50) 
,loca_name_custrcvplc  varchar (100) 
,custrcvplc_expiredate   date 
,loca_prfct_custrcvplc  varchar (20) 
,loca_addr1_custrcvplc  varchar (50) 
,loca_addr2_custrcvplc  varchar (50) 
,loca_tel_custrcvplc  varchar (20) 
,loca_fax_custrcvplc  varchar (20) 
,loca_mail_custrcvplc  varchar (20) 
,loca_abbr_custrcvplc  varchar (50) 
,loca_zip_custrcvplc  varchar (10) 
,loca_country_custrcvplc  varchar (20) 
,custrcvplc_contents  varchar (4000) 
,custrcvplc_remark  varchar (4000) 
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,custrcvplc_person_id_upd  numeric (38,0)
,custrcvplc_update_ip  varchar (40) 
,custrcvplc_created_at   timestamp(6) 
,custrcvplc_updated_at   timestamp(6) 
,custrcvplc_id  numeric (38,0)
,id  numeric (38,0)
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
 CREATE INDEX sio_r_custrcvplcs_uk1 
  ON sio.sio_r_custrcvplcs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custrcvplcs_seq ;
 create sequence sio.sio_r_custrcvplcs_seq ;
