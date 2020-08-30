 --- drop view r_mkshps cascade  
 create or replace view r_mkshps as select  
mkshp.persons_id_upd   mkshp_person_id_upd,
mkshp.created_at  mkshp_created_at,
mkshp.updated_at  mkshp_updated_at,
mkshp.expiredate  mkshp_expiredate,
mkshp.update_ip  mkshp_update_ip,
  itm_org.unit_code  unit_code_org ,
  itm_pare.unit_code  unit_code_pare ,
  itm_org.unit_name  unit_name_org ,
  itm_pare.unit_name  unit_name_pare ,
  itm_org.itm_code  itm_code_org ,
  itm_pare.itm_code  itm_code_pare ,
  itm_org.itm_name  itm_name_org ,
  itm_pare.itm_name  itm_name_pare ,
  loca_pare.loca_code  loca_code_pare ,
  loca_org.loca_code  loca_code_org ,
  loca_pare.loca_name  loca_name_pare ,
  loca_org.loca_name  loca_name_org ,
  itm_org.itm_unit_id  itm_unit_id_org ,
  itm_pare.itm_unit_id  itm_unit_id_pare ,
  itm_org.itm_classlist_id  itm_classlist_id_org ,
  itm_pare.itm_classlist_id  itm_classlist_id_pare ,
  itm_org.classlist_code  classlist_code_org ,
  itm_pare.classlist_code  classlist_code_pare ,
  itm_org.classlist_name  classlist_name_org ,
  itm_pare.classlist_name  classlist_name_pare ,
mkshp.id  mkshp_id,
mkshp.id id,
mkshp.cmpldate  mkshp_cmpldate,
mkshp.result_f  mkshp_result_f,
mkshp.runtime  mkshp_runtime,
mkshp.isudate  mkshp_isudate,
mkshp.confirm  mkshp_confirm,
mkshp.manual  mkshp_manual,
mkshp.orgtblname  mkshp_orgtblname,
mkshp.sno_org  mkshp_sno_org,
mkshp.itms_id_org   mkshp_itm_id_org,
mkshp.locas_id_org   mkshp_loca_id_org,
mkshp.paretblname  mkshp_paretblname,
mkshp.duedate_pare  mkshp_duedate_pare,
mkshp.sno_pare  mkshp_sno_pare,
mkshp.itms_id_pare   mkshp_itm_id_pare,
mkshp.locas_id_pare   mkshp_loca_id_pare,
mkshp.tblname  mkshp_tblname,
mkshp.incnt  mkshp_incnt,
mkshp.inqty  mkshp_inqty,
mkshp.inamt  mkshp_inamt,
mkshp.outcnt  mkshp_outcnt,
mkshp.outqty  mkshp_outqty,
mkshp.outamt  mkshp_outamt,
mkshp.skipcnt  mkshp_skipcnt,
mkshp.skipqty  mkshp_skipqty,
mkshp.skipamt  mkshp_skipamt,
mkshp.remark  mkshp_remark,
mkshp.message_code  mkshp_message_code
 from mkshps   mkshp,
  r_persons  person_upd ,  r_itms  itm_org ,  r_locas  loca_org ,  r_itms  itm_pare ,  r_locas  loca_pare 
  where       mkshp.persons_id_upd = person_upd.id      and mkshp.itms_id_org = itm_org.id      and mkshp.locas_id_org = loca_org.id      and mkshp.itms_id_pare = itm_pare.id      and mkshp.locas_id_pare = loca_pare.id     ;
 DROP TABLE IF EXISTS sio.sio_r_mkshps;
 CREATE TABLE sio.sio_r_mkshps (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_mkshps_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,itm_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,unit_code_org  varchar (50) 
,unit_code_pare  varchar (50) 
,loca_code_pare  varchar (50) 
,loca_code_org  varchar (50) 
,loca_name_pare  varchar (100) 
,loca_name_org  varchar (100) 
,unit_name_org  varchar (100) 
,unit_name_pare  varchar (100) 
,itm_code_org  varchar (50) 
,classlist_code_org  varchar (50) 
,classlist_code_pare  varchar (50) 
,classlist_name_org  varchar (100) 
,classlist_name_pare  varchar (100) 
,itm_name_org  varchar (100) 
,mkshp_manual  varchar (1) 
,mkshp_orgtblname  varchar (30) 
,mkshp_inamt  numeric (38,4)
,mkshp_sno_org  varchar (50) 
,mkshp_tblname  varchar (30) 
,mkshp_sno_pare  varchar (50) 
,mkshp_paretblname  varchar (30) 
,mkshp_duedate_pare  varchar (18) 
,mkshp_inqty  numeric (22,6)
,mkshp_message_code  varchar (256) 
,mkshp_skipamt  numeric (38,4)
,mkshp_expiredate   date 
,mkshp_skipqty  numeric (22,6)
,mkshp_incnt  numeric (38,0)
,mkshp_cmpldate   timestamp(6) 
,mkshp_result_f  varchar (1) 
,mkshp_runtime  numeric (2,0)
,mkshp_isudate   timestamp(6) 
,mkshp_confirm  varchar (1) 
,mkshp_skipcnt  numeric (38,0)
,mkshp_outamt  numeric (38,4)
,mkshp_outqty  numeric (22,6)
,mkshp_outcnt  numeric (38,0)
,unit_contents_org  varchar (4000) 
,itm_std_org  varchar (50) 
,itm_std_pare  varchar (50) 
,itm_model_org  varchar (50) 
,itm_model_pare  varchar (50) 
,itm_material_org  varchar (50) 
,itm_material_pare  varchar (50) 
,itm_design_org  varchar (50) 
,itm_design_pare  varchar (50) 
,itm_weight_org  numeric (22,0)
,itm_weight_pare  numeric (22,0)
,itm_length_org  numeric (22,0)
,itm_length_pare  numeric (22,0)
,itm_wide_org  numeric (22,0)
,itm_wide_pare  numeric (22,0)
,itm_deth_org  numeric (22,0)
,itm_deth_pare  numeric (22,0)
,loca_abbr_pare  varchar (50) 
,loca_abbr_org  varchar (50) 
,loca_zip_pare  varchar (10) 
,loca_zip_org  varchar (10) 
,loca_country_pare  varchar (20) 
,loca_country_org  varchar (20) 
,loca_prfct_pare  varchar (20) 
,loca_prfct_org  varchar (20) 
,loca_addr1_pare  varchar (50) 
,loca_addr1_org  varchar (50) 
,loca_addr2_pare  varchar (50) 
,loca_addr2_org  varchar (50) 
,loca_tel_pare  varchar (20) 
,loca_tel_org  varchar (20) 
,loca_fax_pare  varchar (20) 
,loca_fax_org  varchar (20) 
,loca_mail_pare  varchar (20) 
,loca_mail_org  varchar (20) 
,itm_datascale_org  numeric (22,0)
,itm_datascale_pare  numeric (22,0)
,unit_contents_pare  varchar (4000) 
,mkshp_remark  varchar (4000) 
,mkshp_itm_id_pare  numeric (38,0)
,mkshp_loca_id_pare  numeric (38,0)
,mkshp_itm_id_org  numeric (38,0)
,id  numeric (38,0)
,mkshp_id  numeric (38,0)
,mkshp_person_id_upd  numeric (38,0)
,mkshp_loca_id_org  numeric (38,0)
,mkshp_update_ip  varchar (40) 
,mkshp_updated_at   timestamp(6) 
,mkshp_created_at   timestamp(6) 
,itm_classlist_id_pare  numeric (38,0)
,itm_classlist_id_org  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,itm_unit_id_org  numeric (22,0)
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
 CREATE INDEX sio_r_mkshps_uk1 
  ON sio.sio_r_mkshps(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_mkshps_seq ;
 create sequence sio.sio_r_mkshps_seq ;
