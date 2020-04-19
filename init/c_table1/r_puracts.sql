
 --- drop view r_puracts cascade  
 create or replace view r_puracts as select  
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
puract.sno_purdlv  puract_sno_purdlv,
puract.sno_purinst  puract_sno_purinst,
puract.sno_purord  puract_sno_purord,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
puract.cno_purinst  puract_cno_purinst,
puract.cno_purdlv  puract_cno_purdlv,
puract.chrgs_id   puract_chrg_id,
puract.itm_code_client  puract_itm_code_client,
puract.prjnos_id   puract_prjno_id,
  shelfno_to.shelfno_code  shelfno_code_to ,
  opeitm.shelfno_code  shelfno_code ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  opeitm.shelfno_name  shelfno_name ,
  prjno.prjno_name  prjno_name ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_code  unit_code ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
puract.suppliers_id   puract_supplier_id,
  opeitm.itm_code  itm_code ,
  opeitm.itm_name  itm_name ,
  supplier.payment_chrg_id_payment  payment_chrg_id_payment ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  supplier.loca_code_supplier  loca_code_supplier ,
  supplier.loca_code_payment  loca_code_payment ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_code  loca_code ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  supplier.loca_name_supplier  loca_name_supplier ,
  supplier.loca_name_payment  loca_name_payment ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.loca_name  loca_name ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  supplier.person_code_chrg_supplier  person_code_chrg_supplier ,
  supplier.person_code_chrg_payment  person_code_chrg_payment ,
  chrg.person_code_chrg  person_code_chrg ,
  supplier.person_name_chrg_supplier  person_name_chrg_supplier ,
  supplier.person_name_chrg_payment  person_name_chrg_payment ,
  chrg.person_name_chrg  person_name_chrg ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.itm_unit_id  itm_unit_id ,
puract.crrs_id_pur   puract_crr_id_pur,
  opeitm.itm_classlist_id  itm_classlist_id ,
  opeitm.opeitm_packqty  opeitm_packqty ,
puract.shelfnos_id_to   puract_shelfno_id_to,
  supplier.supplier_loca_id_supplier  supplier_loca_id_supplier ,
  supplier.supplier_chrg_id_supplier  supplier_chrg_id_supplier ,
  supplier.supplier_payment_id  supplier_payment_id ,
  supplier.supplier_crr_id_supplier  supplier_crr_id_supplier ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
puract.id  puract_id,
puract.id id,
puract.qty_stk  puract_qty_stk,
  opeitm.opeitm_stktaking_proc  opeitm_stktaking_proc ,
puract.isudate  puract_isudate,
puract.contract_price  puract_contract_price,
  opeitm.classlist_code  classlist_code ,
puract.sno  puract_sno,
  crr_pur.crr_code  crr_code_pur ,
  supplier.crr_code_supplier  crr_code_supplier ,
  crr_pur.crr_name  crr_name_pur ,
  supplier.crr_name_supplier  crr_name_supplier ,
puract.lotno  puract_lotno,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
puract.gno  puract_gno,
puract.cno  puract_cno,
  opeitm.classlist_name  classlist_name ,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
puract.tax  puract_tax,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  prjno.prjno_code  prjno_code ,
puract.expiredate  puract_expiredate,
puract.updated_at  puract_updated_at,
puract.remark  puract_remark,
puract.created_at  puract_created_at,
puract.update_ip  puract_update_ip,
puract.persons_id_upd   puract_person_id_upd,
puract.contents  puract_contents,
puract.rcptdate  puract_rcptdate,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
puract.opeitms_id   puract_opeitm_id,
puract.qty_case  puract_qty_case,
puract.amt  puract_amt,
puract.price  puract_price,
  opeitm.opeitm_acceptance_proc  opeitm_acceptance_proc ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox 
 from puracts   puract,
  r_chrgs  chrg ,  r_prjnos  prjno ,  r_suppliers  supplier ,  r_crrs  crr_pur ,  r_shelfnos  shelfno_to ,  r_persons  person_upd ,  r_opeitms  opeitm 
  where       puract.chrgs_id = chrg.id      and puract.prjnos_id = prjno.id      and puract.suppliers_id = supplier.id      and puract.crrs_id_pur = crr_pur.id      and puract.shelfnos_id_to = shelfno_to.id      and puract.persons_id_upd = person_upd.id      and puract.opeitms_id = opeitm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_puracts;
 CREATE TABLE sio.sio_r_puracts (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_puracts_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,puract_sno_purord  varchar (50) 
,puract_sno_purinst  varchar (50) 
,puract_isudate   timestamp(6) 
,puract_rcptdate   timestamp(6) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,puract_itm_code_client  varchar (50) 
,puract_qty_stk  numeric (38,4)
,opeitm_packqty  numeric (38,0)
,puract_qty_case  numeric (38,0)
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,puract_price  numeric (38,4)
,puract_amt  numeric (18,4)
,puract_tax  numeric (38,4)
,puract_contract_price  varchar (1) 
,crr_code_supplier  varchar (50) 
,crr_name_supplier  varchar (100) 
,crr_code_pur  varchar (50) 
,crr_name_pur  varchar (100) 
,loca_name_shelfno  varchar (100) 
,loca_code_shelfno  varchar (50) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,loca_code_supplier  varchar (50) 
,loca_name_supplier  varchar (100) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,person_code_chrg_supplier  varchar (50) 
,person_name_chrg_supplier  varchar (100) 
,person_code_chrg_payment  varchar (50) 
,person_name_chrg_payment  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,classlist_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,prjno_code  varchar (50) 
,scrlv_code_chrg_payment  varchar (50) 
,scrlv_code_chrg_supplier  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,shelfno_code_to  varchar (50) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,shelfno_name_to  varchar (100) 
,loca_code_shelfno_to  varchar (50) 
,loca_code_sect_chrg_payment  varchar (50) 
,loca_code_sect_chrg_supplier  varchar (50) 
,loca_code_payment  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_name_sect_chrg_supplier  varchar (100) 
,loca_name_payment  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,prjno_name  varchar (100) 
,unit_code_box  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_box  varchar (100) 
,usrgrp_name_chrg_supplier  varchar (100) 
,usrgrp_name_chrg_payment  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,classlist_code  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,usrgrp_code_chrg_supplier  varchar (50) 
,usrgrp_code_chrg_payment  varchar (50) 
,puract_sno  varchar (40) 
,puract_gno  varchar (40) 
,puract_expiredate   date 
,puract_sno_purdlv  varchar (50) 
,puract_cno_purdlv  varchar (50) 
,puract_cno_purinst  varchar (50) 
,puract_lotno  varchar (50) 
,puract_cno  varchar (40) 
,crr_amtdecimal_pur  numeric (22,0)
,boxe_boxtype  varchar (20) 
,crr_contents_pur  varchar (4000) 
,opeitm_minqty  numeric (38,6)
,opeitm_chkinst  varchar (1) 
,opeitm_acceptance_proc  varchar (1) 
,person_email_chrg  varchar (50) 
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autoinst_p  numeric (3,0)
,scrlv_level1_chrg  varchar (1) 
,opeitm_operation  varchar (20) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_rule_price  varchar (1) 
,opeitm_maxqty  numeric (22,0)
,opeitm_mold  varchar (1) 
,opeitm_contents  varchar (4000) 
,opeitm_priority  numeric (3,0)
,opeitm_autoord_p  numeric (3,0)
,crr_pricedecimal_pur  numeric (22,0)
,opeitm_autoact_p  numeric (3,0)
,opeitm_autocreate_act  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_esttosch  numeric (22,0)
,loca_zip_supplier  varchar (10) 
,opeitm_prdpurshp  varchar (20) 
,loca_country_supplier  varchar (20) 
,loca_prfct_supplier  varchar (20) 
,opeitm_opt_fix_flg  varchar (1) 
,loca_addr1_supplier  varchar (50) 
,loca_addr2_supplier  varchar (50) 
,opeitm_stktaking_proc  varchar (1) 
,loca_abbr_supplier  varchar (50) 
,loca_tel_supplier  varchar (20) 
,opeitm_prjalloc_flg  numeric (22,0)
,loca_fax_supplier  varchar (20) 
,loca_mail_supplier  varchar (20) 
,opeitm_duration  numeric (38,2)
,opeitm_units_lttime  varchar (4) 
,opeitm_safestkqty  numeric (38,0)
,shelfno_contents_to  varchar (4000) 
,supplier_amtdecimal  numeric (38,0)
,supplier_custtype  varchar (1) 
,supplier_contents  varchar (4000) 
,opeitm_processseq  numeric (3,0)
,supplier_contract_price  varchar (1) 
,supplier_rule_price  varchar (1) 
,supplier_amtround  varchar (2) 
,supplier_personname  varchar (30) 
,opeitm_packno_flg  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_shuffle_flg  varchar (1) 
,opeitm_chkord_prc  numeric (3,0)
,opeitm_chkord  varchar (1) 
,puract_remark  varchar (4000) 
,puract_contents  varchar (4000) 
,loca_name  varchar (100) 
,loca_code  varchar (50) 
,puract_shelfno_id_to  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,puract_chrg_id  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,puract_prjno_id  numeric (38,0)
,puract_supplier_id  numeric (22,0)
,puract_person_id_upd  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,puract_update_ip  varchar (40) 
,puract_crr_id_pur  numeric (22,0)
,puract_updated_at   timestamp(6) 
,puract_opeitm_id  numeric (38,0)
,puract_created_at   timestamp(6) 
,chrg_person_id_chrg_payment  numeric (38,0)
,puract_id  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,payment_chrg_id_payment  numeric (22,0)
,loca_abbr_shelfno  varchar (50) 
,loca_abbr  varchar (50) 
,loca_zip_shelfno  varchar (10) 
,loca_zip  varchar (10) 
,loca_country_shelfno  varchar (20) 
,loca_prfct_shelfno  varchar (20) 
,loca_prfct  varchar (20) 
,loca_addr1_shelfno  varchar (50) 
,loca_addr1  varchar (50) 
,loca_addr2_shelfno  varchar (50) 
,loca_addr2  varchar (50) 
,loca_tel_shelfno  varchar (20) 
,loca_fax_shelfno  varchar (20) 
,loca_mail_shelfno  varchar (20) 
,opeitm_itm_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_payment_id  numeric (38,0)
,supplier_crr_id_supplier  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,id  numeric (38,0)
,person_sect_id_chrg_payment  numeric (22,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,payment_loca_id_payment  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,boxe_unit_id_box  numeric (22,0)
,boxe_unit_id_outbox  numeric (22,0)
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
 CREATE INDEX sio_r_puracts_uk1 
  ON sio.sio_r_puracts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_puracts_seq ;
 create sequence sio.sio_r_puracts_seq ;
