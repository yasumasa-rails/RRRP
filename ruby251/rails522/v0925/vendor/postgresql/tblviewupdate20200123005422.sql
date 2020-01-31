
 --- drop view r_nditms cascade  
 create or replace view r_nditms as select  
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.opeitm_prdpurshp  opeitm_prdpurshp ,
nditm.processseq_nditm  nditm_processseq_nditm,
  opeitm.opeitm_opt_fix_flg  opeitm_opt_fix_flg ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.shelfno_name  shelfno_name ,
nditm.consumminqty  nditm_consumminqty,
  opeitm.opeitm_autocreate_ord  opeitm_autocreate_ord ,
  opeitm.opeitm_autoinst_p  opeitm_autoinst_p ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_code_case  unit_code_case ,
  itm_nditm.unit_code  unit_code_nditm ,
  opeitm.unit_code  unit_code ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.unit_name_case  unit_name_case ,
  itm_nditm.unit_name  unit_name_nditm ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  itm_nditm.itm_std  itm_std_nditm ,
  itm_nditm.itm_model  itm_model_nditm ,
  itm_nditm.itm_material  itm_material_nditm ,
  itm_nditm.itm_design  itm_design_nditm ,
  opeitm.itm_design  itm_design ,
  itm_nditm.itm_weight  itm_weight_nditm ,
  itm_nditm.itm_length  itm_length_nditm ,
  itm_nditm.itm_wide  itm_wide_nditm ,
  itm_nditm.itm_deth  itm_deth_nditm ,
  itm_nditm.itm_remark  itm_remark_nditm ,
  itm_nditm.itm_code  itm_code_nditm ,
  opeitm.itm_code  itm_code ,
  itm_nditm.itm_name  itm_name_nditm ,
  opeitm.itm_name  itm_name ,
nditm.consumchgoverqty  nditm_consumchgoverqty,
  opeitm.opeitm_autoact_p  opeitm_autoact_p ,
  opeitm.opeitm_autoord_p  opeitm_autoord_p ,
  loca_fm.loca_abbr  loca_abbr_fm ,
  opeitm.loca_abbr_shelfno  loca_abbr_shelfno ,
  opeitm.loca_abbr  loca_abbr ,
  loca_fm.loca_zip  loca_zip_fm ,
  opeitm.loca_zip_shelfno  loca_zip_shelfno ,
  opeitm.loca_zip  loca_zip ,
  loca_fm.loca_country  loca_country_fm ,
  opeitm.loca_country_shelfno  loca_country_shelfno ,
  opeitm.loca_country  loca_country ,
  loca_fm.loca_prfct  loca_prfct_fm ,
  opeitm.loca_prfct_shelfno  loca_prfct_shelfno ,
  opeitm.loca_prfct  loca_prfct ,
  loca_fm.loca_addr1  loca_addr1_fm ,
  opeitm.loca_addr1_shelfno  loca_addr1_shelfno ,
  opeitm.loca_addr1  loca_addr1 ,
  loca_fm.loca_addr2  loca_addr2_fm ,
  opeitm.loca_addr2_shelfno  loca_addr2_shelfno ,
  opeitm.loca_addr2  loca_addr2 ,
  loca_fm.loca_tel  loca_tel_fm ,
  opeitm.loca_tel_shelfno  loca_tel_shelfno ,
  opeitm.loca_tel  loca_tel ,
  loca_fm.loca_fax  loca_fax_fm ,
  opeitm.loca_fax_shelfno  loca_fax_shelfno ,
  opeitm.loca_fax  loca_fax ,
  loca_fm.loca_mail  loca_mail_fm ,
  opeitm.loca_mail_shelfno  loca_mail_shelfno ,
  opeitm.loca_mail  loca_mail ,
  opeitm.opeitm_remark  opeitm_remark ,
  opeitm.opeitm_duration  opeitm_duration ,
  opeitm.opeitm_units_lttime  opeitm_units_lttime ,
  loca_fm.loca_code  loca_code_fm ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_code  loca_code ,
  loca_fm.loca_name  loca_name_fm ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.loca_name  loca_name ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  opeitm.opeitm_minqty  opeitm_minqty ,
nditm.id id,
nditm.id  nditm_id,
nditm.itms_id_nditm   nditm_itm_id_nditm,
nditm.parenum  nditm_parenum,
nditm.chilnum  nditm_chilnum,
nditm.remark  nditm_remark,
nditm.expiredate  nditm_expiredate,
nditm.persons_id_upd   nditm_person_id_upd,
nditm.update_ip  nditm_update_ip,
nditm.created_at  nditm_created_at,
nditm.updated_at  nditm_updated_at,
nditm.consumunitqty  nditm_consumunitqty,
nditm.opeitms_id   nditm_opeitm_id,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  itm_nditm.itm_unit_id  itm_unit_id_nditm ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_operation  opeitm_operation ,
  opeitm.opeitm_opt_fixoterm  opeitm_opt_fixoterm ,
  itm_nditm.itm_classlist_id  itm_classlist_id_nditm ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  itm_nditm.itm_datascale  itm_datascale_nditm ,
nditm.locas_id_fm   nditm_loca_id_fm,
  opeitm.opeitm_safestkqty  opeitm_safestkqty ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.opeitm_shuffle_flg  opeitm_shuffle_flg ,
  opeitm.opeitm_chkord_prc  opeitm_chkord_prc ,
  opeitm.opeitm_chkord  opeitm_chkord ,
  opeitm.opeitm_autocreate_act  opeitm_autocreate_act ,
  itm_nditm.unit_contents  unit_contents_nditm ,
  opeitm.unit_contents_case  unit_contents_case ,
  opeitm.unit_contents_prdpurshp  unit_contents_prdpurshp ,
  opeitm.opeitm_shuffle_loca  opeitm_shuffle_loca ,
  opeitm.opeitm_esttosch  opeitm_esttosch ,
  opeitm.opeitm_stktaking_proc  opeitm_stktaking_proc ,
  opeitm.opeitm_rule_price  opeitm_rule_price ,
  itm_nditm.classlist_code  classlist_code_nditm ,
  opeitm.classlist_code  classlist_code ,
  opeitm.opeitm_mold  opeitm_mold ,
  opeitm.opeitm_autocreate_inst  opeitm_autocreate_inst ,
  itm_nditm.classlist_name  classlist_name_nditm ,
  opeitm.classlist_name  classlist_name ,
nditm.byproduct  nditm_byproduct,
  opeitm.opeitm_packno_flg  opeitm_packno_flg ,
  opeitm.opeitm_processseq  opeitm_processseq ,
nditm.consumtype  nditm_consumtype,
nditm.contents  nditm_contents,
  opeitm.opeitm_priority  opeitm_priority ,
nditm.consumauto  nditm_consumauto,
  opeitm.opeitm_contents  opeitm_contents ,
  opeitm.shelfno_contents  shelfno_contents ,
  opeitm.opeitm_acceptance_proc  opeitm_acceptance_proc ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.opeitm_chkinst  opeitm_chkinst ,
  opeitm.boxe_boxtype  boxe_boxtype ,
  opeitm.boxe_depth  boxe_depth ,
  opeitm.boxe_wide  boxe_wide ,
  opeitm.boxe_height  boxe_height ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_outdepth  boxe_outdepth ,
  opeitm.boxe_outwide  boxe_outwide ,
  opeitm.boxe_outheight  boxe_outheight ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.boxe_contents  boxe_contents ,
  opeitm.opeitm_maxqty  opeitm_maxqty ,
  opeitm.opeitm_prjalloc_flg  opeitm_prjalloc_flg 
 from nditms   nditm,
  r_itms  itm_nditm ,  r_persons  person_upd ,  r_opeitms  opeitm ,  r_locas  loca_fm 
  where       nditm.itms_id_nditm = itm_nditm.id      and nditm.persons_id_upd = person_upd.id      and nditm.opeitms_id = opeitm.id      and nditm.locas_id_fm = loca_fm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_nditms;
 CREATE TABLE sio.sio_r_nditms (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_nditms_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,opeitm_processseq  numeric (3,0)
,opeitm_priority  numeric (3,0)
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,itm_code_nditm  varchar (50) 
,itm_name_nditm  varchar (100) 
,nditm_processseq_nditm  numeric (38,0)
,nditm_parenum  numeric (38,0)
,nditm_chilnum  numeric (38,0)
,nditm_consumunitqty  numeric (38,0)
,nditm_consumauto  varchar (1) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,classlist_name  varchar (100) 
,classlist_name_nditm  varchar (100) 
,classlist_code  varchar (50) 
,classlist_code_nditm  varchar (50) 
,loca_name_fm  varchar (100) 
,nditm_consumtype  varchar (3) 
,loca_code_fm  varchar (50) 
,nditm_expiredate   date 
,nditm_consumminqty  numeric (22,6)
,nditm_byproduct  varchar (1) 
,nditm_consumchgoverqty  numeric (22,6)
,opeitm_autoord_p  numeric (3,0)
,loca_name_shelfno  varchar (100) 
,loca_code_shelfno  varchar (50) 
,unit_contents_nditm  varchar (4000) 
,opeitm_prdpurshp  varchar (20) 
,shelfno_name  varchar (100) 
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autoinst_p  numeric (3,0)
,itm_material_nditm  varchar (50) 
,itm_design  varchar (50) 
,opeitm_autoact_p  numeric (3,0)
,loca_abbr_fm  varchar (50) 
,loca_zip_fm  varchar (10) 
,loca_country_fm  varchar (20) 
,loca_prfct_fm  varchar (20) 
,loca_addr1_fm  varchar (50) 
,loca_addr2_fm  varchar (50) 
,loca_tel_fm  varchar (20) 
,loca_fax_fm  varchar (20) 
,loca_mail_fm  varchar (20) 
,opeitm_minqty  numeric (38,6)
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_safestkqty  numeric (38,0)
,opeitm_packqty  numeric (38,0)
,opeitm_shuffle_flg  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_stktaking_proc  varchar (1) 
,opeitm_rule_price  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_acceptance_proc  varchar (1) 
,opeitm_maxqty  numeric (22,0)
,shelfno_code  varchar (50) 
,itm_std_nditm  varchar (50) 
,unit_code_nditm  varchar (50) 
,itm_model_nditm  varchar (50) 
,itm_design_nditm  varchar (50) 
,itm_weight_nditm  numeric (22,0)
,itm_length_nditm  numeric (22,0)
,itm_wide_nditm  numeric (22,0)
,itm_deth_nditm  numeric (22,0)
,unit_name_nditm  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,unit_contents_case  varchar (4000) 
,boxe_outdepth  numeric (7,2)
,boxe_outheight  numeric (7,2)
,boxe_height  numeric (7,2)
,unit_name_prdpurshp  varchar (100) 
,boxe_outwide  numeric (7,2)
,boxe_wide  numeric (7,2)
,boxe_depth  numeric (7,2)
,boxe_contents  varchar (4000) 
,loca_country  varchar (20) 
,loca_mail  varchar (20) 
,loca_fax  varchar (20) 
,loca_tel  varchar (20) 
,loca_prfct  varchar (20) 
,loca_addr1  varchar (50) 
,loca_addr2  varchar (50) 
,loca_zip  varchar (10) 
,boxe_boxtype  varchar (20) 
,loca_abbr  varchar (50) 
,loca_addr1_shelfno  varchar (50) 
,loca_prfct_shelfno  varchar (20) 
,loca_country_shelfno  varchar (20) 
,loca_abbr_shelfno  varchar (50) 
,loca_addr2_shelfno  varchar (50) 
,loca_tel_shelfno  varchar (20) 
,loca_fax_shelfno  varchar (20) 
,loca_mail_shelfno  varchar (20) 
,unit_contents_prdpurshp  varchar (4000) 
,shelfno_contents  varchar (4000) 
,loca_zip_shelfno  varchar (10) 
,nditm_remark  varchar (4000) 
,nditm_contents  varchar (4000) 
,nditm_opeitm_id  numeric (38,0)
,nditm_loca_id_fm  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,boxe_unit_id_box  numeric (22,0)
,itm_unit_id_nditm  numeric (22,0)
,itm_classlist_id_nditm  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,boxe_unit_id_outbox  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,itm_unit_id  numeric (22,0)
,opeitm_esttosch  numeric (22,0)
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_chkinst  varchar (1) 
,opeitm_remark  varchar (4000) 
,opeitm_duration  numeric (38,2)
,opeitm_units_lttime  varchar (4) 
,unit_name  varchar (100) 
,id  numeric (38,0)
,nditm_id  numeric (38,0)
,nditm_itm_id_nditm  numeric (38,0)
,unit_name_case  varchar (100) 
,unit_name_box  varchar (100) 
,nditm_person_id_upd  numeric (38,0)
,nditm_update_ip  varchar (40) 
,nditm_created_at   timestamp(6) 
,nditm_updated_at   timestamp(6) 
,unit_name_outbox  varchar (100) 
,opeitm_operation  varchar (20) 
,itm_datascale_nditm  numeric (22,0)
,opeitm_chkord_prc  numeric (3,0)
,opeitm_chkord  varchar (1) 
,unit_code  varchar (50) 
,opeitm_mold  varchar (1) 
,unit_code_case  varchar (50) 
,unit_code_box  varchar (50) 
,opeitm_packno_flg  varchar (1) 
,itm_remark_nditm  varchar (4000) 
,unit_code_outbox  varchar (50) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_shelfno_id  numeric (22,0)
,opeitm_contents  varchar (4000) 
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
 CREATE INDEX sio_r_nditms_uk1 
  ON sio.sio_r_nditms(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_nditms_seq ;
 create sequence sio.sio_r_nditms_seq ;
