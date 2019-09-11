---   create sequence purords_seq ;
 --- drop view r_purords cascade  
 create or replace view r_purords as select  
purord.created_at  purord_created_at,
purord.update_ip  purord_update_ip,
purord.toduedate  purord_toduedate,
purord.isudate  purord_isudate,
purord.expiredate  purord_expiredate,
purord.updated_at  purord_updated_at,
purord.id id,
purord.id  purord_id,
purord.persons_id_upd   purord_person_id_upd,
purord.locas_id_to   purord_loca_id_to,
purord.starttime  purord_starttime,
purord.prjnos_id   purord_prjno_id,
purord.opt_fixoterm  purord_opt_fixoterm,
purord.processseq_pare  purord_processseq_pare,
purord.qty_case  purord_qty_case,
purord.contract_price  purord_contract_price,
purord.chrgs_id   purord_chrg_id,
purord.itm_code_client  purord_itm_code_client,
  loca_to.loca_country  loca_country_to ,
  loca_to.loca_abbr  loca_abbr_to ,
purord.qty  purord_qty,
purord.sno  purord_sno,
purord.remark  purord_remark,
purord.price  purord_price,
purord.duedate  purord_duedate,
purord.confirm  purord_confirm,
purord.amt  purord_amt,
purord.tax  purord_tax,
purord.gno  purord_gno,
  prjno.prjno_code  prjno_code ,
  loca_to.loca_prfct  loca_prfct_to ,
  loca_to.loca_tel  loca_tel_to ,
  loca_to.loca_mail  loca_mail_to ,
  loca_to.loca_addr1  loca_addr1_to ,
  loca_to.loca_zip  loca_zip_to ,
  loca_to.loca_fax  loca_fax_to ,
  loca_to.loca_addr2  loca_addr2_to ,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code_chil  prjno_code_chil ,
  loca_to.loca_name  loca_name_to ,
  opeitm_pur.unit_name  unit_name_pur ,
  opeitm_pur.unit_code  unit_code_pur ,
  opeitm_pur.unit_code_prdpurshp  unit_code_prdpurshp_pur ,
  opeitm_pur.unit_name_case  unit_name_case_pur ,
  opeitm_pur.unit_name_prdpurshp  unit_name_prdpurshp_pur ,
  opeitm_pur.unit_code_outbox  unit_code_outbox_pur ,
  opeitm_pur.unit_code_box  unit_code_box_pur ,
  opeitm_pur.unit_name_box  unit_name_box_pur ,
  opeitm_pur.unit_code_case  unit_code_case_pur ,
  opeitm_pur.itm_length  itm_length_pur ,
  opeitm_pur.itm_weight  itm_weight_pur ,
  opeitm_pur.unit_name_outbox  unit_name_outbox_pur ,
  opeitm_pur.itm_deth  itm_deth_pur ,
  opeitm_pur.itm_wide  itm_wide_pur ,
  opeitm_pur.boxe_boxtype  boxe_boxtype_pur ,
  opeitm_pur.boxe_name  boxe_name_pur ,
  opeitm_pur.shelfno_name  shelfno_name_pur ,
  opeitm_pur.boxe_code  boxe_code_pur ,
  opeitm_pur.itm_material  itm_material_pur ,
  opeitm_pur.itm_model  itm_model_pur ,
  opeitm_pur.loca_code  loca_code_pur ,
  opeitm_pur.loca_name  loca_name_pur ,
  opeitm_pur.itm_std  itm_std_pur ,
  opeitm_pur.itm_name  itm_name_pur ,
  opeitm_pur.itm_design  itm_design_pur ,
  chrg.chrg_person_id  chrg_person_id ,
  chrg.loca_id_sect  loca_id_sect ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.loca_code_sect  loca_code_sect ,
  chrg.loca_name_sect  loca_name_sect ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  opeitm_pur.itm_code  itm_code_pur ,
  loca_to.loca_code  loca_code_to ,
purord.autocreate_inst  purord_autocreate_inst,
purord.autocreate_act  purord_autocreate_act,
purord.consumtype  purord_consumtype,
purord.consumauto  purord_consumauto,
purord.autoinst_p  purord_autoinst_p,
purord.autoact_p  purord_autoact_p,
purord.opeitms_id_pur   purord_opeitm_id_pur,
  opeitm_pur.loca_name_shelfno  loca_name_shelfno_pur ,
  opeitm_pur.loca_mail_shelfno  loca_mail_shelfno_pur ,
  opeitm_pur.loca_zip_shelfno  loca_zip_shelfno_pur ,
  opeitm_pur.opeitm_prjalloc_flg  opeitm_prjalloc_flg_pur ,
  opeitm_pur.opeitm_processseq  opeitm_processseq_pur ,
  opeitm_pur.opeitm_priority  opeitm_priority_pur ,
  opeitm_pur.opeitm_shelfno_id  opeitm_shelfno_id_pur ,
  opeitm_pur.loca_id_shelfno  loca_id_shelfno_pur ,
  opeitm_pur.opeitm_chkord  opeitm_chkord_pur ,
  opeitm_pur.opeitm_chkinst  opeitm_chkinst_pur ,
  opeitm_pur.opeitm_mold  opeitm_mold_pur ,
  opeitm_pur.opeitm_boxe_id  opeitm_boxe_id_pur ,
  opeitm_pur.opeitm_packno_flg  opeitm_packno_flg_pur ,
  opeitm_pur.opeitm_opt_fix_flg  opeitm_opt_fix_flg_pur ,
  opeitm_pur.opeitm_unit_id_case  opeitm_unit_id_case_pur ,
  opeitm_pur.opeitm_units_lttime  opeitm_units_lttime_pur ,
  opeitm_pur.opeitm_minqty  opeitm_minqty_pur ,
  opeitm_pur.opeitm_packqty  opeitm_packqty_pur ,
  opeitm_pur.opeitm_maxqty  opeitm_maxqty_pur ,
  opeitm_pur.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp_pur ,
  opeitm_pur.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_pur ,
  opeitm_pur.opeitm_esttosch  opeitm_esttosch_pur ,
  opeitm_pur.opeitm_chkord_prc  opeitm_chkord_prc_pur ,
  opeitm_pur.opeitm_operation  opeitm_operation_pur ,
  opeitm_pur.opeitm_itm_id  opeitm_itm_id_pur ,
  opeitm_pur.opeitm_loca_id  opeitm_loca_id_pur ,
  opeitm_pur.opeitm_autocreate_act  opeitm_autocreate_act_pur ,
  opeitm_pur.opeitm_opt_fixoterm  opeitm_opt_fixoterm_pur ,
  opeitm_pur.opeitm_shuffle_flg  opeitm_shuffle_flg_pur ,
  opeitm_pur.opeitm_shuffle_loca  opeitm_shuffle_loca_pur ,
  opeitm_pur.opeitm_rule_price  opeitm_rule_price_pur ,
  opeitm_pur.opeitm_stktaking_f  opeitm_stktaking_f_pur ,
  opeitm_pur.opeitm_prdpurshp  opeitm_prdpurshp_pur ,
  opeitm_pur.opeitm_autoord_p  opeitm_autoord_p_pur ,
  opeitm_pur.opeitm_duration  opeitm_duration_pur ,
  opeitm_pur.opeitm_safestkqty  opeitm_safestkqty_pur ,
  opeitm_pur.opeitm_contents  opeitm_contents_pur ,
  opeitm_pur.opeitm_autoact_p  opeitm_autoact_p_pur ,
  opeitm_pur.shelfno_code  shelfno_code_pur ,
  opeitm_pur.loca_prfct  loca_prfct_pur ,
  opeitm_pur.loca_addr1  loca_addr1_pur ,
  opeitm_pur.loca_addr2  loca_addr2_pur ,
  opeitm_pur.loca_zip  loca_zip_pur ,
  opeitm_pur.opeitm_autocreate_inst  opeitm_autocreate_inst_pur ,
  opeitm_pur.opeitm_autocreate_ord  opeitm_autocreate_ord_pur ,
  opeitm_pur.loca_abbr  loca_abbr_pur ,
  opeitm_pur.loca_addr1_shelfno  loca_addr1_shelfno_pur ,
  opeitm_pur.loca_code_shelfno  loca_code_shelfno_pur ,
  opeitm_pur.loca_prfct_shelfno  loca_prfct_shelfno_pur ,
  opeitm_pur.loca_country_shelfno  loca_country_shelfno_pur ,
  opeitm_pur.loca_addr2_shelfno  loca_addr2_shelfno_pur ,
  opeitm_pur.loca_abbr_shelfno  loca_abbr_shelfno_pur ,
  opeitm_pur.loca_fax_shelfno  loca_fax_shelfno_pur ,
  opeitm_pur.loca_tel_shelfno  loca_tel_shelfno_pur 
 from purords   purord,
  r_persons  person_upd ,  r_locas  loca_to ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_opeitms  opeitm_pur 
  where       purord.persons_id_upd = person_upd.id      and purord.locas_id_to = loca_to.id      and purord.prjnos_id = prjno.id      and purord.chrgs_id = chrg.id      and purord.opeitms_id_pur = opeitm_pur.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purords;
 CREATE TABLE sio.sio_r_purords (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_purords_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,purord_confirm  varchar (1) 
,purord_sno  varchar (40) 
,itm_code_pur  varchar (50) 
,itm_name_pur  varchar (100) 
,loca_code_pur  varchar (50) 
,loca_name_pur  varchar (100) 
,purord_qty  numeric (18,4)
,purord_duedate   timestamp(6) 
,purord_amt  numeric (18,4)
,purord_price  numeric (38,4)
,purord_tax  numeric (38,4)
,loca_code_to  varchar (50) 
,loca_name_to  varchar (100) 
,purord_gno  varchar (40) 
,itm_std_pur  varchar (50) 
,itm_material_pur  varchar (50) 
,loca_name_shelfno_pur  varchar (100) 
,shelfno_code_pur  varchar (50) 
,loca_code_shelfno_pur  varchar (50) 
,purord_consumauto  varchar (1) 
,purord_autoact_p  numeric (3,0)
,purord_starttime   timestamp(6) 
,purord_opt_fixoterm  numeric (5,2)
,purord_processseq_pare  numeric (38,0)
,purord_qty_case  numeric (38,0)
,purord_contract_price  varchar (1) 
,purord_itm_code_client  varchar (50) 
,purord_remark  varchar (4000) 
,purord_toduedate   timestamp(6) 
,purord_isudate   timestamp(6) 
,purord_expiredate   date 
,purord_autocreate_inst  varchar (1) 
,purord_autocreate_act  varchar (1) 
,purord_consumtype  varchar (3) 
,purord_autoinst_p  numeric (3,0)
,loca_zip_to  varchar (10) 
,loca_fax_to  varchar (20) 
,loca_addr2_to  varchar (50) 
,opeitm_chkord_pur  varchar (1) 
,opeitm_processseq_pur  numeric (3,0)
,opeitm_duration_pur  numeric (38,2)
,opeitm_prdpurshp_pur  varchar (5) 
,opeitm_stktaking_f_pur  varchar (1) 
,opeitm_rule_price_pur  varchar (1) 
,opeitm_shuffle_loca_pur  varchar (1) 
,opeitm_shuffle_flg_pur  varchar (1) 
,opeitm_opt_fixoterm_pur  numeric (5,2)
,opeitm_autocreate_act_pur  varchar (1) 
,opeitm_operation_pur  varchar (40) 
,opeitm_chkord_prc_pur  numeric (3,0)
,itm_length_pur  numeric (22,0)
,itm_weight_pur  numeric (22,0)
,opeitm_esttosch_pur  numeric (22,0)
,itm_deth_pur  numeric (22,0)
,itm_wide_pur  numeric (22,0)
,boxe_boxtype_pur  varchar (20) 
,opeitm_maxqty_pur  numeric (22,0)
,opeitm_packqty_pur  numeric (38,0)
,opeitm_minqty_pur  numeric (38,6)
,opeitm_safestkqty_pur  numeric (38,0)
,itm_model_pur  varchar (50) 
,opeitm_contents_pur  varchar (4000) 
,opeitm_autoact_p_pur  numeric (3,0)
,opeitm_autocreate_inst_pur  varchar (1) 
,opeitm_prjalloc_flg_pur  numeric (22,0)
,itm_design_pur  varchar (50) 
,opeitm_units_lttime_pur  varchar (4) 
,opeitm_opt_fix_flg_pur  varchar (1) 
,opeitm_packno_flg_pur  varchar (1) 
,opeitm_priority_pur  numeric (3,0)
,opeitm_autocreate_ord_pur  varchar (1) 
,opeitm_mold_pur  varchar (1) 
,opeitm_chkinst_pur  varchar (1) 
,opeitm_autoord_p_pur  numeric (3,0)
,loca_abbr_to  varchar (50) 
,loca_country_to  varchar (20) 
,loca_prfct_to  varchar (20) 
,loca_tel_to  varchar (20) 
,loca_mail_to  varchar (20) 
,loca_addr1_to  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,loca_code_sect  varchar (50) 
,loca_name_sect  varchar (100) 
,person_name_chrg  varchar (100) 
,person_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,unit_code_prdpurshp_pur  varchar (50) 
,unit_code_pur  varchar (50) 
,unit_name_pur  varchar (100) 
,boxe_code_pur  varchar (50) 
,boxe_name_pur  varchar (100) 
,unit_name_outbox_pur  varchar (100) 
,unit_code_case_pur  varchar (50) 
,unit_name_box_pur  varchar (100) 
,unit_code_box_pur  varchar (50) 
,unit_code_outbox_pur  varchar (50) 
,unit_name_prdpurshp_pur  varchar (100) 
,unit_name_case_pur  varchar (100) 
,shelfno_name_pur  varchar (100) 
,purord_created_at   timestamp(6) 
,purord_update_ip  varchar (40) 
,purord_loca_id_to  numeric (38,0)
,purord_person_id_upd  numeric (38,0)
,purord_id  numeric (38,0)
,purord_prjno_id  numeric (38,0)
,purord_opeitm_id  numeric (38,0)
,purord_chrg_id  numeric (38,0)
,id  numeric (38,0)
,purord_opeitm_id_pur  numeric (22,0)
,purord_updated_at   timestamp(6) 
,loca_tel_shelfno_pur  varchar (20) 
,loca_mail_shelfno_pur  varchar (20) 
,opeitm_shelfno_id_pur  numeric (22,0)
,loca_id_shelfno_pur  numeric (22,0)
,opeitm_boxe_id_pur  numeric (22,0)
,loca_id_sect  numeric (22,0)
,opeitm_unit_id_case_pur  numeric (38,0)
,chrg_person_id  numeric (22,0)
,opeitm_unit_id_prdpurshp_pur  numeric (38,0)
,shelfno_loca_id_shelfno_pur  numeric (38,0)
,opeitm_itm_id_pur  numeric (38,0)
,opeitm_loca_id_pur  numeric (38,0)
,loca_prfct_pur  varchar (20) 
,loca_addr1_pur  varchar (50) 
,loca_addr2_pur  varchar (50) 
,loca_zip_pur  varchar (10) 
,loca_abbr_pur  varchar (50) 
,loca_addr1_shelfno_pur  varchar (50) 
,loca_prfct_shelfno_pur  varchar (20) 
,loca_country_shelfno_pur  varchar (20) 
,loca_addr2_shelfno_pur  varchar (50) 
,loca_abbr_shelfno_pur  varchar (50) 
,loca_fax_shelfno_pur  varchar (20) 
,loca_zip_shelfno_pur  varchar (10) 
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
 CREATE INDEX sio_r_purords_uk1 
  ON sio.sio_r_purords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purords_seq ;
 create sequence sio.sio_r_purords_seq ;
