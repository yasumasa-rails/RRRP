
 --- drop view r_prdschs cascade  
 create or replace view r_prdschs as select  
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.opeitm_prdpurshp  opeitm_prdpurshp ,
  opeitm.opeitm_opt_fix_flg  opeitm_opt_fix_flg ,
prdsch.chrgs_id   prdsch_chrg_id,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.shelfno_name  shelfno_name ,
  prjno.prjno_name  prjno_name ,
  opeitm.opeitm_autocreate_ord  opeitm_autocreate_ord ,
  opeitm.opeitm_autoinst_p  opeitm_autoinst_p ,
prdsch.starttime  prdsch_starttime,
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
  opeitm.itm_code  itm_code ,
  opeitm.itm_name  itm_name ,
  opeitm.opeitm_autoact_p  opeitm_autoact_p ,
  opeitm.opeitm_autoord_p  opeitm_autoord_p ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  loca_to.loca_abbr  loca_abbr_to ,
  opeitm.loca_abbr  loca_abbr ,
  loca_to.loca_zip  loca_zip_to ,
  opeitm.loca_zip  loca_zip ,
  loca_to.loca_country  loca_country_to ,
  loca_to.loca_prfct  loca_prfct_to ,
  opeitm.loca_prfct  loca_prfct ,
  loca_to.loca_addr1  loca_addr1_to ,
  opeitm.loca_addr1  loca_addr1 ,
  loca_to.loca_addr2  loca_addr2_to ,
  opeitm.loca_addr2  loca_addr2 ,
  loca_to.loca_tel  loca_tel_to ,
  loca_to.loca_fax  loca_fax_to ,
  loca_to.loca_mail  loca_mail_to ,
  opeitm.opeitm_duration  opeitm_duration ,
  opeitm.opeitm_units_lttime  opeitm_units_lttime ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  loca_to.loca_code  loca_code_to ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  loca_to.loca_name  loca_name_to ,
  opeitm.loca_name  loca_name ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  opeitm.opeitm_minqty  opeitm_minqty ,
  chrg.person_code_chrg  person_code_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_email_chrg  person_email_chrg ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.itm_unit_id  itm_unit_id ,
  chrg.scrlv_level1_chrg  scrlv_level1_chrg ,
  opeitm.opeitm_operation  opeitm_operation ,
  opeitm.opeitm_opt_fixoterm  opeitm_opt_fixoterm ,
prdsch.duedate  prdsch_duedate,
prdsch.toduedate  prdsch_toduedate,
prdsch.qty  prdsch_qty,
prdsch.sno  prdsch_sno,
  opeitm.itm_classlist_id  itm_classlist_id ,
prdsch.expiredate  prdsch_expiredate,
prdsch.persons_id_upd   prdsch_person_id_upd,
prdsch.update_ip  prdsch_update_ip,
prdsch.created_at  prdsch_created_at,
prdsch.updated_at  prdsch_updated_at,
prdsch.id  prdsch_id,
prdsch.id id,
prdsch.isudate  prdsch_isudate,
  opeitm.opeitm_safestkqty  opeitm_safestkqty ,
prdsch.locas_id_to   prdsch_loca_id_to,
prdsch.processseq_pare  prdsch_processseq_pare,
prdsch.opeitms_id   prdsch_opeitm_id,
  opeitm.opeitm_packqty  opeitm_packqty ,
prdsch.gno  prdsch_gno,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.opeitm_shuffle_flg  opeitm_shuffle_flg ,
  opeitm.opeitm_chkord_prc  opeitm_chkord_prc ,
  opeitm.opeitm_chkord  opeitm_chkord ,
  opeitm.opeitm_autocreate_act  opeitm_autocreate_act ,
  opeitm.opeitm_shuffle_loca  opeitm_shuffle_loca ,
  opeitm.opeitm_esttosch  opeitm_esttosch ,
  opeitm.opeitm_stktaking_proc  opeitm_stktaking_proc ,
  opeitm.opeitm_rule_price  opeitm_rule_price ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  opeitm.classlist_code  classlist_code ,
  opeitm.opeitm_mold  opeitm_mold ,
  opeitm.opeitm_autocreate_inst  opeitm_autocreate_inst ,
prdsch.qty_case  prdsch_qty_case,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  opeitm.classlist_name  classlist_name ,
  opeitm.opeitm_packno_flg  opeitm_packno_flg ,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_priority  opeitm_priority ,
prdsch.remark  prdsch_remark,
  prjno.prjno_code  prjno_code ,
  opeitm.opeitm_contents  opeitm_contents ,
prdsch.prjnos_id   prdsch_prjno_id,
  opeitm.opeitm_acceptance_proc  opeitm_acceptance_proc ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.opeitm_chkinst  opeitm_chkinst ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  opeitm.boxe_boxtype  boxe_boxtype ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.opeitm_maxqty  opeitm_maxqty ,
  opeitm.opeitm_prjalloc_flg  opeitm_prjalloc_flg 
 from prdschs   prdsch,
  r_chrgs  chrg ,  r_persons  person_upd ,  r_locas  loca_to ,  r_opeitms  opeitm ,  r_prjnos  prjno 
  where       prdsch.chrgs_id = chrg.id      and prdsch.persons_id_upd = person_upd.id      and prdsch.locas_id_to = loca_to.id      and prdsch.opeitms_id = opeitm.id      and prdsch.prjnos_id = prjno.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdschs;
 CREATE TABLE sio.sio_r_prdschs (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_prdschs_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,prdsch_sno  varchar (40) 
,prdsch_isudate   timestamp(6) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,itm_std  varchar (50) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,loca_code_shelfno  varchar (50) 
,prdsch_qty  numeric (18,4)
,prdsch_duedate   timestamp(6) 
,prdsch_starttime   timestamp(6) 
,opeitm_processseq  numeric (3,0)
,opeitm_priority  numeric (3,0)
,loca_code_to  varchar (50) 
,loca_name_to  varchar (100) 
,prdsch_gno  varchar (40) 
,prdsch_qty_case  numeric (38,0)
,prdsch_toduedate   timestamp(6) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,loca_name_shelfno  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_code_box  varchar (50) 
,unit_code_case  varchar (50) 
,unit_code  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_outbox  varchar (100) 
,unit_name_box  varchar (100) 
,unit_name_case  varchar (100) 
,unit_name  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,shelfno_code  varchar (50) 
,boxe_code  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,classlist_name  varchar (100) 
,classlist_code  varchar (50) 
,boxe_name  varchar (100) 
,shelfno_name  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,prdsch_expiredate   date 
,prdsch_processseq_pare  numeric (38,0)
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_prdpurshp  varchar (20) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autoinst_p  numeric (3,0)
,opeitm_autoact_p  numeric (3,0)
,opeitm_autoord_p  numeric (3,0)
,opeitm_duration  numeric (38,2)
,opeitm_units_lttime  varchar (4) 
,opeitm_minqty  numeric (38,6)
,person_email_chrg  varchar (50) 
,scrlv_level1_chrg  varchar (1) 
,opeitm_operation  varchar (20) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_safestkqty  numeric (38,0)
,opeitm_packqty  numeric (38,0)
,opeitm_shuffle_flg  varchar (1) 
,opeitm_chkord_prc  numeric (3,0)
,opeitm_chkord  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_esttosch  numeric (22,0)
,opeitm_stktaking_proc  varchar (1) 
,opeitm_rule_price  varchar (1) 
,opeitm_mold  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_packno_flg  varchar (1) 
,opeitm_contents  varchar (4000) 
,opeitm_acceptance_proc  varchar (1) 
,opeitm_chkinst  varchar (1) 
,boxe_boxtype  varchar (20) 
,opeitm_maxqty  numeric (22,0)
,prjno_code_chil  varchar (50) 
,loca_country_to  varchar (20) 
,prdsch_remark  varchar (4000) 
,loca_abbr_to  varchar (50) 
,loca_prfct_to  varchar (20) 
,loca_tel_to  varchar (20) 
,loca_mail_to  varchar (20) 
,loca_addr1_to  varchar (50) 
,loca_zip_to  varchar (10) 
,loca_fax_to  varchar (20) 
,loca_addr2_to  varchar (50) 
,prdsch_person_id_upd  numeric (38,0)
,prdsch_prjno_id  numeric (38,0)
,prdsch_update_ip  varchar (40) 
,prdsch_created_at   timestamp(6) 
,prdsch_updated_at   timestamp(6) 
,prdsch_id  numeric (38,0)
,id  numeric (38,0)
,prdsch_chrg_id  numeric (38,0)
,prdsch_loca_id_to  numeric (38,0)
,prdsch_opeitm_id  numeric (38,0)
,loca_abbr  varchar (50) 
,chrg_person_id_chrg  numeric (38,0)
,loca_prfct  varchar (20) 
,opeitm_unit_id_case  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,boxe_unit_id_box  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,boxe_unit_id_outbox  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,itm_unit_id  numeric (22,0)
,loca_zip  varchar (10) 
,person_sect_id_chrg  numeric (22,0)
,loca_addr2  varchar (50) 
,itm_classlist_id  numeric (38,0)
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
 CREATE INDEX sio_r_prdschs_uk1 
  ON sio.sio_r_prdschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdschs_seq ;
 create sequence sio.sio_r_prdschs_seq ;
