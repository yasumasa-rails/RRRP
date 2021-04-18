
 alter table purdlvs DROP COLUMN locas_id_to CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'locas_id_to'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　locas_id_toが削除　2021-04-16 22:13:12 +0900' 
 ---- where  pobject_code_sfd = 'locas_id_to'
  drop view if  exists r_purdlvs cascade ; 
 create or replace view r_purdlvs as select  
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_code_chrg  person_code_chrg ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_std  itm_std ,
  opeitm.itm_code  itm_code ,
  chrg.person_email_chrg  person_email_chrg ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_duration  opeitm_duration ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  prjno.prjno_name  prjno_name ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  opeitm.opeitm_operation  opeitm_operation ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  chrg.scrlv_level1_chrg  scrlv_level1_chrg ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  opeitm.opeitm_opt_fixoterm  opeitm_opt_fixoterm ,
  opeitm.opeitm_autocreate_ord  opeitm_autocreate_ord ,
  opeitm.opeitm_autocreate_inst  opeitm_autocreate_inst ,
  opeitm.opeitm_prdpurshp  opeitm_prdpurshp ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.opeitm_contents  opeitm_contents ,
  opeitm.opeitm_autocreate_act  opeitm_autocreate_act ,
  opeitm.opeitm_shuffle_flg  opeitm_shuffle_flg ,
  opeitm.opeitm_chkord_proc  opeitm_chkord_proc ,
  prjno.prjno_code  prjno_code ,
  opeitm.opeitm_esttosch  opeitm_esttosch ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  supplier.loca_code_payment  loca_code_payment ,
  supplier.loca_name_payment  loca_name_payment ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  opeitm.opeitm_rule_price  opeitm_rule_price ,
  opeitm.opeitm_mold  opeitm_mold ,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  opeitm.boxe_boxtype  boxe_boxtype ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.opeitm_opt_fix_flg  opeitm_opt_fix_flg ,
  opeitm.opeitm_prjalloc_flg  opeitm_prjalloc_flg ,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_units_lttime  opeitm_units_lttime ,
  opeitm.opeitm_autoord_p  opeitm_autoord_p ,
  opeitm.opeitm_autoinst_p  opeitm_autoinst_p ,
  opeitm.opeitm_autoact_p  opeitm_autoact_p ,
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
purdlv.qty  purdlv_qty,
purdlv.qty_case  purdlv_qty_case,
purdlv.gno  purdlv_gno,
  opeitm.opeitm_stktaking_proc  opeitm_stktaking_proc ,
  opeitm.opeitm_acceptance_proc  opeitm_acceptance_proc ,
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
  r_shelfnos  shelfno_to 
  where       purdlv.shelfnos_id_to = shelfno_to.id     ;
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
,purdlv_qty  numeric (18,4)
,opeitm_packqty  numeric (38,0)
,purdlv_qty_case  numeric (38,0)
,purdlv_gno  varchar (40) 
,person_code_upd  varchar (50) 
,itm_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,crr_name_supplier  varchar (100) 
,unit_code_prdpurshp  varchar (50) 
,person_name_chrg  varchar (100) 
,person_code_chrg  varchar (50) 
,itm_name  varchar (100) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_sect_chrg  varchar (100) 
,prjno_name  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,unit_code_case  varchar (50) 
,unit_name_case  varchar (100) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,prjno_code  varchar (50) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,loca_code_payment  varchar (50) 
,loca_name_payment  varchar (100) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
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
,unit_name_prdpurshp  varchar (100) 
,crr_code_supplier  varchar (50) 
,scrlv_code_chrg_supplier  varchar (50) 
,loca_name_sect_chrg_supplier  varchar (100) 
,loca_code_sect_chrg_supplier  varchar (50) 
,scrlv_code_chrg_payment  varchar (50) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_code_sect_chrg_payment  varchar (50) 
,person_name_upd  varchar (100) 
,prjno_name_chil  varchar (100) 
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_priority  numeric (3,0)
,opeitm_opt_fix_flg  varchar (1) 
,person_email_chrg  varchar (50) 
,opeitm_operation  varchar (20) 
,opeitm_processseq  numeric (3,0)
,scrlv_level1_chrg  varchar (1) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_prdpurshp  varchar (20) 
,itm_std  varchar (50) 
,opeitm_stktaking_proc  varchar (1) 
,opeitm_acceptance_proc  varchar (1) 
,opeitm_contents  varchar (4000) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_shuffle_flg  varchar (1) 
,opeitm_chkord_proc  numeric (3,0)
,opeitm_esttosch  numeric (22,0)
,shelfno_code_to  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,opeitm_rule_price  varchar (1) 
,opeitm_mold  varchar (1) 
,boxe_boxtype  varchar (20) 
,opeitm_units_lttime  varchar (4) 
,opeitm_autoord_p  numeric (3,0)
,opeitm_autoinst_p  numeric (3,0)
,opeitm_autoact_p  numeric (3,0)
,opeitm_duration  numeric (38,2)
,shelfno_name_to  varchar (100) 
,loca_name_shelfno_to  varchar (100) 
,purdlv_cno_purinst  varchar (50) 
,purdlv_sno_purinst  varchar (50) 
,purdlv_shelfno_id_to  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,person_sect_id_chrg_payment  numeric (22,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,itm_unit_id  numeric (22,0)
,payment_loca_id_payment  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,supplier_payment_id  numeric (38,0)
,boxe_unit_id_box  numeric (38,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,boxe_unit_id_outbox  numeric (38,0)
,supplier_loca_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,supplier_crr_id_supplier  numeric (22,0)
,payment_chrg_id_payment  numeric (22,0)
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
 ALTER TABLE purdlvs ADD CONSTRAINT purdlv_shelfnos_id_to FOREIGN KEY (shelfnos_id_to)
																		 REFERENCES shelfnos (id);
