
 alter table prjnos  ADD COLUMN code_chil varchar(50);

 alter table prjnos DROP COLUMN contents CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'contents'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　contentsが削除　2021-04-15 14:14:42 +0900' 
 ---- where  pobject_code_sfd = 'contents'
 alter table prjnos DROP COLUMN priority CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'priority'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　priorityが削除　2021-04-15 14:14:42 +0900' 
 ---- where  pobject_code_sfd = 'priority'
 alter table prjnos DROP COLUMN prjnos_id_chil CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'prjnos_id_chil'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　prjnos_id_chilが削除　2021-04-15 14:14:42 +0900' 
 ---- where  pobject_code_sfd = 'prjnos_id_chil'
  drop view if  exists r_prjnos cascade ; 
 create or replace view r_prjnos as select  
prjno.id id,
prjno.name  prjno_name,
prjno.updated_at  prjno_updated_at,
prjno.created_at  prjno_created_at,
prjno.update_ip  prjno_update_ip,
prjno.expiredate  prjno_expiredate,
prjno.remark  prjno_remark,
prjno.id  prjno_id,
prjno.code  prjno_code,
prjno.code_chil  prjno_code_chil
 from prjnos   prjno,
  where  ;
 DROP TABLE IF EXISTS sio.sio_r_prjnos;
 CREATE TABLE sio.sio_r_prjnos (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_prjnos_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,prjno_expiredate   date 
,prjno_remark  varchar (4000) 
,prjno_code_chil  varchar (50) 
,prjno_update_ip  varchar (0) 
,prjno_created_at   timestamp(6) 
,prjno_id  numeric (22,0)
,prjno_updated_at   timestamp(6) 
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
 CREATE INDEX sio_r_prjnos_uk1 
  ON sio.sio_r_prjnos(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_prjnos_seq ;
 create sequence sio.sio_r_prjnos_seq ;
