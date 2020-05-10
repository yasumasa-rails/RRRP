
 --- drop view r_prdacts cascade  
 create or replace view r_prdacts as select  
prdact.opeitms_id   prdact_opeitm_id,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
prdact.prjnos_id   prdact_prjno_id,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
prdact.lotno  prdact_lotno,
prdact.chrgs_id   prdact_chrg_id,
  shelfno_to.shelfno_code  shelfno_code_to ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  opeitm.shelfno_name  shelfno_name ,
  prjno.prjno_name  prjno_name ,
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
prdact.shelfnos_id_to   prdact_shelfno_id_to,
  workplace.scrlv_code_chrg_workplace  scrlv_code_chrg_workplace ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  workplace.loca_code_sect_chrg_workplace  loca_code_sect_chrg_workplace ,
  workplace.loca_code_workplace  loca_code_workplace ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  opeitm.loca_code  loca_code ,
  workplace.loca_name_sect_chrg_workplace  loca_name_sect_chrg_workplace ,
  workplace.loca_name_workplace  loca_name_workplace ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  opeitm.loca_name  loca_name ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  workplace.person_code_chrg_workplace  person_code_chrg_workplace ,
  chrg.person_code_chrg  person_code_chrg ,
  workplace.person_name_chrg_workplace  person_name_chrg_workplace ,
  chrg.person_name_chrg  person_name_chrg ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  workplace.workplace_loca_id_workplace  workplace_loca_id_workplace ,
  workplace.workplace_chrg_id_workplace  workplace_chrg_id_workplace ,
prdact.cno_prdinst  prdact_cno_prdinst,
prdact.cno_prdord  prdact_cno_prdord,
  workplace.usrgrp_name_chrg_workplace  usrgrp_name_chrg_workplace ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
prdact.qty_stk  prdact_qty_stk,
prdact.sno_prdinst  prdact_sno_prdinst,
prdact.sno_prdord  prdact_sno_prdord,
  opeitm.classlist_code  classlist_code ,
prdact.id  prdact_id,
prdact.id id,
prdact.contents  prdact_contents,
prdact.workplaces_id   prdact_workplace_id,
  workplace.person_sect_id_chrg_workplace  person_sect_id_chrg_workplace ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  workplace.usrgrp_code_chrg_workplace  usrgrp_code_chrg_workplace ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  opeitm.classlist_name  classlist_name ,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_code  prjno_code ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
prdact.isudate  prdact_isudate,
prdact.cmpldate  prdact_cmpldate,
prdact.qty_case  prdact_qty_case,
prdact.sno  prdact_sno,
prdact.remark  prdact_remark,
prdact.expiredate  prdact_expiredate,
prdact.persons_id_upd   prdact_person_id_upd,
prdact.update_ip  prdact_update_ip,
prdact.created_at  prdact_created_at,
prdact.updated_at  prdact_updated_at,
prdact.cno  prdact_cno,
prdact.gno  prdact_gno,
  workplace.chrg_person_id_chrg_workplace  chrg_person_id_chrg_workplace ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox 
 from prdacts   prdact,
  r_opeitms  opeitm ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_shelfnos  shelfno_to ,  r_workplaces  workplace ,  r_persons  person_upd 
  where       prdact.opeitms_id = opeitm.id      and prdact.prjnos_id = prjno.id      and prdact.chrgs_id = chrg.id      and prdact.shelfnos_id_to = shelfno_to.id      and prdact.workplaces_id = workplace.id      and prdact.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdacts;
 CREATE TABLE sio.sio_r_prdacts (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_prdacts_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,prdact_cno  varchar (40) 
,prdact_sno  varchar (40) 
,prdact_gno  varchar (40) 
,person_name_chrg  varchar (100) 
,boxe_name  varchar (100) 
,shelfno_name_to  varchar (100) 
,shelfno_name  varchar (100) 
,prjno_name  varchar (100) 
,boxe_code  varchar (50) 
,person_code_chrg  varchar (50) 
,person_name_chrg_workplace  varchar (100) 
,loca_code  varchar (50) 
,loca_name_sect_chrg_workplace  varchar (100) 
,loca_name_workplace  varchar (100) 
,loca_name_shelfno_to  varchar (100) 
,loca_name_shelfno  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,loca_name  varchar (100) 
,usrgrp_code_chrg_workplace  varchar (50) 
,classlist_code  varchar (50) 
,person_code_chrg_workplace  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_code_box  varchar (50) 
,unit_code_case  varchar (50) 
,usrgrp_name_chrg_workplace  varchar (100) 
,unit_code  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_outbox  varchar (100) 
,unit_name_box  varchar (100) 
,unit_name_case  varchar (100) 
,unit_name  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,scrlv_code_chrg_workplace  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,prjno_code  varchar (50) 
,prjno_code_chil  varchar (50) 
,classlist_name  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,shelfno_code_to  varchar (50) 
,shelfno_code  varchar (50) 
,loca_code_sect_chrg_workplace  varchar (50) 
,loca_code_workplace  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,loca_code_shelfno  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,prdact_qty_stk  numeric (22,6)
,prdact_expiredate   date 
,prdact_cmpldate   timestamp(6) 
,prdact_isudate   timestamp(6) 
,prdact_lotno  varchar (50) 
,prdact_cno_prdinst  varchar (50) 
,prdact_sno_prdord  varchar (50) 
,prdact_cno_prdord  varchar (50) 
,prdact_qty_case  numeric (38,0)
,prdact_sno_prdinst  varchar (50) 
,opeitm_rule_price  varchar (1) 
,opeitm_prdpurshp  varchar (20) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autoinst_p  numeric (3,0)
,itm_std  varchar (50) 
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
,opeitm_autocreate_act  varchar (1) 
,workplace_contents  varchar (4000) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_chkord_prc  numeric (3,0)
,opeitm_chkord  varchar (1) 
,opeitm_esttosch  numeric (22,0)
,opeitm_stktaking_proc  varchar (1) 
,opeitm_mold  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_packno_flg  varchar (1) 
,opeitm_processseq  numeric (3,0)
,opeitm_priority  numeric (3,0)
,opeitm_contents  varchar (4000) 
,shelfno_contents_to  varchar (4000) 
,opeitm_acceptance_proc  varchar (1) 
,opeitm_chkinst  varchar (1) 
,boxe_boxtype  varchar (20) 
,opeitm_maxqty  numeric (22,0)
,opeitm_prjalloc_flg  numeric (22,0)
,prdact_contents  varchar (4000) 
,prdact_remark  varchar (4000) 
,prdact_workplace_id  numeric (22,0)
,prdact_updated_at   timestamp(6) 
,prdact_prjno_id  numeric (38,0)
,prdact_shelfno_id_to  numeric (38,0)
,prdact_chrg_id  numeric (38,0)
,prdact_person_id_upd  numeric (38,0)
,prdact_update_ip  varchar (40) 
,prdact_opeitm_id  numeric (38,0)
,prdact_created_at   timestamp(6) 
,prdact_id  numeric (38,0)
,id  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,loca_zip  varchar (10) 
,loca_abbr  varchar (50) 
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,person_sect_id_chrg_workplace  numeric (22,0)
,workplace_chrg_id_workplace  numeric (22,0)
,workplace_loca_id_workplace  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,loca_addr2  varchar (50) 
,loca_addr1  varchar (50) 
,boxe_unit_id_box  numeric (38,0)
,loca_prfct  varchar (20) 
,opeitm_unit_id_case  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,loca_country_shelfno  varchar (20) 
,chrg_person_id_chrg_workplace  numeric (38,0)
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
 CREATE INDEX sio_r_prdacts_uk1 
  ON sio.sio_r_prdacts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdacts_seq ;
 create sequence sio.sio_r_prdacts_seq ;
 --- drop view r_prdinsts cascade  
 create or replace view r_prdinsts as select  
prdinst.chrgs_id   prdinst_chrg_id,
prdinst.opeitms_id   prdinst_opeitm_id,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
prdinst.prjnos_id   prdinst_prjno_id,
  shelfno_to.shelfno_code  shelfno_code_to ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  opeitm.shelfno_name  shelfno_name ,
  prjno.prjno_name  prjno_name ,
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
  workplace.scrlv_code_chrg_workplace  scrlv_code_chrg_workplace ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  chrg.loca_id_sect  loca_id_sect ,
  workplace.loca_code_sect_chrg_workplace  loca_code_sect_chrg_workplace ,
  workplace.loca_code_workplace  loca_code_workplace ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_code_sect  loca_code_sect ,
  loca_to.loca_code  loca_code_to ,
  opeitm.loca_code  loca_code ,
  workplace.loca_name_sect_chrg_workplace  loca_name_sect_chrg_workplace ,
  workplace.loca_name_workplace  loca_name_workplace ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  chrg.loca_name_sect  loca_name_sect ,
  loca_to.loca_name  loca_name_to ,
  opeitm.loca_name  loca_name ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  workplace.person_code_chrg_workplace  person_code_chrg_workplace ,
  chrg.person_code_chrg  person_code_chrg ,
  workplace.person_name_chrg_workplace  person_name_chrg_workplace ,
  chrg.person_name_chrg  person_name_chrg ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  opeitm.opeitm_packqty  opeitm_packqty ,
prdinst.shelfnos_id_to   prdinst_shelfno_id_to,
prdinst.replydate  prdinst_replydate,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  workplace.workplace_loca_id_workplace  workplace_loca_id_workplace ,
  workplace.workplace_chrg_id_workplace  workplace_chrg_id_workplace ,
prdinst.commencementdate  prdinst_commencementdate,
prdinst.id  prdinst_id,
prdinst.id id,
prdinst.contents  prdinst_contents,
prdinst.persons_id_upd   prdinst_person_id_upd,
prdinst.cno_prdord  prdinst_cno_prdord,
  workplace.usrgrp_name_chrg_workplace  usrgrp_name_chrg_workplace ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
prdinst.sno_prdord  prdinst_sno_prdord,
  opeitm.classlist_code  classlist_code ,
prdinst.workplaces_id   prdinst_workplace_id,
  workplace.person_sect_id_chrg_workplace  person_sect_id_chrg_workplace ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  workplace.usrgrp_code_chrg_workplace  usrgrp_code_chrg_workplace ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  opeitm.classlist_name  classlist_name ,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_code  prjno_code ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
prdinst.isudate  prdinst_isudate,
prdinst.expiredate  prdinst_expiredate,
prdinst.updated_at  prdinst_updated_at,
prdinst.qty  prdinst_qty,
prdinst.sno  prdinst_sno,
prdinst.locas_id_to   prdinst_loca_id_to,
prdinst.remark  prdinst_remark,
prdinst.created_at  prdinst_created_at,
prdinst.update_ip  prdinst_update_ip,
prdinst.duedate  prdinst_duedate,
prdinst.qty_case  prdinst_qty_case,
prdinst.commencement_f  prdinst_commencement_f,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
prdinst.cno  prdinst_cno,
prdinst.gno  prdinst_gno,
  workplace.chrg_person_id_chrg_workplace  chrg_person_id_chrg_workplace ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox 
 from prdinsts   prdinst,
  r_chrgs  chrg ,  r_opeitms  opeitm ,  r_prjnos  prjno ,  r_shelfnos  shelfno_to ,  r_persons  person_upd ,  r_workplaces  workplace ,  r_locas  loca_to 
  where       prdinst.chrgs_id = chrg.id      and prdinst.opeitms_id = opeitm.id      and prdinst.prjnos_id = prjno.id      and prdinst.shelfnos_id_to = shelfno_to.id      and prdinst.persons_id_upd = person_upd.id      and prdinst.workplaces_id = workplace.id      and prdinst.locas_id_to = loca_to.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdinsts;
 CREATE TABLE sio.sio_r_prdinsts (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_prdinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,prdinst_sno  varchar (40) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,loca_name  varchar (100) 
,prdinst_isudate   timestamp(6) 
,loca_code_to  varchar (50) 
,prdinst_duedate   timestamp(6) 
,prdinst_qty  numeric (18,4)
,prdinst_qty_case  numeric (38,0)
,prdinst_replydate   date 
,person_name_chrg  varchar (100) 
,loca_code_sect  varchar (50) 
,loca_name_sect  varchar (100) 
,usrgrp_name_chrg_workplace  varchar (100) 
,unit_name_outbox  varchar (100) 
,unit_name_box  varchar (100) 
,unit_name_case  varchar (100) 
,unit_name  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,shelfno_code_to  varchar (50) 
,scrlv_code_chrg_workplace  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,shelfno_code  varchar (50) 
,boxe_code  varchar (50) 
,unit_code_case  varchar (50) 
,loca_name_sect_chrg_workplace  varchar (100) 
,loca_name_workplace  varchar (100) 
,loca_name_shelfno_to  varchar (100) 
,loca_name_shelfno  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,loca_name_to  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,unit_code  varchar (50) 
,person_code_chrg_workplace  varchar (50) 
,person_code_chrg  varchar (50) 
,person_name_chrg_workplace  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,loca_code_sect_chrg_workplace  varchar (50) 
,loca_code_workplace  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,loca_code_shelfno  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,prjno_code  varchar (50) 
,boxe_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,shelfno_name_to  varchar (100) 
,classlist_name  varchar (100) 
,shelfno_name  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_code_chrg_workplace  varchar (50) 
,prjno_name  varchar (100) 
,classlist_code  varchar (50) 
,unit_code_outbox  varchar (50) 
,unit_code_box  varchar (50) 
,loca_code  varchar (50) 
,prdinst_expiredate   date 
,prdinst_cno_prdord  varchar (50) 
,prdinst_sno_prdord  varchar (50) 
,prdinst_commencement_f  varchar (1) 
,prdinst_commencementdate   timestamp(6) 
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_prdpurshp  varchar (20) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autoinst_p  numeric (3,0)
,itm_std  varchar (50) 
,opeitm_autoact_p  numeric (3,0)
,opeitm_autoord_p  numeric (3,0)
,loca_abbr_to  varchar (50) 
,loca_zip_to  varchar (10) 
,loca_country_to  varchar (20) 
,loca_prfct_to  varchar (20) 
,loca_addr1_to  varchar (50) 
,loca_addr2_to  varchar (50) 
,loca_tel_to  varchar (20) 
,loca_fax_to  varchar (20) 
,loca_mail_to  varchar (20) 
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
,opeitm_autocreate_act  varchar (1) 
,workplace_contents  varchar (4000) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_chkord_prc  numeric (3,0)
,opeitm_chkord  varchar (1) 
,opeitm_esttosch  numeric (22,0)
,opeitm_stktaking_proc  varchar (1) 
,opeitm_rule_price  varchar (1) 
,opeitm_mold  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_packno_flg  varchar (1) 
,opeitm_processseq  numeric (3,0)
,opeitm_priority  numeric (3,0)
,opeitm_contents  varchar (4000) 
,shelfno_contents_to  varchar (4000) 
,opeitm_acceptance_proc  varchar (1) 
,opeitm_chkinst  varchar (1) 
,prdinst_cno  varchar (40) 
,boxe_boxtype  varchar (20) 
,opeitm_maxqty  numeric (22,0)
,prdinst_gno  varchar (40) 
,prdinst_contents  varchar (4000) 
,prdinst_remark  varchar (4000) 
,prdinst_created_at   timestamp(6) 
,prdinst_workplace_id  numeric (22,0)
,prdinst_id  numeric (38,0)
,id  numeric (38,0)
,prdinst_person_id_upd  numeric (38,0)
,prdinst_update_ip  varchar (40) 
,prdinst_chrg_id  numeric (38,0)
,prdinst_updated_at   timestamp(6) 
,prdinst_opeitm_id  numeric (38,0)
,prdinst_prjno_id  numeric (38,0)
,prdinst_shelfno_id_to  numeric (38,0)
,prdinst_loca_id_to  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,loca_zip  varchar (10) 
,loca_abbr  varchar (50) 
,itm_classlist_id  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,workplace_loca_id_workplace  numeric (22,0)
,workplace_chrg_id_workplace  numeric (22,0)
,itm_unit_id  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,chrg_person_id  numeric (22,0)
,loca_id_sect  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,loca_addr2  varchar (50) 
,opeitm_unit_id_prdpurshp  numeric (38,0)
,person_sect_id_chrg_workplace  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,loca_addr2_shelfno  varchar (50) 
,loca_addr1  varchar (50) 
,loca_prfct  varchar (20) 
,boxe_unit_id_box  numeric (38,0)
,loca_prfct_shelfno  varchar (20) 
,boxe_unit_id_outbox  numeric (38,0)
,loca_country_shelfno  varchar (20) 
,chrg_person_id_chrg_workplace  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
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
 CREATE INDEX sio_r_prdinsts_uk1 
  ON sio.sio_r_prdinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdinsts_seq ;
 create sequence sio.sio_r_prdinsts_seq ;
 --- drop view r_prdords cascade  
 create or replace view r_prdords as select  
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_prdpurshp  opeitm_prdpurshp ,
prdord.opeitms_id   prdord_opeitm_id,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
prdord.chrgs_id   prdord_chrg_id,
  opeitm.opeitm_opt_fix_flg  opeitm_opt_fix_flg ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  opeitm.shelfno_name  shelfno_name ,
  prjno.prjno_name  prjno_name ,
  opeitm.opeitm_autocreate_ord  opeitm_autocreate_ord ,
  opeitm.opeitm_autoinst_p  opeitm_autoinst_p ,
prdord.starttime  prdord_starttime,
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
prdord.qty_case  prdord_qty_case,
  opeitm.itm_code  itm_code ,
  opeitm.itm_name  itm_name ,
  opeitm.opeitm_autoact_p  opeitm_autoact_p ,
  opeitm.opeitm_autoord_p  opeitm_autoord_p ,
  workplace.scrlv_code_chrg_workplace  scrlv_code_chrg_workplace ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  opeitm.opeitm_duration  opeitm_duration ,
  opeitm.opeitm_units_lttime  opeitm_units_lttime ,
  workplace.loca_code_sect_chrg_workplace  loca_code_sect_chrg_workplace ,
  workplace.loca_code_workplace  loca_code_workplace ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  opeitm.loca_code  loca_code ,
  workplace.loca_name_sect_chrg_workplace  loca_name_sect_chrg_workplace ,
  workplace.loca_name_workplace  loca_name_workplace ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  opeitm.loca_name  loca_name ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  opeitm.opeitm_minqty  opeitm_minqty ,
  workplace.person_code_chrg_workplace  person_code_chrg_workplace ,
  chrg.person_code_chrg  person_code_chrg ,
  workplace.person_name_chrg_workplace  person_name_chrg_workplace ,
  chrg.person_name_chrg  person_name_chrg ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_operation  opeitm_operation ,
  opeitm.opeitm_opt_fixoterm  opeitm_opt_fixoterm ,
  opeitm.itm_classlist_id  itm_classlist_id ,
prdord.id  prdord_id,
prdord.id id,
prdord.qty  prdord_qty,
prdord.persons_id_upd   prdord_person_id_upd,
prdord.duedate  prdord_duedate,
prdord.sno  prdord_sno,
prdord.expiredate  prdord_expiredate,
prdord.isudate  prdord_isudate,
prdord.remark  prdord_remark,
prdord.toduedate  prdord_toduedate,
prdord.created_at  prdord_created_at,
prdord.updated_at  prdord_updated_at,
prdord.update_ip  prdord_update_ip,
  opeitm.opeitm_safestkqty  opeitm_safestkqty ,
  opeitm.opeitm_packqty  opeitm_packqty ,
prdord.shelfnos_id_to   prdord_shelfno_id_to,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.opeitm_shuffle_flg  opeitm_shuffle_flg ,
prdord.prjnos_id   prdord_prjno_id,
  opeitm.opeitm_autocreate_act  opeitm_autocreate_act ,
  workplace.workplace_loca_id_workplace  workplace_loca_id_workplace ,
  workplace.workplace_chrg_id_workplace  workplace_chrg_id_workplace ,
  opeitm.opeitm_shuffle_loca  opeitm_shuffle_loca ,
  opeitm.opeitm_chkord_prc  opeitm_chkord_prc ,
  opeitm.opeitm_chkord  opeitm_chkord ,
  opeitm.opeitm_esttosch  opeitm_esttosch ,
  opeitm.opeitm_rule_price  opeitm_rule_price ,
  workplace.usrgrp_name_chrg_workplace  usrgrp_name_chrg_workplace ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  opeitm.classlist_code  classlist_code ,
  opeitm.opeitm_mold  opeitm_mold ,
prdord.workplaces_id   prdord_workplace_id,
  opeitm.opeitm_autocreate_inst  opeitm_autocreate_inst ,
  workplace.person_sect_id_chrg_workplace  person_sect_id_chrg_workplace ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  workplace.usrgrp_code_chrg_workplace  usrgrp_code_chrg_workplace ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
prdord.confirm  prdord_confirm,
prdord.consumtype  prdord_consumtype,
prdord.autocreate_inst  prdord_autocreate_inst,
prdord.autoinst_p  prdord_autoinst_p,
prdord.autocreate_act  prdord_autocreate_act,
prdord.autoact_p  prdord_autoact_p,
prdord.opt_fixoterm  prdord_opt_fixoterm,
prdord.gno  prdord_gno,
  opeitm.classlist_name  classlist_name ,
  opeitm.opeitm_packno_flg  opeitm_packno_flg ,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_priority  opeitm_priority ,
  prjno.prjno_code  prjno_code ,
  opeitm.opeitm_contents  opeitm_contents ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.opeitm_chkinst  opeitm_chkinst ,
  workplace.chrg_person_id_chrg_workplace  chrg_person_id_chrg_workplace ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.opeitm_maxqty  opeitm_maxqty ,
  opeitm.opeitm_prjalloc_flg  opeitm_prjalloc_flg 
 from prdords   prdord,
  r_opeitms  opeitm ,  r_chrgs  chrg ,  r_persons  person_upd ,  r_shelfnos  shelfno_to ,  r_prjnos  prjno ,  r_workplaces  workplace 
  where       prdord.opeitms_id = opeitm.id      and prdord.chrgs_id = chrg.id      and prdord.persons_id_upd = person_upd.id      and prdord.shelfnos_id_to = shelfno_to.id      and prdord.prjnos_id = prjno.id      and prdord.workplaces_id = workplace.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdords;
 CREATE TABLE sio.sio_r_prdords (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_prdords_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,prdord_confirm  varchar (1) 
,prdord_isudate   timestamp(6) 
,prdord_sno  varchar (40) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,opeitm_processseq  numeric (3,0)
,prdord_duedate   timestamp(6) 
,opeitm_priority  numeric (3,0)
,prdord_starttime   timestamp(6) 
,prdord_toduedate   timestamp(6) 
,prdord_qty  numeric (18,4)
,opeitm_packqty  numeric (38,0)
,prdord_qty_case  numeric (38,0)
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,prdord_autoact_p  numeric (3,0)
,prdord_consumtype  varchar (3) 
,prdord_opt_fixoterm  numeric (5,2)
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,loca_code_shelfno_to  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,prdord_autocreate_inst  varchar (1) 
,prdord_autocreate_act  varchar (1) 
,prdord_autoinst_p  numeric (3,0)
,prdord_gno  varchar (40) 
,prdord_expiredate   date 
,scrlv_code_chrg  varchar (50) 
,scrlv_code_chrg_workplace  varchar (50) 
,prjno_code_chil  varchar (50) 
,loca_code_sect_chrg_workplace  varchar (50) 
,loca_code_workplace  varchar (50) 
,usrgrp_name_chrg_workplace  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,person_name_chrg_workplace  varchar (100) 
,loca_name_sect_chrg_workplace  varchar (100) 
,loca_name_workplace  varchar (100) 
,usrgrp_code_chrg_workplace  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,person_code_chrg_workplace  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,opeitm_stktaking_proc  varchar (1) 
,boxe_boxtype  varchar (20) 
,itm_std  varchar (50) 
,opeitm_acceptance_proc  varchar (1) 
,shelfno_contents_to  varchar (4000) 
,person_email_chrg  varchar (50) 
,scrlv_level1_chrg  varchar (1) 
,workplace_contents  varchar (4000) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,opeitm_chkord  varchar (1) 
,opeitm_chkinst  varchar (1) 
,opeitm_mold  varchar (1) 
,opeitm_packno_flg  varchar (1) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_units_lttime  varchar (4) 
,opeitm_minqty  numeric (38,6)
,opeitm_maxqty  numeric (22,0)
,opeitm_esttosch  numeric (22,0)
,opeitm_chkord_prc  numeric (3,0)
,opeitm_operation  varchar (20) 
,opeitm_autoinst_p  numeric (3,0)
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_shuffle_flg  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_rule_price  varchar (1) 
,opeitm_contents  varchar (4000) 
,opeitm_prdpurshp  varchar (20) 
,opeitm_autoord_p  numeric (3,0)
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_duration  numeric (38,2)
,opeitm_safestkqty  numeric (38,0)
,opeitm_autoact_p  numeric (3,0)
,prdord_remark  varchar (4000) 
,prdord_workplace_id  numeric (22,0)
,prdord_chrg_id  numeric (38,0)
,prdord_prjno_id  numeric (38,0)
,prdord_shelfno_id_to  numeric (38,0)
,prdord_update_ip  varchar (40) 
,prdord_opeitm_id  numeric (38,0)
,prdord_created_at   timestamp(6) 
,prdord_updated_at   timestamp(6) 
,prdord_person_id_upd  numeric (38,0)
,id  numeric (38,0)
,prdord_id  numeric (38,0)
,loca_abbr  varchar (50) 
,opeitm_unit_id_prdpurshp  numeric (38,0)
,chrg_person_id_chrg_workplace  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,workplace_chrg_id_workplace  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,workplace_loca_id_workplace  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
,person_sect_id_chrg_workplace  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,loca_addr2  varchar (50) 
,loca_addr1  varchar (50) 
,loca_prfct  varchar (20) 
,loca_zip  varchar (10) 
,shelfno_loca_id_shelfno_to  numeric (38,0)
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
 CREATE INDEX sio_r_prdords_uk1 
  ON sio.sio_r_prdords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdords_seq ;
 create sequence sio.sio_r_prdords_seq ;
