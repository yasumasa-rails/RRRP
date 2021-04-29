
  drop view if  exists r_pobjgrps cascade ; 
 create or replace view r_pobjgrps as select  
pobjgrp.persons_id_upd   pobjgrp_person_id_upd,
pobjgrp.pobjects_id   pobjgrp_pobject_id,
pobjgrp.remark  pobjgrp_remark,
pobjgrp.contents  pobjgrp_contents,
pobjgrp.created_at  pobjgrp_created_at,
pobjgrp.name  pobjgrp_name,
pobjgrp.update_ip  pobjgrp_update_ip,
  pobject.pobject_code  pobject_code ,
  pobject.pobject_objecttype  pobject_objecttype ,
pobjgrp.expiredate  pobjgrp_expiredate,
pobjgrp.updated_at  pobjgrp_updated_at,
pobjgrp.id  pobjgrp_id,
pobjgrp.id id,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  usrgrp.usrgrp_name  usrgrp_name ,
  usrgrp.usrgrp_code  usrgrp_code ,
pobjgrp.usrgrps_id   pobjgrp_usrgrp_id
 from pobjgrps   pobjgrp,
  r_persons  person_upd ,  r_pobjects  pobject ,  r_usrgrps  usrgrp 
  where       pobjgrp.persons_id_upd = person_upd.id      and pobjgrp.pobjects_id = pobject.id      and pobjgrp.usrgrps_id = usrgrp.id     ;
 DROP TABLE IF EXISTS sio.sio_r_pobjgrps;
 CREATE TABLE sio.sio_r_pobjgrps (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_pobjgrps_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,pobjgrp_name  varchar (100) 
,pobject_code  varchar (50) 
,pobject_objecttype  varchar (19) 
,usrgrp_code  varchar (50) 
,pobjgrp_expiredate   date 
,usrgrp_name  varchar (100) 
,pobjgrp_remark  varchar (4000)
,pobjgrp_contents  varchar (4000) 
,pobjgrp_created_at   timestamp(6) 
,pobjgrp_updated_at   timestamp(6) 
,person_name_upd  varchar (100) 
,person_code_upd  varchar (50) 
,pobjgrp_usrgrp_id  numeric (22,0)
,pobjgrp_pobject_id  numeric (22,0)
,pobjgrp_update_ip  varchar (40) 
,pobjgrp_id  numeric (22,0)
,id  numeric (22,0)
,pobjgrp_person_id_upd  numeric (22,0)
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
 CREATE INDEX sio_r_pobjgrps_uk1 
  ON sio.sio_r_pobjgrps(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_pobjgrps_seq ;
 create sequence sio.sio_r_pobjgrps_seq ;
 ALTER TABLE pobjgrps ADD CONSTRAINT pobjgrp_pobjects_id FOREIGN KEY (pobjects_id)
																		 REFERENCES pobjects (id);
