
 --- drop view r_prdords cascade  
 create or replace view r_prdords as select  
  opeitm_prd.opeitm_loca_id  opeitm_loca_id_prd ,
prdord.sno  prdord_sno,
  opeitm_prd.itm_material  itm_material_prd ,
prdord.isudate  prdord_isudate,
prdord.duedate  prdord_duedate,
  opeitm_prd.opeitm_autoord_p  opeitm_autoord_p_prd ,
prdord.qty_case  prdord_qty_case,
  opeitm_prd.opeitm_autoinst_p  opeitm_autoinst_p_prd ,
  loca_to.loca_code  loca_code_to ,
prdord.opeitms_id   prdord_opeitm_id,
prdord.autoinst_p  prdord_autoinst_p,
prdord.autoact_p  prdord_autoact_p,
  opeitm.opeitm_autoinst_p  opeitm_autoinst_p ,
  opeitm.unit_contents  unit_contents ,
  opeitm.classlist_name  classlist_name ,
  opeitm.classlist_contents  classlist_contents ,
  opeitm.classlist_code  classlist_code ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.loca_mail_shelfno  loca_mail_shelfno ,
  opeitm.loca_zip_shelfno  loca_zip_shelfno ,
  opeitm.opeitm_prjalloc_flg  opeitm_prjalloc_flg ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.loca_id_shelfno  loca_id_shelfno ,
  opeitm.opeitm_chkord  opeitm_chkord ,
  opeitm.opeitm_chkinst  opeitm_chkinst ,
  opeitm.opeitm_mold  opeitm_mold ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_packno_flg  opeitm_packno_flg ,
  opeitm.opeitm_opt_fix_flg  opeitm_opt_fix_flg ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.unit_name  unit_name ,
  opeitm.opeitm_units_lttime  opeitm_units_lttime ,
  opeitm.unit_code  unit_code ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.opeitm_minqty  opeitm_minqty ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_maxqty  opeitm_maxqty ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.itm_deth  itm_deth ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.opeitm_esttosch  opeitm_esttosch ,
  opeitm.opeitm_chkord_prc  opeitm_chkord_prc ,
  opeitm.opeitm_operation  opeitm_operation ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  opeitm.opeitm_opt_fixoterm  opeitm_opt_fixoterm ,
  opeitm.opeitm_autocreate_ord  opeitm_autocreate_ord ,
  opeitm.opeitm_autocreate_inst  opeitm_autocreate_inst ,
  opeitm.opeitm_shuffle_flg  opeitm_shuffle_flg ,
  opeitm.opeitm_shuffle_loca  opeitm_shuffle_loca ,
  opeitm.opeitm_autocreate_act  opeitm_autocreate_act ,
  opeitm.opeitm_rule_price  opeitm_rule_price ,
  opeitm.opeitm_stktaking_f  opeitm_stktaking_f ,
  opeitm.boxe_code  boxe_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.opeitm_contents  opeitm_contents ,
  opeitm.loca_name  loca_name ,
  opeitm.loca_code  loca_code ,
  opeitm.itm_std  itm_std ,
  opeitm.itm_model  itm_model ,
  opeitm.itm_design  itm_design ,
  opeitm.itm_material  itm_material ,
  opeitm.boxe_name  boxe_name ,
  opeitm.loca_prfct  loca_prfct ,
  opeitm.loca_addr1  loca_addr1 ,
  opeitm.loca_addr2  loca_addr2 ,
  opeitm.loca_zip  loca_zip ,
  opeitm.boxe_boxtype  boxe_boxtype ,
  opeitm.loca_abbr  loca_abbr ,
  opeitm.loca_addr1_shelfno  loca_addr1_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_prfct_shelfno  loca_prfct_shelfno ,
  opeitm.loca_country_shelfno  loca_country_shelfno ,
  opeitm.loca_addr2_shelfno  loca_addr2_shelfno ,
  opeitm.loca_abbr_shelfno  loca_abbr_shelfno ,
  opeitm.loca_fax_shelfno  loca_fax_shelfno ,
  opeitm.loca_tel_shelfno  loca_tel_shelfno ,
  opeitm.itm_length  itm_length ,
  opeitm.itm_weight  itm_weight ,
  opeitm.opeitm_prdpurshp  opeitm_prdpurshp ,
  opeitm.opeitm_autoord_p  opeitm_autoord_p ,
  opeitm.itm_wide  itm_wide ,
  opeitm.opeitm_duration  opeitm_duration ,
  opeitm.opeitm_safestkqty  opeitm_safestkqty ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.opeitm_autoact_p  opeitm_autoact_p ,
prdord.persons_id_upd   prdord_person_id_upd,
prdord.qty  prdord_qty,
  opeitm_prd.opeitm_priority  opeitm_priority_prd ,
prdord.locas_id_to   prdord_loca_id_to,
prdord.confirm  prdord_confirm,
prdord.remark  prdord_remark,
prdord.created_at  prdord_created_at,
prdord.update_ip  prdord_update_ip,
prdord.toduedate  prdord_toduedate,
prdord.expiredate  prdord_expiredate,
prdord.consumtype  prdord_consumtype,
prdord.updated_at  prdord_updated_at,
prdord.id id,
prdord.id  prdord_id,
prdord.starttime  prdord_starttime,
prdord.prjnos_id   prdord_prjno_id,
prdord.opt_fixoterm  prdord_opt_fixoterm,
prdord.autocreate_inst  prdord_autocreate_inst,
prdord.processseq_pare  prdord_processseq_pare,
prdord.autocreate_act  prdord_autocreate_act,
prdord.gno  prdord_gno,
prdord.chrgs_id   prdord_chrg_id,
prdord.opeitms_id_prd   prdord_opeitm_id_prd,
  loca_to.loca_country  loca_country_to ,
  loca_to.loca_abbr  loca_abbr_to ,
  loca_to.loca_prfct  loca_prfct_to ,
  loca_to.loca_tel  loca_tel_to ,
  loca_to.loca_mail  loca_mail_to ,
  loca_to.loca_addr1  loca_addr1_to ,
  loca_to.loca_zip  loca_zip_to ,
  loca_to.loca_fax  loca_fax_to ,
  loca_to.loca_addr2  loca_addr2_to ,
  opeitm_prd.loca_mail_shelfno  loca_mail_shelfno_prd ,
  opeitm_prd.loca_zip_shelfno  loca_zip_shelfno_prd ,
  opeitm_prd.opeitm_prjalloc_flg  opeitm_prjalloc_flg_prd ,
  opeitm_prd.opeitm_shelfno_id  opeitm_shelfno_id_prd ,
  opeitm_prd.loca_id_shelfno  loca_id_shelfno_prd ,
  opeitm_prd.opeitm_processseq  opeitm_processseq_prd ,
  loca_to.loca_name  loca_name_to ,
  opeitm_prd.loca_name_shelfno  loca_name_shelfno_prd ,
  opeitm_prd.opeitm_maxqty  opeitm_maxqty_prd ,
  opeitm_prd.opeitm_chkord  opeitm_chkord_prd ,
  opeitm_prd.opeitm_chkinst  opeitm_chkinst_prd ,
  opeitm_prd.opeitm_mold  opeitm_mold_prd ,
  opeitm_prd.opeitm_boxe_id  opeitm_boxe_id_prd ,
  opeitm_prd.opeitm_packno_flg  opeitm_packno_flg_prd ,
  opeitm_prd.opeitm_opt_fix_flg  opeitm_opt_fix_flg_prd ,
  opeitm_prd.opeitm_unit_id_case  opeitm_unit_id_case_prd ,
  opeitm_prd.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_prd ,
  opeitm_prd.opeitm_esttosch  opeitm_esttosch_prd ,
  opeitm_prd.opeitm_packqty  opeitm_packqty_prd ,
  opeitm_prd.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp_prd ,
  opeitm_prd.opeitm_minqty  opeitm_minqty_prd ,
  opeitm_prd.itm_deth  itm_deth_prd ,
  opeitm_prd.unit_code_case  unit_code_case_prd ,
  opeitm_prd.unit_name  unit_name_prd ,
  opeitm_prd.unit_name_case  unit_name_case_prd ,
  opeitm_prd.unit_code_prdpurshp  unit_code_prdpurshp_prd ,
  opeitm_prd.unit_name_outbox  unit_name_outbox_prd ,
  opeitm_prd.unit_code_outbox  unit_code_outbox_prd ,
  opeitm_prd.unit_code_box  unit_code_box_prd ,
  opeitm_prd.unit_name_box  unit_name_box_prd ,
  opeitm_prd.unit_name_prdpurshp  unit_name_prdpurshp_prd ,
  opeitm_prd.opeitm_units_lttime  opeitm_units_lttime_prd ,
  opeitm_prd.unit_code  unit_code_prd ,
  opeitm_prd.opeitm_chkord_prc  opeitm_chkord_prc_prd ,
  opeitm_prd.opeitm_itm_id  opeitm_itm_id_prd ,
  opeitm_prd.opeitm_opt_fixoterm  opeitm_opt_fixoterm_prd ,
  opeitm_prd.opeitm_autocreate_ord  opeitm_autocreate_ord_prd ,
  opeitm_prd.opeitm_autocreate_inst  opeitm_autocreate_inst_prd ,
  opeitm_prd.opeitm_shuffle_flg  opeitm_shuffle_flg_prd ,
  opeitm_prd.opeitm_shuffle_loca  opeitm_shuffle_loca_prd ,
  opeitm_prd.opeitm_autocreate_act  opeitm_autocreate_act_prd ,
  opeitm_prd.opeitm_rule_price  opeitm_rule_price_prd ,
  opeitm_prd.opeitm_stktaking_f  opeitm_stktaking_f_prd ,
  opeitm_prd.boxe_code  boxe_code_prd ,
  opeitm_prd.shelfno_name  shelfno_name_prd ,
  opeitm_prd.shelfno_code  shelfno_code_prd ,
  opeitm_prd.opeitm_prdpurshp  opeitm_prdpurshp_prd ,
  opeitm_prd.opeitm_duration  opeitm_duration_prd ,
  opeitm_prd.opeitm_contents  opeitm_contents_prd ,
  opeitm_prd.itm_name  itm_name_prd ,
  opeitm_prd.opeitm_safestkqty  opeitm_safestkqty_prd ,
  opeitm_prd.itm_length  itm_length_prd ,
  opeitm_prd.itm_wide  itm_wide_prd ,
  opeitm_prd.itm_weight  itm_weight_prd ,
  opeitm_prd.opeitm_operation  opeitm_operation_prd ,
  opeitm_prd.loca_code_shelfno  loca_code_shelfno_prd ,
  opeitm_prd.itm_std  itm_std_prd ,
  opeitm_prd.boxe_name  boxe_name_prd ,
  opeitm_prd.loca_prfct  loca_prfct_prd ,
  opeitm_prd.loca_addr1  loca_addr1_prd ,
  opeitm_prd.loca_addr2  loca_addr2_prd ,
  opeitm_prd.loca_zip  loca_zip_prd ,
  opeitm_prd.boxe_boxtype  boxe_boxtype_prd ,
  opeitm_prd.loca_abbr  loca_abbr_prd ,
  opeitm_prd.loca_addr1_shelfno  loca_addr1_shelfno_prd ,
  opeitm_prd.loca_prfct_shelfno  loca_prfct_shelfno_prd ,
  opeitm_prd.loca_country_shelfno  loca_country_shelfno_prd ,
  opeitm_prd.loca_addr2_shelfno  loca_addr2_shelfno_prd ,
  opeitm_prd.loca_abbr_shelfno  loca_abbr_shelfno_prd ,
  opeitm_prd.loca_fax_shelfno  loca_fax_shelfno_prd ,
  opeitm_prd.itm_model  itm_model_prd ,
  opeitm_prd.itm_design  itm_design_prd ,
  opeitm_prd.loca_code  loca_code_prd ,
  opeitm_prd.loca_name  loca_name_prd ,
  opeitm_prd.itm_code  itm_code_prd ,
  chrg.person_code_chrg  person_code_chrg ,
  opeitm_prd.loca_tel_shelfno  loca_tel_shelfno_prd ,
  chrg.chrg_person_id  chrg_person_id ,
  chrg.loca_id_sect  loca_id_sect ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  prjno.prjno_code_chil  prjno_code_chil ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.loca_name_sect  loca_name_sect ,
  chrg.loca_code_sect  loca_code_sect ,
  prjno.prjno_code  prjno_code ,
  prjno.prjno_name  prjno_name 
 from prdords   prdord,
  r_opeitms  opeitm ,  r_persons  person_upd ,  r_locas  loca_to ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_opeitms  opeitm_prd 
  where       prdord.opeitms_id = opeitm.id      and prdord.persons_id_upd = person_upd.id      and prdord.locas_id_to = loca_to.id      and prdord.prjnos_id = prjno.id      and prdord.chrgs_id = chrg.id      and prdord.opeitms_id_prd = opeitm_prd.id     ;
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
,prdord_sno  varchar (40) 
,prdord_isudate   timestamp(6) 
,itm_code_prd  varchar (50) 
,prdord_qty  numeric (18,4)
,prdord_duedate   timestamp(6) 
,itm_name_prd  varchar (100) 
,opeitm_processseq_prd  numeric (3,0)
,opeitm_priority_prd  numeric (3,0)
,itm_std_prd  varchar (50) 
,itm_model_prd  varchar (50) 
,itm_design_prd  varchar (50) 
,itm_material_prd  varchar (50) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,itm_deth_prd  numeric (22,0)
,itm_length_prd  numeric (22,0)
,itm_wide_prd  numeric (22,0)
,itm_weight_prd  numeric (22,0)
,loca_code_prd  varchar (50) 
,loca_name_prd  varchar (100) 
,loca_code_to  varchar (50) 
,loca_name_to  varchar (100) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,loca_code_sect  varchar (50) 
,loca_name_sect  varchar (100) 
,prdord_gno  varchar (40) 
,unit_code_prdpurshp_prd  varchar (50) 
,unit_name_prdpurshp_prd  varchar (100) 
,unit_code_prd  varchar (50) 
,unit_name_prd  varchar (100) 
,unit_code_case_prd  varchar (50) 
,unit_name_case_prd  varchar (100) 
,unit_code_outbox_prd  varchar (50) 
,unit_name_outbox_prd  varchar (100) 
,opeitm_units_lttime_prd  varchar (4) 
,opeitm_minqty_prd  numeric (38,6)
,opeitm_maxqty_prd  numeric (22,0)
,opeitm_packqty_prd  numeric (38,0)
,opeitm_safestkqty_prd  numeric (38,0)
,shelfno_code_prd  varchar (50) 
,unit_code  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_outbox  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,itm_name  varchar (100) 
,itm_code  varchar (50) 
,classlist_code  varchar (50) 
,boxe_code_prd  varchar (50) 
,unit_name_box_prd  varchar (100) 
,unit_code_box_prd  varchar (50) 
,loca_name_shelfno  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,unit_code_case  varchar (50) 
,prjno_code_chil  varchar (50) 
,boxe_code  varchar (50) 
,shelfno_name  varchar (100) 
,shelfno_code  varchar (50) 
,loca_name  varchar (100) 
,loca_code  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,unit_name_case  varchar (100) 
,unit_name  varchar (100) 
,boxe_name  varchar (100) 
,boxe_name_prd  varchar (100) 
,classlist_name  varchar (100) 
,loca_code_shelfno  varchar (50) 
,shelfno_name_prd  varchar (100) 
,loca_code_shelfno_prd  varchar (50) 
,loca_name_shelfno_prd  varchar (100) 
,prdord_autoact_p  numeric (3,0)
,prdord_consumtype  varchar (3) 
,prdord_processseq_pare  numeric (38,0)
,prdord_autocreate_inst  varchar (1) 
,prdord_expiredate   date 
,prdord_qty_case  numeric (38,0)
,prdord_opt_fixoterm  numeric (5,2)
,prdord_toduedate   timestamp(6) 
,prdord_autocreate_act  varchar (1) 
,prdord_starttime   timestamp(6) 
,prdord_remark  varchar (4000) 
,prdord_autoinst_p  numeric (3,0)
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_autoord_p_prd  numeric (3,0)
,opeitm_autoinst_p_prd  numeric (3,0)
,opeitm_autoinst_p  numeric (3,0)
,unit_contents  varchar (4000) 
,classlist_contents  varchar (4000) 
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_processseq  numeric (3,0)
,opeitm_priority  numeric (3,0)
,opeitm_chkord  varchar (1) 
,opeitm_chkinst  varchar (1) 
,opeitm_mold  varchar (1) 
,opeitm_packno_flg  varchar (1) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_units_lttime  varchar (4) 
,opeitm_minqty  numeric (38,6)
,opeitm_packqty  numeric (38,0)
,opeitm_maxqty  numeric (22,0)
,itm_deth  numeric (22,0)
,opeitm_esttosch  numeric (22,0)
,opeitm_chkord_prc  numeric (3,0)
,opeitm_operation  varchar (20) 
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_shuffle_flg  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_rule_price  varchar (1) 
,opeitm_stktaking_f  varchar (1) 
,opeitm_contents  varchar (4000) 
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,itm_design  varchar (50) 
,itm_material  varchar (50) 
,boxe_boxtype  varchar (20) 
,itm_length  numeric (22,0)
,itm_weight  numeric (22,0)
,opeitm_prdpurshp  varchar (20) 
,opeitm_autoord_p  numeric (3,0)
,itm_wide  numeric (22,0)
,opeitm_duration  numeric (38,2)
,opeitm_safestkqty  numeric (38,0)
,opeitm_autoact_p  numeric (3,0)
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
,opeitm_chkord_prd  varchar (1) 
,opeitm_chkinst_prd  varchar (1) 
,opeitm_mold_prd  varchar (1) 
,opeitm_packno_flg_prd  varchar (1) 
,opeitm_opt_fix_flg_prd  varchar (1) 
,opeitm_esttosch_prd  numeric (22,0)
,opeitm_chkord_prc_prd  numeric (3,0)
,opeitm_opt_fixoterm_prd  numeric (5,2)
,opeitm_autocreate_ord_prd  varchar (1) 
,opeitm_autocreate_inst_prd  varchar (1) 
,opeitm_shuffle_flg_prd  varchar (1) 
,opeitm_shuffle_loca_prd  varchar (1) 
,opeitm_autocreate_act_prd  varchar (1) 
,opeitm_rule_price_prd  varchar (1) 
,opeitm_stktaking_f_prd  varchar (1) 
,opeitm_prdpurshp_prd  varchar (20) 
,opeitm_duration_prd  numeric (38,2)
,opeitm_contents_prd  varchar (4000) 
,opeitm_operation_prd  varchar (20) 
,boxe_boxtype_prd  varchar (20) 
,prdord_loca_id_to  numeric (38,0)
,prdord_person_id_upd  numeric (38,0)
,prdord_opeitm_id  numeric (38,0)
,prdord_update_ip  varchar (40) 
,prdord_created_at   timestamp(6) 
,prdord_opeitm_id_prd  numeric (22,0)
,prdord_chrg_id  numeric (38,0)
,prdord_prjno_id  numeric (38,0)
,prdord_id  numeric (38,0)
,id  numeric (38,0)
,prdord_updated_at   timestamp(6) 
,loca_tel_shelfno  varchar (20) 
,loca_fax_shelfno  varchar (20) 
,loca_id_shelfno  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,loca_zip_shelfno  varchar (10) 
,loca_abbr_shelfno  varchar (50) 
,loca_addr2_shelfno  varchar (50) 
,loca_country_shelfno  varchar (20) 
,loca_prfct_shelfno  varchar (20) 
,loca_addr1_shelfno  varchar (50) 
,loca_mail_shelfno  varchar (20) 
,loca_abbr  varchar (50) 
,loca_zip  varchar (10) 
,loca_addr2  varchar (50) 
,loca_prfct_prd  varchar (20) 
,loca_addr1_prd  varchar (50) 
,loca_addr2_prd  varchar (50) 
,loca_zip_prd  varchar (10) 
,loca_abbr_prd  varchar (50) 
,loca_addr1_shelfno_prd  varchar (50) 
,loca_prfct_shelfno_prd  varchar (20) 
,loca_country_shelfno_prd  varchar (20) 
,loca_addr2_shelfno_prd  varchar (50) 
,loca_abbr_shelfno_prd  varchar (50) 
,loca_fax_shelfno_prd  varchar (20) 
,loca_addr1  varchar (50) 
,loca_prfct  varchar (20) 
,opeitm_unit_id_case_prd  numeric (38,0)
,shelfno_loca_id_shelfno_prd  numeric (38,0)
,opeitm_loca_id_prd  numeric (38,0)
,opeitm_boxe_id_prd  numeric (22,0)
,opeitm_unit_id_prdpurshp_prd  numeric (38,0)
,loca_id_shelfno_prd  numeric (22,0)
,opeitm_shelfno_id_prd  numeric (22,0)
,loca_mail_shelfno_prd  varchar (20) 
,loca_zip_shelfno_prd  varchar (10) 
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id_prd  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,loca_tel_shelfno_prd  varchar (20) 
,chrg_person_id  numeric (22,0)
,loca_id_sect  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
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
