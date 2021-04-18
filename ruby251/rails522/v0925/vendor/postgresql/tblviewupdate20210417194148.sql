
 alter table shprets DROP COLUMN opeitms_id CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'opeitms_id'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　opeitms_idが削除　2021-04-17 19:41:15 +0900' 
 ---- where  pobject_code_sfd = 'opeitms_id'
  drop view if  exists r_shpords cascade ; 
 create or replace view r_shpords as select  
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  itm.itm_name  itm_name ,
  itm.itm_code  itm_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_unit_id  itm_unit_id ,
  transport.transport_code  transport_code ,
  transport.transport_name  transport_name ,
shpord.qty  shpord_qty,
shpord.sno  shpord_sno,
shpord.update_ip  shpord_update_ip,
shpord.updated_at  shpord_updated_at,
shpord.isudate  shpord_isudate,
shpord.persons_id_upd   shpord_person_id_upd,
shpord.id  shpord_id,
shpord.created_at  shpord_created_at,
shpord.id id,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to ,
shpord.expiredate  shpord_expiredate,
shpord.depdate  shpord_depdate,
shpord.locas_id_to   shpord_loca_id_to,
shpord.price  shpord_price,
shpord.itms_id   shpord_itm_id,
shpord.remark  shpord_remark,
shpord.amt  shpord_amt,
shpord.tax  shpord_tax,
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
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
shpord.chrgs_id   shpord_chrg_id,
shpord.gno  shpord_gno,
shpord.processseq  shpord_processseq,
shpord.manual  shpord_manual,
shpord.prjnos_id   shpord_prjno_id,
shpord.contract_price  shpord_contract_price,
shpord.qty_case  shpord_qty_case,
shpord.lotno  shpord_lotno,
shpord.packno  shpord_packno,
  prjno.prjno_code_chil  prjno_code_chil ,
shpord.transports_id   shpord_transport_id,
  itm.itm_classlist_id  itm_classlist_id ,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
shpord.qty_stk  shpord_qty_stk,
shpord.crrs_id   shpord_crr_id,
shpord.paretblname  shpord_paretblname,
shpord.paretblid  shpord_paretblid,
shpord.shelfnos_id_fm   shpord_shelfno_id_fm,
shpord.sno_shpsch  shpord_sno_shpsch,
shpord.gno_shpsch  shpord_gno_shpsch,
  prjno.prjno_name_chil  prjno_name_chil 
 from shpords   shpord,
  r_persons  person_upd ,  r_locas  loca_to ,  r_itms  itm ,  r_chrgs  chrg ,  r_prjnos  prjno ,  r_transports  transport ,  r_crrs  crr ,  r_shelfnos  shelfno_fm 
  where       shpord.persons_id_upd = person_upd.id      and shpord.locas_id_to = loca_to.id      and shpord.itms_id = itm.id      and shpord.chrgs_id = chrg.id      and shpord.prjnos_id = prjno.id      and shpord.transports_id = transport.id      and shpord.crrs_id = crr.id      and shpord.shelfnos_id_fm = shelfno_fm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shpords;
 CREATE TABLE sio.sio_r_shpords (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shpords_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,crr_code  varchar (50) 
,classlist_code  varchar (50) 
,itm_code  varchar (50) 
,prjno_code  varchar (50) 
,transport_code  varchar (50) 
,shpord_gno  varchar (40) 
,unit_code  varchar (50) 
,shpord_sno  varchar (40) 
,shpord_qty_stk  numeric (22,6)
,shpord_expiredate   date 
,shpord_depdate   timestamp(6) 
,shpord_packno  varchar (10) 
,shpord_price  numeric (38,4)
,shpord_lotno  varchar (50) 
,shpord_qty_case  numeric (22,0)
,shpord_amt  numeric (18,4)
,shpord_tax  numeric (38,4)
,itm_name  varchar (100) 
,prjno_name  varchar (100) 
,shpord_contract_price  varchar (1) 
,classlist_name  varchar (100) 
,crr_name  varchar (100) 
,shpord_processseq  numeric (38,0)
,unit_name  varchar (100) 
,shpord_sno_shpsch  varchar (50) 
,transport_name  varchar (100) 
,shpord_qty  numeric (22,6)
,shpord_paretblid  numeric (38,0)
,shpord_paretblname  varchar (30) 
,shpord_isudate   timestamp(6) 
,shpord_manual  varchar (1) 
,person_code_chrg  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,loca_code_to  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,prjno_code_chil  varchar (50) 
,shelfno_code_fm  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,prjno_name_chil  varchar (100) 
,loca_name_to  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,shelfno_name_fm  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,person_name_chrg  varchar (100) 
,shpord_gno_shpsch  varchar (50) 
,shpord_remark  varchar (4000) 
,shpord_loca_id_to  numeric (38,0)
,id  numeric (38,0)
,shpord_transport_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,shpord_created_at   timestamp(6) 
,itm_unit_id  numeric (22,0)
,shpord_id  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,shpord_person_id_upd  numeric (38,0)
,shpord_crr_id  numeric (22,0)
,shpord_updated_at   timestamp(6) 
,shpord_update_ip  varchar (40) 
,shpord_shelfno_id_fm  numeric (22,0)
,shpord_chrg_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,shpord_prjno_id  numeric (38,0)
,shpord_itm_id  numeric (38,0)
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
 CREATE INDEX sio_r_shpords_uk1 
  ON sio.sio_r_shpords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpords_seq ;
 create sequence sio.sio_r_shpords_seq ;
  drop view if  exists r_purdlvs cascade ; 
 create or replace view r_purdlvs as select  
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
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
purdlv.id id,
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
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  prjno.prjno_code_chil  prjno_code_chil ,
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
  supplier.scrlv_code_chrg_supplier  scrlv_code_chrg_supplier ,
  supplier.loca_name_sect_chrg_supplier  loca_name_sect_chrg_supplier ,
  supplier.loca_code_sect_chrg_supplier  loca_code_sect_chrg_supplier ,
  supplier.scrlv_code_chrg_payment  scrlv_code_chrg_payment ,
  supplier.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment ,
  supplier.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
purdlv.remark  purdlv_remark,
purdlv.created_at  purdlv_created_at,
purdlv.update_ip  purdlv_update_ip,
purdlv.isudate  purdlv_isudate,
purdlv.expiredate  purdlv_expiredate,
purdlv.updated_at  purdlv_updated_at,
purdlv.qty  purdlv_qty,
purdlv.sno  purdlv_sno,
purdlv.persons_id_upd   purdlv_person_id_upd,
purdlv.depdate  purdlv_depdate,
purdlv.prjnos_id   purdlv_prjno_id,
purdlv.opeitms_id   purdlv_opeitm_id,
purdlv.qty_case  purdlv_qty_case,
purdlv.cno  purdlv_cno,
purdlv.gno  purdlv_gno,
purdlv.chrgs_id   purdlv_chrg_id,
purdlv.itm_code_client  purdlv_itm_code_client,
purdlv.autoact_p  purdlv_autoact_p,
purdlv.suppliers_id   purdlv_supplier_id,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
purdlv.sno_purinst  purdlv_sno_purinst,
purdlv.cno_purinst  purdlv_cno_purinst,
purdlv.shelfnos_id_to   purdlv_shelfno_id_to,
  prjno.prjno_name_chil  prjno_name_chil 
 from purdlvs   purdlv,
  r_persons  person_upd ,  r_prjnos  prjno ,  r_opeitms  opeitm ,  r_chrgs  chrg ,  r_suppliers  supplier ,  r_shelfnos  shelfno_to 
  where       purdlv.persons_id_upd = person_upd.id      and purdlv.prjnos_id = prjno.id      and purdlv.opeitms_id = opeitm.id      and purdlv.chrgs_id = chrg.id      and purdlv.suppliers_id = supplier.id      and purdlv.shelfnos_id_to = shelfno_to.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purdlvs;
 CREATE TABLE sio.sio_r_purdlvs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purdlvs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,boxe_code  varchar (50) 
,prjno_code  varchar (50) 
,itm_code  varchar (50) 
,loca_code  varchar (50) 
,unit_code  varchar (50) 
,shelfno_code  varchar (50) 
,boxe_name  varchar (100) 
,prjno_name  varchar (100) 
,itm_name  varchar (100) 
,unit_name  varchar (100) 
,loca_name  varchar (100) 
,classlist_name  varchar (100) 
,shelfno_name  varchar (100) 
,person_code_chrg_supplier  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,person_code_chrg  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,unit_code_case  varchar (50) 
,shelfno_code_to  varchar (50) 
,loca_code_sect_chrg_payment  varchar (50) 
,loca_code_shelfno  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,loca_code_payment  varchar (50) 
,scrlv_code_chrg_payment  varchar (50) 
,loca_code_sect_chrg_supplier  varchar (50) 
,unit_code_box  varchar (50) 
,unit_code_outbox  varchar (50) 
,scrlv_code_chrg_supplier  varchar (50) 
,prjno_code_chil  varchar (50) 
,crr_code_supplier  varchar (50) 
,person_code_chrg_payment  varchar (50) 
,usrgrp_code_chrg_payment  varchar (50) 
,usrgrp_code_chrg_supplier  varchar (50) 
,loca_code_supplier  varchar (50) 
,person_name_chrg_payment  varchar (100) 
,crr_name_supplier  varchar (100) 
,unit_name_box  varchar (100) 
,loca_name_sect_chrg_supplier  varchar (100) 
,unit_name_case  varchar (100) 
,person_name_chrg_supplier  varchar (100) 
,shelfno_name_to  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,unit_name_outbox  varchar (100) 
,person_name_chrg  varchar (100) 
,loca_name_shelfno  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_name_supplier  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,usrgrp_name_chrg_payment  varchar (100) 
,loca_name_payment  varchar (100) 
,loca_name_shelfno_to  varchar (100) 
,prjno_name_chil  varchar (100) 
,usrgrp_name_chrg_supplier  varchar (100) 
,purdlv_itm_code_client  varchar (50) 
,id  numeric (38,0)
,purdlv_remark  varchar (4000) 
,purdlv_created_at   timestamp(6) 
,purdlv_update_ip  varchar (40) 
,purdlv_isudate   timestamp(6) 
,purdlv_expiredate   date 
,purdlv_updated_at   timestamp(6) 
,purdlv_qty  numeric (22,6)
,purdlv_sno  varchar (40) 
,purdlv_depdate   timestamp(6) 
,purdlv_prjno_id  numeric (38,0)
,purdlv_opeitm_id  numeric (38,0)
,purdlv_qty_case  numeric (22,0)
,purdlv_cno  varchar (40) 
,purdlv_gno  varchar (40) 
,purdlv_chrg_id  numeric (38,0)
,purdlv_autoact_p  numeric (3,0)
,purdlv_supplier_id  numeric (22,0)
,purdlv_sno_purinst  varchar (50) 
,purdlv_cno_purinst  varchar (50) 
,purdlv_shelfno_id_to  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_payment_id  numeric (38,0)
,payment_chrg_id_payment  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,purdlv_person_id_upd  numeric (22,0)
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
 CREATE INDEX sio_r_purdlvs_uk1 
  ON sio.sio_r_purdlvs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purdlvs_seq ;
 create sequence sio.sio_r_purdlvs_seq ;
  drop view if  exists r_purschs cascade ; 
 create or replace view r_purschs as select  
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
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
pursch.id id,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
pursch.id  pursch_id,
pursch.remark  pursch_remark,
pursch.expiredate  pursch_expiredate,
pursch.update_ip  pursch_update_ip,
pursch.created_at  pursch_created_at,
pursch.updated_at  pursch_updated_at,
pursch.persons_id_upd   pursch_person_id_upd,
pursch.price  pursch_price,
pursch.sno  pursch_sno,
pursch.duedate  pursch_duedate,
pursch.toduedate  pursch_toduedate,
pursch.isudate  pursch_isudate,
pursch.tax  pursch_tax,
pursch.opeitms_id   pursch_opeitm_id,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
pursch.prjnos_id   pursch_prjno_id,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
pursch.chrgs_id   pursch_chrg_id,
pursch.starttime  pursch_starttime,
  prjno.prjno_code_chil  prjno_code_chil ,
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
  supplier.scrlv_code_chrg_supplier  scrlv_code_chrg_supplier ,
  supplier.loca_name_sect_chrg_supplier  loca_name_sect_chrg_supplier ,
  supplier.loca_code_sect_chrg_supplier  loca_code_sect_chrg_supplier ,
  supplier.scrlv_code_chrg_payment  scrlv_code_chrg_payment ,
  supplier.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment ,
  supplier.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
pursch.suppliers_id   pursch_supplier_id,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
pursch.shelfnos_id_to   pursch_shelfno_id_to,
pursch.qty_sch  pursch_qty_sch,
pursch.crrs_id_pursch   pursch_crr_id_pursch,
  crr_pursch.crr_code  crr_code_pursch ,
  crr_pursch.crr_name  crr_name_pursch ,
pursch.amt_sch  pursch_amt_sch,
  prjno.prjno_name_chil  prjno_name_chil 
 from purschs   pursch,
  r_persons  person_upd ,  r_opeitms  opeitm ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_suppliers  supplier ,  r_shelfnos  shelfno_to ,  r_crrs  crr_pursch 
  where       pursch.persons_id_upd = person_upd.id      and pursch.opeitms_id = opeitm.id      and pursch.prjnos_id = prjno.id      and pursch.chrgs_id = chrg.id      and pursch.suppliers_id = supplier.id      and pursch.shelfnos_id_to = shelfno_to.id      and pursch.crrs_id_pursch = crr_pursch.id     ;
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
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,pursch_duedate   timestamp(6) 
,prjno_code  varchar (50) 
,boxe_code  varchar (50) 
,shelfno_code  varchar (50) 
,loca_code  varchar (50) 
,classlist_code  varchar (50) 
,itm_code  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,unit_name_case  varchar (100) 
,unit_code_case  varchar (50) 
,unit_code  varchar (50) 
,loca_name  varchar (100) 
,unit_name  varchar (100) 
,unit_name_outbox  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_box  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,pursch_expiredate   date 
,pursch_toduedate   timestamp(6) 
,pursch_isudate   timestamp(6) 
,shelfno_name  varchar (100) 
,classlist_name  varchar (100) 
,prjno_name  varchar (100) 
,boxe_name  varchar (100) 
,itm_name  varchar (100) 
,pursch_starttime   timestamp(6) 
,person_code_chrg_supplier  varchar (50) 
,loca_code_sect_chrg_payment  varchar (50) 
,scrlv_code_chrg_payment  varchar (50) 
,loca_code_sect_chrg_supplier  varchar (50) 
,person_code_chrg_payment  varchar (50) 
,loca_code_shelfno  varchar (50) 
,scrlv_code_chrg_supplier  varchar (50) 
,person_code_chrg  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,loca_code_payment  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,crr_code_supplier  varchar (50) 
,usrgrp_code_chrg_payment  varchar (50) 
,usrgrp_code_chrg_supplier  varchar (50) 
,loca_code_supplier  varchar (50) 
,crr_code_pursch  varchar (50) 
,prjno_code_chil  varchar (50) 
,shelfno_code_to  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,shelfno_name_to  varchar (100) 
,loca_name_shelfno  varchar (100) 
,usrgrp_name_chrg_supplier  varchar (100) 
,person_name_chrg  varchar (100) 
,person_name_chrg_payment  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,loca_name_payment  varchar (100) 
,usrgrp_name_chrg_payment  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,crr_name_pursch  varchar (100) 
,prjno_name_chil  varchar (100) 
,loca_name_supplier  varchar (100) 
,loca_name_sect_chrg_payment  varchar (100) 
,crr_name_supplier  varchar (100) 
,person_name_chrg_supplier  varchar (100) 
,loca_name_sect_chrg_supplier  varchar (100) 
,pursch_price  numeric (38,4)
,pursch_tax  numeric (38,4)
,pursch_amt_sch  numeric (38,4)
,pursch_crr_id_pursch  numeric (22,0)
,pursch_qty_sch  numeric (22,6)
,pursch_remark  varchar (4000) 
,pursch_created_at   timestamp(6) 
,payment_chrg_id_payment  numeric (22,0)
,itm_unit_id  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,pursch_id  numeric (38,0)
,pursch_update_ip  varchar (40) 
,pursch_updated_at   timestamp(6) 
,pursch_person_id_upd  numeric (38,0)
,pursch_opeitm_id  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,pursch_prjno_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,pursch_chrg_id  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,supplier_payment_id  numeric (38,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,pursch_supplier_id  numeric (22,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,pursch_shelfno_id_to  numeric (38,0)
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
  drop view if  exists r_shprets cascade ; 
 create or replace view r_shprets as select  
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
shpret.id id,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to ,
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
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
shpret.expiredate  shpret_expiredate,
shpret.updated_at  shpret_updated_at,
shpret.qty  shpret_qty,
shpret.sno  shpret_sno,
shpret.price  shpret_price,
shpret.remark  shpret_remark,
shpret.created_at  shpret_created_at,
shpret.update_ip  shpret_update_ip,
shpret.amt  shpret_amt,
shpret.id  shpret_id,
shpret.tax  shpret_tax,
shpret.persons_id_upd   shpret_person_id_upd,
shpret.contents  shpret_contents,
shpret.qty_case  shpret_qty_case,
shpret.contract_price  shpret_contract_price,
shpret.chrgs_id   shpret_chrg_id,
shpret.isudate  shpret_isudate,
shpret.prjnos_id   shpret_prjno_id,
  loca_fm.loca_code  loca_code_fm ,
  loca_fm.loca_name  loca_name_fm ,
shpret.retdate  shpret_retdate,
shpret.locas_id_to   shpret_loca_id_to,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_name_chil  prjno_name_chil 
 from shprets   shpret,
  r_persons  person_upd ,  r_chrgs  chrg ,  r_prjnos  prjno ,  r_locas  loca_to 
  where       shpret.persons_id_upd = person_upd.id      and shpret.chrgs_id = chrg.id      and shpret.prjnos_id = prjno.id      and shpret.locas_id_to = loca_to.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shprets;
 CREATE TABLE sio.sio_r_shprets (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shprets_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,crr_code  varchar (50) 
,loca_code_to  varchar (50) 
,loca_code_fm  varchar (50) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,crr_name  varchar (100) 
,loca_name_to  varchar (100) 
,loca_name_fm  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,person_code_chrg  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,prjno_code_chil  varchar (50) 
,prjno_name_chil  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,person_name_chrg  varchar (100) 
,shpret_retdate   date 
,shpret_qty_case  numeric (22,0)
,shpret_contract_price  varchar (1) 
,shpret_remark  varchar (4000) 
,shpret_expiredate   date 
,shpret_qty  numeric (18,4)
,shpret_price  numeric (22,0)
,shpret_amt  numeric (18,4)
,shpret_sno  varchar (40) 
,shpret_isudate   timestamp(6) 
,shpret_contents  varchar (4000) 
,shpret_tax  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,shpret_id  numeric (22,0)
,shpret_prjno_id  numeric (22,0)
,shpret_update_ip  varchar (40) 
,shpret_loca_id_to  numeric (22,0)
,id  numeric (22,0)
,shpret_updated_at   timestamp(6) 
,shpret_created_at   timestamp(6) 
,shpret_person_id_upd  numeric (22,0)
,shpret_chrg_id  numeric (22,0)
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
 CREATE INDEX sio_r_shprets_uk1 
  ON sio.sio_r_shprets(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shprets_seq ;
 create sequence sio.sio_r_shprets_seq ;
  drop view if  exists r_shpacts cascade ; 
 create or replace view r_shpacts as select  
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  itm.itm_name  itm_name ,
  itm.itm_code  itm_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_unit_id  itm_unit_id ,
  transport.transport_code  transport_code ,
  transport.transport_name  transport_name ,
shpact.id id,
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
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
shpact.sno  shpact_sno,
shpact.price  shpact_price,
shpact.remark  shpact_remark,
shpact.created_at  shpact_created_at,
shpact.update_ip  shpact_update_ip,
shpact.amt  shpact_amt,
shpact.id  shpact_id,
shpact.tax  shpact_tax,
shpact.persons_id_upd   shpact_person_id_upd,
shpact.contents  shpact_contents,
shpact.contract_price  shpact_contract_price,
shpact.chrgs_id   shpact_chrg_id,
shpact.gno  shpact_gno,
shpact.isudate  shpact_isudate,
shpact.cartonno  shpact_cartonno,
shpact.prjnos_id   shpact_prjno_id,
shpact.expiredate  shpact_expiredate,
shpact.updated_at  shpact_updated_at,
shpact.box  shpact_box,
shpact.duedate  shpact_duedate,
shpact.qty_case  shpact_qty_case,
shpact.cno  shpact_cno,
  prjno.prjno_code_chil  prjno_code_chil ,
shpact.transports_id   shpact_transport_id,
  itm.itm_classlist_id  itm_classlist_id ,
shpact.starttime  shpact_starttime,
shpact.processseq  shpact_processseq,
shpact.sno_shpord  shpact_sno_shpord,
shpact.gno_shpord  shpact_gno_shpord,
shpact.itms_id   shpact_itm_id,
shpact.paretblname  shpact_paretblname,
shpact.paretblid  shpact_paretblid,
shpact.qty_stk  shpact_qty_stk,
shpact.gno_shpinst  shpact_gno_shpinst,
  prjno.prjno_name_chil  prjno_name_chil 
 from shpacts   shpact,
  r_persons  person_upd ,  r_chrgs  chrg ,  r_prjnos  prjno ,  r_transports  transport ,  r_itms  itm 
  where       shpact.persons_id_upd = person_upd.id      and shpact.chrgs_id = chrg.id      and shpact.prjnos_id = prjno.id      and shpact.transports_id = transport.id      and shpact.itms_id = itm.id     ;
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
,crr_code  varchar (50) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,crr_name  varchar (100) 
,shpact_duedate   timestamp(6) 
,shpact_qty_stk  numeric (22,6)
,transport_code  varchar (50) 
,itm_code  varchar (50) 
,unit_code  varchar (50) 
,prjno_code  varchar (50) 
,classlist_code  varchar (50) 
,shpact_gno  varchar (40) 
,shpact_cno  varchar (40) 
,shpact_sno  varchar (40) 
,shpact_contract_price  varchar (1) 
,shpact_starttime   timestamp(6) 
,shpact_isudate   timestamp(6) 
,shpact_processseq  numeric (38,0)
,shpact_sno_shpord  varchar (50) 
,shpact_gno_shpord  varchar (50) 
,unit_name  varchar (100) 
,shpact_paretblname  varchar (30) 
,classlist_name  varchar (100) 
,itm_name  varchar (100) 
,prjno_name  varchar (100) 
,shpact_price  numeric (38,4)
,shpact_box  varchar (50) 
,shpact_expiredate   date 
,shpact_qty_case  numeric (22,0)
,shpact_amt  numeric (18,4)
,shpact_paretblid  numeric (38,0)
,shpact_tax  numeric (38,4)
,shpact_cartonno  varchar (20) 
,transport_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,person_code_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,person_name_chrg  varchar (100) 
,prjno_name_chil  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,shpact_gno_shpinst  varchar (50) 
,shpact_remark  varchar (4000) 
,shpact_contents  varchar (4000) 
,shpact_created_at   timestamp(6) 
,shpact_itm_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,itm_unit_id  numeric (22,0)
,shpact_update_ip  varchar (40) 
,shpact_id  numeric (38,0)
,shpact_person_id_upd  numeric (38,0)
,shpact_chrg_id  numeric (38,0)
,shpact_prjno_id  numeric (38,0)
,shpact_updated_at   timestamp(6) 
,shpact_transport_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
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
 CREATE INDEX sio_r_shpacts_uk1 
  ON sio.sio_r_shpacts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpacts_seq ;
 create sequence sio.sio_r_shpacts_seq ;
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
shpinst.id  shpinst_id,
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
shpinst.processseq  shpinst_processseq,
shpinst.starttime  shpinst_starttime,
shpinst.paretblname  shpinst_paretblname,
shpinst.paretblid  shpinst_paretblid,
shpinst.qty_shortage  shpinst_qty_shortage,
shpinst.qty_stk  shpinst_qty_stk,
shpinst.gno_shpord  shpinst_gno_shpord,
  prjno.prjno_name_chil  prjno_name_chil 
 from shpinsts   shpinst,
  r_locas  loca_to ,  r_itms  itm ,  r_prjnos  prjno ,  r_persons  person_upd ,  r_chrgs  chrg ,  r_transports  transport 
  where       shpinst.locas_id_to = loca_to.id      and shpinst.itms_id = itm.id      and shpinst.prjnos_id = prjno.id      and shpinst.persons_id_upd = person_upd.id      and shpinst.chrgs_id = chrg.id      and shpinst.transports_id = transport.id     ;
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
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,unit_code  varchar (50) 
,shpinst_gno  varchar (40) 
,transport_code  varchar (50) 
,shpinst_sno  varchar (40) 
,itm_code  varchar (50) 
,prjno_code  varchar (50) 
,shpinst_cno  varchar (40) 
,classlist_name  varchar (100) 
,classlist_code  varchar (50) 
,shpinst_box  varchar (50) 
,itm_name  varchar (100) 
,unit_name  varchar (100) 
,transport_name  varchar (100) 
,shpinst_tax  numeric (38,4)
,shpinst_cartonno  varchar (20) 
,shpinst_expiredate   date 
,shpinst_qty  numeric (22,6)
,shpinst_price  numeric (38,4)
,shpinst_amt  numeric (18,4)
,prjno_name  varchar (100) 
,shpinst_isudate   timestamp(6) 
,shpinst_contract_price  varchar (1) 
,shpinst_duedate   timestamp(6) 
,shpinst_qty_case  numeric (22,0)
,shpinst_processseq  numeric (38,0)
,shpinst_starttime   timestamp(6) 
,shpinst_paretblname  varchar (30) 
,shpinst_paretblid  numeric (38,0)
,shpinst_qty_shortage  numeric (22,5)
,shpinst_qty_stk  numeric (22,6)
,loca_code_sect_chrg  varchar (50) 
,person_code_chrg  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,prjno_code_chil  varchar (50) 
,loca_code_to  varchar (50) 
,person_name_chrg  varchar (100) 
,loca_name_to  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,prjno_name_chil  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,shpinst_gno_shpord  varchar (50) 
,shpinst_remark  varchar (4000) 
,shpinst_contents  varchar (4000) 
,shpinst_created_at   timestamp(6) 
,itm_unit_id  numeric (22,0)
,shpinst_itm_id  numeric (38,0)
,shpinst_loca_id_to  numeric (38,0)
,shpinst_update_ip  varchar (40) 
,shpinst_id  numeric (38,0)
,id  numeric (38,0)
,shpinst_updated_at   timestamp(6) 
,chrg_person_id_chrg  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,shpinst_prjno_id  numeric (38,0)
,shpinst_person_id_upd  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,shpinst_chrg_id  numeric (38,0)
,shpinst_transport_id  numeric (38,0)
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
  drop view if  exists r_prdacts cascade ; 
 create or replace view r_prdacts as select  
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
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
prdact.id id,
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
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
prdact.remark  prdact_remark,
prdact.created_at  prdact_created_at,
prdact.update_ip  prdact_update_ip,
prdact.id  prdact_id,
prdact.persons_id_upd   prdact_person_id_upd,
prdact.contents  prdact_contents,
prdact.cmpldate  prdact_cmpldate,
prdact.chrgs_id   prdact_chrg_id,
prdact.isudate  prdact_isudate,
prdact.prjnos_id   prdact_prjno_id,
prdact.opeitms_id   prdact_opeitm_id,
prdact.expiredate  prdact_expiredate,
prdact.updated_at  prdact_updated_at,
prdact.sno  prdact_sno,
prdact.cno  prdact_cno,
prdact.gno  prdact_gno,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
prdact.lotno  prdact_lotno,
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
prdact.shelfnos_id_to   prdact_shelfno_id_to,
prdact.qty_stk  prdact_qty_stk,
prdact.sno_prdord  prdact_sno_prdord,
prdact.sno_prdinst  prdact_sno_prdinst,
prdact.cno_prdinst  prdact_cno_prdinst,
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
prdact.workplaces_id   prdact_workplace_id,
prdact.packno  prdact_packno,
  prjno.prjno_name_chil  prjno_name_chil 
 from prdacts   prdact,
  r_persons  person_upd ,  r_chrgs  chrg ,  r_prjnos  prjno ,  r_opeitms  opeitm ,  r_shelfnos  shelfno_to ,  r_workplaces  workplace 
  where       prdact.persons_id_upd = person_upd.id      and prdact.chrgs_id = chrg.id      and prdact.prjnos_id = prjno.id      and prdact.opeitms_id = opeitm.id      and prdact.shelfnos_id_to = shelfno_to.id      and prdact.workplaces_id = workplace.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdacts;
 CREATE TABLE sio.sio_r_prdacts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdacts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prdact_sno_prdord  varchar (50) 
,prdact_isudate   timestamp(6) 
,loca_code_workplace  varchar (50) 
,person_code_upd  varchar (50) 
,loca_name_workplace  varchar (100) 
,person_name_upd  varchar (100) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,prdact_qty_stk  numeric (22,6)
,prdact_cmpldate   timestamp(6) 
,loca_code_shelfno_to  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,prdact_gno  varchar (40) 
,prdact_cno  varchar (40) 
,classlist_code  varchar (50) 
,prdact_sno  varchar (40) 
,loca_code  varchar (50) 
,shelfno_code  varchar (50) 
,boxe_code  varchar (50) 
,prjno_code  varchar (50) 
,unit_code  varchar (50) 
,scrlv_code_chrg_workplace  varchar (50) 
,prdact_lotno  varchar (50) 
,unit_name  varchar (100) 
,shelfno_name  varchar (100) 
,boxe_name  varchar (100) 
,classlist_name  varchar (100) 
,prjno_name  varchar (100) 
,prdact_cno_prdinst  varchar (50) 
,loca_name  varchar (100) 
,prdact_sno_prdinst  varchar (50) 
,prdact_expiredate   date 
,unit_code_outbox  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,person_code_chrg  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,unit_code_case  varchar (50) 
,loca_code_shelfno  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,unit_code_box  varchar (50) 
,prjno_code_chil  varchar (50) 
,shelfno_code_to  varchar (50) 
,loca_code_sect_chrg_workplace  varchar (50) 
,person_code_chrg_workplace  varchar (50) 
,usrgrp_code_chrg_workplace  varchar (50) 
,unit_name_box  varchar (100) 
,unit_name_case  varchar (100) 
,person_name_chrg  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,unit_name_outbox  varchar (100) 
,loca_name_shelfno  varchar (100) 
,shelfno_name_to  varchar (100) 
,loca_name_sect_chrg_workplace  varchar (100) 
,person_name_chrg_workplace  varchar (100) 
,usrgrp_name_chrg_workplace  varchar (100) 
,prjno_name_chil  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,prdact_packno  varchar (10) 
,prdact_remark  varchar (4000) 
,prdact_contents  varchar (4000) 
,workplace_loca_id_workplace  numeric (22,0)
,id  numeric (38,0)
,prdact_shelfno_id_to  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,workplace_chrg_id_workplace  numeric (22,0)
,prdact_workplace_id  numeric (22,0)
,prdact_person_id_upd  numeric (38,0)
,prdact_id  numeric (38,0)
,prdact_chrg_id  numeric (38,0)
,prdact_update_ip  varchar (40) 
,prdact_opeitm_id  numeric (38,0)
,prdact_prjno_id  numeric (38,0)
,prdact_created_at   timestamp(6) 
,prdact_updated_at   timestamp(6) 
,chrg_person_id_chrg  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,person_sect_id_chrg_workplace  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,chrg_person_id_chrg_workplace  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
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
 CREATE INDEX sio_r_prdacts_uk1 
  ON sio.sio_r_prdacts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdacts_seq ;
 create sequence sio.sio_r_prdacts_seq ;
  drop view if  exists r_purrets cascade ; 
 create or replace view r_purrets as select  
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
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
purret.id id,
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
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
purret.qty_case  purret_qty_case,
purret.contract_price  purret_contract_price,
purret.chrgs_id   purret_chrg_id,
purret.id  purret_id,
purret.remark  purret_remark,
purret.expiredate  purret_expiredate,
purret.update_ip  purret_update_ip,
purret.created_at  purret_created_at,
purret.updated_at  purret_updated_at,
purret.persons_id_upd   purret_person_id_upd,
purret.qty  purret_qty,
purret.price  purret_price,
purret.amt  purret_amt,
purret.isudate  purret_isudate,
purret.contents  purret_contents,
purret.tax  purret_tax,
purret.prjnos_id   purret_prjno_id,
purret.opeitms_id   purret_opeitm_id,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
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
purret.retdate  purret_retdate,
purret.locas_id_fm   purret_loca_id_fm,
  loca_fm.loca_code  loca_code_fm ,
  loca_fm.loca_name  loca_name_fm ,
purret.sno  purret_sno,
  prjno.prjno_code_chil  prjno_code_chil ,
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
purret.suppliers_id   purret_supplier_id,
purret.crrs_id   purret_crr_id,
  prjno.prjno_name_chil  prjno_name_chil ,
purret.sno_puract  purret_sno_puract
 from purrets   purret,
  r_chrgs  chrg ,  r_persons  person_upd ,  r_prjnos  prjno ,  r_opeitms  opeitm ,  r_locas  loca_fm ,  r_suppliers  supplier ,  r_crrs  crr 
  where       purret.chrgs_id = chrg.id      and purret.persons_id_upd = person_upd.id      and purret.prjnos_id = prjno.id      and purret.opeitms_id = opeitm.id      and purret.locas_id_fm = loca_fm.id      and purret.suppliers_id = supplier.id      and purret.crrs_id = crr.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purrets;
 CREATE TABLE sio.sio_r_purrets (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purrets_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,boxe_code  varchar (50) 
,prjno_code  varchar (50) 
,shelfno_code  varchar (50) 
,unit_code  varchar (50) 
,itm_code  varchar (50) 
,loca_code  varchar (50) 
,crr_code  varchar (50) 
,prjno_name  varchar (100) 
,unit_name  varchar (100) 
,shelfno_name  varchar (100) 
,loca_name  varchar (100) 
,classlist_name  varchar (100) 
,crr_name  varchar (100) 
,boxe_name  varchar (100) 
,itm_name  varchar (100) 
,scrlv_code_chrg_payment  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,person_code_chrg  varchar (50) 
,loca_code_sect_chrg_payment  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_code_sect_chrg_supplier  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,unit_code_case  varchar (50) 
,scrlv_code_chrg_supplier  varchar (50) 
,loca_code_shelfno  varchar (50) 
,crr_code_supplier  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_code_chrg_supplier  varchar (50) 
,person_code_chrg_supplier  varchar (50) 
,loca_code_supplier  varchar (50) 
,usrgrp_code_chrg_payment  varchar (50) 
,person_code_chrg_payment  varchar (50) 
,prjno_code_chil  varchar (50) 
,loca_code_fm  varchar (50) 
,loca_code_payment  varchar (50) 
,unit_code_outbox  varchar (50) 
,unit_code_box  varchar (50) 
,usrgrp_name_chrg_supplier  varchar (100) 
,loca_name_supplier  varchar (100) 
,loca_name_payment  varchar (100) 
,person_name_chrg_payment  varchar (100) 
,loca_name_sect_chrg_payment  varchar (100) 
,usrgrp_name_chrg_payment  varchar (100) 
,prjno_name_chil  varchar (100) 
,loca_name_sect_chrg_supplier  varchar (100) 
,unit_name_outbox  varchar (100) 
,loca_name_fm  varchar (100) 
,loca_name_shelfno  varchar (100) 
,unit_name_case  varchar (100) 
,person_name_chrg  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,unit_name_box  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,crr_name_supplier  varchar (100) 
,person_name_chrg_supplier  varchar (100) 
,purret_qty_case  numeric (22,0)
,purret_contract_price  varchar (1) 
,purret_sno_puract  varchar (50) 
,purret_loca_id_fm  numeric (38,0)
,purret_supplier_id  numeric (22,0)
,purret_crr_id  numeric (22,0)
,purret_retdate   date 
,purret_remark  varchar (4000) 
,purret_expiredate   date 
,purret_qty  numeric (18,4)
,purret_price  numeric (22,0)
,purret_amt  numeric (18,4)
,purret_sno  varchar (40) 
,purret_isudate   timestamp(6) 
,purret_contents  varchar (4000) 
,purret_tax  numeric (22,0)
,payment_loca_id_payment  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,payment_chrg_id_payment  numeric (22,0)
,supplier_payment_id  numeric (38,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,itm_unit_id  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,purret_updated_at   timestamp(6) 
,purret_created_at   timestamp(6) 
,purret_update_ip  varchar (40) 
,purret_person_id_upd  numeric (22,0)
,purret_prjno_id  numeric (22,0)
,purret_id  numeric (22,0)
,purret_chrg_id  numeric (22,0)
,purret_opeitm_id  numeric (22,0)
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
 CREATE INDEX sio_r_purrets_uk1 
  ON sio.sio_r_purrets(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purrets_seq ;
 create sequence sio.sio_r_purrets_seq ;
  drop view if  exists r_custschs cascade ; 
 create or replace view r_custschs as select  
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
custsch.id id,
  cust.cust_loca_id_cust  cust_loca_id_cust ,
  prjno.prjno_name  prjno_name ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
custsch.cno  custsch_cno,
custsch.isudate  custsch_isudate,
custsch.prjnos_id   custsch_prjno_id,
custsch.expiredate  custsch_expiredate,
custsch.updated_at  custsch_updated_at,
custsch.sno  custsch_sno,
custsch.price  custsch_price,
custsch.remark  custsch_remark,
custsch.created_at  custsch_created_at,
custsch.update_ip  custsch_update_ip,
custsch.duedate  custsch_duedate,
custsch.id  custsch_id,
custsch.persons_id_upd   custsch_person_id_upd,
custsch.contents  custsch_contents,
custsch.custs_id   custsch_cust_id,
custsch.contract_price  custsch_contract_price,
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
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  cust.bill_loca_id_bill  bill_loca_id_bill ,
  cust.loca_code_bill  loca_code_bill ,
  cust.loca_name_bill  loca_name_bill ,
  cust.cust_bill_id  cust_bill_id ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  prjno.prjno_code_chil  prjno_code_chil ,
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
custsch.opeitms_id   custsch_opeitm_id,
  cust.scrlv_code_chrg_bill  scrlv_code_chrg_bill ,
  cust.loca_code_sect_chrg_bill  loca_code_sect_chrg_bill ,
  cust.loca_name_sect_chrg_bill  loca_name_sect_chrg_bill ,
  cust.person_sect_id_chrg_bill  person_sect_id_chrg_bill ,
  cust.chrg_person_id_chrg_bill  chrg_person_id_chrg_bill ,
  cust.bill_crr_id_bill  bill_crr_id_bill ,
  cust.crr_code_bill  crr_code_bill ,
  cust.crr_name_bill  crr_name_bill ,
custsch.starttime  custsch_starttime,
custsch.qty_sch  custsch_qty_sch,
custsch.shelfnos_id_fm   custsch_shelfno_id_fm,
custsch.amt_sch  custsch_amt_sch,
  prjno.prjno_name_chil  prjno_name_chil 
 from custschs   custsch,
  r_prjnos  prjno ,  r_persons  person_upd ,  r_custs  cust ,  r_opeitms  opeitm ,  r_shelfnos  shelfno_fm 
  where       custsch.prjnos_id = prjno.id      and custsch.persons_id_upd = person_upd.id      and custsch.custs_id = cust.id      and custsch.opeitms_id = opeitm.id      and custsch.shelfnos_id_fm = shelfno_fm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custschs;
 CREATE TABLE sio.sio_r_custschs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custschs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,custsch_isudate   timestamp(6) 
,custsch_cno  varchar (40) 
,person_code_upd  varchar (50) 
,itm_code  varchar (50) 
,person_name_upd  varchar (100) 
,itm_name  varchar (100) 
,loca_code_cust  varchar (50) 
,loca_name_cust  varchar (100) 
,custsch_duedate   timestamp(6) 
,custsch_price  numeric (38,4)
,custsch_contract_price  varchar (1) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,boxe_code  varchar (50) 
,classlist_code  varchar (50) 
,loca_code  varchar (50) 
,person_code_chrg_cust  varchar (50) 
,person_name_chrg_cust  varchar (100) 
,scrlv_code_chrg_cust  varchar (50) 
,loca_code_sect_chrg_cust  varchar (50) 
,usrgrp_code_chrg_cust  varchar (50) 
,usrgrp_name_chrg_cust  varchar (100) 
,loca_name_sect_chrg_cust  varchar (100) 
,person_code_chrg_bill  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,usrgrp_code_chrg_bill  varchar (50) 
,usrgrp_name_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,loca_name_shelfno  varchar (100) 
,prjno_code_chil  varchar (50) 
,loca_code_shelfno  varchar (50) 
,loca_code_bill  varchar (50) 
,shelfno_code  varchar (50) 
,boxe_name  varchar (100) 
,custsch_expiredate   date 
,loca_name  varchar (100) 
,classlist_name  varchar (100) 
,crr_code_bill  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,shelfno_code_fm  varchar (50) 
,prjno_name_chil  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,shelfno_name_fm  varchar (100) 
,loca_name_bill  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,crr_name_bill  varchar (100) 
,custsch_qty_sch  numeric (22,6)
,custsch_amt_sch  numeric (38,4)
,custsch_sno  varchar (40) 
,custsch_shelfno_id_fm  numeric (22,0)
,custsch_starttime   timestamp(6) 
,custsch_contents  varchar (4000) 
,custsch_remark  varchar (4000) 
,shelfno_name  varchar (100) 
,boxe_unit_id_box  numeric (22,0)
,itm_unit_id  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,id  numeric (38,0)
,cust_loca_id_cust  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,custsch_prjno_id  numeric (38,0)
,custsch_updated_at   timestamp(6) 
,custsch_created_at   timestamp(6) 
,custsch_update_ip  varchar (40) 
,custsch_id  numeric (38,0)
,custsch_person_id_upd  numeric (38,0)
,custsch_cust_id  numeric (38,0)
,cust_chrg_id_cust  numeric (38,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,person_sect_id_chrg_cust  numeric (22,0)
,bill_loca_id_bill  numeric (38,0)
,cust_bill_id  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,boxe_unit_id_outbox  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,bill_chrg_id_bill  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,custsch_opeitm_id  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
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
 CREATE INDEX sio_r_custschs_uk1 
  ON sio.sio_r_custschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custschs_seq ;
 create sequence sio.sio_r_custschs_seq ;
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
prdinst.workplaces_id   prdinst_workplace_id,
  prjno.prjno_name_chil  prjno_name_chil 
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
,loca_code  varchar (50) 
,boxe_code  varchar (50) 
,unit_code  varchar (50) 
,classlist_code  varchar (50) 
,prjno_code  varchar (50) 
,shelfno_code  varchar (50) 
,loca_name_sect_chrg_workplace  varchar (100) 
,prjno_name  varchar (100) 
,prdinst_commencementdate   timestamp(6) 
,prdinst_commencement_f  varchar (1) 
,boxe_name  varchar (100) 
,prdinst_expiredate   date 
,prdinst_sno_prdord  varchar (50) 
,classlist_name  varchar (100) 
,unit_name  varchar (100) 
,prdinst_starttime   timestamp(6) 
,shelfno_name  varchar (100) 
,unit_code_box  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,person_code_chrg  varchar (50) 
,usrgrp_code_chrg_workplace  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,unit_code_case  varchar (50) 
,person_code_chrg_workplace  varchar (50) 
,loca_code_shelfno  varchar (50) 
,loca_code_sect_chrg_workplace  varchar (50) 
,prdinst_cno  varchar (40) 
,scrlv_code_chrg_workplace  varchar (50) 
,loca_code_workplace  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,shelfno_code_to  varchar (50) 
,prjno_code_chil  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,unit_code_outbox  varchar (50) 
,loca_name_workplace  varchar (100) 
,loca_name_shelfno  varchar (100) 
,unit_name_case  varchar (100) 
,person_name_chrg_workplace  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,loca_name_to  varchar (100) 
,unit_name_box  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,usrgrp_name_chrg_workplace  varchar (100) 
,prjno_name_chil  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,unit_name_outbox  varchar (100) 
,shelfno_name_to  varchar (100) 
,loca_name_shelfno_to  varchar (100) 
,prdinst_gno  varchar (40) 
,prdinst_contents  varchar (4000) 
,prdinst_remark  varchar (4000) 
,prdinst_chrg_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,prdinst_loca_id_to  numeric (38,0)
,prdinst_person_id_upd  numeric (38,0)
,itm_unit_id  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,person_sect_id_chrg_workplace  numeric (22,0)
,chrg_person_id_chrg_workplace  numeric (38,0)
,prdinst_shelfno_id_to  numeric (38,0)
,prdinst_workplace_id  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,prdinst_updated_at   timestamp(6) 
,prdinst_created_at   timestamp(6) 
,prdinst_update_ip  varchar (40) 
,shelfno_loca_id_shelfno_to  numeric (38,0)
,workplace_loca_id_workplace  numeric (22,0)
,prdinst_id  numeric (38,0)
,workplace_chrg_id_workplace  numeric (22,0)
,prdinst_opeitm_id  numeric (38,0)
,prdinst_prjno_id  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,id  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
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
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
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
  prjno.prjno_name_chil  prjno_name_chil 
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
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,purinst_isudate   timestamp(6) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,purinst_qty  numeric (18,4)
,purinst_qty_case  numeric (38,0)
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,person_code_chrg  varchar (50) 
,purinst_cno  varchar (40) 
,classlist_code  varchar (50) 
,crr_code  varchar (50) 
,purinst_sno  varchar (40) 
,loca_code  varchar (50) 
,boxe_code  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,unit_code_case  varchar (50) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,purinst_starttime   timestamp(6) 
,classlist_name  varchar (100) 
,purinst_expiredate   date 
,loca_name  varchar (100) 
,boxe_name  varchar (100) 
,purinst_autoact_p  numeric (3,0)
,purinst_contract_price  varchar (1) 
,purinst_itm_code_client  varchar (50) 
,crr_name  varchar (100) 
,purinst_autocreate_act  varchar (1) 
,person_code_chrg_supplier  varchar (50) 
,loca_code_shelfno  varchar (50) 
,usrgrp_code_chrg_supplier  varchar (50) 
,crr_code_supplier  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,person_code_chrg_payment  varchar (50) 
,usrgrp_code_chrg_payment  varchar (50) 
,loca_code_payment  varchar (50) 
,prjno_code_chil  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,loca_code_supplier  varchar (50) 
,loca_code_sect_chrg_payment  varchar (50) 
,unit_code_outbox  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,unit_code_box  varchar (50) 
,scrlv_code_chrg_payment  varchar (50) 
,loca_code_sect_chrg_supplier  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,scrlv_code_chrg_supplier  varchar (50) 
,unit_name_box  varchar (100) 
,usrgrp_name_chrg_payment  varchar (100) 
,prjno_name_chil  varchar (100) 
,loca_name_shelfno_to  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,unit_name_case  varchar (100) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_name_sect_chrg_supplier  varchar (100) 
,person_name_chrg  varchar (100) 
,loca_name_shelfno  varchar (100) 
,crr_name_supplier  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,person_name_chrg_supplier  varchar (100) 
,loca_name_payment  varchar (100) 
,usrgrp_name_chrg_supplier  varchar (100) 
,person_name_chrg_payment  varchar (100) 
,loca_name_supplier  varchar (100) 
,unit_name_outbox  varchar (100) 
,purinst_tax  numeric (38,4)
,purinst_price  numeric (38,4)
,purinst_duedate   timestamp(6) 
,purinst_amt  numeric (18,4)
,purinst_crr_id  numeric (22,0)
,purinst_remark  varchar (4000) 
,purinst_created_at   timestamp(6) 
,supplier_loca_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,purinst_chrg_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,purinst_prjno_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,purinst_person_id_upd  numeric (38,0)
,purinst_supplier_id  numeric (22,0)
,purinst_id  numeric (38,0)
,purinst_update_ip  varchar (40) 
,payment_chrg_id_payment  numeric (22,0)
,supplier_payment_id  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,purinst_updated_at   timestamp(6) 
,purinst_opeitm_id  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,purinst_shelfno_id_to  numeric (38,0)
,itm_unit_id  numeric (22,0)
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
  drop view if  exists r_trngantts cascade ; 
 create or replace view r_trngantts as select  
  itm.itm_name  itm_name ,
  itm.itm_code  itm_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  loca.loca_code  loca_code ,
  loca.loca_name  loca_name ,
  itm.itm_unit_id  itm_unit_id ,
trngantt.id id,
  prjno.prjno_name  prjno_name ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  itm_pare.itm_code  itm_code_pare ,
  itm_pare.itm_name  itm_name_pare ,
  itm_pare.itm_unit_id  itm_unit_id_pare ,
  itm_pare.unit_code  unit_code_pare ,
  itm_pare.unit_name  unit_name_pare ,
trngantt.processseq_pare  trngantt_processseq_pare,
trngantt.qty_alloc  trngantt_qty_alloc,
trngantt.orgtblname  trngantt_orgtblname,
trngantt.orgtblid  trngantt_orgtblid,
trngantt.id  trngantt_id,
trngantt.persons_id_upd   trngantt_person_id_upd,
trngantt.itms_id_pare   trngantt_itm_id_pare,
trngantt.parenum  trngantt_parenum,
trngantt.chilnum  trngantt_chilnum,
trngantt.expiredate  trngantt_expiredate,
trngantt.updated_at  trngantt_updated_at,
trngantt.qty  trngantt_qty,
trngantt.remark  trngantt_remark,
trngantt.created_at  trngantt_created_at,
trngantt.update_ip  trngantt_update_ip,
trngantt.duedate  trngantt_duedate,
trngantt.tblid  trngantt_tblid,
trngantt.tblname  trngantt_tblname,
trngantt.key  trngantt_key,
trngantt.mlevel  trngantt_mlevel,
trngantt.qty_stk  trngantt_qty_stk,
trngantt.processseq  trngantt_processseq,
trngantt.itms_id   trngantt_itm_id,
trngantt.locas_id   trngantt_loca_id,
  prjno.prjno_code  prjno_code ,
trngantt.prjnos_id   trngantt_prjno_id,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
  loca_pare.loca_code  loca_code_pare ,
  loca_pare.loca_name  loca_name_pare ,
trngantt.consumtype  trngantt_consumtype,
trngantt.consumauto  trngantt_consumauto,
trngantt.starttime  trngantt_starttime,
  prjno.prjno_code_chil  prjno_code_chil ,
trngantt.shuffle_flg  trngantt_shuffle_flg,
trngantt.consumunitqty  trngantt_consumunitqty,
trngantt.paretblname  trngantt_paretblname,
trngantt.paretblid  trngantt_paretblid,
trngantt.consumminqty  trngantt_consumminqty,
trngantt.consumchgoverqty  trngantt_consumchgoverqty,
  itm.itm_classlist_id  itm_classlist_id ,
trngantt.locas_id_pare   trngantt_loca_id_pare,
  itm_pare.itm_classlist_id  itm_classlist_id_pare ,
  itm_pare.classlist_name  classlist_name_pare ,
  itm_pare.classlist_code  classlist_code_pare ,
trngantt.qty_stk_pare  trngantt_qty_stk_pare,
trngantt.qty_pare  trngantt_qty_pare,
trngantt.shelfnos_id_fm   trngantt_shelfno_id_fm,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
trngantt.qty_pare_alloc  trngantt_qty_pare_alloc,
trngantt.duedate_org  trngantt_duedate_org,
trngantt.qty_bal  trngantt_qty_bal,
trngantt.qty_pare_bal  trngantt_qty_pare_bal,
trngantt.qty_sch  trngantt_qty_sch,
  prjno.prjno_name_chil  prjno_name_chil 
 from trngantts   trngantt,
  r_persons  person_upd ,  r_itms  itm_pare ,  r_itms  itm ,  r_locas  loca ,  r_prjnos  prjno ,  r_locas  loca_pare ,  r_shelfnos  shelfno_fm 
  where       trngantt.persons_id_upd = person_upd.id      and trngantt.itms_id_pare = itm_pare.id      and trngantt.itms_id = itm.id      and trngantt.locas_id = loca.id      and trngantt.prjnos_id = prjno.id      and trngantt.locas_id_pare = loca_pare.id      and trngantt.shelfnos_id_fm = shelfno_fm.id     ;
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
,itm_code_pare  varchar (50) 
,loca_code_pare  varchar (50) 
,trngantt_orgtblid  numeric (22,0)
,loca_code  varchar (50) 
,itm_name_pare  varchar (100) 
,trngantt_paretblname  varchar (30) 
,trngantt_paretblid  numeric (38,0)
,trngantt_tblname  varchar (30) 
,trngantt_tblid  numeric (38,0)
,loca_name  varchar (100) 
,loca_name_pare  varchar (100) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,trngantt_processseq  numeric (38,0)
,trngantt_duedate   timestamp(6) 
,trngantt_qty  numeric (18,4)
,trngantt_qty_stk  numeric (22,0)
,trngantt_qty_alloc  numeric (22,6)
,trngantt_qty_pare  numeric (22,6)
,trngantt_qty_stk_pare  numeric (22,6)
,trngantt_qty_pare_alloc  numeric (22,6)
,shelfno_code_fm  varchar (50) 
,shelfno_name_fm  varchar (100) 
,loca_code_shelfno_fm  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,classlist_code  varchar (50) 
,classlist_code_pare  varchar (50) 
,trngantt_consumtype  varchar (3) 
,trngantt_processseq_pare  numeric (38,0)
,classlist_name  varchar (100) 
,trngantt_starttime   timestamp(6) 
,trngantt_consumunitqty  numeric (22,6)
,trngantt_consumminqty  numeric (22,6)
,trngantt_consumchgoverqty  numeric (22,6)
,trngantt_qty_pare_bal  numeric (22,6)
,trngantt_key  varchar (250) 
,trngantt_mlevel  numeric (3,0)
,unit_code_pare  varchar (50) 
,unit_code  varchar (50) 
,unit_name_pare  varchar (100) 
,unit_name  varchar (100) 
,classlist_name_pare  varchar (100) 
,prjno_name_chil  varchar (100) 
,trngantt_qty_sch  numeric (22,6)
,trngantt_duedate_org   timestamp(6) 
,trngantt_qty_bal  numeric (22,6)
,trngantt_parenum  numeric (22,0)
,trngantt_chilnum  numeric (22,0)
,trngantt_shuffle_flg  varchar (1) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,trngantt_consumauto  varchar (1) 
,trngantt_expiredate   date 
,trngantt_remark  varchar (4000) 
,trngantt_id  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,trngantt_loca_id  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,trngantt_update_ip  varchar (40) 
,trngantt_updated_at   timestamp(6) 
,trngantt_person_id_upd  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,person_code_upd  varchar (50) 
,prjno_code_chil  varchar (50) 
,person_name_upd  varchar (100) 
,id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,trngantt_created_at  numeric (22,0)
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
  drop view if  exists r_prdschs cascade ; 
 create or replace view r_prdschs as select  
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
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
prdsch.id id,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
prdsch.id  prdsch_id,
prdsch.remark  prdsch_remark,
prdsch.expiredate  prdsch_expiredate,
prdsch.update_ip  prdsch_update_ip,
prdsch.created_at  prdsch_created_at,
prdsch.updated_at  prdsch_updated_at,
prdsch.persons_id_upd   prdsch_person_id_upd,
prdsch.sno  prdsch_sno,
prdsch.duedate  prdsch_duedate,
prdsch.toduedate  prdsch_toduedate,
prdsch.isudate  prdsch_isudate,
prdsch.opeitms_id   prdsch_opeitm_id,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
prdsch.prjnos_id   prdsch_prjno_id,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
prdsch.chrgs_id   prdsch_chrg_id,
prdsch.starttime  prdsch_starttime,
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
prdsch.shelfnos_id_to   prdsch_shelfno_id_to,
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
prdsch.workplaces_id   prdsch_workplace_id,
prdsch.qty_sch  prdsch_qty_sch,
  prjno.prjno_name_chil  prjno_name_chil 
 from prdschs   prdsch,
  r_persons  person_upd ,  r_opeitms  opeitm ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_shelfnos  shelfno_to ,  r_workplaces  workplace 
  where       prdsch.persons_id_upd = person_upd.id      and prdsch.opeitms_id = opeitm.id      and prdsch.prjnos_id = prjno.id      and prdsch.chrgs_id = chrg.id      and prdsch.shelfnos_id_to = shelfno_to.id      and prdsch.workplaces_id = workplace.id     ;
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
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,prdsch_duedate   timestamp(6) 
,loca_code_workplace  varchar (50) 
,loca_name_workplace  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,classlist_code  varchar (50) 
,boxe_code  varchar (50) 
,unit_code  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,prdsch_toduedate   timestamp(6) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,boxe_name  varchar (100) 
,classlist_name  varchar (100) 
,prdsch_expiredate   date 
,unit_name  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,loca_code_sect_chrg_workplace  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,unit_code_case  varchar (50) 
,unit_code_box  varchar (50) 
,unit_code_outbox  varchar (50) 
,scrlv_code_chrg_workplace  varchar (50) 
,person_code_chrg_workplace  varchar (50) 
,usrgrp_code_chrg_workplace  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,prjno_name_chil  varchar (100) 
,unit_name_outbox  varchar (100) 
,person_name_chrg_workplace  varchar (100) 
,usrgrp_name_chrg_workplace  varchar (100) 
,unit_name_box  varchar (100) 
,unit_name_case  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,loca_name_sect_chrg_workplace  varchar (100) 
,prdsch_starttime   timestamp(6) 
,prdsch_qty_sch  numeric (22,6)
,prdsch_isudate   timestamp(6) 
,prjno_code_chil  varchar (50) 
,prdsch_remark  varchar (4000) 
,itm_classlist_id  numeric (38,0)
,id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,workplace_loca_id_workplace  numeric (22,0)
,itm_unit_id  numeric (22,0)
,prdsch_shelfno_id_to  numeric (38,0)
,workplace_chrg_id_workplace  numeric (22,0)
,prdsch_workplace_id  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,prdsch_person_id_upd  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,prdsch_opeitm_id  numeric (38,0)
,person_sect_id_chrg_workplace  numeric (22,0)
,prdsch_prjno_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,prdsch_updated_at   timestamp(6) 
,prdsch_created_at   timestamp(6) 
,prdsch_update_ip  varchar (40) 
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,chrg_person_id_chrg_workplace  numeric (38,0)
,prdsch_id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,prdsch_chrg_id  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
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
  drop view if  exists r_lotstkhists cascade ; 
 create or replace view r_lotstkhists as select  
  itm.itm_name  itm_name ,
  itm.itm_code  itm_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_unit_id  itm_unit_id ,
lotstkhist.id id,
  prjno.prjno_name  prjno_name ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
lotstkhist.expiredate  lotstkhist_expiredate,
lotstkhist.updated_at  lotstkhist_updated_at,
lotstkhist.processseq  lotstkhist_processseq,
lotstkhist.qty  lotstkhist_qty,
lotstkhist.itms_id   lotstkhist_itm_id,
lotstkhist.remark  lotstkhist_remark,
lotstkhist.created_at  lotstkhist_created_at,
lotstkhist.update_ip  lotstkhist_update_ip,
lotstkhist.id  lotstkhist_id,
lotstkhist.persons_id_upd   lotstkhist_person_id_upd,
lotstkhist.lotno  lotstkhist_lotno,
lotstkhist.packno  lotstkhist_packno,
  shelfno.shelfno_code  shelfno_code ,
  shelfno.shelfno_name  shelfno_name ,
  shelfno.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  shelfno.loca_code_shelfno  loca_code_shelfno ,
  shelfno.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
lotstkhist.prjnos_id   lotstkhist_prjno_id,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
lotstkhist.starttime  lotstkhist_starttime,
  prjno.prjno_code_chil  prjno_code_chil ,
lotstkhist.shelfnos_id   lotstkhist_shelfno_id,
lotstkhist.qty_stk  lotstkhist_qty_stk,
  itm.itm_classlist_id  itm_classlist_id ,
lotstkhist.stktaking_proc  lotstkhist_stktaking_proc,
lotstkhist.qty_sch  lotstkhist_qty_sch,
  prjno.prjno_name_chil  prjno_name_chil 
 from lotstkhists   lotstkhist,
  r_itms  itm ,  r_persons  person_upd ,  r_prjnos  prjno ,  r_shelfnos  shelfno 
  where       lotstkhist.itms_id = itm.id      and lotstkhist.persons_id_upd = person_upd.id      and lotstkhist.prjnos_id = prjno.id      and lotstkhist.shelfnos_id = shelfno.id     ;
 DROP TABLE IF EXISTS sio.sio_r_lotstkhists;
 CREATE TABLE sio.sio_r_lotstkhists (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_lotstkhists_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,lotstkhist_starttime   timestamp(6) 
,itm_code  varchar (50) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,itm_name  varchar (100) 
,lotstkhist_processseq  numeric (38,0)
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,lotstkhist_lotno  varchar (50) 
,lotstkhist_packno  varchar (10) 
,lotstkhist_qty_stk  numeric (22,6)
,lotstkhist_qty  numeric (22,6)
,lotstkhist_qty_sch  numeric (22,6)
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,classlist_name  varchar (100) 
,classlist_code  varchar (50) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,lotstkhist_expiredate   date 
,lotstkhist_stktaking_proc  varchar (1) 
,prjno_name_chil  varchar (100) 
,lotstkhist_remark  varchar (4000) 
,itm_unit_id  numeric (22,0)
,lotstkhist_itm_id  numeric (38,0)
,lotstkhist_created_at   timestamp(6) 
,lotstkhist_update_ip  varchar (40) 
,lotstkhist_id  numeric (38,0)
,lotstkhist_person_id_upd  numeric (38,0)
,id  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,lotstkhist_updated_at   timestamp(6) 
,lotstkhist_prjno_id  numeric (38,0)
,lotstkhist_shelfno_id  numeric (38,0)
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
 CREATE INDEX sio_r_lotstkhists_uk1 
  ON sio.sio_r_lotstkhists(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_lotstkhists_seq ;
 create sequence sio.sio_r_lotstkhists_seq ;
  drop view if  exists r_prdords cascade ; 
 create or replace view r_prdords as select  
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
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
prdord.id id,
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
prdord.expiredate  prdord_expiredate,
prdord.updated_at  prdord_updated_at,
prdord.qty  prdord_qty,
prdord.sno  prdord_sno,
prdord.remark  prdord_remark,
prdord.created_at  prdord_created_at,
prdord.update_ip  prdord_update_ip,
prdord.duedate  prdord_duedate,
prdord.toduedate  prdord_toduedate,
prdord.id  prdord_id,
prdord.persons_id_upd   prdord_person_id_upd,
prdord.isudate  prdord_isudate,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
prdord.prjnos_id   prdord_prjno_id,
prdord.gno  prdord_gno,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
prdord.opeitms_id   prdord_opeitm_id,
prdord.chrgs_id   prdord_chrg_id,
prdord.starttime  prdord_starttime,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
prdord.confirm  prdord_confirm,
prdord.opt_fixoterm  prdord_opt_fixoterm,
prdord.autocreate_inst  prdord_autocreate_inst,
prdord.autocreate_act  prdord_autocreate_act,
prdord.autoinst_p  prdord_autoinst_p,
prdord.autoact_p  prdord_autoact_p,
prdord.qty_case  prdord_qty_case,
  opeitm.itm_classlist_id  itm_classlist_id ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  workplace.workplace_loca_id_workplace  workplace_loca_id_workplace ,
  workplace.loca_code_workplace  loca_code_workplace ,
  workplace.loca_name_workplace  loca_name_workplace ,
prdord.shelfnos_id_to   prdord_shelfno_id_to,
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
prdord.workplaces_id   prdord_workplace_id,
prdord.sno_prdsch  prdord_sno_prdsch,
  prjno.prjno_name_chil  prjno_name_chil 
 from prdords   prdord,
  r_persons  person_upd ,  r_prjnos  prjno ,  r_opeitms  opeitm ,  r_chrgs  chrg ,  r_shelfnos  shelfno_to ,  r_workplaces  workplace 
  where       prdord.persons_id_upd = person_upd.id      and prdord.prjnos_id = prjno.id      and prdord.opeitms_id = opeitm.id      and prdord.chrgs_id = chrg.id      and prdord.shelfnos_id_to = shelfno_to.id      and prdord.workplaces_id = workplace.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdords;
 CREATE TABLE sio.sio_r_prdords (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdords_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prdord_confirm  varchar (1) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,prdord_isudate   timestamp(6) 
,prdord_sno  varchar (40) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,prdord_duedate   timestamp(6) 
,prdord_qty  numeric (18,4)
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,loca_code_workplace  varchar (50) 
,loca_name_workplace  varchar (100) 
,prdord_toduedate   timestamp(6) 
,prdord_qty_case  numeric (38,0)
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,prdord_autoact_p  numeric (3,0)
,prdord_opt_fixoterm  numeric (5,2)
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,loca_code_shelfno_to  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,prdord_autocreate_inst  varchar (1) 
,prdord_autocreate_act  varchar (1) 
,prdord_autoinst_p  numeric (3,0)
,prdord_expiredate   date 
,person_code_chrg_workplace  varchar (50) 
,person_name_chrg_workplace  varchar (100) 
,usrgrp_name_chrg_workplace  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg_workplace  varchar (100) 
,usrgrp_code_chrg_workplace  varchar (50) 
,loca_code_sect_chrg_workplace  varchar (50) 
,scrlv_code_chrg_workplace  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,prdord_sno_prdsch  varchar (50) 
,prjno_code_chil  varchar (50) 
,prjno_name_chil  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,unit_code  varchar (50) 
,prdord_starttime   timestamp(6) 
,prdord_gno  varchar (40) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,prdord_remark  varchar (4000) 
,opeitm_unit_id_case  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,workplace_loca_id_workplace  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,prdord_shelfno_id_to  numeric (38,0)
,workplace_chrg_id_workplace  numeric (22,0)
,id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,person_sect_id_chrg_workplace  numeric (22,0)
,chrg_person_id_chrg_workplace  numeric (38,0)
,prdord_workplace_id  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,prdord_opeitm_id  numeric (38,0)
,prdord_chrg_id  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,prdord_prjno_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,prdord_person_id_upd  numeric (38,0)
,prdord_id  numeric (38,0)
,prdord_update_ip  varchar (40) 
,prdord_created_at   timestamp(6) 
,itm_classlist_id  numeric (38,0)
,prdord_updated_at   timestamp(6) 
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
 CREATE INDEX sio_r_prdords_uk1 
  ON sio.sio_r_prdords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdords_seq ;
 create sequence sio.sio_r_prdords_seq ;
  drop view if  exists r_purords cascade ; 
 create or replace view r_purords as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
purord.autoinst_p  purord_autoinst_p,
purord.autocreate_act  purord_autocreate_act,
purord.autoact_p  purord_autoact_p,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
purord.qty  purord_qty,
purord.duedate  purord_duedate,
purord.isudate  purord_isudate,
purord.remark  purord_remark,
purord.update_ip  purord_update_ip,
purord.created_at  purord_created_at,
purord.updated_at  purord_updated_at,
purord.id  purord_id,
purord.sno  purord_sno,
purord.id id,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
purord.amt  purord_amt,
purord.toduedate  purord_toduedate,
purord.persons_id_upd   purord_person_id_upd,
purord.sno_pursch  purord_sno_pursch,
purord.expiredate  purord_expiredate,
purord.price  purord_price,
purord.opt_fixoterm  purord_opt_fixoterm,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
purord.qty_case  purord_qty_case,
purord.confirm  purord_confirm,
purord.opeitms_id   purord_opeitm_id,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
purord.autocreate_inst  purord_autocreate_inst,
  prjno.prjno_code  prjno_code ,
purord.prjnos_id   purord_prjno_id,
purord.contract_price  purord_contract_price,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
purord.chrgs_id   purord_chrg_id,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
purord.tax  purord_tax,
purord.gno  purord_gno,
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
purord.itm_code_client  purord_itm_code_client,
purord.starttime  purord_starttime,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  supplier.payment_chrg_id_payment  payment_chrg_id_payment ,
  supplier.person_code_chrg_payment  person_code_chrg_payment ,
  supplier.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment ,
  supplier.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment ,
  supplier.person_name_chrg_payment  person_name_chrg_payment ,
purord.suppliers_id   purord_supplier_id,
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
purord.crrs_id_pur   purord_crr_id_pur,
  crr_pur.crr_name  crr_name_pur ,
  crr_pur.crr_code  crr_code_pur ,
  opeitm.itm_classlist_id  itm_classlist_id ,
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
purord.shelfnos_id_to   purord_shelfno_id_to,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
purord.crrs_id   purord_crr_id,
  prjno.prjno_name_chil  prjno_name_chil 
 from purords   purord,
  r_persons  person_upd ,  r_opeitms  opeitm ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_suppliers  supplier ,  r_crrs  crr_pur ,  r_shelfnos  shelfno_to ,  r_crrs  crr 
  where       purord.persons_id_upd = person_upd.id      and purord.opeitms_id = opeitm.id      and purord.prjnos_id = prjno.id      and purord.chrgs_id = chrg.id      and purord.suppliers_id = supplier.id      and purord.crrs_id_pur = crr_pur.id      and purord.shelfnos_id_to = shelfno_to.id      and purord.crrs_id = crr.id     ;
 DROP TABLE IF EXISTS sio.sio_r_purords;
 CREATE TABLE sio.sio_r_purords (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_purords_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,purord_confirm  char (01) 
,purord_sno  varchar (40) 
,purord_isudate   timestamp(6) 
,itm_code  varchar (50) 
,person_code_upd  varchar (50) 
,itm_name  varchar (100) 
,person_name_upd  varchar (100) 
,purord_starttime   timestamp(6) 
,purord_duedate   timestamp(6) 
,purord_qty  numeric (18,4)
,loca_code_supplier  varchar (50) 
,loca_name_supplier  varchar (100) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,purord_qty_case  numeric (38,0)
,purord_price  numeric (38,4)
,purord_amt  numeric (18,4)
,purord_tax  numeric (38,4)
,crr_code_supplier  varchar (50) 
,crr_name_supplier  varchar (100) 
,crr_code_pur  varchar (50) 
,crr_name_pur  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,loca_code_shelfno_to  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,crr_code  varchar (50) 
,person_code_chrg_supplier  varchar (50) 
,person_name_chrg_supplier  varchar (100) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,purord_itm_code_client  varchar (50) 
,purord_opt_fixoterm  numeric (5,2)
,purord_autocreate_inst  varchar (1) 
,purord_autoinst_p  numeric (3,0)
,purord_autocreate_act  varchar (1) 
,purord_autoact_p  numeric (3,0)
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_name_outbox  varchar (100) 
,unit_code_outbox  varchar (50) 
,usrgrp_name_chrg_supplier  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,loca_code_payment  varchar (50) 
,loca_name_payment  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,prjno_code_chil  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,scrlv_code_chrg_supplier  varchar (50) 
,loca_name_sect_chrg_supplier  varchar (100) 
,loca_code_sect_chrg_supplier  varchar (50) 
,scrlv_code_chrg_payment  varchar (50) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_code_sect_chrg_payment  varchar (50) 
,usrgrp_code_chrg_supplier  varchar (50) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,person_code_chrg_payment  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,person_name_chrg_payment  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,usrgrp_code_chrg_payment  varchar (50) 
,purord_toduedate   timestamp(6) 
,purord_expiredate   date 
,crr_name  varchar (100) 
,purord_sno_pursch  varchar (50) 
,prjno_name_chil  varchar (100) 
,usrgrp_name_chrg_payment  varchar (100) 
,purord_contract_price  varchar (1) 
,purord_crr_id  numeric (22,0)
,purord_gno  varchar (40) 
,purord_remark  varchar (4000) 
,purord_updated_at   timestamp(6) 
,purord_created_at   timestamp(6) 
,purord_update_ip  varchar (40) 
,purord_supplier_id  numeric (22,0)
,purord_prjno_id  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,purord_shelfno_id_to  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,purord_crr_id_pur  numeric (22,0)
,purord_opeitm_id  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,purord_person_id_upd  numeric (38,0)
,purord_chrg_id  numeric (38,0)
,id  numeric (38,0)
,purord_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,payment_chrg_id_payment  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,supplier_payment_id  numeric (38,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
,payment_loca_id_payment  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
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
 CREATE INDEX sio_r_purords_uk1 
  ON sio.sio_r_purords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_purords_seq ;
 create sequence sio.sio_r_purords_seq ;
  drop view if  exists r_custords cascade ; 
 create or replace view r_custords as select  
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
custord.remark  custord_remark,
custord.update_ip  custord_update_ip,
custord.duedate  custord_duedate,
custord.updated_at  custord_updated_at,
custord.price  custord_price,
custord.id  custord_id,
custord.persons_id_upd   custord_person_id_upd,
custord.created_at  custord_created_at,
custord.toduedate  custord_toduedate,
custord.expiredate  custord_expiredate,
custord.sno  custord_sno,
  cust.loca_name_cust  loca_name_cust ,
custord.amt  custord_amt,
custord.qty  custord_qty,
custord.isudate  custord_isudate,
  cust.loca_code_cust  loca_code_cust ,
  custrcvplc.loca_code_custrcvplc  loca_code_custrcvplc ,
  custrcvplc.loca_name_custrcvplc  loca_name_custrcvplc ,
custord.id id,
custord.custs_id   custord_cust_id,
  cust.cust_loca_id_cust  cust_loca_id_cust ,
  prjno.prjno_name  prjno_name ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
custord.cno  custord_cno,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
custord.prjnos_id   custord_prjno_id,
custord.gno  custord_gno,
  custrcvplc.custrcvplc_loca_id_custrcvplc  custrcvplc_loca_id_custrcvplc ,
custord.contract_price  custord_contract_price,
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
custord.chrgs_id_cpo   custord_chrg_id_cpo,
  chrg_cpo.person_code_chrg  person_code_chrg_cpo ,
  chrg_cpo.person_name_chrg  person_name_chrg_cpo ,
  chrg_cpo.loca_code_sect_chrg  loca_code_sect_chrg_cpo ,
  chrg_cpo.loca_name_sect_chrg  loca_name_sect_chrg_cpo ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  chrg_cpo.person_sect_id_chrg  person_sect_id_chrg_cpo ,
  cust.bill_loca_id_bill  bill_loca_id_bill ,
  cust.loca_code_bill  loca_code_bill ,
  cust.loca_name_bill  loca_name_bill ,
  cust.cust_bill_id  cust_bill_id ,
  chrg_cpo.chrg_person_id_chrg  chrg_person_id_chrg_cpo ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
custord.custrcvplcs_id   custord_custrcvplc_id,
custord.itm_code_client  custord_itm_code_client,
custord.contents  custord_contents,
  prjno.prjno_code_chil  prjno_code_chil ,
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
custord.opeitms_id   custord_opeitm_id,
custord.cno_custsch  custord_cno_custsch,
  cust.bill_crr_id_bill  bill_crr_id_bill ,
  cust.crr_code_bill  crr_code_bill ,
  cust.crr_name_bill  crr_name_bill ,
custord.starttime  custord_starttime,
custord.shelfnos_id_fm   custord_shelfno_id_fm,
  prjno.prjno_name_chil  prjno_name_chil 
 from custords   custord,
  r_persons  person_upd ,  r_custs  cust ,  r_prjnos  prjno ,  r_chrgs  chrg_cpo ,  r_custrcvplcs  custrcvplc ,  r_opeitms  opeitm ,  r_shelfnos  shelfno_fm 
  where       custord.persons_id_upd = person_upd.id      and custord.custs_id = cust.id      and custord.prjnos_id = prjno.id      and custord.chrgs_id_cpo = chrg_cpo.id      and custord.custrcvplcs_id = custrcvplc.id      and custord.opeitms_id = opeitm.id      and custord.shelfnos_id_fm = shelfno_fm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_custords;
 CREATE TABLE sio.sio_r_custords (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_custords_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,custord_isudate   date 
,custord_cno  varchar (40) 
,loca_code_cust  varchar (50) 
,loca_name_cust  varchar (100) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,custord_duedate   timestamp(6) 
,custord_qty  numeric (18,4)
,custord_price  numeric (22,0)
,custord_contract_price  varchar (1) 
,custord_itm_code_client  varchar (50) 
,custord_amt  numeric (18,4)
,person_code_chrg_cust  varchar (50) 
,person_name_chrg_cust  varchar (100) 
,loca_code_sect_chrg_cust  varchar (50) 
,loca_name_sect_chrg_cust  varchar (100) 
,person_code_chrg_bill  varchar (50) 
,loca_code_sect_chrg_bill  varchar (50) 
,loca_name_sect_chrg_bill  varchar (100) 
,loca_code_bill  varchar (50) 
,loca_name_bill  varchar (100) 
,boxe_code  varchar (50) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,usrgrp_code_chrg_bill  varchar (50) 
,person_name_chrg_bill  varchar (100) 
,scrlv_code_chrg_bill  varchar (50) 
,loca_code  varchar (50) 
,scrlv_code_chrg_cust  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,boxe_name  varchar (100) 
,usrgrp_name_chrg_bill  varchar (100) 
,loca_name  varchar (100) 
,usrgrp_code_chrg_cust  varchar (50) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,usrgrp_name_chrg_cust  varchar (100) 
,crr_code_bill  varchar (50) 
,crr_name_bill  varchar (100) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,classlist_code  varchar (50) 
,custord_starttime   timestamp(6) 
,custord_cno_custsch  varchar (50) 
,classlist_name  varchar (100) 
,custord_sno  varchar (40) 
,loca_code_custrcvplc  varchar (50) 
,scrlv_code_chrg_cpo  varchar (50) 
,usrgrp_code_chrg_cpo  varchar (50) 
,person_code_chrg_cpo  varchar (50) 
,loca_code_sect_chrg_cpo  varchar (50) 
,shelfno_code_fm  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,prjno_name_chil  varchar (100) 
,usrgrp_name_chrg_cpo  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,person_name_chrg_cpo  varchar (100) 
,loca_name_sect_chrg_cpo  varchar (100) 
,loca_name_custrcvplc  varchar (100) 
,shelfno_name_fm  varchar (100) 
,custord_shelfno_id_fm  numeric (22,0)
,custord_gno  varchar (40) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,custord_toduedate   timestamp(6) 
,custord_expiredate   date 
,custord_contents  varchar (4000) 
,custord_remark  varchar (4000) 
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,bill_chrg_id_bill  numeric (22,0)
,chrg_person_id_chrg_cpo  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,custrcvplc_loca_id_custrcvplc  numeric (38,0)
,person_sect_id_chrg_cpo  numeric (22,0)
,bill_loca_id_bill  numeric (38,0)
,custord_prjno_id  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,custord_chrg_id_cpo  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,cust_loca_id_cust  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,custord_custrcvplc_id  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,person_sect_id_chrg_bill  numeric (22,0)
,chrg_person_id_chrg_bill  numeric (38,0)
,custord_opeitm_id  numeric (38,0)
,bill_crr_id_bill  numeric (22,0)
,opeitm_loca_id  numeric (38,0)
,cust_chrg_id_cust  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,person_sect_id_chrg_cust  numeric (22,0)
,chrg_person_id_chrg_cust  numeric (38,0)
,custord_person_id_upd  numeric (22,0)
,custord_created_at   timestamp(6) 
,id  numeric (22,0)
,custord_updated_at   timestamp(6) 
,custord_id  numeric (22,0)
,custord_update_ip  varchar (40) 
,cust_bill_id  numeric (22,0)
,custord_cust_id  numeric (22,0)
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
 CREATE INDEX sio_r_custords_uk1 
  ON sio.sio_r_custords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_custords_seq ;
 create sequence sio.sio_r_custords_seq ;
  drop view if  exists r_shpschs cascade ; 
 create or replace view r_shpschs as select  
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  itm.itm_name  itm_name ,
  itm.itm_code  itm_code ,
  itm.unit_name  unit_name ,
  itm.unit_code  unit_code ,
  itm.itm_unit_id  itm_unit_id ,
  transport.transport_code  transport_code ,
  transport.transport_name  transport_name ,
shpsch.id id,
shpsch.expiredate  shpsch_expiredate,
shpsch.updated_at  shpsch_updated_at,
shpsch.depdate  shpsch_depdate,
shpsch.remark  shpsch_remark,
shpsch.created_at  shpsch_created_at,
shpsch.update_ip  shpsch_update_ip,
shpsch.id  shpsch_id,
shpsch.itms_id   shpsch_itm_id,
shpsch.tax  shpsch_tax,
shpsch.locas_id_to   shpsch_loca_id_to,
  loca_to.loca_code  loca_code_to ,
  loca_to.loca_name  loca_name_to ,
shpsch.sno  shpsch_sno,
shpsch.price  shpsch_price,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
shpsch.persons_id_upd   shpsch_person_id_upd,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
shpsch.isudate  shpsch_isudate,
shpsch.processseq  shpsch_processseq,
shpsch.manual  shpsch_manual,
  prjno.prjno_code  prjno_code ,
shpsch.prjnos_id   shpsch_prjno_id,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
shpsch.contract_price  shpsch_contract_price,
shpsch.chrgs_id   shpsch_chrg_id,
shpsch.qty_case  shpsch_qty_case,
  prjno.prjno_code_chil  prjno_code_chil ,
shpsch.transports_id   shpsch_transport_id,
  itm.itm_classlist_id  itm_classlist_id ,
shpsch.gno  shpsch_gno,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
shpsch.lotno  shpsch_lotno,
shpsch.packno  shpsch_packno,
shpsch.paretblname  shpsch_paretblname,
shpsch.paretblid  shpsch_paretblid,
shpsch.shelfnos_id_fm   shpsch_shelfno_id_fm,
shpsch.qty_sch  shpsch_qty_sch,
shpsch.amt_sch  shpsch_amt_sch,
  prjno.prjno_name_chil  prjno_name_chil 
 from shpschs   shpsch,
  r_itms  itm ,  r_locas  loca_to ,  r_persons  person_upd ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_transports  transport ,  r_shelfnos  shelfno_fm 
  where       shpsch.itms_id = itm.id      and shpsch.locas_id_to = loca_to.id      and shpsch.persons_id_upd = person_upd.id      and shpsch.prjnos_id = prjno.id      and shpsch.chrgs_id = chrg.id      and shpsch.transports_id = transport.id      and shpsch.shelfnos_id_fm = shelfno_fm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shpschs;
 CREATE TABLE sio.sio_r_shpschs (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shpschs_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,shpsch_isudate   timestamp(6) 
,itm_code  varchar (50) 
,person_code_upd  varchar (50) 
,itm_name  varchar (100) 
,person_name_upd  varchar (100) 
,shpsch_depdate   timestamp(6) 
,loca_code_shelfno_fm  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,shelfno_code_fm  varchar (50) 
,shelfno_name_fm  varchar (100) 
,loca_code_to  varchar (50) 
,loca_name_to  varchar (100) 
,shpsch_lotno  varchar (50) 
,shpsch_packno  varchar (10) 
,shpsch_price  numeric (38,4)
,shpsch_tax  numeric (38,4)
,transport_code  varchar (50) 
,transport_name  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,prjno_code  varchar (50) 
,classlist_code  varchar (50) 
,shpsch_sno  varchar (40) 
,shpsch_gno  varchar (40) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,shpsch_paretblid  numeric (38,0)
,shpsch_processseq  numeric (38,0)
,shpsch_manual  varchar (1) 
,shpsch_paretblname  varchar (30) 
,shpsch_expiredate   date 
,shpsch_contract_price  varchar (1) 
,prjno_name  varchar (100) 
,classlist_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,prjno_name_chil  varchar (100) 
,shpsch_qty_case  numeric (38,0)
,shpsch_amt_sch  numeric (38,4)
,shpsch_qty_sch  numeric (22,6)
,shpsch_remark  varchar (4000) 
,shpsch_transport_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,shpsch_update_ip  varchar (40) 
,shpsch_created_at   timestamp(6) 
,shpsch_updated_at   timestamp(6) 
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,shpsch_prjno_id  numeric (38,0)
,shpsch_person_id_upd  numeric (38,0)
,shpsch_shelfno_id_fm  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,shpsch_itm_id  numeric (38,0)
,shpsch_chrg_id  numeric (38,0)
,shpsch_loca_id_to  numeric (38,0)
,shpsch_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
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
 CREATE INDEX sio_r_shpschs_uk1 
  ON sio.sio_r_shpschs(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpschs_seq ;
 create sequence sio.sio_r_shpschs_seq ;
  drop view if  exists r_puracts cascade ; 
 create or replace view r_puracts as select  
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
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
puract.id id,
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
puract.opeitms_id   puract_opeitm_id,
puract.id  puract_id,
puract.remark  puract_remark,
puract.expiredate  puract_expiredate,
puract.update_ip  puract_update_ip,
puract.created_at  puract_created_at,
puract.updated_at  puract_updated_at,
puract.persons_id_upd   puract_person_id_upd,
puract.isudate  puract_isudate,
puract.contents  puract_contents,
puract.rcptdate  puract_rcptdate,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  prjno.prjno_code  prjno_code ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
puract.chrgs_id   puract_chrg_id,
puract.prjnos_id   puract_prjno_id,
puract.sno  puract_sno,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
puract.cno  puract_cno,
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
puract.lotno  puract_lotno,
puract.itm_code_client  puract_itm_code_client,
  prjno.prjno_code_chil  prjno_code_chil ,
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
  crr_pur.crr_name  crr_name_pur ,
  crr_pur.crr_code  crr_code_pur ,
  opeitm.itm_classlist_id  itm_classlist_id ,
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
puract.suppliers_id   puract_supplier_id,
puract.sno_purinst  puract_sno_purinst,
puract.sno_purord  puract_sno_purord,
puract.sno_purdlv  puract_sno_purdlv,
puract.cno_purinst  puract_cno_purinst,
puract.cno_purdlv  puract_cno_purdlv,
puract.qty_stk  puract_qty_stk,
puract.crrs_id_pur   puract_crr_id_pur,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
puract.shelfnos_id_to   puract_shelfno_id_to,
puract.packno  puract_packno,
puract.crrs_id   puract_crr_id,
  prjno.prjno_name_chil  prjno_name_chil 
 from puracts   puract,
  r_opeitms  opeitm ,  r_persons  person_upd ,  r_chrgs  chrg ,  r_prjnos  prjno ,  r_suppliers  supplier ,  r_crrs  crr_pur ,  r_shelfnos  shelfno_to ,  r_crrs  crr 
  where       puract.opeitms_id = opeitm.id      and puract.persons_id_upd = person_upd.id      and puract.chrgs_id = chrg.id      and puract.prjnos_id = prjno.id      and puract.suppliers_id = supplier.id      and puract.crrs_id_pur = crr_pur.id      and puract.shelfnos_id_to = shelfno_to.id      and puract.crrs_id = crr.id     ;
 DROP TABLE IF EXISTS sio.sio_r_puracts;
 CREATE TABLE sio.sio_r_puracts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_puracts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,puract_sno_purord  varchar (50) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,puract_isudate   timestamp(6) 
,puract_rcptdate   timestamp(6) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,puract_itm_code_client  varchar (50) 
,puract_qty_stk  numeric (38,4)
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_name_outbox  varchar (100) 
,crr_code_supplier  varchar (50) 
,crr_name_supplier  varchar (100) 
,crr_code_pur  varchar (50) 
,crr_name_pur  varchar (100) 
,loca_name_shelfno  varchar (100) 
,loca_code_shelfno  varchar (50) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,crr_code  varchar (50) 
,loca_code_supplier  varchar (50) 
,loca_name_supplier  varchar (100) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,person_code_chrg_supplier  varchar (50) 
,person_name_chrg_supplier  varchar (100) 
,person_code_chrg_payment  varchar (50) 
,person_name_chrg_payment  varchar (100) 
,usrgrp_code_chrg_payment  varchar (50) 
,unit_name_prdpurshp  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,prjno_name  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,prjno_code  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,loca_code_payment  varchar (50) 
,loca_name_payment  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,unit_code_box  varchar (50) 
,unit_name_box  varchar (100) 
,boxe_code  varchar (50) 
,boxe_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,usrgrp_name_chrg_payment  varchar (100) 
,usrgrp_name_chrg_supplier  varchar (100) 
,usrgrp_code_chrg_supplier  varchar (50) 
,scrlv_code_chrg_supplier  varchar (50) 
,loca_name_sect_chrg_supplier  varchar (100) 
,loca_code_sect_chrg_supplier  varchar (50) 
,scrlv_code_chrg_payment  varchar (50) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_code_sect_chrg_payment  varchar (50) 
,puract_lotno  varchar (50) 
,puract_cno_purdlv  varchar (50) 
,crr_name  varchar (100) 
,puract_expiredate   date 
,puract_cno_purinst  varchar (50) 
,shelfno_code_to  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,prjno_name_chil  varchar (100) 
,shelfno_name_to  varchar (100) 
,puract_packno  varchar (10) 
,puract_sno_purinst  varchar (50) 
,puract_crr_id  numeric (22,0)
,puract_sno  varchar (40) 
,puract_cno  varchar (40) 
,puract_sno_purdlv  varchar (50) 
,puract_contents  varchar (4000) 
,puract_remark  varchar (4000) 
,loca_name  varchar (100) 
,loca_code  varchar (50) 
,puract_updated_at   timestamp(6) 
,puract_created_at   timestamp(6) 
,puract_update_ip  varchar (40) 
,puract_crr_id_pur  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,puract_opeitm_id  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,puract_shelfno_id_to  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,puract_chrg_id  numeric (38,0)
,puract_prjno_id  numeric (38,0)
,puract_supplier_id  numeric (22,0)
,puract_person_id_upd  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,boxe_unit_id_outbox  numeric (38,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_payment_id  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,opeitm_shelfno_id  numeric (22,0)
,payment_chrg_id_payment  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
,person_sect_id_chrg_payment  numeric (22,0)
,opeitm_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_boxe_id  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,opeitm_unit_id_case  numeric (38,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,puract_id  numeric (38,0)
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
 CREATE INDEX sio_r_puracts_uk1 
  ON sio.sio_r_puracts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_puracts_seq ;
 create sequence sio.sio_r_puracts_seq ;
  drop view if  exists r_prdrets cascade ; 
 create or replace view r_prdrets as select  
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
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
prdret.id id,
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
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
  loca_fm.loca_code  loca_code_fm ,
  loca_fm.loca_name  loca_name_fm ,
prdret.qty_case  prdret_qty_case,
prdret.retdate  prdret_retdate,
prdret.locas_id_fm   prdret_loca_id_fm,
prdret.id  prdret_id,
prdret.remark  prdret_remark,
prdret.expiredate  prdret_expiredate,
prdret.update_ip  prdret_update_ip,
prdret.created_at  prdret_created_at,
prdret.updated_at  prdret_updated_at,
prdret.persons_id_upd   prdret_person_id_upd,
prdret.qty  prdret_qty,
prdret.sno  prdret_sno,
prdret.isudate  prdret_isudate,
prdret.contents  prdret_contents,
prdret.locas_id_to   prdret_loca_id_to,
prdret.tax  prdret_tax,
prdret.prjnos_id   prdret_prjno_id,
prdret.opeitms_id   prdret_opeitm_id,
  prjno.prjno_code_chil  prjno_code_chil ,
prdret.chrgs_id   prdret_chrg_id,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  prjno.prjno_name_chil  prjno_name_chil ,
prdret.sno_prdact  prdret_sno_prdact
 from prdrets   prdret,
  r_locas  loca_fm ,  r_persons  person_upd ,  r_locas  loca_to ,  r_prjnos  prjno ,  r_opeitms  opeitm ,  r_chrgs  chrg 
  where       prdret.locas_id_fm = loca_fm.id      and prdret.persons_id_upd = person_upd.id      and prdret.locas_id_to = loca_to.id      and prdret.prjnos_id = prjno.id      and prdret.opeitms_id = opeitm.id      and prdret.chrgs_id = chrg.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdrets;
 CREATE TABLE sio.sio_r_prdrets (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prdrets_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,unit_code  varchar (50) 
,classlist_code  varchar (50) 
,itm_code  varchar (50) 
,loca_code  varchar (50) 
,boxe_code  varchar (50) 
,shelfno_code  varchar (50) 
,prjno_code  varchar (50) 
,unit_name  varchar (100) 
,boxe_name  varchar (100) 
,loca_name  varchar (100) 
,shelfno_name  varchar (100) 
,itm_name  varchar (100) 
,classlist_name  varchar (100) 
,prjno_name  varchar (100) 
,prdret_expiredate   date 
,prdret_qty  numeric (18,4)
,prdret_sno  varchar (40) 
,loca_code_shelfno  varchar (50) 
,unit_code_box  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,prjno_code_chil  varchar (50) 
,loca_code_to  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_code_fm  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,unit_code_case  varchar (50) 
,person_code_chrg  varchar (50) 
,unit_code_outbox  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,person_name_chrg  varchar (100) 
,loca_name_to  varchar (100) 
,unit_name_case  varchar (100) 
,loca_name_shelfno  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,unit_name_box  varchar (100) 
,unit_name_outbox  varchar (100) 
,loca_name_fm  varchar (100) 
,prjno_name_chil  varchar (100) 
,prdret_remark  varchar (4000) 
,prdret_tax  numeric (22,0)
,prdret_sno_prdact  varchar (50) 
,prdret_loca_id_fm  numeric (38,0)
,prdret_contents  varchar (4000) 
,prdret_qty_case  numeric (22,0)
,prdret_retdate   date 
,prdret_isudate   timestamp(6) 
,shelfno_loca_id_shelfno  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,opeitm_unit_id_case  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,opeitm_boxe_id  numeric (22,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,boxe_unit_id_box  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,opeitm_shelfno_id  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,prdret_loca_id_to  numeric (22,0)
,prdret_id  numeric (22,0)
,prdret_prjno_id  numeric (22,0)
,prdret_created_at   timestamp(6) 
,prdret_updated_at   timestamp(6) 
,prdret_person_id_upd  numeric (22,0)
,prdret_opeitm_id  numeric (22,0)
,prdret_chrg_id  numeric (22,0)
,prdret_update_ip  varchar (40) 
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
 CREATE INDEX sio_r_prdrets_uk1 
  ON sio.sio_r_prdrets(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdrets_seq ;
 create sequence sio.sio_r_prdrets_seq ;
 ALTER TABLE shprets ADD CONSTRAINT shpret_persons_id_upd FOREIGN KEY (persons_id_upd)
																		 REFERENCES persons (id);
 ALTER TABLE shprets ADD CONSTRAINT shpret_locas_id_to FOREIGN KEY (locas_id_to)
																		 REFERENCES locas (id);
 ALTER TABLE shprets ADD CONSTRAINT shpret_prjnos_id FOREIGN KEY (prjnos_id)
																		 REFERENCES prjnos (id);
 ALTER TABLE shprets ADD CONSTRAINT shpret_chrgs_id FOREIGN KEY (chrgs_id)
																		 REFERENCES chrgs (id);
 ALTER TABLE shprets ADD CONSTRAINT shpret_crrs_id FOREIGN KEY (crrs_id)
																		 REFERENCES crrs (id);
 ALTER TABLE shprets ADD CONSTRAINT shpret_locas_id_fm FOREIGN KEY (locas_id_fm)
																		 REFERENCES locas (id);
