
 alter table lotstkhists DROP COLUMN shelfname CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'shelfname'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　shelfnameが削除　2020-01-22 11:19:55 +0900' 
 ---- where  pobject_code_sfd = 'shelfname'
 --- drop view r_lotstkhists cascade  
 create or replace view r_lotstkhists as select  
  prjno.prjno_name  prjno_name ,
lotstkhist.starttime  lotstkhist_starttime,
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
lotstkhist.stktaking_proc  lotstkhist_stktaking_proc,
lotstkhist.qty_stk  lotstkhist_qty_stk,
  loca.loca_abbr  loca_abbr ,
  loca.loca_zip  loca_zip ,
  loca.loca_country  loca_country ,
  loca.loca_prfct  loca_prfct ,
  loca.loca_addr1  loca_addr1 ,
  loca.loca_addr2  loca_addr2 ,
  loca.loca_tel  loca_tel ,
  loca.loca_fax  loca_fax ,
  loca.loca_mail  loca_mail ,
  loca.loca_code  loca_code ,
  loca.loca_name  loca_name ,
  itm.itm_unit_id  itm_unit_id ,
lotstkhist.qty  lotstkhist_qty,
lotstkhist.expiredate  lotstkhist_expiredate,
lotstkhist.remark  lotstkhist_remark,
lotstkhist.persons_id_upd   lotstkhist_person_id_upd,
lotstkhist.update_ip  lotstkhist_update_ip,
lotstkhist.created_at  lotstkhist_created_at,
lotstkhist.updated_at  lotstkhist_updated_at,
lotstkhist.id  lotstkhist_id,
lotstkhist.id id,
  itm.itm_classlist_id  itm_classlist_id ,
  itm.itm_datascale  itm_datascale ,
lotstkhist.itms_id   lotstkhist_itm_id,
lotstkhist.lotno  lotstkhist_lotno,
lotstkhist.packno  lotstkhist_packno,
lotstkhist.prjnos_id   lotstkhist_prjno_id,
  itm.unit_contents  unit_contents ,
  itm.classlist_code  classlist_code ,
  itm.classlist_name  classlist_name ,
  prjno.prjno_code_chil  prjno_code_chil ,
lotstkhist.processseq  lotstkhist_processseq,
lotstkhist.locas_id   lotstkhist_loca_id,
  prjno.prjno_code  prjno_code 
 from lotstkhists   lotstkhist,
  r_persons  person_upd ,  r_itms  itm ,  r_prjnos  prjno ,  r_locas  loca 
  where       lotstkhist.persons_id_upd = person_upd.id      and lotstkhist.itms_id = itm.id      and lotstkhist.prjnos_id = prjno.id      and lotstkhist.locas_id = loca.id     ;
 DROP TABLE IF EXISTS sio.sio_r_lotstkhists;
 CREATE TABLE sio.sio_r_lotstkhists (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_lotstkhists_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,itm_name  varchar (100) 
,loca_code  varchar (50) 
,loca_name  varchar (100) 
,prjno_code  varchar (50) 
,prjno_code_chil  varchar (50) 
,classlist_name  varchar (100) 
,classlist_code  varchar (50) 
,prjno_name  varchar (100) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,lotstkhist_stktaking_proc  varchar (1) 
,lotstkhist_qty_stk  numeric (38,4)
,lotstkhist_expiredate   date 
,lotstkhist_starttime   timestamp(6) 
,lotstkhist_processseq  numeric (38,0)
,lotstkhist_packno  varchar (10) 
,lotstkhist_lotno  varchar (50) 
,lotstkhist_qty  numeric (18,4)
,unit_contents  varchar (4000) 
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,itm_material  varchar (50) 
,itm_design  varchar (50) 
,itm_weight  numeric (22,0)
,itm_length  numeric (22,0)
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,loca_abbr  varchar (50) 
,loca_zip  varchar (10) 
,loca_country  varchar (20) 
,loca_prfct  varchar (20) 
,loca_addr1  varchar (50) 
,loca_addr2  varchar (50) 
,loca_tel  varchar (20) 
,loca_fax  varchar (20) 
,loca_mail  varchar (20) 
,itm_datascale  numeric (22,0)
,lotstkhist_remark  varchar (4000) 
,lotstkhist_itm_id  numeric (38,0)
,id  numeric (38,0)
,lotstkhist_id  numeric (38,0)
,lotstkhist_prjno_id  numeric (38,0)
,lotstkhist_loca_id  numeric (38,0)
,lotstkhist_created_at   timestamp(6) 
,lotstkhist_update_ip  varchar (40) 
,lotstkhist_person_id_upd  numeric (38,0)
,lotstkhist_updated_at   timestamp(6) 
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
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
 CREATE INDEX sio_r_lotstkhists_uk1 
  ON sio.sio_r_lotstkhists(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_lotstkhists_seq ;
 create sequence sio.sio_r_lotstkhists_seq ;