
 alter table inspords DROP COLUMN locas_id_to CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'locas_id_to'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　locas_id_toが削除　2020-01-22 15:42:37 +0900' 
 ---- where  pobject_code_sfd = 'locas_id_to'
 alter table inspords DROP COLUMN opeitms_id CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'opeitms_id'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　opeitms_idが削除　2020-01-22 15:42:37 +0900' 
 ---- where  pobject_code_sfd = 'opeitms_id'
 alter table  inspords  ADD COLUMN itms_id numeric(38,0);

 alter table  inspords  ADD COLUMN processseq numeric(38,0);

 alter table  inspords  ADD COLUMN shelfnos_id_to numeric(38,0);

 alter table  inspords  ADD COLUMN shelfnos_id_fm numeric(22,0);

 ALTER TABLE inspords ADD CONSTRAINT inspord_itms_id FOREIGN KEY (itms_id)
																		 REFERENCES itms (id);
 ALTER TABLE inspords ADD CONSTRAINT inspord_shelfnos_id_to FOREIGN KEY (shelfnos_id_to)
																		 REFERENCES shelfnos (id);
 ALTER TABLE inspords ADD CONSTRAINT inspord_shelfnos_id_fm FOREIGN KEY (shelfnos_id_fm)
																		 REFERENCES shelfnos (id);
 --- drop view r_inspords cascade  
 create or replace view r_inspords as select  
  reason.reason_code  reason_code ,
  reason.reason_name  reason_name ,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  reason.reason_contents  reason_contents ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  prjno.prjno_name  prjno_name ,
  itm.unit_code  unit_code ,
  itm.unit_name  unit_name ,
  itm.itm_std  itm_std ,
  itm.itm_model  itm_model ,
  itm.itm_material  itm_material ,
  itm.itm_design  itm_design ,
  itm.itm_weight  itm_weight ,
  itm.itm_length  itm_length ,
  itm.itm_wide  itm_wide ,
  itm.itm_deth  itm_deth ,
  itm.itm_code  itm_code ,
  itm.itm_name  itm_name ,
  supplier.scrlv_code_chrg_payment  scrlv_code_chrg_payment ,
  supplier.scrlv_code_chrg_supplier  scrlv_code_chrg_supplier ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  supplier.payment_chrg_id_payment  payment_chrg_id_payment ,
inspord.sno_purord  inspord_sno_purord,
  supplier.loca_abbr_supplier  loca_abbr_supplier ,
  supplier.loca_zip_supplier  loca_zip_supplier ,
  supplier.loca_country_supplier  loca_country_supplier ,
  supplier.loca_prfct_supplier  loca_prfct_supplier ,
  supplier.loca_addr1_supplier  loca_addr1_supplier ,
  supplier.loca_addr2_supplier  loca_addr2_supplier ,
  supplier.loca_tel_supplier  loca_tel_supplier ,
  supplier.loca_fax_supplier  loca_fax_supplier ,
  supplier.loca_mail_supplier  loca_mail_supplier ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  supplier.loca_code_sect_chrg_payment  loca_code_sect_chrg_payment ,
  supplier.loca_code_sect_chrg_supplier  loca_code_sect_chrg_supplier ,
  supplier.loca_code_supplier  loca_code_supplier ,
  supplier.loca_code_payment  loca_code_payment ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  supplier.loca_name_sect_chrg_payment  loca_name_sect_chrg_payment ,
  supplier.loca_name_sect_chrg_supplier  loca_name_sect_chrg_supplier ,
  supplier.loca_name_supplier  loca_name_supplier ,
  supplier.loca_name_payment  loca_name_payment ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  supplier.person_code_chrg_supplier  person_code_chrg_supplier ,
  supplier.person_code_chrg_payment  person_code_chrg_payment ,
  chrg.person_code_chrg  person_code_chrg ,
  supplier.person_name_chrg_supplier  person_name_chrg_supplier ,
  supplier.person_name_chrg_payment  person_name_chrg_payment ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_email_chrg  person_email_chrg ,
  itm.itm_unit_id  itm_unit_id ,
  chrg.scrlv_level1_chrg  scrlv_level1_chrg ,
inspord.reasons_id   inspord_reason_id,
  itm.itm_classlist_id  itm_classlist_id ,
  itm.itm_datascale  itm_datascale ,
inspord.shelfnos_id_to   inspord_shelfno_id_to,
  supplier.supplier_amtdecimal  supplier_amtdecimal ,
  supplier.supplier_custtype  supplier_custtype ,
  supplier.supplier_contents  supplier_contents ,
  supplier.supplier_loca_id_supplier  supplier_loca_id_supplier ,
  supplier.supplier_contract_price  supplier_contract_price ,
  supplier.supplier_rule_price  supplier_rule_price ,
  supplier.supplier_amtround  supplier_amtround ,
  supplier.supplier_chrg_id_supplier  supplier_chrg_id_supplier ,
  supplier.supplier_personname  supplier_personname ,
  supplier.supplier_payment_id  supplier_payment_id ,
  supplier.supplier_crr_id_supplier  supplier_crr_id_supplier ,
  itm.unit_contents  unit_contents ,
inspord.processseq  inspord_processseq,
inspord.shelfnos_id_fm   inspord_shelfno_id_fm,
  supplier.usrgrp_name_chrg_supplier  usrgrp_name_chrg_supplier ,
  supplier.usrgrp_name_chrg_payment  usrgrp_name_chrg_payment ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  itm.classlist_code  classlist_code ,
  supplier.crr_code_supplier  crr_code_supplier ,
  supplier.crr_name_supplier  crr_name_supplier ,
inspord.itms_id   inspord_itm_id,
inspord.id  inspord_id,
inspord.id id,
inspord.isudate  inspord_isudate,
inspord.duedate  inspord_duedate,
inspord.qty  inspord_qty,
inspord.price  inspord_price,
inspord.amt  inspord_amt,
inspord.tax  inspord_tax,
inspord.contract_price  inspord_contract_price,
inspord.gno  inspord_gno,
inspord.itm_code_client  inspord_itm_code_client,
inspord.sno  inspord_sno,
inspord.contents  inspord_contents,
inspord.remark  inspord_remark,
inspord.expiredate  inspord_expiredate,
inspord.suppliers_id   inspord_supplier_id,
inspord.prjnos_id   inspord_prjno_id,
inspord.chrgs_id   inspord_chrg_id,
inspord.persons_id_upd   inspord_person_id_upd,
inspord.update_ip  inspord_update_ip,
inspord.created_at  inspord_created_at,
inspord.updated_at  inspord_updated_at,
  supplier.person_sect_id_chrg_payment  person_sect_id_chrg_payment ,
  supplier.person_sect_id_chrg_supplier  person_sect_id_chrg_supplier ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  supplier.usrgrp_code_chrg_supplier  usrgrp_code_chrg_supplier ,
  supplier.usrgrp_code_chrg_payment  usrgrp_code_chrg_payment ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  itm.classlist_name  classlist_name ,
  supplier.payment_loca_id_payment  payment_loca_id_payment ,
  prjno.prjno_code_chil  prjno_code_chil ,
  prjno.prjno_code  prjno_code ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  shelfno_fm.shelfno_contents  shelfno_contents_fm ,
  shelfno_to.shelfno_contents  shelfno_contents_to ,
  supplier.chrg_person_id_chrg_payment  chrg_person_id_chrg_payment ,
  supplier.chrg_person_id_chrg_supplier  chrg_person_id_chrg_supplier ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg 
 from inspords   inspord,
  r_reasons  reason ,  r_shelfnos  shelfno_to ,  r_shelfnos  shelfno_fm ,  r_itms  itm ,  r_suppliers  supplier ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_persons  person_upd 
  where       inspord.reasons_id = reason.id      and inspord.shelfnos_id_to = shelfno_to.id      and inspord.shelfnos_id_fm = shelfno_fm.id      and inspord.itms_id = itm.id      and inspord.suppliers_id = supplier.id      and inspord.prjnos_id = prjno.id      and inspord.chrgs_id = chrg.id      and inspord.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_inspords;
 CREATE TABLE sio.sio_r_inspords (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_inspords_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,inspord_sno  varchar (40) 
,inspord_gno  varchar (40) 
,scrlv_code_chrg_supplier  varchar (50) 
,scrlv_code_chrg  varchar (50) 
,prjno_code  varchar (50) 
,usrgrp_code_chrg_supplier  varchar (50) 
,shelfno_code_fm  varchar (50) 
,shelfno_code_to  varchar (50) 
,reason_name  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,usrgrp_code_chrg_payment  varchar (50) 
,person_code_chrg_supplier  varchar (50) 
,person_code_chrg_payment  varchar (50) 
,person_code_chrg  varchar (50) 
,person_name_chrg_supplier  varchar (100) 
,person_name_chrg_payment  varchar (100) 
,person_name_chrg  varchar (100) 
,itm_code  varchar (50) 
,prjno_code_chil  varchar (50) 
,itm_name  varchar (100) 
,classlist_name  varchar (100) 
,scrlv_code_chrg_payment  varchar (50) 
,shelfno_name_fm  varchar (100) 
,usrgrp_name_chrg_supplier  varchar (100) 
,usrgrp_name_chrg_payment  varchar (100) 
,usrgrp_name_chrg  varchar (100) 
,classlist_code  varchar (50) 
,crr_code_supplier  varchar (50) 
,crr_name_supplier  varchar (100) 
,shelfno_name_to  varchar (100) 
,reason_code  varchar (50) 
,prjno_name  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,loca_code_sect_chrg_payment  varchar (50) 
,loca_code_sect_chrg_supplier  varchar (50) 
,loca_code_supplier  varchar (50) 
,loca_code_payment  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_shelfno_to  varchar (100) 
,loca_name_sect_chrg_payment  varchar (100) 
,loca_name_sect_chrg_supplier  varchar (100) 
,loca_name_supplier  varchar (100) 
,loca_name_payment  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,inspord_expiredate   date 
,inspord_itm_code_client  varchar (50) 
,inspord_contract_price  varchar (1) 
,inspord_processseq  numeric (38,0)
,inspord_sno_purord  varchar (50) 
,inspord_tax  numeric (38,4)
,inspord_amt  numeric (18,4)
,inspord_isudate   timestamp(6) 
,inspord_duedate   timestamp(6) 
,inspord_qty  numeric (18,4)
,inspord_price  numeric (38,4)
,loca_addr2_supplier  varchar (50) 
,reason_contents  varchar (4000) 
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,itm_material  varchar (50) 
,itm_design  varchar (50) 
,itm_weight  numeric (22,0)
,itm_length  numeric (22,0)
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,loca_abbr_supplier  varchar (50) 
,loca_zip_supplier  varchar (10) 
,loca_country_supplier  varchar (20) 
,loca_prfct_supplier  varchar (20) 
,loca_addr1_supplier  varchar (50) 
,loca_tel_supplier  varchar (20) 
,loca_fax_supplier  varchar (20) 
,loca_mail_supplier  varchar (20) 
,person_email_chrg  varchar (50) 
,scrlv_level1_chrg  varchar (1) 
,itm_datascale  numeric (22,0)
,supplier_amtdecimal  numeric (38,0)
,supplier_custtype  varchar (1) 
,supplier_contents  varchar (4000) 
,supplier_contract_price  varchar (1) 
,supplier_rule_price  varchar (1) 
,supplier_amtround  varchar (2) 
,supplier_personname  varchar (30) 
,unit_contents  varchar (4000) 
,shelfno_contents_fm  varchar (4000) 
,shelfno_contents_to  varchar (4000) 
,inspord_remark  varchar (4000) 
,inspord_contents  varchar (4000) 
,inspord_itm_id  numeric (38,0)
,inspord_shelfno_id_fm  numeric (22,0)
,inspord_supplier_id  numeric (22,0)
,inspord_prjno_id  numeric (38,0)
,inspord_chrg_id  numeric (38,0)
,inspord_person_id_upd  numeric (38,0)
,inspord_update_ip  varchar (40) 
,inspord_created_at   timestamp(6) 
,inspord_updated_at   timestamp(6) 
,inspord_shelfno_id_to  numeric (38,0)
,inspord_reason_id  numeric (22,0)
,id  numeric (38,0)
,inspord_id  numeric (38,0)
,person_sect_id_chrg_supplier  numeric (22,0)
,person_sect_id_chrg  numeric (22,0)
,supplier_loca_id_supplier  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,supplier_payment_id  numeric (38,0)
,supplier_crr_id_supplier  numeric (22,0)
,supplier_chrg_id_supplier  numeric (22,0)
,chrg_person_id_chrg_payment  numeric (38,0)
,payment_loca_id_payment  numeric (38,0)
,itm_unit_id  numeric (22,0)
,payment_chrg_id_payment  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,chrg_person_id_chrg_supplier  numeric (38,0)
,person_sect_id_chrg_payment  numeric (22,0)
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
 CREATE INDEX sio_r_inspords_uk1 
  ON sio.sio_r_inspords(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_inspords_seq ;
 create sequence sio.sio_r_inspords_seq ;
