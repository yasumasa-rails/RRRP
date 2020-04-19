
 create sequence rules_seq ;
 --- drop view r_rules cascade  
 create or replace view r_rules as select  
  .pobject_code  pobject_code ,
  .pobject_objecttype  pobject_objecttype ,
rule.id  rule_id,
rule.id id,
rule.contents  rule_contents,
rule.remark  rule_remark,
rule.expiredate  rule_expiredate,
rule.persons_id_upd   rule_person_id_upd,
rule.update_ip  rule_update_ip,
rule.created_at  rule_created_at,
rule.updated_at  rule_updated_at,
rule.pobjects_id   rule_pobject_id
 from rules   rule,
  r_persons  person_upd ,  r_pobjects  pobject 
  where       rule.persons_id_upd = person_upd.id      and rule.pobjects_id = pobject.id     ;
 DROP TABLE IF EXISTS sio.sio_r_rules;
 CREATE TABLE sio.sio_r_rules (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_rules_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,pobject_code  varchar (50) 
,pobject_objecttype  varchar (20) 
,rule_contents  varchar (4000) 
,pobject_contents  varchar (4000) 
,rule_expiredate   date 
,rule_remark  varchar (4000) 
,rule_pobject_id  numeric (38,0)
,rule_id  numeric (38,0)
,id  numeric (38,0)
,rule_person_id_upd  numeric (38,0)
,rule_update_ip  varchar (40) 
,rule_created_at   timestamp(6) 
,rule_updated_at   timestamp(6) 
,pobject_rubycode  varchar (4000) 
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
 CREATE INDEX sio_r_rules_uk1 
  ON sio.sio_r_rules(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_rules_seq ;
 create sequence sio.sio_r_rules_seq ;
