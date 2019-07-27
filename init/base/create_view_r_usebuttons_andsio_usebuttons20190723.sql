
 ALTER TABLE usebuttons ADD CONSTRAINT usebutton_screens_id_ub FOREIGN KEY (screens_id_ub) REFERENCES screens (id);
 --- drop view r_usebuttons cascade  
 create or replace view r_usebuttons as select  
usebutton.id  usebutton_id,
  screen_ub.scrlv_level1  scrlv_level1_ub ,
  screen_ub.pobject_contents_scr  pobject_contents_scr_ub ,
  screen_ub.pobject_contents_view  pobject_contents_view_ub ,
  screen_ub.pobject_contents_sgrp  pobject_contents_sgrp_ub ,
  screen_ub.screen_form_ps  screen_form_ps_ub ,
  screen_ub.screen_rowlist  screen_rowlist_ub ,
  screen_ub.screen_strgrouporder  screen_strgrouporder_ub ,
  button.button_code  button_code ,
  button.button_seqno  button_seqno ,
  button.button_title  button_title ,
  button.button_buttonicon  button_buttonicon ,
  screen_ub.screen_strselect  screen_strselect_ub ,
  screen_ub.screen_cdrflayout  screen_cdrflayout_ub ,
  screen_ub.screen_ymlcode  screen_ymlcode_ub ,
  screen_ub.screen_strwhere  screen_strwhere_ub ,
usebutton.remark  usebutton_remark,
usebutton.expiredate  usebutton_expiredate,
usebutton.id id,
usebutton.persons_id_upd   usebutton_person_id_upd,
usebutton.created_at  usebutton_created_at,
usebutton.update_ip  usebutton_update_ip,
usebutton.updated_at  usebutton_updated_at,
usebutton.buttons_id   usebutton_button_id,
usebutton.screens_id_ub   usebutton_screen_id_ub,
  button.button_onclickbutton  button_onclickbutton ,
usebutton.contents  usebutton_contents,
  screen_ub.screen_rows_per_page  screen_rows_per_page_ub ,
  screen_ub.screen_height  screen_height_ub ,
  screen_ub.pobject_objecttype_scr  pobject_objecttype_scr_ub ,
  screen_ub.pobject_code_scr  pobject_code_scr_ub ,
  screen_ub.pobject_objecttype_view  pobject_objecttype_view_ub ,
  screen_ub.pobject_code_view  pobject_code_view_ub ,
  screen_ub.scrlv_code  scrlv_code_ub ,
  screen_ub.screen_seqno  screen_seqno_ub ,
  screen_ub.screen_strorder  screen_strorder_ub ,
  screen_ub.pobject_objecttype_sgrp  pobject_objecttype_sgrp_ub ,
  screen_ub.pobject_code_sgrp  pobject_code_sgrp_ub ,
  screen_ub.screen_width  screen_width_ub ,
  button.button_contents  button_contents ,
  screen_ub.screen_contents  screen_contents_ub ,
  button.button_caption  button_caption 
 from usebuttons   usebutton,
  r_persons  person_upd ,  r_buttons  button ,  r_screens  screen_ub 
  where       usebutton.persons_id_upd = person_upd.id      and usebutton.buttons_id = button.id      and usebutton.screens_id_ub = screen_ub.id     ;
 DROP TABLE IF EXISTS sio.sio_r_usebuttons;
 CREATE TABLE sio.sio_r_usebuttons (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_usebuttons_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,usebutton_id  numeric (38,0)
,pobject_code_sgrp_ub  varchar (50) 
,pobject_code_scr_ub  varchar (50) 
,button_code  varchar (30) 
,button_title  varchar (30) 
,usebutton_contents  varchar (4000) 
,usebutton_expiredate   date 
,usebutton_remark  varchar (4000) 
,button_contents  varchar (4000) 
,pobject_contents_sgrp_ub  varchar (200) 
,screen_strorder_ub  varchar (4000) 
,screen_ymlcode_ub  varchar (4000) 
,screen_strwhere_ub  varchar (4000) 
,id  numeric (38,0)
,usebutton_person_id_upd  numeric (38,0)
,usebutton_created_at   timestamp(6) 
,usebutton_update_ip  varchar (40) 
,usebutton_updated_at   timestamp(6) 
,usebutton_button_id  numeric (38,0)
,usebutton_screen_id_ub  numeric (38,0)
,button_onclickbutton  varchar (4000) 
,screen_pobject_id_scr_ub  numeric (38,0)
,screen_pobject_id_view_ub  numeric (38,0)
,screen_rows_per_page_ub  numeric (38,0)
,screen_height_ub  numeric (38,0)
,screen_scrlv_id_ub  numeric (38,0)
,pobject_objecttype_scr_ub  varchar (19) 
,pobject_objecttype_view_ub  varchar (19) 
,pobject_code_view_ub  varchar (50) 
,scrlv_code_ub  varchar (50) 
,screen_pobject_id_sgrp_ub  numeric (38,0)
,screen_seqno_ub  numeric (38,0)
,pobject_objecttype_sgrp_ub  varchar (19) 
,screen_width_ub  numeric (38,0)
,screen_contents_ub  varchar (4000) 
,button_caption  varchar (20) 
,scrlv_level1_ub  varchar (1) 
,pobject_contents_scr_ub  varchar (200) 
,pobject_contents_view_ub  varchar (200) 
,screen_form_ps_ub  varchar (4000) 
,screen_rowlist_ub  varchar (30) 
,screen_strgrouporder_ub  varchar (4000) 
,button_seqno  numeric (22,0)
,button_buttonicon  varchar (40) 
,screen_strselect_ub  varchar (4000) 
,screen_cdrflayout_ub  varchar (10) 
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
 CREATE INDEX sio_r_usebuttons_uk1 
  ON sio.sio_r_usebuttons(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_usebuttons_seq ;
 create sequence sio.sio_r_usebuttons_seq ;
