
  drop view if  exists r_custacts cascade ; 
 create or replace view r_custacts as select  
  cust.loca_code_bill  loca_code_bill ,
custact.custs_id   custact_cust_id,
custact.id id,
custact.id  custact_id,
custact.asstwhs_id   custact_asstwh_id,
custact.custrcvplcs_id   custact_custrcvplc_id,
custact.itm_code_client  custact_itm_code_client,
custact.contract_price  custact_contract_price,
custact.chrgs_id_cpo   custact_chrg_id_cpo,
custact.itms_id   custact_itm_id,
custact.tblname  custact_tblname,
custact.tblid  custact_tblid,
custact.isudate  custact_isudate,
custact.sno  custact_sno,
custact.amt  custact_amt,
custact.price  custact_price,
custact.qty  custact_qty,
custact.persons_id_upd   custact_person_id_upd,
custact.updated_at  custact_updated_at,
custact.created_at  custact_created_at,
custact.update_ip  custact_update_ip,
custact.expiredate  custact_expiredate,
custact.remark  custact_remark,
custact.saledate  custact_saledate,
  cust.cust_bill_id  cust_bill_id ,
  cust.cust_loca_id_cust  cust_loca_id_cust ,
  cust.cust_chrg_id_cust  cust_chrg_id_cust ,
  cust.loca_name_bill  loca_name_bill ,
  cust.bill_chrg_id_bill  bill_chrg_id_bill ,
  cust.bill_crr_id_bill  bill_crr_id_bill ,
  cust.bill_loca_id_bill  bill_loca_id_bill ,
  cust.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  cust.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  cust.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  cust.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  cust.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  cust.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  cust.person_name_chrg_bill  person_name_chrg_bill ,
  cust.person_code_chrg_bill  person_code_chrg_bill ,
  cust.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  cust.crr_name_bill  crr_name_bill ,
  cust.crr_code_bill  crr_code_bill ,
  cust.loca_code_cust  loca_code_cust ,
  cust.loca_name_cust  loca_name_cust ,
  cust.person_sect_id_chrg_cust  person_sect_id_chrg_cust ,
  cust.scrlv_code_chrg_cust  scrlv_code_chrg_cust ,
  cust.person_name_chrg_cust  person_name_chrg_cust ,
  cust.loca_name_sect_chrg_cust  loca_name_sect_chrg_cust ,
  cust.loca_code_sect_chrg_cust  loca_code_sect_chrg_cust ,
  cust.person_code_chrg_cust  person_code_chrg_cust ,
  cust.usrgrp_code_chrg_cust  usrgrp_code_chrg_cust ,
  cust.usrgrp_name_chrg_cust  usrgrp_name_chrg_cust ,
  cust.chrg_person_id_chrg_cust  chrg_person_id_chrg_cust ,
  custrcvplc.custrcvplc_loca_id_custrcvplc  custrcvplc_loca_id_custrcvplc ,
  custrcvplc.loca_code_custrcvplc  loca_code_custrcvplc ,
  custrcvplc.loca_name_custrcvplc  loca_name_custrcvplc ,
  chrg_cpo.person_sect_id_chrg  person_sect_id_chrg_cpo ,
  chrg_cpo.scrlv_code_chrg  scrlv_code_chrg_cpo ,
  chrg_cpo.person_name_chrg  person_name_chrg_cpo ,
  chrg_cpo.loca_name_sect_chrg  loca_name_sect_chrg_cpo ,
  chrg_cpo.loca_code_sect_chrg  loca_code_sect_chrg_cpo ,
  chrg_cpo.person_code_chrg  person_code_chrg_cpo ,
  chrg_cpo.usrgrp_code_chrg  usrgrp_code_chrg_cpo ,
  chrg_cpo.usrgrp_name_chrg  usrgrp_name_chrg_cpo ,
  chrg_cpo.chrg_person_id_chrg  chrg_person_id_chrg_cpo ,
  itm.itm_classlist_id  itm_classlist_id ,
  itm.itm_unit_id  itm_unit_id ,
  itm.classlist_name  classlist_name ,
  itm.classlist_code  classlist_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name 
 from custacts   custact,
  r_custs  cust ,  r_asstwhs  asstwh ,  r_custrcvplcs  custrcvplc ,  r_chrgs  chrg_cpo ,  r_itms  itm ,  r_persons  person_upd 
  where       custact.custs_id = cust.id      and custact.asstwhs_id = asstwh.id      and custact.custrcvplcs_id = custrcvplc.id      and custact.chrgs_id_cpo = chrg_cpo.id      and custact.itms_id = itm.id      and custact.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custacts;
 CREATE TABLE sio.sio_r_custacts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custacts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,custact_sno  varchar (40) 
,itm_name  varchar (100) 
,loca_name_bill  varchar (100) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,usrgrp_name_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,person_code_chrg_bill  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,crr_code_bill  varchar (50) 
,loca_code_cust  varchar (50) 
,loca_name_cust  varchar (100) 
,scrlv_code_chrg_cust  varchar (50) 
,person_name_chrg_cust  varchar (100) 
,loca_name_sect_chrg_cust  varchar (100) 
,loca_code_sect_chrg_cust  varchar (50) 
,person_code_chrg_cust  varchar (50) 
,usrgrp_code_chrg_cust  varchar (50) 
,usrgrp_name_chrg_cust  varchar (100) 
,loca_code_custrcvplc  varchar (50) 
,loca_name_custrcvplc  varchar (100) 
,scrlv_code_chrg_cpo  varchar (50) 
,person_name_chrg_cpo  varchar (100) 
,loca_name_sect_chrg_cpo  varchar (100) 
,loca_code_sect_chrg_cpo  varchar (50) 
,person_code_chrg_cpo  varchar (50) 
,usrgrp_code_chrg_cpo  varchar (50) 
,usrgrp_name_chrg_cpo  varchar (100) 
,classlist_name  varchar (100) 
,classlist_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,itm_code  varchar (50) 
,loca_code_bill  varchar (50) 
,custact_expiredate   date 
,custact_qty  numeric (22,6)
,custact_tblname  varchar (30) 
,custact_price  numeric (38,4)
,custact_isudate   timestamp(6) 
,custact_tblid  numeric (38,0)
,custact_amt  numeric (18,4)
,custact_contract_price  varchar (1) 
,custact_saledate   timestamp(6) 
,custact_itm_code_client  varchar (50) 
,itm_deth  numeric (22,0)
,itm_material  varchar (50) 
,itm_model  varchar (50) 
,itm_weight  numeric (22,0)
,cust_rule_price  varchar (1) 
,custrcvplc_stktaking_proc  varchar (1) 
,custrcvplc_contents  varchar (4000) 
,unit_contents  varchar (4000) 
,itm_length  numeric (22,0)
,scrlv_level1_chrg_cpo  varchar (1) 
,itm_datascale  numeric (22,0)
,person_email_chrg_cpo  varchar (50) 
,itm_design  varchar (50) 
,itm_wide  numeric (22,0)
,cust_autocreate_custact  varchar (1) 
,cust_contract_price  varchar (1) 
,cust_personname  varchar (30) 
,cust_amtround  varchar (2) 
,cust_amtdecimal  numeric (38,0)
,cust_custtype  varchar (1) 
,cust_contents  varchar (4000) 
,custact_remark  varchar (4000) 
,custact_chrg_id_cpo  numeric (38,0)
,custact_cust_id  numeric (38,0)
,custact_person_id_upd  numeric (38,0)
,custact_updated_at   timestamp(6) 
,custact_created_at   timestamp(6) 
,custact_update_ip  varchar (40) 
,id  numeric (38,0)
,custact_id  numeric (38,0)
,custact_asstwh_id  numeric (38,0)
,custact_custrcvplc_id  numeric (38,0)
,custact_itm_id  numeric (38,0)
,bill_loca_id_bill  numeric (38,0)
,person_sect_id_chrg_cust  numeric (22,0)
,bill_crr_id_bill  numeric (22,0)
,cust_bill_id  numeric (38,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,itm_unit_id  numeric (22,0)
,person_sect_id_chrg_cpo  numeric (22,0)
,cust_loca_id_cust  numeric (38,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,cust_chrg_id_cust  numeric (38,0)
,bill_chrg_id_bill  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,chrg_person_id_chrg_cpo  numeric (38,0)
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
 CREATE INDEX sio_r_custacts_uk1 
  ON sio.sio_r_custacts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custacts_seq ;
 create sequence sio.sio_r_custacts_seq ;
  drop view if  exists r_custschs cascade ; 
 create or replace view r_custschs as select  
custsch.id id,
custsch.id  custsch_id,
custsch.custs_id   custsch_cust_id,
custsch.duedate  custsch_duedate,
custsch.isudate  custsch_isudate,
custsch.price  custsch_price,
custsch.amt  custsch_amt,
custsch.cno  custsch_cno,
custsch.remark  custsch_remark,
custsch.expiredate  custsch_expiredate,
custsch.persons_id_upd   custsch_person_id_upd,
custsch.update_ip  custsch_update_ip,
custsch.created_at  custsch_created_at,
custsch.updated_at  custsch_updated_at,
custsch.contents  custsch_contents,
custsch.opeitms_id   custsch_opeitm_id,
custsch.qty_sch  custsch_qty_sch,
custsch.gno  custsch_gno,
custsch.contract_price  custsch_contract_price,
custsch.starttime  custsch_starttime,
custsch.sno  custsch_sno,
custsch.prjnos_id   custsch_prjno_id,
  cust.cust_bill_id  cust_bill_id ,
  cust.cust_loca_id_cust  cust_loca_id_cust ,
  cust.cust_chrg_id_cust  cust_chrg_id_cust ,
  cust.loca_name_bill  loca_name_bill ,
  cust.loca_code_bill  loca_code_bill ,
  cust.bill_chrg_id_bill  bill_chrg_id_bill ,
  cust.bill_crr_id_bill  bill_crr_id_bill ,
  cust.bill_loca_id_bill  bill_loca_id_bill ,
  cust.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  cust.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  cust.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  cust.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  cust.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  cust.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  cust.person_name_chrg_bill  person_name_chrg_bill ,
  cust.person_code_chrg_bill  person_code_chrg_bill ,
  cust.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  cust.crr_name_bill  crr_name_bill ,
  cust.crr_code_bill  crr_code_bill ,
  cust.loca_code_cust  loca_code_cust ,
  cust.loca_name_cust  loca_name_cust ,
  cust.person_sect_id_chrg_cust  person_sect_id_chrg_cust ,
  cust.scrlv_code_chrg_cust  scrlv_code_chrg_cust ,
  cust.person_name_chrg_cust  person_name_chrg_cust ,
  cust.loca_name_sect_chrg_cust  loca_name_sect_chrg_cust ,
  cust.loca_code_sect_chrg_cust  loca_code_sect_chrg_cust ,
  cust.person_code_chrg_cust  person_code_chrg_cust ,
  cust.usrgrp_code_chrg_cust  usrgrp_code_chrg_cust ,
  cust.usrgrp_name_chrg_cust  usrgrp_name_chrg_cust ,
  cust.chrg_person_id_chrg_cust  chrg_person_id_chrg_cust ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code  prjno_code 
 from custschs   custsch,
  r_custs  cust ,  r_persons  person_upd ,  r_opeitms  opeitm ,  r_prjnos  prjno 
  where       custsch.custs_id = cust.id      and custsch.persons_id_upd = person_upd.id      and custsch.opeitms_id = opeitm.id      and custsch.prjnos_id = prjno.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custschs;
 CREATE TABLE sio.sio_r_custschs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custschs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,custsch_cno  varchar (40) 
,custsch_sno  varchar (40) 
,custsch_gno  varchar (40) 
,person_code_chrg_bill  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,usrgrp_name_chrg_bill  varchar (100) 
,usrgrp_name_chrg_cust  varchar (100) 
,usrgrp_code_chrg_cust  varchar (50) 
,person_code_chrg_cust  varchar (50) 
,loca_code_sect_chrg_cust  varchar (50) 
,loca_name_sect_chrg_cust  varchar (100) 
,person_name_chrg_cust  varchar (100) 
,loca_name_bill  varchar (100) 
,crr_name_bill  varchar (100) 
,usrgrp_code_chrg_bill  varchar (50) 
,scrlv_code_chrg_cust  varchar (50) 
,loca_name_cust  varchar (100) 
,prjno_code  varchar (50) 
,loca_code_cust  varchar (50) 
,prjno_name  varchar (100) 
,crr_code_bill  varchar (50) 
,prjno_code_chil  varchar (50) 
,loca_code_bill  varchar (50) 
,custsch_contract_price  varchar (1) 
,custsch_starttime   timestamp(6) 
,custsch_qty_sch  numeric (22,6)
,custsch_duedate   timestamp(6) 
,custsch_isudate   timestamp(6) 
,custsch_expiredate   date 
,custsch_price  numeric (38,4)
,custsch_amt  numeric (18,4)
,opeitm_processseq  numeric (38,0)
,cust_autocreate_custact  varchar (1) 
,cust_contract_price  varchar (1) 
,cust_rule_price  varchar (1) 
,cust_personname  varchar (30) 
,cust_amtround  varchar (2) 
,cust_amtdecimal  numeric (38,0)
,cust_custtype  varchar (1) 
,cust_contents  varchar (4000) 
,opeitm_autoact_p  numeric (3,0)
,opeitm_autoord_p  numeric (3,0)
,opeitm_duration  numeric (38,2)
,opeitm_units_lttime  varchar (4) 
,opeitm_minqty  numeric (22,6)
,opeitm_operation  varchar (40) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_safestkqty  numeric (22,0)
,opeitm_packqty  numeric (18,2)
,opeitm_shuffle_flg  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_chkinst_proc  varchar (1) 
,opeitm_esttosch  numeric (38,0)
,opeitm_stktaking_proc  varchar (1) 
,opeitm_rule_price  varchar (1) 
,opeitm_mold  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_packno_proc  varchar (1) 
,opeitm_priority  numeric (38,0)
,opeitm_contents  varchar (4000) 
,opeitm_acceptance_proc  varchar (1) 
,opeitm_chkord_proc  varchar (3) 
,opeitm_maxqty  numeric (22,6)
,opeitm_prjalloc_flg  numeric (38,0)
,opeitm_prdpurshp  varchar (5) 
,itm_std  varchar (50) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autoinst_p  numeric (3,0)
,opeitm_lotno_proc  varchar (3) 
,custsch_contents  varchar (4000) 
,custsch_remark  varchar (4000) 
,custsch_updated_at   timestamp(6) 
,custsch_created_at   timestamp(6) 
,id  numeric (38,0)
,custsch_update_ip  varchar (40) 
,custsch_id  numeric (38,0)
,custsch_cust_id  numeric (38,0)
,custsch_prjno_id  numeric (38,0)
,custsch_person_id_upd  numeric (38,0)
,custsch_opeitm_id  numeric (38,0)
,opeitm_shelfno_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,bill_loca_id_bill  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,bill_chrg_id_bill  numeric (22,0)
,cust_chrg_id_cust  numeric (38,0)
,cust_loca_id_cust  numeric (38,0)
,cust_bill_id  numeric (38,0)
,person_sect_id_chrg_cust  numeric (22,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,opeitm_boxe_id  numeric (38,0)
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
 CREATE INDEX sio_r_custschs_uk1 
  ON sio.sio_r_custschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custschs_seq ;
 create sequence sio.sio_r_custschs_seq ;
  drop view if  exists r_custrcvplcs cascade ; 
 create or replace view r_custrcvplcs as select  
custrcvplc.locas_id_custrcvplc   custrcvplc_loca_id_custrcvplc,
custrcvplc.stktaking_proc  custrcvplc_stktaking_proc,
custrcvplc.contents  custrcvplc_contents,
custrcvplc.remark  custrcvplc_remark,
custrcvplc.expiredate  custrcvplc_expiredate,
custrcvplc.persons_id_upd   custrcvplc_person_id_upd,
custrcvplc.update_ip  custrcvplc_update_ip,
custrcvplc.created_at  custrcvplc_created_at,
custrcvplc.updated_at  custrcvplc_updated_at,
custrcvplc.id id,
custrcvplc.id  custrcvplc_id,
  loca_custrcvplc.loca_code  loca_code_custrcvplc ,
  loca_custrcvplc.loca_name  loca_name_custrcvplc 
 from custrcvplcs   custrcvplc,
  r_locas  loca_custrcvplc ,  r_persons  person_upd 
  where       custrcvplc.locas_id_custrcvplc = loca_custrcvplc.id      and custrcvplc.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custrcvplcs;
 CREATE TABLE sio.sio_r_custrcvplcs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custrcvplcs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,loca_name_custrcvplc  varchar (100) 
,loca_code_custrcvplc  varchar (50) 
,custrcvplc_expiredate   date 
,custrcvplc_stktaking_proc  varchar (1) 
,loca_country_custrcvplc  varchar (20) 
,loca_abbr_custrcvplc  varchar (50) 
,loca_prfct_custrcvplc  varchar (20) 
,loca_tel_custrcvplc  varchar (20) 
,loca_mail_custrcvplc  varchar (20) 
,loca_addr1_custrcvplc  varchar (50) 
,loca_zip_custrcvplc  varchar (10) 
,loca_fax_custrcvplc  varchar (20) 
,loca_addr2_custrcvplc  varchar (50) 
,custrcvplc_remark  varchar (4000) 
,custrcvplc_contents  varchar (4000) 
,custrcvplc_update_ip  varchar (40) 
,custrcvplc_created_at   timestamp(6) 
,custrcvplc_updated_at   timestamp(6) 
,id  numeric (38,0)
,custrcvplc_id  numeric (38,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,custrcvplc_person_id_upd  numeric (38,0)
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
 CREATE INDEX sio_r_custrcvplcs_uk1 
  ON sio.sio_r_custrcvplcs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custrcvplcs_seq ;
 create sequence sio.sio_r_custrcvplcs_seq ;
  drop view if  exists r_custinsts cascade ; 
 create or replace view r_custinsts as select  
custinst.custs_id   custinst_cust_id,
custinst.itms_id   custinst_itm_id,
custinst.itm_code_client  custinst_itm_code_client,
custinst.cno  custinst_cno,
custinst.custrcvplcs_id   custinst_custrcvplc_id,
custinst.id id,
custinst.id  custinst_id,
custinst.asstwhs_id   custinst_asstwh_id,
custinst.gno  custinst_gno,
custinst.contract_price  custinst_contract_price,
custinst.starttime  custinst_starttime,
custinst.chrgs_id_cpo   custinst_chrg_id_cpo,
custinst.expiredate  custinst_expiredate,
custinst.duedate  custinst_duedate,
custinst.isudate  custinst_isudate,
custinst.qty  custinst_qty,
custinst.price  custinst_price,
custinst.amt  custinst_amt,
custinst.sno  custinst_sno,
custinst.remark  custinst_remark,
custinst.persons_id_upd   custinst_person_id_upd,
custinst.update_ip  custinst_update_ip,
custinst.created_at  custinst_created_at,
custinst.updated_at  custinst_updated_at,
  cust.cust_bill_id  cust_bill_id ,
  cust.cust_loca_id_cust  cust_loca_id_cust ,
  cust.cust_chrg_id_cust  cust_chrg_id_cust ,
  cust.loca_name_bill  loca_name_bill ,
  cust.loca_code_bill  loca_code_bill ,
  cust.bill_chrg_id_bill  bill_chrg_id_bill ,
  cust.bill_crr_id_bill  bill_crr_id_bill ,
  cust.bill_loca_id_bill  bill_loca_id_bill ,
  cust.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  cust.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  cust.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  cust.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  cust.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  cust.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  cust.person_name_chrg_bill  person_name_chrg_bill ,
  cust.person_code_chrg_bill  person_code_chrg_bill ,
  cust.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  cust.crr_name_bill  crr_name_bill ,
  cust.crr_code_bill  crr_code_bill ,
  cust.loca_code_cust  loca_code_cust ,
  cust.loca_name_cust  loca_name_cust ,
  cust.person_sect_id_chrg_cust  person_sect_id_chrg_cust ,
  cust.scrlv_code_chrg_cust  scrlv_code_chrg_cust ,
  cust.person_name_chrg_cust  person_name_chrg_cust ,
  cust.loca_name_sect_chrg_cust  loca_name_sect_chrg_cust ,
  cust.loca_code_sect_chrg_cust  loca_code_sect_chrg_cust ,
  cust.person_code_chrg_cust  person_code_chrg_cust ,
  cust.usrgrp_code_chrg_cust  usrgrp_code_chrg_cust ,
  cust.usrgrp_name_chrg_cust  usrgrp_name_chrg_cust ,
  cust.chrg_person_id_chrg_cust  chrg_person_id_chrg_cust ,
  itm.itm_classlist_id  itm_classlist_id ,
  itm.itm_unit_id  itm_unit_id ,
  itm.classlist_name  classlist_name ,
  itm.classlist_code  classlist_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name ,
  custrcvplc.custrcvplc_loca_id_custrcvplc  custrcvplc_loca_id_custrcvplc ,
  custrcvplc.loca_code_custrcvplc  loca_code_custrcvplc ,
  custrcvplc.loca_name_custrcvplc  loca_name_custrcvplc ,
  chrg_cpo.person_sect_id_chrg  person_sect_id_chrg_cpo ,
  chrg_cpo.scrlv_code_chrg  scrlv_code_chrg_cpo ,
  chrg_cpo.person_name_chrg  person_name_chrg_cpo ,
  chrg_cpo.loca_name_sect_chrg  loca_name_sect_chrg_cpo ,
  chrg_cpo.loca_code_sect_chrg  loca_code_sect_chrg_cpo ,
  chrg_cpo.person_code_chrg  person_code_chrg_cpo ,
  chrg_cpo.usrgrp_code_chrg  usrgrp_code_chrg_cpo ,
  chrg_cpo.usrgrp_name_chrg  usrgrp_name_chrg_cpo ,
  chrg_cpo.chrg_person_id_chrg  chrg_person_id_chrg_cpo 
 from custinsts   custinst,
  r_custs  cust ,  r_itms  itm ,  r_custrcvplcs  custrcvplc ,  r_asstwhs  asstwh ,  r_chrgs  chrg_cpo ,  r_persons  person_upd 
  where       custinst.custs_id = cust.id      and custinst.itms_id = itm.id      and custinst.custrcvplcs_id = custrcvplc.id      and custinst.asstwhs_id = asstwh.id      and custinst.chrgs_id_cpo = chrg_cpo.id      and custinst.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custinsts;
 CREATE TABLE sio.sio_r_custinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,custinst_cno  varchar (40) 
,custinst_gno  varchar (40) 
,custinst_sno  varchar (40) 
,crr_code_bill  varchar (50) 
,loca_code_cust  varchar (50) 
,loca_name_cust  varchar (100) 
,loca_name_sect_chrg_cust  varchar (100) 
,scrlv_code_chrg_cust  varchar (50) 
,person_name_chrg_cust  varchar (100) 
,person_name_chrg_cpo  varchar (100) 
,person_name_chrg_bill  varchar (100) 
,usrgrp_code_chrg_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,usrgrp_name_chrg_cust  varchar (100) 
,usrgrp_code_chrg_cust  varchar (50) 
,person_code_chrg_cust  varchar (50) 
,loca_code_sect_chrg_cust  varchar (50) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,usrgrp_name_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,person_code_chrg_bill  varchar (50) 
,scrlv_code_chrg_cpo  varchar (50) 
,loca_name_custrcvplc  varchar (100) 
,loca_code_custrcvplc  varchar (50) 
,itm_name  varchar (100) 
,itm_code  varchar (50) 
,unit_code  varchar (50) 
,usrgrp_name_chrg_cpo  varchar (100) 
,unit_name  varchar (100) 
,usrgrp_code_chrg_cpo  varchar (50) 
,classlist_code  varchar (50) 
,person_code_chrg_cpo  varchar (50) 
,loca_code_sect_chrg_cpo  varchar (50) 
,loca_name_sect_chrg_cpo  varchar (100) 
,loca_name_bill  varchar (100) 
,loca_code_bill  varchar (50) 
,classlist_name  varchar (100) 
,custinst_duedate   timestamp(6) 
,custinst_isudate   timestamp(6) 
,custinst_qty  numeric (22,6)
,custinst_price  numeric (38,4)
,custinst_amt  numeric (18,4)
,custinst_expiredate   date 
,custinst_starttime   timestamp(6) 
,custinst_contract_price  varchar (1) 
,custinst_itm_code_client  varchar (50) 
,itm_model  varchar (50) 
,cust_autocreate_custact  varchar (1) 
,cust_contract_price  varchar (1) 
,cust_rule_price  varchar (1) 
,cust_personname  varchar (30) 
,cust_amtround  varchar (2) 
,cust_amtdecimal  numeric (38,0)
,cust_custtype  varchar (1) 
,cust_contents  varchar (4000) 
,itm_weight  numeric (22,0)
,unit_contents  varchar (4000) 
,itm_length  numeric (22,0)
,itm_design  varchar (50) 
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,itm_material  varchar (50) 
,itm_datascale  numeric (22,0)
,custrcvplc_stktaking_proc  varchar (1) 
,custrcvplc_contents  varchar (4000) 
,scrlv_level1_chrg_cpo  varchar (1) 
,person_email_chrg_cpo  varchar (50) 
,custinst_remark  varchar (4000) 
,custinst_chrg_id_cpo  numeric (38,0)
,custinst_asstwh_id  numeric (38,0)
,custinst_cust_id  numeric (38,0)
,custinst_itm_id  numeric (38,0)
,custinst_id  numeric (38,0)
,custinst_updated_at   timestamp(6) 
,custinst_created_at   timestamp(6) 
,id  numeric (38,0)
,custinst_custrcvplc_id  numeric (38,0)
,custinst_update_ip  varchar (40) 
,custinst_person_id_upd  numeric (38,0)
,person_sect_id_chrg_cpo  numeric (22,0)
,chrg_person_id_chrg_cpo  numeric (38,0)
,itm_unit_id  numeric (22,0)
,person_sect_id_chrg_cust  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,bill_loca_id_bill  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,cust_chrg_id_cust  numeric (38,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,cust_loca_id_cust  numeric (38,0)
,cust_bill_id  numeric (38,0)
,bill_chrg_id_bill  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
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
 CREATE INDEX sio_r_custinsts_uk1 
  ON sio.sio_r_custinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custinsts_seq ;
 create sequence sio.sio_r_custinsts_seq ;
  drop view if  exists r_custs cascade ; 
 create or replace view r_custs as select  
cust.bills_id   cust_bill_id,
cust.autocreate_custact  cust_autocreate_custact,
cust.id id,
cust.id  cust_id,
cust.locas_id_cust   cust_loca_id_cust,
cust.updated_at  cust_updated_at,
cust.contract_price  cust_contract_price,
cust.rule_price  cust_rule_price,
cust.personname  cust_personname,
cust.chrgs_id_cust   cust_chrg_id_cust,
cust.amtround  cust_amtround,
cust.amtdecimal  cust_amtdecimal,
cust.created_at  cust_created_at,
cust.remark  cust_remark,
cust.custtype  cust_custtype,
cust.expiredate  cust_expiredate,
cust.persons_id_upd   cust_person_id_upd,
cust.update_ip  cust_update_ip,
cust.contents  cust_contents,
  bill.loca_name_bill  loca_name_bill ,
  bill.loca_code_bill  loca_code_bill ,
  bill.bill_chrg_id_bill  bill_chrg_id_bill ,
  bill.bill_crr_id_bill  bill_crr_id_bill ,
  bill.bill_loca_id_bill  bill_loca_id_bill ,
  bill.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  bill.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  bill.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  bill.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  bill.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  bill.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  bill.person_name_chrg_bill  person_name_chrg_bill ,
  bill.person_code_chrg_bill  person_code_chrg_bill ,
  bill.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  bill.crr_name_bill  crr_name_bill ,
  bill.crr_code_bill  crr_code_bill ,
  loca_cust.loca_code  loca_code_cust ,
  loca_cust.loca_name  loca_name_cust ,
  chrg_cust.person_sect_id_chrg  person_sect_id_chrg_cust ,
  chrg_cust.scrlv_code_chrg  scrlv_code_chrg_cust ,
  chrg_cust.person_name_chrg  person_name_chrg_cust ,
  chrg_cust.loca_name_sect_chrg  loca_name_sect_chrg_cust ,
  chrg_cust.loca_code_sect_chrg  loca_code_sect_chrg_cust ,
  chrg_cust.person_code_chrg  person_code_chrg_cust ,
  chrg_cust.usrgrp_code_chrg  usrgrp_code_chrg_cust ,
  chrg_cust.usrgrp_name_chrg  usrgrp_name_chrg_cust ,
  chrg_cust.chrg_person_id_chrg  chrg_person_id_chrg_cust 
 from custs   cust,
  r_bills  bill ,  r_locas  loca_cust ,  r_chrgs  chrg_cust ,  r_persons  person_upd 
  where       cust.bills_id = bill.id      and cust.locas_id_cust = loca_cust.id      and cust.chrgs_id_cust = chrg_cust.id      and cust.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custs;
 CREATE TABLE sio.sio_r_custs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,loca_name_bill  varchar (100) 
,person_code_chrg_bill  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,loca_code_bill  varchar (50) 
,usrgrp_name_chrg_bill  varchar (100) 
,loca_name_sect_chrg_bill  varchar (100) 
,loca_code_sect_chrg_bill  varchar (50) 
,person_code_chrg_cust  varchar (50) 
,loca_name_sect_chrg_cust  varchar (100) 
,loca_code_sect_chrg_cust  varchar (50) 
,usrgrp_name_chrg_cust  varchar (100) 
,person_name_chrg_cust  varchar (100) 
,scrlv_code_chrg_cust  varchar (50) 
,loca_name_cust  varchar (100) 
,usrgrp_code_chrg_cust  varchar (50) 
,loca_code_cust  varchar (50) 
,crr_code_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,usrgrp_code_chrg_bill  varchar (50) 
,cust_custtype  varchar (1) 
,cust_autocreate_custact  varchar (1) 
,cust_contract_price  varchar (1) 
,cust_rule_price  varchar (1) 
,cust_personname  varchar (30) 
,cust_amtround  varchar (2) 
,cust_amtdecimal  numeric (38,0)
,cust_expiredate   date 
,person_email_chrg_cust  varchar (50) 
,loca_country_cust  varchar (20) 
,loca_abbr_cust  varchar (50) 
,loca_prfct_cust  varchar (20) 
,loca_tel_cust  varchar (20) 
,loca_mail_cust  varchar (20) 
,loca_addr1_cust  varchar (50) 
,loca_zip_cust  varchar (10) 
,loca_fax_cust  varchar (20) 
,loca_addr2_cust  varchar (50) 
,bill_contents  varchar (4000) 
,scrlv_level1_chrg_cust  varchar (1) 
,loca_abbr_bill  varchar (50) 
,bill_personname  varchar (30) 
,loca_tel_bill  varchar (20) 
,cust_remark  varchar (4000) 
,cust_contents  varchar (4000) 
,cust_loca_id_cust  numeric (38,0)
,cust_id  numeric (38,0)
,id  numeric (38,0)
,cust_bill_id  numeric (38,0)
,cust_created_at   timestamp(6) 
,cust_update_ip  varchar (40) 
,cust_chrg_id_cust  numeric (38,0)
,cust_person_id_upd  numeric (38,0)
,cust_updated_at   timestamp(6) 
,chrg_person_id_chrg_cust  numeric (38,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,bill_loca_id_bill  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,bill_chrg_id_bill  numeric (22,0)
,person_sect_id_chrg_cust  numeric (22,0)
,person_sect_id_chrg_bill  numeric (22,0)
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
 CREATE INDEX sio_r_custs_uk1 
  ON sio.sio_r_custs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custs_seq ;
 create sequence sio.sio_r_custs_seq ;
  drop view if  exists r_custords cascade ; 
 create or replace view r_custords as select  
custord.gno  custord_gno,
custord.itm_code_client  custord_itm_code_client,
custord.contents  custord_contents,
custord.locas_id_fm   custord_loca_id_fm,
custord.custrcvplcs_id   custord_custrcvplc_id,
custord.id id,
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
custord.cno  custord_cno,
custord.opeitms_id   custord_opeitm_id,
custord.cno_custsch  custord_cno_custsch,
custord.gno_custsch  custord_gno_custsch,
custord.contract_price  custord_contract_price,
custord.starttime  custord_starttime,
custord.chrgs_id_cpo   custord_chrg_id_cpo,
custord.sno  custord_sno,
custord.prjnos_id   custord_prjno_id,
  loca_fm.loca_code  loca_code_fm ,
  loca_fm.loca_name  loca_name_fm ,
  custrcvplc.custrcvplc_loca_id_custrcvplc  custrcvplc_loca_id_custrcvplc ,
  custrcvplc.loca_code_custrcvplc  loca_code_custrcvplc ,
  custrcvplc.loca_name_custrcvplc  loca_name_custrcvplc ,
  cust.cust_bill_id  cust_bill_id ,
  cust.cust_loca_id_cust  cust_loca_id_cust ,
  cust.cust_chrg_id_cust  cust_chrg_id_cust ,
  cust.loca_name_bill  loca_name_bill ,
  cust.loca_code_bill  loca_code_bill ,
  cust.bill_chrg_id_bill  bill_chrg_id_bill ,
  cust.bill_crr_id_bill  bill_crr_id_bill ,
  cust.bill_loca_id_bill  bill_loca_id_bill ,
  cust.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  cust.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  cust.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  cust.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  cust.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  cust.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  cust.person_name_chrg_bill  person_name_chrg_bill ,
  cust.person_code_chrg_bill  person_code_chrg_bill ,
  cust.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  cust.crr_name_bill  crr_name_bill ,
  cust.crr_code_bill  crr_code_bill ,
  cust.loca_code_cust  loca_code_cust ,
  cust.loca_name_cust  loca_name_cust ,
  cust.person_sect_id_chrg_cust  person_sect_id_chrg_cust ,
  cust.scrlv_code_chrg_cust  scrlv_code_chrg_cust ,
  cust.person_name_chrg_cust  person_name_chrg_cust ,
  cust.loca_name_sect_chrg_cust  loca_name_sect_chrg_cust ,
  cust.loca_code_sect_chrg_cust  loca_code_sect_chrg_cust ,
  cust.person_code_chrg_cust  person_code_chrg_cust ,
  cust.usrgrp_code_chrg_cust  usrgrp_code_chrg_cust ,
  cust.usrgrp_name_chrg_cust  usrgrp_name_chrg_cust ,
  cust.chrg_person_id_chrg_cust  chrg_person_id_chrg_cust ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  chrg_cpo.person_sect_id_chrg  person_sect_id_chrg_cpo ,
  chrg_cpo.scrlv_code_chrg  scrlv_code_chrg_cpo ,
  chrg_cpo.person_name_chrg  person_name_chrg_cpo ,
  chrg_cpo.loca_name_sect_chrg  loca_name_sect_chrg_cpo ,
  chrg_cpo.loca_code_sect_chrg  loca_code_sect_chrg_cpo ,
  chrg_cpo.person_code_chrg  person_code_chrg_cpo ,
  chrg_cpo.usrgrp_code_chrg  usrgrp_code_chrg_cpo ,
  chrg_cpo.usrgrp_name_chrg  usrgrp_name_chrg_cpo ,
  chrg_cpo.chrg_person_id_chrg  chrg_person_id_chrg_cpo ,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code  prjno_code 
 from custords   custord,
  r_locas  loca_fm ,  r_custrcvplcs  custrcvplc ,  r_custs  cust ,  r_persons  person_upd ,  r_opeitms  opeitm ,  r_chrgs  chrg_cpo ,  r_prjnos  prjno 
  where       custord.locas_id_fm = loca_fm.id      and custord.custrcvplcs_id = custrcvplc.id      and custord.custs_id = cust.id      and custord.persons_id_upd = person_upd.id      and custord.opeitms_id = opeitm.id      and custord.chrgs_id_cpo = chrg_cpo.id      and custord.prjnos_id = prjno.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custords;
 CREATE TABLE sio.sio_r_custords (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custords_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,custord_cno  varchar (40) 
,custord_sno  varchar (40) 
,custord_gno  varchar (40) 
,person_name_chrg_cpo  varchar (100) 
,scrlv_code_chrg_cpo  varchar (50) 
,loca_name_bill  varchar (100) 
,loca_code_bill  varchar (50) 
,loca_code_cust  varchar (50) 
,crr_code_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,usrgrp_code_chrg_bill  varchar (50) 
,person_code_chrg_bill  varchar (50) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,usrgrp_name_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,usrgrp_name_chrg_cust  varchar (100) 
,usrgrp_name_chrg_cpo  varchar (100) 
,loca_name_cust  varchar (100) 
,loca_name_sect_chrg_cpo  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,usrgrp_code_chrg_cpo  varchar (50) 
,person_code_chrg_cpo  varchar (50) 
,loca_code_sect_chrg_cpo  varchar (50) 
,loca_name_fm  varchar (100) 
,loca_name_sect_chrg_cust  varchar (100) 
,loca_code_custrcvplc  varchar (50) 
,loca_name_custrcvplc  varchar (100) 
,person_name_chrg_cust  varchar (100) 
,scrlv_code_chrg_cust  varchar (50) 
,usrgrp_code_chrg_cust  varchar (50) 
,person_code_chrg_cust  varchar (50) 
,loca_code_sect_chrg_cust  varchar (50) 
,loca_code_fm  varchar (50) 
,custord_expiredate   date 
,custord_toduedate   timestamp(6) 
,custord_cno_custsch  varchar (50) 
,custord_gno_custsch  varchar (50) 
,custord_contract_price  varchar (1) 
,custord_starttime   timestamp(6) 
,custord_isudate   timestamp(6) 
,custord_amt  numeric (18,4)
,custord_duedate   timestamp(6) 
,custord_qty  numeric (22,6)
,custord_price  numeric (38,4)
,custord_itm_code_client  varchar (50) 
,opeitm_prjalloc_flg  numeric (38,0)
,loca_country_fm  varchar (20) 
,loca_abbr_fm  varchar (50) 
,loca_prfct_fm  varchar (20) 
,loca_tel_fm  varchar (20) 
,loca_mail_fm  varchar (20) 
,loca_addr1_fm  varchar (50) 
,loca_zip_fm  varchar (10) 
,loca_fax_fm  varchar (20) 
,loca_addr2_fm  varchar (50) 
,custrcvplc_stktaking_proc  varchar (1) 
,custrcvplc_contents  varchar (4000) 
,cust_autocreate_custact  varchar (1) 
,cust_contract_price  varchar (1) 
,cust_rule_price  varchar (1) 
,cust_personname  varchar (30) 
,cust_amtround  varchar (2) 
,cust_amtdecimal  numeric (38,0)
,cust_custtype  varchar (1) 
,cust_contents  varchar (4000) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autoinst_p  numeric (3,0)
,opeitm_lotno_proc  varchar (3) 
,opeitm_autoact_p  numeric (3,0)
,opeitm_autoord_p  numeric (3,0)
,opeitm_duration  numeric (38,2)
,opeitm_units_lttime  varchar (4) 
,opeitm_minqty  numeric (22,6)
,opeitm_operation  varchar (40) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_safestkqty  numeric (22,0)
,opeitm_packqty  numeric (18,2)
,opeitm_shuffle_flg  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_chkinst_proc  varchar (1) 
,opeitm_esttosch  numeric (38,0)
,opeitm_stktaking_proc  varchar (1) 
,opeitm_mold  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_packno_proc  varchar (1) 
,opeitm_processseq  numeric (38,0)
,opeitm_priority  numeric (38,0)
,opeitm_contents  varchar (4000) 
,opeitm_acceptance_proc  varchar (1) 
,opeitm_chkord_proc  varchar (3) 
,opeitm_maxqty  numeric (22,6)
,opeitm_rule_price  varchar (1) 
,opeitm_prdpurshp  varchar (5) 
,itm_std  varchar (50) 
,scrlv_level1_chrg_cpo  varchar (1) 
,person_email_chrg_cpo  varchar (50) 
,custord_contents  varchar (4000) 
,custord_remark  varchar (4000) 
,custord_prjno_id  numeric (38,0)
,custord_custrcvplc_id  numeric (38,0)
,custord_chrg_id_cpo  numeric (38,0)
,custord_person_id_upd  numeric (38,0)
,custord_opeitm_id  numeric (38,0)
,custord_created_at   timestamp(6) 
,custord_loca_id_fm  numeric (38,0)
,custord_cust_id  numeric (38,0)
,custord_updated_at   timestamp(6) 
,custord_id  numeric (38,0)
,custord_update_ip  varchar (40) 
,id  numeric (38,0)
,chrg_person_id_chrg_cpo  numeric (38,0)
,person_sect_id_chrg_cpo  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,bill_loca_id_bill  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,bill_chrg_id_bill  numeric (22,0)
,cust_chrg_id_cust  numeric (38,0)
,person_sect_id_chrg_cust  numeric (22,0)
,cust_loca_id_cust  numeric (38,0)
,cust_bill_id  numeric (38,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,opeitm_boxe_id  numeric (38,0)
,opeitm_shelfno_id  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
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
 CREATE INDEX sio_r_custords_uk1 
  ON sio.sio_r_custords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custords_seq ;
 create sequence sio.sio_r_custords_seq ;
  drop view if  exists r_custwhs cascade ; 
 create or replace view r_custwhs as select  
custwh.qty_sch  custwh_qty_sch,
custwh.duedate  custwh_duedate,
custwh.remark  custwh_remark,
custwh.created_at  custwh_created_at,
custwh.update_ip  custwh_update_ip,
custwh.expiredate  custwh_expiredate,
custwh.updated_at  custwh_updated_at,
custwh.qty  custwh_qty,
custwh.id id,
custwh.id  custwh_id,
custwh.persons_id_upd   custwh_person_id_upd,
custwh.inoutflg  custwh_inoutflg,
custwh.lotno  custwh_lotno,
custwh.qty_stk  custwh_qty_stk,
custwh.packno  custwh_packno,
custwh.custrcvplcs_id   custwh_custrcvplc_id,
  custrcvplc.custrcvplc_loca_id_custrcvplc  custrcvplc_loca_id_custrcvplc ,
  custrcvplc.loca_code_custrcvplc  loca_code_custrcvplc ,
  custrcvplc.loca_name_custrcvplc  loca_name_custrcvplc 
 from custwhs   custwh,
  r_persons  person_upd ,  r_custrcvplcs  custrcvplc 
  where       custwh.persons_id_upd = person_upd.id      and custwh.custrcvplcs_id = custrcvplc.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custwhs;
 CREATE TABLE sio.sio_r_custwhs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custwhs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,loca_name_custrcvplc  varchar (100) 
,loca_code_custrcvplc  varchar (50) 
,custwh_qty_sch  numeric (22,6)
,custwh_duedate   timestamp(6) 
,custwh_expiredate   date 
,custwh_qty  numeric (22,6)
,custwh_inoutflg  varchar (20) 
,custwh_lotno  varchar (50) 
,custwh_qty_stk  numeric (22,6)
,custwh_packno  varchar (10) 
,custrcvplc_contents  varchar (4000) 
,custrcvplc_stktaking_proc  varchar (1) 
,custwh_remark  varchar (4000) 
,custwh_custrcvplc_id  numeric (38,0)
,custwh_updated_at   timestamp(6) 
,custwh_id  numeric (38,0)
,custwh_created_at   timestamp(6) 
,custwh_update_ip  varchar (40) 
,custwh_person_id_upd  numeric (38,0)
,id  numeric (38,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
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
 CREATE INDEX sio_r_custwhs_uk1 
  ON sio.sio_r_custwhs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custwhs_seq ;
 create sequence sio.sio_r_custwhs_seq ;
 drop sequence  if exists  custdlvs_seq ;
 create sequence custdlvs_seq ;
  drop view if  exists r_custdlvs cascade ; 
 create or replace view r_custdlvs as select  
custdlv.custs_id   custdlv_cust_id,
custdlv.itms_id   custdlv_itm_id,
custdlv.itm_code_client  custdlv_itm_code_client,
custdlv.cno  custdlv_cno,
custdlv.custrcvplcs_id   custdlv_custrcvplc_id,
custdlv.id id,
custdlv.id  custdlv_id,
custdlv.asstwhs_id   custdlv_asstwh_id,
custdlv.gno  custdlv_gno,
custdlv.contract_price  custdlv_contract_price,
custdlv.starttime  custdlv_starttime,
custdlv.chrgs_id_cpo   custdlv_chrg_id_cpo,
custdlv.qty  custdlv_qty,
custdlv.price  custdlv_price,
custdlv.expiredate  custdlv_expiredate,
custdlv.duedate  custdlv_duedate,
custdlv.amt  custdlv_amt,
custdlv.isudate  custdlv_isudate,
custdlv.sno  custdlv_sno,
custdlv.remark  custdlv_remark,
custdlv.persons_id_upd   custdlv_person_id_upd,
custdlv.update_ip  custdlv_update_ip,
custdlv.created_at  custdlv_created_at,
custdlv.updated_at  custdlv_updated_at,
  cust.cust_bill_id  cust_bill_id ,
  cust.cust_loca_id_cust  cust_loca_id_cust ,
  cust.cust_chrg_id_cust  cust_chrg_id_cust ,
  cust.loca_name_bill  loca_name_bill ,
  cust.loca_code_bill  loca_code_bill ,
  cust.bill_chrg_id_bill  bill_chrg_id_bill ,
  cust.bill_crr_id_bill  bill_crr_id_bill ,
  cust.bill_loca_id_bill  bill_loca_id_bill ,
  cust.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  cust.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  cust.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  cust.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  cust.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  cust.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  cust.person_name_chrg_bill  person_name_chrg_bill ,
  cust.person_code_chrg_bill  person_code_chrg_bill ,
  cust.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  cust.crr_name_bill  crr_name_bill ,
  cust.crr_code_bill  crr_code_bill ,
  cust.loca_code_cust  loca_code_cust ,
  cust.loca_name_cust  loca_name_cust ,
  cust.person_sect_id_chrg_cust  person_sect_id_chrg_cust ,
  cust.scrlv_code_chrg_cust  scrlv_code_chrg_cust ,
  cust.person_name_chrg_cust  person_name_chrg_cust ,
  cust.loca_name_sect_chrg_cust  loca_name_sect_chrg_cust ,
  cust.loca_code_sect_chrg_cust  loca_code_sect_chrg_cust ,
  cust.person_code_chrg_cust  person_code_chrg_cust ,
  cust.usrgrp_code_chrg_cust  usrgrp_code_chrg_cust ,
  cust.usrgrp_name_chrg_cust  usrgrp_name_chrg_cust ,
  cust.chrg_person_id_chrg_cust  chrg_person_id_chrg_cust ,
  itm.itm_classlist_id  itm_classlist_id ,
  itm.itm_unit_id  itm_unit_id ,
  itm.classlist_name  classlist_name ,
  itm.classlist_code  classlist_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name ,
  custrcvplc.custrcvplc_loca_id_custrcvplc  custrcvplc_loca_id_custrcvplc ,
  custrcvplc.loca_code_custrcvplc  loca_code_custrcvplc ,
  custrcvplc.loca_name_custrcvplc  loca_name_custrcvplc ,
  chrg_cpo.person_sect_id_chrg  person_sect_id_chrg_cpo ,
  chrg_cpo.scrlv_code_chrg  scrlv_code_chrg_cpo ,
  chrg_cpo.person_name_chrg  person_name_chrg_cpo ,
  chrg_cpo.loca_name_sect_chrg  loca_name_sect_chrg_cpo ,
  chrg_cpo.loca_code_sect_chrg  loca_code_sect_chrg_cpo ,
  chrg_cpo.person_code_chrg  person_code_chrg_cpo ,
  chrg_cpo.usrgrp_code_chrg  usrgrp_code_chrg_cpo ,
  chrg_cpo.usrgrp_name_chrg  usrgrp_name_chrg_cpo ,
  chrg_cpo.chrg_person_id_chrg  chrg_person_id_chrg_cpo 
 from custdlvs   custdlv,
  r_custs  cust ,  r_itms  itm ,  r_custrcvplcs  custrcvplc ,  r_asstwhs  asstwh ,  r_chrgs  chrg_cpo ,  r_persons  person_upd 
  where       custdlv.custs_id = cust.id      and custdlv.itms_id = itm.id      and custdlv.custrcvplcs_id = custrcvplc.id      and custdlv.asstwhs_id = asstwh.id      and custdlv.chrgs_id_cpo = chrg_cpo.id      and custdlv.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custdlvs;
 CREATE TABLE sio.sio_r_custdlvs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custdlvs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,custdlv_cno  varchar (40) 
,custdlv_gno  varchar (40) 
,custdlv_sno  varchar (40) 
,crr_code_bill  varchar (50) 
,loca_code_cust  varchar (50) 
,loca_name_cust  varchar (100) 
,loca_name_sect_chrg_cust  varchar (100) 
,scrlv_code_chrg_cust  varchar (50) 
,person_name_chrg_cust  varchar (100) 
,person_name_chrg_cpo  varchar (100) 
,person_name_chrg_bill  varchar (100) 
,usrgrp_code_chrg_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,usrgrp_name_chrg_cust  varchar (100) 
,usrgrp_code_chrg_cust  varchar (50) 
,person_code_chrg_cust  varchar (50) 
,loca_code_sect_chrg_cust  varchar (50) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,usrgrp_name_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,person_code_chrg_bill  varchar (50) 
,scrlv_code_chrg_cpo  varchar (50) 
,loca_name_custrcvplc  varchar (100) 
,loca_code_custrcvplc  varchar (50) 
,itm_name  varchar (100) 
,itm_code  varchar (50) 
,unit_code  varchar (50) 
,usrgrp_name_chrg_cpo  varchar (100) 
,unit_name  varchar (100) 
,usrgrp_code_chrg_cpo  varchar (50) 
,classlist_code  varchar (50) 
,person_code_chrg_cpo  varchar (50) 
,loca_code_sect_chrg_cpo  varchar (50) 
,loca_name_sect_chrg_cpo  varchar (100) 
,loca_name_bill  varchar (100) 
,loca_code_bill  varchar (50) 
,classlist_name  varchar (100) 
,custdlv_price  numeric (38,4)
,custdlv_expiredate   date 
,custdlv_duedate   timestamp(6) 
,custdlv_amt  numeric (18,4)
,custdlv_isudate   timestamp(6) 
,custdlv_qty  numeric (22,6)
,custdlv_starttime   timestamp(6) 
,custdlv_contract_price  varchar (1) 
,custdlv_itm_code_client  varchar (50) 
,itm_model  varchar (50) 
,cust_autocreate_custact  varchar (1) 
,cust_contract_price  varchar (1) 
,cust_rule_price  varchar (1) 
,cust_personname  varchar (30) 
,cust_amtround  varchar (2) 
,cust_amtdecimal  numeric (38,0)
,cust_custtype  varchar (1) 
,cust_contents  varchar (4000) 
,itm_weight  numeric (22,0)
,unit_contents  varchar (4000) 
,itm_length  numeric (22,0)
,itm_design  varchar (50) 
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,itm_material  varchar (50) 
,itm_datascale  numeric (22,0)
,custrcvplc_stktaking_proc  varchar (1) 
,custrcvplc_contents  varchar (4000) 
,scrlv_level1_chrg_cpo  varchar (1) 
,person_email_chrg_cpo  varchar (50) 
,custdlv_remark  varchar (4000) 
,custdlv_chrg_id_cpo  numeric (38,0)
,custdlv_asstwh_id  numeric (38,0)
,custdlv_cust_id  numeric (38,0)
,custdlv_itm_id  numeric (38,0)
,custdlv_id  numeric (38,0)
,custdlv_updated_at   timestamp(6) 
,custdlv_created_at   timestamp(6) 
,id  numeric (38,0)
,custdlv_custrcvplc_id  numeric (38,0)
,custdlv_update_ip  varchar (40) 
,custdlv_person_id_upd  numeric (38,0)
,person_sect_id_chrg_cpo  numeric (22,0)
,chrg_person_id_chrg_cpo  numeric (38,0)
,itm_unit_id  numeric (22,0)
,person_sect_id_chrg_cust  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,bill_loca_id_bill  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,cust_chrg_id_cust  numeric (38,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,cust_loca_id_cust  numeric (38,0)
,cust_bill_id  numeric (38,0)
,bill_chrg_id_bill  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
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
 CREATE INDEX sio_r_custdlvs_uk1 
  ON sio.sio_r_custdlvs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custdlvs_seq ;
 create sequence sio.sio_r_custdlvs_seq ;
 ALTER TABLE custacts ADD CONSTRAINT custact_custs_id FOREIGN KEY (custs_id)
																		 REFERENCES custs (id);
 ALTER TABLE custacts ADD CONSTRAINT custact_asstwhs_id FOREIGN KEY (asstwhs_id)
																		 REFERENCES asstwhs (id);
 ALTER TABLE custacts ADD CONSTRAINT custact_custrcvplcs_id FOREIGN KEY (custrcvplcs_id)
																		 REFERENCES custrcvplcs (id);
 ALTER TABLE custacts ADD CONSTRAINT custact_chrgs_id_cpo FOREIGN KEY (chrgs_id_cpo)
																		 REFERENCES chrgs (id);
 ALTER TABLE custacts ADD CONSTRAINT custact_itms_id FOREIGN KEY (itms_id)
																		 REFERENCES itms (id);
 ALTER TABLE custacts ADD CONSTRAINT custact_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 ALTER TABLE custinsts ADD CONSTRAINT custinst_custs_id FOREIGN KEY (custs_id)
																		 REFERENCES custs (id);
 ALTER TABLE custinsts ADD CONSTRAINT custinst_itms_id FOREIGN KEY (itms_id)
																		 REFERENCES itms (id);
 ALTER TABLE custinsts ADD CONSTRAINT custinst_custrcvplcs_id FOREIGN KEY (custrcvplcs_id)
																		 REFERENCES custrcvplcs (id);
 ALTER TABLE custinsts ADD CONSTRAINT custinst_asstwhs_id FOREIGN KEY (asstwhs_id)
																		 REFERENCES asstwhs (id);
 ALTER TABLE custinsts ADD CONSTRAINT custinst_chrgs_id_cpo FOREIGN KEY (chrgs_id_cpo)
																		 REFERENCES chrgs (id);
 ALTER TABLE custinsts ADD CONSTRAINT custinst_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 ALTER TABLE custdlvs ADD CONSTRAINT custdlv_custs_id FOREIGN KEY (custs_id)
																		 REFERENCES custs (id);
 ALTER TABLE custdlvs ADD CONSTRAINT custdlv_itms_id FOREIGN KEY (itms_id)
																		 REFERENCES itms (id);
 ALTER TABLE custdlvs ADD CONSTRAINT custdlv_custrcvplcs_id FOREIGN KEY (custrcvplcs_id)
																		 REFERENCES custrcvplcs (id);
 ALTER TABLE custdlvs ADD CONSTRAINT custdlv_asstwhs_id FOREIGN KEY (asstwhs_id)
																		 REFERENCES asstwhs (id);
 ALTER TABLE custdlvs ADD CONSTRAINT custdlv_chrgs_id_cpo FOREIGN KEY (chrgs_id_cpo)
																		 REFERENCES chrgs (id);
 ALTER TABLE custdlvs ADD CONSTRAINT custdlv_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
