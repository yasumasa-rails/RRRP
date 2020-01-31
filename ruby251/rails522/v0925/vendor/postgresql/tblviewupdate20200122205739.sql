
 --- drop view r_instks cascade  
 create or replace view r_instks as select  
  trngantt.trngantt_consumauto  trngantt_consumauto ,
instk.qty  instk_qty,
  trngantt.shelfno_code_fm  shelfno_code_fm ,
  shelfno_in.shelfno_code  shelfno_code_in ,
  trngantt.trngantt_processseq  trngantt_processseq ,
  trngantt.shelfno_name_fm  shelfno_name_fm ,
  shelfno_in.shelfno_name  shelfno_name_in ,
  trngantt.prjno_name  prjno_name ,
  trngantt.trngantt_starttime  trngantt_starttime ,
  trngantt.unit_code_pare  unit_code_pare ,
  trngantt.unit_code  unit_code ,
  trngantt.unit_name_pare  unit_name_pare ,
  trngantt.unit_name  unit_name ,
  trngantt.trngantt_consumunitqty  trngantt_consumunitqty ,
  trngantt.trngantt_consumminqty  trngantt_consumminqty ,
  trngantt.trngantt_itm_id  trngantt_itm_id ,
  trngantt.trngantt_shuffle_flg  trngantt_shuffle_flg ,
  trngantt.itm_code_pare  itm_code_pare ,
  trngantt.itm_code  itm_code ,
  trngantt.itm_name_pare  itm_name_pare ,
  trngantt.itm_name  itm_name ,
  trngantt.trngantt_consumchgoverqty  trngantt_consumchgoverqty ,
  trngantt.trngantt_qty_stk  trngantt_qty_stk ,
  trngantt.trngantt_tblname  trngantt_tblname ,
  trngantt.trngantt_tblid  trngantt_tblid ,
  trngantt.loca_tel_pare  loca_tel_pare ,
  trngantt.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  shelfno_in.loca_code_shelfno  loca_code_shelfno_in ,
  trngantt.loca_code_pare  loca_code_pare ,
  trngantt.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  shelfno_in.loca_name_shelfno  loca_name_shelfno_in ,
  trngantt.loca_name_pare  loca_name_pare ,
  trngantt.itm_unit_id_pare  itm_unit_id_pare ,
  trngantt.itm_unit_id  itm_unit_id ,
  trngantt.itm_classlist_id_pare  itm_classlist_id_pare ,
  trngantt.itm_classlist_id  itm_classlist_id ,
  trngantt.trngantt_parenum  trngantt_parenum ,
  trngantt.trngantt_chilnum  trngantt_chilnum ,
  trngantt.trngantt_duedate  trngantt_duedate ,
  trngantt.trngantt_qty  trngantt_qty ,
  trngantt.trngantt_mlevel  trngantt_mlevel ,
  trngantt.trngantt_orgtblname  trngantt_orgtblname ,
  trngantt.trngantt_key  trngantt_key ,
  trngantt.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
instk.id  instk_id,
instk.id id,
instk.starttime  instk_starttime,
instk.qty_stk  instk_qty_stk,
instk.lotno  instk_lotno,
instk.packno  instk_packno,
instk.inoutflg  instk_inoutflg,
instk.expiredate  instk_expiredate,
instk.remark  instk_remark,
instk.persons_id_upd   instk_person_id_upd,
instk.created_at  instk_created_at,
instk.updated_at  instk_updated_at,
instk.update_ip  instk_update_ip,
  trngantt.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  trngantt.trngantt_processseq_pare  trngantt_processseq_pare ,
  trngantt.trngantt_loca_id_pare  trngantt_loca_id_pare ,
instk.trngantts_id   instk_trngantt_id,
  trngantt.trngantt_qty_pare  trngantt_qty_pare ,
  trngantt.trngantt_qty_stk_pare  trngantt_qty_stk_pare ,
instk.shelfnos_id_in   instk_shelfno_id_in,
  trngantt.classlist_code_pare  classlist_code_pare ,
  trngantt.classlist_code  classlist_code ,
  trngantt.classlist_name_pare  classlist_name_pare ,
  trngantt.classlist_name  classlist_name ,
  trngantt.trngantt_paretblname  trngantt_paretblname ,
  trngantt.trngantt_paretblid  trngantt_paretblid ,
  trngantt.prjno_code_chil  prjno_code_chil ,
  trngantt.trngantt_orgtblid  trngantt_orgtblid ,
  trngantt.prjno_code  prjno_code ,
  trngantt.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  shelfno_in.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_in ,
  shelfno_in.shelfno_contents  shelfno_contents_in ,
  trngantt.trngantt_prjno_id  trngantt_prjno_id 
 from instks   instk,
  r_persons  person_upd ,  r_trngantts  trngantt ,  r_shelfnos  shelfno_in 
  where       instk.persons_id_upd = person_upd.id      and instk.trngantts_id = trngantt.id      and instk.shelfnos_id_in = shelfno_in.id     ;
 DROP TABLE IF EXISTS sio.sio_r_instks;
 CREATE TABLE sio.sio_r_instks (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_instks_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,loca_code_shelfno_in  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,shelfno_code_fm  varchar (50) 
,shelfno_code_in  varchar (50) 
,prjno_code  varchar (50) 
,shelfno_name_fm  varchar (100) 
,shelfno_name_in  varchar (100) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,unit_code_pare  varchar (50) 
,unit_code  varchar (50) 
,unit_name_pare  varchar (100) 
,unit_name  varchar (100) 
,classlist_name  varchar (100) 
,classlist_name_pare  varchar (100) 
,classlist_code  varchar (50) 
,classlist_code_pare  varchar (50) 
,itm_code_pare  varchar (50) 
,itm_code  varchar (50) 
,itm_name_pare  varchar (100) 
,itm_name  varchar (100) 
,loca_name_pare  varchar (100) 
,loca_name_shelfno_in  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,loca_code_pare  varchar (50) 
,instk_qty_stk  numeric (38,4)
,instk_qty  numeric (18,4)
,instk_starttime   timestamp(6) 
,instk_lotno  varchar (50) 
,instk_packno  varchar (10) 
,instk_inoutflg  varchar (3) 
,instk_expiredate   date 
,trngantt_key  varchar (250) 
,trngantt_mlevel  numeric (3,0)
,trngantt_orgtblname  varchar (30) 
,trngantt_processseq  numeric (38,0)
,trngantt_consumauto  varchar (1) 
,shelfno_contents_in  varchar (4000) 
,trngantt_processseq_pare  numeric (38,0)
,trngantt_qty_pare  numeric (22,0)
,trngantt_qty_stk_pare  numeric (22,0)
,trngantt_shuffle_flg  varchar (1) 
,trngantt_consumminqty  numeric (22,6)
,trngantt_consumunitqty  numeric (22,6)
,trngantt_paretblname  varchar (30) 
,trngantt_paretblid  numeric (38,0)
,trngantt_starttime   timestamp(6) 
,trngantt_orgtblid  numeric (22,0)
,loca_tel_pare  varchar (20) 
,trngantt_tblid  numeric (38,0)
,trngantt_tblname  varchar (30) 
,trngantt_qty_stk  numeric (22,0)
,trngantt_consumchgoverqty  numeric (22,6)
,trngantt_parenum  numeric (22,0)
,trngantt_chilnum  numeric (22,0)
,trngantt_duedate   timestamp(6) 
,trngantt_qty  numeric (18,4)
,instk_remark  varchar (4000) 
,id  numeric (38,0)
,instk_person_id_upd  numeric (38,0)
,instk_trngantt_id  numeric (38,0)
,instk_id  numeric (38,0)
,instk_updated_at   timestamp(6) 
,instk_shelfno_id_in  numeric (38,0)
,instk_update_ip  varchar (40) 
,instk_created_at   timestamp(6) 
,shelfno_loca_id_shelfno_in  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,itm_classlist_id_pare  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,itm_unit_id  numeric (22,0)
,trngantt_loca_id_pare  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
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
 CREATE INDEX sio_r_instks_uk1 
  ON sio.sio_r_instks(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_instks_seq ;
 create sequence sio.sio_r_instks_seq ;
