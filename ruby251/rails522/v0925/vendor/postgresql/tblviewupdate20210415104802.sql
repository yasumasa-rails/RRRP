
  drop view if  exists r_prdinsts cascade ; 
 create or replace view r_prdinsts as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
prdinst.id id,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
prdinst.prjnos_id   prdinst_prjno_id,
prdinst.cno  prdinst_cno,
prdinst.opeitms_id   prdinst_opeitm_id,
prdinst.contents  prdinst_contents,
prdinst.id  prdinst_id,
prdinst.remark  prdinst_remark,
prdinst.expiredate  prdinst_expiredate,
prdinst.update_ip  prdinst_update_ip,
prdinst.created_at  prdinst_created_at,
prdinst.updated_at  prdinst_updated_at,
prdinst.persons_id_upd   prdinst_person_id_upd,
prdinst.qty  prdinst_qty,
prdinst.sno  prdinst_sno,
prdinst.duedate  prdinst_duedate,
prdinst.isudate  prdinst_isudate,
prdinst.locas_id_to   prdinst_loca_id_to,
prdinst.qty_case  prdinst_qty_case,
prdinst.commencementdate  prdinst_commencementdate,
prdinst.commencement_f  prdinst_commencement_f,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
prdinst.chrgs_id   prdinst_chrg_id,
prdinst.gno  prdinst_gno,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
prdinst.starttime  prdinst_starttime,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  workplace.workplace_loca_id_workplace  workplace_loca_id_workplace ,
  workplace.loca_code_workplace  loca_code_workplace ,
  workplace.loca_name_workplace  loca_name_workplace ,
  workplace.workplace_chrg_id_workplace  workplace_chrg_id_workplace ,
  workplace.scrlv_code_chrg_workplace  scrlv_code_chrg_workplace ,
  workplace.loca_code_sect_chrg_workplace  loca_code_sect_chrg_workplace ,
  workplace.loca_name_sect_chrg_workplace  loca_name_sect_chrg_workplace ,
  workplace.person_code_chrg_workplace  person_code_chrg_workplace ,
  workplace.person_name_chrg_workplace  person_name_chrg_workplace ,
  workplace.usrgrp_name_chrg_workplace  usrgrp_name_chrg_workplace ,
  workplace.person_sect_id_chrg_workplace  person_sect_id_chrg_workplace ,
  workplace.usrgrp_code_chrg_workplace  usrgrp_code_chrg_workplace ,
  workplace.chrg_person_id_chrg_workplace  chrg_person_id_chrg_workplace ,
prdinst.sno_prdord  prdinst_sno_prdord,
prdinst.shelfnos_id_to   prdinst_shelfno_id_to,
prdinst.workplaces_id   prdinst_workplace_id
 from prdinsts   prdinst,
  r_prjnos  prjno ,  r_opeitms  opeitm ,  r_persons  person_upd ,  r_locas  loca_to ,  r_chrgs  chrg ,  r_shelfnos  shelfno_to ,  r_workplaces  workplace 
  where       prdinst.prjnos_id = prjno.id      and prdinst.opeitms_id = opeitm.id      and prdinst.persons_id_upd = person_upd.id      and prdinst.locas_id_to = loca_to.id      and prdinst.chrgs_id = chrg.id      and prdinst.shelfnos_id_to = shelfno_to.id      and prdinst.workplaces_id = workplace.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdinsts;
 CREATE TABLE sio.sio_r_prdinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prdinst_sno  varchar (40) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,loca_name  varchar (100) 
,prdinst_isudate   timestamp(6) 
,prdinst_duedate   timestamp(6) 
,loca_code_to  varchar (50) 
,prdinst_qty  numeric (18,4)
,prdinst_qty_case  numeric (38,0)
,person_name_chrg  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,loca_name_to  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,prjno_name  varchar (100) 
,person_name_chrg_workplace  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,person_code_chrg_workplace  varchar (50) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,loca_name_sect_chrg_workplace  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,prjno_code  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,person_code_chrg  varchar (50) 
,loca_name_workplace  varchar (100) 
,unit_name_outbox  varchar (100) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,loca_code_workplace  varchar (50) 
,prjno_code_chil  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,loca_code_shelfno_to  varchar (50) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,usrgrp_code_chrg_workplace  varchar (50) 
,usrgrp_name_chrg_workplace  varchar (100) 
,unit_code  varchar (50) 
,loca_code  varchar (50) 
,loca_code_sect_chrg_workplace  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,scrlv_code_chrg_workplace  varchar (50) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name  varchar (100) 
,prdinst_expiredate   date 
,prdinst_commencement_f  varchar (1) 
,prdinst_starttime   timestamp(6) 
,prdinst_sno_prdord  varchar (50) 
,prdinst_commencementdate   timestamp(6) 
,prdinst_cno  varchar (40) 
,opeitm_packqty  numeric (38,0)
,opeitm_processseq  numeric (3,0)
,prdinst_gno  varchar (40) 
,prdinst_remark  varchar (4000) 
,prdinst_contents  varchar (4000) 
,prdinst_workplace_id  numeric (22,0)
,id  numeric (38,0)
,prdinst_prjno_id  numeric (38,0)
,prdinst_opeitm_id  numeric (38,0)
,prdinst_id  numeric (38,0)
,prdinst_update_ip  varchar (40) 
,prdinst_created_at   timestamp(6) 
,prdinst_updated_at   timestamp(6) 
,prdinst_person_id_upd  numeric (38,0)
,prdinst_loca_id_to  numeric (38,0)
,prdinst_chrg_id  numeric (38,0)
,prdinst_shelfno_id_to  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,workplace_loca_id_workplace  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,workplace_chrg_id_workplace  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,opeitm_loca_id  numeric (38,0)
,person_sect_id_chrg_workplace  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,chrg_person_id_chrg_workplace  numeric (38,0)
,itm_unit_id  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,itm_classlist_id  numeric (38,0)
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
 CREATE INDEX sio_r_prdinsts_uk1 
  ON sio.sio_r_prdinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdinsts_seq ;
 create sequence sio.sio_r_prdinsts_seq ;
  drop view if  exists r_custinsts cascade ; 
 create or replace view r_custinsts as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  cust.loca_name_cust  loca_name_cust ,
  cust.loca_code_cust  loca_code_cust ,
custinst.isudate  custinst_isudate,
custinst.created_at  custinst_created_at,
custinst.sno  custinst_sno,
custinst.amt  custinst_amt,
  custrcvplc.loca_code_custrcvplc  loca_code_custrcvplc ,
custinst.updated_at  custinst_updated_at,
custinst.remark  custinst_remark,
custinst.update_ip  custinst_update_ip,
custinst.price  custinst_price,
custinst.qty  custinst_qty,
custinst.duedate  custinst_duedate,
custinst.persons_id_upd   custinst_person_id_upd,
  custrcvplc.loca_name_custrcvplc  loca_name_custrcvplc ,
custinst.id id,
  asstwh.loca_code_asstwh  loca_code_asstwh ,
  asstwh.loca_name_asstwh  loca_name_asstwh ,
  cust.cust_loca_id_cust  cust_loca_id_cust ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  asstwh.asstwh_loca_id_asstwh  asstwh_loca_id_asstwh ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
custinst.expiredate  custinst_expiredate,
custinst.cno  custinst_cno,
custinst.custs_id   custinst_cust_id,
custinst.gno  custinst_gno,
custinst.asstwhs_id   custinst_asstwh_id,
  custrcvplc.custrcvplc_loca_id_custrcvplc  custrcvplc_loca_id_custrcvplc ,
custinst.custrcvplcs_id   custinst_custrcvplc_id,
  cust.scrlv_code_chrg_cust  scrlv_code_chrg_cust ,
  cust.cust_chrg_id_cust  cust_chrg_id_cust ,
  cust.chrg_person_id_chrg_cust  chrg_person_id_chrg_cust ,
  cust.person_code_chrg_cust  person_code_chrg_cust ,
  cust.person_name_chrg_cust  person_name_chrg_cust ,
  cust.person_sect_id_chrg_cust  person_sect_id_chrg_cust ,
  cust.loca_code_sect_chrg_cust  loca_code_sect_chrg_cust ,
  cust.loca_name_sect_chrg_cust  loca_name_sect_chrg_cust ,
  cust.usrgrp_code_chrg_cust  usrgrp_code_chrg_cust ,
  cust.usrgrp_name_chrg_cust  usrgrp_name_chrg_cust ,
  chrg_cpo.scrlv_code_chrg  scrlv_code_chrg_cpo ,
  chrg_cpo.usrgrp_code_chrg  usrgrp_code_chrg_cpo ,
  chrg_cpo.usrgrp_name_chrg  usrgrp_name_chrg_cpo ,
  chrg_cpo.person_code_chrg  person_code_chrg_cpo ,
  chrg_cpo.person_name_chrg  person_name_chrg_cpo ,
  chrg_cpo.loca_code_sect_chrg  loca_code_sect_chrg_cpo ,
  chrg_cpo.loca_name_sect_chrg  loca_name_sect_chrg_cpo ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  chrg_cpo.person_sect_id_chrg  person_sect_id_chrg_cpo ,
  asstwh.usrgrp_code_chrg_asstwh  usrgrp_code_chrg_asstwh ,
  asstwh.usrgrp_name_chrg_asstwh  usrgrp_name_chrg_asstwh ,
  asstwh.person_code_chrg_asstwh  person_code_chrg_asstwh ,
  asstwh.person_name_chrg_asstwh  person_name_chrg_asstwh ,
  asstwh.person_sect_id_chrg_asstwh  person_sect_id_chrg_asstwh ,
  asstwh.loca_code_sect_chrg_asstwh  loca_code_sect_chrg_asstwh ,
  asstwh.loca_name_sect_chrg_asstwh  loca_name_sect_chrg_asstwh ,
  asstwh.scrlv_code_chrg_asstwh  scrlv_code_chrg_asstwh ,
  cust.bill_loca_id_bill  bill_loca_id_bill ,
  cust.loca_code_bill  loca_code_bill ,
  cust.loca_name_bill  loca_name_bill ,
  cust.cust_bill_id  cust_bill_id ,
  chrg_cpo.chrg_person_id_chrg  chrg_person_id_chrg_cpo ,
  cust.crr_name_cust  crr_name_cust ,
  cust.cust_crr_id_cust  cust_crr_id_cust ,
  cust.crr_code_cust  crr_code_cust ,
  asstwh.asstwh_chrg_id_asstwh  asstwh_chrg_id_asstwh ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
custinst.contract_price  custinst_contract_price,
custinst.itm_code_client  custinst_itm_code_client,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  cust.bill_chrg_id_bill  bill_chrg_id_bill ,
  cust.person_code_chrg_bill  person_code_chrg_bill ,
  cust.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  cust.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  cust.person_name_chrg_bill  person_name_chrg_bill ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
  cust.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  cust.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  cust.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  cust.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  cust.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  cust.bill_crr_id_bill  bill_crr_id_bill ,
  cust.crr_code_bill  crr_code_bill ,
  cust.crr_name_bill  crr_name_bill ,
custinst.starttime  custinst_starttime,
  asstwh.chrg_person_id_chrg_asstwh  chrg_person_id_chrg_asstwh ,
custinst.chrgs_id_cpo   custinst_chrg_id_cpo,
custinst.shelfnos_id_fm   custinst_shelfno_id_fm,
custinst.opeitms_id   custinst_opeitm_id
 from custinsts   custinst,
  r_persons  person_upd ,  r_custs  cust ,  r_asstwhs  asstwh ,  r_custrcvplcs  custrcvplc ,  r_chrgs  chrg_cpo ,  r_shelfnos  shelfno_fm ,  r_opeitms  opeitm 
  where       custinst.persons_id_upd = person_upd.id      and custinst.custs_id = cust.id      and custinst.asstwhs_id = asstwh.id      and custinst.custrcvplcs_id = custrcvplc.id      and custinst.chrgs_id_cpo = chrg_cpo.id      and custinst.shelfnos_id_fm = shelfno_fm.id      and custinst.opeitms_id = opeitm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custinsts;
 CREATE TABLE sio.sio_r_custinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,custinst_itm_code_client  varchar (50) 
,crr_code_cust  varchar (50) 
,loca_code_bill  varchar (50) 
,loca_name_bill  varchar (100) 
,person_code_upd  varchar (50) 
,loca_code_custrcvplc  varchar (50) 
,loca_code_cust  varchar (50) 
,person_name_upd  varchar (100) 
,itm_name  varchar (100) 
,person_code_chrg_bill  varchar (50) 
,loca_code  varchar (50) 
,crr_name_cust  varchar (100) 
,loca_name  varchar (100) 
,loca_name_custrcvplc  varchar (100) 
,person_name_chrg_bill  varchar (100) 
,loca_name_cust  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,usrgrp_name_chrg_bill  varchar (100) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,crr_code_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,loca_code_asstwh  varchar (50) 
,loca_name_asstwh  varchar (100) 
,shelfno_code_fm  varchar (50) 
,shelfno_name_fm  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,loca_code_shelfno_fm  varchar (50) 
,scrlv_code_chrg_cpo  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,boxe_code  varchar (50) 
,loca_name_sect_chrg_cust  varchar (100) 
,usrgrp_code_chrg_cust  varchar (50) 
,usrgrp_name_chrg_cust  varchar (100) 
,usrgrp_code_chrg_cpo  varchar (50) 
,scrlv_code_chrg_asstwh  varchar (50) 
,loca_name_sect_chrg_asstwh  varchar (100) 
,loca_code_sect_chrg_asstwh  varchar (50) 
,usrgrp_name_chrg_asstwh  varchar (100) 
,usrgrp_code_chrg_asstwh  varchar (50) 
,loca_name_sect_chrg_cpo  varchar (100) 
,loca_code_sect_chrg_cpo  varchar (50) 
,scrlv_code_chrg_cust  varchar (50) 
,person_name_chrg_cpo  varchar (100) 
,person_code_chrg_cpo  varchar (50) 
,person_code_chrg_cust  varchar (50) 
,person_name_chrg_cust  varchar (100) 
,usrgrp_name_chrg_cpo  varchar (100) 
,loca_code_sect_chrg_cust  varchar (50) 
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
,person_code_chrg_asstwh  varchar (50) 
,person_name_chrg_asstwh  varchar (100) 
,custinst_sno  varchar (40) 
,custinst_duedate   timestamp(6) 
,custinst_gno  varchar (40) 
,custinst_isudate   timestamp(6) 
,custinst_contract_price  varchar (1) 
,custinst_price  numeric (38,4)
,custinst_cno  varchar (40) 
,custinst_amt  numeric (18,4)
,custinst_qty  numeric (22,6)
,custinst_starttime   timestamp(6) 
,custinst_expiredate   date 
,custinst_remark  varchar (4000) 
,custinst_opeitm_id  numeric (38,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,cust_chrg_id_cust  numeric (38,0)
,custinst_custrcvplc_id  numeric (38,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,custinst_asstwh_id  numeric (38,0)
,custinst_cust_id  numeric (38,0)
,bill_loca_id_bill  numeric (38,0)
,cust_bill_id  numeric (38,0)
,chrg_person_id_chrg_cpo  numeric (38,0)
,cust_crr_id_cust  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,cust_loca_id_cust  numeric (38,0)
,bill_chrg_id_bill  numeric (22,0)
,custinst_update_ip  varchar (40) 
,custinst_updated_at   timestamp(6) 
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,custinst_created_at   timestamp(6) 
,opeitm_loca_id  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,chrg_person_id_chrg_asstwh  numeric (38,0)
,custinst_chrg_id_cpo  numeric (38,0)
,custinst_shelfno_id_fm  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,person_sect_id_chrg_cpo  numeric (22,0)
,person_sect_id_chrg_cust  numeric (22,0)
,person_sect_id_chrg_asstwh  numeric (22,0)
,itm_unit_id  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,custinst_person_id_upd  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
,asstwh_loca_id_asstwh  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,asstwh_chrg_id_asstwh  numeric (22,0)
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
 CREATE INDEX sio_r_custinsts_uk1 
  ON sio.sio_r_custinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custinsts_seq ;
 create sequence sio.sio_r_custinsts_seq ;
  drop view if  exists r_purinsts cascade ; 
 create or replace view r_purinsts as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  opeitm.opeitm_duration  opeitm_duration ,
purinst.id id,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
purinst.qty_case  purinst_qty_case,
purinst.cno  purinst_cno,
purinst.isudate  purinst_isudate,
purinst.opeitms_id   purinst_opeitm_id,
purinst.expiredate  purinst_expiredate,
purinst.updated_at  purinst_updated_at,
purinst.qty  purinst_qty,
purinst.sno  purinst_sno,
purinst.price  purinst_price,
purinst.remark  purinst_remark,
purinst.created_at  purinst_created_at,
purinst.update_ip  purinst_update_ip,
purinst.duedate  purinst_duedate,
purinst.amt  purinst_amt,
purinst.id  purinst_id,
purinst.persons_id_upd   purinst_person_id_upd,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
purinst.prjnos_id   purinst_prjno_id,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
purinst.contract_price  purinst_contract_price,
purinst.chrgs_id   purinst_chrg_id,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
purinst.tax  purinst_tax,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
purinst.starttime  purinst_starttime,
purinst.itm_code_client  purinst_itm_code_client,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_autoact_p  opeitm_autoact_p ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  supplier.payment_chrg_id_payment  payment_chrg_id_payment ,
  supplier.person_code_chrg_payment  person_code_chrg_payment ,
  supplier.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment ,
  supplier.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment ,
  supplier.person_name_chrg_payment  person_name_chrg_payment ,
  supplier.supplier_payment_id  supplier_payment_id ,
  supplier.supplier_loca_id_supplier  supplier_loca_id_supplier ,
  supplier.supplier_chrg_id_supplier  supplier_chrg_id_supplier ,
  supplier.supplier_crr_id_supplier  supplier_crr_id_supplier ,
  supplier.loca_code_supplier  loca_code_supplier ,
  supplier.loca_name_supplier  loca_name_supplier ,
  supplier.person_code_chrg_supplier  person_code_chrg_supplier ,
  supplier.usrgrp_name_chrg_supplier  usrgrp_name_chrg_supplier ,
  supplier.usrgrp_code_chrg_supplier  usrgrp_code_chrg_supplier ,
  supplier.person_name_chrg_supplier  person_name_chrg_supplier ,
  supplier.crr_name_supplier  crr_name_supplier ,
  supplier.crr_code_supplier  crr_code_supplier ,
  opeitm.itm_classlist_id  itm_classlist_id ,
purinst.autocreate_act  purinst_autocreate_act,
purinst.autoact_p  purinst_autoact_p,
purinst.suppliers_id   purinst_supplier_id,
  supplier.scrlv_code_chrg_supplier  scrlv_code_chrg_supplier ,
  supplier.loca_name_sect_chrg_supplier  loca_name_sect_chrg_supplier ,
  supplier.loca_code_sect_chrg_supplier  loca_code_sect_chrg_supplier ,
  supplier.scrlv_code_chrg_payment  scrlv_code_chrg_payment ,
  supplier.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment ,
  supplier.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
purinst.sno_purord  purinst_sno_purord,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
purinst.shelfnos_id_to   purinst_shelfno_id_to,
purinst.crrs_id   purinst_crr_id,
  supplier.payment_crr_id_payment  payment_crr_id_payment ,
  supplier.crr_code_payment  crr_code_payment ,
  supplier.crr_name_payment  crr_name_payment 
 from purinsts   purinst,
  r_opeitms  opeitm ,  r_persons  person_upd ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_suppliers  supplier ,  r_shelfnos  shelfno_to ,  r_crrs  crr 
  where       purinst.opeitms_id = opeitm.id      and purinst.persons_id_upd = person_upd.id      and purinst.prjnos_id = prjno.id      and purinst.chrgs_id = chrg.id      and purinst.suppliers_id = supplier.id      and purinst.shelfnos_id_to = shelfno_to.id      and purinst.crrs_id = crr.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purinsts;
 CREATE TABLE sio.sio_r_purinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,purinst_sno_purord  varchar (50) 
,crr_code  varchar (50) 
,crr_code_payment  varchar (50) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,purinst_isudate   timestamp(6) 
,crr_name_payment  varchar (100) 
,itm_code  varchar (50) 
,crr_name  varchar (100) 
,itm_name  varchar (100) 
,purinst_qty  numeric (18,4)
,purinst_duedate   timestamp(6) 
,purinst_qty_case  numeric (38,0)
,purinst_price  numeric (38,4)
,purinst_amt  numeric (18,4)
,purinst_tax  numeric (38,4)
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,person_code_chrg  varchar (50) 
,purinst_sno  varchar (40) 
,purinst_cno  varchar (40) 
,loca_code_sect_chrg_payment  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,person_name_chrg  varchar (100) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,loca_code_payment  varchar (50) 
,loca_name_payment  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,person_code_chrg_payment  varchar (50) 
,usrgrp_name_chrg_payment  varchar (100) 
,usrgrp_code_chrg_payment  varchar (50) 
,person_name_chrg_payment  varchar (100) 
,loca_code_supplier  varchar (50) 
,loca_name_supplier  varchar (100) 
,person_code_chrg_supplier  varchar (50) 
,usrgrp_name_chrg_supplier  varchar (100) 
,usrgrp_code_chrg_supplier  varchar (50) 
,person_name_chrg_supplier  varchar (100) 
,crr_name_supplier  varchar (100) 
,crr_code_supplier  varchar (50) 
,scrlv_code_chrg_supplier  varchar (50) 
,loca_name_sect_chrg_supplier  varchar (100) 
,loca_code_sect_chrg_supplier  varchar (50) 
,scrlv_code_chrg_payment  varchar (50) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_code_shelfno_to  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,purinst_contract_price  varchar (1) 
,purinst_itm_code_client  varchar (50) 
,purinst_starttime   timestamp(6) 
,purinst_autoact_p  numeric (3,0)
,purinst_autocreate_act  varchar (1) 
,purinst_expiredate   date 
,opeitm_autoact_p  numeric (3,0)
,opeitm_priority  numeric (3,0)
,opeitm_packqty  numeric (38,0)
,opeitm_duration  numeric (38,2)
,opeitm_processseq  numeric (3,0)
,purinst_remark  varchar (4000) 
,purinst_created_at   timestamp(6) 
,id  numeric (38,0)
,purinst_supplier_id  numeric (22,0)
,purinst_id  numeric (38,0)
,purinst_person_id_upd  numeric (38,0)
,payment_crr_id_payment  numeric (22,0)
,purinst_opeitm_id  numeric (38,0)
,purinst_crr_id  numeric (22,0)
,purinst_chrg_id  numeric (38,0)
,purinst_update_ip  varchar (40) 
,purinst_shelfno_id_to  numeric (38,0)
,purinst_updated_at   timestamp(6) 
,purinst_prjno_id  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,payment_chrg_id_payment  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,supplier_payment_id  numeric (38,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,supplier_crr_id_supplier  numeric (22,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,itm_unit_id  numeric (22,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,boxe_unit_id_outbox  numeric (22,0)
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
 CREATE INDEX sio_r_purinsts_uk1 
  ON sio.sio_r_purinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purinsts_seq ;
 create sequence sio.sio_r_purinsts_seq ;
  drop view if  exists r_billinsts cascade ; 
 create or replace view r_billinsts as select  
  itm.itm_name  itm_name ,
  itm.itm_code  itm_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_unit_id  itm_unit_id ,
billinst.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
  bill.bill_loca_id_bill  bill_loca_id_bill ,
  bill.loca_code_bill  loca_code_bill ,
  bill.loca_name_bill  loca_name_bill ,
billinst.remark  billinst_remark,
billinst.expiredate  billinst_expiredate,
billinst.update_ip  billinst_update_ip,
billinst.created_at  billinst_created_at,
billinst.updated_at  billinst_updated_at,
billinst.persons_id_upd   billinst_person_id_upd,
billinst.itms_id   billinst_itm_id,
billinst.qty  billinst_qty,
billinst.price  billinst_price,
billinst.amt  billinst_amt,
billinst.sno  billinst_sno,
billinst.duedate  billinst_duedate,
billinst.isudate  billinst_isudate,
billinst.contents  billinst_contents,
billinst.tblname  billinst_tblname,
billinst.tblid  billinst_tblid,
billinst.tax  billinst_tax,
billinst.orgtblname  billinst_orgtblname,
billinst.orgtblid  billinst_orgtblid,
billinst.bills_id   billinst_bill_id,
billinst.saledate  billinst_saledate,
  bill.bill_chrg_id_bill  bill_chrg_id_bill ,
  bill.person_code_chrg_bill  person_code_chrg_bill ,
  bill.usrgrp_name_chrg_bill  usrgrp_name_chrg_bill ,
  bill.usrgrp_code_chrg_bill  usrgrp_code_chrg_bill ,
  bill.person_name_chrg_bill  person_name_chrg_bill ,
  itm.itm_classlist_id  itm_classlist_id ,
  bill.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  bill.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  bill.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  bill.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  bill.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  bill.bill_crr_id_bill  bill_crr_id_bill ,
  bill.crr_code_bill  crr_code_bill ,
  bill.crr_name_bill  crr_name_bill 
 from billinsts   billinst,
  r_persons  person_upd ,  r_itms  itm ,  r_bills  bill 
  where       billinst.persons_id_upd = person_upd.id      and billinst.itms_id = itm.id      and billinst.bills_id = bill.id     ;
 DROP TABLE IF EXISTS sio.sio_r_billinsts;
 CREATE TABLE sio.sio_r_billinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_billinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,loca_code_bill  varchar (50) 
,itm_code  varchar (50) 
,loca_name_bill  varchar (100) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,itm_name  varchar (100) 
,person_code_chrg_bill  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,usrgrp_name_chrg_bill  varchar (100) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,crr_code_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,classlist_name  varchar (100) 
,classlist_code  varchar (50) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,billinst_orgtblname  varchar (30) 
,billinst_qty  numeric (22,6)
,billinst_price  numeric (38,4)
,billinst_amt  numeric (18,4)
,billinst_sno  varchar (40) 
,billinst_duedate   timestamp(6) 
,billinst_isudate   timestamp(6) 
,billinst_tblname  varchar (30) 
,billinst_tblid  numeric (38,0)
,billinst_tax  numeric (38,4)
,billinst_orgtblid  numeric (38,0)
,billinst_saledate   timestamp(6) 
,billinst_expiredate   date 
,billinst_remark  varchar (4000) 
,billinst_contents  varchar (4000) 
,billinst_itm_id  numeric (38,0)
,bill_loca_id_bill  numeric (38,0)
,billinst_bill_id  numeric (38,0)
,bill_chrg_id_bill  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,billinst_updated_at   timestamp(6) 
,billinst_created_at   timestamp(6) 
,billinst_update_ip  varchar (40) 
,bill_crr_id_bill  numeric (22,0)
,person_sect_id_chrg_bill  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,itm_unit_id  numeric (22,0)
,billinst_person_id_upd  numeric (22,0)
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
 CREATE INDEX sio_r_billinsts_uk1 
  ON sio.sio_r_billinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_billinsts_seq ;
 create sequence sio.sio_r_billinsts_seq ;
  drop view if  exists r_payinsts cascade ; 
 create or replace view r_payinsts as select  
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
payinst.id id,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  supplier.payment_chrg_id_payment  payment_chrg_id_payment ,
  supplier.person_code_chrg_payment  person_code_chrg_payment ,
  supplier.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment ,
  supplier.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment ,
  supplier.person_name_chrg_payment  person_name_chrg_payment ,
  supplier.supplier_payment_id  supplier_payment_id ,
  supplier.supplier_loca_id_supplier  supplier_loca_id_supplier ,
  supplier.supplier_chrg_id_supplier  supplier_chrg_id_supplier ,
  supplier.supplier_crr_id_supplier  supplier_crr_id_supplier ,
  supplier.loca_code_supplier  loca_code_supplier ,
  supplier.loca_name_supplier  loca_name_supplier ,
  supplier.person_code_chrg_supplier  person_code_chrg_supplier ,
  supplier.usrgrp_name_chrg_supplier  usrgrp_name_chrg_supplier ,
  supplier.usrgrp_code_chrg_supplier  usrgrp_code_chrg_supplier ,
  supplier.person_name_chrg_supplier  person_name_chrg_supplier ,
  supplier.crr_name_supplier  crr_name_supplier ,
  supplier.crr_code_supplier  crr_code_supplier ,
  crr_pur.crr_name  crr_name_pur ,
  crr_pur.crr_code  crr_code_pur ,
  supplier.scrlv_code_chrg_supplier  scrlv_code_chrg_supplier ,
  supplier.loca_name_sect_chrg_supplier  loca_name_sect_chrg_supplier ,
  supplier.loca_code_sect_chrg_supplier  loca_code_sect_chrg_supplier ,
  supplier.scrlv_code_chrg_payment  scrlv_code_chrg_payment ,
  supplier.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment ,
  supplier.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
  payment_pay.scrlv_code_chrg_payment  scrlv_code_chrg_payment_pay ,
  payment_pay.payment_chrg_id_payment  payment_chrg_id_payment_pay ,
  payment_pay.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment_pay ,
  payment_pay.loca_code_payment  loca_code_payment_pay ,
  payment_pay.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment_pay ,
  payment_pay.loca_name_payment  loca_name_payment_pay ,
  payment_pay.person_code_chrg_payment  person_code_chrg_payment_pay ,
  payment_pay.person_name_chrg_payment  person_name_chrg_payment_pay ,
  payment_pay.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment_pay ,
  payment_pay.person_sect_id_chrg_payment  person_sect_id_chrg_payment_pay ,
  payment_pay.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment_pay ,
  payment_pay.payment_loca_id_payment  payment_loca_id_payment_pay ,
  payment_pay.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment_pay ,
payinst.price  payinst_price,
payinst.remark  payinst_remark,
payinst.created_at  payinst_created_at,
payinst.update_ip  payinst_update_ip,
payinst.duedate  payinst_duedate,
payinst.amt  payinst_amt,
payinst.isudate  payinst_isudate,
payinst.expiredate  payinst_expiredate,
payinst.updated_at  payinst_updated_at,
payinst.sno  payinst_sno,
payinst.id  payinst_id,
payinst.persons_id_upd   payinst_person_id_upd,
payinst.contents  payinst_contents,
payinst.tax  payinst_tax,
payinst.contract_price  payinst_contract_price,
payinst.chrgs_id   payinst_chrg_id,
payinst.itm_code_client  payinst_itm_code_client,
payinst.suppliers_id   payinst_supplier_id,
payinst.crrs_id_pur   payinst_crr_id_pur,
payinst.payments_id_pay   payinst_payment_id_pay,
  supplier.payment_crr_id_payment  payment_crr_id_payment ,
  supplier.crr_code_payment  crr_code_payment ,
  supplier.crr_name_payment  crr_name_payment ,
  payment_pay.payment_crr_id_payment  payment_crr_id_payment_pay ,
  payment_pay.crr_code_payment  crr_code_payment_pay ,
  payment_pay.crr_name_payment  crr_name_payment_pay 
 from payinsts   payinst,
  r_persons  person_upd ,  r_chrgs  chrg ,  r_suppliers  supplier ,  r_crrs  crr_pur ,  r_payments  payment_pay 
  where       payinst.persons_id_upd = person_upd.id      and payinst.chrgs_id = chrg.id      and payinst.suppliers_id = supplier.id      and payinst.crrs_id_pur = crr_pur.id      and payinst.payments_id_pay = payment_pay.id     ;
 DROP TABLE IF EXISTS sio.sio_r_payinsts;
 CREATE TABLE sio.sio_r_payinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_payinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,crr_code_payment_pay  varchar (50) 
,crr_code_payment  varchar (50) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,crr_name_payment  varchar (100) 
,crr_name_payment_pay  varchar (100) 
,payinst_sno  varchar (40) 
,loca_code_payment  varchar (50) 
,loca_name_payment  varchar (100) 
,person_code_chrg_payment  varchar (50) 
,usrgrp_name_chrg_payment  varchar (100) 
,usrgrp_code_chrg_payment  varchar (50) 
,person_name_chrg_payment  varchar (100) 
,person_name_chrg  varchar (100) 
,person_code_chrg  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,loca_code_supplier  varchar (50) 
,loca_name_supplier  varchar (100) 
,person_code_chrg_supplier  varchar (50) 
,usrgrp_name_chrg_supplier  varchar (100) 
,usrgrp_code_chrg_supplier  varchar (50) 
,person_name_chrg_supplier  varchar (100) 
,crr_name_supplier  varchar (100) 
,crr_code_supplier  varchar (50) 
,crr_name_pur  varchar (100) 
,crr_code_pur  varchar (50) 
,scrlv_code_chrg_supplier  varchar (50) 
,loca_name_sect_chrg_supplier  varchar (100) 
,loca_code_sect_chrg_supplier  varchar (50) 
,scrlv_code_chrg_payment  varchar (50) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_code_sect_chrg_payment  varchar (50) 
,scrlv_code_chrg_payment_pay  varchar (50) 
,loca_code_sect_chrg_payment_pay  varchar (50) 
,loca_code_payment_pay  varchar (50) 
,loca_name_sect_chrg_payment_pay  varchar (100) 
,loca_name_payment_pay  varchar (100) 
,person_code_chrg_payment_pay  varchar (50) 
,person_name_chrg_payment_pay  varchar (100) 
,usrgrp_name_chrg_payment_pay  varchar (100) 
,usrgrp_code_chrg_payment_pay  varchar (50) 
,payinst_expiredate   date 
,payinst_isudate   timestamp(6) 
,payinst_price  numeric (38,4)
,payinst_amt  numeric (18,4)
,payinst_duedate   timestamp(6) 
,payinst_tax  numeric (38,4)
,payinst_contract_price  varchar (1) 
,payinst_itm_code_client  varchar (50) 
,payinst_remark  varchar (4000) 
,payinst_contents  varchar (4000) 
,payinst_supplier_id  numeric (22,0)
,payinst_crr_id_pur  numeric (22,0)
,payinst_payment_id_pay  numeric (22,0)
,payment_crr_id_payment  numeric (22,0)
,payment_crr_id_payment_pay  numeric (22,0)
,id  numeric (38,0)
,payinst_created_at   timestamp(6) 
,payinst_update_ip  varchar (40) 
,payinst_updated_at   timestamp(6) 
,payinst_id  numeric (38,0)
,payinst_person_id_upd  numeric (38,0)
,payinst_chrg_id  numeric (38,0)
,chrg_person_id_chrg_payment_pay  numeric (38,0)
,payment_loca_id_payment_pay  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,payment_chrg_id_payment  numeric (22,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,person_sect_id_chrg_payment_pay  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,payment_chrg_id_payment_pay  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,payment_loca_id_payment  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_payment_id  numeric (38,0)
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
 CREATE INDEX sio_r_payinsts_uk1 
  ON sio.sio_r_payinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_payinsts_seq ;
 create sequence sio.sio_r_payinsts_seq ;
  drop view if  exists r_shpinsts cascade ; 
 create or replace view r_shpinsts as select  
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  itm.itm_name  itm_name ,
  itm.itm_code  itm_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_unit_id  itm_unit_id ,
  transport.transport_code  transport_code ,
  transport.transport_name  transport_name ,
shpinst.id id,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to ,
shpinst.tax  shpinst_tax,
shpinst.cartonno  shpinst_cartonno,
shpinst.expiredate  shpinst_expiredate,
shpinst.updated_at  shpinst_updated_at,
shpinst.qty  shpinst_qty,
shpinst.sno  shpinst_sno,
shpinst.locas_id_to   shpinst_loca_id_to,
shpinst.price  shpinst_price,
shpinst.itms_id   shpinst_itm_id,
shpinst.remark  shpinst_remark,
shpinst.created_at  shpinst_created_at,
shpinst.amt  shpinst_amt,
shpinst.update_ip  shpinst_update_ip,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  prjno.prjno_code  prjno_code ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
shpinst.gno  shpinst_gno,
shpinst.isudate  shpinst_isudate,
shpinst.prjnos_id   shpinst_prjno_id,
shpinst.persons_id_upd   shpinst_person_id_upd,
shpinst.contents  shpinst_contents,
shpinst.contract_price  shpinst_contract_price,
shpinst.chrgs_id   shpinst_chrg_id,
shpinst.box  shpinst_box,
shpinst.duedate  shpinst_duedate,
shpinst.cno  shpinst_cno,
shpinst.qty_case  shpinst_qty_case,
  prjno.prjno_code_chil  prjno_code_chil ,
shpinst.transports_id   shpinst_transport_id,
  itm.itm_classlist_id  itm_classlist_id ,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
shpinst.processseq  shpinst_processseq,
shpinst.starttime  shpinst_starttime,
shpinst.paretblname  shpinst_paretblname,
shpinst.paretblid  shpinst_paretblid,
shpinst.qty_shortage  shpinst_qty_shortage,
shpinst.qty_stk  shpinst_qty_stk,
shpinst.shelfnos_id_fm   shpinst_shelfno_id_fm,
shpinst.gno_shpord  shpinst_gno_shpord
 from shpinsts   shpinst,
  r_locas  loca_to ,  r_itms  itm ,  r_prjnos  prjno ,  r_persons  person_upd ,  r_chrgs  chrg ,  r_transports  transport ,  r_shelfnos  shelfno_fm 
  where       shpinst.locas_id_to = loca_to.id      and shpinst.itms_id = itm.id      and shpinst.prjnos_id = prjno.id      and shpinst.persons_id_upd = person_upd.id      and shpinst.chrgs_id = chrg.id      and shpinst.transports_id = transport.id      and shpinst.shelfnos_id_fm = shelfno_fm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shpinsts;
 CREATE TABLE sio.sio_r_shpinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shpinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,loca_code_to  varchar (50) 
,itm_code  varchar (50) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,itm_name  varchar (100) 
,loca_name_to  varchar (100) 
,transport_code  varchar (50) 
,transport_name  varchar (100) 
,shelfno_code_fm  varchar (50) 
,prjno_name  varchar (100) 
,shelfno_name_fm  varchar (100) 
,prjno_code  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,person_code_chrg  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,classlist_name  varchar (100) 
,classlist_code  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,shpinst_qty_case  numeric (22,0)
,shpinst_tax  numeric (38,4)
,shpinst_cartonno  varchar (20) 
,shpinst_qty  numeric (22,6)
,shpinst_sno  varchar (40) 
,shpinst_price  numeric (38,4)
,shpinst_amt  numeric (18,4)
,shpinst_gno  varchar (40) 
,shpinst_isudate   timestamp(6) 
,shpinst_contract_price  varchar (1) 
,shpinst_box  varchar (50) 
,shpinst_duedate   timestamp(6) 
,shpinst_cno  varchar (40) 
,shpinst_processseq  numeric (38,0)
,shpinst_starttime   timestamp(6) 
,shpinst_paretblname  varchar (30) 
,shpinst_paretblid  numeric (38,0)
,shpinst_qty_shortage  numeric (22,5)
,shpinst_qty_stk  numeric (22,6)
,shpinst_gno_shpord  varchar (50) 
,shpinst_expiredate   date 
,shpinst_remark  varchar (4000) 
,shpinst_contents  varchar (4000) 
,prjno_code_chil  varchar (50) 
,shpinst_transport_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,shpinst_update_ip  varchar (40) 
,shpinst_created_at   timestamp(6) 
,shpinst_itm_id  numeric (38,0)
,shpinst_updated_at   timestamp(6) 
,shpinst_prjno_id  numeric (38,0)
,shpinst_chrg_id  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,shpinst_shelfno_id_fm  numeric (22,0)
,shpinst_loca_id_to  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,shpinst_person_id_upd  numeric (22,0)
,itm_unit_id  numeric (22,0)
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
 CREATE INDEX sio_r_shpinsts_uk1 
  ON sio.sio_r_shpinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpinsts_seq ;
 create sequence sio.sio_r_shpinsts_seq ;
 ALTER TABLE custinsts ADD CONSTRAINT custinst_opeitms_id FOREIGN KEY (opeitms_id)
																		 REFERENCES opeitms (id);
