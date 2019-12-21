
 alter table purschs  ADD COLUMN depdate timestamp(6);

 --- drop view r_purschs cascade  
 create or replace view r_purschs as select  
pursch.price  pursch_price,
pursch.remark  pursch_remark,
pursch.created_at  pursch_created_at,
pursch.update_ip  pursch_update_ip,
pursch.duedate  pursch_duedate,
pursch.amt  pursch_amt,
pursch.toduedate  pursch_toduedate,
pursch.isudate  pursch_isudate,
pursch.expiredate  pursch_expiredate,
pursch.consumtype  pursch_consumtype,
pursch.updated_at  pursch_updated_at,
pursch.qty  pursch_qty,
pursch.sno  pursch_sno,
pursch.id id,
pursch.id  pursch_id,
pursch.persons_id_upd   pursch_person_id_upd,
pursch.locas_id_to   pursch_loca_id_to,
pursch.tax  pursch_tax,
pursch.starttime  pursch_starttime,
pursch.prjnos_id   pursch_prjno_id,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_country  loca_country_to ,
  loca_to.loca_abbr  loca_abbr_to ,
  loca_to.loca_tel  loca_tel_to ,
  loca_to.loca_mail  loca_mail_to ,
  loca_to.loca_addr1  loca_addr1_to ,
  loca_to.loca_zip  loca_zip_to ,
  loca_to.loca_fax  loca_fax_to ,
  loca_to.loca_addr2  loca_addr2_to ,
  loca_to.loca_name  loca_name_to ,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code  prjno_code ,
pursch.opeitms_id   pursch_opeitm_id,
  opeitm.opeitm_autoinst_p  opeitm_autoinst_p ,
  opeitm.unit_contents  unit_contents ,
  opeitm.classlist_name  classlist_name ,
  opeitm.classlist_contents  classlist_contents ,
  opeitm.classlist_code  classlist_code ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.loca_mail_shelfno  loca_mail_shelfno ,
  opeitm.loca_zip_shelfno  loca_zip_shelfno ,
  opeitm.opeitm_prjalloc_flg  opeitm_prjalloc_flg ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.loca_id_shelfno  loca_id_shelfno ,
  opeitm.opeitm_chkord  opeitm_chkord ,
  opeitm.opeitm_chkinst  opeitm_chkinst ,
  opeitm.opeitm_mold  opeitm_mold ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_packno_flg  opeitm_packno_flg ,
  opeitm.opeitm_opt_fix_flg  opeitm_opt_fix_flg ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.unit_name  unit_name ,
  opeitm.opeitm_units_lttime  opeitm_units_lttime ,
  opeitm.unit_code  unit_code ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.opeitm_minqty  opeitm_minqty ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_maxqty  opeitm_maxqty ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.itm_deth  itm_deth ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.opeitm_esttosch  opeitm_esttosch ,
  opeitm.opeitm_chkord_prc  opeitm_chkord_prc ,
  opeitm.opeitm_operation  opeitm_operation ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  opeitm.opeitm_opt_fixoterm  opeitm_opt_fixoterm ,
  opeitm.opeitm_autocreate_ord  opeitm_autocreate_ord ,
  opeitm.opeitm_autocreate_inst  opeitm_autocreate_inst ,
  opeitm.opeitm_shuffle_flg  opeitm_shuffle_flg ,
  opeitm.opeitm_shuffle_loca  opeitm_shuffle_loca ,
  opeitm.opeitm_autocreate_act  opeitm_autocreate_act ,
  opeitm.opeitm_rule_price  opeitm_rule_price ,
  opeitm.opeitm_stktaking_f  opeitm_stktaking_f ,
  opeitm.boxe_code  boxe_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.opeitm_contents  opeitm_contents ,
  opeitm.loca_name  loca_name ,
  opeitm.loca_code  loca_code ,
  opeitm.itm_std  itm_std ,
  opeitm.itm_model  itm_model ,
  opeitm.itm_design  itm_design ,
  opeitm.itm_material  itm_material ,
  opeitm.boxe_name  boxe_name ,
  opeitm.loca_prfct  loca_prfct ,
  opeitm.loca_addr1  loca_addr1 ,
  opeitm.loca_addr2  loca_addr2 ,
  opeitm.loca_zip  loca_zip ,
  opeitm.boxe_boxtype  boxe_boxtype ,
  opeitm.loca_abbr  loca_abbr ,
  opeitm.loca_addr1_shelfno  loca_addr1_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_prfct_shelfno  loca_prfct_shelfno ,
  opeitm.loca_country_shelfno  loca_country_shelfno ,
  opeitm.loca_addr2_shelfno  loca_addr2_shelfno ,
  opeitm.loca_abbr_shelfno  loca_abbr_shelfno ,
  opeitm.loca_fax_shelfno  loca_fax_shelfno ,
  opeitm.loca_tel_shelfno  loca_tel_shelfno ,
  opeitm.itm_length  itm_length ,
  opeitm.itm_weight  itm_weight ,
  opeitm.opeitm_prdpurshp  opeitm_prdpurshp ,
  opeitm.opeitm_autoord_p  opeitm_autoord_p ,
  opeitm.itm_wide  itm_wide ,
  opeitm.opeitm_duration  opeitm_duration ,
  opeitm.opeitm_safestkqty  opeitm_safestkqty ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.opeitm_autoact_p  opeitm_autoact_p ,
  loca_to.loca_prfct  loca_prfct_to ,
pursch.qty_case  pursch_qty_case,
pursch.suppliers_id   pursch_supplier_id,
  supplier.supplier_amtdecimal  supplier_amtdecimal ,
  supplier.supplier_custtype  supplier_custtype ,
  supplier.supplier_contents  supplier_contents ,
  supplier.supplier_contract_price  supplier_contract_price ,
  supplier.supplier_rule_price  supplier_rule_price ,
  supplier.supplier_amtround  supplier_amtround ,
  supplier.supplier_payment_id  supplier_payment_id ,
  supplier.supplier_personname  supplier_personname ,
  supplier.supplier_loca_id_supplier  supplier_loca_id_supplier ,
  supplier.supplier_chrg_id_supplier  supplier_chrg_id_supplier ,
  supplier.payment_contents  payment_contents ,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.loca_country_payment  loca_country_payment ,
  supplier.loca_abbr_payment  loca_abbr_payment ,
  supplier.loca_prfct_payment  loca_prfct_payment ,
  supplier.loca_tel_payment  loca_tel_payment ,
  supplier.loca_mail_payment  loca_mail_payment ,
  supplier.loca_addr1_payment  loca_addr1_payment ,
  supplier.loca_zip_payment  loca_zip_payment ,
  supplier.loca_fax_payment  loca_fax_payment ,
  supplier.loca_addr2_payment  loca_addr2_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  supplier.scrlv_code_chrg_payment  scrlv_code_chrg_payment ,
  supplier.scrlv_level1_chrg_payment  scrlv_level1_chrg_payment ,
  supplier.person_name_chrg_payment  person_name_chrg_payment ,
  supplier.person_email_chrg_payment  person_email_chrg_payment ,
  supplier.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment ,
  supplier.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment ,
  supplier.person_code_chrg_payment  person_code_chrg_payment ,
  supplier.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment ,
  supplier.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment ,
  supplier.payment_personname  payment_personname ,
  supplier.loca_code_supplier  loca_code_supplier ,
  supplier.loca_country_supplier  loca_country_supplier ,
  supplier.loca_abbr_supplier  loca_abbr_supplier ,
  supplier.loca_prfct_supplier  loca_prfct_supplier ,
  supplier.loca_tel_supplier  loca_tel_supplier ,
  supplier.loca_mail_supplier  loca_mail_supplier ,
  supplier.loca_addr1_supplier  loca_addr1_supplier ,
  supplier.loca_zip_supplier  loca_zip_supplier ,
  supplier.loca_fax_supplier  loca_fax_supplier ,
  supplier.loca_addr2_supplier  loca_addr2_supplier ,
  supplier.loca_name_supplier  loca_name_supplier ,
  supplier.scrlv_code_chrg_supplier  scrlv_code_chrg_supplier ,
  supplier.scrlv_level1_chrg_supplier  scrlv_level1_chrg_supplier ,
  supplier.person_name_chrg_supplier  person_name_chrg_supplier ,
  supplier.person_email_chrg_supplier  person_email_chrg_supplier ,
  supplier.loca_name_sect_chrg_supplier  loca_name_sect_chrg_supplier ,
  supplier.loca_code_sect_chrg_supplier  loca_code_sect_chrg_supplier ,
  supplier.person_code_chrg_supplier  person_code_chrg_supplier ,
  supplier.usrgrp_code_chrg_supplier  usrgrp_code_chrg_supplier ,
  supplier.usrgrp_name_chrg_supplier  usrgrp_name_chrg_supplier ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  supplier.crr_contents_supplier  crr_contents_supplier ,
  supplier.crr_name_supplier  crr_name_supplier ,
  supplier.crr_pricedecimal_supplier  crr_pricedecimal_supplier ,
  supplier.crr_amtdecimal_supplier  crr_amtdecimal_supplier ,
  supplier.crr_code_supplier  crr_code_supplier ,
  supplier.supplier_crr_id_supplier  supplier_crr_id_supplier ,
pursch.depdate  pursch_depdate
 from purschs   pursch,
  r_persons  person_upd ,  r_locas  loca_to ,  r_prjnos  prjno ,  r_opeitms  opeitm ,  r_suppliers  supplier 
  where       pursch.persons_id_upd = person_upd.id      and pursch.locas_id_to = loca_to.id      and pursch.prjnos_id = prjno.id      and pursch.opeitms_id = opeitm.id      and pursch.suppliers_id = supplier.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purschs;
 CREATE TABLE sio.sio_r_purschs (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_purschs_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,pursch_sno  varchar (40) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,loca_code_supplier  varchar (50) 
,person_code_chrg_supplier  varchar (50) 
,loca_code_sect_chrg_supplier  varchar (50) 
,usrgrp_name_chrg_payment  varchar (100) 
,loca_name_sect_chrg_supplier  varchar (100) 
,usrgrp_code_chrg_payment  varchar (50) 
,unit_name_case  varchar (100) 
,unit_name  varchar (100) 
,loca_code_to  varchar (50) 
,unit_code  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_outbox  varchar (100) 
,unit_code_box  varchar (50) 
,crr_code_supplier  varchar (50) 
,person_code_chrg_payment  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,unit_code_case  varchar (50) 
,loca_code_sect_chrg_payment  varchar (50) 
,loca_name_sect_chrg_payment  varchar (100) 
,person_name_chrg_payment  varchar (100) 
,loca_name_to  varchar (100) 
,prjno_code_chil  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code  varchar (50) 
,person_name_chrg_supplier  varchar (100) 
,crr_name_supplier  varchar (100) 
,boxe_code  varchar (50) 
,shelfno_name  varchar (100) 
,shelfno_code  varchar (50) 
,classlist_name  varchar (100) 
,loca_name  varchar (100) 
,loca_code  varchar (50) 
,classlist_code  varchar (50) 
,loca_name_shelfno  varchar (100) 
,scrlv_code_chrg_supplier  varchar (50) 
,boxe_name  varchar (100) 
,scrlv_code_chrg_payment  varchar (50) 
,loca_name_payment  varchar (100) 
,loca_code_payment  varchar (50) 
,loca_name_supplier  varchar (100) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,loca_code_shelfno  varchar (50) 
,usrgrp_name_chrg_supplier  varchar (100) 
,usrgrp_code_chrg_supplier  varchar (50) 
,pursch_expiredate   date 
,pursch_qty  numeric (18,4)
,pursch_tax  numeric (38,4)
,pursch_price  numeric (38,4)
,pursch_depdate   timestamp(6) 
,pursch_duedate   timestamp(6) 
,pursch_remark  varchar (4000) 
,pursch_amt  numeric (18,4)
,pursch_toduedate   timestamp(6) 
,pursch_isudate   timestamp(6) 
,pursch_consumtype  varchar (3) 
,pursch_starttime   timestamp(6) 
,pursch_qty_case  numeric (38,0)
,loca_mail_supplier  varchar (20) 
,loca_country_to  varchar (20) 
,loca_abbr_to  varchar (50) 
,loca_tel_to  varchar (20) 
,loca_mail_to  varchar (20) 
,loca_addr1_to  varchar (50) 
,loca_zip_to  varchar (10) 
,loca_fax_to  varchar (20) 
,loca_addr2_to  varchar (50) 
,opeitm_autoinst_p  numeric (3,0)
,unit_contents  varchar (4000) 
,classlist_contents  varchar (4000) 
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_processseq  numeric (3,0)
,opeitm_priority  numeric (3,0)
,opeitm_chkord  varchar (1) 
,opeitm_chkinst  varchar (1) 
,opeitm_mold  varchar (1) 
,opeitm_packno_flg  varchar (1) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_units_lttime  varchar (4) 
,opeitm_minqty  numeric (38,6)
,opeitm_packqty  numeric (38,0)
,opeitm_maxqty  numeric (22,0)
,itm_deth  numeric (22,0)
,opeitm_esttosch  numeric (22,0)
,opeitm_chkord_prc  numeric (3,0)
,opeitm_operation  varchar (20) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_shuffle_flg  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_rule_price  varchar (1) 
,opeitm_stktaking_f  varchar (1) 
,opeitm_contents  varchar (4000) 
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,itm_design  varchar (50) 
,itm_material  varchar (50) 
,boxe_boxtype  varchar (20) 
,opeitm_duration  numeric (38,2)
,opeitm_safestkqty  numeric (38,0)
,opeitm_autoact_p  numeric (3,0)
,loca_prfct_to  varchar (20) 
,supplier_amtdecimal  numeric (38,0)
,supplier_custtype  varchar (1) 
,supplier_contents  varchar (4000) 
,supplier_contract_price  varchar (1) 
,supplier_rule_price  varchar (1) 
,supplier_amtround  varchar (2) 
,supplier_personname  varchar (30) 
,payment_contents  varchar (4000) 
,loca_country_payment  varchar (20) 
,loca_abbr_payment  varchar (50) 
,loca_prfct_payment  varchar (20) 
,loca_tel_payment  varchar (20) 
,loca_mail_payment  varchar (20) 
,loca_addr1_payment  varchar (50) 
,loca_zip_payment  varchar (10) 
,loca_fax_payment  varchar (20) 
,loca_addr2_payment  varchar (50) 
,scrlv_level1_chrg_payment  varchar (1) 
,person_email_chrg_payment  varchar (50) 
,payment_personname  varchar (30) 
,loca_country_supplier  varchar (20) 
,loca_abbr_supplier  varchar (50) 
,loca_prfct_supplier  varchar (20) 
,loca_tel_supplier  varchar (20) 
,loca_addr1_supplier  varchar (50) 
,loca_zip_supplier  varchar (10) 
,loca_fax_supplier  varchar (20) 
,loca_addr2_supplier  varchar (50) 
,scrlv_level1_chrg_supplier  varchar (1) 
,person_email_chrg_supplier  varchar (50) 
,crr_contents_supplier  varchar (4000) 
,crr_pricedecimal_supplier  numeric (22,0)
,crr_amtdecimal_supplier  numeric (22,0)
,itm_length  numeric (22,0)
,itm_weight  numeric (22,0)
,opeitm_prdpurshp  varchar (20) 
,opeitm_autoord_p  numeric (3,0)
,itm_wide  numeric (22,0)
,pursch_update_ip  varchar (40) 
,pursch_updated_at   timestamp(6) 
,pursch_opeitm_id  numeric (38,0)
,pursch_supplier_id  numeric (22,0)
,pursch_created_at   timestamp(6) 
,pursch_prjno_id  numeric (38,0)
,pursch_loca_id_to  numeric (38,0)
,pursch_person_id_upd  numeric (38,0)
,pursch_id  numeric (38,0)
,id  numeric (38,0)
,loca_prfct  varchar (20) 
,supplier_crr_id_supplier  numeric (22,0)
,opeitm_loca_id  numeric (38,0)
,loca_addr1_shelfno  varchar (50) 
,loca_abbr  varchar (50) 
,opeitm_shelfno_id  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,loca_zip  varchar (10) 
,loca_addr2  varchar (50) 
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,loca_prfct_shelfno  varchar (20) 
,loca_id_shelfno  numeric (22,0)
,supplier_payment_id  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,supplier_loca_id_supplier  numeric (22,0)
,loca_country_shelfno  varchar (20) 
,loca_addr2_shelfno  varchar (50) 
,loca_abbr_shelfno  varchar (50) 
,loca_fax_shelfno  varchar (20) 
,loca_tel_shelfno  varchar (20) 
,supplier_chrg_id_supplier  numeric (22,0)
,loca_zip_shelfno  varchar (10) 
,loca_mail_shelfno  varchar (20) 
,loca_addr1  varchar (50) 
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
 CREATE INDEX sio_r_purschs_uk1 
  ON sio.sio_r_purschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purschs_seq ;
 create sequence sio.sio_r_purschs_seq ;
