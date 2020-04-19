﻿
 --- drop view r_prdschs cascade  
 create or replace view r_prdschs as select  
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
prdsch.chrgs_id   prdsch_chrg_id,
  shelfno_to.shelfno_code  shelfno_code_to ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  opeitm.shelfno_name  shelfno_name ,
  prjno.prjno_name  prjno_name ,
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
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  opeitm.loca_code  loca_code ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  opeitm.loca_name  loca_name ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  chrg.person_code_chrg  person_code_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.itm_unit_id  itm_unit_id ,
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
prdsch.opeitms_id   prdsch_opeitm_id,
  opeitm.opeitm_packqty  opeitm_packqty ,
prdsch.shelfnos_id_to   prdsch_shelfno_id_to,
prdsch.gno  prdsch_gno,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  opeitm.classlist_code  classlist_code ,
prdsch.qty_case  prdsch_qty_case,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  opeitm.classlist_name  classlist_name ,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_priority  opeitm_priority ,
prdsch.remark  prdsch_remark,
  prjno.prjno_code  prjno_code ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
prdsch.prjnos_id   prdsch_prjno_id,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox 
 from prdschs   prdsch,
  r_chrgs  chrg ,  r_persons  person_upd ,  r_opeitms  opeitm ,  r_shelfnos  shelfno_to ,  r_prjnos  prjno 
  where       prdsch.chrgs_id = chrg.id      and prdsch.persons_id_upd = person_upd.id      and prdsch.opeitms_id = opeitm.id      and prdsch.shelfnos_id_to = shelfno_to.id      and prdsch.prjnos_id = prjno.id     ;
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
,prdsch_qty  numeric (18,4)
,prdsch_duedate   timestamp(6) 
,prdsch_starttime   timestamp(6) 
,opeitm_processseq  numeric (3,0)
,opeitm_priority  numeric (3,0)
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,loca_code_shelfno_to  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,prdsch_gno  varchar (40) 
,prdsch_qty_case  numeric (38,0)
,prdsch_toduedate   timestamp(6) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,boxe_code  varchar (50) 
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
,scrlv_code_chrg  varchar (50) 
,classlist_name  varchar (100) 
,classlist_code  varchar (50) 
,boxe_name  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,prdsch_expiredate   date 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,opeitm_operation  varchar (20) 
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
,shelfno_contents_to  varchar (4000) 
,opeitm_acceptance_proc  varchar (1) 
,opeitm_chkinst  varchar (1) 
,boxe_boxtype  varchar (20) 
,opeitm_maxqty  numeric (22,0)
,opeitm_prjalloc_flg  numeric (22,0)
,prjno_code_chil  varchar (50) 
,prdsch_remark  varchar (4000) 
,prdsch_update_ip  varchar (40) 
,prdsch_prjno_id  numeric (38,0)
,prdsch_person_id_upd  numeric (38,0)
,prdsch_created_at   timestamp(6) 
,prdsch_updated_at   timestamp(6) 
,prdsch_id  numeric (38,0)
,id  numeric (38,0)
,prdsch_opeitm_id  numeric (38,0)
,prdsch_shelfno_id_to  numeric (38,0)
,prdsch_chrg_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,loca_zip  varchar (10) 
,chrg_person_id_chrg  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,loca_addr2  varchar (50) 
,loca_abbr  varchar (50) 
,boxe_unit_id_outbox  numeric (38,0)
,loca_addr1  varchar (50) 
,person_sect_id_chrg  numeric (22,0)
,loca_prfct  varchar (20) 
,opeitm_boxe_id  numeric (22,0)
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
