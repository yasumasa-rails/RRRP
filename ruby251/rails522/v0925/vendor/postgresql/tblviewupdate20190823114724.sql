
 create sequence prdords_seq ;
 --- drop view r_prdords cascade  
 create or replace view r_prdords as select  
prdord.persons_id_upd   prdord_person_id_upd,
prdord.locas_id_to   prdord_loca_id_to,
prdord.remark  prdord_remark,
prdord.created_at  prdord_created_at,
prdord.update_ip  prdord_update_ip,
prdord.duedate  prdord_duedate,
prdord.toduedate  prdord_toduedate,
prdord.isudate  prdord_isudate,
prdord.expiredate  prdord_expiredate,
prdord.consumtype  prdord_consumtype,
prdord.updated_at  prdord_updated_at,
prdord.qty  prdord_qty,
prdord.sno  prdord_sno,
prdord.id id,
prdord.id  prdord_id,
prdord.starttime  prdord_starttime,
prdord.prjnos_id   prdord_prjno_id,
prdord.opt_fixoterm  prdord_opt_fixoterm,
prdord.autocreate_inst  prdord_autocreate_inst,
prdord.processseq_pare  prdord_processseq_pare,
prdord.confirm  prdord_confirm,
prdord.autocreate_act  prdord_autocreate_act,
prdord.gno  prdord_gno,
prdord.chrgs_id   prdord_chrg_id,
prdord.consumauto  prdord_consumauto,
prdord.autoinst_p  prdord_autoinst_p,
prdord.autoact_p  prdord_autoact_p,
prdord.opeitms_id_prd   prdord_opeitm_id_prd,
  loca_to.loca_code  loca_code ,
  loca_to.loca_country  loca_country ,
  loca_to.loca_abbr  loca_abbr ,
  loca_to.loca_prfct  loca_prfct ,
  loca_to.loca_tel  loca_tel ,
  loca_to.loca_mail  loca_mail ,
  loca_to.loca_addr1  loca_addr1 ,
  loca_to.loca_zip  loca_zip ,
  loca_to.loca_fax  loca_fax ,
  loca_to.loca_addr2  loca_addr2 ,
  loca_to.loca_name  loca_name ,
  opeitm_prd.loca_name_shelfno  loca_name_shelfno ,
  opeitm_prd.loca_mail_shelfno  loca_mail_shelfno ,
  opeitm_prd.loca_zip_shelfno  loca_zip_shelfno ,
  opeitm_prd.opeitm_prjalloc_flg  opeitm_prjalloc_flg ,
  opeitm_prd.opeitm_processseq  opeitm_processseq ,
  opeitm_prd.opeitm_priority  opeitm_priority ,
  opeitm_prd.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm_prd.loca_id_shelfno  loca_id_shelfno ,
  opeitm_prd.opeitm_chkord  opeitm_chkord ,
  opeitm_prd.opeitm_chkinst  opeitm_chkinst ,
  opeitm_prd.opeitm_mold  opeitm_mold ,
  opeitm_prd.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm_prd.opeitm_packno_flg  opeitm_packno_flg ,
  opeitm_prd.opeitm_opt_fix_flg  opeitm_opt_fix_flg ,
  opeitm_prd.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm_prd.unit_name_case  unit_name_case ,
  opeitm_prd.unit_name  unit_name ,
  opeitm_prd.opeitm_units_lttime  opeitm_units_lttime ,
  opeitm_prd.unit_code  unit_code ,
  opeitm_prd.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm_prd.unit_name_outbox  unit_name_outbox ,
  opeitm_prd.unit_code_outbox  unit_code_outbox ,
  opeitm_prd.unit_code_box  unit_code_box ,
  opeitm_prd.unit_name_box  unit_name_box ,
  opeitm_prd.opeitm_minqty  opeitm_minqty ,
  opeitm_prd.opeitm_packqty  opeitm_packqty ,
  opeitm_prd.opeitm_maxqty  opeitm_maxqty ,
  opeitm_prd.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm_prd.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm_prd.unit_code_case  unit_code_case ,
  opeitm_prd.itm_deth  itm_deth ,
  opeitm_prd.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm_prd.opeitm_esttosch  opeitm_esttosch ,
  opeitm_prd.opeitm_chkord_prc  opeitm_chkord_prc ,
  opeitm_prd.opeitm_operation  opeitm_operation ,
  opeitm_prd.opeitm_itm_id  opeitm_itm_id ,
  opeitm_prd.opeitm_loca_id  opeitm_loca_id ,
  opeitm_prd.opeitm_opt_fixoterm  opeitm_opt_fixoterm ,
  opeitm_prd.opeitm_autocreate_ord  opeitm_autocreate_ord ,
  opeitm_prd.opeitm_autocreate_inst  opeitm_autocreate_inst ,
  opeitm_prd.opeitm_shuffle_flg  opeitm_shuffle_flg ,
  opeitm_prd.opeitm_shuffle_loca  opeitm_shuffle_loca ,
  opeitm_prd.opeitm_autocreate_act  opeitm_autocreate_act ,
  opeitm_prd.opeitm_rule_price  opeitm_rule_price ,
  opeitm_prd.opeitm_stktaking_f  opeitm_stktaking_f ,
  opeitm_prd.boxe_code  boxe_code ,
  opeitm_prd.shelfno_name  shelfno_name ,
  opeitm_prd.shelfno_code  shelfno_code ,
  opeitm_prd.itm_weight  itm_weight ,
  opeitm_prd.itm_length  itm_length ,
  opeitm_prd.opeitm_prdpurshp  opeitm_prdpurshp ,
  opeitm_prd.opeitm_autoord_p  opeitm_autoord_p ,
  opeitm_prd.itm_wide  itm_wide ,
  opeitm_prd.opeitm_duration  opeitm_duration ,
  opeitm_prd.opeitm_safestkqty  opeitm_safestkqty ,
  opeitm_prd.opeitm_contents  opeitm_contents ,
  opeitm_prd.itm_name  itm_name ,
  opeitm_prd.loca_name  loca_name ,
  opeitm_prd.loca_code  loca_code ,
  opeitm_prd.itm_code  itm_code ,
  opeitm_prd.itm_std  itm_std ,
  opeitm_prd.itm_model  itm_model ,
  opeitm_prd.itm_design  itm_design ,
  opeitm_prd.itm_material  itm_material ,
  opeitm_prd.opeitm_autoact_p  opeitm_autoact_p ,
  opeitm_prd.boxe_name  boxe_name ,
  opeitm_prd.loca_prfct  loca_prfct ,
  opeitm_prd.loca_addr1  loca_addr1 ,
  opeitm_prd.loca_addr2  loca_addr2 ,
  opeitm_prd.loca_zip  loca_zip ,
  opeitm_prd.boxe_boxtype  boxe_boxtype ,
  opeitm_prd.loca_abbr  loca_abbr ,
  opeitm_prd.loca_addr1_shelfno  loca_addr1_shelfno ,
  opeitm_prd.loca_code_shelfno  loca_code_shelfno ,
  opeitm_prd.loca_prfct_shelfno  loca_prfct_shelfno ,
  opeitm_prd.loca_country_shelfno  loca_country_shelfno ,
  opeitm_prd.loca_addr2_shelfno  loca_addr2_shelfno ,
  opeitm_prd.loca_abbr_shelfno  loca_abbr_shelfno ,
  opeitm_prd.loca_fax_shelfno  loca_fax_shelfno ,
  opeitm_prd.loca_tel_shelfno  loca_tel_shelfno ,
  chrg.chrg_person_id  chrg_person_id ,
  chrg.loca_id_sect  loca_id_sect ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.loca_code_sect  loca_code_sect ,
  chrg.loca_name_sect  loca_name_sect ,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code  prjno_code 
 from prdords   prdord,
  r_persons  person_upd ,  r_locas  loca_to ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_opeitms  opeitm_prd 
  where       prdord.persons_id_upd = person_upd.id      and prdord.locas_id_to = loca_to.id      and prdord.prjnos_id = prjno.id      and prdord.chrgs_id = chrg.id      and prdord.opeitms_id_prd = opeitm_prd.id     ;
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
,prdord_sno  varchar (40) 
,prdord_gno  varchar (40) 
,usrgrp_name_chrg  varchar (100) 
,itm_name_prd  varchar (100) 
,unit_name_case_prd  varchar (100) 
,unit_name_prd  varchar (100) 
,unit_code_prd  varchar (50) 
,unit_code_prdpurshp_prd  varchar (50) 
,unit_name_outbox_prd  varchar (100) 
,unit_code_outbox_prd  varchar (50) 
,unit_code_box_prd  varchar (50) 
,loca_name_prd  varchar (100) 
,person_code_chrg  varchar (50) 
,boxe_code_prd  varchar (50) 
,person_name_chrg  varchar (100) 
,loca_code_to  varchar (50) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,loca_name_to  varchar (100) 
,loca_name_shelfno_prd  varchar (100) 
,loca_code_shelfno_prd  varchar (50) 
,boxe_name_prd  varchar (100) 
,loca_name_sect  varchar (100) 
,itm_code_prd  varchar (50) 
,loca_code_prd  varchar (50) 
,loca_code_sect  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,unit_name_box_prd  varchar (100) 
,shelfno_code_prd  varchar (50) 
,unit_name_prdpurshp_prd  varchar (100) 
,unit_code_case_prd  varchar (50) 
,shelfno_name_prd  varchar (100) 
,prdord_starttime   timestamp(6) 
,prdord_expiredate   date 
,prdord_processseq_pare  numeric (38,0)
,prdord_confirm  varchar (1) 
,prdord_autocreate_act  varchar (1) 
,prdord_consumtype  varchar (3) 
,prdord_remark  varchar (4000) 
,prdord_opt_fixoterm  numeric (5,2)
,prdord_autocreate_inst  varchar (1) 
,prdord_qty  numeric (18,4)
,prdord_duedate   timestamp(6) 
,prdord_consumauto  varchar (1) 
,prdord_autoinst_p  numeric (3,0)
,prdord_toduedate   timestamp(6) 
,prdord_autoact_p  numeric (3,0)
,prdord_isudate   timestamp(6) 
,opeitm_autocreate_act_prd  varchar (1) 
,loca_country_to  varchar (20) 
,loca_abbr_to  varchar (50) 
,loca_prfct_to  varchar (20) 
,loca_tel_to  varchar (20) 
,loca_mail_to  varchar (20) 
,loca_addr1_to  varchar (50) 
,loca_zip_to  varchar (10) 
,loca_fax_to  varchar (20) 
,loca_addr2_to  varchar (50) 
,opeitm_prjalloc_flg_prd  numeric (22,0)
,opeitm_processseq_prd  numeric (3,0)
,opeitm_priority_prd  numeric (3,0)
,opeitm_chkord_prd  varchar (1) 
,opeitm_chkinst_prd  varchar (1) 
,opeitm_mold_prd  varchar (1) 
,opeitm_packno_flg_prd  varchar (1) 
,opeitm_opt_fix_flg_prd  varchar (1) 
,opeitm_units_lttime_prd  varchar (4) 
,opeitm_minqty_prd  numeric (38,6)
,opeitm_packqty_prd  numeric (38,0)
,opeitm_maxqty_prd  numeric (22,0)
,itm_deth_prd  numeric (22,0)
,opeitm_esttosch_prd  numeric (22,0)
,opeitm_chkord_prc_prd  numeric (3,0)
,opeitm_operation_prd  varchar (40) 
,opeitm_opt_fixoterm_prd  numeric (5,2)
,opeitm_autocreate_ord_prd  varchar (1) 
,opeitm_autocreate_inst_prd  varchar (1) 
,opeitm_shuffle_flg_prd  varchar (1) 
,opeitm_shuffle_loca_prd  varchar (1) 
,opeitm_rule_price_prd  varchar (1) 
,opeitm_stktaking_f_prd  varchar (1) 
,itm_weight_prd  numeric (22,0)
,itm_length_prd  numeric (22,0)
,opeitm_prdpurshp_prd  varchar (5) 
,opeitm_autoord_p_prd  numeric (3,0)
,itm_wide_prd  numeric (22,0)
,opeitm_duration_prd  numeric (38,2)
,opeitm_safestkqty_prd  numeric (38,0)
,opeitm_contents_prd  varchar (4000) 
,itm_std_prd  varchar (50) 
,itm_model_prd  varchar (50) 
,itm_design_prd  varchar (50) 
,itm_material_prd  varchar (50) 
,opeitm_autoact_p_prd  numeric (3,0)
,boxe_boxtype_prd  varchar (20) 
,prdord_update_ip  varchar (40) 
,prdord_created_at   timestamp(6) 
,prdord_person_id_upd  numeric (38,0)
,prdord_id  numeric (38,0)
,prdord_loca_id_to  numeric (38,0)
,id  numeric (38,0)
,prdord_opeitm_id_prd  numeric (22,0)
,prdord_chrg_id  numeric (38,0)
,prdord_prjno_id  numeric (38,0)
,prdord_updated_at   timestamp(6) 
,loca_addr1_shelfno_prd  varchar (50) 
,loca_mail_shelfno_prd  varchar (20) 
,loca_prfct_shelfno_prd  varchar (20) 
,loca_country_shelfno_prd  varchar (20) 
,loca_addr2_shelfno_prd  varchar (50) 
,opeitm_itm_id_prd  numeric (38,0)
,shelfno_loca_id_shelfno_prd  numeric (38,0)
,opeitm_unit_id_prdpurshp_prd  numeric (38,0)
,loca_abbr_shelfno_prd  varchar (50) 
,loca_fax_shelfno_prd  varchar (20) 
,loca_tel_shelfno_prd  varchar (20) 
,chrg_person_id  numeric (22,0)
,loca_id_sect  numeric (22,0)
,opeitm_boxe_id_prd  numeric (22,0)
,opeitm_unit_id_case_prd  numeric (38,0)
,loca_id_shelfno_prd  numeric (22,0)
,opeitm_shelfno_id_prd  numeric (22,0)
,loca_zip_shelfno_prd  varchar (10) 
,loca_prfct_prd  varchar (20) 
,loca_addr1_prd  varchar (50) 
,loca_addr2_prd  varchar (50) 
,loca_zip_prd  varchar (10) 
,opeitm_loca_id_prd  numeric (38,0)
,loca_abbr_prd  varchar (50) 
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
