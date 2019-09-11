
 --- drop view r_opeitms cascade  
 create or replace view r_opeitms as select  
  shelfno.loca_name_shelfno  loca_name_shelfno ,
  shelfno.loca_mail_shelfno  loca_mail_shelfno ,
  shelfno.loca_zip_shelfno  loca_zip_shelfno ,
opeitm.id  opeitm_id,
opeitm.prjalloc_flg  opeitm_prjalloc_flg,
opeitm.processseq  opeitm_processseq,
opeitm.priority  opeitm_priority,
opeitm.shelfnos_id   opeitm_shelfno_id,
  shelfno.loca_id_shelfno  loca_id_shelfno ,
opeitm.chkord  opeitm_chkord,
opeitm.chkinst  opeitm_chkinst,
opeitm.mold  opeitm_mold,
  boxe.boxe_outwide  boxe_outwide ,
  boxe.boxe_outdepth  boxe_outdepth ,
  boxe.boxe_wide  boxe_wide ,
  boxe.boxe_outheight  boxe_outheight ,
  boxe.boxe_depth  boxe_depth ,
opeitm.boxes_id   opeitm_boxe_id,
  boxe.boxe_contents  boxe_contents ,
  boxe.boxe_height  boxe_height ,
  shelfno.shelfno_contents  shelfno_contents ,
opeitm.packno_flg  opeitm_packno_flg,
opeitm.opt_fix_flg  opeitm_opt_fix_flg,
opeitm.units_id_case   opeitm_unit_id_case,
  unit_case.unit_name  unit_name_case ,
  itm.itm_unit_id  itm_unit_id ,
  itm.unit_name  unit_name ,
opeitm.units_lttime  opeitm_units_lttime,
  itm.unit_code  unit_code ,
  unit_prdpurshp.unit_contents  unit_contents_prdpurshp ,
  boxe.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  unit_prdpurshp.unit_code  unit_code_prdpurshp ,
  boxe.unit_name_outbox  unit_name_outbox ,
  boxe.unit_code_outbox  unit_code_outbox ,
  boxe.unit_code_box  unit_code_box ,
  boxe.unit_name_box  unit_name_box ,
opeitm.id id,
opeitm.minqty  opeitm_minqty,
opeitm.packqty  opeitm_packqty,
opeitm.maxqty  opeitm_maxqty,
  boxe.boxe_unit_id_box  boxe_unit_id_box ,
opeitm.units_id_prdpurshp   opeitm_unit_id_prdpurshp,
  unit_prdpurshp.unit_name  unit_name_prdpurshp ,
  unit_case.unit_code  unit_code_case ,
  unit_case.unit_contents  unit_contents_case ,
  itm.itm_datascale  itm_datascale ,
  itm.itm_deth  itm_deth ,
opeitm.persons_id_upd   opeitm_person_id_upd,
  shelfno.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
opeitm.esttosch  opeitm_esttosch,
opeitm.chkord_prc  opeitm_chkord_prc,
opeitm.remark  opeitm_remark,
opeitm.operation  opeitm_operation,
opeitm.itms_id   opeitm_itm_id,
opeitm.locas_id   opeitm_loca_id,
opeitm.opt_fixoterm  opeitm_opt_fixoterm,
opeitm.autocreate_ord  opeitm_autocreate_ord,
opeitm.autocreate_inst  opeitm_autocreate_inst,
opeitm.shuffle_flg  opeitm_shuffle_flg,
opeitm.shuffle_loca  opeitm_shuffle_loca,
opeitm.autocreate_act  opeitm_autocreate_act,
opeitm.rule_price  opeitm_rule_price,
opeitm.stktaking_f  opeitm_stktaking_f,
  boxe.boxe_code  boxe_code ,
  shelfno.shelfno_name  shelfno_name ,
  shelfno.shelfno_code  shelfno_code ,
opeitm.created_at  opeitm_created_at,
  itm.itm_weight  itm_weight ,
  itm.itm_length  itm_length ,
opeitm.prdpurshp  opeitm_prdpurshp,
opeitm.autoord_p  opeitm_autoord_p,
  itm.itm_wide  itm_wide ,
opeitm.duration  opeitm_duration,
opeitm.safestkqty  opeitm_safestkqty,
opeitm.expiredate  opeitm_expiredate,
opeitm.updated_at  opeitm_updated_at,
opeitm.contents  opeitm_contents,
  itm.itm_name  itm_name ,
  loca.loca_name  loca_name ,
  loca.loca_code  loca_code ,
  itm.itm_code  itm_code ,
  loca.loca_country  loca_country ,
  itm.itm_std  itm_std ,
  itm.itm_model  itm_model ,
  itm.itm_design  itm_design ,
  itm.itm_material  itm_material ,
  boxe.boxe_name  boxe_name ,
  loca.loca_tel  loca_tel ,
  loca.loca_mail  loca_mail ,
  loca.loca_fax  loca_fax ,
  loca.loca_prfct  loca_prfct ,
  loca.loca_addr1  loca_addr1 ,
  loca.loca_addr2  loca_addr2 ,
  loca.loca_zip  loca_zip ,
  person_upd.person_name  person_name_upd ,
  boxe.boxe_boxtype  boxe_boxtype ,
opeitm.update_ip  opeitm_update_ip,
  person_upd.person_code  person_code_upd ,
  loca.loca_abbr  loca_abbr ,
  shelfno.loca_addr1_shelfno  loca_addr1_shelfno ,
  shelfno.loca_code_shelfno  loca_code_shelfno ,
  shelfno.loca_prfct_shelfno  loca_prfct_shelfno ,
  shelfno.loca_country_shelfno  loca_country_shelfno ,
  shelfno.loca_addr2_shelfno  loca_addr2_shelfno ,
  shelfno.loca_abbr_shelfno  loca_abbr_shelfno ,
  shelfno.loca_fax_shelfno  loca_fax_shelfno ,
  shelfno.loca_tel_shelfno  loca_tel_shelfno 
 from opeitms   opeitm,
  r_shelfnos  shelfno ,  r_boxes  boxe ,  r_units  unit_case ,  r_units  unit_prdpurshp ,  r_persons  person_upd ,  r_itms  itm ,  r_locas  loca 
  where       opeitm.shelfnos_id = shelfno.id      and opeitm.boxes_id = boxe.id      and opeitm.units_id_case = unit_case.id      and opeitm.units_id_prdpurshp = unit_prdpurshp.id      and opeitm.persons_id_upd = person_upd.id   
  and opeitm.itms_id = itm.id      and opeitm.locas_id = loca.id     ;
 DROP TABLE IF EXISTS sio.sio_r_opeitms;
 CREATE TABLE sio.sio_r_opeitms (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_opeitms_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,opeitm_prdpurshp  varchar (5) 
,opeitm_operation  varchar (40) 
,opeitm_processseq  numeric (3,0)
,opeitm_priority  numeric (3,0)
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,opeitm_shuffle_flg  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_autocreate_ord  varchar (1) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_shuffle_loca  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_rule_price  varchar (1) 
,opeitm_stktaking_f  varchar (1) 
,opeitm_packno_flg  varchar (1) 
,itm_length  numeric (22,0)
,itm_weight  numeric (22,0)
,itm_wide  numeric (22,0)
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,itm_design  varchar (50) 
,itm_material  varchar (50) 
,itm_deth  numeric (22,0)
,opeitm_packqty  numeric (38,0)
,opeitm_consumunitqty  numeric (38,0)
,opeitm_minqty  numeric (38,6)
,opeitm_maxqty  numeric (22,0)
,shelfno_contents  varchar (4000) 
,unit_contents_prdpurshp  varchar (4000) 
,unit_name_prdpurshp  varchar (100) 
,unit_contents_case  varchar (4000) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,opeitm_safestkqty  numeric (38,0)
,opeitm_units_lttime  varchar (4) 
,unit_code_box  varchar (50) 
,unit_name_outbox  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_box  varchar (100) 
,opeitm_chkord  varchar (1) 
,opeitm_chkord_prc  numeric (3,0)
,opeitm_consumauto  varchar (1) 
,opeitm_esttosch  numeric (22,0)
,opeitm_chkinst  varchar (1) 
,opeitm_mold  varchar (1) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,opeitm_qty_pur  numeric (22,0)
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_duration  numeric (38,2)
,opeitm_consumtype  varchar (3) 
,opeitm_autoord_p  numeric (3,0)
,opeitm_autoact_p  numeric (3,0)
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_expiredate   date 
,boxe_boxtype  varchar (20) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,opeitm_contents  varchar (4000) 
,opeitm_remark  varchar (4000) 
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,loca_tel_shelfno  varchar (20) 
,itm_expiredate   date 
,loca_mail_shelfno  varchar (20) 
,loca_zip_shelfno  varchar (10) 
,opeitm_id  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,loca_id_shelfno  numeric (22,0)
,boxe_outwide  numeric (7,2)
,boxe_outdepth  numeric (7,2)
,loca_id  numeric (22,0)
,boxe_wide  numeric (7,2)
,boxe_outheight  numeric (7,2)
,boxe_depth  numeric (7,2)
,opeitm_boxe_id  numeric (22,0)
,boxe_contents  varchar (4000) 
,boxe_height  numeric (7,2)
,opeitm_unit_id_case  numeric (38,0)
,itm_unit_id  numeric (22,0)
,boxe_unit_id_outbox  numeric (22,0)
,id  numeric (22,0)
,boxe_unit_id_box  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,itm_datascale  numeric (22,0)
,opeitm_person_id_upd  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_created_at   timestamp(6) 
,person_id_upd  numeric (22,0)
,itm_id  numeric (22,0)
,opeitm_parenum  numeric (22,0)
,opeitm_chilnum  numeric (22,0)
,shelfno_id  numeric (22,0)
,opeitm_updated_at   timestamp 
,loca_country  varchar (20) 
,loca_tel  varchar (20) 
,loca_mail  varchar (20) 
,loca_fax  varchar (20) 
,loca_prfct  varchar (20) 
,loca_addr1  varchar (50) 
,loca_addr2  varchar (50) 
,loca_zip  varchar (10) 
,person_name_upd  varchar (100) 
,shelfno_expiredate   date 
,loca_expiredate_shelfno   date 
,loca_expiredate   date 
,boxe_expiredate   date 
,opeitm_update_ip  varchar (40) 
,person_code_upd  varchar (50) 
,loca_abbr  varchar (50) 
,loca_addr1_shelfno  varchar (50) 
,loca_code_shelfno  varchar (50) 
,loca_prfct_shelfno  varchar (20) 
,loca_country_shelfno  varchar (20) 
,loca_addr2_shelfno  varchar (50) 
,loca_abbr_shelfno  varchar (50) 
,loca_fax_shelfno  varchar (20) 
,loca_name_shelfno  varchar (100) 
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
 CREATE INDEX sio_r_opeitms_uk1 
  ON sio.sio_r_opeitms(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_opeitms_seq ;
 create sequence sio.sio_r_opeitms_seq ;
