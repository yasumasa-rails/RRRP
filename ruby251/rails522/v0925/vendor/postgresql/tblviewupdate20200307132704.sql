
 --- drop view r_prdords cascade  
 create or replace view r_prdords as select  
prdord.chrgs_id   prdord_chrg_id,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
prdord.opeitms_id   prdord_opeitm_id,
  opeitm.opeitm_prdpurshp  opeitm_prdpurshp ,
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
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  opeitm.opeitm_duration  opeitm_duration ,
  opeitm.opeitm_units_lttime  opeitm_units_lttime ,
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
  opeitm.opeitm_minqty  opeitm_minqty ,
  chrg.person_code_chrg  person_code_chrg ,
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
  opeitm.opeitm_chkord_prc  opeitm_chkord_prc ,
  opeitm.opeitm_chkord  opeitm_chkord ,
  opeitm.opeitm_autocreate_act  opeitm_autocreate_act ,
  opeitm.opeitm_shuffle_loca  opeitm_shuffle_loca ,
  opeitm.opeitm_esttosch  opeitm_esttosch ,
  opeitm.opeitm_rule_price  opeitm_rule_price ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  opeitm.classlist_code  classlist_code ,
  opeitm.opeitm_mold  opeitm_mold ,
  opeitm.opeitm_autocreate_inst  opeitm_autocreate_inst ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
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
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.opeitm_maxqty  opeitm_maxqty ,
  opeitm.opeitm_prjalloc_flg  opeitm_prjalloc_flg 
 from prdords   prdord,
  r_chrgs  chrg ,  r_opeitms  opeitm ,  r_persons  person_upd ,  r_shelfnos  shelfno_to ,  r_prjnos  prjno 
  where       prdord.chrgs_id = chrg.id      and prdord.opeitms_id = opeitm.id      and prdord.persons_id_upd = person_upd.id      and prdord.shelfnos_id_to = shelfno_to.id      and prdord.prjnos_id = prjno.id     ;
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
,prdord_autocreate_inst  varchar (1) 
,prdord_autocreate_act  varchar (1) 
,prdord_autoinst_p  numeric (3,0)
,prdord_gno  varchar (40) 
,prdord_expiredate   date 
,loca_code_shelfno_to  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,prjno_code_chil  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,loca_name_shelfno  varchar (100) 
,loca_code_shelfno  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,scrlv_level1_chrg  varchar (1) 
,boxe_boxtype  varchar (20) 
,opeitm_acceptance_proc  varchar (1) 
,shelfno_contents_to  varchar (4000) 
,person_email_chrg  varchar (50) 
,opeitm_stktaking_proc  varchar (1) 
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
,shelfno_name  varchar (100) 
,shelfno_code  varchar (50) 
,opeitm_chkord  varchar (1) 
,opeitm_chkinst  varchar (1) 
,opeitm_mold  varchar (1) 
,opeitm_packno_flg  varchar (1) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_units_lttime  varchar (4) 
,opeitm_minqty  numeric (38,6)
,opeitm_packqty  numeric (38,0)
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
,prdord_person_id_upd  numeric (38,0)
,id  numeric (38,0)
,prdord_id  numeric (38,0)
,prdord_prjno_id  numeric (38,0)
,prdord_created_at   timestamp(6) 
,prdord_shelfno_id_to  numeric (38,0)
,prdord_updated_at   timestamp(6) 
,prdord_update_ip  varchar (40) 
,prdord_chrg_id  numeric (38,0)
,prdord_opeitm_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
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
,loca_abbr  varchar (50) 
,shelfno_loca_id_shelfno_to  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,boxe_unit_id_box  numeric (22,0)
,boxe_unit_id_outbox  numeric (22,0)
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
 CREATE INDEX sio_r_prdords_uk1 
  ON sio.sio_r_prdords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdords_seq ;
 create sequence sio.sio_r_prdords_seq ;
