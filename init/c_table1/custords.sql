
 --- drop view r_custords cascade  
 create or replace view r_custords as select  
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  cust.cust_bill_id  cust_bill_id ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.opeitm_prdpurshp  opeitm_prdpurshp ,
  opeitm.opeitm_opt_fix_flg  opeitm_opt_fix_flg ,
custord.gno  custord_gno,
custord.itm_code_client  custord_itm_code_client,
  cust.cust_autocreate_custact  cust_autocreate_custact ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.boxe_code  boxe_code ,
custord.contents  custord_contents,
  cust.bill_chrg_id_bill  bill_chrg_id_bill ,
  opeitm.boxe_name  boxe_name ,
  opeitm.shelfno_name  shelfno_name ,
  prjno.prjno_name  prjno_name ,
custord.locas_id_fm   custord_loca_id_fm,
custord.custrcvplcs_id   custord_custrcvplc_id,
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
  opeitm.itm_code  itm_code ,
  opeitm.itm_name  itm_name ,
  opeitm.opeitm_autoact_p  opeitm_autoact_p ,
  opeitm.opeitm_autoord_p  opeitm_autoord_p ,
  cust.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  chrg_cpo.scrlv_code_chrg  scrlv_code_chrg_cpo ,
  cust.scrlv_code_chrg_cust  scrlv_code_chrg_cust ,
custord.id  custord_id,
custord.created_at  custord_created_at,
custord.updated_at  custord_updated_at,
custord.duedate  custord_duedate,
custord.toduedate  custord_toduedate,
custord.isudate  custord_isudate,
custord.qty  custord_qty,
custord.price  custord_price,
custord.amt  custord_amt,
custord.custs_id   custord_cust_id,
custord.remark  custord_remark,
custord.expiredate  custord_expiredate,
custord.persons_id_upd   custord_person_id_upd,
custord.update_ip  custord_update_ip,
  cust.cust_loca_id_cust  cust_loca_id_cust ,
  loca_fm.loca_abbr  loca_abbr_fm ,
  opeitm.loca_abbr  loca_abbr ,
  loca_fm.loca_zip  loca_zip_fm ,
  opeitm.loca_zip  loca_zip ,
  loca_fm.loca_country  loca_country_fm ,
  loca_fm.loca_prfct  loca_prfct_fm ,
  opeitm.loca_prfct  loca_prfct ,
  loca_fm.loca_addr1  loca_addr1_fm ,
  opeitm.loca_addr1  loca_addr1 ,
  loca_fm.loca_addr2  loca_addr2_fm ,
  opeitm.loca_addr2  loca_addr2 ,
  loca_fm.loca_tel  loca_tel_fm ,
  loca_fm.loca_fax  loca_fax_fm ,
  loca_fm.loca_mail  loca_mail_fm ,
  opeitm.opeitm_duration  opeitm_duration ,
  opeitm.opeitm_units_lttime  opeitm_units_lttime ,
  cust.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  loca_fm.loca_code  loca_code_fm ,
  cust.loca_code_bill  loca_code_bill ,
  chrg_cpo.loca_code_sect_chrg  loca_code_sect_chrg_cpo ,
  cust.loca_code_sect_chrg_cust  loca_code_sect_chrg_cust ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  custrcvplc.loca_code_custrcvplc  loca_code_custrcvplc ,
  cust.loca_code_cust  loca_code_cust ,
  opeitm.loca_code  loca_code ,
  cust.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  loca_fm.loca_name  loca_name_fm ,
  cust.loca_name_bill  loca_name_bill ,
  chrg_cpo.loca_name_sect_chrg  loca_name_sect_chrg_cpo ,
  cust.loca_name_sect_chrg_cust  loca_name_sect_chrg_cust ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  custrcvplc.loca_name_custrcvplc  loca_name_custrcvplc ,
  cust.loca_name_cust  loca_name_cust ,
  opeitm.loca_name  loca_name ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  opeitm.opeitm_minqty  opeitm_minqty ,
  cust.person_code_chrg_bill  person_code_chrg_bill ,
  chrg_cpo.person_code_chrg  person_code_chrg_cpo ,
  cust.person_code_chrg_cust  person_code_chrg_cust ,
  cust.person_name_chrg_bill  person_name_chrg_bill ,
  chrg_cpo.person_name_chrg  person_name_chrg_cpo ,
  cust.person_name_chrg_cust  person_name_chrg_cust ,
  chrg_cpo.person_email_chrg  person_email_chrg_cpo ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
custord.id id,
  opeitm.itm_unit_id  itm_unit_id ,
  chrg_cpo.scrlv_level1_chrg  scrlv_level1_chrg_cpo ,
  opeitm.opeitm_operation  opeitm_operation ,
  opeitm.opeitm_opt_fixoterm  opeitm_opt_fixoterm ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  opeitm.opeitm_safestkqty  opeitm_safestkqty ,
  opeitm.opeitm_packqty  opeitm_packqty ,
custord.cno  custord_cno,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.opeitm_shuffle_flg  opeitm_shuffle_flg ,
  opeitm.opeitm_chkord_prc  opeitm_chkord_prc ,
  opeitm.opeitm_chkord  opeitm_chkord ,
  opeitm.opeitm_autocreate_act  opeitm_autocreate_act ,
  opeitm.opeitm_shuffle_loca  opeitm_shuffle_loca ,
  cust.cust_contract_price  cust_contract_price ,
  cust.cust_rule_price  cust_rule_price ,
custord.opeitms_id   custord_opeitm_id,
  opeitm.opeitm_esttosch  opeitm_esttosch ,
  opeitm.opeitm_stktaking_proc  opeitm_stktaking_proc ,
  opeitm.opeitm_rule_price  opeitm_rule_price ,
custord.contract_price  custord_contract_price,
  cust.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  chrg_cpo.usrgrp_name_chrg  usrgrp_name_chrg_cpo ,
  cust.usrgrp_name_chrg_cust  usrgrp_name_chrg_cust ,
  opeitm.classlist_code  classlist_code ,
  opeitm.opeitm_mold  opeitm_mold ,
  cust.crr_code_cust  crr_code_cust ,
  cust.cust_personname  cust_personname ,
  cust.crr_name_cust  crr_name_cust ,
  opeitm.opeitm_autocreate_inst  opeitm_autocreate_inst ,
  cust.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  chrg_cpo.person_sect_id_chrg  person_sect_id_chrg_cpo ,
  cust.person_sect_id_chrg_cust  person_sect_id_chrg_cust ,
  cust.cust_chrg_id_cust  cust_chrg_id_cust ,
custord.chrgs_id_cpo   custord_chrg_id_cpo,
  cust.cust_amtround  cust_amtround ,
  cust.cust_amtdecimal  cust_amtdecimal ,
  cust.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  chrg_cpo.usrgrp_code_chrg  usrgrp_code_chrg_cpo ,
  cust.usrgrp_code_chrg_cust  usrgrp_code_chrg_cust ,
  opeitm.classlist_name  classlist_name ,
  opeitm.opeitm_packno_flg  opeitm_packno_flg ,
  prjno.prjno_code_chil  prjno_code_chil ,
  cust.cust_custtype  cust_custtype ,
custord.sno  custord_sno,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_priority  opeitm_priority ,
  prjno.prjno_code  prjno_code ,
  opeitm.opeitm_contents  opeitm_contents ,
custord.prjnos_id   custord_prjno_id,
  opeitm.opeitm_acceptance_proc  opeitm_acceptance_proc ,
  custrcvplc.custrcvplc_loca_id_custrcvplc  custrcvplc_loca_id_custrcvplc ,
  custrcvplc.custrcvplc_contents  custrcvplc_contents ,
  cust.cust_contents  cust_contents ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.opeitm_chkinst  opeitm_chkinst ,
  cust.bill_loca_id_bill  bill_loca_id_bill ,
  cust.cust_crr_id_cust  cust_crr_id_cust ,
  cust.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  chrg_cpo.chrg_person_id_chrg  chrg_person_id_chrg_cpo ,
  cust.chrg_person_id_chrg_cust  chrg_person_id_chrg_cust ,
  opeitm.boxe_boxtype  boxe_boxtype ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.opeitm_maxqty  opeitm_maxqty ,
  opeitm.opeitm_prjalloc_flg  opeitm_prjalloc_flg 
 from custords   custord,
  r_locas  loca_fm ,  r_custrcvplcs  custrcvplc ,  r_custs  cust ,  r_persons  person_upd ,  r_opeitms  opeitm ,  r_chrgs  chrg_cpo ,  r_prjnos  prjno 
  where       custord.locas_id_fm = loca_fm.id      and custord.custrcvplcs_id = custrcvplc.id      and custord.custs_id = cust.id      and custord.persons_id_upd = person_upd.id      and custord.opeitms_id = opeitm.id      and custord.chrgs_id_cpo = chrg_cpo.id      and custord.prjnos_id = prjno.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custords;
 CREATE TABLE sio.sio_r_custords (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_custords_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,custord_isudate   timestamp 
,custord_sno  varchar (40) 
,custord_cno  varchar (40) 
,custord_gno  varchar (40) 
,custord_itm_code_client  varchar (50) 
,itm_name  varchar (100) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_code_fm  varchar (50) 
,loca_code_bill  varchar (50) 
,loca_code_sect_chrg_cpo  varchar (50) 
,loca_code_sect_chrg_cust  varchar (50) 
,loca_code_shelfno  varchar (50) 
,loca_code_custrcvplc  varchar (50) 
,loca_code_cust  varchar (50) 
,loca_code  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,loca_name_fm  varchar (100) 
,loca_name_bill  varchar (100) 
,loca_name_sect_chrg_cpo  varchar (100) 
,loca_name_sect_chrg_cust  varchar (100) 
,loca_name_shelfno  varchar (100) 
,loca_name_custrcvplc  varchar (100) 
,loca_name_cust  varchar (100) 
,loca_name  varchar (100) 
,boxe_name  varchar (100) 
,crr_name_cust  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,person_code_chrg_bill  varchar (50) 
,person_code_chrg_cust  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,person_name_chrg_cust  varchar (100) 
,scrlv_code_chrg_cpo  varchar (50) 
,scrlv_code_chrg_cust  varchar (50) 
,shelfno_name  varchar (100) 
,prjno_name  varchar (100) 
,prjno_code  varchar (50) 
,usrgrp_name_chrg_cpo  varchar (100) 
,usrgrp_name_chrg_bill  varchar (100) 
,usrgrp_name_chrg_cust  varchar (100) 
,classlist_code  varchar (50) 
,shelfno_code  varchar (50) 
,unit_name_outbox  varchar (100) 
,unit_name_case  varchar (100) 
,unit_name  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,itm_code  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_box  varchar (100) 
,boxe_code  varchar (50) 
,prjno_code_chil  varchar (50) 
,classlist_name  varchar (100) 
,unit_code_outbox  varchar (50) 
,usrgrp_code_chrg_cust  varchar (50) 
,unit_code_box  varchar (50) 
,crr_code_cust  varchar (50) 
,unit_code_case  varchar (50) 
,unit_code  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,person_code_chrg_cpo  varchar (50) 
,person_name_chrg_cpo  varchar (100) 
,opeitm_rule_price  varchar (1) 
,opeitm_maxqty  numeric (22,0)
,opeitm_prdpurshp  varchar (20) 
,opeitm_opt_fix_flg  varchar (1) 
,cust_autocreate_custact  varchar (1) 
,boxe_boxtype  varchar (20) 
,opeitm_chkinst  varchar (1) 
,cust_contents  varchar (4000) 
,custrcvplc_contents  varchar (4000) 
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autoinst_p  numeric (3,0)
,opeitm_autoact_p  numeric (3,0)
,opeitm_autoord_p  numeric (3,0)
,opeitm_acceptance_proc  varchar (1) 
,opeitm_contents  varchar (4000) 
,opeitm_priority  numeric (3,0)
,opeitm_processseq  numeric (3,0)
,cust_custtype  varchar (1) 
,opeitm_packno_flg  varchar (1) 
,loca_abbr_fm  varchar (50) 
,loca_zip_fm  varchar (10) 
,loca_country_fm  varchar (20) 
,loca_prfct_fm  varchar (20) 
,loca_addr1_fm  varchar (50) 
,cust_amtdecimal  numeric (38,0)
,loca_addr2_fm  varchar (50) 
,cust_amtround  varchar (2) 
,loca_tel_fm  varchar (20) 
,loca_fax_fm  varchar (20) 
,loca_mail_fm  varchar (20) 
,opeitm_duration  numeric (38,2)
,opeitm_units_lttime  varchar (4) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_minqty  numeric (38,6)
,person_email_chrg_cpo  varchar (50) 
,cust_personname  varchar (30) 
,cust_contract_price  varchar (1) 
,cust_rule_price  varchar (1) 
,opeitm_esttosch  numeric (22,0)
,opeitm_stktaking_proc  varchar (1) 
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_mold  varchar (1) 
,scrlv_level1_chrg_cpo  varchar (1) 
,opeitm_operation  varchar (20) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_safestkqty  numeric (38,0)
,opeitm_packqty  numeric (38,0)
,opeitm_shuffle_flg  varchar (1) 
,opeitm_chkord_prc  numeric (3,0)
,opeitm_chkord  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,custord_duedate   timestamp 
,custord_qty  numeric (18,4)
,custord_price  numeric (22,0)
,custord_amt  numeric (18,4)
,usrgrp_code_chrg_cpo  varchar (50) 
,custord_toduedate   timestamp(6) 
,custord_contract_price  varchar (1) 
,custord_expiredate   date 
,custord_contents  varchar (4000) 
,custord_remark  varchar (4000) 
,custord_custrcvplc_id  numeric (38,0)
,custord_chrg_id_cpo  numeric (38,0)
,custord_prjno_id  numeric (38,0)
,custord_opeitm_id  numeric (38,0)
,custord_loca_id_fm  numeric (38,0)
,person_sect_id_chrg_cpo  numeric (22,0)
,person_sect_id_chrg_cust  numeric (22,0)
,cust_chrg_id_cust  numeric (38,0)
,loca_addr2  varchar (50) 
,loca_addr1  varchar (50) 
,loca_prfct  varchar (20) 
,loca_zip  varchar (10) 
,loca_abbr  varchar (50) 
,cust_loca_id_cust  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,bill_chrg_id_bill  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,bill_loca_id_bill  numeric (38,0)
,cust_crr_id_cust  numeric (38,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,chrg_person_id_chrg_cpo  numeric (38,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,boxe_unit_id_box  numeric (22,0)
,boxe_unit_id_outbox  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,custord_created_at   timestamp(6) 
,custord_updated_at   timestamp(6) 
,custord_id  numeric (22,0)
,cust_bill_id  numeric (22,0)
,custord_cust_id  numeric (22,0)
,custord_person_id_upd  numeric (22,0)
,id  numeric (22,0)
,custord_update_ip  varchar (40) 
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
 CREATE INDEX sio_r_custords_uk1 
  ON sio.sio_r_custords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custords_seq ;
 create sequence sio.sio_r_custords_seq ;
