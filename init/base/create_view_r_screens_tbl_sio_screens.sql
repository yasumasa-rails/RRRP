drop view if exists r_screens cascade;
 create or replace view r_screens as select  
screen.strgrouporder  screen_strgrouporder,
screen.strselect  screen_strselect,
screen.remark  screen_remark,
screen.created_at  screen_created_at,
screen.update_ip  screen_update_ip,
screen.cdrflayout  screen_cdrflayout,
screen.ymlcode  screen_ymlcode,
screen.expiredate  screen_expiredate,
screen.updated_at  screen_updated_at,
screen.strwhere  screen_strwhere,
screen.width  screen_width,
screen.seqno  screen_seqno,
screen.id id,
screen.persons_id_upd   screen_person_id_upd,
screen.contents  screen_contents,
screen.pobjects_id_scr   screen_pobject_id_scr,
screen.pobjects_id_view   screen_pobject_id_view,
screen.form_ps  screen_form_ps,
screen.rows_per_page  screen_rows_per_page,
screen.rowlist  screen_rowlist,
screen.height  screen_height,
screen.scrlvs_id   screen_scrlv_id,
screen.strorder  screen_strorder,
screen.pobjects_id_sgrp   screen_pobject_id_sgrp,
  pobject_scr.pobject_objecttype  pobject_objecttype_scr ,
  pobject_scr.pobject_contents  pobject_contents_scr ,
  pobject_scr.pobject_code  pobject_code_scr ,
  pobject_view.pobject_objecttype  pobject_objecttype_view ,
  pobject_view.pobject_contents  pobject_contents_view ,
  pobject_view.pobject_code  pobject_code_view ,
  scrlv.scrlv_level1  scrlv_level1 ,
  scrlv.scrlv_code  scrlv_code ,
  pobject_sgrp.pobject_objecttype  pobject_objecttype_sgrp ,
  pobject_sgrp.pobject_contents  pobject_contents_sgrp ,
  pobject_sgrp.pobject_code  pobject_code_sgrp 
 from screens   screen,
  r_persons  person_upd ,  r_pobjects  pobject_scr ,  r_pobjects  pobject_view ,  r_scrlvs  scrlv ,  r_pobjects  pobject_sgrp 
  where       screen.persons_id_upd = person_upd.id      and screen.pobjects_id_scr = pobject_scr.id      and screen.pobjects_id_view = pobject_view.id      and screen.scrlvs_id = scrlv.id      and screen.pobjects_id_sgrp = pobject_sgrp.id     ;
 DROP TABLE IF EXISTS sio.sio_r_screens;
 CREATE TABLE sio.sio_r_screens (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_screens_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,screen_strgrouporder  varchar (4000) 
,screen_strselect  varchar (4000) 
,screen_remark  varchar (4000) 
,screen_created_at   timestamp(6) 
,screen_update_ip  varchar (40) 
,screen_cdrflayout  varchar (10) 
,screen_ymlcode  varchar (4000) 
,screen_expiredate   date 
,screen_updated_at   timestamp(6) 
,screen_strwhere  varchar (4000) 
,screen_width  numeric (38,0)
,screen_seqno  numeric (38,0)
,id  numeric (38,0)
,screen_id  numeric (38,0)
,screen_person_id_upd  numeric (38,0)
,screen_contents  varchar (4000) 
,screen_pobject_id_scr  numeric (38,0)
,screen_pobject_id_view  numeric (38,0)
,screen_form_ps  varchar (4000) 
,screen_rows_per_page  numeric (38,0)
,screen_rowlist  varchar (30) 
,screen_height  numeric (38,0)
,screen_scrlv_id  numeric (38,0)
,screen_strorder  varchar (4000) 
,screen_pobject_id_sgrp  numeric (38,0)
,pobject_objecttype_scr  varchar (19) 
,pobject_contents_scr  varchar (200) 
,pobject_code_scr  varchar (50) 
,pobject_objecttype_view  varchar (19) 
,pobject_contents_view  varchar (200) 
,pobject_code_view  varchar (50) 
,scrlv_level1  varchar (1) 
,scrlv_code  varchar (50) 
,pobject_objecttype_sgrp  varchar (19) 
,pobject_contents_sgrp  varchar (200) 
,pobject_code_sgrp  varchar (50) 
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
 CREATE INDEX sio_r_screens_uk1 
  ON sio.sio_r_screens(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_screens_seq ;
 create sequence sio.sio_r_screens_seq ;


DETAIL:  view r_screenfields depends on view r_screens
view r_tblinks depends on view r_screens
view r_usebuttons depends on view r_screens
view r_reports depends on view r_screens