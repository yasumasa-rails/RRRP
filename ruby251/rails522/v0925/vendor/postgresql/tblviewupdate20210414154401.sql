
  drop view if  exists r_classlists cascade ; 
 create or replace view r_classlists as select  
classlist.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
classlist.id  classlist_id,
classlist.remark  classlist_remark,
classlist.expiredate  classlist_expiredate,
classlist.update_ip  classlist_update_ip,
classlist.created_at  classlist_created_at,
classlist.updated_at  classlist_updated_at,
classlist.persons_id_upd   classlist_person_id_upd,
classlist.code  classlist_code,
classlist.name  classlist_name,
classlist.contents  classlist_contents
 from classlists   classlist,
  r_persons  person_upd 
  where       classlist.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_classlists;
 CREATE TABLE sio.sio_r_classlists (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_classlists_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
          ,sio_Term_id varchar(30)
          ,sio_session_id numeric(22,0)
          ,sio_Command_Response char(1)
          ,sio_session_counter numeric(22,0)
          ,sio_classname varchar(50)
          ,sio_viewname varchar(30)
          ,sio_code varchar(30)
          ,sio_strsql varchar(4000)
          ,sio_totalcount numeric(22,0)
          ,sio_recordcount numeric(22,0)
          ,sio_start_record numeric(22,0)
          ,sio_end_record numeric(22,0)
          ,sio_sord varchar(256)
          ,sio_search varchar(10)
          ,sio_sidx varchar(256)
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,classlist_expiredate   date 
,classlist_contents  varchar (4000) 
,classlist_remark  varchar (4000) 
,classlist_update_ip  varchar (40) 
,classlist_id  numeric (38,0)
,id  numeric (38,0)
,classlist_created_at   timestamp(6) 
,classlist_updated_at   timestamp(6) 
,classlist_person_id_upd  numeric (38,0)
          ,sio_errline varchar(4000)
          ,sio_org_tblname varchar(30)
          ,sio_org_tblid numeric(22,0)
          ,sio_add_time date
          ,sio_replay_time date
          ,sio_result_f char(1)
          ,sio_message_code char(10)
          ,sio_message_contents varchar(4000)
          ,sio_chk_done char(1)
);
 CREATE INDEX sio_r_classlists_uk1 
  ON sio.sio_r_classlists(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_classlists_seq ;
 create sequence sio.sio_r_classlists_seq ;
  drop view if  exists r_units cascade ; 
 create or replace view r_units as select  
unit.expiredate  unit_expiredate,
unit.persons_id_upd   unit_person_id_upd,
unit.created_at  unit_created_at,
unit.updated_at  unit_updated_at,
unit.remark  unit_remark,
unit.name  unit_name,
unit.code  unit_code,
unit.update_ip  unit_update_ip,
unit.id  unit_id,
unit.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
unit.contents  unit_contents,
unit.dataprecision  unit_dataprecision
 from units   unit,
  r_persons  person_upd 
  where       unit.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_units;
 CREATE TABLE sio.sio_r_units (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_units_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
          ,sio_Term_id varchar(30)
          ,sio_session_id numeric(22,0)
          ,sio_Command_Response char(1)
          ,sio_session_counter numeric(22,0)
          ,sio_classname varchar(50)
          ,sio_viewname varchar(30)
          ,sio_code varchar(30)
          ,sio_strsql varchar(4000)
          ,sio_totalcount numeric(22,0)
          ,sio_recordcount numeric(22,0)
          ,sio_start_record numeric(22,0)
          ,sio_end_record numeric(22,0)
          ,sio_sord varchar(256)
          ,sio_search varchar(10)
          ,sio_sidx varchar(256)
,person_code_upd  varchar (50) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,person_name_upd  varchar (100) 
,unit_dataprecision  numeric (38,0)
,unit_expiredate   date 
,unit_remark  varchar (4000) 
,unit_contents  varchar (4000) 
,unit_id  numeric (38,0)
,unit_updated_at   timestamp(6) 
,unit_created_at   timestamp(6) 
,unit_person_id_upd  numeric (38,0)
,unit_update_ip  varchar (40) 
,id  numeric (22,0)
          ,sio_errline varchar(4000)
          ,sio_org_tblname varchar(30)
          ,sio_org_tblid numeric(22,0)
          ,sio_add_time date
          ,sio_replay_time date
          ,sio_result_f char(1)
          ,sio_message_code char(10)
          ,sio_message_contents varchar(4000)
          ,sio_chk_done char(1)
);
 CREATE INDEX sio_r_units_uk1 
  ON sio.sio_r_units(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_units_seq ;
 create sequence sio.sio_r_units_seq ;
  drop view if  exists r_itms cascade ; 
 create or replace view r_itms as select  
itm.model  itm_model,
itm.deth  itm_deth,
itm.created_at  itm_created_at,
itm.name  itm_name,
itm.design  itm_design,
itm.std  itm_std,
itm.code  itm_code,
itm.expiredate  itm_expiredate,
  unit.unit_name  unit_name ,
itm.wide  itm_wide,
itm.updated_at  itm_updated_at,
itm.persons_id_upd   itm_person_id_upd,
  unit.unit_code  unit_code ,
itm.length  itm_length,
itm.update_ip  itm_update_ip,
itm.weight  itm_weight,
itm.material  itm_material,
itm.remark  itm_remark,
itm.units_id   itm_unit_id,
itm.id  itm_id,
itm.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  classlist.classlist_code  classlist_code ,
  classlist.classlist_name  classlist_name ,
  unit.unit_contents  unit_contents ,
itm.datascale  itm_datascale,
itm.classlists_id   itm_classlist_id,
  unit.unit_dataprecision  unit_dataprecision 
 from itms   itm,
  r_persons  person_upd ,  r_units  unit ,  r_classlists  classlist 
  where       itm.persons_id_upd = person_upd.id      and itm.units_id = unit.id      and itm.classlists_id = classlist.id     ;
 DROP TABLE IF EXISTS sio.sio_r_itms;
 CREATE TABLE sio.sio_r_itms (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_itms_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
          ,sio_Term_id varchar(30)
          ,sio_session_id numeric(22,0)
          ,sio_Command_Response char(1)
          ,sio_session_counter numeric(22,0)
          ,sio_classname varchar(50)
          ,sio_viewname varchar(30)
          ,sio_code varchar(30)
          ,sio_strsql varchar(4000)
          ,sio_totalcount numeric(22,0)
          ,sio_recordcount numeric(22,0)
          ,sio_start_record numeric(22,0)
          ,sio_end_record numeric(22,0)
          ,sio_sord varchar(256)
          ,sio_search varchar(10)
          ,sio_sidx varchar(256)
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,unit_dataprecision  numeric (38,0)
,itm_material  varchar (50) 
,classlist_name  varchar (100) 
,classlist_code  varchar (50) 
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,itm_datascale  numeric (22,0)
,itm_design  varchar (50) 
,itm_weight  numeric (22,0)
,itm_length  numeric (22,0)
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_contents  varchar (4000) 
,itm_remark  varchar (4000) 
,itm_expiredate   date 
,itm_created_at   timestamp(6) 
,itm_updated_at   timestamp(6) 
,itm_update_ip  varchar (40) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,id  numeric (22,0)
,itm_id  numeric (22,0)
,itm_person_id_upd  numeric (22,0)
          ,sio_errline varchar(4000)
          ,sio_org_tblname varchar(30)
          ,sio_org_tblid numeric(22,0)
          ,sio_add_time date
          ,sio_replay_time date
          ,sio_result_f char(1)
          ,sio_message_code char(10)
          ,sio_message_contents varchar(4000)
          ,sio_chk_done char(1)
);
 CREATE INDEX sio_r_itms_uk1 
  ON sio.sio_r_itms(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_itms_seq ;
 create sequence sio.sio_r_itms_seq ;
  drop view if  exists r_opeitms cascade ; 
 create or replace view r_opeitms as select  
opeitm.units_id_prdpurshp   opeitm_unit_id_prdpurshp,
  unit_prdpurshp.unit_name  unit_name_prdpurshp ,
  unit_prdpurshp.unit_code  unit_code_prdpurshp ,
  loca.loca_abbr  loca_abbr ,
  itm.itm_name  itm_name ,
  loca.loca_addr2  loca_addr2 ,
  itm.itm_std  itm_std ,
  itm.itm_code  itm_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  loca.loca_code  loca_code ,
  loca.loca_zip  loca_zip ,
  loca.loca_name  loca_name ,
  loca.loca_addr1  loca_addr1 ,
  loca.loca_prfct  loca_prfct ,
  itm.itm_unit_id  itm_unit_id ,
opeitm.processseq  opeitm_processseq,
opeitm.minqty  opeitm_minqty,
opeitm.expiredate  opeitm_expiredate,
opeitm.persons_id_upd   opeitm_person_id_upd,
opeitm.update_ip  opeitm_update_ip,
opeitm.updated_at  opeitm_updated_at,
opeitm.packqty  opeitm_packqty,
opeitm.priority  opeitm_priority,
opeitm.created_at  opeitm_created_at,
opeitm.itms_id   opeitm_itm_id,
opeitm.id  opeitm_id,
opeitm.locas_id   opeitm_loca_id,
opeitm.duration  opeitm_duration,
opeitm.id id,
opeitm.remark  opeitm_remark,
opeitm.operation  opeitm_operation,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
opeitm.maxqty  opeitm_maxqty,
opeitm.opt_fixoterm  opeitm_opt_fixoterm,
opeitm.autocreate_ord  opeitm_autocreate_ord,
opeitm.autocreate_inst  opeitm_autocreate_inst,
opeitm.prdpurshp  opeitm_prdpurshp,
opeitm.safestkqty  opeitm_safestkqty,
  unit_case.unit_code  unit_code_case ,
  unit_case.unit_name  unit_name_case ,
opeitm.units_id_case   opeitm_unit_id_case,
  shelfno.shelfno_code  shelfno_code ,
  shelfno.shelfno_name  shelfno_name ,
  shelfno.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  shelfno.loca_code_shelfno  loca_code_shelfno ,
  shelfno.loca_name_shelfno  loca_name_shelfno ,
opeitm.contents  opeitm_contents,
opeitm.autocreate_act  opeitm_autocreate_act,
opeitm.shuffle_flg  opeitm_shuffle_flg,
opeitm.shuffle_loca  opeitm_shuffle_loca,
opeitm.chkord_proc  opeitm_chkord_proc,
opeitm.esttosch  opeitm_esttosch,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
opeitm.rule_price  opeitm_rule_price,
opeitm.mold  opeitm_mold,
  boxe.boxe_boxtype  boxe_boxtype ,
  boxe.boxe_unit_id_box  boxe_unit_id_box ,
  boxe.unit_code_box  unit_code_box ,
  boxe.unit_name_box  unit_name_box ,
  boxe.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  boxe.unit_code_outbox  unit_code_outbox ,
  boxe.unit_name_outbox  unit_name_outbox ,
  boxe.boxe_code  boxe_code ,
  boxe.boxe_name  boxe_name ,
opeitm.boxes_id   opeitm_boxe_id,
opeitm.opt_fix_flg  opeitm_opt_fix_flg,
opeitm.prjalloc_flg  opeitm_prjalloc_flg,
opeitm.units_lttime  opeitm_units_lttime,
opeitm.autoord_p  opeitm_autoord_p,
opeitm.autoinst_p  opeitm_autoinst_p,
opeitm.autoact_p  opeitm_autoact_p,
opeitm.shelfnos_id   opeitm_shelfno_id,
  itm.itm_classlist_id  itm_classlist_id ,
opeitm.stktaking_proc  opeitm_stktaking_proc,
opeitm.acceptance_proc  opeitm_acceptance_proc,
opeitm.lotno_proc  opeitm_lotno_proc,
opeitm.chkinst_proc  opeitm_chkinst_proc,
opeitm.packno_proc  opeitm_packno_proc
 from opeitms   opeitm,
  r_units  unit_prdpurshp ,  r_persons  person_upd ,  r_itms  itm ,  r_locas  loca ,  r_units  unit_case ,  r_boxes  boxe ,  r_shelfnos  shelfno 
  where       opeitm.units_id_prdpurshp = unit_prdpurshp.id      and opeitm.persons_id_upd = person_upd.id      and opeitm.itms_id = itm.id      and opeitm.locas_id = loca.id      and opeitm.units_id_case = unit_case.id      and opeitm.boxes_id = boxe.id      and opeitm.shelfnos_id = shelfno.id     ;
 DROP TABLE IF EXISTS sio.sio_r_opeitms;
 CREATE TABLE sio.sio_r_opeitms (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_opeitms_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
          ,sio_Term_id varchar(30)
          ,sio_session_id numeric(22,0)
          ,sio_Command_Response char(1)
          ,sio_session_counter numeric(22,0)
          ,sio_classname varchar(50)
          ,sio_viewname varchar(30)
          ,sio_code varchar(30)
          ,sio_strsql varchar(4000)
          ,sio_totalcount numeric(22,0)
          ,sio_recordcount numeric(22,0)
          ,sio_start_record numeric(22,0)
          ,sio_end_record numeric(22,0)
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
,opeitm_packqty  numeric (38,0)
,opeitm_minqty  numeric (38,6)
,opeitm_maxqty  numeric (22,0)
,opeitm_duration  numeric (38,2)
,opeitm_autoinst_p  numeric (3,0)
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
,opeitm_autocreate_ord  varchar (1) 
,opeitm_stktaking_proc  varchar (1) 
,opeitm_acceptance_proc  varchar (1) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_rule_price  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_shuffle_flg  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_safestkqty  numeric (38,0)
,opeitm_units_lttime  varchar (4) 
,opeitm_chkord_proc  numeric (3,0)
,itm_std  varchar (50) 
,opeitm_esttosch  numeric (22,0)
,opeitm_mold  varchar (1) 
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_autoord_p  numeric (3,0)
,opeitm_autoact_p  numeric (3,0)
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_chkinst_proc  varchar (1) 
,opeitm_packno_proc  varchar (1) 
,opeitm_lotno_proc  varchar (3) 
,opeitm_expiredate   date 
,boxe_boxtype  varchar (20) 
,opeitm_contents  varchar (4000) 
,opeitm_remark  varchar (4000) 
,opeitm_update_ip  varchar (40) 
,opeitm_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_created_at   timestamp(6) 
,opeitm_person_id_upd  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,person_name_upd  varchar (100) 
,opeitm_updated_at   timestamp 
,opeitm_unit_id_case  numeric (38,0)
,loca_prfct  varchar (20) 
,loca_addr1  varchar (50) 
,loca_zip  varchar (10) 
,opeitm_boxe_id  numeric (22,0)
,id  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,loca_addr2  varchar (50) 
,loca_abbr  varchar (50) 
,shelfno_loca_id_shelfno  numeric (38,0)
,person_code_upd  varchar (50) 
          ,sio_errline varchar(4000)
          ,sio_org_tblname varchar(30)
          ,sio_org_tblid numeric(22,0)
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
  drop view if  exists r_nditms cascade ; 
 create or replace view r_nditms as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
nditm.contents  nditm_contents,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
nditm.parenum  nditm_parenum,
nditm.created_at  nditm_created_at,
nditm.opeitms_id   nditm_opeitm_id,
nditm.consumunitqty  nditm_consumunitqty,
nditm.persons_id_upd   nditm_person_id_upd,
nditm.updated_at  nditm_updated_at,
nditm.id  nditm_id,
nditm.remark  nditm_remark,
nditm.expiredate  nditm_expiredate,
nditm.update_ip  nditm_update_ip,
nditm.consumtype  nditm_consumtype,
  itm_nditm.itm_code  itm_code_nditm ,
  itm_nditm.itm_design  itm_design_nditm ,
  itm_nditm.itm_deth  itm_deth_nditm ,
  itm_nditm.itm_length  itm_length_nditm ,
  itm_nditm.itm_material  itm_material_nditm ,
  itm_nditm.itm_model  itm_model_nditm ,
  itm_nditm.itm_name  itm_name_nditm ,
  itm_nditm.itm_std  itm_std_nditm ,
  itm_nditm.itm_weight  itm_weight_nditm ,
nditm.itms_id_nditm   nditm_itm_id_nditm,
  itm_nditm.unit_code  unit_code_nditm ,
  itm_nditm.unit_name  unit_name_nditm ,
nditm.chilnum  nditm_chilnum,
  opeitm.opeitm_duration  opeitm_duration ,
  itm_nditm.itm_wide  itm_wide_nditm ,
nditm.id id,
  itm_nditm.itm_unit_id  itm_unit_id_nditm ,
  opeitm.opeitm_operation  opeitm_operation ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  opeitm.opeitm_prdpurshp  opeitm_prdpurshp ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.opeitm_chkord_proc  opeitm_chkord_proc ,
  opeitm.opeitm_esttosch  opeitm_esttosch ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  opeitm.opeitm_mold  opeitm_mold ,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  loca_fm.loca_code  loca_code_fm ,
  loca_fm.loca_name  loca_name_fm ,
nditm.consumauto  nditm_consumauto,
nditm.processseq_nditm  nditm_processseq_nditm,
  opeitm.opeitm_opt_fix_flg  opeitm_opt_fix_flg ,
  opeitm.opeitm_prjalloc_flg  opeitm_prjalloc_flg ,
  opeitm.opeitm_autoord_p  opeitm_autoord_p ,
nditm.byproduct  nditm_byproduct,
nditm.consumminqty  nditm_consumminqty,
nditm.consumchgoverqty  nditm_consumchgoverqty,
  opeitm.itm_classlist_id  itm_classlist_id ,
  itm_nditm.itm_classlist_id  itm_classlist_id_nditm ,
  itm_nditm.classlist_name  classlist_name_nditm ,
  itm_nditm.classlist_code  classlist_code_nditm ,
nditm.locas_id_fm   nditm_loca_id_fm,
nditm.price  nditm_price,
nditm.crrs_id   nditm_crr_id
 from nditms   nditm,
  r_opeitms  opeitm ,  r_persons  person_upd ,  r_itms  itm_nditm ,  r_locas  loca_fm ,  r_crrs  crr 
  where       nditm.opeitms_id = opeitm.id      and nditm.persons_id_upd = person_upd.id      and nditm.itms_id_nditm = itm_nditm.id      and nditm.locas_id_fm = loca_fm.id      and nditm.crrs_id = crr.id     ;
 DROP TABLE IF EXISTS sio.sio_r_nditms;
 CREATE TABLE sio.sio_r_nditms (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_nditms_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
          ,sio_Term_id varchar(30)
          ,sio_session_id numeric(22,0)
          ,sio_Command_Response char(1)
          ,sio_session_counter numeric(22,0)
          ,sio_classname varchar(50)
          ,sio_viewname varchar(30)
          ,sio_code varchar(30)
          ,sio_strsql varchar(4000)
          ,sio_totalcount numeric(22,0)
          ,sio_recordcount numeric(22,0)
          ,sio_start_record numeric(22,0)
          ,sio_end_record numeric(22,0)
          ,sio_sord varchar(256)
          ,sio_search varchar(10)
          ,sio_sidx varchar(256)
,itm_code  varchar (50) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
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
,opeitm_packqty  numeric (38,0)
,nditm_consumtype  varchar (3) 
,loca_code_fm  varchar (50) 
,loca_name_fm  varchar (100) 
,nditm_consumunitqty  numeric (38,0)
,nditm_consumauto  varchar (1) 
,classlist_code  varchar (50) 
,crr_name  varchar (100) 
,crr_code  varchar (50) 
,classlist_name_nditm  varchar (100) 
,classlist_name  varchar (100) 
,classlist_code_nditm  varchar (50) 
,boxe_name  varchar (100) 
,boxe_code  varchar (50) 
,nditm_expiredate   date 
,nditm_byproduct  varchar (1) 
,nditm_consumminqty  numeric (22,6)
,nditm_consumchgoverqty  numeric (22,6)
,nditm_price  numeric (38,4)
,opeitm_autoord_p  numeric (3,0)
,loca_name_shelfno  varchar (100) 
,loca_code_shelfno  varchar (50) 
,shelfno_name  varchar (100) 
,opeitm_prdpurshp  varchar (20) 
,itm_material_nditm  varchar (50) 
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
,nditm_remark  varchar (4000) 
,nditm_contents  varchar (4000) 
,nditm_crr_id  numeric (22,0)
,nditm_opeitm_id  numeric (38,0)
,nditm_loca_id_fm  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,itm_unit_id_nditm  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_classlist_id_nditm  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_operation  varchar (20) 
,opeitm_esttosch  numeric (22,0)
,opeitm_chkord_proc  numeric (3,0)
,opeitm_mold  varchar (1) 
,nditm_itm_id_nditm  numeric (38,0)
,opeitm_duration  numeric (38,2)
,nditm_update_ip  varchar (40) 
,id  numeric (38,0)
,nditm_id  numeric (38,0)
,nditm_updated_at   timestamp(6) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_prjalloc_flg  numeric (22,0)
,nditm_person_id_upd  numeric (38,0)
,nditm_created_at   timestamp(6) 
          ,sio_errline varchar(4000)
          ,sio_org_tblname varchar(30)
          ,sio_org_tblid numeric(22,0)
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
