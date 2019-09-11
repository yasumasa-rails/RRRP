
 create table acpschs (
 id numeric(38,0 ) ,
 contents varchar(4000) ,
 isudate timestamp(6),
 locas_id_to numeric(38,0 ) ,
 processseq_pare numeric(38,0 ) ,
 acpdate timestamp(6),
 qty numeric(18,4 ) ,
 price numeric(38,4 ) ,
 amt numeric(18,4 ) ,
 tax numeric(38,4 ) ,
 updated_at timestamp(6),
 sno varchar(40) ,
 manual char(1) ,
 expiredate date,
 persons_id_upd numeric(38,0 ) ,
 created_at timestamp(6),
 update_ip varchar(40) ,
 remark varchar(4000) ,
 prjnos_id numeric(38,0 ) ,
 opeitms_id numeric(38,0 ) ,
  CONSTRAINT acpschs_id_pk PRIMARY KEY (id));
 create table alloctbls (
 id numeric(38,0 ) ,
 srctblname varchar(30) ,
 srctblid numeric(38,0 ) ,
 destblname varchar(30) ,
 destblid numeric(38,0 ) ,
 qty numeric(18,4 ) ,
 qty_stk numeric(38,4 ) ,
 packqty numeric(18,2 ) ,
 amt numeric(18,4 ) ,
 shuffle_flg char(1) ,
 allocfree varchar(30) ,
 allocfreeid numeric(38,0 ) ,
 shuffle_loca char(1) ,
 contents varchar(4000) ,
 remark varchar(4000) ,
 persons_id_upd numeric(38,0 ) ,
 updated_at timestamp(6),
 expiredate date,
 update_ip varchar(40) ,
 created_at timestamp(6),
  CONSTRAINT alloctbls_id_pk PRIMARY KEY (id));
 ALTER TABLE acpschs ADD CONSTRAINT acpsch_locas_id_to FOREIGN KEY (locas_id_to) REFERENCES locas (id);
 ALTER TABLE acpschs ADD CONSTRAINT acpsch_persons_id_upd FOREIGN KEY (persons_id_upd) REFERENCES persons (id);
 ALTER TABLE acpschs ADD CONSTRAINT acpsch_prjnos_id FOREIGN KEY (prjnos_id) REFERENCES prjnos (id);
 ALTER TABLE acpschs ADD CONSTRAINT acpsch_opeitms_id FOREIGN KEY (opeitms_id) REFERENCES opeitms (id);
 ALTER TABLE alloctbls ADD CONSTRAINT alloctbl_persons_id_upd FOREIGN KEY (persons_id_upd) REFERENCES persons (id);
 create sequence acpschs_seq ;
 DROP TABLE IF EXISTS sio.sio_r_acpschs;
 CREATE TABLE sio.sio_r_acpschs (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_acpschs_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
 CREATE INDEX sio_r_acpschs_uk1 
  ON sio.sio_r_acpschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_acpschs_seq ;
 create sequence sio.sio_r_acpschs_seq ;
 ALTER TABLE acpschs ADD CONSTRAINT acpsch_locas_id_to FOREIGN KEY (locas_id_to) REFERENCES locas (id);
 ALTER TABLE acpschs ADD CONSTRAINT acpsch_persons_id_upd FOREIGN KEY (persons_id_upd) REFERENCES persons (id);
 ALTER TABLE acpschs ADD CONSTRAINT acpsch_prjnos_id FOREIGN KEY (prjnos_id) REFERENCES prjnos (id);
 ALTER TABLE acpschs ADD CONSTRAINT acpsch_opeitms_id FOREIGN KEY (opeitms_id) REFERENCES opeitms (id);
 ALTER TABLE alloctbls ADD CONSTRAINT alloctbl_persons_id_upd FOREIGN KEY (persons_id_upd) REFERENCES persons (id);
 create sequence alloctbls_seq ;
 --- drop view r_alloctbls cascade  
 create or replace view r_alloctbls as select  
alloctbl.packqty  alloctbl_packqty,
alloctbl.remark  alloctbl_remark,
alloctbl.created_at  alloctbl_created_at,
alloctbl.update_ip  alloctbl_update_ip,
alloctbl.amt  alloctbl_amt,
alloctbl.expiredate  alloctbl_expiredate,
alloctbl.updated_at  alloctbl_updated_at,
alloctbl.qty  alloctbl_qty,
alloctbl.id id,
alloctbl.id  alloctbl_id,
alloctbl.persons_id_upd   alloctbl_person_id_upd,
alloctbl.contents  alloctbl_contents,
alloctbl.qty_stk  alloctbl_qty_stk,
alloctbl.srctblname  alloctbl_srctblname,
alloctbl.destblname  alloctbl_destblname,
alloctbl.srctblid  alloctbl_srctblid,
alloctbl.destblid  alloctbl_destblid,
alloctbl.shuffle_flg  alloctbl_shuffle_flg,
alloctbl.shuffle_loca  alloctbl_shuffle_loca,
alloctbl.allocfree  alloctbl_allocfree,
alloctbl.allocfreeid  alloctbl_allocfreeid,
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
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code  prjno_code ,
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
  opeitm.opeitm_opt_fix_flg  opeitm_opt_fix_flg ,
  opeitm.opeitm_packno_flg  opeitm_packno_flg ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.opeitm_units_lttime  opeitm_units_lttime ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
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
  opeitm.opeitm_chkord_prc  opeitm_chkord_prc ,
  opeitm.opeitm_esttosch  opeitm_esttosch ,
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
  opeitm.itm_length  itm_length ,
  opeitm.itm_weight  itm_weight ,
  opeitm.opeitm_prdpurshp  opeitm_prdpurshp ,
  opeitm.opeitm_autoord_p  opeitm_autoord_p ,
  opeitm.itm_wide  itm_wide ,
  opeitm.opeitm_duration  opeitm_duration ,
  opeitm.opeitm_safestkqty  opeitm_safestkqty ,
  opeitm.opeitm_contents  opeitm_contents ,
  opeitm.itm_name  itm_name ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_code  itm_code ,
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
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_abbr_shelfno  loca_abbr_shelfno ,
  opeitm.loca_country_shelfno  loca_country_shelfno ,
  opeitm.loca_prfct_shelfno  loca_prfct_shelfno ,
  opeitm.loca_addr1_shelfno  loca_addr1_shelfno ,
  opeitm.loca_addr2_shelfno  loca_addr2_shelfno ,
  opeitm.loca_tel_shelfno  loca_tel_shelfno ,
  opeitm.loca_fax_shelfno  loca_fax_shelfno 
 from alloctbls   alloctbl,
  r_persons  person_upd 
  where       alloctbl.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_alloctbls;
 CREATE TABLE sio.sio_r_alloctbls (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_alloctbls_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,unit_code_case  varchar (50) 
,unit_name  varchar (100) 
,itm_code  varchar (50) 
,unit_code  varchar (50) 
,loca_name  varchar (100) 
,loca_code  varchar (50) 
,loca_name_to  varchar (100) 
,prjno_code_chil  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code  varchar (50) 
,loca_name_shelfno  varchar (100) 
,unit_name_case  varchar (100) 
,shelfno_code  varchar (50) 
,itm_name  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,boxe_code  varchar (50) 
,shelfno_name  varchar (100) 
,loca_code_to  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,loca_code_shelfno  varchar (50) 
,boxe_name  varchar (100) 
,alloctbl_contents  varchar (4000) 
,alloctbl_srctblname  varchar (30) 
,alloctbl_destblname  varchar (30) 
,alloctbl_srctblid  numeric (38,0)
,alloctbl_destblid  numeric (38,0)
,alloctbl_shuffle_flg  varchar (1) 
,alloctbl_shuffle_loca  varchar (1) 
,alloctbl_allocfree  varchar (30) 
,alloctbl_allocfreeid  numeric (38,0)
,alloctbl_remark  varchar (4000) 
,alloctbl_amt  numeric (18,4)
,alloctbl_expiredate   date 
,alloctbl_qty  numeric (18,4)
,alloctbl_packqty  numeric (18,2)
,alloctbl_qty_stk  numeric (38,4)
,opeitm_prdpurshp  varchar (20) 
,loca_country_to  varchar (20) 
,loca_abbr_to  varchar (50) 
,loca_prfct_to  varchar (20) 
,loca_tel_to  varchar (20) 
,loca_mail_to  varchar (20) 
,loca_addr1_to  varchar (50) 
,loca_zip_to  varchar (10) 
,loca_fax_to  varchar (20) 
,loca_addr2_to  varchar (50) 
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_processseq  numeric (3,0)
,opeitm_priority  numeric (3,0)
,opeitm_chkord  varchar (1) 
,opeitm_chkinst  varchar (1) 
,opeitm_mold  varchar (1) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_packno_flg  varchar (1) 
,opeitm_units_lttime  varchar (4) 
,opeitm_minqty  numeric (38,6)
,opeitm_packqty  numeric (38,0)
,opeitm_maxqty  numeric (22,0)
,itm_deth  numeric (22,0)
,opeitm_chkord_prc  numeric (3,0)
,opeitm_esttosch  numeric (22,0)
,opeitm_operation  varchar (20) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_shuffle_flg  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_rule_price  varchar (1) 
,opeitm_stktaking_f  varchar (1) 
,itm_length  numeric (22,0)
,itm_weight  numeric (22,0)
,opeitm_autoord_p  numeric (3,0)
,itm_wide  numeric (22,0)
,opeitm_duration  numeric (38,2)
,opeitm_safestkqty  numeric (38,0)
,opeitm_contents  varchar (4000) 
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,itm_design  varchar (50) 
,itm_material  varchar (50) 
,boxe_boxtype  varchar (20) 
,id  numeric (38,0)
,alloctbl_created_at   timestamp(6) 
,alloctbl_person_id_upd  numeric (38,0)
,alloctbl_update_ip  varchar (40) 
,alloctbl_updated_at   timestamp(6) 
,alloctbl_id  numeric (38,0)
,loca_country_shelfno  varchar (20) 
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,loca_prfct_shelfno  varchar (20) 
,loca_addr1_shelfno  varchar (50) 
,loca_addr2_shelfno  varchar (50) 
,loca_tel_shelfno  varchar (20) 
,loca_prfct  varchar (20) 
,loca_addr1  varchar (50) 
,loca_id_shelfno  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,loca_zip_shelfno  varchar (10) 
,loca_addr2  varchar (50) 
,loca_zip  varchar (10) 
,loca_fax_shelfno  varchar (20) 
,loca_mail_shelfno  varchar (20) 
,loca_abbr  varchar (50) 
,loca_abbr_shelfno  varchar (50) 
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
 CREATE INDEX sio_r_alloctbls_uk1 
  ON sio.sio_r_alloctbls(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_alloctbls_seq ;
 create sequence sio.sio_r_alloctbls_seq ;
