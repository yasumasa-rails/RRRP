
 alter table  custords ALTER COLUMN qty  TYPE numeric(22,6);

 alter table custords ALTER COLUMN cno_custsch  TYPE varchar(50) ;

 --- drop view r_custords cascade  
 create or replace view r_custords as select  
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  custrcvplc.cust_bill_id_custrcvplc  cust_bill_id_custrcvplc ,
  cust.cust_bill_id  cust_bill_id ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
custord.gno  custord_gno,
custord.itm_code_client  custord_itm_code_client,
  opeitm.boxe_code  boxe_code ,
custord.contents  custord_contents,
  custrcvplc.bill_chrg_id_bill_custrcvplc  bill_chrg_id_bill_custrcvplc ,
  cust.bill_chrg_id_bill  bill_chrg_id_bill ,
  opeitm.boxe_name  boxe_name ,
  prjno.prjno_name  prjno_name ,
custord.locas_id_fm   custord_loca_id_fm,
custord.custrcvplcs_id   custord_custrcvplc_id,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_code  unit_code ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.unit_name  unit_name ,
  opeitm.itm_code  itm_code ,
  opeitm.itm_name  itm_name ,
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
  custrcvplc.cust_loca_id_cust_custrcvplc  cust_loca_id_cust_custrcvplc ,
  cust.cust_loca_id_cust  cust_loca_id_cust ,
  custrcvplc.loca_code_cust_custrcvplc  loca_code_cust_custrcvplc ,
  loca_fm.loca_code  loca_code_fm ,
  cust.loca_code_bill  loca_code_bill ,
  chrg_cpo.loca_code_sect_chrg  loca_code_sect_chrg_cpo ,
  cust.loca_code_cust  loca_code_cust ,
  custrcvplc.loca_name_cust_custrcvplc  loca_name_cust_custrcvplc ,
  loca_fm.loca_name  loca_name_fm ,
  cust.loca_name_bill  loca_name_bill ,
  chrg_cpo.loca_name_sect_chrg  loca_name_sect_chrg_cpo ,
  cust.loca_name_cust  loca_name_cust ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  chrg_cpo.person_code_chrg  person_code_chrg_cpo ,
  cust.person_code_chrg_cust  person_code_chrg_cust ,
  chrg_cpo.person_name_chrg  person_name_chrg_cpo ,
  cust.person_name_chrg_cust  person_name_chrg_cust ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
custord.id id,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  opeitm.opeitm_packqty  opeitm_packqty ,
custord.cno  custord_cno,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  cust.cust_contract_price  cust_contract_price ,
  custrcvplc.custrcvplc_code  custrcvplc_code ,
  custrcvplc.custrcvplc_name  custrcvplc_name ,
custord.opeitms_id   custord_opeitm_id,
custord.cno_custsch  custord_cno_custsch,
custord.gno_custsch  custord_gno_custsch,
custord.contract_price  custord_contract_price,
  custrcvplc.bill_crr_id_bill_custrcvplc  bill_crr_id_bill_custrcvplc ,
  cust.bill_crr_id_bill  bill_crr_id_bill ,
  custrcvplc.custrcvplc_stktaking_proc  custrcvplc_stktaking_proc ,
custord.starttime  custord_starttime,
  opeitm.classlist_code  classlist_code ,
  cust.crr_code_bill  crr_code_bill ,
  cust.crr_name_bill  crr_name_bill ,
  cust.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  chrg_cpo.person_sect_id_chrg  person_sect_id_chrg_cpo ,
  cust.person_sect_id_chrg_cust  person_sect_id_chrg_cust ,
custord.chrgs_id_cpo   custord_chrg_id_cpo,
  custrcvplc.cust_chrg_id_cust_custrcvplc  cust_chrg_id_cust_custrcvplc ,
  cust.cust_chrg_id_cust  cust_chrg_id_cust ,
  opeitm.classlist_name  classlist_name ,
  prjno.prjno_code_chil  prjno_code_chil ,
custord.sno  custord_sno,
  opeitm.opeitm_processseq  opeitm_processseq ,
  prjno.prjno_code  prjno_code ,
custord.prjnos_id   custord_prjno_id,
  custrcvplc.custrcvplc_cust_id_custrcvplc  custrcvplc_cust_id_custrcvplc ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  custrcvplc.bill_loca_id_bill_custrcvplc  bill_loca_id_bill_custrcvplc ,
  cust.bill_loca_id_bill  bill_loca_id_bill ,
  custrcvplc.chrg_person_id_chrg_cust_custrcvplc  chrg_person_id_chrg_cust_custrcvplc ,
  custrcvplc.chrg_person_id_chrg_bill_custrcvplc  chrg_person_id_chrg_bill_custrcvplc ,
  cust.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  chrg_cpo.chrg_person_id_chrg  chrg_person_id_chrg_cpo ,
  cust.chrg_person_id_chrg_cust  chrg_person_id_chrg_cust ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox 
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
,custord_isudate   date 
,custord_cno  varchar (40) 
,loca_code_cust  varchar (50) 
,loca_name_cust  varchar (100) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,opeitm_processseq  numeric (3,0)
,custord_duedate   timestamp(6) 
,custord_qty  numeric (18,4)
,custord_price  numeric (22,0)
,cust_contract_price  varchar (1) 
,custord_contract_price  varchar (1) 
,custord_itm_code_client  varchar (50) 
,custord_amt  numeric (18,4)
,loca_code_cust_custrcvplc  varchar (50) 
,loca_name_cust_custrcvplc  varchar (100) 
,custrcvplc_code  varchar (50) 
,custrcvplc_name  varchar (100) 
,person_code_chrg_cust  varchar (50) 
,person_name_chrg_cust  varchar (100) 
,person_code_chrg_cpo  varchar (50) 
,person_name_chrg_cpo  varchar (100) 
,loca_code_sect_chrg_cust  varchar (50) 
,loca_code_sect_chrg_cpo  varchar (50) 
,loca_name_sect_chrg_cust  varchar (100) 
,loca_name_sect_chrg_cpo  varchar (100) 
,person_code_chrg_bill  varchar (50) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,loca_code_bill  varchar (50) 
,loca_name_bill  varchar (100) 
,loca_code_fm  varchar (50) 
,loca_name_fm  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,person_name_chrg_cust_custrcvplc  varchar (100) 
,person_name_chrg_bill_custrcvplc  varchar (100) 
,usrgrp_code_chrg_bill  varchar (50) 
,usrgrp_code_chrg_bill_custrcvplc  varchar (50) 
,usrgrp_code_chrg_cust_custrcvplc  varchar (50) 
,crr_name_bill_custrcvplc  varchar (100) 
,scrlv_code_chrg_bill_custrcvplc  varchar (50) 
,crr_code_bill_custrcvplc  varchar (50) 
,scrlv_code_chrg_bill  varchar (50) 
,scrlv_code_chrg_cpo  varchar (50) 
,scrlv_code_chrg_cust  varchar (50) 
,usrgrp_name_chrg_bill_custrcvplc  varchar (100) 
,boxe_name  varchar (100) 
,loca_name_shelfno  varchar (100) 
,loca_name  varchar (100) 
,usrgrp_code_chrg_cust  varchar (50) 
,person_code_chrg_cust_custrcvplc  varchar (50) 
,person_code_chrg_bill_custrcvplc  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,boxe_code  varchar (50) 
,usrgrp_name_chrg_cust  varchar (100) 
,usrgrp_name_chrg_cpo  varchar (100) 
,scrlv_code_chrg_cust_custrcvplc  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,usrgrp_name_chrg_bill  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_code  varchar (50) 
,usrgrp_name_chrg_cust_custrcvplc  varchar (100) 
,crr_code_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,classlist_code  varchar (50) 
,custord_starttime   timestamp(6) 
,custord_gno_custsch  varchar (50) 
,custord_cno_custsch  varchar (50) 
,classlist_name  varchar (100) 
,custord_sno  varchar (40) 
,custord_gno  varchar (40) 
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_autoord_p  numeric (3,0)
,itm_std  varchar (50) 
,loca_abbr_fm  varchar (50) 
,loca_zip_fm  varchar (10) 
,loca_country_fm  varchar (20) 
,loca_prfct_fm  varchar (20) 
,loca_addr1_fm  varchar (50) 
,loca_addr2_fm  varchar (50) 
,loca_tel_fm  varchar (20) 
,loca_fax_fm  varchar (20) 
,loca_mail_fm  varchar (20) 
,opeitm_duration  numeric (38,2)
,opeitm_units_lttime  varchar (4) 
,opeitm_autoinst_p  numeric (3,0)
,opeitm_autocreate_ord  varchar (1) 
,opeitm_minqty  numeric (38,6)
,cust_autocreate_custact  varchar (1) 
,person_email_chrg_cpo  varchar (50) 
,scrlv_level1_chrg_cpo  varchar (1) 
,opeitm_operation  varchar (20) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_safestkqty  numeric (38,0)
,opeitm_packqty  numeric (38,0)
,opeitm_shuffle_flg  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_chkord_prc  numeric (3,0)
,opeitm_chkord  varchar (1) 
,opeitm_opt_fix_flg  varchar (1) 
,cust_rule_price  varchar (1) 
,opeitm_prdpurshp  varchar (20) 
,custrcvplc_addr1  varchar (50) 
,custrcvplc_addr2  varchar (50) 
,custrcvplc_tel  varchar (20) 
,opeitm_esttosch  numeric (22,0)
,opeitm_stktaking_proc  varchar (1) 
,opeitm_rule_price  varchar (1) 
,custrcvplc_stktaking_proc  varchar (1) 
,opeitm_mold  varchar (1) 
,cust_personname  varchar (30) 
,opeitm_autocreate_inst  varchar (1) 
,cust_amtround  varchar (2) 
,cust_amtdecimal  numeric (38,0)
,opeitm_packno_flg  varchar (1) 
,cust_custtype  varchar (1) 
,opeitm_priority  numeric (3,0)
,opeitm_contents  varchar (4000) 
,opeitm_acceptance_proc  varchar (1) 
,custrcvplc_contents  varchar (4000) 
,cust_contents  varchar (4000) 
,opeitm_chkinst  varchar (1) 
,boxe_boxtype  varchar (20) 
,opeitm_maxqty  numeric (22,0)
,opeitm_autoact_p  numeric (3,0)
,usrgrp_code_chrg_cpo  varchar (50) 
,custord_toduedate   timestamp(6) 
,custord_expiredate   date 
,custord_contents  varchar (4000) 
,custord_remark  varchar (4000) 
,custord_custrcvplc_id  numeric (38,0)
,custord_prjno_id  numeric (38,0)
,custord_loca_id_fm  numeric (38,0)
,custord_opeitm_id  numeric (38,0)
,custord_chrg_id_cpo  numeric (38,0)
,cust_loca_id_cust_custrcvplc  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,person_sect_id_chrg_cust_custrcvplc  numeric (22,0)
,person_sect_id_chrg_bill_custrcvplc  numeric (22,0)
,person_sect_id_chrg_bill  numeric (22,0)
,person_sect_id_chrg_cpo  numeric (22,0)
,person_sect_id_chrg_cust  numeric (22,0)
,bill_chrg_id_bill_custrcvplc  numeric (22,0)
,cust_chrg_id_cust_custrcvplc  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,itm_unit_id  numeric (22,0)
,cust_chrg_id_cust  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,bill_loca_id_bill_custrcvplc  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,bill_loca_id_bill  numeric (38,0)
,chrg_person_id_chrg_cpo  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,loca_addr2  varchar (50) 
,loca_addr1  varchar (50) 
,loca_prfct  varchar (20) 
,loca_zip  varchar (10) 
,chrg_person_id_chrg_cust  numeric (38,0)
,loca_abbr  varchar (50) 
,cust_loca_id_cust  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,cust_bill_id_custrcvplc  numeric (38,0)
,chrg_person_id_chrg_bill_custrcvplc  numeric (38,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,bill_chrg_id_bill  numeric (22,0)
,bill_crr_id_bill_custrcvplc  numeric (22,0)
,bill_crr_id_bill  numeric (22,0)
,custrcvplc_cust_id_custrcvplc  numeric (22,0)
,chrg_person_id_chrg_cust_custrcvplc  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,custord_updated_at   timestamp(6) 
,custord_update_ip  varchar (40) 
,custord_person_id_upd  numeric (22,0)
,custord_created_at   timestamp(6) 
,custord_cust_id  numeric (22,0)
,id  numeric (22,0)
,cust_bill_id  numeric (22,0)
,custord_id  numeric (22,0)
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
