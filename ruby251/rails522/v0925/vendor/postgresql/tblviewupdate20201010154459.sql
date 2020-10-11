
 alter table  purschs  ADD COLUMN crrs_id_pur numeric(22,0) not null;

 ALTER TABLE purschs ADD CONSTRAINT pursch_crrs_id_pur FOREIGN KEY (crrs_id_pur)
																		 REFERENCES crrs (id);
 --- drop view r_purschs cascade  
 create or replace view r_purschs as select  
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  opeitm.shelfno_name  shelfno_name ,
  prjno.prjno_name  prjno_name ,
pursch.crrs_id_pur   pursch_crr_id_pur,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_code  unit_code ,
  opeitm.unit_name  unit_name ,
  opeitm.itm_code  itm_code ,
  opeitm.itm_name  itm_name ,
  supplier.scrlv_code_chrg_payment  scrlv_code_chrg_payment ,
  supplier.scrlv_code_chrg_supplier  scrlv_code_chrg_supplier ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  supplier.payment_chrg_id_payment  payment_chrg_id_payment ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  supplier.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment ,
  supplier.loca_code_sect_chrg_supplier  loca_code_sect_chrg_supplier ,
  supplier.loca_code_supplier  loca_code_supplier ,
  supplier.loca_code_payment  loca_code_payment ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  opeitm.loca_code  loca_code ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  supplier.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment ,
  supplier.loca_name_sect_chrg_supplier  loca_name_sect_chrg_supplier ,
  supplier.loca_name_supplier  loca_name_supplier ,
  supplier.loca_name_payment  loca_name_payment ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
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
pursch.price  pursch_price,
pursch.remark  pursch_remark,
pursch.created_at  pursch_created_at,
pursch.update_ip  pursch_update_ip,
pursch.amt  pursch_amt,
pursch.toduedate  pursch_toduedate,
pursch.isudate  pursch_isudate,
pursch.expiredate  pursch_expiredate,
pursch.duedate  pursch_duedate,
pursch.updated_at  pursch_updated_at,
pursch.sno  pursch_sno,
pursch.id  pursch_id,
pursch.id id,
pursch.persons_id_upd   pursch_person_id_upd,
pursch.tax  pursch_tax,
pursch.prjnos_id   pursch_prjno_id,
pursch.starttime  pursch_starttime,
pursch.qty  pursch_qty,
pursch.shelfnos_id_to   pursch_shelfno_id_to,
  opeitm.itm_classlist_id  itm_classlist_id ,
pursch.opeitms_id   pursch_opeitm_id,
  opeitm.opeitm_packqty  opeitm_packqty ,
  supplier.supplier_loca_id_supplier  supplier_loca_id_supplier ,
  supplier.supplier_chrg_id_supplier  supplier_chrg_id_supplier ,
  supplier.supplier_payment_id  supplier_payment_id ,
  supplier.supplier_crr_id_supplier  supplier_crr_id_supplier ,
pursch.gno  pursch_gno,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
pursch.qty_case  pursch_qty_case,
pursch.suppliers_id   pursch_supplier_id,
  supplier.usrgrp_name_chrg_supplier  usrgrp_name_chrg_supplier ,
  supplier.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  opeitm.classlist_code  classlist_code ,
  crr_pur.crr_code  crr_code_pur ,
  supplier.crr_code_supplier  crr_code_supplier ,
  crr_pur.crr_name  crr_name_pur ,
  supplier.crr_name_supplier  crr_name_supplier ,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  supplier.usrgrp_code_chrg_supplier  usrgrp_code_chrg_supplier ,
  supplier.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  opeitm.classlist_name  classlist_name ,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  prjno.prjno_code  prjno_code ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
pursch.chrgs_id   pursch_chrg_id,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox 
 from purschs   pursch,
  r_crrs  crr_pur ,  r_persons  person_upd ,  r_prjnos  prjno ,  r_shelfnos  shelfno_to ,  r_opeitms  opeitm ,  r_suppliers  supplier ,  r_chrgs  chrg 
  where       pursch.crrs_id_pur = crr_pur.id      and pursch.persons_id_upd = person_upd.id      and pursch.prjnos_id = prjno.id      and pursch.shelfnos_id_to = shelfno_to.id      and pursch.opeitms_id = opeitm.id      and pursch.suppliers_id = supplier.id      and pursch.chrgs_id = chrg.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purschs;
 CREATE TABLE sio.sio_r_purschs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purschs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
          ,sio_Term_id varchar(30)
          ,sio_session_id numeric(22,0)
          ,sio_Command_Response char(1)
          ,sio_session_counter numeric(22,0)
          ,sio_classname varchar(50)
          ,sio_viewname varchar(30)
          ,sio_code varchar(30)
          ,sio_strsql varchar(4000)
          ,sio_totalcount numeric(22,0)
          ,sio_recordcount numeric(22,0)
          ,sio_start_record numeric(22,0)
          ,sio_end_record numeric(22,0)
          ,sio_sord varchar(256)
          ,sio_search varchar(10)
          ,sio_sidx varchar(256)
,pursch_sno  varchar (40) 
,pursch_duedate   timestamp(6) 
,pursch_qty  numeric (18,4)
,pursch_price  numeric (38,4)
,pursch_amt  numeric (18,4)
,pursch_tax  numeric (38,4)
,opeitm_processseq  numeric (3,0)
,pursch_gno  varchar (40) 
,person_name_chrg_payment  varchar (100) 
,person_name_chrg  varchar (100) 
,unit_name_outbox  varchar (100) 
,unit_name_box  varchar (100) 
,loca_name_payment  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,loca_name  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,person_code_chrg_supplier  varchar (50) 
,person_code_chrg_payment  varchar (50) 
,person_code_chrg  varchar (50) 
,person_name_chrg_supplier  varchar (100) 
,loca_name_shelfno_to  varchar (100) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_name_sect_chrg_supplier  varchar (100) 
,loca_name_supplier  varchar (100) 
,loca_name_shelfno  varchar (100) 
,unit_name_case  varchar (100) 
,unit_name  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,shelfno_code  varchar (50) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,scrlv_code_chrg_payment  varchar (50) 
,scrlv_code_chrg_supplier  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,prjno_code_chil  varchar (50) 
,shelfno_name_to  varchar (100) 
,classlist_name  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,shelfno_name  varchar (100) 
,usrgrp_code_chrg_payment  varchar (50) 
,usrgrp_code_chrg_supplier  varchar (50) 
,prjno_name  varchar (100) 
,crr_name_supplier  varchar (100) 
,crr_name_pur  varchar (100) 
,crr_code_supplier  varchar (50) 
,crr_code_pur  varchar (50) 
,classlist_code  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,prjno_code  varchar (50) 
,usrgrp_name_chrg_payment  varchar (100) 
,usrgrp_name_chrg_supplier  varchar (100) 
,shelfno_code_to  varchar (50) 
,unit_code_outbox  varchar (50) 
,unit_code_box  varchar (50) 
,unit_code_case  varchar (50) 
,unit_code  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,loca_code_sect_chrg_payment  varchar (50) 
,loca_code_sect_chrg_supplier  varchar (50) 
,loca_code_supplier  varchar (50) 
,loca_code_payment  varchar (50) 
,loca_code_shelfno  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_code  varchar (50) 
,pursch_toduedate   timestamp(6) 
,pursch_isudate   timestamp(6) 
,pursch_qty_case  numeric (22,0)
,pursch_starttime   timestamp(6) 
,pursch_expiredate   date 
,loca_addr1_supplier  varchar (50) 
,opeitm_prdpurshp  varchar (20) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autoinst_p  numeric (3,0)
,itm_std  varchar (50) 
,opeitm_autoact_p  numeric (3,0)
,opeitm_autoord_p  numeric (3,0)
,loca_abbr_supplier  varchar (50) 
,loca_zip_supplier  varchar (10) 
,loca_country_supplier  varchar (20) 
,loca_prfct_supplier  varchar (20) 
,loca_addr2_supplier  varchar (50) 
,loca_tel_supplier  varchar (20) 
,loca_fax_supplier  varchar (20) 
,loca_mail_supplier  varchar (20) 
,opeitm_duration  numeric (38,2)
,opeitm_units_lttime  varchar (4) 
,opeitm_minqty  numeric (38,6)
,person_email_chrg  varchar (50) 
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
,opeitm_autocreate_act  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_chkord_prc  numeric (3,0)
,opeitm_chkord  varchar (1) 
,opeitm_esttosch  numeric (22,0)
,opeitm_stktaking_proc  varchar (1) 
,opeitm_rule_price  varchar (1) 
,opeitm_mold  varchar (1) 
,crr_pricedecimal_pur  numeric (22,0)
,crr_amtdecimal_pur  numeric (22,0)
,crr_contents_pur  varchar (4000) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_packno_flg  varchar (1) 
,opeitm_priority  numeric (3,0)
,opeitm_contents  varchar (4000) 
,shelfno_contents_to  varchar (4000) 
,opeitm_acceptance_proc  varchar (1) 
,opeitm_chkinst  varchar (1) 
,boxe_boxtype  varchar (20) 
,opeitm_maxqty  numeric (22,0)
,opeitm_prjalloc_flg  numeric (22,0)
,pursch_remark  varchar (4000) 
,pursch_id  numeric (38,0)
,id  numeric (38,0)
,pursch_person_id_upd  numeric (38,0)
,pursch_created_at   timestamp(6) 
,pursch_prjno_id  numeric (38,0)
,pursch_supplier_id  numeric (22,0)
,pursch_shelfno_id_to  numeric (38,0)
,pursch_crr_id_pur  numeric (22,0)
,pursch_chrg_id  numeric (38,0)
,pursch_opeitm_id  numeric (38,0)
,pursch_update_ip  varchar (40) 
,pursch_updated_at   timestamp(6) 
,opeitm_boxe_id  numeric (22,0)
,loca_prfct  varchar (20) 
,itm_unit_id  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,loca_mail_shelfno  varchar (20) 
,itm_classlist_id  numeric (38,0)
,loca_prfct_shelfno  varchar (20) 
,loca_country_shelfno  varchar (20) 
,boxe_unit_id_box  numeric (38,0)
,person_sect_id_chrg_payment  numeric (22,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,supplier_loca_id_supplier  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,loca_zip  varchar (10) 
,loca_zip_shelfno  varchar (10) 
,supplier_chrg_id_supplier  numeric (22,0)
,loca_abbr  varchar (50) 
,supplier_payment_id  numeric (38,0)
,supplier_crr_id_supplier  numeric (22,0)
,loca_fax_shelfno  varchar (20) 
,loca_tel_shelfno  varchar (20) 
,opeitm_unit_id_case  numeric (38,0)
,loca_abbr_shelfno  varchar (50) 
,payment_loca_id_payment  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,payment_chrg_id_payment  numeric (22,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,loca_addr2  varchar (50) 
,loca_addr2_shelfno  varchar (50) 
,loca_addr1  varchar (50) 
,loca_addr1_shelfno  varchar (50) 
,shelfno_loca_id_shelfno_to  numeric (38,0)
          ,sio_errline varchar(4000)
          ,sio_org_tblname varchar(30)
          ,sio_org_tblid numeric(22,0)
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
