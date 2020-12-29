
 --- drop view r_schofmkords cascade  
 create or replace view r_schofmkords as select  
schofmkord.created_at  schofmkord_created_at,
schofmkord.updated_at  schofmkord_updated_at,
schofmkord.persons_id_upd   schofmkord_person_id_upd,
schofmkord.id id,
schofmkord.id  schofmkord_id,
schofmkord.mkords_id   schofmkord_mkord_id,
schofmkord.trngantts_id   schofmkord_trngantt_id,
schofmkord.expiredate  schofmkord_expiredate,
schofmkord.contents  schofmkord_contents,
schofmkord.remark  schofmkord_remark,
schofmkord.processseq  schofmkord_processseq,
schofmkord.itms_id   schofmkord_itm_id,
schofmkord.update_ip  schofmkord_update_ip,
  mkord.loca_name_sect_chrg_trn  loca_name_sect_chrg_trn ,
  mkord.loca_code_sect_chrg_trn  loca_code_sect_chrg_trn ,
  mkord.person_name_chrg_trn  person_name_chrg_trn ,
  mkord.person_code_chrg_trn  person_code_chrg_trn ,
  mkord.loca_name_org  loca_name_org ,
  mkord.loca_code_org  loca_code_org ,
  mkord.itm_name_pare  itm_name_pare ,
  mkord.loca_name_pare  loca_name_pare ,
  mkord.loca_name_trn  loca_name_trn ,
  mkord.itm_name_trn  itm_name_trn ,
  mkord.loca_code_trn  loca_code_trn ,
  mkord.itm_code_pare  itm_code_pare ,
  mkord.itm_name_org  itm_name_org ,
  mkord.loca_code_pare  loca_code_pare ,
  mkord.loca_name_to  loca_name_to ,
  mkord.loca_code_to  loca_code_to ,
  mkord.classlist_name_pare  classlist_name_pare ,
  mkord.person_sect_id_chrg_trn  person_sect_id_chrg_trn ,
  mkord.itm_code_trn  itm_code_trn ,
  mkord.itm_code_org  itm_code_org ,
  mkord.mkord_loca_id_to  mkord_loca_id_to ,
  mkord.mkord_message_code  mkord_message_code ,
  mkord.mkord_loca_id_trn  mkord_loca_id_trn ,
  mkord.classlist_name_org  classlist_name_org ,
  mkord.mkord_itm_id_org  mkord_itm_id_org ,
  mkord.mkord_itm_id_trn  mkord_itm_id_trn ,
  mkord.mkord_loca_id_org  mkord_loca_id_org ,
  mkord.mkord_loca_id_pare  mkord_loca_id_pare ,
  mkord.mkord_itm_id_pare  mkord_itm_id_pare ,
  mkord.mkord_chrg_id_trn  mkord_chrg_id_trn ,
  mkord.classlist_code_org  classlist_code_org ,
  trngantt.itm_code  itm_code ,
  trngantt.itm_name  itm_name ,
  trngantt.trngantt_itm_id  trngantt_itm_id ,
  trngantt.trngantt_loca_id  trngantt_loca_id ,
  trngantt.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  trngantt.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  trngantt.trngantt_loca_id_pare  trngantt_loca_id_pare ,
  trngantt.trngantt_prjno_id  trngantt_prjno_id ,
  trngantt.itm_classlist_id  itm_classlist_id ,
  trngantt.itm_unit_id  itm_unit_id ,
  trngantt.classlist_name  classlist_name ,
  trngantt.classlist_code  classlist_code ,
  trngantt.unit_name  unit_name ,
  trngantt.unit_code  unit_code ,
  trngantt.loca_code  loca_code ,
  trngantt.loca_name  loca_name ,
  trngantt.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  trngantt.shelfno_name_fm  shelfno_name_fm ,
  trngantt.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  trngantt.shelfno_code_fm  shelfno_code_fm ,
  trngantt.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  trngantt.itm_classlist_id_pare  itm_classlist_id_pare ,
  trngantt.itm_unit_id_pare  itm_unit_id_pare ,
  trngantt.classlist_code_pare  classlist_code_pare ,
  trngantt.unit_name_pare  unit_name_pare ,
  trngantt.unit_code_pare  unit_code_pare ,
  trngantt.prjno_name  prjno_name ,
  trngantt.prjno_code  prjno_code ,
  trngantt.prjno_code_chil  prjno_code_chil 
 from schofmkords   schofmkord,
  r_persons  person_upd ,  r_mkords  mkord ,  r_trngantts  trngantt ,  r_itms  itm 
  where       schofmkord.persons_id_upd = person_upd.id      and schofmkord.mkords_id = mkord.id      and schofmkord.trngantts_id = trngantt.id      and schofmkord.itms_id = itm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_schofmkords;
 CREATE TABLE sio.sio_r_schofmkords (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_schofmkords_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,loca_name_pare  varchar (100) 
,loca_name_trn  varchar (100) 
,itm_name_trn  varchar (100) 
,loca_code_trn  varchar (50) 
,itm_code_pare  varchar (50) 
,itm_name_org  varchar (100) 
,loca_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,shelfno_code_fm  varchar (50) 
,shelfno_name_fm  varchar (100) 
,loca_name_to  varchar (100) 
,loca_code_to  varchar (50) 
,classlist_name_pare  varchar (100) 
,loca_code  varchar (50) 
,loca_name_sect_chrg_trn  varchar (100) 
,loca_code_sect_chrg_trn  varchar (50) 
,itm_code_trn  varchar (50) 
,itm_code_org  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,unit_code  varchar (50) 
,mkord_message_code  varchar (256) 
,prjno_code_chil  varchar (50) 
,unit_name  varchar (100) 
,classlist_name_org  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,itm_name  varchar (100) 
,itm_code  varchar (50) 
,person_name_chrg_trn  varchar (100) 
,classlist_code_org  varchar (50) 
,person_code_chrg_trn  varchar (50) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,unit_code_pare  varchar (50) 
,unit_name_pare  varchar (100) 
,classlist_code_pare  varchar (50) 
,loca_name  varchar (100) 
,loca_code_shelfno_fm  varchar (50) 
,loca_name_org  varchar (100) 
,loca_code_org  varchar (50) 
,schofmkord_processseq  numeric (38,0)
,schofmkord_expiredate   date 
,mkord_skipamt  numeric (38,4)
,mkord_gno_trn  varchar (50) 
,itm_std_org  varchar (50) 
,mkord_sno_org  varchar (50) 
,mkord_orgtblname  varchar (20) 
,mkord_duedate_trn   timestamp(6) 
,mkord_confirm  varchar (1) 
,mkord_isudate   timestamp(6) 
,mkord_cmpldate   timestamp(6) 
,mkord_result_f  varchar (1) 
,mkord_runtime  numeric (2,0)
,mkord_opeitm_processseq_trn  varchar (3) 
,mkord_duedate_pare   timestamp(6) 
,mkord_starttime_trn   timestamp(6) 
,mkord_sno_pare  varchar (50) 
,mkord_outcnt  numeric (38,0)
,mkord_incnt  numeric (38,0)
,mkord_outqty  numeric (22,6)
,mkord_inamt  numeric (38,4)
,mkord_outamt  numeric (38,4)
,mkord_skipcnt  numeric (38,0)
,mkord_opeitm_operation_trn  varchar (40) 
,mkord_skipqty  numeric (22,6)
,mkord_inqty  numeric (22,6)
,mkord_paretblname  varchar (20) 
,mkord_tblname  varchar (20) 
,mkord_opeitm_processseq_org  varchar (3) 
,mkord_manual  varchar (1) 
,mkord_duedate_org   timestamp(6) 
,mkord_opeitm_processseq_pare  varchar (3) 
,mkord_sno_trn  varchar (50) 
,trngantt_processseq_pare  numeric (38,0)
,trngantt_duedate_org   timestamp(6) 
,trngantt_consumtype  varchar (3) 
,loca_tel_pare  varchar (20) 
,trngantt_tblid  numeric (38,0)
,trngantt_qty_pare  numeric (22,6)
,trngantt_paretblname  varchar (30) 
,trngantt_paretblid  numeric (38,0)
,trngantt_qty_alloc  numeric (22,6)
,trngantt_qty_stk_pare  numeric (22,6)
,trngantt_qty_pare_alloc  numeric (22,6)
,trngantt_orgtblid  numeric (22,0)
,trngantt_mlevel  numeric (3,0)
,trngantt_consumauto  varchar (1) 
,trngantt_shuffle_flg  varchar (1) 
,trngantt_key  varchar (250) 
,trngantt_parenum  numeric (22,0)
,trngantt_chilnum  numeric (22,0)
,trngantt_qty  numeric (18,4)
,trngantt_qty_stk  numeric (22,0)
,trngantt_orgtblname  varchar (30) 
,itm_weight  numeric (22,0)
,unit_contents  varchar (4000) 
,itm_length  numeric (22,0)
,itm_design  varchar (50) 
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,itm_material  varchar (50) 
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,itm_datascale  numeric (22,0)
,trngantt_qty_linkto_alloctbl  numeric (22,0)
,trngantt_tblname  varchar (30) 
,trngantt_processseq  numeric (38,0)
,trngantt_duedate   timestamp(6) 
,trngantt_consumchgoverqty  numeric (22,6)
,trngantt_starttime   timestamp(6) 
,trngantt_consumminqty  numeric (22,6)
,trngantt_consumunitqty  numeric (22,6)
,trngantt_qty_bal  numeric (22,6)
,trngantt_qty_pare_bal  numeric (22,6)
,schofmkord_contents  varchar (4000) 
,schofmkord_remark  varchar (4000) 
,schofmkord_itm_id  numeric (38,0)
,schofmkord_created_at   timestamp(6) 
,schofmkord_update_ip  varchar (40) 
,schofmkord_trngantt_id  numeric (38,0)
,schofmkord_mkord_id  numeric (22,0)
,schofmkord_id  numeric (38,0)
,schofmkord_person_id_upd  numeric (38,0)
,schofmkord_updated_at   timestamp(6) 
,id  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,mkord_itm_id_trn  numeric (38,0)
,mkord_itm_id_org  numeric (38,0)
,mkord_loca_id_trn  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,trngantt_itm_id_pare  numeric (38,0)
,mkord_loca_id_to  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,person_sect_id_chrg_trn  numeric (22,0)
,mkord_chrg_id_trn  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,mkord_loca_id_pare  numeric (38,0)
,mkord_loca_id_org  numeric (38,0)
,mkord_itm_id_pare  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
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
 CREATE INDEX sio_r_schofmkords_uk1 
  ON sio.sio_r_schofmkords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_schofmkords_seq ;
 create sequence sio.sio_r_schofmkords_seq ;
 --- drop view r_purschs cascade  
 create or replace view r_purschs as select  
pursch.qty  pursch_qty,
pursch.duedate  pursch_duedate,
pursch.amt  pursch_amt,
pursch.tax  pursch_tax,
pursch.price  pursch_price,
pursch.created_at  pursch_created_at,
pursch.sno  pursch_sno,
pursch.crrs_id_pur   pursch_crr_id_pur,
pursch.qty_bal  pursch_qty_bal,
pursch.remark  pursch_remark,
pursch.update_ip  pursch_update_ip,
pursch.toduedate  pursch_toduedate,
  opeitm.opeitm_processseq  opeitm_processseq ,
pursch.isudate  pursch_isudate,
pursch.expiredate  pursch_expiredate,
pursch.updated_at  pursch_updated_at,
pursch.id id,
pursch.id  pursch_id,
pursch.persons_id_upd   pursch_person_id_upd,
pursch.prjnos_id   pursch_prjno_id,
pursch.starttime  pursch_starttime,
pursch.shelfnos_id_to   pursch_shelfno_id_to,
pursch.gno  pursch_gno,
pursch.qty_case  pursch_qty_case,
pursch.suppliers_id   pursch_supplier_id,
pursch.opeitms_id   pursch_opeitm_id,
pursch.chrgs_id   pursch_chrg_id,
  crr_pur.crr_name  crr_name_pur ,
  crr_pur.crr_code  crr_code_pur ,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code  prjno_code ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.loca_code  loca_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.boxe_code  boxe_code ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.itm_code  itm_code ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  opeitm.itm_name  itm_name ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  supplier.scrlv_code_chrg_supplier  scrlv_code_chrg_supplier ,
  supplier.loca_code_supplier  loca_code_supplier ,
  supplier.loca_name_supplier  loca_name_supplier ,
  supplier.supplier_payment_id  supplier_payment_id ,
  supplier.supplier_loca_id_supplier  supplier_loca_id_supplier ,
  supplier.supplier_chrg_id_supplier  supplier_chrg_id_supplier ,
  supplier.supplier_crr_id_supplier  supplier_crr_id_supplier ,
  supplier.payment_chrg_id_payment  payment_chrg_id_payment ,
  supplier.person_name_chrg_supplier  person_name_chrg_supplier ,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  supplier.loca_code_sect_chrg_supplier  loca_code_sect_chrg_supplier ,
  supplier.person_code_chrg_supplier  person_code_chrg_supplier ,
  supplier.usrgrp_name_chrg_supplier  usrgrp_name_chrg_supplier ,
  supplier.loca_name_sect_chrg_supplier  loca_name_sect_chrg_supplier ,
  supplier.scrlv_code_chrg_payment  scrlv_code_chrg_payment ,
  supplier.usrgrp_code_chrg_supplier  usrgrp_code_chrg_supplier ,
  supplier.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment ,
  supplier.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment ,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.person_code_chrg_payment  person_code_chrg_payment ,
  supplier.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment ,
  supplier.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment ,
  supplier.person_name_chrg_payment  person_name_chrg_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  supplier.crr_code_supplier  crr_code_supplier ,
  supplier.crr_name_supplier  crr_name_supplier ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.loca_name  loca_name 
 from purschs   pursch,
  r_crrs  crr_pur ,  r_persons  person_upd ,  r_prjnos  prjno ,  r_shelfnos  shelfno_to ,  r_suppliers  supplier ,  r_opeitms  opeitm ,  r_chrgs  chrg 
  where       pursch.crrs_id_pur = crr_pur.id      and pursch.persons_id_upd = person_upd.id      and pursch.prjnos_id = prjno.id      and pursch.shelfnos_id_to = shelfno_to.id      and pursch.suppliers_id = supplier.id      and pursch.opeitms_id = opeitm.id      and pursch.chrgs_id = chrg.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purschs;
 CREATE TABLE sio.sio_r_purschs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purschs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,pursch_sno  varchar (40) 
,pursch_duedate   timestamp(6) 
,pursch_qty  numeric (18,4)
,pursch_price  numeric (38,4)
,pursch_amt  numeric (18,4)
,pursch_tax  numeric (38,4)
,opeitm_processseq  numeric (3,0)
,pursch_gno  varchar (40) 
,loca_code_shelfno_to  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,unit_name_box  varchar (100) 
,unit_code_box  varchar (50) 
,crr_name_pur  varchar (100) 
,crr_code_pur  varchar (50) 
,prjno_code_chil  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,shelfno_name_to  varchar (100) 
,shelfno_code_to  varchar (50) 
,loca_name_shelfno  varchar (100) 
,loca_code  varchar (50) 
,boxe_name  varchar (100) 
,boxe_code  varchar (50) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,loca_code_shelfno  varchar (50) 
,scrlv_code_chrg_supplier  varchar (50) 
,loca_code_supplier  varchar (50) 
,loca_name_supplier  varchar (100) 
,person_name_chrg_supplier  varchar (100) 
,loca_code_sect_chrg_supplier  varchar (50) 
,person_code_chrg_supplier  varchar (50) 
,usrgrp_name_chrg_supplier  varchar (100) 
,loca_name_sect_chrg_supplier  varchar (100) 
,scrlv_code_chrg_payment  varchar (50) 
,usrgrp_code_chrg_supplier  varchar (50) 
,loca_code_sect_chrg_payment  varchar (50) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_code_payment  varchar (50) 
,person_code_chrg_payment  varchar (50) 
,usrgrp_code_chrg_payment  varchar (50) 
,usrgrp_name_chrg_payment  varchar (100) 
,person_name_chrg_payment  varchar (100) 
,loca_name_payment  varchar (100) 
,crr_code_supplier  varchar (50) 
,crr_name_supplier  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,person_code_chrg  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,unit_name  varchar (100) 
,unit_name_case  varchar (100) 
,unit_name_outbox  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,unit_code  varchar (50) 
,unit_code_case  varchar (50) 
,unit_code_outbox  varchar (50) 
,loca_name  varchar (100) 
,pursch_expiredate   date 
,pursch_qty_case  numeric (22,0)
,pursch_starttime   timestamp(6) 
,pursch_qty_bal  numeric (22,6)
,pursch_isudate   timestamp(6) 
,pursch_toduedate   timestamp(6) 
,loca_zip_supplier  varchar (10) 
,loca_country_supplier  varchar (20) 
,scrlv_level1_chrg  varchar (1) 
,opeitm_autoord_p  numeric (3,0)
,opeitm_duration  numeric (38,2)
,opeitm_safestkqty  numeric (38,0)
,shelfno_contents_to  varchar (4000) 
,opeitm_autoact_p  numeric (3,0)
,opeitm_units_lttime  varchar (4) 
,opeitm_autocreate_ord  varchar (1) 
,person_email_chrg  varchar (50) 
,opeitm_prdpurshp  varchar (20) 
,opeitm_operation  varchar (20) 
,opeitm_autoinst_p  numeric (3,0)
,opeitm_maxqty  numeric (22,0)
,loca_prfct_supplier  varchar (20) 
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_priority  numeric (3,0)
,loca_tel_supplier  varchar (20) 
,opeitm_chkord  varchar (1) 
,opeitm_chkinst  varchar (1) 
,opeitm_mold  varchar (1) 
,supplier_amtdecimal  numeric (38,0)
,opeitm_packno_flg  varchar (1) 
,opeitm_opt_fix_flg  varchar (1) 
,supplier_custtype  varchar (1) 
,opeitm_minqty  numeric (38,6)
,opeitm_packqty  numeric (38,0)
,opeitm_esttosch  numeric (22,0)
,opeitm_chkord_prc  numeric (3,0)
,supplier_contents  varchar (4000) 
,supplier_contract_price  varchar (1) 
,supplier_rule_price  varchar (1) 
,supplier_amtround  varchar (2) 
,opeitm_rule_price  varchar (1) 
,supplier_personname  varchar (30) 
,opeitm_acceptance_proc  varchar (1) 
,loca_addr1_supplier  varchar (50) 
,opeitm_shuffle_flg  varchar (1) 
,opeitm_stktaking_proc  varchar (1) 
,opeitm_contents  varchar (4000) 
,itm_std  varchar (50) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_autocreate_inst  varchar (1) 
,loca_fax_supplier  varchar (20) 
,loca_addr2_supplier  varchar (50) 
,loca_mail_supplier  varchar (20) 
,opeitm_autocreate_act  varchar (1) 
,crr_contents_pur  varchar (4000) 
,loca_abbr_supplier  varchar (50) 
,crr_amtdecimal_pur  numeric (22,0)
,crr_pricedecimal_pur  numeric (22,0)
,boxe_boxtype  varchar (20) 
,pursch_remark  varchar (4000) 
,pursch_created_at   timestamp(6) 
,pursch_supplier_id  numeric (22,0)
,pursch_updated_at   timestamp(6) 
,id  numeric (38,0)
,pursch_id  numeric (38,0)
,pursch_person_id_upd  numeric (38,0)
,pursch_prjno_id  numeric (38,0)
,pursch_chrg_id  numeric (38,0)
,pursch_shelfno_id_to  numeric (38,0)
,pursch_update_ip  varchar (40) 
,pursch_opeitm_id  numeric (38,0)
,pursch_crr_id_pur  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,loca_prfct_shelfno  varchar (20) 
,loca_addr1  varchar (50) 
,loca_addr1_shelfno  varchar (50) 
,opeitm_itm_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,loca_addr2  varchar (50) 
,loca_mail_shelfno  varchar (20) 
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,loca_addr2_shelfno  varchar (50) 
,supplier_payment_id  numeric (38,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
,payment_chrg_id_payment  numeric (22,0)
,loca_tel_shelfno  varchar (20) 
,person_sect_id_chrg_payment  numeric (22,0)
,payment_loca_id_payment  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,loca_fax_shelfno  varchar (20) 
,chrg_person_id_chrg  numeric (38,0)
,loca_abbr  varchar (50) 
,loca_abbr_shelfno  varchar (50) 
,loca_zip  varchar (10) 
,shelfno_loca_id_shelfno_to  numeric (38,0)
,loca_zip_shelfno  varchar (10) 
,loca_country_shelfno  varchar (20) 
,loca_prfct  varchar (20) 
,opeitm_shelfno_id  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
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
 CREATE INDEX sio_r_purschs_uk1 
  ON sio.sio_r_purschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purschs_seq ;
 create sequence sio.sio_r_purschs_seq ;
 --- drop view r_prdschs cascade  
 create or replace view r_prdschs as select  
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  shelfno_to.shelfno_code  shelfno_code_to ,
prdsch.isudate  prdsch_isudate,
prdsch.toduedate  prdsch_toduedate,
  prjno.prjno_code_chil  prjno_code_chil ,
prdsch.qty_case  prdsch_qty_case,
prdsch.starttime  prdsch_starttime,
prdsch.qty  prdsch_qty,
prdsch.duedate  prdsch_duedate,
  chrg.person_code_chrg  person_code_chrg ,
  prjno.prjno_code  prjno_code ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  prjno.prjno_name  prjno_name ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
prdsch.sno  prdsch_sno,
  chrg.person_name_chrg  person_name_chrg ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.itm_std  itm_std ,
  opeitm.loca_name  loca_name ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.opeitm_priority  opeitm_priority ,
prdsch.chrgs_id   prdsch_chrg_id,
prdsch.qty_bal  prdsch_qty_bal,
prdsch.expiredate  prdsch_expiredate,
prdsch.persons_id_upd   prdsch_person_id_upd,
prdsch.update_ip  prdsch_update_ip,
prdsch.created_at  prdsch_created_at,
prdsch.updated_at  prdsch_updated_at,
prdsch.id id,
prdsch.id  prdsch_id,
prdsch.opeitms_id   prdsch_opeitm_id,
prdsch.shelfnos_id_to   prdsch_shelfno_id_to,
prdsch.gno  prdsch_gno,
prdsch.remark  prdsch_remark,
prdsch.prjnos_id   prdsch_prjno_id,
prdsch.workplaces_id   prdsch_workplace_id,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.boxe_code  boxe_code ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.classlist_code  classlist_code ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.classlist_name  classlist_name ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  workplace.workplace_loca_id_workplace  workplace_loca_id_workplace ,
  workplace.workplace_chrg_id_workplace  workplace_chrg_id_workplace ,
  workplace.loca_code_sect_chrg_workplace  loca_code_sect_chrg_workplace ,
  workplace.scrlv_code_chrg_workplace  scrlv_code_chrg_workplace ,
  workplace.person_code_chrg_workplace  person_code_chrg_workplace ,
  workplace.person_sect_id_chrg_workplace  person_sect_id_chrg_workplace ,
  workplace.chrg_person_id_chrg_workplace  chrg_person_id_chrg_workplace ,
  workplace.usrgrp_code_chrg_workplace  usrgrp_code_chrg_workplace ,
  workplace.usrgrp_name_chrg_workplace  usrgrp_name_chrg_workplace ,
  workplace.person_name_chrg_workplace  person_name_chrg_workplace ,
  workplace.loca_name_sect_chrg_workplace  loca_name_sect_chrg_workplace ,
  workplace.loca_code_workplace  loca_code_workplace ,
  workplace.loca_name_workplace  loca_name_workplace 
 from prdschs   prdsch,
  r_chrgs  chrg ,  r_persons  person_upd ,  r_opeitms  opeitm ,  r_shelfnos  shelfno_to ,  r_prjnos  prjno ,  r_workplaces  workplace 
  where       prdsch.chrgs_id = chrg.id      and prdsch.persons_id_upd = person_upd.id      and prdsch.opeitms_id = opeitm.id      and prdsch.shelfnos_id_to = shelfno_to.id      and prdsch.prjnos_id = prjno.id      and prdsch.workplaces_id = workplace.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdschs;
 CREATE TABLE sio.sio_r_prdschs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdschs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prdsch_sno  varchar (40) 
,prdsch_isudate   timestamp(6) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,itm_std  varchar (50) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,prdsch_qty  numeric (18,4)
,prdsch_duedate   timestamp(6) 
,prdsch_starttime   timestamp(6) 
,opeitm_processseq  numeric (3,0)
,opeitm_priority  numeric (3,0)
,loca_code_workplace  varchar (50) 
,loca_name_workplace  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,prdsch_gno  varchar (40) 
,loca_code_shelfno_to  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,prdsch_qty_case  numeric (38,0)
,prdsch_toduedate   timestamp(6) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,unit_code_case  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,boxe_code  varchar (50) 
,unit_name_box  varchar (100) 
,unit_name_case  varchar (100) 
,unit_name_outbox  varchar (100) 
,boxe_name  varchar (100) 
,loca_name_sect_chrg_workplace  varchar (100) 
,person_name_chrg_workplace  varchar (100) 
,usrgrp_name_chrg_workplace  varchar (100) 
,usrgrp_code_chrg_workplace  varchar (50) 
,person_code_chrg_workplace  varchar (50) 
,scrlv_code_chrg_workplace  varchar (50) 
,loca_code_sect_chrg_workplace  varchar (50) 
,classlist_name  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,classlist_code  varchar (50) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,unit_code_outbox  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,prdsch_qty_bal  numeric (22,6)
,prdsch_expiredate   date 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,opeitm_autoact_p  numeric (3,0)
,shelfno_contents_to  varchar (4000) 
,scrlv_level1_chrg  varchar (1) 
,person_email_chrg  varchar (50) 
,opeitm_prdpurshp  varchar (20) 
,opeitm_operation  varchar (20) 
,opeitm_autoinst_p  numeric (3,0)
,opeitm_maxqty  numeric (22,0)
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_chkord  varchar (1) 
,opeitm_chkinst  varchar (1) 
,opeitm_mold  varchar (1) 
,opeitm_packno_flg  varchar (1) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_units_lttime  varchar (4) 
,opeitm_minqty  numeric (38,6)
,opeitm_packqty  numeric (38,0)
,opeitm_esttosch  numeric (22,0)
,opeitm_chkord_prc  numeric (3,0)
,opeitm_rule_price  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_shuffle_flg  varchar (1) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_autocreate_inst  varchar (1) 
,opeitm_contents  varchar (4000) 
,opeitm_autocreate_ord  varchar (1) 
,opeitm_acceptance_proc  varchar (1) 
,opeitm_stktaking_proc  varchar (1) 
,boxe_boxtype  varchar (20) 
,opeitm_autoord_p  numeric (3,0)
,opeitm_safestkqty  numeric (38,0)
,opeitm_duration  numeric (38,2)
,workplace_contents  varchar (4000) 
,prjno_code_chil  varchar (50) 
,prdsch_remark  varchar (4000) 
,prdsch_created_at   timestamp(6) 
,prdsch_updated_at   timestamp(6) 
,prdsch_workplace_id  numeric (22,0)
,prdsch_opeitm_id  numeric (38,0)
,prdsch_id  numeric (38,0)
,prdsch_prjno_id  numeric (38,0)
,id  numeric (38,0)
,prdsch_update_ip  varchar (40) 
,prdsch_shelfno_id_to  numeric (38,0)
,prdsch_person_id_upd  numeric (38,0)
,prdsch_chrg_id  numeric (38,0)
,loca_abbr  varchar (50) 
,opeitm_shelfno_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,workplace_loca_id_workplace  numeric (22,0)
,workplace_chrg_id_workplace  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,loca_prfct  varchar (20) 
,loca_addr1  varchar (50) 
,loca_zip  varchar (10) 
,loca_addr2  varchar (50) 
,opeitm_itm_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,person_sect_id_chrg_workplace  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,chrg_person_id_chrg_workplace  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
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
 CREATE INDEX sio_r_prdschs_uk1 
  ON sio.sio_r_prdschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdschs_seq ;
 create sequence sio.sio_r_prdschs_seq ;
 --- drop view r_trngantts cascade  
 create or replace view r_trngantts as select  
trngantt.qty_linkto_alloctbl  trngantt_qty_linkto_alloctbl,
trngantt.tblname  trngantt_tblname,
trngantt.processseq  trngantt_processseq,
trngantt.duedate  trngantt_duedate,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name ,
trngantt.consumchgoverqty  trngantt_consumchgoverqty,
  loca_pare.loca_tel  loca_tel_pare ,
trngantt.tblid  trngantt_tblid,
trngantt.qty_pare  trngantt_qty_pare,
trngantt.paretblname  trngantt_paretblname,
trngantt.paretblid  trngantt_paretblid,
trngantt.qty_alloc  trngantt_qty_alloc,
trngantt.qty_stk_pare  trngantt_qty_stk_pare,
trngantt.qty_pare_alloc  trngantt_qty_pare_alloc,
trngantt.orgtblid  trngantt_orgtblid,
trngantt.mlevel  trngantt_mlevel,
trngantt.consumauto  trngantt_consumauto,
trngantt.shuffle_flg  trngantt_shuffle_flg,
trngantt.starttime  trngantt_starttime,
trngantt.itms_id   trngantt_itm_id,
trngantt.locas_id   trngantt_loca_id,
trngantt.consumminqty  trngantt_consumminqty,
trngantt.consumunitqty  trngantt_consumunitqty,
trngantt.qty_pare_bal  trngantt_qty_pare_bal,
trngantt.qty_bal  trngantt_qty_bal,
trngantt.id  trngantt_id,
trngantt.persons_id_upd   trngantt_person_id_upd,
trngantt.update_ip  trngantt_update_ip,
trngantt.updated_at  trngantt_updated_at,
trngantt.shelfnos_id_fm   trngantt_shelfno_id_fm,
trngantt.itms_id_pare   trngantt_itm_id_pare,
trngantt.processseq_pare  trngantt_processseq_pare,
trngantt.locas_id_pare   trngantt_loca_id_pare,
trngantt.duedate_org  trngantt_duedate_org,
trngantt.consumtype  trngantt_consumtype,
trngantt.prjnos_id   trngantt_prjno_id,
  itm.itm_classlist_id  itm_classlist_id ,
  itm.itm_unit_id  itm_unit_id ,
  itm.classlist_name  classlist_name ,
  itm.classlist_code  classlist_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  loca.loca_code  loca_code ,
  loca.loca_name  loca_name ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  itm_pare.itm_classlist_id  itm_classlist_id_pare ,
trngantt.key  trngantt_key,
  itm_pare.itm_unit_id  itm_unit_id_pare ,
  itm_pare.classlist_name  classlist_name_pare ,
  itm_pare.classlist_code  classlist_code_pare ,
  itm_pare.unit_name  unit_name_pare ,
  itm_pare.unit_code  unit_code_pare ,
  itm_pare.itm_code  itm_code_pare ,
  itm_pare.itm_name  itm_name_pare ,
  loca_pare.loca_code  loca_code_pare ,
  loca_pare.loca_name  loca_name_pare ,
trngantt.created_at  trngantt_created_at,
trngantt.parenum  trngantt_parenum,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code  prjno_code ,
trngantt.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
trngantt.expiredate  trngantt_expiredate,
trngantt.chilnum  trngantt_chilnum,
trngantt.qty  trngantt_qty,
trngantt.qty_stk  trngantt_qty_stk,
trngantt.remark  trngantt_remark,
trngantt.orgtblname  trngantt_orgtblname,
  prjno.prjno_code_chil  prjno_code_chil 
 from trngantts   trngantt,
  r_itms  itm ,  r_locas  loca ,  r_persons  person_upd ,  r_shelfnos  shelfno_fm ,  r_itms  itm_pare ,  r_locas  loca_pare ,  r_prjnos  prjno 
  where       trngantt.itms_id = itm.id      and trngantt.locas_id = loca.id      and trngantt.persons_id_upd = person_upd.id      and trngantt.shelfnos_id_fm = shelfno_fm.id      and trngantt.itms_id_pare = itm_pare.id      and trngantt.locas_id_pare = loca_pare.id      and trngantt.prjnos_id = prjno.id     ;
 DROP TABLE IF EXISTS sio.sio_r_trngantts;
 CREATE TABLE sio.sio_r_trngantts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_trngantts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,trngantt_orgtblname  varchar (30) 
,trngantt_orgtblid  numeric (22,0)
,trngantt_paretblname  varchar (30) 
,trngantt_paretblid  numeric (38,0)
,trngantt_tblname  varchar (30) 
,trngantt_tblid  numeric (38,0)
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,trngantt_processseq  numeric (38,0)
,trngantt_duedate   timestamp(6) 
,trngantt_qty  numeric (18,4)
,trngantt_qty_stk  numeric (22,0)
,trngantt_qty_alloc  numeric (22,6)
,trngantt_qty_linkto_alloctbl  numeric (22,0)
,trngantt_qty_pare  numeric (22,6)
,trngantt_qty_stk_pare  numeric (22,6)
,trngantt_qty_pare_alloc  numeric (22,6)
,shelfno_code_fm  varchar (50) 
,classlist_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_pare  varchar (100) 
,loca_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,itm_code_pare  varchar (50) 
,unit_code_pare  varchar (50) 
,unit_name_pare  varchar (100) 
,classlist_code_pare  varchar (50) 
,classlist_name_pare  varchar (100) 
,loca_code_shelfno_fm  varchar (50) 
,shelfno_name_fm  varchar (100) 
,classlist_name  varchar (100) 
,trngantt_processseq_pare  numeric (38,0)
,trngantt_duedate_org   timestamp(6) 
,trngantt_qty_pare_bal  numeric (22,6)
,trngantt_qty_bal  numeric (22,6)
,trngantt_consumtype  varchar (3) 
,trngantt_consumchgoverqty  numeric (22,6)
,trngantt_consumunitqty  numeric (22,6)
,trngantt_consumminqty  numeric (22,6)
,trngantt_starttime   timestamp(6) 
,trngantt_key  varchar (250) 
,trngantt_mlevel  numeric (3,0)
,itm_datascale_pare  numeric (22,0)
,loca_tel_pare  varchar (20) 
,itm_weight  numeric (22,0)
,unit_contents  varchar (4000) 
,itm_length  numeric (22,0)
,itm_design  varchar (50) 
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,itm_material  varchar (50) 
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,itm_datascale  numeric (22,0)
,loca_country  varchar (20) 
,loca_abbr  varchar (50) 
,loca_prfct  varchar (20) 
,loca_tel  varchar (20) 
,loca_mail  varchar (20) 
,loca_addr1  varchar (50) 
,loca_zip  varchar (10) 
,loca_fax  varchar (20) 
,loca_addr2  varchar (50) 
,itm_weight_pare  numeric (22,0)
,shelfno_contents_fm  varchar (4000) 
,unit_contents_pare  varchar (4000) 
,itm_length_pare  numeric (22,0)
,itm_design_pare  varchar (50) 
,itm_wide_pare  numeric (22,0)
,itm_deth_pare  numeric (22,0)
,itm_material_pare  varchar (50) 
,itm_std_pare  varchar (50) 
,itm_model_pare  varchar (50) 
,loca_country_pare  varchar (20) 
,loca_abbr_pare  varchar (50) 
,loca_prfct_pare  varchar (20) 
,loca_mail_pare  varchar (20) 
,loca_addr1_pare  varchar (50) 
,loca_zip_pare  varchar (10) 
,loca_fax_pare  varchar (20) 
,loca_addr2_pare  varchar (50) 
,trngantt_parenum  numeric (22,0)
,trngantt_chilnum  numeric (22,0)
,trngantt_shuffle_flg  varchar (1) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,trngantt_consumauto  varchar (1) 
,trngantt_expiredate   date 
,trngantt_remark  varchar (4000) 
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_id  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,trngantt_updated_at   timestamp(6) 
,trngantt_update_ip  varchar (40) 
,trngantt_prjno_id  numeric (38,0)
,trngantt_person_id_upd  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_classlist_id_pare  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,person_code_upd  varchar (50) 
,prjno_expiredate   date 
,person_name_upd  varchar (100) 
,prjno_id  numeric (22,0)
,prjno_code_chil  varchar (50) 
,trngantt_created_at  numeric (22,0)
,id  numeric (38,0)
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
 CREATE INDEX sio_r_trngantts_uk1 
  ON sio.sio_r_trngantts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_trngantts_seq ;
 create sequence sio.sio_r_trngantts_seq ;
 --- drop view r_shpacts cascade  
 create or replace view r_shpacts as select  
shpact.qty_stk  shpact_qty_stk,
shpact.cartonno  shpact_cartonno,
shpact.expiredate  shpact_expiredate,
shpact.tax  shpact_tax,
shpact.contents  shpact_contents,
shpact.isudate  shpact_isudate,
shpact.amt  shpact_amt,
shpact.price  shpact_price,
shpact.remark  shpact_remark,
shpact.duedate  shpact_duedate,
shpact.starttime  shpact_starttime,
shpact.cno  shpact_cno,
shpact.gno  shpact_gno,
shpact.contract_price  shpact_contract_price,
shpact.sno  shpact_sno,
shpact.transports_id   shpact_transport_id,
shpact.prjnos_id   shpact_prjno_id,
shpact.itms_id   shpact_itm_id,
shpact.instks_id   shpact_instk_id,
shpact.paretblname  shpact_paretblname,
shpact.paretblid  shpact_paretblid,
shpact.id id,
shpact.id  shpact_id,
shpact.update_ip  shpact_update_ip,
shpact.updated_at  shpact_updated_at,
shpact.persons_id_upd   shpact_person_id_upd,
shpact.chrgs_id   shpact_chrg_id,
shpact.sno_shpord  shpact_sno_shpord,
  transport.transport_code  transport_code ,
  transport.transport_name  transport_name ,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name  prjno_name ,
  prjno.prjno_code  prjno_code ,
  itm.itm_classlist_id  itm_classlist_id ,
  itm.itm_unit_id  itm_unit_id ,
  itm.classlist_name  classlist_name ,
  itm.classlist_code  classlist_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name ,
  instk.instk_alloctbl_id  instk_alloctbl_id ,
  instk.instk_shelfno_id_in  instk_shelfno_id_in ,
  instk.trngantt_itm_id  trngantt_itm_id ,
  instk.trngantt_loca_id  trngantt_loca_id ,
  instk.itm_code_pare  itm_code_pare ,
  instk.itm_name_pare  itm_name_pare ,
  instk.loca_code_pare  loca_code_pare ,
  instk.loca_name_pare  loca_name_pare ,
  instk.itm_unit_id_pare  itm_unit_id_pare ,
  instk.itm_classlist_id_pare  itm_classlist_id_pare ,
  instk.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  instk.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  instk.trngantt_loca_id_pare  trngantt_loca_id_pare ,
  instk.alloctbl_trngantt_id  alloctbl_trngantt_id ,
  instk.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  instk.trngantt_prjno_id  trngantt_prjno_id ,
  instk.shelfno_loca_id_shelfno_in  shelfno_loca_id_shelfno_in ,
  instk.shelfno_code_fm  shelfno_code_fm ,
  instk.shelfno_name_fm  shelfno_name_fm ,
  instk.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  instk.loca_code  loca_code ,
  instk.loca_name  loca_name ,
  instk.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  instk.shelfno_code_in  shelfno_code_in ,
  instk.shelfno_name_in  shelfno_name_in ,
  instk.loca_code_shelfno_in  loca_code_shelfno_in ,
  instk.loca_name_shelfno_in  loca_name_shelfno_in ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
shpact.box  shpact_box,
shpact.qty_case  shpact_qty_case,
shpact.gno_shpord  shpact_gno_shpord,
shpact.processseq  shpact_processseq,
shpact.created_at  shpact_created_at
 from shpacts   shpact,
  r_transports  transport ,  r_prjnos  prjno ,  r_itms  itm ,  r_instks  instk ,  r_persons  person_upd ,  r_chrgs  chrg 
  where       shpact.transports_id = transport.id      and shpact.prjnos_id = prjno.id      and shpact.itms_id = itm.id      and shpact.instks_id = instk.id      and shpact.persons_id_upd = person_upd.id      and shpact.chrgs_id = chrg.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shpacts;
 CREATE TABLE sio.sio_r_shpacts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shpacts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,shpact_duedate   timestamp(6) 
,shpact_qty  numeric (18,4)
,shpact_qty_stk  numeric (22,6)
,shpact_gno  varchar (40) 
,shpact_cno  varchar (40) 
,shpact_sno  varchar (40) 
,itm_name  varchar (100) 
,itm_code  varchar (50) 
,classlist_code  varchar (50) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,person_code_chrg  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,person_name_chrg  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,loca_name_shelfno_in  varchar (100) 
,loca_code_shelfno_in  varchar (50) 
,shelfno_name_in  varchar (100) 
,shelfno_code_in  varchar (50) 
,transport_code  varchar (50) 
,transport_name  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,prjno_code_chil  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code  varchar (50) 
,loca_name  varchar (100) 
,loca_code  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,shelfno_code_fm  varchar (50) 
,shelfno_name_fm  varchar (100) 
,classlist_name  varchar (100) 
,loca_name_pare  varchar (100) 
,loca_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,itm_code_pare  varchar (50) 
,shpact_contract_price  varchar (1) 
,shpact_cartonno  varchar (20) 
,shpact_expiredate   date 
,shpact_tax  numeric (38,4)
,shpact_isudate   timestamp(6) 
,shpact_amt  numeric (18,4)
,shpact_price  numeric (38,4)
,shpact_starttime   timestamp(6) 
,shpact_paretblname  varchar (30) 
,shpact_paretblid  numeric (38,0)
,shpact_sno_shpord  varchar (50) 
,shpact_box  varchar (50) 
,shpact_qty_case  numeric (22,0)
,shpact_gno_shpord  varchar (50) 
,shpact_processseq  numeric (38,0)
,instk_packno  varchar (10) 
,instk_inoutflg  varchar (20) 
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,itm_material  varchar (50) 
,itm_deth  numeric (22,0)
,itm_wide  numeric (22,0)
,itm_design  varchar (50) 
,itm_datascale  numeric (22,0)
,itm_length  numeric (22,0)
,unit_contents  varchar (4000) 
,person_email_chrg  varchar (50) 
,scrlv_level1_chrg  varchar (1) 
,trngantt_processseq  numeric (38,0)
,trngantt_duedate   timestamp(6) 
,instk_lotno  varchar (50) 
,transport_contents  varchar (4000) 
,alloctbl_srctblid  numeric (38,0)
,alloctbl_srctblname  varchar (30) 
,itm_weight  numeric (22,0)
,instk_qty_sch  numeric (22,6)
,instk_starttime   timestamp(6) 
,instk_qty_stk  numeric (22,6)
,instk_qty  numeric (22,6)
,shpact_contents  varchar (4000) 
,shpact_remark  varchar (4000) 
,shpact_created_at   timestamp(6) 
,shpact_id  numeric (38,0)
,shpact_chrg_id  numeric (38,0)
,id  numeric (38,0)
,shpact_person_id_upd  numeric (38,0)
,shpact_instk_id  numeric (22,0)
,shpact_itm_id  numeric (38,0)
,shpact_prjno_id  numeric (38,0)
,shpact_transport_id  numeric (38,0)
,shpact_updated_at   timestamp(6) 
,shpact_update_ip  varchar (40) 
,chrg_person_id_chrg  numeric (38,0)
,instk_shelfno_id_in  numeric (38,0)
,itm_unit_id  numeric (22,0)
,shelfno_loca_id_shelfno_in  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,alloctbl_trngantt_id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,itm_unit_id_pare  numeric (22,0)
,trngantt_loca_id  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,instk_alloctbl_id  numeric (38,0)
,chrg_expiredate   date 
,boxe_expiredate   date 
,transport_expiredate   date 
,prjno_expiredate   date 
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
 CREATE INDEX sio_r_shpacts_uk1 
  ON sio.sio_r_shpacts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpacts_seq ;
 create sequence sio.sio_r_shpacts_seq ;
