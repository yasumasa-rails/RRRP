
 alter table classlists DROP COLUMN moduleclass CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'moduleclass'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　moduleclassが削除　2021-04-14 14:06:50 +0900' 
 ---- where  pobject_code_sfd = 'moduleclass'
  drop view if  exists r_classlists cascade ; 
 create or replace view r_classlists as select  
classlist.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
classlist.id  classlist_id,
classlist.remark  classlist_remark,
classlist.expiredate  classlist_expiredate,
classlist.update_ip  classlist_update_ip,
classlist.created_at  classlist_created_at,
classlist.updated_at  classlist_updated_at,
classlist.persons_id_upd   classlist_person_id_upd,
classlist.code  classlist_code,
classlist.name  classlist_name,
classlist.contents  classlist_contents
 from classlists   classlist,
  r_persons  person_upd 
  where       classlist.persons_id_upd = person_upd.id     ;
 DROP TABLE IF EXISTS sio.sio_r_classlists;
 CREATE TABLE sio.sio_r_classlists (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_classlists_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,classlist_name  varchar (100) 
,classlist_expiredate   date 
,classlist_contents  varchar (4000) 
,classlist_remark  varchar (4000) 
,classlist_update_ip  varchar (40) 
,classlist_id  numeric (38,0)
,id  numeric (38,0)
,classlist_created_at   timestamp(6) 
,classlist_updated_at   timestamp(6) 
,classlist_person_id_upd  numeric (38,0)
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
 CREATE INDEX sio_r_classlists_uk1 
  ON sio.sio_r_classlists(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_classlists_seq ;
 create sequence sio.sio_r_classlists_seq ;
