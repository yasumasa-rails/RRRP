
 alter table shpschs  ADD COLUMN depdate timestamp(6);

 alter table shpschs  ADD COLUMN sno_purord varchar(50);

 alter table shpschs  ADD COLUMN lotno varchar(50);

 alter table  shpschs  ADD COLUMN qty_stk numeric(38,4);

 alter table shpschs  ADD COLUMN packno varchar(10);

 alter table shpschs  ADD COLUMN sno_prdord varchar(50);

 --- drop view r_shpschs cascade  
 create or replace view r_shpschs as select  
shpsch.id  shpsch_id,
shpsch.id id,
shpsch.transports_id   shpsch_transport_id,
shpsch.chrgs_id   shpsch_chrg_id,
shpsch.prjnos_id   shpsch_prjno_id,
  trngantt_shp.shelfno_code_fm  shelfno_code_fm_shp ,
  trngantt_shp.shelfno_name_fm  shelfno_name_fm_shp ,
  trngantt_shp.prjno_name  prjno_name_shp ,
  prjno.prjno_name  prjno_name ,
  trngantt_shp.unit_code_pare  unit_code_pare_shp ,
  trngantt_shp.unit_code  unit_code_shp ,
  trngantt_shp.unit_name_pare  unit_name_pare_shp ,
  trngantt_shp.unit_name  unit_name_shp ,
  trngantt_shp.trngantt_itm_id  trngantt_itm_id_shp ,
  trngantt_shp.itm_code_pare  itm_code_pare_shp ,
  trngantt_shp.itm_code  itm_code_shp ,
  trngantt_shp.itm_name_pare  itm_name_pare_shp ,
  trngantt_shp.itm_name  itm_name_shp ,
shpsch.expiredate  shpsch_expiredate,
shpsch.persons_id_upd   shpsch_person_id_upd,
shpsch.starttime  shpsch_starttime,
shpsch.remark  shpsch_remark,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
shpsch.update_ip  shpsch_update_ip,
shpsch.created_at  shpsch_created_at,
shpsch.updated_at  shpsch_updated_at,
shpsch.qty  shpsch_qty,
shpsch.amt  shpsch_amt,
shpsch.tax  shpsch_tax,
shpsch.price  shpsch_price,
shpsch.sno  shpsch_sno,
  trngantt_shp.loca_code_shelfno_fm  loca_code_shelfno_fm_shp ,
  trngantt_shp.loca_code_pare  loca_code_pare_shp ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  trngantt_shp.loca_name_shelfno_fm  loca_name_shelfno_fm_shp ,
  trngantt_shp.loca_name_pare  loca_name_pare_shp ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  trngantt_shp.itm_unit_id  itm_unit_id_shp ,
  trngantt_shp.itm_unit_id_pare  itm_unit_id_pare_shp ,
  trngantt_shp.itm_classlist_id  itm_classlist_id_shp ,
  trngantt_shp.itm_classlist_id_pare  itm_classlist_id_pare_shp ,
shpsch.isudate  shpsch_isudate,
  trngantt_shp.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm_shp ,
  trngantt_shp.trngantt_loca_id_fm  trngantt_loca_id_fm_shp ,
  trngantt_shp.trngantt_itm_id_pare  trngantt_itm_id_pare_shp ,
  trngantt_shp.trngantt_loca_id_pare  trngantt_loca_id_pare_shp ,
shpsch.gno  shpsch_gno,
shpsch.trngantts_id_shp   shpsch_trngantt_id_shp,
shpsch.crrs_id   shpsch_crr_id,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  trngantt_shp.classlist_code_pare  classlist_code_pare_shp ,
  trngantt_shp.classlist_code  classlist_code_shp ,
shpsch.depdate  shpsch_depdate,
shpsch.lotno  shpsch_lotno,
shpsch.packno  shpsch_packno,
shpsch.sno_purord  shpsch_sno_purord,
shpsch.sno_prdord  shpsch_sno_prdord,
shpsch.qty_stk  shpsch_qty_stk,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
shpsch.qty_case  shpsch_qty_case,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
shpsch.contract_price  shpsch_contract_price,
  trngantt_shp.classlist_name_pare  classlist_name_pare_shp ,
  trngantt_shp.classlist_name  classlist_name_shp ,
  trngantt_shp.prjno_code_chil  prjno_code_chil_shp ,
  prjno.prjno_code_chil  prjno_code_chil ,
  trngantt_shp.prjno_code  prjno_code_shp ,
  prjno.prjno_code  prjno_code ,
shpsch.duedate  shpsch_duedate,
  trngantt_shp.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm_shp ,
  trngantt_shp.trngantt_prjno_id  trngantt_prjno_id_shp ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
shpsch.manual  shpsch_manual
 from shpschs   shpsch,
  r_transports  transport ,  r_chrgs  chrg ,  r_prjnos  prjno ,  r_persons  person_upd ,  r_trngantts  trngantt_shp ,  r_crrs  crr 
  where       shpsch.transports_id = transport.id      and shpsch.chrgs_id = chrg.id      and shpsch.prjnos_id = prjno.id      and shpsch.persons_id_upd = person_upd.id      and shpsch.trngantts_id_shp = trngantt_shp.id      and shpsch.crrs_id = crr.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shpschs;
 CREATE TABLE sio.sio_r_shpschs (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_shpschs_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,shpsch_gno  varchar (40) 
,shpsch_sno  varchar (40) 
,prjno_code_chil  varchar (50) 
,prjno_code_chil_shp  varchar (50) 
,classlist_name_shp  varchar (100) 
,shelfno_code_fm_shp  varchar (50) 
,classlist_name_pare_shp  varchar (100) 
,shelfno_name_fm_shp  varchar (100) 
,prjno_name_shp  varchar (100) 
,prjno_name  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,unit_code_pare_shp  varchar (50) 
,unit_code_shp  varchar (50) 
,unit_name_pare_shp  varchar (100) 
,unit_name_shp  varchar (100) 
,crr_name  varchar (100) 
,crr_code  varchar (50) 
,classlist_code_shp  varchar (50) 
,classlist_code_pare_shp  varchar (50) 
,itm_code_pare_shp  varchar (50) 
,itm_code_shp  varchar (50) 
,itm_name_pare_shp  varchar (100) 
,itm_name_shp  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,person_name_chrg  varchar (100) 
,person_code_chrg  varchar (50) 
,prjno_code  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,loca_name_pare_shp  varchar (100) 
,loca_name_shelfno_fm_shp  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,loca_code_shelfno_fm_shp  varchar (50) 
,loca_code_pare_shp  varchar (50) 
,prjno_code_shp  varchar (50) 
,shpsch_expiredate   date 
,shpsch_starttime   timestamp(6) 
,shpsch_qty  numeric (18,4)
,shpsch_amt  numeric (18,4)
,shpsch_tax  numeric (38,4)
,shpsch_price  numeric (38,4)
,shpsch_isudate   timestamp(6) 
,shpsch_depdate   timestamp(6) 
,shpsch_lotno  varchar (50) 
,shpsch_packno  varchar (10) 
,shpsch_sno_purord  varchar (50) 
,shpsch_sno_prdord  varchar (50) 
,shpsch_qty_stk  numeric (38,4)
,shpsch_qty_case  numeric (38,0)
,shpsch_contract_price  varchar (1) 
,shpsch_duedate   timestamp(6) 
,shpsch_manual  varchar (1) 
,trngantt_parenum_shp  numeric (22,0)
,trngantt_consumminqty_shp  numeric (22,6)
,crr_pricedecimal  numeric (22,0)
,crr_amtdecimal  numeric (22,0)
,crr_contents  varchar (4000) 
,trngantt_consumunitqty_shp  numeric (22,6)
,trngantt_chilnum_shp  numeric (22,0)
,trngantt_duedate_shp   timestamp(6) 
,trngantt_qty_shp  numeric (18,4)
,trngantt_mlevel_shp  numeric (3,0)
,trngantt_orgtblname_shp  varchar (30) 
,trngantt_key_shp  varchar (250) 
,trngantt_tblname_shp  varchar (30) 
,trngantt_tblid_shp  numeric (38,0)
,loca_tel_pare_shp  varchar (20) 
,trngantt_processseq_pare_shp  numeric (38,0)
,trngantt_paretblname_shp  varchar (30) 
,trngantt_qty_pare_shp  numeric (22,0)
,trngantt_qty_stk_pare_shp  numeric (22,0)
,trngantt_qty_stk_shp  numeric (22,0)
,scrlv_level1_chrg  varchar (1) 
,person_email_chrg  varchar (50) 
,trngantt_consumchgoverqty_shp  numeric (22,6)
,trngantt_shuffle_flg_shp  varchar (1) 
,trngantt_processseq_shp  numeric (38,0)
,trngantt_consumauto_shp  varchar (1) 
,trngantt_starttime_shp   timestamp(6) 
,trngantt_orgtblid_shp  numeric (22,0)
,trngantt_paretblid_shp  numeric (38,0)
,shpsch_remark  varchar (4000) 
,shpsch_prjno_id  numeric (38,0)
,shpsch_trngantt_id_shp  numeric (22,0)
,shpsch_crr_id  numeric (22,0)
,shpsch_chrg_id  numeric (38,0)
,shpsch_transport_id  numeric (38,0)
,id  numeric (38,0)
,shpsch_updated_at   timestamp(6) 
,shpsch_created_at   timestamp(6) 
,shpsch_update_ip  varchar (40) 
,shpsch_person_id_upd  numeric (38,0)
,shpsch_id  numeric (38,0)
,itm_unit_id_pare_shp  numeric (22,0)
,trngantt_loca_id_pare_shp  numeric (38,0)
,trngantt_itm_id_pare_shp  numeric (38,0)
,itm_classlist_id_pare_shp  numeric (38,0)
,itm_classlist_id_shp  numeric (38,0)
,itm_unit_id_shp  numeric (22,0)
,trngantt_loca_id_fm_shp  numeric (38,0)
,trngantt_shelfno_id_fm_shp  numeric (22,0)
,shelfno_loca_id_shelfno_fm_shp  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,trngantt_prjno_id_shp  numeric (22,0)
,trngantt_itm_id_shp  numeric (38,0)
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
 CREATE INDEX sio_r_shpschs_uk1 
  ON sio.sio_r_shpschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpschs_seq ;
 create sequence sio.sio_r_shpschs_seq ;
