
 create table puracts (
 id numeric(38,0 )   not null  ,
 sno varchar(40)   ,
 sno_inst varchar(40)   ,
 sno_dlv varchar(50)   ,
 isudate timestamp(6)  ,
 rcptdate timestamp(6)  ,
 qty numeric(18,4 )   ,
 qty_case numeric(38,0 )   ,
 price numeric(38,4 )   ,
 amt numeric(18,4 )   ,
 tax numeric(38,4 )   ,
 contract_price char(1)   ,
 cno varchar(40)   ,
 cno_inst varchar(40)   ,
 gno varchar(40)   ,
 itm_code_client varchar(50)   ,
 lotno varchar(50)   ,
 contents varchar(4000)   ,
 remark varchar(4000)   ,
 expiredate date  ,
 chrgs_id numeric(38,0 )   not null ,
 shelfnos_id_act numeric(38,0 )   not null ,
 prjnos_id numeric(38,0 )   not null ,
 locas_id_to numeric(38,0 )   not null ,
 opeitms_id numeric(38,0 )   not null ,
 persons_id_upd numeric(38,0 )   not null ,
 update_ip varchar(40)   ,
 created_at timestamp(6)  ,
 updated_at timestamp(6)  ,
  CONSTRAINT puracts_id_pk PRIMARY KEY (id));
 ALTER TABLE puracts ADD CONSTRAINT puract_chrgs_id FOREIGN KEY (chrgs_id)
																		 REFERENCES chrgs (id);
 ALTER TABLE puracts ADD CONSTRAINT puract_shelfnos_id_act FOREIGN KEY (shelfnos_id_act)
																		 REFERENCES shelfnos (id);
 ALTER TABLE puracts ADD CONSTRAINT puract_prjnos_id FOREIGN KEY (prjnos_id)
																		 REFERENCES prjnos (id);
 ALTER TABLE puracts ADD CONSTRAINT puract_locas_id_to FOREIGN KEY (locas_id_to)
																		 REFERENCES locas (id);
 ALTER TABLE puracts ADD CONSTRAINT puract_opeitms_id FOREIGN KEY (opeitms_id)
																		 REFERENCES opeitms (id);
 ALTER TABLE puracts ADD CONSTRAINT puract_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 create sequence puracts_seq ;
 --- drop view r_puracts cascade  
 create or replace view r_puracts as select  
puract.price  puract_price,
puract.remark  puract_remark,
puract.created_at  puract_created_at,
puract.update_ip  puract_update_ip,
puract.amt  puract_amt,
puract.isudate  puract_isudate,
puract.expiredate  puract_expiredate,
puract.updated_at  puract_updated_at,
puract.qty  puract_qty,
puract.sno  puract_sno,
puract.id id,
puract.id  puract_id,
puract.persons_id_upd   puract_person_id_upd,
puract.contents  puract_contents,
puract.locas_id_to   puract_loca_id_to,
puract.tax  puract_tax,
puract.prjnos_id   puract_prjno_id,
puract.opeitms_id   puract_opeitm_id,
puract.lotno  puract_lotno,
puract.qty_case  puract_qty_case,
puract.cno  puract_cno,
puract.sno_inst  puract_sno_inst,
puract.cno_inst  puract_cno_inst,
puract.rcptdate  puract_rcptdate,
puract.contract_price  puract_contract_price,
puract.gno  puract_gno,
puract.chrgs_id   puract_chrg_id,
puract.itm_code_client  puract_itm_code_client,
puract.shelfnos_id_act   puract_shelfno_id_act,
puract.sno_dlv  puract_sno_dlv,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  chrg.scrlv_level1_chrg  scrlv_level1_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_email_chrg  person_email_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  shelfno_act.shelfno_name  shelfno_name_act ,
  shelfno_act.loca_name_shelfno  loca_name_shelfno_act ,
  shelfno_act.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_act ,
  shelfno_act.loca_id_shelfno  loca_id_shelfno_act ,
  shelfno_act.shelfno_contents  shelfno_contents_act ,
  shelfno_act.shelfno_code  shelfno_code_act ,
  shelfno_act.loca_code_shelfno  loca_code_shelfno_act ,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code  prjno_code ,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_country  loca_country_to ,
  loca_to.loca_abbr  loca_abbr_to ,
  loca_to.loca_prfct  loca_prfct_to ,
  loca_to.loca_tel  loca_tel_to ,
  loca_to.loca_mail  loca_mail_to ,
  loca_to.loca_addr1  loca_addr1_to ,
  loca_to.loca_zip  loca_zip_to ,
  loca_to.loca_fax  loca_fax_to ,
  loca_to.loca_addr2  loca_addr2_to ,
  loca_to.loca_name  loca_name_to ,
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
  opeitm.opeitm_autoact_p  opeitm_autoact_p 
 from puracts   puract,
  r_persons  person_upd ,  r_locas  loca_to ,  r_prjnos  prjno ,  r_opeitms  opeitm ,  r_chrgs  chrg ,  r_shelfnos  shelfno_act 
  where       puract.persons_id_upd = person_upd.id      and puract.locas_id_to = loca_to.id      and puract.prjnos_id = prjno.id      and puract.opeitms_id = opeitm.id      and puract.chrgs_id = chrg.id      and puract.shelfnos_id_act = shelfno_act.id     ;
 DROP TABLE IF EXISTS sio.sio_r_puracts;
 CREATE TABLE sio.sio_r_puracts (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_puracts_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,puract_gno  varchar (40) 
,puract_cno  varchar (40) 
,puract_sno  varchar (40) 
,shelfno_code  varchar (50) 
,loca_name_to  varchar (100) 
,shelfno_name  varchar (100) 
,boxe_code  varchar (50) 
,classlist_name  varchar (100) 
,classlist_code  varchar (50) 
,loca_name_shelfno  varchar (100) 
,unit_code  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,unit_code_box  varchar (50) 
,shelfno_name_act  varchar (100) 
,loca_name_shelfno_act  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,loca_code_shelfno  varchar (50) 
,shelfno_code_act  varchar (50) 
,loca_code_shelfno_act  varchar (50) 
,prjno_code_chil  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code  varchar (50) 
,loca_code_to  varchar (50) 
,boxe_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name  varchar (100) 
,unit_name_case  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,unit_name_box  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,itm_code  varchar (50) 
,person_name_chrg  varchar (100) 
,itm_name  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,person_code_chrg  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,puract_price  numeric (38,4)
,puract_expiredate   date 
,puract_lotno  varchar (50) 
,puract_sno_dlv  varchar (50) 
,puract_amt  numeric (18,4)
,puract_qty_case  numeric (38,0)
,puract_qty  numeric (18,4)
,puract_sno_inst  varchar (40) 
,puract_cno_inst  varchar (40) 
,puract_rcptdate   timestamp(6) 
,puract_contract_price  varchar (1) 
,puract_tax  numeric (38,4)
,puract_isudate   timestamp(6) 
,puract_itm_code_client  varchar (50) 
,opeitm_rule_price  varchar (1) 
,scrlv_level1_chrg  varchar (1) 
,person_email_chrg  varchar (50) 
,shelfno_contents_act  varchar (4000) 
,loca_country_to  varchar (20) 
,loca_abbr_to  varchar (50) 
,loca_prfct_to  varchar (20) 
,loca_tel_to  varchar (20) 
,loca_mail_to  varchar (20) 
,loca_addr1_to  varchar (50) 
,loca_zip_to  varchar (10) 
,loca_fax_to  varchar (20) 
,loca_addr2_to  varchar (50) 
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
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_shuffle_flg  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
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
,puract_contents  varchar (4000) 
,puract_remark  varchar (4000) 
,puract_loca_id_to  numeric (38,0)
,puract_person_id_upd  numeric (38,0)
,puract_update_ip  varchar (40) 
,puract_prjno_id  numeric (38,0)
,puract_id  numeric (38,0)
,id  numeric (38,0)
,puract_shelfno_id_act  numeric (38,0)
,puract_chrg_id  numeric (38,0)
,puract_opeitm_id  numeric (38,0)
,puract_updated_at   timestamp(6) 
,puract_created_at   timestamp(6) 
,loca_abbr_shelfno  varchar (50) 
,loca_zip_shelfno  varchar (10) 
,loca_mail_shelfno  varchar (20) 
,loca_id_shelfno_act  numeric (38,0)
,shelfno_loca_id_shelfno_act  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,loca_zip  varchar (10) 
,loca_fax_shelfno  varchar (20) 
,loca_tel_shelfno  varchar (20) 
,loca_country_shelfno  varchar (20) 
,opeitm_unit_id_prdpurshp  numeric (38,0)
,loca_prfct_shelfno  varchar (20) 
,loca_abbr  varchar (50) 
,loca_addr1_shelfno  varchar (50) 
,shelfno_loca_id_shelfno  numeric (38,0)
,loca_prfct  varchar (20) 
,loca_addr1  varchar (50) 
,loca_addr2  varchar (50) 
,loca_addr2_shelfno  varchar (50) 
,opeitm_boxe_id  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,loca_id_shelfno  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
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
 CREATE INDEX sio_r_puracts_uk1 
  ON sio.sio_r_puracts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_puracts_seq ;
 create sequence sio.sio_r_puracts_seq ;
