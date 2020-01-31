
 alter table prdacts DROP COLUMN locas_id_to CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'locas_id_to'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　locas_id_toが削除　2020-01-27 12:32:36 +0900' 
 ---- where  pobject_code_sfd = 'locas_id_to'
 alter table prdacts DROP COLUMN sno_inst CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'sno_inst'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　sno_instが削除　2020-01-27 12:32:36 +0900' 
 ---- where  pobject_code_sfd = 'sno_inst'
 alter table prdacts DROP COLUMN cno_inst CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'cno_inst'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　cno_instが削除　2020-01-27 12:32:36 +0900' 
 ---- where  pobject_code_sfd = 'cno_inst'
 alter table  prdacts  ADD COLUMN shelfnos_id_to numeric(38,0);

 ALTER TABLE prdacts ADD CONSTRAINT prdact_shelfnos_id_to FOREIGN KEY (shelfnos_id_to)
																		 REFERENCES shelfnos (id);
 --- drop view r_prdacts cascade  
 create or replace view r_prdacts as select  
prdact.opeitms_id   prdact_opeitm_id,
  opeitm.opeitm_boxe_id  opeitm_boxe_id ,
prdact.prjnos_id   prdact_prjno_id,
  opeitm.opeitm_shelfno_id  opeitm_shelfno_id ,
  opeitm.opeitm_prdpurshp  opeitm_prdpurshp ,
  opeitm.opeitm_opt_fix_flg  opeitm_opt_fix_flg ,
prdact.lotno  prdact_lotno,
prdact.chrgs_id   prdact_chrg_id,
  shelfno_to.shelfno_code  shelfno_code_to ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  opeitm.shelfno_name  shelfno_name ,
  prjno.prjno_name  prjno_name ,
  opeitm.opeitm_autocreate_ord  opeitm_autocreate_ord ,
  opeitm.opeitm_autoinst_p  opeitm_autoinst_p ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_code  unit_code ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.itm_code  itm_code ,
  opeitm.itm_name  itm_name ,
  opeitm.opeitm_autoact_p  opeitm_autoact_p ,
  opeitm.opeitm_autoord_p  opeitm_autoord_p ,
prdact.shelfnos_id_to   prdact_shelfno_id_to,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
  opeitm.loca_abbr  loca_abbr ,
  opeitm.loca_zip  loca_zip ,
  opeitm.loca_country_shelfno  loca_country_shelfno ,
  opeitm.loca_prfct  loca_prfct ,
  opeitm.loca_addr1  loca_addr1 ,
  opeitm.loca_addr2  loca_addr2 ,
  opeitm.opeitm_duration  opeitm_duration ,
  opeitm.opeitm_units_lttime  opeitm_units_lttime ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  opeitm.loca_code  loca_code ,
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  opeitm.loca_name  loca_name ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
  opeitm.opeitm_loca_id  opeitm_loca_id ,
  opeitm.opeitm_minqty  opeitm_minqty ,
  chrg.person_code_chrg  person_code_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  chrg.person_email_chrg  person_email_chrg ,
  opeitm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno ,
  opeitm.itm_unit_id  itm_unit_id ,
  chrg.scrlv_level1_chrg  scrlv_level1_chrg ,
  opeitm.opeitm_operation  opeitm_operation ,
  opeitm.opeitm_opt_fixoterm  opeitm_opt_fixoterm ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  opeitm.opeitm_safestkqty  opeitm_safestkqty ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_unit_id_case  opeitm_unit_id_case ,
  opeitm.opeitm_shuffle_flg  opeitm_shuffle_flg ,
  opeitm.opeitm_chkord_prc  opeitm_chkord_prc ,
  opeitm.opeitm_chkord  opeitm_chkord ,
  opeitm.opeitm_autocreate_act  opeitm_autocreate_act ,
  opeitm.opeitm_shuffle_loca  opeitm_shuffle_loca ,
  opeitm.opeitm_esttosch  opeitm_esttosch ,
  opeitm.opeitm_stktaking_proc  opeitm_stktaking_proc ,
  opeitm.opeitm_rule_price  opeitm_rule_price ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  opeitm.classlist_code  classlist_code ,
  opeitm.opeitm_mold  opeitm_mold ,
prdact.id  prdact_id,
prdact.id id,
prdact.contents  prdact_contents,
  opeitm.opeitm_autocreate_inst  opeitm_autocreate_inst ,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  opeitm.classlist_name  classlist_name ,
  opeitm.opeitm_packno_flg  opeitm_packno_flg ,
  prjno.prjno_code_chil  prjno_code_chil ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_priority  opeitm_priority ,
  prjno.prjno_code  prjno_code ,
  opeitm.opeitm_contents  opeitm_contents ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  shelfno_to.shelfno_contents  shelfno_contents_to ,
  opeitm.opeitm_acceptance_proc  opeitm_acceptance_proc ,
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
prdact.isudate  prdact_isudate,
prdact.cmpldate  prdact_cmpldate,
prdact.qty_case  prdact_qty_case,
prdact.qty  prdact_qty,
prdact.sno  prdact_sno,
prdact.remark  prdact_remark,
prdact.expiredate  prdact_expiredate,
prdact.persons_id_upd   prdact_person_id_upd,
prdact.update_ip  prdact_update_ip,
prdact.created_at  prdact_created_at,
prdact.updated_at  prdact_updated_at,
  opeitm.opeitm_chkinst  opeitm_chkinst ,
prdact.cno  prdact_cno,
prdact.gno  prdact_gno,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
  opeitm.boxe_boxtype  boxe_boxtype ,
  opeitm.boxe_unit_id_box  boxe_unit_id_box ,
  opeitm.boxe_unit_id_outbox  boxe_unit_id_outbox ,
  opeitm.opeitm_maxqty  opeitm_maxqty ,
  opeitm.opeitm_prjalloc_flg  opeitm_prjalloc_flg 
 from prdacts   prdact,
  r_opeitms  opeitm ,  r_prjnos  prjno ,  r_chrgs  chrg ,  r_shelfnos  shelfno_to ,  r_persons  person_upd 
  where       prdact.opeitms_id = opeitm.id      and prdact.prjnos_id = prjno.id      and prdact.chrgs_id = chrg.id      and prdact.shelfnos_id_to = shelfno_to.id      and prdact.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_prdacts;
 CREATE TABLE sio.sio_r_prdacts (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_prdacts_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,prdact_sno  varchar (40) 
,prdact_gno  varchar (40) 
,prdact_cno  varchar (40) 
,loca_name  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,classlist_code  varchar (50) 
,shelfno_code  varchar (50) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,boxe_code  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,boxe_name  varchar (100) 
,shelfno_name_to  varchar (100) 
,shelfno_name  varchar (100) 
,prjno_name  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_code_box  varchar (50) 
,unit_code_case  varchar (50) 
,unit_code  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,unit_name_outbox  varchar (100) 
,unit_name_box  varchar (100) 
,unit_name_case  varchar (100) 
,unit_name  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,loca_code  varchar (50) 
,loca_name_shelfno  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,classlist_name  varchar (100) 
,shelfno_code_to  varchar (50) 
,loca_code_shelfno_to  varchar (50) 
,loca_code_shelfno  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_name_shelfno_to  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,prjno_code  varchar (50) 
,prjno_code_chil  varchar (50) 
,prdact_lotno  varchar (50) 
,prdact_qty  numeric (18,4)
,prdact_expiredate   date 
,prdact_qty_case  numeric (38,0)
,prdact_cmpldate   timestamp(6) 
,prdact_isudate   timestamp(6) 
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_prdpurshp  varchar (20) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_autocreate_ord  varchar (1) 
,opeitm_autoinst_p  numeric (3,0)
,opeitm_autoact_p  numeric (3,0)
,opeitm_autoord_p  numeric (3,0)
,opeitm_duration  numeric (38,2)
,opeitm_units_lttime  varchar (4) 
,opeitm_minqty  numeric (38,6)
,person_email_chrg  varchar (50) 
,scrlv_level1_chrg  varchar (1) 
,opeitm_operation  varchar (20) 
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_safestkqty  numeric (38,0)
,opeitm_packqty  numeric (38,0)
,opeitm_shuffle_flg  varchar (1) 
,opeitm_chkord_prc  numeric (3,0)
,opeitm_chkord  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_esttosch  numeric (22,0)
,opeitm_stktaking_proc  varchar (1) 
,opeitm_rule_price  varchar (1) 
,opeitm_mold  varchar (1) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_packno_flg  varchar (1) 
,opeitm_processseq  numeric (3,0)
,opeitm_priority  numeric (3,0)
,opeitm_contents  varchar (4000) 
,shelfno_contents_to  varchar (4000) 
,opeitm_acceptance_proc  varchar (1) 
,opeitm_chkinst  varchar (1) 
,boxe_boxtype  varchar (20) 
,opeitm_maxqty  numeric (22,0)
,prdact_contents  varchar (4000) 
,prdact_remark  varchar (4000) 
,prdact_person_id_upd  numeric (38,0)
,prdact_update_ip  varchar (40) 
,prdact_prjno_id  numeric (38,0)
,prdact_shelfno_id_to  numeric (38,0)
,prdact_created_at   timestamp(6) 
,prdact_id  numeric (38,0)
,id  numeric (38,0)
,prdact_updated_at   timestamp(6) 
,prdact_chrg_id  numeric (38,0)
,prdact_opeitm_id  numeric (38,0)
,loca_country_shelfno  varchar (20) 
,opeitm_unit_id_case  numeric (38,0)
,loca_zip  varchar (10) 
,loca_abbr  varchar (50) 
,opeitm_shelfno_id  numeric (22,0)
,shelfno_loca_id_shelfno  numeric (38,0)
,opeitm_loca_id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,loca_addr2  varchar (50) 
,boxe_unit_id_outbox  numeric (22,0)
,loca_addr1  varchar (50) 
,opeitm_boxe_id  numeric (22,0)
,loca_prfct  varchar (20) 
,chrg_person_id_chrg  numeric (38,0)
,itm_unit_id  numeric (22,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,boxe_unit_id_box  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
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
 CREATE INDEX sio_r_prdacts_uk1 
  ON sio.sio_r_prdacts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prdacts_seq ;
 create sequence sio.sio_r_prdacts_seq ;
