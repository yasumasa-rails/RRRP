
 --- drop view r_shpschs cascade  
 create or replace view r_shpschs as select  
shpsch.price  shpsch_price,
shpsch.remark  shpsch_remark,
shpsch.created_at  shpsch_created_at,
shpsch.update_ip  shpsch_update_ip,
shpsch.duedate  shpsch_duedate,
shpsch.amt  shpsch_amt,
shpsch.isudate  shpsch_isudate,
shpsch.expiredate  shpsch_expiredate,
shpsch.updated_at  shpsch_updated_at,
shpsch.qty  shpsch_qty,
shpsch.sno  shpsch_sno,
shpsch.id id,
shpsch.id  shpsch_id,
shpsch.persons_id_upd   shpsch_person_id_upd,
shpsch.tax  shpsch_tax,
shpsch.starttime  shpsch_starttime,
shpsch.prjnos_id   shpsch_prjno_id,
shpsch.manual  shpsch_manual,
shpsch.qty_case  shpsch_qty_case,
shpsch.contract_price  shpsch_contract_price,
shpsch.gno  shpsch_gno,
shpsch.chrgs_id   shpsch_chrg_id,
shpsch.crrs_id   shpsch_crr_id,
shpsch.transports_id   shpsch_transport_id,
shpsch.trngantts_id_shp   shpsch_trngantt_id_shp,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code  prjno_code ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  chrg.scrlv_level1_chrg  scrlv_level1_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_email_chrg  person_email_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  crr.crr_contents  crr_contents ,
  crr.crr_name  crr_name ,
  crr.crr_pricedecimal  crr_pricedecimal ,
  crr.crr_amtdecimal  crr_amtdecimal ,
  crr.crr_code  crr_code ,
  trngantt_shp.trngantt_consumunitqty  trngantt_consumunitqty_shp ,
  trngantt_shp.trngantt_paretblname  trngantt_paretblname_shp ,
  trngantt_shp.trngantt_paretblid  trngantt_paretblid_shp ,
  trngantt_shp.trngantt_consumminqty  trngantt_consumminqty_shp ,
  trngantt_shp.trngantt_consumchgoverqty  trngantt_consumchgoverqty_shp ,
  trngantt_shp.trngantt_tblname  trngantt_tblname_shp ,
  trngantt_shp.trngantt_tblid  trngantt_tblid_shp ,
  trngantt_shp.trngantt_duedate  trngantt_duedate_shp ,
  trngantt_shp.trngantt_starttime  trngantt_starttime_shp ,
  trngantt_shp.trngantt_itm_id  trngantt_itm_id_shp ,
  trngantt_shp.trngantt_processseq  trngantt_processseq_shp ,
  trngantt_shp.trngantt_loca_id_fm  trngantt_loca_id_fm_shp ,
  trngantt_shp.itm_weight  itm_weight_shp ,
  trngantt_shp.unit_contents  unit_contents_shp ,
  trngantt_shp.classlist_name  classlist_name_shp ,
  trngantt_shp.classlist_contents  classlist_contents_shp ,
  trngantt_shp.classlist_code  classlist_code_shp ,
  trngantt_shp.itm_length  itm_length_shp ,
  trngantt_shp.itm_design  itm_design_shp ,
  trngantt_shp.itm_wide  itm_wide_shp ,
  trngantt_shp.itm_deth  itm_deth_shp ,
  trngantt_shp.itm_material  itm_material_shp ,
  trngantt_shp.itm_std  itm_std_shp ,
  trngantt_shp.itm_model  itm_model_shp ,
  trngantt_shp.itm_datascale  itm_datascale_shp ,
  trngantt_shp.unit_name  unit_name_shp ,
  trngantt_shp.unit_code  unit_code_shp ,
  trngantt_shp.itm_code  itm_code_shp ,
  trngantt_shp.itm_name  itm_name_shp ,
  trngantt_shp.loca_code_fm  loca_code_fm_shp ,
  trngantt_shp.loca_country_fm  loca_country_fm_shp ,
  trngantt_shp.loca_abbr_fm  loca_abbr_fm_shp ,
  trngantt_shp.loca_prfct_fm  loca_prfct_fm_shp ,
  trngantt_shp.loca_tel_fm  loca_tel_fm_shp ,
  trngantt_shp.loca_mail_fm  loca_mail_fm_shp ,
  trngantt_shp.loca_addr1_fm  loca_addr1_fm_shp ,
  trngantt_shp.loca_zip_fm  loca_zip_fm_shp ,
  trngantt_shp.loca_fax_fm  loca_fax_fm_shp ,
  trngantt_shp.loca_addr2_fm  loca_addr2_fm_shp ,
  trngantt_shp.loca_name_fm  loca_name_fm_shp ,
  trngantt_shp.trngantt_processseq_pare  trngantt_processseq_pare_shp ,
  trngantt_shp.trngantt_loca_id_pare  trngantt_loca_id_pare_shp ,
  trngantt_shp.loca_code_pare  loca_code_pare_shp ,
  trngantt_shp.loca_country_pare  loca_country_pare_shp ,
  trngantt_shp.loca_abbr_pare  loca_abbr_pare_shp ,
  trngantt_shp.loca_prfct_pare  loca_prfct_pare_shp ,
  trngantt_shp.loca_tel_pare  loca_tel_pare_shp ,
  trngantt_shp.loca_mail_pare  loca_mail_pare_shp ,
  trngantt_shp.loca_addr1_pare  loca_addr1_pare_shp ,
  trngantt_shp.loca_zip_pare  loca_zip_pare_shp ,
  trngantt_shp.loca_fax_pare  loca_fax_pare_shp ,
  trngantt_shp.loca_addr2_pare  loca_addr2_pare_shp ,
  trngantt_shp.loca_name_pare  loca_name_pare_shp ,
  trngantt_shp.itm_weight_pare  itm_weight_pare_shp ,
  trngantt_shp.unit_contents_pare  unit_contents_pare_shp ,
  trngantt_shp.classlist_name_pare  classlist_name_pare_shp ,
  trngantt_shp.classlist_contents_pare  classlist_contents_pare_shp ,
  trngantt_shp.classlist_code_pare  classlist_code_pare_shp ,
  trngantt_shp.itm_length_pare  itm_length_pare_shp ,
  trngantt_shp.itm_design_pare  itm_design_pare_shp ,
  trngantt_shp.itm_wide_pare  itm_wide_pare_shp ,
  trngantt_shp.itm_deth_pare  itm_deth_pare_shp ,
  trngantt_shp.itm_material_pare  itm_material_pare_shp ,
  trngantt_shp.itm_std_pare  itm_std_pare_shp ,
  trngantt_shp.itm_model_pare  itm_model_pare_shp ,
  trngantt_shp.itm_datascale_pare  itm_datascale_pare_shp ,
  trngantt_shp.unit_name_pare  unit_name_pare_shp ,
  trngantt_shp.unit_code_pare  unit_code_pare_shp ,
  trngantt_shp.itm_code_pare  itm_code_pare_shp ,
  trngantt_shp.itm_name_pare  itm_name_pare_shp ,
  trngantt_shp.trngantt_qty_stk_pare  trngantt_qty_stk_pare_shp ,
  trngantt_shp.trngantt_qty_pare  trngantt_qty_pare_shp ,
  trngantt_shp.trngantt_mlevel  trngantt_mlevel_shp ,
  trngantt_shp.trngantt_orgtblid  trngantt_orgtblid_shp ,
  trngantt_shp.trngantt_consumauto  trngantt_consumauto_shp ,
  trngantt_shp.trngantt_shuffle_flg  trngantt_shuffle_flg_shp ,
  trngantt_shp.trngantt_key  trngantt_key_shp ,
  trngantt_shp.trngantt_parenum  trngantt_parenum_shp ,
  trngantt_shp.prjno_code  prjno_code_shp ,
  trngantt_shp.prjno_name  prjno_name_shp ,
  trngantt_shp.trngantt_chilnum  trngantt_chilnum_shp ,
  trngantt_shp.trngantt_qty  trngantt_qty_shp ,
  trngantt_shp.trngantt_qty_stk  trngantt_qty_stk_shp ,
  trngantt_shp.trngantt_orgtblname  trngantt_orgtblname_shp ,
  trngantt_shp.prjno_code_chil  prjno_code_chil_shp ,
  trngantt_shp.trngantt_itm_id_pare  trngantt_itm_id_pare_shp ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  trngantt_shp.trngantt_prjno_id  trngantt_prjno_id_shp 
 from shpschs   shpsch,
  r_persons  person_upd ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_crrs  crr ,  r_transports  transport ,  r_trngantts  trngantt_shp 
  where       shpsch.persons_id_upd = person_upd.id      and shpsch.prjnos_id = prjno.id      and shpsch.chrgs_id = chrg.id      and shpsch.crrs_id = crr.id      and shpsch.transports_id = transport.id      and shpsch.trngantts_id_shp = trngantt_shp.id     ;
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
,shpsch_sno  varchar (40) 
,shpsch_gno  varchar (40) 
,itm_code_pare_shp  varchar (50) 
,unit_code_pare_shp  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,itm_name_pare_shp  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,prjno_code_chil_shp  varchar (50) 
,person_name_chrg  varchar (100) 
,prjno_name_shp  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,person_code_chrg  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,prjno_code_shp  varchar (50) 
,crr_name  varchar (100) 
,crr_code  varchar (50) 
,loca_name_fm_shp  varchar (100) 
,loca_code_fm_shp  varchar (50) 
,unit_name_pare_shp  varchar (100) 
,classlist_name_shp  varchar (100) 
,classlist_code_shp  varchar (50) 
,classlist_code_pare_shp  varchar (50) 
,classlist_name_pare_shp  varchar (100) 
,loca_name_pare_shp  varchar (100) 
,loca_code_pare_shp  varchar (50) 
,prjno_code_chil  varchar (50) 
,prjno_name  varchar (100) 
,unit_name_shp  varchar (100) 
,unit_code_shp  varchar (50) 
,itm_code_shp  varchar (50) 
,itm_name_shp  varchar (100) 
,prjno_code  varchar (50) 
,shpsch_tax  numeric (38,4)
,shpsch_expiredate   date 
,shpsch_starttime   timestamp(6) 
,shpsch_price  numeric (38,4)
,shpsch_isudate   timestamp(6) 
,shpsch_manual  varchar (1) 
,shpsch_duedate   timestamp(6) 
,shpsch_qty_case  numeric (38,0)
,shpsch_amt  numeric (18,4)
,shpsch_contract_price  varchar (1) 
,shpsch_qty  numeric (18,4)
,trngantt_qty_pare_shp  numeric (22,0)
,scrlv_level1_chrg  varchar (1) 
,person_email_chrg  varchar (50) 
,crr_contents  varchar (4000) 
,crr_pricedecimal  numeric (22,0)
,crr_amtdecimal  numeric (22,0)
,trngantt_consumunitqty_shp  numeric (22,6)
,trngantt_paretblname_shp  varchar (30) 
,trngantt_paretblid_shp  numeric (38,0)
,trngantt_consumminqty_shp  numeric (22,6)
,trngantt_consumchgoverqty_shp  numeric (22,6)
,trngantt_tblname_shp  varchar (30) 
,trngantt_tblid_shp  numeric (38,0)
,trngantt_duedate_shp   timestamp(6) 
,trngantt_starttime_shp   timestamp(6) 
,trngantt_processseq_shp  numeric (38,0)
,itm_weight_shp  numeric (22,0)
,unit_contents_shp  varchar (4000) 
,classlist_contents_shp  varchar (4000) 
,itm_length_shp  numeric (22,0)
,itm_design_shp  varchar (50) 
,itm_wide_shp  numeric (22,0)
,itm_deth_shp  numeric (22,0)
,itm_material_shp  varchar (50) 
,itm_std_shp  varchar (50) 
,itm_model_shp  varchar (50) 
,itm_datascale_shp  numeric (22,0)
,itm_design_pare_shp  varchar (50) 
,itm_wide_pare_shp  numeric (22,0)
,itm_deth_pare_shp  numeric (22,0)
,itm_material_pare_shp  varchar (50) 
,itm_std_pare_shp  varchar (50) 
,itm_model_pare_shp  varchar (50) 
,itm_datascale_pare_shp  numeric (22,0)
,trngantt_qty_stk_pare_shp  numeric (22,0)
,trngantt_mlevel_shp  numeric (3,0)
,trngantt_orgtblid_shp  numeric (22,0)
,trngantt_consumauto_shp  varchar (1) 
,trngantt_shuffle_flg_shp  varchar (1) 
,trngantt_key_shp  varchar (250) 
,trngantt_parenum_shp  numeric (22,0)
,trngantt_chilnum_shp  numeric (22,0)
,trngantt_qty_shp  numeric (18,4)
,trngantt_qty_stk_shp  numeric (22,0)
,trngantt_orgtblname_shp  varchar (30) 
,loca_country_fm_shp  varchar (20) 
,loca_abbr_fm_shp  varchar (50) 
,loca_prfct_fm_shp  varchar (20) 
,loca_tel_fm_shp  varchar (20) 
,loca_mail_fm_shp  varchar (20) 
,loca_addr1_fm_shp  varchar (50) 
,loca_zip_fm_shp  varchar (10) 
,loca_fax_fm_shp  varchar (20) 
,loca_addr2_fm_shp  varchar (50) 
,trngantt_processseq_pare_shp  numeric (38,0)
,loca_country_pare_shp  varchar (20) 
,loca_abbr_pare_shp  varchar (50) 
,loca_prfct_pare_shp  varchar (20) 
,loca_tel_pare_shp  varchar (20) 
,loca_mail_pare_shp  varchar (20) 
,loca_addr1_pare_shp  varchar (50) 
,loca_zip_pare_shp  varchar (10) 
,loca_fax_pare_shp  varchar (20) 
,loca_addr2_pare_shp  varchar (50) 
,itm_weight_pare_shp  numeric (22,0)
,unit_contents_pare_shp  varchar (4000) 
,classlist_contents_pare_shp  varchar (4000) 
,itm_length_pare_shp  numeric (22,0)
,shpsch_remark  varchar (4000) 
,shpsch_update_ip  varchar (40) 
,shpsch_created_at   timestamp(6) 
,shpsch_updated_at   timestamp(6) 
,shpsch_person_id_upd  numeric (38,0)
,shpsch_crr_id  numeric (22,0)
,shpsch_id  numeric (38,0)
,shpsch_trngantt_id_shp  numeric (22,0)
,shpsch_chrg_id  numeric (38,0)
,id  numeric (38,0)
,shpsch_transport_id  numeric (38,0)
,shpsch_prjno_id  numeric (38,0)
,trngantt_itm_id_pare_shp  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,trngantt_itm_id_shp  numeric (38,0)
,trngantt_prjno_id_shp  numeric (22,0)
,trngantt_loca_id_pare_shp  numeric (38,0)
,trngantt_loca_id_fm_shp  numeric (38,0)
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
