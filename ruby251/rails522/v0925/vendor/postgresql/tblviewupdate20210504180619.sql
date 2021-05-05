
 alter table  mkordopeitms  ADD COLUMN opeitms_id numeric(38,0)  DEFAULT 0  not null;

 alter table mkordopeitms DROP COLUMN locas_id CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'locas_id'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　locas_idが削除　2021-05-04 18:06:16 +0900' 
 ---- where  pobject_code_sfd = 'locas_id'
 alter table mkordopeitms DROP COLUMN processseq CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'processseq'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　processseqが削除　2021-05-04 18:06:16 +0900' 
 ---- where  pobject_code_sfd = 'processseq'
 alter table mkordopeitms DROP COLUMN prjnos_id CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'prjnos_id'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　prjnos_idが削除　2021-05-04 18:06:16 +0900' 
 ---- where  pobject_code_sfd = 'prjnos_id'
 alter table mkordopeitms DROP COLUMN itms_id CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'itms_id'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　itms_idが削除　2021-05-04 18:06:16 +0900' 
 ---- where  pobject_code_sfd = 'itms_id'
 alter table mkordopeitms DROP COLUMN shelfnos_id_to CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'shelfnos_id_to'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　shelfnos_id_toが削除　2021-05-04 18:06:16 +0900' 
 ---- where  pobject_code_sfd = 'shelfnos_id_to'
  drop view if  exists r_mkordopeitms cascade ; 
 create or replace view r_mkordopeitms as select  
  opeitm.opeitm_unit_id_prdpurshp  opeitm_unit_id_prdpurshp ,
  opeitm.unit_name_prdpurshp  unit_name_prdpurshp ,
  opeitm.unit_code_prdpurshp  unit_code_prdpurshp ,
  opeitm.itm_name  itm_name ,
  opeitm.itm_code  itm_code ,
  opeitm.unit_name  unit_name ,
  opeitm.unit_code  unit_code ,
  opeitm.itm_unit_id  itm_unit_id ,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_itm_id  opeitm_itm_id ,
mkordopeitm.id id,
  mkord.loca_code_to  loca_code_to ,
  mkord.loca_name_to  loca_name_to ,
  opeitm.opeitm_operation  opeitm_operation ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  opeitm.opeitm_prdpurshp  opeitm_prdpurshp ,
  mkord.itm_code_pare  itm_code_pare ,
  mkord.itm_name_pare  itm_name_pare ,
  mkord.mkord_message_code  mkord_message_code ,
  mkord.mkord_loca_id_org  mkord_loca_id_org ,
  mkord.loca_code_org  loca_code_org ,
  mkord.loca_name_org  loca_name_org ,
  mkord.mkord_loca_id_trn  mkord_loca_id_trn ,
  mkord.loca_code_trn  loca_code_trn ,
  mkord.loca_name_trn  loca_name_trn ,
  mkord.mkord_itm_id_org  mkord_itm_id_org ,
  mkord.itm_code_org  itm_code_org ,
  mkord.itm_name_org  itm_name_org ,
  mkord.mkord_itm_id_trn  mkord_itm_id_trn ,
  mkord.itm_code_trn  itm_code_trn ,
  mkord.itm_name_trn  itm_name_trn ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  mkord.mkord_chrg_id_trn  mkord_chrg_id_trn ,
  mkord.person_code_chrg_trn  person_code_chrg_trn ,
  mkord.person_name_chrg_trn  person_name_chrg_trn ,
  mkord.person_sect_id_chrg_trn  person_sect_id_chrg_trn ,
  opeitm.classlist_code  classlist_code ,
  opeitm.classlist_name  classlist_name ,
  mkord.loca_code_pare  loca_code_pare ,
  mkord.loca_name_pare  loca_name_pare ,
  mkord.mkord_loca_id_pare  mkord_loca_id_pare ,
  mkord.mkord_itm_id_pare  mkord_itm_id_pare ,
  mkord.mkord_itm_code_pare  mkord_itm_code_pare ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.boxe_code  boxe_code ,
  opeitm.boxe_name  boxe_name ,
  opeitm.itm_classlist_id  itm_classlist_id ,
  mkord.classlist_name_pare  classlist_name_pare ,
  mkord.mkord_loca_id_to  mkord_loca_id_to ,
  mkord.classlist_code_org  classlist_code_org ,
  mkord.classlist_name_org  classlist_name_org ,
mkordopeitm.remark  mkordopeitm_remark,
mkordopeitm.created_at  mkordopeitm_created_at,
mkordopeitm.expiredate  mkordopeitm_expiredate,
mkordopeitm.updated_at  mkordopeitm_updated_at,
mkordopeitm.id  mkordopeitm_id,
mkordopeitm.persons_id_upd   mkordopeitm_person_id_upd,
mkordopeitm.contents  mkordopeitm_contents,
mkordopeitm.mkords_id   mkordopeitm_mkord_id,
mkordopeitm.update_ip  mkordopeitm_update_ip,
  opeitm.loca_code_opeitm  loca_code_opeitm ,
  opeitm.loca_name_opeitm  loca_name_opeitm ,
mkordopeitm.opeitms_id   mkordopeitm_opeitm_id
 from mkordopeitms   mkordopeitm,
  r_persons  person_upd ,  r_mkords  mkord ,  r_opeitms  opeitm 
  where       mkordopeitm.persons_id_upd = person_upd.id      and mkordopeitm.mkords_id = mkord.id      and mkordopeitm.opeitms_id = opeitm.id     ;
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
,boxe_code  varchar (50) 
,shelfno_code  varchar (50) 
,classlist_code_org  varchar (50) 
,itm_name  varchar (100) 
,itm_code  varchar (50) 
,unit_name  varchar (100) 
,unit_code  varchar (50) 
,classlist_name_pare  varchar (100) 
,loca_name_pare  varchar (100) 
,loca_code_pare  varchar (50) 
,classlist_name  varchar (100) 
,loca_code_to  varchar (50) 
,loca_name_to  varchar (100) 
,classlist_code  varchar (50) 
,person_name_chrg_trn  varchar (100) 
,person_code_chrg_trn  varchar (50) 
,itm_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,mkord_message_code  varchar (256) 
,itm_name_trn  varchar (100) 
,loca_code_org  varchar (50) 
,loca_name_org  varchar (100) 
,itm_code_trn  varchar (50) 
,loca_code_trn  varchar (50) 
,loca_name_trn  varchar (100) 
,itm_code_org  varchar (50) 
,itm_name_org  varchar (100) 
,classlist_name_org  varchar (100) 
,mkordopeitm_expiredate   date 
,shelfno_name  varchar (100) 
,boxe_name  varchar (100) 
,unit_code_outbox  varchar (50) 
,unit_code_prdpurshp  varchar (50) 
,unit_code_case  varchar (50) 
,loca_code_opeitm  varchar (50) 
,mkord_itm_code_pare  varchar (50) 
,unit_code_box  varchar (50) 
,loca_code_shelfno  varchar (50) 
,unit_name_outbox  varchar (100) 
,unit_name_case  varchar (100) 
,loca_name_opeitm  varchar (100) 
,loca_name_shelfno  varchar (100) 
,unit_name_prdpurshp  varchar (100) 
,unit_name_box  varchar (100) 
,opeitm_prdpurshp  varchar (20) 
,opeitm_operation  varchar (20) 
,opeitm_priority  numeric (3,0)
,opeitm_processseq  numeric (3,0)
,mkordopeitm_opeitm_id  numeric (38,0)
,mkordopeitm_contents  varchar (4000) 
,mkordopeitm_remark  varchar (4000) 
,person_name_upd  varchar (100) 
,person_code_upd  varchar (50) 
,mkordopeitm_created_at   timestamp(6) 
,id  numeric (38,0)
,opeitm_itm_id  numeric (38,0)
,opeitm_unit_id_prdpurshp  numeric (38,0)
,mkordopeitm_updated_at   timestamp(6) 
,mkordopeitm_id  numeric (38,0)
,mkordopeitm_person_id_upd  numeric (38,0)
,mkordopeitm_mkord_id  numeric (22,0)
,mkordopeitm_update_ip  varchar (40) 
,mkord_loca_id_trn  numeric (38,0)
,mkord_chrg_id_trn  numeric (38,0)
,mkord_itm_id_org  numeric (38,0)
,mkord_itm_id_trn  numeric (38,0)
,mkord_loca_id_org  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,mkord_loca_id_to  numeric (38,0)
,mkord_itm_id_pare  numeric (38,0)
,mkord_loca_id_pare  numeric (38,0)
,person_sect_id_chrg_trn  numeric (22,0)
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
 ALTER TABLE mkordopeitms ADD CONSTRAINT mkordopeitm_opeitms_id FOREIGN KEY (opeitms_id)
																		 REFERENCES opeitms (id);
