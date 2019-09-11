
 alter table nditms DROP COLUMN duration CASCADE;

 ---- 使用しているview 
 ---- select * from pobject_code_scr,pobject_code_sfd,
							   case screenfield_selection when 1 then '選択有' else '' end select,
								case screenfield_hideflg when 1 then '' else '表示有' end display,
							   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'duration'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　durationが削除　2019-09-02 18:15:21 +0900' 
 ---- where  pobject_code_sfd = 'duration'
 alter table  nditms ALTER COLUMN parenum  TYPE numeric(22,6);

 alter table  nditms ALTER COLUMN chilnum  TYPE numeric(22,6);

 alter table  nditms ALTER COLUMN consumunitqty  TYPE numeric(22,6);

 alter table  nditms  ADD COLUMN consumminqty numeric(22,6);

 alter table  nditms  ADD COLUMN consumchgoverqty numeric(22,6);

 --- drop view r_nditms cascade  
 create or replace view r_nditms as select  
nditm.byproduct  nditm_byproduct,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
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
nditm.id  nditm_id,
nditm.consumminqty  nditm_consumminqty,
nditm.consumchgoverqty  nditm_consumchgoverqty,
  opeitm.opeitm_chkord  opeitm_chkord ,
  opeitm.opeitm_chkinst  opeitm_chkinst ,
  opeitm.opeitm_mold  opeitm_mold ,
nditm.update_ip  nditm_update_ip,
nditm.updated_at  nditm_updated_at,
nditm.processseq_nditm  nditm_processseq_nditm,
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.loca_zip_shelfno  loca_zip_shelfno ,
  opeitm.loca_id_shelfno  loca_id_shelfno ,
  opeitm.boxe_outwide  boxe_outwide ,
  opeitm.boxe_outdepth  boxe_outdepth ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.shelfno_contents  shelfno_contents ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.boxe_contents  boxe_contents ,
  opeitm.unit_contents_case  unit_contents_case ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.boxe_height  boxe_height ,
  opeitm.loca_country  loca_country ,
  opeitm.itm_model  itm_model ,
  opeitm.itm_std  itm_std ,
  opeitm.itm_weight  itm_weight ,
  opeitm.itm_length  itm_length ,
  opeitm.itm_design  itm_design ,
  opeitm.loca_tel  loca_tel ,
  loca_nditm.loca_code  loca_code_nditm ,
  itm_nditm.itm_name  itm_name_nditm ,
  itm_nditm.itm_code  itm_code_nditm ,
  opeitm.loca_fax  loca_fax ,
  opeitm.loca_mail  loca_mail ,
  opeitm.loca_zip  loca_zip ,
  opeitm.loca_abbr  loca_abbr ,
  opeitm.loca_addr1  loca_addr1 ,
  opeitm.loca_addr1_shelfno  loca_addr1_shelfno ,
  opeitm.boxe_boxtype  boxe_boxtype ,
  opeitm.loca_prfct_shelfno  loca_prfct_shelfno ,
  opeitm.loca_country_shelfno  loca_country_shelfno ,
  opeitm.loca_abbr_shelfno  loca_abbr_shelfno ,
  opeitm.loca_addr2  loca_addr2 ,
  opeitm.loca_addr2_shelfno  loca_addr2_shelfno ,
  opeitm.loca_fax_shelfno  loca_fax_shelfno ,
  opeitm.loca_tel_shelfno  loca_tel_shelfno ,
  loca_nditm.loca_name  loca_name_nditm ,
  opeitm.itm_wide  itm_wide ,
  opeitm.itm_material  itm_material ,
  opeitm.loca_mail_shelfno  loca_mail_shelfno ,
  opeitm.boxe_depth  boxe_depth ,
  opeitm.unit_contents_prdpurshp  unit_contents_prdpurshp ,
  opeitm.loca_prfct  loca_prfct ,
  opeitm.boxe_outheight  boxe_outheight ,
  opeitm.boxe_wide  boxe_wide ,
  opeitm.itm_datascale  itm_datascale ,
nditm.contents  nditm_contents,
nditm.itms_id_nditm   nditm_itm_id_nditm,
nditm.parenum  nditm_parenum,
nditm.chilnum  nditm_chilnum,
nditm.consumunitqty  nditm_consumunitqty,
nditm.locas_id_nditm   nditm_loca_id_nditm,
  opeitm.opeitm_duration  opeitm_duration ,
  opeitm.opeitm_minqty  opeitm_minqty ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_maxqty  opeitm_maxqty ,
  opeitm.opeitm_chkord_prc  opeitm_chkord_prc ,
  opeitm.opeitm_prjalloc_flg  opeitm_prjalloc_flg ,
  opeitm.opeitm_safestkqty  opeitm_safestkqty ,
  opeitm.opeitm_esttosch  opeitm_esttosch ,
  opeitm.opeitm_operation  opeitm_operation ,
  opeitm.opeitm_prdpurshp  opeitm_prdpurshp ,
  opeitm.itm_deth  itm_deth ,
  opeitm.unit_name_case  unit_name_case ,
  itm_nditm.itm_remark  itm_remark_nditm ,
  opeitm.opeitm_opt_fix_flg  opeitm_opt_fix_flg ,
  opeitm.opeitm_packno_flg  opeitm_packno_flg ,
  opeitm.opeitm_units_lttime  opeitm_units_lttime ,
  itm_nditm.itm_unit_id  itm_unit_id_nditm ,
  itm_nditm.itm_datascale  itm_datascale_nditm ,
  itm_nditm.itm_weight  itm_weight_nditm ,
  itm_nditm.itm_length  itm_length_nditm ,
  itm_nditm.itm_wide  itm_wide_nditm ,
  itm_nditm.itm_deth  itm_deth_nditm ,
  itm_nditm.itm_material  itm_material_nditm ,
  itm_nditm.itm_std  itm_std_nditm ,
  itm_nditm.unit_code  unit_code_nditm ,
  itm_nditm.itm_model  itm_model_nditm ,
  itm_nditm.itm_design  itm_design_nditm ,
  itm_nditm.unit_name  unit_name_nditm ,
  loca_nditm.loca_country  loca_country_nditm ,
  loca_nditm.loca_tel  loca_tel_nditm ,
  loca_nditm.loca_prfct  loca_prfct_nditm ,
  loca_nditm.loca_abbr  loca_abbr_nditm ,
  loca_nditm.loca_mail  loca_mail_nditm ,
  loca_nditm.loca_addr1  loca_addr1_nditm ,
  loca_nditm.loca_fax  loca_fax_nditm ,
  loca_nditm.loca_addr2  loca_addr2_nditm ,
  loca_nditm.loca_zip  loca_zip_nditm ,
nditm.consumtype  nditm_consumtype,
nditm.consumauto  nditm_consumauto,
  opeitm.opeitm_remark  opeitm_remark ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_autoord_p  opeitm_autoord_p ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.itm_name  itm_name ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_code  shelfno_code ,
  loca_nditm.loca_remark  loca_remark_nditm ,
nditm.remark  nditm_remark,
nditm.opeitms_id   nditm_opeitm_id,
nditm.duration  nditm_duration,
nditm.id id,
nditm.created_at  nditm_created_at,
nditm.expiredate  nditm_expiredate,
nditm.persons_id_upd   nditm_person_id_upd,
  opeitm.opeitm_contents  opeitm_contents ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_code  unit_code ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.unit_name  unit_name 
 from nditms   nditm,
  r_itms  itm_nditm ,  r_locas  loca_nditm ,  r_opeitms  opeitm ,  r_persons  person_upd 
  where       nditm.itms_id_nditm = itm_nditm.id      and nditm.locas_id_nditm = loca_nditm.id      and nditm.opeitms_id = opeitm.id      and nditm.persons_id_upd = person_upd.id     ;
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
,itm_code_nditm  varchar (50) 
,itm_name_nditm  varchar (100) 
,nditm_processseq_nditm  numeric (38,0)
,nditm_duration  numeric (38,2)
,nditm_parenum  numeric (38,0)
,nditm_chilnum  numeric (38,0)
,nditm_consumunitqty  numeric (38,0)
,nditm_consumauto  varchar (1) 
,nditm_consumtype  varchar (3) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,loca_code_nditm  varchar (50) 
,loca_name_nditm  varchar (100) 
,nditm_contents  varchar (4000) 
,nditm_expiredate   date 
,nditm_consumchgoverqty  numeric (22,6)
,nditm_byproduct  varchar (1) 
,nditm_consumminqty  numeric (22,6)
,opeitm_autoact_p  numeric (3,0)
,opeitm_autoord_p  numeric (3,0)
,opeitm_qty_pur  numeric (22,0)
,loca_name_shelfno  varchar (100) 
,loca_code_shelfno  varchar (50) 
,unit_code_case_pur  varchar (50) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_shuffle_flg  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_rule_price  varchar (1) 
,opeitm_stktaking_f  varchar (1) 
,shelfno_name  varchar (100) 
,itm_design  varchar (50) 
,itm_material_nditm  varchar (50) 
,shelfno_code  varchar (50) 
,itm_model  varchar (50) 
,itm_std_nditm  varchar (50) 
,itm_std  varchar (50) 
,unit_code_nditm  varchar (50) 
,itm_model_nditm  varchar (50) 
,itm_material  varchar (50) 
,itm_length  numeric (22,0)
,itm_design_nditm  varchar (50) 
,itm_weight_nditm  numeric (22,0)
,itm_weight  numeric (22,0)
,itm_length_nditm  numeric (22,0)
,itm_wide_nditm  numeric (22,0)
,itm_deth_nditm  numeric (22,0)
,unit_name_nditm  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,boxe_outheight  numeric (7,2)
,unit_contents_case  varchar (4000) 
,boxe_outdepth  numeric (7,2)
,unit_name_prdpurshp  varchar (100) 
,boxe_height  numeric (7,2)
,boxe_outwide  numeric (7,2)
,boxe_wide  numeric (7,2)
,boxe_depth  numeric (7,2)
,boxe_contents  varchar (4000) 
,itm_wide  numeric (22,0)
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
,unit_contents_prdpurshp  varchar (4000) 
,loca_mail_shelfno  varchar (20) 
,shelfno_contents  varchar (4000) 
,loca_zip_shelfno  varchar (10) 
,nditm_remark  varchar (4000) 
,nditm_minqty  numeric (38,6)
,opeitm_loca_id  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,loca_prfct_nditm  varchar (20) 
,loca_abbr_nditm  varchar (50) 
,loca_mail_nditm  varchar (20) 
,loca_addr1_nditm  varchar (50) 
,loca_fax_nditm  varchar (20) 
,loca_addr2_nditm  varchar (50) 
,loca_zip_nditm  varchar (10) 
,opeitm_consumunitqty  numeric (22,0)
,opeitm_remark  varchar (4000) 
,shelfno_id  numeric (22,0)
,opeitm_parenum  numeric (22,0)
,opeitm_chilnum  numeric (22,0)
,opeitm_unit_id_case  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,loca_id_shelfno  numeric (22,0)
,nditm_updated_at   timestamp(6) 
,unit_code_case  varchar (50) 
,opeitm_shelfno_id  numeric (22,0)
,nditm_update_ip  varchar (40) 
,opeitm_mold  varchar (1) 
,opeitm_chkinst  varchar (1) 
,opeitm_consumtype  varchar (3) 
,opeitm_consumauto  varchar (1) 
,opeitm_chkord  varchar (1) 
,unit_name_case_pur  varchar (100) 
,nditm_id  numeric (38,0)
,loca_remark_nditm  varchar (4000) 
,nditm_opeitm_id  numeric (38,0)
,id  numeric (38,0)
,nditm_created_at   timestamp(6) 
,nditm_person_id_upd  numeric (38,0)
,itm_expiredate   date 
,opeitm_contents  varchar (4000) 
,unit_code_box  varchar (50) 
,unit_code  varchar (50) 
,unit_name_outbox  varchar (100) 
,unit_code_outbox  varchar (50) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,unit_name_box  varchar (100) 
,unit_name  varchar (100) 
,itm_datascale  numeric (22,0)
,nditm_itm_id_nditm  numeric (38,0)
,nditm_loca_id_nditm  numeric (38,0)
,opeitm_duration  numeric (38,2)
,opeitm_minqty  numeric (38,6)
,opeitm_packqty  numeric (38,0)
,opeitm_maxqty  numeric (22,0)
,opeitm_chkord_prc  numeric (3,0)
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_safestkqty  numeric (38,0)
,opeitm_esttosch  numeric (22,0)
,boxe_id  numeric (22,0)
,opeitm_operation  varchar (40) 
,opeitm_prdpurshp  varchar (5) 
,itm_deth  numeric (22,0)
,unit_name_case  varchar (100) 
,itm_remark_nditm  varchar (4000) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_packno_flg  varchar (1) 
,opeitm_units_lttime  varchar (4) 
,itm_unit_id_nditm  numeric (22,0)
,itm_datascale_nditm  numeric (22,0)
,loca_country_nditm  varchar (20) 
,loca_tel_nditm  varchar (20) 
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
