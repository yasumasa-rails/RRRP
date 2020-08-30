
 alter table  shpords  ADD COLUMN amt numeric(18,4);

 --- drop view r_shpords cascade  
 create or replace view r_shpords as select  
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  transport.transport_code  transport_code ,
  transport.transport_name  transport_name ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  prjno.prjno_name  prjno_name ,
  itm.unit_code  unit_code ,
  itm.unit_name  unit_name ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  loca_to.loca_code  loca_code_to ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  loca_to.loca_name  loca_name_to ,
  chrg.person_code_chrg  person_code_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  itm.itm_unit_id  itm_unit_id ,
  itm.itm_classlist_id  itm_classlist_id ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  itm.classlist_code  classlist_code ,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
shpord.id id,
shpord.id  shpord_id,
shpord.isudate  shpord_isudate,
shpord.itms_id   shpord_itm_id,
shpord.shelfnos_id_fm   shpord_shelfno_id_fm,
shpord.locas_id_to   shpord_loca_id_to,
shpord.transports_id   shpord_transport_id,
shpord.expiredate  shpord_expiredate,
shpord.depdate  shpord_depdate,
shpord.qty  shpord_qty,
shpord.price  shpord_price,
shpord.tax  shpord_tax,
shpord.contract_price  shpord_contract_price,
shpord.prjnos_id   shpord_prjno_id,
shpord.manual  shpord_manual,
shpord.lotno  shpord_lotno,
shpord.qty_stk  shpord_qty_stk,
shpord.qty_case  shpord_qty_case,
shpord.packno  shpord_packno,
shpord.gno  shpord_gno,
shpord.sno  shpord_sno,
shpord.chrgs_id   shpord_chrg_id,
shpord.crrs_id   shpord_crr_id,
shpord.paretblname  shpord_paretblname,
shpord.paretblid  shpord_paretblid,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
shpord.remark  shpord_remark,
shpord.persons_id_upd   shpord_person_id_upd,
shpord.created_at  shpord_created_at,
shpord.updated_at  shpord_updated_at,
  itm.classlist_name  classlist_name ,
shpord.update_ip  shpord_update_ip,
shpord.sno_shpsch  shpord_sno_shpsch,
  prjno.prjno_code_chil  prjno_code_chil ,
shpord.processseq  shpord_processseq,
  prjno.prjno_code  prjno_code ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
shpord.amt  shpord_amt
 from shpords   shpord,
  r_itms  itm ,  r_shelfnos  shelfno_fm ,  r_locas  loca_to ,  r_transports  transport ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_crrs  crr ,  r_persons  person_upd 
  where       shpord.itms_id = itm.id      and shpord.shelfnos_id_fm = shelfno_fm.id      and shpord.locas_id_to = loca_to.id      and shpord.transports_id = transport.id      and shpord.prjnos_id = prjno.id      and shpord.chrgs_id = chrg.id      and shpord.crrs_id = crr.id      and shpord.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shpords;
 CREATE TABLE sio.sio_r_shpords (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_shpords_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,shpord_sno  varchar (40) 
,shpord_gno  varchar (40) 
,transport_name  varchar (100) 
,shelfno_name_fm  varchar (100) 
,prjno_name  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,shelfno_code_fm  varchar (50) 
,prjno_code  varchar (50) 
,prjno_code_chil  varchar (50) 
,classlist_name  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,crr_name  varchar (100) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,crr_code  varchar (50) 
,classlist_code  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,person_name_chrg  varchar (100) 
,person_code_chrg  varchar (50) 
,loca_name_to  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,loca_code_to  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,transport_code  varchar (50) 
,shpord_amt  numeric (18,4)
,shpord_isudate   timestamp(6) 
,shpord_expiredate   date 
,shpord_depdate   timestamp(6) 
,shpord_qty  numeric (22,6)
,shpord_price  numeric (38,4)
,shpord_tax  numeric (38,4)
,shpord_contract_price  varchar (1) 
,shpord_manual  varchar (1) 
,shpord_lotno  varchar (50) 
,shpord_qty_stk  numeric (22,6)
,shpord_qty_case  numeric (22,0)
,shpord_packno  varchar (10) 
,shpord_paretblname  varchar (30) 
,shpord_paretblid  numeric (38,0)
,shpord_sno_shpsch  varchar (50) 
,shpord_processseq  numeric (38,0)
,crr_pricedecimal  numeric (22,0)
,crr_contents  varchar (4000) 
,itm_deth  numeric (22,0)
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,itm_wide  numeric (22,0)
,itm_length  numeric (22,0)
,shelfno_contents_fm  varchar (4000) 
,loca_mail_to  varchar (20) 
,loca_fax_to  varchar (20) 
,loca_tel_to  varchar (20) 
,loca_addr2_to  varchar (50) 
,loca_addr1_to  varchar (50) 
,loca_prfct_to  varchar (20) 
,person_email_chrg  varchar (50) 
,scrlv_level1_chrg  varchar (1) 
,itm_datascale  numeric (22,0)
,unit_contents  varchar (4000) 
,loca_country_to  varchar (20) 
,loca_zip_to  varchar (10) 
,loca_abbr_to  varchar (50) 
,crr_amtdecimal  numeric (22,0)
,itm_weight  numeric (22,0)
,itm_design  varchar (50) 
,itm_material  varchar (50) 
,transport_contents  varchar (4000) 
,shpord_remark  varchar (4000) 
,shpord_id  numeric (38,0)
,shpord_itm_id  numeric (38,0)
,shpord_shelfno_id_fm  numeric (22,0)
,shpord_loca_id_to  numeric (38,0)
,shpord_transport_id  numeric (38,0)
,id  numeric (38,0)
,shpord_updated_at   timestamp(6) 
,shpord_update_ip  varchar (40) 
,shpord_prjno_id  numeric (38,0)
,shpord_chrg_id  numeric (38,0)
,shpord_crr_id  numeric (22,0)
,shpord_person_id_upd  numeric (38,0)
,shpord_created_at   timestamp(6) 
,person_sect_id_chrg  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,itm_unit_id  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,itm_classlist_id  numeric (38,0)
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
 CREATE INDEX sio_r_shpords_uk1 
  ON sio.sio_r_shpords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpords_seq ;
 create sequence sio.sio_r_shpords_seq ;
