
 --- drop view r_outamts cascade  
 create or replace view r_outamts as select  
outamt.itms_id   outamt_itm_id,
outamt.remark  outamt_remark,
outamt.created_at  outamt_created_at,
outamt.update_ip  outamt_update_ip,
outamt.amt  outamt_amt,
outamt.expiredate  outamt_expiredate,
outamt.updated_at  outamt_updated_at,
outamt.processseq  outamt_processseq,
outamt.id id,
outamt.id  outamt_id,
outamt.persons_id_upd   outamt_person_id_upd,
outamt.locas_id_to   outamt_loca_id_to,
outamt.starttime  outamt_starttime,
outamt.locas_id   outamt_loca_id,
outamt.inoutflg  outamt_inoutflg,
outamt.lotno  outamt_lotno,
outamt.packno  outamt_packno,
outamt.trngantts_id   outamt_trngantt_id,
outamt.crrs_id   outamt_crr_id,
  itm.itm_weight  itm_weight ,
  itm.itm_classlist_id  itm_classlist_id ,
  itm.unit_contents  unit_contents ,
  itm.classlist_name  classlist_name ,
  itm.classlist_contents  classlist_contents ,
  itm.classlist_code  classlist_code ,
  itm.itm_length  itm_length ,
  itm.itm_unit_id  itm_unit_id ,
  itm.itm_design  itm_design ,
  itm.itm_wide  itm_wide ,
  itm.itm_deth  itm_deth ,
  itm.itm_material  itm_material ,
  itm.itm_std  itm_std ,
  itm.itm_model  itm_model ,
  itm.itm_datascale  itm_datascale ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name ,
  loca.loca_code  loca_code ,
  loca.loca_country  loca_country ,
  loca.loca_abbr  loca_abbr ,
  loca.loca_prfct  loca_prfct ,
  loca.loca_tel  loca_tel ,
  loca.loca_mail  loca_mail ,
  loca.loca_addr1  loca_addr1 ,
  loca.loca_zip  loca_zip ,
  loca.loca_fax  loca_fax ,
  loca.loca_addr2  loca_addr2 ,
  loca.loca_name  loca_name ,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_country  loca_country_to ,
  loca_to.loca_abbr  loca_abbr_to ,
  loca_to.loca_prfct  loca_prfct_to ,
  loca_to.loca_tel  loca_tel_to ,
  loca_to.loca_mail  loca_mail_to ,
  loca_to.loca_addr1  loca_addr1_to ,
  loca_to.loca_zip  loca_zip_to ,
  loca_to.loca_fax  loca_fax_to ,
  loca_to.loca_addr2  loca_addr2_to ,
  loca_to.loca_name  loca_name_to ,
  crr.crr_contents  crr_contents ,
  crr.crr_name  crr_name ,
  crr.crr_pricedecimal  crr_pricedecimal ,
  crr.crr_amtdecimal  crr_amtdecimal ,
  crr.crr_code  crr_code ,
  trngantt.trngantt_consumunitqty  trngantt_consumunitqty ,
  trngantt.trngantt_paretblname  trngantt_paretblname ,
  trngantt.trngantt_paretblid  trngantt_paretblid ,
  trngantt.trngantt_consumminqty  trngantt_consumminqty ,
  trngantt.trngantt_consumchgoverqty  trngantt_consumchgoverqty ,
  trngantt.trngantt_tblname  trngantt_tblname ,
  trngantt.trngantt_tblid  trngantt_tblid ,
  trngantt.trngantt_duedate  trngantt_duedate ,
  trngantt.trngantt_starttime  trngantt_starttime ,
  trngantt.trngantt_itm_id  trngantt_itm_id ,
  trngantt.trngantt_processseq  trngantt_processseq ,
  trngantt.trngantt_loca_id_fm  trngantt_loca_id_fm ,
  trngantt.loca_code_fm  loca_code_fm ,
  trngantt.loca_country_fm  loca_country_fm ,
  trngantt.loca_abbr_fm  loca_abbr_fm ,
  trngantt.loca_prfct_fm  loca_prfct_fm ,
  trngantt.loca_tel_fm  loca_tel_fm ,
  trngantt.loca_mail_fm  loca_mail_fm ,
  trngantt.loca_addr1_fm  loca_addr1_fm ,
  trngantt.loca_zip_fm  loca_zip_fm ,
  trngantt.loca_fax_fm  loca_fax_fm ,
  trngantt.loca_addr2_fm  loca_addr2_fm ,
  trngantt.loca_name_fm  loca_name_fm ,
  trngantt.trngantt_processseq_pare  trngantt_processseq_pare ,
  trngantt.trngantt_loca_id_pare  trngantt_loca_id_pare ,
  trngantt.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  trngantt.loca_code_pare  loca_code_pare ,
  trngantt.loca_country_pare  loca_country_pare ,
  trngantt.loca_abbr_pare  loca_abbr_pare ,
  trngantt.loca_prfct_pare  loca_prfct_pare ,
  trngantt.loca_tel_pare  loca_tel_pare ,
  trngantt.loca_mail_pare  loca_mail_pare ,
  trngantt.loca_addr1_pare  loca_addr1_pare ,
  trngantt.loca_zip_pare  loca_zip_pare ,
  trngantt.loca_fax_pare  loca_fax_pare ,
  trngantt.loca_addr2_pare  loca_addr2_pare ,
  trngantt.loca_name_pare  loca_name_pare ,
  trngantt.itm_weight_pare  itm_weight_pare ,
  trngantt.unit_contents_pare  unit_contents_pare ,
  trngantt.classlist_name_pare  classlist_name_pare ,
  trngantt.classlist_contents_pare  classlist_contents_pare ,
  trngantt.classlist_code_pare  classlist_code_pare ,
  trngantt.itm_length_pare  itm_length_pare ,
  trngantt.itm_design_pare  itm_design_pare ,
  trngantt.itm_wide_pare  itm_wide_pare ,
  trngantt.itm_deth_pare  itm_deth_pare ,
  trngantt.itm_material_pare  itm_material_pare ,
  trngantt.itm_std_pare  itm_std_pare ,
  trngantt.itm_model_pare  itm_model_pare ,
  trngantt.itm_datascale_pare  itm_datascale_pare ,
  trngantt.unit_name_pare  unit_name_pare ,
  trngantt.unit_code_pare  unit_code_pare ,
  trngantt.itm_code_pare  itm_code_pare ,
  trngantt.itm_name_pare  itm_name_pare ,
  trngantt.trngantt_qty_stk_pare  trngantt_qty_stk_pare ,
  trngantt.trngantt_qty_pare  trngantt_qty_pare ,
  trngantt.trngantt_mlevel  trngantt_mlevel ,
  trngantt.trngantt_orgtblid  trngantt_orgtblid ,
  trngantt.trngantt_consumauto  trngantt_consumauto ,
  trngantt.trngantt_shuffle_flg  trngantt_shuffle_flg ,
  trngantt.trngantt_prjno_id  trngantt_prjno_id ,
  trngantt.trngantt_key  trngantt_key ,
  trngantt.trngantt_parenum  trngantt_parenum ,
  trngantt.prjno_code  prjno_code ,
  trngantt.prjno_name  prjno_name ,
  trngantt.trngantt_chilnum  trngantt_chilnum ,
  trngantt.trngantt_qty  trngantt_qty ,
  trngantt.trngantt_qty_stk  trngantt_qty_stk ,
  trngantt.trngantt_orgtblname  trngantt_orgtblname ,
  trngantt.prjno_code_chil  prjno_code_chil 
 from outamts   outamt,
  r_itms  itm ,  r_persons  person_upd ,  r_locas  loca_to ,  r_locas  loca ,  r_trngantts  trngantt ,  r_crrs  crr 
  where       outamt.itms_id = itm.id      and outamt.persons_id_upd = person_upd.id      and outamt.locas_id_to = loca_to.id      and outamt.locas_id = loca.id      and outamt.trngantts_id = trngantt.id      and outamt.crrs_id = crr.id     ;
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
,unit_code  varchar (50) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,loca_code  varchar (50) 
,loca_name_fm  varchar (100) 
,classlist_name_pare  varchar (100) 
,loca_name  varchar (100) 
,loca_code_to  varchar (50) 
,prjno_name  varchar (100) 
,classlist_name  varchar (100) 
,prjno_code  varchar (50) 
,classlist_code  varchar (50) 
,loca_name_pare  varchar (100) 
,loca_code_fm  varchar (50) 
,loca_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,prjno_code_chil  varchar (50) 
,loca_name_to  varchar (100) 
,itm_code_pare  varchar (50) 
,crr_name  varchar (100) 
,unit_code_pare  varchar (50) 
,unit_name_pare  varchar (100) 
,crr_code  varchar (50) 
,classlist_code_pare  varchar (50) 
,unit_name  varchar (100) 
,outamt_inoutflg  varchar (3) 
,outamt_packno  varchar (10) 
,outamt_amt  numeric (18,4)
,outamt_expiredate   date 
,outamt_processseq  numeric (38,0)
,outamt_starttime   timestamp(6) 
,outamt_lotno  varchar (50) 
,crr_amtdecimal  numeric (22,0)
,trngantt_consumunitqty  numeric (22,6)
,trngantt_paretblname  varchar (30) 
,trngantt_paretblid  numeric (38,0)
,trngantt_consumminqty  numeric (22,6)
,trngantt_consumchgoverqty  numeric (22,6)
,trngantt_tblname  varchar (30) 
,trngantt_tblid  numeric (38,0)
,trngantt_duedate   timestamp(6) 
,trngantt_starttime   timestamp(6) 
,loca_addr1_fm  varchar (50) 
,itm_weight  numeric (22,0)
,unit_contents  varchar (4000) 
,classlist_contents  varchar (4000) 
,itm_length  numeric (22,0)
,itm_design  varchar (50) 
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,itm_material  varchar (50) 
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,itm_datascale  numeric (22,0)
,loca_country  varchar (20) 
,loca_abbr  varchar (50) 
,loca_prfct  varchar (20) 
,loca_tel  varchar (20) 
,loca_mail  varchar (20) 
,loca_addr1  varchar (50) 
,loca_zip  varchar (10) 
,loca_fax  varchar (20) 
,loca_addr2  varchar (50) 
,loca_country_to  varchar (20) 
,loca_abbr_to  varchar (50) 
,loca_prfct_to  varchar (20) 
,loca_tel_to  varchar (20) 
,loca_mail_to  varchar (20) 
,loca_addr1_to  varchar (50) 
,loca_zip_to  varchar (10) 
,loca_fax_to  varchar (20) 
,loca_addr2_to  varchar (50) 
,crr_contents  varchar (4000) 
,crr_pricedecimal  numeric (22,0)
,itm_design_pare  varchar (50) 
,itm_wide_pare  numeric (22,0)
,itm_deth_pare  numeric (22,0)
,itm_material_pare  varchar (50) 
,itm_std_pare  varchar (50) 
,itm_model_pare  varchar (50) 
,itm_datascale_pare  numeric (22,0)
,trngantt_qty_stk_pare  numeric (22,0)
,trngantt_qty_pare  numeric (22,0)
,trngantt_mlevel  numeric (3,0)
,trngantt_orgtblid  numeric (22,0)
,trngantt_consumauto  varchar (1) 
,trngantt_shuffle_flg  varchar (1) 
,trngantt_key  varchar (250) 
,trngantt_parenum  numeric (22,0)
,trngantt_chilnum  numeric (22,0)
,trngantt_qty  numeric (18,4)
,trngantt_qty_stk  numeric (22,0)
,trngantt_orgtblname  varchar (30) 
,trngantt_processseq  numeric (38,0)
,loca_country_fm  varchar (20) 
,loca_abbr_fm  varchar (50) 
,loca_prfct_fm  varchar (20) 
,loca_tel_fm  varchar (20) 
,loca_mail_fm  varchar (20) 
,loca_zip_fm  varchar (10) 
,loca_fax_fm  varchar (20) 
,loca_addr2_fm  varchar (50) 
,trngantt_processseq_pare  numeric (38,0)
,loca_country_pare  varchar (20) 
,loca_abbr_pare  varchar (50) 
,loca_prfct_pare  varchar (20) 
,loca_tel_pare  varchar (20) 
,loca_mail_pare  varchar (20) 
,loca_addr1_pare  varchar (50) 
,loca_zip_pare  varchar (10) 
,loca_fax_pare  varchar (20) 
,loca_addr2_pare  varchar (50) 
,itm_weight_pare  numeric (22,0)
,unit_contents_pare  varchar (4000) 
,classlist_contents_pare  varchar (4000) 
,itm_length_pare  numeric (22,0)
,outamt_remark  varchar (4000) 
,outamt_loca_id  numeric (38,0)
,outamt_update_ip  varchar (40) 
,outamt_created_at   timestamp(6) 
,outamt_loca_id_to  numeric (38,0)
,outamt_crr_id  numeric (22,0)
,outamt_trngantt_id  numeric (38,0)
,outamt_id  numeric (38,0)
,id  numeric (38,0)
,outamt_itm_id  numeric (38,0)
,outamt_updated_at   timestamp(6) 
,outamt_person_id_upd  numeric (38,0)
,trngantt_prjno_id  numeric (22,0)
,trngantt_loca_id_fm  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
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
