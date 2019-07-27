
 --- drop view r_screenfields cascade  
 create or replace view r_screenfields as select  
screenfield.id  screenfield_id,
  screen.pobject_objecttype_scr  pobject_objecttype_scr ,
screenfield.sumkey  screenfield_sumkey,
screenfield.remark  screenfield_remark,
screenfield.created_at  screenfield_created_at,
screenfield.update_ip  screenfield_update_ip,
screenfield.edoptmaxlength  screenfield_edoptmaxlength,
screenfield.datascale  screenfield_datascale,
screenfield.dataprecision  screenfield_dataprecision,
screenfield.minvalue  screenfield_minvalue,
screenfield.edoptsize  screenfield_edoptsize,
screenfield.colpos  screenfield_colpos,
screenfield.expiredate  screenfield_expiredate,
screenfield.updated_at  screenfield_updated_at,
screenfield.edoptcols  screenfield_edoptcols,
screenfield.edoptrow  screenfield_edoptrow,
screenfield.width  screenfield_width,
screenfield.indisp  screenfield_indisp,
screenfield.rowpos  screenfield_rowpos,
screenfield.seqno  screenfield_seqno,
screenfield.hideflg  screenfield_hideflg,
screenfield.maxvalue  screenfield_maxvalue,
screenfield.paragraph  screenfield_paragraph,
screenfield.selection  screenfield_selection,
screenfield.crtfield  screenfield_crtfield,
screenfield.edoptvalue  screenfield_edoptvalue,
screenfield.subindisp  screenfield_subindisp,
screenfield.type  screenfield_type,
screenfield.persons_id_upd   screenfield_person_id_upd,
screenfield.contents  screenfield_contents,
screenfield.screens_id   screenfield_screen_id,
screenfield.pobjects_id_sfd   screenfield_pobject_id_sfd,
screenfield.tblfields_id   screenfield_tblfield_id,
screenfield.formatter  screenfield_formatter,
screenfield.editable  screenfield_editable,
  screen.screen_strorder  screen_strorder ,
  screen.screen_strgrouporder  screen_strgrouporder ,
  screen.screen_strselect  screen_strselect ,
  screen.screen_cdrflayout  screen_cdrflayout ,
  screen.screen_ymlcode  screen_ymlcode ,
  screen.screen_strwhere  screen_strwhere ,
  screen.screen_contents  screen_contents ,
  screen.screen_form_ps  screen_form_ps ,
  screen.screen_rows_per_page  screen_rows_per_page ,
  screen.screen_rowlist  screen_rowlist ,
  screen.screen_height  screen_height ,
  screen.pobject_contents_scr  pobject_contents_scr ,
  screen.pobject_code_scr  pobject_code_scr ,
  screen.pobject_objecttype_view  pobject_objecttype_view ,
  screen.pobject_contents_view  pobject_contents_view ,
  screen.pobject_code_view  pobject_code_view ,
  screen.scrlv_level1  scrlv_level1 ,
  screen.scrlv_code  scrlv_code ,
  pobject_sfd.pobject_code  pobject_code_sfd ,
  screen.screen_pobject_id_sgrp  screen_pobject_id_sgrp ,
  screen.screen_width  screen_width ,
  screen.pobject_contents_sgrp  pobject_contents_sgrp ,
screenfield.id id,
  screen.pobject_code_sgrp  pobject_code_sgrp ,
  pobject_sfd.pobject_objecttype  pobject_objecttype_sfd ,
  pobject_sfd.pobject_contents  pobject_contents_sfd ,
  tblfield.fieldcode_fieldlength  fieldcode_fieldlength ,
  tblfield.fieldcode_datascale  fieldcode_datascale ,
  tblfield.fieldcode_dataprecision  fieldcode_dataprecision ,
  tblfield.tblfield_seqno  tblfield_seqno ,
  tblfield.tblfield_contents  tblfield_contents ,
  tblfield.pobject_code_tbl  pobject_code_tbl ,
  tblfield.fieldcode_contents  fieldcode_contents ,
  tblfield.tblfield_viewflmk  tblfield_viewflmk ,
  tblfield.pobject_code_fld  pobject_code_fld ,
  tblfield.pobject_id_fld  pobject_id_fld ,
  tblfield.fieldcode_ftype  fieldcode_ftype 
 from screenfields   screenfield,
  r_persons  person_upd ,  r_screens  screen ,  r_pobjects  pobject_sfd ,  r_tblfields  tblfield 
  where       screenfield.persons_id_upd = person_upd.id      and screenfield.screens_id = screen.id      and screenfield.pobjects_id_sfd = pobject_sfd.id      and screenfield.tblfields_id = tblfield.id     ;
 DROP TABLE IF EXISTS sio.sio_r_screenfields;
 CREATE TABLE sio.sio_r_screenfields (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_screenfields_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,pobject_code_sgrp  varchar (50) 
,screenfield_id  numeric (38,0)
,pobject_objecttype_sgrp  varchar (19) 
,screen_pobject_id_sgrp  numeric (38,0)
,screen_seqno  numeric (38,0)
,screen_strorder  varchar (4000) 
,pobject_contents_sgrp  varchar (200) 
,pobject_code_scr  varchar (50) 
,pobject_code_sfd  varchar (50) 
,screenfield_seqno  numeric (38,0)
,screenfield_selection  numeric (38,0)
,screenfield_hideflg  numeric (38,0)
,screenfield_indisp  numeric (38,0)
,screenfield_editable  numeric (38,0)
,screenfield_rowpos  numeric (38,0)
,screenfield_colpos  numeric (38,0)
,screenfield_type  varchar (12) 
,screenfield_edoptvalue  varchar (800) 
,screenfield_formatter  varchar (4000) 
,screenfield_paragraph  varchar (30) 
,screen_width  numeric (38,0)
,screenfield_width  numeric (38,0)
,screenfield_edoptcols  numeric (38,0)
,screenfield_edoptrow  numeric (38,0)
,screenfield_minvalue  numeric (38,0)
,screenfield_maxvalue  numeric (38,0)
,screenfield_edoptsize  numeric (38,0)
,screenfield_dataprecision  numeric (38,0)
,screenfield_datascale  numeric (38,0)
,screenfield_edoptmaxlength  numeric (38,0)
,screenfield_subindisp  varchar (10) 
,screenfield_crtfield  varchar (100) 
,screenfield_sumkey  varchar (1) 
,screenfield_contents  varchar (4000) 
,pobject_code_tbl  varchar (50) 
,pobject_code_fld  varchar (50) 
,pobject_id_fld   numeric (38,0)
,tblfield_contents  varchar (4000) 
,fieldcode_contents  varchar (4000) 
,screenfield_remark  varchar (4000) 
,screenfield_expiredate   date 
,fieldcode_ftype  varchar (15) 
,pobject_objecttype_scr  varchar (19) 
,screenfield_created_at   timestamp(6) 
,screenfield_update_ip  varchar (40) 
,screenfield_updated_at   timestamp(6) 
,screenfield_person_id_upd  numeric (38,0)
,screenfield_screen_id  numeric (38,0)
,screenfield_pobject_id_sfd  numeric (38,0)
,screenfield_tblfield_id  numeric (38,0)
,screen_strgrouporder  varchar (4000) 
,screen_strselect  varchar (4000) 
,screen_cdrflayout  varchar (10) 
,screen_ymlcode  varchar (4000) 
,screen_strwhere  varchar (4000) 
,screen_contents  varchar (4000) 
,screen_pobject_id_scr  numeric (38,0)
,screen_pobject_id_view  numeric (38,0)
,screen_form_ps  varchar (4000) 
,screen_rows_per_page  numeric (38,0)
,screen_rowlist  varchar (30) 
,screen_height  numeric (38,0)
,screen_scrlv_id  numeric (38,0)
,pobject_contents_scr  varchar (200) 
,pobject_objecttype_view  varchar (19) 
,pobject_contents_view  varchar (200) 
,pobject_code_view  varchar (50) 
,scrlv_level1  varchar (1) 
,scrlv_code  varchar (50) 
,id  numeric (38,0)
,pobject_objecttype_sfd  varchar (19) 
,pobject_contents_sfd  varchar (200) 
,fieldcode_fieldlength  numeric (22,0)
,fieldcode_datascale  numeric (22,0)
,fieldcode_dataprecision  numeric (38,0)
,tblfield_seqno  numeric (22,0)
,tblfield_blktb_id  numeric (22,0)
,tblfield_fieldcode_id  numeric (22,0)
,tblfield_viewflmk  varchar (4000) 
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
 CREATE INDEX sio_r_screenfields_uk1 
  ON sio.sio_r_screenfields(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_screenfields_seq ;
 create sequence sio.sio_r_screenfields_seq ;
