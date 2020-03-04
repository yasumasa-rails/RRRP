﻿
 --- drop view r_inamts cascade  
 create or replace view r_inamts as select  
  trngantt.trngantt_consumauto  trngantt_consumauto ,
  trngantt.trngantt_processseq  trngantt_processseq ,
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
  trngantt.itm_std_pare  itm_std_pare ,
  trngantt.itm_std  itm_std ,
  trngantt.itm_model_pare  itm_model_pare ,
  trngantt.itm_model  itm_model ,
  trngantt.itm_material_pare  itm_material_pare ,
  trngantt.itm_material  itm_material ,
  trngantt.itm_design_pare  itm_design_pare ,
  trngantt.itm_design  itm_design ,
  trngantt.itm_weight_pare  itm_weight_pare ,
  trngantt.itm_weight  itm_weight ,
  trngantt.itm_length_pare  itm_length_pare ,
  trngantt.itm_length  itm_length ,
  trngantt.itm_wide_pare  itm_wide_pare ,
  trngantt.itm_wide  itm_wide ,
  trngantt.itm_deth_pare  itm_deth_pare ,
  trngantt.itm_deth  itm_deth ,
  trngantt.itm_code_pare  itm_code_pare ,
  trngantt.itm_code  itm_code ,
  trngantt.itm_name_pare  itm_name_pare ,
  trngantt.itm_name  itm_name ,
  trngantt.trngantt_consumchgoverqty  trngantt_consumchgoverqty ,
  trngantt.trngantt_qty_stk  trngantt_qty_stk ,
  trngantt.trngantt_tblname  trngantt_tblname ,
  trngantt.trngantt_tblid  trngantt_tblid ,
  loca_in.loca_abbr  loca_abbr_in ,
  trngantt.loca_abbr_fm  loca_abbr_fm ,
  trngantt.loca_abbr_pare  loca_abbr_pare ,
  loca_in.loca_zip  loca_zip_in ,
  trngantt.loca_zip_fm  loca_zip_fm ,
  trngantt.loca_zip_pare  loca_zip_pare ,
  loca_in.loca_country  loca_country_in ,
  trngantt.loca_country_fm  loca_country_fm ,
  trngantt.loca_country_pare  loca_country_pare ,
  loca_in.loca_prfct  loca_prfct_in ,
  trngantt.loca_prfct_fm  loca_prfct_fm ,
  trngantt.loca_prfct_pare  loca_prfct_pare ,
  loca_in.loca_addr1  loca_addr1_in ,
  trngantt.loca_addr1_fm  loca_addr1_fm ,
  trngantt.loca_addr1_pare  loca_addr1_pare ,
  loca_in.loca_addr2  loca_addr2_in ,
  trngantt.loca_addr2_fm  loca_addr2_fm ,
  trngantt.loca_addr2_pare  loca_addr2_pare ,
  loca_in.loca_tel  loca_tel_in ,
  trngantt.loca_tel_fm  loca_tel_fm ,
  trngantt.loca_tel_pare  loca_tel_pare ,
  loca_in.loca_fax  loca_fax_in ,
  trngantt.loca_fax_fm  loca_fax_fm ,
  trngantt.loca_fax_pare  loca_fax_pare ,
  loca_in.loca_mail  loca_mail_in ,
  trngantt.loca_mail_fm  loca_mail_fm ,
  trngantt.loca_mail_pare  loca_mail_pare ,
  loca_in.loca_code  loca_code_in ,
  trngantt.loca_code_fm  loca_code_fm ,
  trngantt.loca_code_pare  loca_code_pare ,
  loca_in.loca_name  loca_name_in ,
  trngantt.loca_name_fm  loca_name_fm ,
  trngantt.loca_name_pare  loca_name_pare ,
  trngantt.itm_datascale_pare  itm_datascale_pare ,
  trngantt.itm_datascale  itm_datascale ,
  trngantt.trngantt_parenum  trngantt_parenum ,
  trngantt.trngantt_chilnum  trngantt_chilnum ,
  trngantt.trngantt_duedate  trngantt_duedate ,
  trngantt.trngantt_qty  trngantt_qty ,
  trngantt.trngantt_mlevel  trngantt_mlevel ,
  trngantt.trngantt_orgtblname  trngantt_orgtblname ,
  trngantt.trngantt_key  trngantt_key ,
  trngantt.trngantt_loca_id_fm  trngantt_loca_id_fm ,
  trngantt.unit_contents_pare  unit_contents_pare ,
  trngantt.unit_contents  unit_contents ,
  trngantt.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  trngantt.trngantt_processseq_pare  trngantt_processseq_pare ,
  trngantt.trngantt_loca_id_pare  trngantt_loca_id_pare ,
inamt.id  inamt_id,
inamt.id id,
inamt.starttime  inamt_starttime,
inamt.amt  inamt_amt,
inamt.crrs_id   inamt_crr_id,
inamt.inoutflg  inamt_inoutflg,
inamt.expiredate  inamt_expiredate,
inamt.remark  inamt_remark,
inamt.persons_id_upd   inamt_person_id_upd,
inamt.created_at  inamt_created_at,
  trngantt.trngantt_qty_pare  trngantt_qty_pare ,
  trngantt.trngantt_qty_stk_pare  trngantt_qty_stk_pare ,
inamt.updated_at  inamt_updated_at,
inamt.update_ip  inamt_update_ip,
inamt.trngantts_id   inamt_trngantt_id,
inamt.locas_id_in   inamt_loca_id_in,
  trngantt.classlist_code_pare  classlist_code_pare ,
  trngantt.classlist_code  classlist_code ,
  crr.crr_code  crr_code ,
  crr.crr_pricedecimal  crr_pricedecimal ,
  crr.crr_amtdecimal  crr_amtdecimal ,
  crr.crr_contents  crr_contents ,
  crr.crr_name  crr_name ,
  trngantt.classlist_contents_pare  classlist_contents_pare ,
  trngantt.classlist_contents  classlist_contents ,
  trngantt.classlist_name_pare  classlist_name_pare ,
  trngantt.classlist_name  classlist_name ,
  trngantt.trngantt_paretblname  trngantt_paretblname ,
  trngantt.trngantt_paretblid  trngantt_paretblid ,
  trngantt.prjno_code_chil  prjno_code_chil ,
  trngantt.trngantt_orgtblid  trngantt_orgtblid ,
  trngantt.prjno_code  prjno_code ,
  trngantt.trngantt_prjno_id  trngantt_prjno_id 
 from inamts   inamt,
  r_crrs  crr ,  r_persons  person_upd ,  r_trngantts  trngantt ,  r_locas  loca_in 
  where       inamt.crrs_id = crr.id      and inamt.persons_id_upd = person_upd.id      and inamt.trngantts_id = trngantt.id      and inamt.locas_id_in = loca_in.id     ;
 DROP TABLE IF EXISTS sio.sio_r_inamts;
 CREATE TABLE sio.sio_r_inamts (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_inamts_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,classlist_code_pare  varchar (50) 
,loca_name_in  varchar (100) 
,loca_name_fm  varchar (100) 
,loca_name_pare  varchar (100) 
,unit_code  varchar (50) 
,unit_name_pare  varchar (100) 
,unit_name  varchar (100) 
,prjno_name  varchar (100) 
,unit_code_pare  varchar (50) 
,itm_code_pare  varchar (50) 
,itm_code  varchar (50) 
,itm_name_pare  varchar (100) 
,itm_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,prjno_code  varchar (50) 
,loca_code_in  varchar (50) 
,classlist_name  varchar (100) 
,loca_code_fm  varchar (50) 
,classlist_name_pare  varchar (100) 
,crr_name  varchar (100) 
,crr_code  varchar (50) 
,classlist_code  varchar (50) 
,loca_code_pare  varchar (50) 
,inamt_expiredate   date 
,inamt_inoutflg  varchar (3) 
,inamt_starttime   timestamp(6) 
,inamt_amt  numeric (18,4)
,loca_abbr_fm  varchar (50) 
,loca_abbr_pare  varchar (50) 
,loca_zip_in  varchar (10) 
,loca_zip_fm  varchar (10) 
,loca_zip_pare  varchar (10) 
,loca_country_in  varchar (20) 
,loca_country_fm  varchar (20) 
,loca_country_pare  varchar (20) 
,loca_prfct_in  varchar (20) 
,loca_prfct_fm  varchar (20) 
,loca_prfct_pare  varchar (20) 
,loca_addr1_in  varchar (50) 
,loca_addr1_fm  varchar (50) 
,loca_addr1_pare  varchar (50) 
,loca_addr2_in  varchar (50) 
,loca_addr2_fm  varchar (50) 
,loca_addr2_pare  varchar (50) 
,loca_tel_in  varchar (20) 
,loca_tel_fm  varchar (20) 
,loca_tel_pare  varchar (20) 
,loca_fax_in  varchar (20) 
,loca_fax_fm  varchar (20) 
,loca_fax_pare  varchar (20) 
,loca_mail_in  varchar (20) 
,loca_mail_fm  varchar (20) 
,loca_mail_pare  varchar (20) 
,itm_datascale_pare  numeric (22,0)
,itm_datascale  numeric (22,0)
,trngantt_parenum  numeric (22,0)
,trngantt_chilnum  numeric (22,0)
,trngantt_duedate   timestamp(6) 
,trngantt_qty  numeric (18,4)
,trngantt_mlevel  numeric (3,0)
,trngantt_orgtblname  varchar (30) 
,trngantt_key  varchar (250) 
,unit_contents_pare  varchar (4000) 
,unit_contents  varchar (4000) 
,trngantt_processseq_pare  numeric (38,0)
,itm_model_pare  varchar (50) 
,trngantt_processseq  numeric (38,0)
,trngantt_starttime   timestamp(6) 
,trngantt_consumunitqty  numeric (22,6)
,trngantt_consumminqty  numeric (22,6)
,trngantt_shuffle_flg  varchar (1) 
,itm_std_pare  varchar (50) 
,itm_std  varchar (50) 
,trngantt_consumauto  varchar (1) 
,itm_model  varchar (50) 
,itm_material_pare  varchar (50) 
,itm_material  varchar (50) 
,itm_design_pare  varchar (50) 
,itm_design  varchar (50) 
,itm_weight_pare  numeric (22,0)
,itm_weight  numeric (22,0)
,itm_length_pare  numeric (22,0)
,itm_length  numeric (22,0)
,itm_wide_pare  numeric (22,0)
,itm_wide  numeric (22,0)
,itm_deth_pare  numeric (22,0)
,itm_deth  numeric (22,0)
,trngantt_consumchgoverqty  numeric (22,6)
,trngantt_qty_stk  numeric (22,0)
,trngantt_tblname  varchar (30) 
,trngantt_tblid  numeric (38,0)
,loca_abbr_in  varchar (50) 
,trngantt_qty_pare  numeric (22,0)
,trngantt_qty_stk_pare  numeric (22,0)
,crr_pricedecimal  numeric (22,0)
,crr_amtdecimal  numeric (22,0)
,crr_contents  varchar (4000) 
,classlist_contents_pare  varchar (4000) 
,classlist_contents  varchar (4000) 
,trngantt_paretblname  varchar (30) 
,trngantt_paretblid  numeric (38,0)
,trngantt_orgtblid  numeric (22,0)
,inamt_remark  varchar (4000) 
,id  numeric (38,0)
,inamt_updated_at   timestamp(6) 
,inamt_update_ip  varchar (40) 
,inamt_trngantt_id  numeric (38,0)
,inamt_loca_id_in  numeric (22,0)
,inamt_crr_id  numeric (22,0)
,inamt_id  numeric (38,0)
,inamt_person_id_upd  numeric (38,0)
,inamt_created_at   timestamp(6) 
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_prjno_id  numeric (22,0)
,trngantt_itm_id  numeric (38,0)
,trngantt_loca_id_fm  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
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
 CREATE INDEX sio_r_inamts_uk1 
  ON sio.sio_r_inamts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_inamts_seq ;
 create sequence sio.sio_r_inamts_seq ;