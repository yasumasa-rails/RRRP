
 alter table  opeitms ALTER COLUMN packqty  TYPE numeric(18,2);

 --- drop view r_opeitms cascade  
 create or replace view r_opeitms as select  
opeitm.boxes_id   opeitm_boxe_id,
opeitm.shelfnos_id   opeitm_shelfno_id,
opeitm.prdpurshp  opeitm_prdpurshp,
opeitm.opt_fix_flg  opeitm_opt_fix_flg,
  shelfno.shelfno_code  shelfno_code ,
  boxe.boxe_code  boxe_code ,
  boxe.boxe_name  boxe_name ,
  shelfno.shelfno_name  shelfno_name ,
opeitm.autocreate_ord  opeitm_autocreate_ord,
opeitm.autoinst_p  opeitm_autoinst_p,
  boxe.unit_code_outbox  unit_code_outbox ,
  boxe.unit_code_box  unit_code_box ,
  unit_case.unit_code  unit_code_case ,
  itm.unit_code  unit_code ,
  unit_prdpurshp.unit_code  unit_code_prdpurshp ,
  boxe.unit_name_outbox  unit_name_outbox ,
  boxe.unit_name_box  unit_name_box ,
  unit_case.unit_name  unit_name_case ,
  itm.unit_name  unit_name ,
  unit_prdpurshp.unit_name  unit_name_prdpurshp ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name ,
opeitm.autoact_p  opeitm_autoact_p,
opeitm.autoord_p  opeitm_autoord_p,
opeitm.id  opeitm_id,
  loca.loca_abbr  loca_abbr ,
  loca.loca_zip  loca_zip ,
  loca.loca_prfct  loca_prfct ,
  loca.loca_addr1  loca_addr1 ,
  loca.loca_addr2  loca_addr2 ,
opeitm.remark  opeitm_remark,
opeitm.duration  opeitm_duration,
opeitm.units_lttime  opeitm_units_lttime,
opeitm.expiredate  opeitm_expiredate,
opeitm.persons_id_upd   opeitm_person_id_upd,
opeitm.update_ip  opeitm_update_ip,
opeitm.created_at  opeitm_created_at,
opeitm.updated_at  opeitm_updated_at,
  shelfno.loca_code_shelfno  loca_code_shelfno ,
  loca.loca_code  loca_code ,
  shelfno.loca_name_shelfno  loca_name_shelfno ,
  loca.loca_name  loca_name ,
opeitm.itms_id   opeitm_itm_id,
opeitm.locas_id   opeitm_loca_id,
opeitm.minqty  opeitm_minqty,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  shelfno.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
opeitm.id id,
  itm.itm_unit_id  itm_unit_id ,
opeitm.operation  opeitm_operation,
opeitm.opt_fixoterm  opeitm_opt_fixoterm,
  itm.itm_classlist_id  itm_classlist_id ,
opeitm.safestkqty  opeitm_safestkqty,
opeitm.packqty  opeitm_packqty,
opeitm.units_id_case   opeitm_unit_id_case,
opeitm.shuffle_flg  opeitm_shuffle_flg,
opeitm.chkord_prc  opeitm_chkord_prc,
opeitm.chkord  opeitm_chkord,
opeitm.autocreate_act  opeitm_autocreate_act,
opeitm.shuffle_loca  opeitm_shuffle_loca,
opeitm.esttosch  opeitm_esttosch,
opeitm.stktaking_proc  opeitm_stktaking_proc,
opeitm.rule_price  opeitm_rule_price,
  itm.classlist_code  classlist_code ,
opeitm.mold  opeitm_mold,
opeitm.autocreate_inst  opeitm_autocreate_inst,
  itm.classlist_name  classlist_name ,
opeitm.packno_flg  opeitm_packno_flg,
opeitm.processseq  opeitm_processseq,
opeitm.priority  opeitm_priority,
opeitm.contents  opeitm_contents,
opeitm.acceptance_proc  opeitm_acceptance_proc,
opeitm.units_id_prdpurshp   opeitm_unit_id_prdpurshp,
opeitm.chkinst  opeitm_chkinst,
  boxe.boxe_boxtype  boxe_boxtype ,
  boxe.boxe_unit_id_box  boxe_unit_id_box ,
  boxe.boxe_unit_id_outbox  boxe_unit_id_outbox ,
opeitm.maxqty  opeitm_maxqty,
opeitm.prjalloc_flg  opeitm_prjalloc_flg
 from opeitms   opeitm,
  r_boxes  boxe ,  r_shelfnos  shelfno ,  r_persons  person_upd ,  r_itms  itm ,  r_locas  loca ,  r_units  unit_case ,  r_units  unit_prdpurshp 
  where       opeitm.boxes_id = boxe.id      and opeitm.shelfnos_id = shelfno.id      and opeitm.persons_id_upd = person_upd.id      and opeitm.itms_id = itm.id      and opeitm.locas_id = loca.id      and opeitm.units_id_case = unit_case.id      and opeitm.units_id_prdpurshp = unit_prdpurshp.id     ;
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
,opeitm_processseq  numeric (3,0)
,opeitm_priority  numeric (3,0)
,itm_name  varchar (100) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,opeitm_prdpurshp  varchar (20) 
,opeitm_operation  varchar (20) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,opeitm_duration  numeric (38,2)
,opeitm_autocreate_ord  varchar (1) 
,opeitm_acceptance_proc  varchar (1) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_stktaking_proc  varchar (1) 
,opeitm_autoinst_p  numeric (3,0)
,opeitm_rule_price  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_shuffle_flg  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_packno_flg  varchar (1) 
,opeitm_packqty  numeric (38,0)
,opeitm_minqty  numeric (38,6)
,opeitm_maxqty  numeric (22,0)
,opeitm_safestkqty  numeric (38,0)
,opeitm_units_lttime  varchar (4) 
,opeitm_chkord  varchar (1) 
,opeitm_chkord_prc  numeric (3,0)
,opeitm_esttosch  numeric (22,0)
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,itm_material  varchar (50) 
,itm_design  varchar (50) 
,itm_weight  numeric (22,0)
,itm_length  numeric (22,0)
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,itm_datascale  numeric (22,0)
,unit_contents  varchar (4000) 
,unit_dataprecision_prdpurshp  numeric (38,0)
,unit_dataprecision_case  numeric (38,0)
,opeitm_chkinst  varchar (1) 
,opeitm_mold  varchar (1) 
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_autoord_p  numeric (3,0)
,opeitm_autoact_p  numeric (3,0)
,opeitm_opt_fix_flg  varchar (1) 
,unit_contents_prdpurshp  varchar (4000) 
,unit_contents_case  varchar (4000) 
,opeitm_expiredate   date 
,boxe_boxtype  varchar (20) 
,opeitm_contents  varchar (4000) 
,opeitm_remark  varchar (4000) 
,opeitm_created_at   timestamp(6) 
,opeitm_loca_id  numeric (38,0)
,opeitm_id  numeric (38,0)
,opeitm_person_id_upd  numeric (38,0)
,opeitm_update_ip  varchar (40) 
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,loca_zip_shelfno  varchar (10) 
,opeitm_shelfno_id  numeric (22,0)
,opeitm_updated_at   timestamp 
,loca_abbr_shelfno  varchar (50) 
,shelfno_contents  varchar (4000) 
,boxe_depth  numeric (7,2)
,boxe_wide  numeric (7,2)
,boxe_height  numeric (7,2)
,boxe_outdepth  numeric (7,2)
,boxe_outwide  numeric (7,2)
,boxe_outheight  numeric (7,2)
,loca_abbr  varchar (50) 
,loca_mail  varchar (20) 
,loca_mail_shelfno  varchar (20) 
,loca_fax  varchar (20) 
,loca_fax_shelfno  varchar (20) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,shelfno_loca_id_shelfno  numeric (38,0)
,id  numeric (22,0)
,loca_tel  varchar (20) 
,loca_tel_shelfno  varchar (20) 
,loca_addr2  varchar (50) 
,loca_addr2_shelfno  varchar (50) 
,opeitm_unit_id_case  numeric (38,0)
,loca_addr1  varchar (50) 
,loca_addr1_shelfno  varchar (50) 
,loca_prfct  varchar (20) 
,loca_prfct_shelfno  varchar (20) 
,boxe_contents  varchar (4000) 
,loca_country  varchar (20) 
,opeitm_boxe_id  numeric (22,0)
,loca_country_shelfno  varchar (20) 
,loca_zip  varchar (10) 
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
