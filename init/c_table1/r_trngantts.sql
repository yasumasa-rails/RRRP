
 --- drop view r_trngantts cascade  
 create or replace view r_trngantts as select  
trngantt.consumunitqty  trngantt_consumunitqty,
trngantt.paretblname  trngantt_paretblname,
trngantt.paretblid  trngantt_paretblid,
trngantt.consumminqty  trngantt_consumminqty,
trngantt.consumchgoverqty  trngantt_consumchgoverqty,
  prjno.prjno_expiredate  prjno_expiredate ,
trngantt.tblname  trngantt_tblname,
trngantt.tblid  trngantt_tblid,
trngantt.duedate  trngantt_duedate,
trngantt.starttime  trngantt_starttime,
trngantt.itms_id   trngantt_itm_id,
trngantt.processseq  trngantt_processseq,
trngantt.locas_id_fm   trngantt_loca_id_fm,
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
  loca_fm.loca_code  loca_code_fm ,
  loca_fm.loca_country  loca_country_fm ,
  loca_fm.loca_abbr  loca_abbr_fm ,
  loca_fm.loca_prfct  loca_prfct_fm ,
  loca_fm.loca_tel  loca_tel_fm ,
  loca_fm.loca_mail  loca_mail_fm ,
  loca_fm.loca_addr1  loca_addr1_fm ,
  loca_fm.loca_zip  loca_zip_fm ,
  loca_fm.loca_fax  loca_fax_fm ,
  loca_fm.loca_addr2  loca_addr2_fm ,
  loca_fm.loca_name  loca_name_fm ,
trngantt.processseq_pare  trngantt_processseq_pare,
trngantt.locas_id_pare   trngantt_loca_id_pare,
trngantt.itms_id_pare   trngantt_itm_id_pare,
  loca_pare.loca_code  loca_code_pare ,
  loca_pare.loca_country  loca_country_pare ,
  loca_pare.loca_abbr  loca_abbr_pare ,
  loca_pare.loca_prfct  loca_prfct_pare ,
  loca_pare.loca_tel  loca_tel_pare ,
  loca_pare.loca_mail  loca_mail_pare ,
  loca_pare.loca_addr1  loca_addr1_pare ,
  loca_pare.loca_zip  loca_zip_pare ,
  loca_pare.loca_fax  loca_fax_pare ,
  loca_pare.loca_addr2  loca_addr2_pare ,
  loca_pare.loca_name  loca_name_pare ,
  itm_pare.itm_weight  itm_weight_pare ,
  itm_pare.itm_classlist_id  itm_classlist_id_pare ,
  itm_pare.unit_contents  unit_contents_pare ,
  itm_pare.classlist_name  classlist_name_pare ,
  itm_pare.classlist_contents  classlist_contents_pare ,
  itm_pare.classlist_code  classlist_code_pare ,
  itm_pare.itm_length  itm_length_pare ,
  itm_pare.itm_unit_id  itm_unit_id_pare ,
  itm_pare.itm_design  itm_design_pare ,
  itm_pare.itm_wide  itm_wide_pare ,
  itm_pare.itm_deth  itm_deth_pare ,
  itm_pare.itm_material  itm_material_pare ,
  itm_pare.itm_std  itm_std_pare ,
  itm_pare.itm_model  itm_model_pare ,
  itm_pare.itm_datascale  itm_datascale_pare ,
  itm_pare.unit_name  unit_name_pare ,
  itm_pare.unit_code  unit_code_pare ,
  itm_pare.itm_code  itm_code_pare ,
  itm_pare.itm_name  itm_name_pare ,
trngantt.qty_stk_pare  trngantt_qty_stk_pare,
trngantt.qty_pare  trngantt_qty_pare,
trngantt.mlevel  trngantt_mlevel,
trngantt.orgtblid  trngantt_orgtblid,
trngantt.id  trngantt_id,
  prjno.prjno_id  prjno_id ,
trngantt.consumauto  trngantt_consumauto,
trngantt.shuffle_flg  trngantt_shuffle_flg,
trngantt.persons_id_upd   trngantt_person_id_upd,
trngantt.prjnos_id   trngantt_prjno_id,
trngantt.key  trngantt_key,
trngantt.created_at  trngantt_created_at,
trngantt.parenum  trngantt_parenum,
  prjno.prjno_code  prjno_code ,
  prjno.prjno_name  prjno_name ,
trngantt.id id,
trngantt.update_ip  trngantt_update_ip,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
trngantt.expiredate  trngantt_expiredate,
trngantt.chilnum  trngantt_chilnum,
trngantt.qty  trngantt_qty,
trngantt.qty_stk  trngantt_qty_stk,
trngantt.remark  trngantt_remark,
trngantt.orgtblname  trngantt_orgtblname,
trngantt.updated_at  trngantt_updated_at,
  prjno.prjno_code_chil  prjno_code_chil 
 from trngantts   trngantt,
  r_itms  itm ,  r_locas  loca_fm ,  r_locas  loca_pare ,  r_itms  itm_pare ,  r_persons  person_upd ,  r_prjnos  prjno 
  where       trngantt.itms_id = itm.id      and trngantt.locas_id_fm = loca_fm.id      and trngantt.locas_id_pare = loca_pare.id      and trngantt.itms_id_pare = itm_pare.id      and trngantt.persons_id_upd = person_upd.id      and trngantt.prjnos_id = prjno.id     ;
 DROP TABLE IF EXISTS sio.sio_r_trngantts;
 CREATE TABLE sio.sio_r_trngantts (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_trngantts_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,trngantt_orgtblname  varchar (30) 
,trngantt_orgtblid  numeric (22,0)
,unit_name_pare  varchar (100) 
,loca_name_fm  varchar (100) 
,itm_name_pare  varchar (100) 
,loca_code_pare  varchar (50) 
,unit_name  varchar (100) 
,loca_name_pare  varchar (100) 
,unit_code  varchar (50) 
,itm_code_pare  varchar (50) 
,itm_code  varchar (50) 
,classlist_name_pare  varchar (100) 
,itm_name  varchar (100) 
,classlist_code_pare  varchar (50) 
,loca_code_fm  varchar (50) 
,unit_code_pare  varchar (50) 
,classlist_name  varchar (100) 
,classlist_code  varchar (50) 
,trngantt_paretblid  numeric (38,0)
,trngantt_qty_stk_pare  numeric (22,0)
,trngantt_processseq  numeric (38,0)
,trngantt_consumchgoverqty  numeric (22,6)
,trngantt_qty_pare  numeric (22,0)
,trngantt_processseq_pare  numeric (38,0)
,trngantt_tblname  varchar (30) 
,trngantt_tblid  numeric (38,0)
,trngantt_consumunitqty  numeric (22,6)
,trngantt_duedate   timestamp(6) 
,trngantt_starttime   timestamp(6) 
,trngantt_paretblname  varchar (30) 
,trngantt_consumminqty  numeric (22,6)
,trngantt_key  varchar (250) 
,trngantt_mlevel  numeric (3,0)
,itm_design_pare  varchar (50) 
,itm_wide_pare  numeric (22,0)
,itm_deth_pare  numeric (22,0)
,itm_material_pare  varchar (50) 
,itm_std_pare  varchar (50) 
,itm_model_pare  varchar (50) 
,itm_datascale_pare  numeric (22,0)
,itm_material  varchar (50) 
,itm_weight  numeric (22,0)
,unit_contents  varchar (4000) 
,classlist_contents  varchar (4000) 
,itm_length  numeric (22,0)
,itm_design  varchar (50) 
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,itm_datascale  numeric (22,0)
,loca_country_fm  varchar (20) 
,loca_abbr_fm  varchar (50) 
,loca_prfct_fm  varchar (20) 
,loca_tel_fm  varchar (20) 
,loca_mail_fm  varchar (20) 
,loca_addr1_fm  varchar (50) 
,loca_zip_fm  varchar (10) 
,loca_fax_fm  varchar (20) 
,loca_addr2_fm  varchar (50) 
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
,trngantt_qty  numeric (18,4)
,trngantt_qty_stk  numeric (22,0)
,trngantt_parenum  numeric (22,0)
,trngantt_chilnum  numeric (22,0)
,trngantt_shuffle_flg  varchar (1) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,trngantt_consumauto  varchar (1) 
,trngantt_expiredate   date 
,trngantt_remark  varchar (4000) 
,trngantt_loca_id_fm  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,itm_classlist_id_pare  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,id  numeric (38,0)
,trngantt_update_ip  varchar (40) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,trngantt_created_at  numeric (22,0)
,trngantt_prjno_id  numeric (22,0)
,trngantt_person_id_upd  numeric (22,0)
,prjno_id  numeric (22,0)
,trngantt_id  numeric (22,0)
,prjno_expiredate   date 
,trngantt_updated_at   timestamp(6) 
,prjno_code_chil  varchar (50) 
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
 CREATE INDEX sio_r_trngantts_uk1 
  ON sio.sio_r_trngantts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_trngantts_seq ;
 create sequence sio.sio_r_trngantts_seq ;
