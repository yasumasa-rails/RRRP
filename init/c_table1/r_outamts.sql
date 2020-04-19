
 --- drop view r_outamts cascade  
 create or replace view r_outamts as select  
  trngantt.shelfno_code_fm  shelfno_code_fm ,
  trngantt.shelfno_name_fm  shelfno_name_fm ,
  trngantt.prjno_name  prjno_name ,
  trngantt.unit_code_pare  unit_code_pare ,
  trngantt.unit_code  unit_code ,
  trngantt.unit_name_pare  unit_name_pare ,
  trngantt.unit_name  unit_name ,
  trngantt.trngantt_itm_id  trngantt_itm_id ,
  trngantt.itm_code_pare  itm_code_pare ,
  trngantt.itm_code  itm_code ,
  trngantt.itm_name_pare  itm_name_pare ,
  trngantt.itm_name  itm_name ,
  trngantt.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  loca_out.loca_code  loca_code_out ,
  trngantt.loca_code_pare  loca_code_pare ,
  trngantt.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  loca_out.loca_name  loca_name_out ,
  trngantt.loca_name_pare  loca_name_pare ,
  trngantt.itm_unit_id_pare  itm_unit_id_pare ,
  trngantt.itm_unit_id  itm_unit_id ,
  trngantt.itm_classlist_id_pare  itm_classlist_id_pare ,
  trngantt.itm_classlist_id  itm_classlist_id ,
  trngantt.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  trngantt.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  trngantt.trngantt_loca_id_pare  trngantt_loca_id_pare ,
outamt.id  outamt_id,
outamt.id id,
outamt.starttime  outamt_starttime,
outamt.amt  outamt_amt,
outamt.crrs_id   outamt_crr_id,
outamt.inoutflg  outamt_inoutflg,
outamt.expiredate  outamt_expiredate,
outamt.remark  outamt_remark,
outamt.persons_id_upd   outamt_person_id_upd,
outamt.created_at  outamt_created_at,
outamt.updated_at  outamt_updated_at,
outamt.update_ip  outamt_update_ip,
outamt.trngantts_id   outamt_trngantt_id,
outamt.locas_id_out   outamt_loca_id_out,
  trngantt.classlist_code_pare  classlist_code_pare ,
  trngantt.classlist_code  classlist_code ,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
  trngantt.classlist_name_pare  classlist_name_pare ,
  trngantt.classlist_name  classlist_name ,
  trngantt.prjno_code_chil  prjno_code_chil ,
  trngantt.prjno_code  prjno_code ,
  trngantt.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  trngantt.trngantt_prjno_id  trngantt_prjno_id 
 from outamts   outamt,
  r_crrs  crr ,  r_persons  person_upd ,  r_trngantts  trngantt ,  r_locas  loca_out 
  where       outamt.crrs_id = crr.id      and outamt.persons_id_upd = person_upd.id      and outamt.trngantts_id = trngantt.id      and outamt.locas_id_out = loca_out.id     ;
 DROP TABLE IF EXISTS sio.sio_r_outamts;
 CREATE TABLE sio.sio_r_outamts (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_outamts_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,itm_name_pare  varchar (100) 
,unit_code_pare  varchar (50) 
,unit_code  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_out  varchar (50) 
,loca_code_pare  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_out  varchar (100) 
,loca_name_pare  varchar (100) 
,prjno_code_chil  varchar (50) 
,classlist_name  varchar (100) 
,classlist_name_pare  varchar (100) 
,crr_name  varchar (100) 
,unit_name_pare  varchar (100) 
,unit_name  varchar (100) 
,shelfno_name_fm  varchar (100) 
,prjno_name  varchar (100) 
,prjno_code  varchar (50) 
,shelfno_code_fm  varchar (50) 
,itm_code_pare  varchar (50) 
,crr_code  varchar (50) 
,classlist_code  varchar (50) 
,itm_code  varchar (50) 
,classlist_code_pare  varchar (50) 
,itm_name  varchar (100) 
,outamt_inoutflg  varchar (3) 
,outamt_starttime   timestamp(6) 
,outamt_amt  numeric (18,4)
,outamt_expiredate   date 
,trngantt_tblname  varchar (30) 
,trngantt_processseq  numeric (38,0)
,trngantt_starttime   timestamp(6) 
,trngantt_consumunitqty  numeric (22,6)
,trngantt_consumminqty  numeric (22,6)
,trngantt_shuffle_flg  varchar (1) 
,trngantt_consumchgoverqty  numeric (22,6)
,trngantt_qty_stk  numeric (22,0)
,trngantt_consumauto  varchar (1) 
,trngantt_tblid  numeric (38,0)
,loca_abbr_out  varchar (50) 
,loca_zip_out  varchar (10) 
,loca_country_out  varchar (20) 
,loca_prfct_out  varchar (20) 
,loca_addr1_out  varchar (50) 
,loca_addr2_out  varchar (50) 
,loca_tel_out  varchar (20) 
,loca_tel_pare  varchar (20) 
,loca_fax_out  varchar (20) 
,loca_mail_out  varchar (20) 
,trngantt_parenum  numeric (22,0)
,trngantt_chilnum  numeric (22,0)
,trngantt_duedate   timestamp(6) 
,trngantt_qty  numeric (18,4)
,trngantt_mlevel  numeric (3,0)
,trngantt_orgtblname  varchar (30) 
,trngantt_key  varchar (250) 
,trngantt_processseq_pare  numeric (38,0)
,trngantt_qty_pare  numeric (22,6)
,trngantt_qty_stk_pare  numeric (22,6)
,crr_pricedecimal  numeric (22,0)
,crr_amtdecimal  numeric (22,0)
,crr_contents  varchar (4000) 
,trngantt_paretblname  varchar (30) 
,trngantt_paretblid  numeric (38,0)
,trngantt_orgtblid  numeric (22,0)
,outamt_remark  varchar (4000) 
,outamt_trngantt_id  numeric (38,0)
,outamt_loca_id_out  numeric (22,0)
,outamt_crr_id  numeric (22,0)
,id  numeric (38,0)
,outamt_id  numeric (38,0)
,outamt_person_id_upd  numeric (38,0)
,outamt_created_at   timestamp(6) 
,outamt_updated_at   timestamp(6) 
,outamt_update_ip  varchar (40) 
,itm_classlist_id  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,trngantt_prjno_id  numeric (38,0)
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
 CREATE INDEX sio_r_outamts_uk1 
  ON sio.sio_r_outamts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_outamts_seq ;
 create sequence sio.sio_r_outamts_seq ;
