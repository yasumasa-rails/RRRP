
 --- drop view r_purdlvs cascade  
 create or replace view r_purdlvs as select  
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.opeitm_prdpurshp  opeitm_prdpurshp ,
  opeitm.opeitm_opt_fix_flg  opeitm_opt_fix_flg ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.shelfno_name  shelfno_name ,
  prjno.prjno_name  prjno_name ,
  opeitm.opeitm_autocreate_ord  opeitm_autocreate_ord ,
  opeitm.opeitm_autoinst_p  opeitm_autoinst_p ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_code  unit_code ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.itm_std  itm_std ,
  opeitm.itm_model  itm_model ,
  opeitm.itm_material  itm_material ,
  opeitm.itm_design  itm_design ,
  opeitm.itm_weight  itm_weight ,
  opeitm.itm_length  itm_length ,
  opeitm.itm_wide  itm_wide ,
  opeitm.itm_deth  itm_deth ,
  opeitm.itm_code  itm_code ,
  opeitm.itm_name  itm_name ,
purdlv.shelfcode  purdlv_shelfcode,
  opeitm.opeitm_autoact_p  opeitm_autoact_p ,
  opeitm.opeitm_autoord_p  opeitm_autoord_p ,
  supplier.scrlv_code_chrg_payment  scrlv_code_chrg_payment ,
  supplier.scrlv_code_chrg_supplier  scrlv_code_chrg_supplier ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  supplier.payment_chrg_id_payment  payment_chrg_id_payment ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  supplier.loca_abbr_supplier  loca_abbr_supplier ,
  supplier.loca_abbr_payment  loca_abbr_payment ,
  opeitm.loca_abbr_shelfno  loca_abbr_shelfno ,
  loca_to.loca_abbr  loca_abbr_to ,
  opeitm.loca_abbr  loca_abbr ,
  supplier.loca_zip_supplier  loca_zip_supplier ,
  supplier.loca_zip_payment  loca_zip_payment ,
  opeitm.loca_zip_shelfno  loca_zip_shelfno ,
  loca_to.loca_zip  loca_zip_to ,
  opeitm.loca_zip  loca_zip ,
  supplier.loca_country_supplier  loca_country_supplier ,
  supplier.loca_country_payment  loca_country_payment ,
  opeitm.loca_country_shelfno  loca_country_shelfno ,
  loca_to.loca_country  loca_country_to ,
  supplier.loca_prfct_supplier  loca_prfct_supplier ,
  supplier.loca_prfct_payment  loca_prfct_payment ,
  opeitm.loca_prfct_shelfno  loca_prfct_shelfno ,
  loca_to.loca_prfct  loca_prfct_to ,
  opeitm.loca_prfct  loca_prfct ,
  supplier.loca_addr1_supplier  loca_addr1_supplier ,
  supplier.loca_addr1_payment  loca_addr1_payment ,
  opeitm.loca_addr1_shelfno  loca_addr1_shelfno ,
  loca_to.loca_addr1  loca_addr1_to ,
  opeitm.loca_addr1  loca_addr1 ,
  supplier.loca_addr2_supplier  loca_addr2_supplier ,
  supplier.loca_addr2_payment  loca_addr2_payment ,
  opeitm.loca_addr2_shelfno  loca_addr2_shelfno ,
  loca_to.loca_addr2  loca_addr2_to ,
  opeitm.loca_addr2  loca_addr2 ,
  supplier.loca_tel_supplier  loca_tel_supplier ,
  supplier.loca_tel_payment  loca_tel_payment ,
  opeitm.loca_tel_shelfno  loca_tel_shelfno ,
  loca_to.loca_tel  loca_tel_to ,
  supplier.loca_fax_supplier  loca_fax_supplier ,
  supplier.loca_fax_payment  loca_fax_payment ,
  opeitm.loca_fax_shelfno  loca_fax_shelfno ,
  loca_to.loca_fax  loca_fax_to ,
  supplier.loca_mail_supplier  loca_mail_supplier ,
  supplier.loca_mail_payment  loca_mail_payment ,
  opeitm.loca_mail_shelfno  loca_mail_shelfno ,
  loca_to.loca_mail  loca_mail_to ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_duration  opeitm_duration ,
  opeitm.opeitm_units_lttime  opeitm_units_lttime ,
  supplier.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment ,
  supplier.loca_code_sect_chrg_supplier  loca_code_sect_chrg_supplier ,
  supplier.loca_code_supplier  loca_code_supplier ,
  supplier.loca_code_payment  loca_code_payment ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  loca_to.loca_code  loca_code_to ,
  opeitm.loca_code  loca_code ,
  supplier.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment ,
  supplier.loca_name_sect_chrg_supplier  loca_name_sect_chrg_supplier ,
  supplier.loca_name_supplier  loca_name_supplier ,
  supplier.loca_name_payment  loca_name_payment ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  loca_to.loca_name  loca_name_to ,
  opeitm.loca_name  loca_name ,
  opeitm.opeitm_minqty  opeitm_minqty ,
  supplier.person_code_chrg_supplier  person_code_chrg_supplier ,
  supplier.person_code_chrg_payment  person_code_chrg_payment ,
  chrg.person_code_chrg  person_code_chrg ,
  supplier.person_name_chrg_supplier  person_name_chrg_supplier ,
  supplier.person_name_chrg_payment  person_name_chrg_payment ,
  chrg.person_name_chrg  person_name_chrg ,
  supplier.person_email_chrg_payment  person_email_chrg_payment ,
  supplier.person_email_chrg_supplier  person_email_chrg_supplier ,
  chrg.person_email_chrg  person_email_chrg ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.itm_unit_id  itm_unit_id ,
  supplier.scrlv_level1_chrg_payment  scrlv_level1_chrg_payment ,
  supplier.scrlv_level1_chrg_supplier  scrlv_level1_chrg_supplier ,
  chrg.scrlv_level1_chrg  scrlv_level1_chrg ,
  opeitm.opeitm_operation  opeitm_operation ,
  opeitm.opeitm_opt_fixoterm  opeitm_opt_fixoterm ,
  opeitm.itm_classlist_id  itm_classlist_id ,
purdlv.replydate  purdlv_replydate,
  opeitm.opeitm_safestkqty  opeitm_safestkqty ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  supplier.supplier_amtdecimal  supplier_amtdecimal ,
  supplier.supplier_custtype  supplier_custtype ,
  supplier.supplier_contents  supplier_contents ,
  supplier.supplier_loca_id_supplier  supplier_loca_id_supplier ,
  supplier.supplier_contract_price  supplier_contract_price ,
  supplier.supplier_rule_price  supplier_rule_price ,
  supplier.supplier_amtround  supplier_amtround ,
  supplier.supplier_chrg_id_supplier  supplier_chrg_id_supplier ,
  supplier.supplier_personname  supplier_personname ,
  supplier.supplier_payment_id  supplier_payment_id ,
  supplier.supplier_crr_id_supplier  supplier_crr_id_supplier ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.opeitm_shuffle_flg  opeitm_shuffle_flg ,
  opeitm.opeitm_chkord_prc  opeitm_chkord_prc ,
  opeitm.opeitm_chkord  opeitm_chkord ,
  opeitm.opeitm_autocreate_act  opeitm_autocreate_act ,
  opeitm.unit_contents  unit_contents ,
purdlv.remark  purdlv_remark,
purdlv.created_at  purdlv_created_at,
purdlv.update_ip  purdlv_update_ip,
purdlv.depdate  purdlv_depdate,
purdlv.isudate  purdlv_isudate,
purdlv.expiredate  purdlv_expiredate,
purdlv.updated_at  purdlv_updated_at,
purdlv.qty  purdlv_qty,
purdlv.sno  purdlv_sno,
purdlv.id  purdlv_id,
purdlv.id id,
purdlv.persons_id_upd   purdlv_person_id_upd,
purdlv.locas_id_to   purdlv_loca_id_to,
purdlv.prjnos_id   purdlv_prjno_id,
purdlv.opeitms_id   purdlv_opeitm_id,
purdlv.qty_case  purdlv_qty_case,
purdlv.cno  purdlv_cno,
purdlv.sno_inst  purdlv_sno_inst,
purdlv.gno  purdlv_gno,
purdlv.chrgs_id   purdlv_chrg_id,
purdlv.itm_code_client  purdlv_itm_code_client,
purdlv.autoact_p  purdlv_autoact_p,
purdlv.suppliers_id   purdlv_supplier_id,
  opeitm.opeitm_shuffle_loca  opeitm_shuffle_loca ,
  opeitm.opeitm_esttosch  opeitm_esttosch ,
  opeitm.opeitm_stktaking_proc  opeitm_stktaking_proc ,
  opeitm.opeitm_rule_price  opeitm_rule_price ,
  supplier.usrgrp_name_chrg_supplier  usrgrp_name_chrg_supplier ,
  supplier.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  opeitm.classlist_code  classlist_code ,
  opeitm.opeitm_mold  opeitm_mold ,
  supplier.crr_code_supplier  crr_code_supplier ,
  supplier.crr_pricedecimal_supplier  crr_pricedecimal_supplier ,
  supplier.crr_amtdecimal_supplier  crr_amtdecimal_supplier ,
  supplier.crr_contents_supplier  crr_contents_supplier ,
  supplier.crr_name_supplier  crr_name_supplier ,
  opeitm.opeitm_autocreate_inst  opeitm_autocreate_inst ,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  supplier.usrgrp_code_chrg_supplier  usrgrp_code_chrg_supplier ,
  supplier.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  opeitm.classlist_name  classlist_name ,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  opeitm.opeitm_packno_flg  opeitm_packno_flg ,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_priority  opeitm_priority ,
  prjno.prjno_code  prjno_code ,
  opeitm.opeitm_contents  opeitm_contents ,
  opeitm.opeitm_acceptance_proc  opeitm_acceptance_proc ,
  supplier.payment_contents  payment_contents ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.opeitm_chkinst  opeitm_chkinst ,
  supplier.payment_personname  payment_personname ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  opeitm.boxe_boxtype  boxe_boxtype ,
  opeitm.opeitm_maxqty  opeitm_maxqty ,
  opeitm.opeitm_prjalloc_flg  opeitm_prjalloc_flg 
 from purdlvs   purdlv,
  r_persons  person_upd ,  r_locas  loca_to ,  r_prjnos  prjno ,  r_opeitms  opeitm ,  r_chrgs  chrg ,  r_suppliers  supplier 
  where       purdlv.persons_id_upd = person_upd.id      and purdlv.locas_id_to = loca_to.id      and purdlv.prjnos_id = prjno.id      and purdlv.opeitms_id = opeitm.id      and purdlv.chrgs_id = chrg.id      and purdlv.suppliers_id = supplier.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purdlvs;
 CREATE TABLE sio.sio_r_purdlvs (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_purdlvs_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,purdlv_gno  varchar (40) 
,purdlv_cno  varchar (40) 
,purdlv_sno  varchar (40) 
,scrlv_code_chrg_supplier  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,prjno_code_chil  varchar (50) 
,classlist_name  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_outbox  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,unit_code_case  varchar (50) 
,unit_code  varchar (50) 
,scrlv_code_chrg_payment  varchar (50) 
,prjno_code  varchar (50) 
,classlist_code  varchar (50) 
,shelfno_code  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_code_box  varchar (50) 
,usrgrp_name_chrg_payment  varchar (100) 
,itm_code  varchar (50) 
,usrgrp_name_chrg_supplier  varchar (100) 
,itm_name  varchar (100) 
,unit_name_box  varchar (100) 
,usrgrp_code_chrg_payment  varchar (50) 
,loca_code_sect_chrg_payment  varchar (50) 
,loca_code_sect_chrg_supplier  varchar (50) 
,loca_code_supplier  varchar (50) 
,loca_code_payment  varchar (50) 
,loca_code_shelfno  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_code_to  varchar (50) 
,loca_code  varchar (50) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_name_sect_chrg_supplier  varchar (100) 
,loca_name_supplier  varchar (100) 
,loca_name_payment  varchar (100) 
,loca_name_shelfno  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,loca_name_to  varchar (100) 
,loca_name  varchar (100) 
,unit_name_case  varchar (100) 
,person_code_chrg_supplier  varchar (50) 
,person_code_chrg_payment  varchar (50) 
,person_code_chrg  varchar (50) 
,person_name_chrg_supplier  varchar (100) 
,person_name_chrg_payment  varchar (100) 
,person_name_chrg  varchar (100) 
,unit_name  varchar (100) 
,usrgrp_code_chrg_supplier  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,crr_name_supplier  varchar (100) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,crr_code_supplier  varchar (50) 
,shelfno_name  varchar (100) 
,prjno_name  varchar (100) 
,purdlv_qty_case  numeric (38,0)
,purdlv_replydate   date 
,purdlv_sno_inst  varchar (40) 
,purdlv_qty  numeric (18,4)
,purdlv_isudate   timestamp(6) 
,purdlv_shelfcode  varchar (10) 
,purdlv_autoact_p  numeric (3,0)
,purdlv_itm_code_client  varchar (50) 
,purdlv_depdate   timestamp(6) 
,purdlv_expiredate   date 
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_prdpurshp  varchar (20) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autoinst_p  numeric (3,0)
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,itm_material  varchar (50) 
,itm_design  varchar (50) 
,itm_weight  numeric (22,0)
,itm_length  numeric (22,0)
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,opeitm_autoact_p  numeric (3,0)
,opeitm_autoord_p  numeric (3,0)
,loca_abbr_supplier  varchar (50) 
,loca_abbr_payment  varchar (50) 
,loca_abbr_to  varchar (50) 
,loca_zip_supplier  varchar (10) 
,loca_zip_payment  varchar (10) 
,loca_zip_to  varchar (10) 
,loca_country_supplier  varchar (20) 
,loca_country_payment  varchar (20) 
,loca_country_to  varchar (20) 
,loca_prfct_supplier  varchar (20) 
,loca_prfct_payment  varchar (20) 
,loca_prfct_to  varchar (20) 
,loca_addr1_supplier  varchar (50) 
,loca_addr1_payment  varchar (50) 
,loca_addr1_to  varchar (50) 
,loca_addr2_supplier  varchar (50) 
,loca_addr2_payment  varchar (50) 
,loca_addr2_to  varchar (50) 
,loca_tel_supplier  varchar (20) 
,loca_tel_payment  varchar (20) 
,loca_tel_to  varchar (20) 
,loca_fax_supplier  varchar (20) 
,loca_fax_payment  varchar (20) 
,loca_fax_to  varchar (20) 
,loca_mail_supplier  varchar (20) 
,loca_mail_payment  varchar (20) 
,loca_mail_to  varchar (20) 
,opeitm_duration  numeric (38,2)
,opeitm_units_lttime  varchar (4) 
,opeitm_minqty  numeric (38,6)
,person_email_chrg_payment  varchar (50) 
,person_email_chrg_supplier  varchar (50) 
,person_email_chrg  varchar (50) 
,scrlv_level1_chrg_payment  varchar (1) 
,scrlv_level1_chrg_supplier  varchar (1) 
,scrlv_level1_chrg  varchar (1) 
,opeitm_operation  varchar (20) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_safestkqty  numeric (38,0)
,opeitm_packqty  numeric (38,0)
,supplier_amtdecimal  numeric (38,0)
,supplier_custtype  varchar (1) 
,supplier_contents  varchar (4000) 
,supplier_contract_price  varchar (1) 
,supplier_rule_price  varchar (1) 
,supplier_amtround  varchar (2) 
,supplier_personname  varchar (30) 
,opeitm_shuffle_flg  varchar (1) 
,opeitm_chkord_prc  numeric (3,0)
,opeitm_chkord  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,unit_contents  varchar (4000) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_esttosch  numeric (22,0)
,opeitm_stktaking_proc  varchar (1) 
,opeitm_rule_price  varchar (1) 
,opeitm_mold  varchar (1) 
,crr_pricedecimal_supplier  numeric (22,0)
,crr_amtdecimal_supplier  numeric (22,0)
,crr_contents_supplier  varchar (4000) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_packno_flg  varchar (1) 
,opeitm_processseq  numeric (3,0)
,opeitm_priority  numeric (3,0)
,opeitm_contents  varchar (4000) 
,opeitm_acceptance_proc  varchar (1) 
,payment_contents  varchar (4000) 
,opeitm_chkinst  varchar (1) 
,payment_personname  varchar (30) 
,boxe_boxtype  varchar (20) 
,opeitm_maxqty  numeric (22,0)
,purdlv_remark  varchar (4000) 
,purdlv_updated_at   timestamp(6) 
,purdlv_created_at   timestamp(6) 
,purdlv_update_ip  varchar (40) 
,purdlv_id  numeric (38,0)
,id  numeric (38,0)
,purdlv_person_id_upd  numeric (38,0)
,purdlv_loca_id_to  numeric (38,0)
,purdlv_prjno_id  numeric (38,0)
,purdlv_opeitm_id  numeric (38,0)
,purdlv_supplier_id  numeric (22,0)
,purdlv_chrg_id  numeric (38,0)
,loca_prfct_shelfno  varchar (20) 
,opeitm_unit_id_prdpurshp  numeric (38,0)
,loca_country_shelfno  varchar (20) 
,chrg_person_id_chrg  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,loca_zip  varchar (10) 
,chrg_person_id_chrg_payment  numeric (38,0)
,person_sect_id_chrg_payment  numeric (22,0)
,supplier_payment_id  numeric (38,0)
,supplier_crr_id_supplier  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,loca_zip_shelfno  varchar (10) 
,loca_abbr  varchar (50) 
,loca_abbr_shelfno  varchar (50) 
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_loca_id_supplier  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,loca_mail_shelfno  varchar (20) 
,opeitm_itm_id  numeric (38,0)
,loca_fax_shelfno  varchar (20) 
,loca_tel_shelfno  varchar (20) 
,loca_addr2  varchar (50) 
,loca_addr2_shelfno  varchar (50) 
,opeitm_loca_id  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,payment_chrg_id_payment  numeric (22,0)
,loca_addr1  varchar (50) 
,loca_addr1_shelfno  varchar (50) 
,loca_prfct  varchar (20) 
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
 CREATE INDEX sio_r_purdlvs_uk1 
  ON sio.sio_r_purdlvs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purdlvs_seq ;
 create sequence sio.sio_r_purdlvs_seq ;
