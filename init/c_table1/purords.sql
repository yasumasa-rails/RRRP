CREATE TABLE PURORDS 
   (	ID NUMERIC(38,0), 
	SNO VARCHAR(40), 
	QTY NUMERIC(18,4), 
	DUEDATE TIMESTAMP (6), 
	ISUDATE TIMESTAMP (6), 
	REMARK VARCHAR(4000), 
	UPDATE_IP VARCHAR(40), 
	CREATED_AT TIMESTAMP (6), 
	UPDATED_AT TIMESTAMP (6), 
	AMT NUMERIC(18,4), 
	TODUEDATE TIMESTAMP (6), 
	PERSONS_ID_UPD NUMERIC, 
	EXPIREDATE DATE, 
	PRICE NUMERIC(38,4), 
	QTY_CASE NUMERIC(38,0), 
	CONFIRM CHAR(1), 
	OPEITMS_ID NUMERIC, 
	OPT_FIXOTERM NUMERIC(5,2), 
	LOCAS_ID_TO NUMERIC, 
	PROCESSSEQ_PARE NUMERIC(38,0), 
	PRJNOS_ID NUMERIC, 
	CONTRACT_PRICE CHAR(1), 
	CHRGS_ID NUMERIC(38,0), 
	TAX NUMERIC(38,4), 
	GNO VARCHAR(40), 
	ITM_CODE_CLIENT VARCHAR(50), 
	STARTTIME TIMESTAMP (6), 
	 CONSTRAINT PURORDS_ID_PK PRIMARY KEY (ID),
	 CONSTRAINT PURORD_CHRGS_ID FOREIGN KEY (CHRGS_ID)
	  REFERENCES CHRGS (ID) , 
	 CONSTRAINT PURORD_OPEITMS_ID FOREIGN KEY (OPEITMS_ID)
	  REFERENCES OPEITMS (ID) , 
	 CONSTRAINT PURORD_LOCAS_ID_TO FOREIGN KEY (LOCAS_ID_TO)
	  REFERENCES LOCAS (ID) , 
	 CONSTRAINT PURORD_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
	  REFERENCES PERSONS (ID) , 
	 CONSTRAINT PURORD_PRJNOS_ID FOREIGN KEY (PRJNOS_ID)
	  REFERENCES PRJNOS (ID) 
   ) 

;

CREATE SEQUENCE  PURORDS_SEQ INCREMENT BY 1 START WITH 1 
;

CREATE OR REPLACE  VIEW R_REPORTS (REPORT_CONTENTS, REPORT_POBJECT_ID_REP, POBJECT_CODE_REP, POBJECT_OBJECTTYPE_REP, POBJECT_EXPIREDATE_REP, POBJECT_RUBYCODE_REP, POBJECT_ID_REP, POBJECT_CONTENTS_REP, ID, REPORT_ID, REPORT_REMARK, REPORT_EXPIREDATE, REPORT_UPDATE_IP, REPORT_CREATED_AT, REPORT_UPDATED_AT, REPORT_PERSON_ID_UPD, PERSON_ID_UPD, PERSON_CODE_UPD, PERSON_NAME_UPD, REPORT_SCREEN_ID, SCREEN_POBJECT_ID_VIEW, POBJECT_CODE_VIEW, POBJECT_OBJECTTYPE_VIEW, POBJECT_EXPIREDATE_VIEW, POBJECT_RUBYCODE_VIEW, POBJECT_ID_VIEW, POBJECT_CONTENTS_VIEW, SCREEN_FORM_PS, SCREEN_ROWS_PER_PAGE, SCREEN_ROWLIST, SCREEN_HEIGHT, SCREEN_STRSELECT, SCREEN_STRWHERE, SCREEN_STRGROUPORDER, SCREEN_YMLCODE, SCREEN_CDRFLAYOUT, SCREEN_CONTENTS, SCREEN_GRPCODENAME, SCREEN_ID, SCREEN_EXPIREDATE, SCREEN_POBJECT_ID_SCR, POBJECT_CODE_SCR, POBJECT_OBJECTTYPE_SCR, POBJECT_EXPIREDATE_SCR, POBJECT_RUBYCODE_SCR, POBJECT_ID_SCR, POBJECT_CONTENTS_SCR, SCREEN_SCRLV_ID, SCRLV_LEVEL1, SCRLV_ID, SCRLV_EXPIREDATE, SCRLV_CODE, SCREEN_STRORDER, REPORT_FILENAME, REPORT_USRGRP_ID, USRGRP_ID, USRGRP_EXPIREDATE, USRGRP_CODE, USRGRP_NAME, USRGRP_CONTENTS) AS 
  select report.contents report_contents ,report.pobjects_id_rep report_pobject_id_rep , pobject_rep.pobject_code pobject_code_rep, pobject_rep.pobject_objecttype pobject_objecttype_rep, pobject_rep.pobject_expiredate pobject_expiredate_rep, pobject_rep.pobject_rubycode pobject_rubycode_rep, pobject_rep.pobject_id pobject_id_rep, pobject_rep.pobject_contents pobject_contents_rep,report.id id,report.id report_id ,report.remark report_remark ,report.expiredate report_expiredate ,report.update_ip report_update_ip ,report.created_at report_created_at ,report.updated_at report_updated_at ,report.persons_id_upd report_person_id_upd , person_upd.person_id_upd person_id_upd, person_upd.person_code_upd person_code_upd, person_upd.person_name_upd person_name_upd,report.screens_id report_screen_id , screen.screen_pobject_id_view screen_pobject_id_view, screen.pobject_code_view pobject_code_view, screen.pobject_objecttype_view pobject_objecttype_view, screen.pobject_expiredate_view pobject_expiredate_view, screen.pobject_rubycode_view pobject_rubycode_view, screen.pobject_id_view pobject_id_view, screen.pobject_contents_view pobject_contents_view, screen.screen_form_ps screen_form_ps, screen.screen_rows_per_page screen_rows_per_page, screen.screen_rowlist screen_rowlist, screen.screen_height screen_height, screen.screen_strselect screen_strselect, screen.screen_strwhere screen_strwhere, screen.screen_strgrouporder screen_strgrouporder, screen.screen_ymlcode screen_ymlcode, screen.screen_cdrflayout screen_cdrflayout, screen.screen_contents screen_contents, screen.screen_grpcodename screen_grpcodename, screen.screen_id screen_id, screen.screen_expiredate screen_expiredate, screen.screen_pobject_id_scr screen_pobject_id_scr, screen.pobject_code_scr pobject_code_scr, screen.pobject_objecttype_scr pobject_objecttype_scr, screen.pobject_expiredate_scr pobject_expiredate_scr, screen.pobject_rubycode_scr pobject_rubycode_scr, screen.pobject_id_scr pobject_id_scr, screen.pobject_contents_scr pobject_contents_scr, screen.screen_scrlv_id screen_scrlv_id, screen.scrlv_level1 scrlv_level1, screen.scrlv_id scrlv_id, screen.scrlv_expiredate scrlv_expiredate, screen.scrlv_code scrlv_code, screen.screen_strorder screen_strorder,report.filename report_filename ,report.usrgrps_id report_usrgrp_id , usrgrp.usrgrp_id usrgrp_id, usrgrp.usrgrp_expiredate usrgrp_expiredate, usrgrp.usrgrp_code usrgrp_code, usrgrp.usrgrp_name usrgrp_name, usrgrp.usrgrp_contents usrgrp_contents
 from reports report ,r_pobjects  pobject_rep,upd_persons  person_upd,r_screens  screen,r_usrgrps  usrgrp
 where  pobject_rep.id = report.pobjects_id_rep and  person_upd.id = report.persons_id_upd and  screen.id = report.screens_id and  usrgrp.id = report.usrgrps_id
;