﻿
 --- drop view r_itms cascade  
 create or replace view r_itms as select  
  unit.unit_id  unit_id ,
itm.id  itm_id,
  unit.unit_code  unit_code ,
  unit.unit_name  unit_name ,
  unit.unit_remark  unit_remark ,
itm.std  itm_std,
itm.model  itm_model,
itm.material  itm_material,
itm.design  itm_design,
itm.weight  itm_weight,
itm.length  itm_length,
itm.wide  itm_wide,
itm.deth  itm_deth,
itm.remark  itm_remark,
itm.expiredate  itm_expiredate,
itm.update_ip  itm_update_ip,
itm.updated_at  itm_updated_at,
itm.code  itm_code,
itm.name  itm_name,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
itm.id id,
itm.units_id   itm_unit_id,
itm.persons_id_upd   itm_person_id_upd,
itm.created_at  itm_created_at,
itm.classlists_id   itm_classlist_id,
itm.datascale  itm_datascale,
  unit.unit_contents  unit_contents ,
  classlist.classlist_code  classlist_code ,
  classlist.classlist_contents  classlist_contents ,
  classlist.classlist_name  classlist_name 
 from itms   itm,
  r_units  unit ,  r_persons  person_upd ,  r_classlists  classlist 
  where       itm.units_id = unit.id      and itm.persons_id_upd = person_upd.id      and itm.classlists_id = classlist.id     ;
 DROP TABLE IF EXISTS sio.sio_r_itms;
 CREATE TABLE sio.sio_r_itms (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_itms_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,itm_material  varchar (50) 
,classlist_code  varchar (50) 
,classlist_name  varchar (100) 
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,itm_datascale  numeric (22,0)
,itm_design  varchar (50) 
,itm_weight  numeric (22,0)
,itm_length  numeric (22,0)
,itm_wide  numeric (22,0)
,itm_deth  numeric (22,0)
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,classlist_contents  varchar (4000) 
,unit_contents  varchar (4000) 
,itm_remark  varchar (4000) 
,itm_expiredate   date 
,itm_created_at   timestamp(6) 
,itm_updated_at   timestamp(6) 
,itm_update_ip  varchar (40) 
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,itm_classlist_id  numeric (38,0)
,unit_id  numeric (22,0)
,unit_remark  varchar (4000) 
,itm_unit_id  numeric (22,0)
,itm_id  numeric (22,0)
,itm_person_id_upd  numeric (22,0)
,id  numeric (22,0)
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
 CREATE INDEX sio_r_itms_uk1 
  ON sio.sio_r_itms(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_itms_seq ;
 create sequence sio.sio_r_itms_seq ;