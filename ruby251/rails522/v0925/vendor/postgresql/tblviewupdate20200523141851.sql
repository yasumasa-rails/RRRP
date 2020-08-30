
 alter table srctbls DROP COLUMN tblname CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'tblname'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　tblnameが削除　2020-05-23 14:18:51 +0900' 
 ---- where  pobject_code_sfd = 'tblname'
 alter table srctbls DROP COLUMN tblid CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'tblid'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　tblidが削除　2020-05-23 14:18:51 +0900' 
 ---- where  pobject_code_sfd = 'tblid'
 --- drop view r_srctbls cascade  
 create or replace view r_srctbls as select  
srctbl.id  srctbl_id,
srctbl.id id,
srctbl.srctblname  srctbl_srctblname,
srctbl.sno  srctbl_sno,
srctbl.cno  srctbl_cno,
srctbl.srctblid  srctbl_srctblid,
srctbl.contents  srctbl_contents,
srctbl.created_at  srctbl_created_at,
srctbl.update_ip  srctbl_update_ip,
srctbl.expiredate  srctbl_expiredate,
srctbl.updated_at  srctbl_updated_at,
srctbl.persons_id_upd   srctbl_person_id_upd,
srctbl.remark  srctbl_remark,
srctbl.qty_src  srctbl_qty_src
 from srctbls   srctbl,
  r_persons  person_upd 
  where       srctbl.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_srctbls;
 CREATE TABLE sio.sio_r_srctbls (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_srctbls_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,srctbl_sno  varchar (40) 
,srctbl_cno  varchar (40) 
,srctbl_srctblid  numeric (38,0)
,srctbl_qty_src  numeric (38,6)
,srctbl_srctblname  varchar (30) 
,srctbl_expiredate   date 
,srctbl_contents  varchar (4000) 
,srctbl_remark  varchar (4000) 
,srctbl_created_at   timestamp(6) 
,id  numeric (38,0)
,srctbl_id  numeric (38,0)
,srctbl_update_ip  varchar (40) 
,srctbl_updated_at   timestamp(6) 
,srctbl_person_id_upd  numeric (38,0)
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
 CREATE INDEX sio_r_srctbls_uk1 
  ON sio.sio_r_srctbls(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_srctbls_seq ;
 create sequence sio.sio_r_srctbls_seq ;
