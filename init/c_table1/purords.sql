
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
purord.opeitms_id   purord_opeitm_id,
purord.opt_fixoterm  purord_opt_fixoterm,
purord.processseq_pare  purord_processseq_pare,
purord.qty_case  purord_qty_case,
purord.contract_price  purord_contract_price,
purord.chrgs_id   purord_chrg_id,
purord.itm_code_client  purord_itm_code_client,
  loca_to.loca_country  loca_country_to ,
  loca_to.loca_abbr  loca_abbr_to ,
purord.duedate  purord_duedate,
purord.sno  purord_sno,
purord.remark  purord_remark,
purord.price  purord_price,
purord.qty  purord_qty,
purord.confirm  purord_confirm,
purord.amt  purord_amt,
purord.tax  purord_tax,
purord.gno  purord_gno,
  opeitm.opeitm_prjalloc_flg  opeitm_prjalloc_flg ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  prjno.prjno_code  prjno_code ,
  loca_to.loca_prfct  loca_prfct_to ,
  loca_to.loca_tel  loca_tel_to ,
  loca_to.loca_mail  loca_mail_to ,
  loca_to.loca_addr1  loca_addr1_to ,
  loca_to.loca_zip  loca_zip_to ,
  loca_to.loca_fax  loca_fax_to ,
  loca_to.loca_addr2  loca_addr2_to ,
  opeitm.loca_mail_shelfno  loca_mail_shelfno ,
  opeitm.loca_zip_shelfno  loca_zip_shelfno ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.loca_id_shelfno  loca_id_shelfno ,
  prjno.prjno_name  prjno_name ,
  loca_to.loca_name  loca_name_to ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_units_lttime  opeitm_units_lttime ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.unit_code  unit_code ,
  opeitm.unit_name  unit_name ,
  opeitm.opeitm_chkord  opeitm_chkord ,
  opeitm.opeitm_chkinst  opeitm_chkinst ,
  opeitm.opeitm_mold  opeitm_mold ,
  opeitm.opeitm_packno_flg  opeitm_packno_flg ,
  opeitm.opeitm_opt_fix_flg  opeitm_opt_fix_flg ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.opeitm_minqty  opeitm_minqty ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_maxqty  opeitm_maxqty ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.itm_deth  itm_deth ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.opeitm_chkord_prc  opeitm_chkord_prc ,
  opeitm.itm_weight  itm_weight ,
  opeitm.itm_length  itm_length ,
  opeitm.itm_wide  itm_wide ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.opeitm_operation  opeitm_operation ,
  opeitm.opeitm_prdpurshp  opeitm_prdpurshp ,
  opeitm.opeitm_autoord_p  opeitm_autoord_p ,
  opeitm.opeitm_duration  opeitm_duration ,
  opeitm.opeitm_esttosch  opeitm_esttosch ,
  opeitm.itm_model  itm_model ,
  opeitm.itm_design  itm_design ,
  opeitm.loca_prfct  loca_prfct ,
  opeitm.loca_addr1  loca_addr1 ,
  opeitm.loca_addr2  loca_addr2 ,
  opeitm.loca_zip  loca_zip ,
  opeitm.boxe_boxtype  boxe_boxtype ,
  opeitm.loca_abbr  loca_abbr ,
  opeitm.loca_addr1_shelfno  loca_addr1_shelfno ,
  opeitm.boxe_name  boxe_name ,
  opeitm.boxe_code  boxe_code ,
  opeitm.loca_name  loca_name ,
  opeitm.opeitm_autoact_p  opeitm_autoact_p ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.opeitm_safestkqty  opeitm_safestkqty ,
  opeitm.opeitm_contents  opeitm_contents ,
  opeitm.itm_material  itm_material ,
  opeitm.itm_std  itm_std ,
  opeitm.itm_name  itm_name ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_prfct_shelfno  loca_prfct_shelfno ,
  opeitm.loca_country_shelfno  loca_country_shelfno ,
  opeitm.loca_addr2_shelfno  loca_addr2_shelfno ,
  opeitm.loca_abbr_shelfno  loca_abbr_shelfno ,
  opeitm.loca_fax_shelfno  loca_fax_shelfno ,
  opeitm.loca_tel_shelfno  loca_tel_shelfno ,
  chrg.chrg_person_id  chrg_person_id ,
  chrg.loca_id_sect  loca_id_sect ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.loca_code_sect  loca_code_sect ,
  chrg.loca_name_sect  loca_name_sect ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  opeitm.itm_code  itm_code ,
  loca_to.loca_code  loca_code_to ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  opeitm.opeitm_opt_fixoterm  opeitm_opt_fixoterm ,
  opeitm.opeitm_autocreate_ord  opeitm_autocreate_ord ,
  opeitm.opeitm_autocreate_inst  opeitm_autocreate_inst ,
  opeitm.opeitm_shuffle_flg  opeitm_shuffle_flg ,
  opeitm.opeitm_shuffle_loca  opeitm_shuffle_loca ,
  opeitm.opeitm_autocreate_act  opeitm_autocreate_act ,
  opeitm.opeitm_rule_price  opeitm_rule_price ,
  opeitm.opeitm_stktaking_f  opeitm_stktaking_f 
 from purords   purord,
  r_persons  person_upd ,  r_locas  loca_to ,  r_prjnos  prjno ,  r_opeitms  opeitm ,  r_chrgs  chrg 
  where       purord.persons_id_upd = person_upd.id      and purord.locas_id_to = loca_to.id      and purord.prjnos_id = prjno.id      and purord.opeitms_id = opeitm.id      and purord.chrgs_id = chrg.id     ;
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
,itm_name  varchar (100) 
,itm_code  varchar (50) 
,loca_code  varchar (50) 
,purord_qty  numeric (18,4)
,loca_name  varchar (100) 
,purord_duedate   timestamp(6) 
,purord_amt  numeric (18,4)
,purord_price  numeric (38,4)
,purord_tax  numeric (38,4)
,purord_gno  varchar (40) 
,itm_std  varchar (50) 
,opeitm_autoact_p  numeric (3,0)
,itm_material  varchar (50) 
,opeitm_operation  varchar (40) 
,opeitm_prdpurshp  varchar (5) 
,opeitm_autoord_p  numeric (3,0)
,opeitm_duration  numeric (38,2)
,opeitm_safestkqty  numeric (38,0)
,opeitm_contents  varchar (4000) 
,purord_contract_price  varchar (1) 
,purord_starttime   timestamp(6) 
,purord_opt_fixoterm  numeric (5,2)
,purord_processseq_pare  numeric (38,0)
,purord_qty_case  numeric (38,0)
,purord_itm_code_client  varchar (50) 
,purord_remark  varchar (4000) 
,opeitm_processseq  numeric (3,0)
,purord_toduedate   timestamp(6) 
,purord_isudate   timestamp(6) 
,purord_expiredate   date 
,opeitm_priority  numeric (3,0)
,opeitm_chkord  varchar (1) 
,opeitm_chkinst  varchar (1) 
,opeitm_mold  varchar (1) 
,opeitm_packno_flg  varchar (1) 
,loca_code_to  varchar (50) 
,loca_name_to  varchar (100) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_esttosch  numeric (22,0)
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_chkord_prc  numeric (3,0)
,opeitm_shuffle_flg  varchar (1) 
,itm_deth  numeric (22,0)
,opeitm_shuffle_loca  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_rule_price  varchar (1) 
,itm_wide  numeric (22,0)
,boxe_boxtype  varchar (20) 
,itm_design  varchar (50) 
,itm_model  varchar (50) 
,itm_length  numeric (22,0)
,itm_weight  numeric (22,0)
,opeitm_minqty  numeric (38,6)
,loca_abbr_to  varchar (50) 
,loca_country_to  varchar (20) 
,opeitm_stktaking_f  varchar (1) 
,opeitm_maxqty  numeric (22,0)
,opeitm_packqty  numeric (38,0)
,loca_prfct_to  varchar (20) 
,loca_tel_to  varchar (20) 
,loca_mail_to  varchar (20) 
,loca_addr1_to  varchar (50) 
,loca_zip_to  varchar (10) 
,loca_fax_to  varchar (20) 
,loca_addr2_to  varchar (50) 
,opeitm_opt_fixoterm  numeric (5,2)
,loca_code_sect  varchar (50) 
,opeitm_prjalloc_flg  numeric (22,0)
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,loca_name_sect  varchar (100) 
,person_name_chrg  varchar (100) 
,person_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,opeitm_units_lttime  varchar (4) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_outbox  varchar (100) 
,boxe_name  varchar (100) 
,boxe_code  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,shelfno_name  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,shelfno_code  varchar (50) 
,purord_id  numeric (38,0)
,id  numeric (38,0)
,purord_updated_at   timestamp(6) 
,purord_created_at   timestamp(6) 
,purord_update_ip  varchar (40) 
,purord_chrg_id  numeric (38,0)
,purord_opeitm_id  numeric (38,0)
,purord_prjno_id  numeric (38,0)
,purord_loca_id_to  numeric (38,0)
,purord_person_id_upd  numeric (38,0)
,loca_addr2_shelfno  varchar (50) 
,loca_abbr_shelfno  varchar (50) 
,loca_fax_shelfno  varchar (20) 
,loca_tel_shelfno  varchar (20) 
,chrg_person_id  numeric (22,0)
,loca_id_sect  numeric (22,0)
,loca_addr1_shelfno  varchar (50) 
,loca_abbr  varchar (50) 
,loca_addr2  varchar (50) 
,loca_prfct  varchar (20) 
,opeitm_unit_id_prdpurshp  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,loca_mail_shelfno  varchar (20) 
,loca_zip  varchar (10) 
,opeitm_itm_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,loca_addr1  varchar (50) 
,opeitm_unit_id_case  numeric (38,0)
,loca_id_shelfno  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,loca_zip_shelfno  varchar (10) 
,loca_prfct_shelfno  varchar (20) 
,loca_country_shelfno  varchar (20) 
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
