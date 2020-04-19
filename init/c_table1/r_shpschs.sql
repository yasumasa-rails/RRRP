
 --- drop view r_shpschs cascade  
 create or replace view r_shpschs as select  
shpsch.id  shpsch_id,
shpsch.id id,
shpsch.transports_id   shpsch_transport_id,
shpsch.chrgs_id   shpsch_chrg_id,
shpsch.prjnos_id   shpsch_prjno_id,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  transport.transport_code  transport_code ,
  transport.transport_name  transport_name ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  prjno.prjno_name  prjno_name ,
  itm.unit_code  unit_code ,
  itm.unit_name  unit_name ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name ,
shpsch.expiredate  shpsch_expiredate,
shpsch.persons_id_upd   shpsch_person_id_upd,
shpsch.remark  shpsch_remark,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
shpsch.update_ip  shpsch_update_ip,
shpsch.created_at  shpsch_created_at,
shpsch.updated_at  shpsch_updated_at,
shpsch.qty  shpsch_qty,
shpsch.amt  shpsch_amt,
shpsch.tax  shpsch_tax,
shpsch.price  shpsch_price,
shpsch.locas_id_to   shpsch_loca_id_to,
shpsch.sno  shpsch_sno,
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
shpsch.isudate  shpsch_isudate,
shpsch.gno  shpsch_gno,
shpsch.crrs_id   shpsch_crr_id,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  itm.classlist_code  classlist_code ,
shpsch.depdate  shpsch_depdate,
shpsch.lotno  shpsch_lotno,
shpsch.packno  shpsch_packno,
shpsch.qty_stk  shpsch_qty_stk,
  crr.crr_code  crr_code ,
shpsch.shelfnos_id_fm   shpsch_shelfno_id_fm,
shpsch.itms_id   shpsch_itm_id,
shpsch.paretblname  shpsch_paretblname,
shpsch.paretblid  shpsch_paretblid,
  crr.crr_name  crr_name ,
shpsch.qty_case  shpsch_qty_case,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
shpsch.contract_price  shpsch_contract_price,
  itm.classlist_name  classlist_name ,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_code  prjno_code ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
shpsch.manual  shpsch_manual
 from shpschs   shpsch,
  r_transports  transport ,  r_chrgs  chrg ,  r_prjnos  prjno ,  r_persons  person_upd ,  r_locas  loca_to ,  r_crrs  crr ,  r_shelfnos  shelfno_fm ,  r_itms  itm 
  where       shpsch.transports_id = transport.id      and shpsch.chrgs_id = chrg.id      and shpsch.prjnos_id = prjno.id      and shpsch.persons_id_upd = person_upd.id      and shpsch.locas_id_to = loca_to.id      and shpsch.crrs_id = crr.id      and shpsch.shelfnos_id_fm = shelfno_fm.id      and shpsch.itms_id = itm.id     ;
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
,shpsch_isudate   timestamp(6) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,shpsch_depdate   timestamp(6) 
,shpsch_qty  numeric (18,4)
,shpsch_qty_stk  numeric (38,4)
,shpsch_qty_case  numeric (38,0)
,loca_code_shelfno_fm  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,shelfno_code_fm  varchar (50) 
,shelfno_name_fm  varchar (100) 
,loca_code_to  varchar (50) 
,loca_name_to  varchar (100) 
,shpsch_lotno  varchar (50) 
,shpsch_packno  varchar (10) 
,shpsch_price  numeric (38,4)
,shpsch_amt  numeric (18,4)
,shpsch_tax  numeric (38,4)
,crr_code  varchar (50) 
,crr_name  varchar (100) 
,transport_code  varchar (50) 
,transport_name  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,shpsch_gno  varchar (40) 
,shpsch_sno  varchar (40) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,classlist_code  varchar (50) 
,prjno_name  varchar (100) 
,classlist_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,prjno_code  varchar (50) 
,shpsch_expiredate   date 
,shpsch_paretblname  varchar (30) 
,shpsch_paretblid  numeric (38,0)
,shpsch_contract_price  varchar (1) 
,shpsch_manual  varchar (1) 
,loca_addr2_to  varchar (50) 
,shelfno_contents_fm  varchar (4000) 
,crr_pricedecimal  numeric (22,0)
,crr_amtdecimal  numeric (22,0)
,crr_contents  varchar (4000) 
,itm_model  varchar (50) 
,itm_std  varchar (50) 
,loca_addr1_to  varchar (50) 
,person_email_chrg  varchar (50) 
,transport_contents  varchar (4000) 
,loca_fax_to  varchar (20) 
,scrlv_level1_chrg  varchar (1) 
,loca_tel_to  varchar (20) 
,loca_abbr_to  varchar (50) 
,itm_datascale  numeric (22,0)
,unit_contents  varchar (4000) 
,loca_prfct_to  varchar (20) 
,loca_mail_to  varchar (20) 
,loca_country_to  varchar (20) 
,itm_deth  numeric (22,0)
,itm_wide  numeric (22,0)
,itm_length  numeric (22,0)
,itm_weight  numeric (22,0)
,itm_design  varchar (50) 
,itm_material  varchar (50) 
,loca_zip_to  varchar (10) 
,shpsch_remark  varchar (4000) 
,shpsch_crr_id  numeric (22,0)
,shpsch_loca_id_to  numeric (38,0)
,shpsch_updated_at   timestamp(6) 
,shpsch_created_at   timestamp(6) 
,shpsch_update_ip  varchar (40) 
,shpsch_person_id_upd  numeric (38,0)
,shpsch_id  numeric (38,0)
,shpsch_shelfno_id_fm  numeric (22,0)
,shpsch_itm_id  numeric (38,0)
,shpsch_prjno_id  numeric (38,0)
,shpsch_chrg_id  numeric (38,0)
,shpsch_transport_id  numeric (38,0)
,id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
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
