
  drop view if  exists r_custrcvplcs cascade ; 
 create or replace view r_custrcvplcs as select  
  loca_custrcvplc.loca_code  loca_code_custrcvplc ,
  loca_custrcvplc.loca_name  loca_name_custrcvplc ,
custrcvplc.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
custrcvplc.contents  custrcvplc_contents,
custrcvplc.locas_id_custrcvplc   custrcvplc_loca_id_custrcvplc,
custrcvplc.id  custrcvplc_id,
custrcvplc.remark  custrcvplc_remark,
custrcvplc.expiredate  custrcvplc_expiredate,
custrcvplc.update_ip  custrcvplc_update_ip,
custrcvplc.created_at  custrcvplc_created_at,
custrcvplc.updated_at  custrcvplc_updated_at,
custrcvplc.persons_id_upd   custrcvplc_person_id_upd,
custrcvplc.stktaking_proc  custrcvplc_stktaking_proc
 from custrcvplcs   custrcvplc,
  r_locas  loca_custrcvplc ,  r_persons  person_upd 
  where       custrcvplc.locas_id_custrcvplc = loca_custrcvplc.id      and custrcvplc.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custrcvplcs;
 CREATE TABLE sio.sio_r_custrcvplcs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custrcvplcs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,custrcvplc_stktaking_proc  varchar (1) 
,custrcvplc_expiredate   date 
,loca_code_custrcvplc  varchar (50) 
,loca_name_custrcvplc  varchar (100) 
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,custrcvplc_contents  varchar (4000) 
,custrcvplc_remark  varchar (4000) 
,id  numeric (38,0)
,custrcvplc_update_ip  varchar (40) 
,custrcvplc_created_at   timestamp(6) 
,custrcvplc_updated_at   timestamp(6) 
,custrcvplc_person_id_upd  numeric (38,0)
,custrcvplc_id  numeric (38,0)
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
 CREATE INDEX sio_r_custrcvplcs_uk1 
  ON sio.sio_r_custrcvplcs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custrcvplcs_seq ;
 create sequence sio.sio_r_custrcvplcs_seq ;
  drop view if  exists r_custwhs cascade ; 
 create or replace view r_custwhs as select  
  custrcvplc.loca_code_custrcvplc  loca_code_custrcvplc ,
  custrcvplc.loca_name_custrcvplc  loca_name_custrcvplc ,
custwh.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  custrcvplc.custrcvplc_loca_id_custrcvplc  custrcvplc_loca_id_custrcvplc ,
custwh.qty_sch  custwh_qty_sch,
custwh.duedate  custwh_duedate,
custwh.remark  custwh_remark,
custwh.created_at  custwh_created_at,
custwh.update_ip  custwh_update_ip,
custwh.expiredate  custwh_expiredate,
custwh.updated_at  custwh_updated_at,
custwh.qty  custwh_qty,
custwh.persons_id_upd   custwh_person_id_upd,
custwh.inoutflg  custwh_inoutflg,
custwh.lotno  custwh_lotno,
custwh.qty_stk  custwh_qty_stk,
custwh.packno  custwh_packno,
custwh.custrcvplcs_id   custwh_custrcvplc_id
 from custwhs   custwh,
  r_persons  person_upd ,  r_custrcvplcs  custrcvplc 
  where       custwh.persons_id_upd = person_upd.id      and custwh.custrcvplcs_id = custrcvplc.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custwhs;
 CREATE TABLE sio.sio_r_custwhs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custwhs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,loca_code_custrcvplc  varchar (50) 
,loca_name_custrcvplc  varchar (100) 
,custwh_remark  varchar (4000) 
,custwh_created_at   timestamp(6) 
,custwh_update_ip  varchar (40) 
,custwh_expiredate   date 
,custwh_updated_at   timestamp(6) 
,custwh_qty  numeric (22,6)
,custwh_custrcvplc_id  numeric (38,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,custwh_qty_sch  numeric (22,6)
,custwh_duedate   timestamp(6) 
,custwh_qty_stk  numeric (22,6)
,custwh_packno  varchar (10) 
,custwh_inoutflg  varchar (20) 
,custwh_lotno  varchar (50) 
,id  numeric (38,0)
,custwh_person_id_upd  numeric (22,0)
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
 CREATE INDEX sio_r_custwhs_uk1 
  ON sio.sio_r_custwhs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custwhs_seq ;
 create sequence sio.sio_r_custwhs_seq ;
