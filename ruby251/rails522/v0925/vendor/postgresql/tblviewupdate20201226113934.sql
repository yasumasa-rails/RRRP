
 alter table mkordopeitms DROP COLUMN shelfnos_id_fm CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'shelfnos_id_fm'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　shelfnos_id_fmが削除　2020-12-26 11:38:15 +0900' 
 ---- where  pobject_code_sfd = 'shelfnos_id_fm'
 alter table  mkordopeitms  ADD COLUMN shelfnos_id_to numeric(38,0) not null;

 ALTER TABLE mkordopeitms ADD CONSTRAINT mkordopeitm_shelfnos_id_to FOREIGN KEY (shelfnos_id_to)
																		 REFERENCES shelfnos (id);
 --- drop view r_mkordopeitms cascade  
 create or replace view r_mkordopeitms as select  
mkordopeitm.created_at  mkordopeitm_created_at,
mkordopeitm.updated_at  mkordopeitm_updated_at,
mkordopeitm.persons_id_upd   mkordopeitm_person_id_upd,
mkordopeitm.id id,
mkordopeitm.id  mkordopeitm_id,
mkordopeitm.mkords_id   mkordopeitm_mkord_id,
mkordopeitm.expiredate  mkordopeitm_expiredate,
mkordopeitm.contents  mkordopeitm_contents,
mkordopeitm.remark  mkordopeitm_remark,
mkordopeitm.locas_id   mkordopeitm_loca_id,
mkordopeitm.processseq  mkordopeitm_processseq,
mkordopeitm.prjnos_id   mkordopeitm_prjno_id,
mkordopeitm.itms_id   mkordopeitm_itm_id,
mkordopeitm.update_ip  mkordopeitm_update_ip,
mkordopeitm.shelfnos_id_to   mkordopeitm_shelfno_id_to,
  mkord.person_code_chrg_trn  person_code_chrg_trn ,
  mkord.loca_name_sect_chrg_trn  loca_name_sect_chrg_trn ,
  mkord.loca_code_sect_chrg_trn  loca_code_sect_chrg_trn ,
  mkord.person_name_chrg_trn  person_name_chrg_trn ,
  mkord.itm_code_trn  itm_code_trn ,
  mkord.itm_code_org  itm_code_org ,
  mkord.mkord_message_code  mkord_message_code ,
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
  mkord.mkord_loca_id_to  mkord_loca_id_to ,
  mkord.mkord_loca_id_trn  mkord_loca_id_trn ,
  mkord.mkord_loca_id_pare  mkord_loca_id_pare ,
  mkord.mkord_loca_id_org  mkord_loca_id_org ,
  mkord.mkord_itm_id_trn  mkord_itm_id_trn ,
  mkord.mkord_itm_id_pare  mkord_itm_id_pare ,
  mkord.mkord_itm_id_org  mkord_itm_id_org ,
  mkord.classlist_name_org  classlist_name_org ,
  mkord.classlist_code_org  classlist_code_org ,
  mkord.mkord_chrg_id_trn  mkord_chrg_id_trn ,
  loca.loca_code  loca_code ,
  loca.loca_name  loca_name ,
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
  shelfno_to.loca_name_shelfno  loca_name_shelfno_to ,
  shelfno_to.shelfno_name  shelfno_name_to ,
  shelfno_to.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_to ,
  shelfno_to.shelfno_code  shelfno_code_to ,
  shelfno_to.loca_code_shelfno  loca_code_shelfno_to 
 from mkordopeitms   mkordopeitm,
  r_persons  person_upd ,  r_mkords  mkord ,  r_locas  loca ,  r_prjnos  prjno ,  r_itms  itm ,  r_shelfnos  shelfno_to 
  where       mkordopeitm.persons_id_upd = person_upd.id      and mkordopeitm.mkords_id = mkord.id      and mkordopeitm.locas_id = loca.id      and mkordopeitm.prjnos_id = prjno.id      and mkordopeitm.itms_id = itm.id      and mkordopeitm.shelfnos_id_to = shelfno_to.id     ;
 DROP TABLE IF EXISTS sio.sio_r_mkordopeitms;
 CREATE TABLE sio.sio_r_mkordopeitms (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_mkordopeitms_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,itm_code_trn  varchar (50) 
,itm_code_org  varchar (50) 
,person_code_chrg_trn  varchar (50) 
,itm_code  varchar (50) 
,mkord_message_code  varchar (256) 
,unit_code  varchar (50) 
,loca_name_org  varchar (100) 
,loca_code_org  varchar (50) 
,itm_name_pare  varchar (100) 
,loca_name_pare  varchar (100) 
,loca_name_trn  varchar (100) 
,itm_name_trn  varchar (100) 
,loca_code_trn  varchar (50) 
,itm_code_pare  varchar (50) 
,itm_name_org  varchar (100) 
,loca_code_pare  varchar (50) 
,unit_name  varchar (100) 
,loca_name_shelfno_to  varchar (100) 
,itm_name  varchar (100) 
,loca_name_to  varchar (100) 
,loca_code_to  varchar (50) 
,classlist_name_pare  varchar (100) 
,prjno_code_chil  varchar (50) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,loca_name  varchar (100) 
,loca_code  varchar (50) 
,classlist_code_org  varchar (50) 
,classlist_name_org  varchar (100) 
,prjno_code  varchar (50) 
,loca_name_sect_chrg_trn  varchar (100) 
,loca_code_sect_chrg_trn  varchar (50) 
,prjno_name  varchar (100) 
,loca_code_shelfno_to  varchar (50) 
,person_name_chrg_trn  varchar (100) 
,shelfno_code_to  varchar (50) 
,shelfno_name_to  varchar (100) 
,mkordopeitm_processseq  numeric (38,0)
,mkordopeitm_expiredate   date 
,itm_material  varchar (50) 
,mkord_gno_trn  varchar (50) 
,itm_std_org  varchar (50) 
,mkord_sno_org  varchar (50) 
,mkord_orgtblname  varchar (20) 
,mkord_duedate_trn   timestamp(6) 
,mkord_confirm  varchar (1) 
,mkord_sno_pare  varchar (50) 
,mkord_outcnt  numeric (38,0)
,mkord_isudate   timestamp(6) 
,mkord_cmpldate   timestamp(6) 
,mkord_result_f  varchar (1) 
,mkord_runtime  numeric (2,0)
,mkord_opeitm_processseq_trn  varchar (3) 
,mkord_duedate_pare   timestamp(6) 
,mkord_starttime_trn   timestamp(6) 
,mkord_incnt  numeric (38,0)
,mkord_outqty  numeric (22,6)
,mkord_inamt  numeric (38,4)
,mkord_outamt  numeric (38,4)
,mkord_skipamt  numeric (38,4)
,mkord_opeitm_processseq_pare  varchar (3) 
,mkord_duedate_org   timestamp(6) 
,mkord_skipcnt  numeric (38,0)
,mkord_skipqty  numeric (22,6)
,mkord_inqty  numeric (22,6)
,mkord_paretblname  varchar (20) 
,mkord_tblname  varchar (20) 
,mkord_manual  varchar (1) 
,mkord_opeitm_processseq_org  varchar (3) 
,mkord_sno_trn  varchar (50) 
,loca_country  varchar (20) 
,loca_abbr  varchar (50) 
,loca_prfct  varchar (20) 
,loca_tel  varchar (20) 
,loca_mail  varchar (20) 
,loca_addr1  varchar (50) 
,loca_zip  varchar (10) 
,loca_fax  varchar (20) 
,loca_addr2  varchar (50) 
,itm_weight  numeric (22,0)
,unit_contents  varchar (4000) 
,itm_length  numeric (22,0)
,itm_design  varchar (50) 
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,itm_datascale  numeric (22,0)
,shelfno_contents_to  varchar (4000) 
,mkordopeitm_contents  varchar (4000) 
,mkordopeitm_remark  varchar (4000) 
,mkordopeitm_update_ip  varchar (40) 
,mkordopeitm_loca_id  numeric (38,0)
,mkordopeitm_itm_id  numeric (38,0)
,mkordopeitm_mkord_id  numeric (22,0)
,mkordopeitm_id  numeric (38,0)
,id  numeric (38,0)
,mkordopeitm_created_at   timestamp(6) 
,mkordopeitm_updated_at   timestamp(6) 
,mkordopeitm_prjno_id  numeric (38,0)
,mkordopeitm_person_id_upd  numeric (38,0)
,mkordopeitm_shelfno_id_to  numeric (38,0)
,person_sect_id_chrg_trn  numeric (22,0)
,mkord_loca_id_to  numeric (38,0)
,shelfno_loca_id_shelfno_to  numeric (38,0)
,mkord_itm_id_pare  numeric (38,0)
,mkord_itm_id_org  numeric (38,0)
,mkord_itm_id_trn  numeric (38,0)
,mkord_loca_id_org  numeric (38,0)
,mkord_loca_id_pare  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,mkord_chrg_id_trn  numeric (38,0)
,mkord_loca_id_trn  numeric (38,0)
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
 CREATE INDEX sio_r_mkordopeitms_uk1 
  ON sio.sio_r_mkordopeitms(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_mkordopeitms_seq ;
 create sequence sio.sio_r_mkordopeitms_seq ;
