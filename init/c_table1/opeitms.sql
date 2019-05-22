CREATE TABLE OPEITMS 
   (	ID NUMERIC(38,0), 
	PROCESSSEQ NUMERIC(38,0), 
	PRIORITY NUMERIC(38,0), 
	LOCAS_ID NUMERIC(38,0), 
	ITMS_ID NUMERIC(38,0), 
	PACKQTY NUMERIC(18,2), 
	MINQTY NUMERIC(38,6), 
	DURATION NUMERIC(38,2), 
	EXPIREDATE DATE, 
	PERSONS_ID_UPD NUMERIC(38,0), 
	UPDATE_IP VARCHAR(40), 
	CREATED_AT TIMESTAMP (6), 
	UPDATED_AT TIMESTAMP (6), 
	REMARK VARCHAR(4000 ), 
	OPERATION VARCHAR(40), 
	MAXQTY NUMERIC(38,4), 
	OPT_FIXOTERM NUMERIC(5,2), 
	AUTOCREATE_ORD CHAR(1), 
	SAFESTKQTY NUMERIC(38,0), 
	UNITS_ID_CASE NUMERIC(38,0), 
	AUTOCREATE_ACT CHAR(1), 
	AUTOCREATE_INST CHAR(1), 
	CONTENTS VARCHAR(4000), 
	CHKORD CHAR(1), 
	CHKORD_PRC NUMERIC(3,0), 
	SHUFFLE_FLG CHAR(1), 
	SHUFFLE_LOCA CHAR(1), 
	ESTTOSCH NUMERIC(38,0), 
	STKTAKING_F CHAR(1), 
	PRDPURSHP VARCHAR(5), 
	MOLD CHAR(1 ), 
	RULE_PRICE CHAR(1 ), 
	CHKINST CHAR(1 ), 
	BOXES_ID NUMERIC(38,0), 
	OPT_FIX_FLG CHAR(1 ), 
	PRJALLOC_FLG NUMERIC(38,0), 
	PACKNO_FLG CHAR(1 ), 
	CHILNUM NUMERIC, 
	PARENUM NUMERIC, 
	UNITS_LTTIME CHAR(4 ), 
	CONSUMTYPE CHAR(3 ), 
	SHELFNOS_ID NUMERIC(38,0), 
	AUTOACT_P NUMERIC(3,0), 
	AUTOORD_P NUMERIC(3,0), 
	CONSUMAUTO CHAR(1 ), 
	UNITS_ID_CASE_PUR NUMERIC(38,0), 
	QTY_PUR NUMERIC(38,0), 
	CONSUMUNITQTY NUMERIC(38,0), 
	 CONSTRAINT OPEITMS_ID_PK PRIMARY KEY (ID),
 
	 CONSTRAINT OPEITM_SHELFNOS_ID FOREIGN KEY (SHELFNOS_ID)
	  REFERENCES SHELFNOS (ID) , 
	 CONSTRAINT OPEITM_UNITS_ID_CASE_PUR FOREIGN KEY (UNITS_ID_CASE_PUR)
	  REFERENCES UNITS (ID) , 
	 CONSTRAINT OPEITM_UNITS_ID_CASE FOREIGN KEY (UNITS_ID_CASE)
	  REFERENCES UNITS (ID) , 
	 CONSTRAINT OPEITM_BOXES_ID FOREIGN KEY (BOXES_ID)
	  REFERENCES BOXES (ID) , 
	 CONSTRAINT OPEITM_LOCAS_ID FOREIGN KEY (LOCAS_ID)
	  REFERENCES LOCAS (ID) , 
	 CONSTRAINT OPEITM_ITMS_ID FOREIGN KEY (ITMS_ID)
	  REFERENCES ITMS (ID) , 
	 CONSTRAINT OPEITM_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
	  REFERENCES PERSONS (ID) 
   ) 
;

CREATE SEQUENCE  OPEITMS_SEQ   INCREMENT BY 1 START WITH 10000
;
CREATE OR REPLACE  VIEW R_OPEITMS (OPEITM_MINQTY, OPEITM_PRIORITY, OPEITM_PARENUM, OPEITM_CHILNUM, OPEITM_CONSUMUNITQTY, OPEITM_EXPIREDATE, OPEITM_CONSUMTYPE, OPEITM_UPDATED_AT, OPEITM_PROCESSSEQ, OPEITM_SAFESTKQTY, OPEITM_DURATION, OPEITM_PACKQTY, OPEITM_ITM_ID, ITM_CODE, ITM_STD, ITM_EXPIREDATE, ITM_MODEL, ITM_WIDE, ITM_NAME, ITM_DETH, ITM_LENGTH, ITM_WEIGHT, ITM_DESIGN, ITM_DATASCALE, ITM_MATERIAL, ITM_ID, ITM_UNIT_ID, UNIT_CONTENTS, UNIT_ID, UNIT_CODE, UNIT_NAME, OPEITM_REMARK, OPEITM_CREATED_AT, OPEITM_UPDATE_IP, OPEITM_PRDPURSHP, ID, OPEITM_ID, OPEITM_PERSON_ID_UPD, PERSON_ID_UPD, PERSON_CODE_UPD, PERSON_NAME_UPD, OPEITM_CONTENTS, OPEITM_LOCA_ID, LOCA_ID, LOCA_EXPIREDATE, LOCA_CODE, LOCA_NAME, LOCA_ABBR, LOCA_ZIP, LOCA_COUNTRY, LOCA_PRFCT, LOCA_ADDR1, LOCA_ADDR2, LOCA_TEL, LOCA_FAX, LOCA_MAIL, OPEITM_AUTOCREATE_ORD, OPEITM_AUTOCREATE_INST, OPEITM_OPT_FIXOTERM, OPEITM_MAXQTY, OPEITM_OPERATION, OPEITM_UNIT_ID_CASE_PUR, UNIT_ID_CASE_PUR, UNIT_EXPIREDATE_CASE_PUR, UNIT_CODE_CASE_PUR, UNIT_NAME_CASE_PUR, UNIT_CONTENTS_CASE_PUR, OPEITM_UNIT_ID_CASE, UNIT_ID_CASE, UNIT_EXPIREDATE_CASE, UNIT_CODE_CASE, UNIT_NAME_CASE, UNIT_CONTENTS_CASE, OPEITM_AUTOCREATE_ACT, OPEITM_SHUFFLE_FLG, OPEITM_SHUFFLE_LOCA, OPEITM_CHKORD, OPEITM_CHKORD_PRC, OPEITM_RULE_PRICE, OPEITM_STKTAKING_F, OPEITM_ESTTOSCH, OPEITM_CHKINST, OPEITM_MOLD, OPEITM_CONSUMAUTO, OPEITM_BOXE_ID, BOXE_HEIGHT, BOXE_CONTENTS, BOXE_ID, BOXE_EXPIREDATE, BOXE_CODE, BOXE_NAME, BOXE_WIDE, BOXE_BOXTYPE, BOXE_DEPTH, BOXE_OUTDEPTH, BOXE_OUTWIDE, BOXE_OUTHEIGHT, BOXE_UNIT_ID_BOX, UNIT_ID_BOX, UNIT_EXPIREDATE_BOX, UNIT_CODE_BOX, UNIT_NAME_BOX, UNIT_CONTENTS_BOX, BOXE_UNIT_ID_OUTBOX, UNIT_ID_OUTBOX, UNIT_EXPIREDATE_OUTBOX, UNIT_CODE_OUTBOX, UNIT_NAME_OUTBOX, UNIT_CONTENTS_OUTBOX, OPEITM_OPT_FIX_FLG, OPEITM_AUTOORD_P, OPEITM_PACKNO_FLG, OPEITM_PRJALLOC_FLG, OPEITM_AUTOACT_P, OPEITM_UNITS_LTTIME, OPEITM_QTY_PUR, OPEITM_SHELFNO_ID, SHELFNO_CODE, SHELFNO_EXPIREDATE, SHELFNO_NAME, SHELFNO_ID, SHELFNO_CONTENTS, SHELFNO_LOCA_ID_SHELFNO, LOCA_ID_SHELFNO, LOCA_EXPIREDATE_SHELFNO, LOCA_CODE_SHELFNO, LOCA_NAME_SHELFNO, LOCA_ABBR_SHELFNO, LOCA_ZIP_SHELFNO, LOCA_COUNTRY_SHELFNO, LOCA_PRFCT_SHELFNO, LOCA_ADDR1_SHELFNO, LOCA_ADDR2_SHELFNO, LOCA_TEL_SHELFNO, LOCA_FAX_SHELFNO, LOCA_MAIL_SHELFNO) AS 
  select opeitm.minqty opeitm_minqty ,opeitm.priority opeitm_priority ,opeitm.parenum opeitm_parenum ,opeitm.chilnum opeitm_chilnum ,opeitm.consumunitqty opeitm_consumunitqty ,opeitm.expiredate opeitm_expiredate ,opeitm.consumtype opeitm_consumtype ,opeitm.updated_at opeitm_updated_at ,opeitm.processseq opeitm_processseq ,opeitm.safestkqty opeitm_safestkqty ,opeitm.duration opeitm_duration ,opeitm.packqty opeitm_packqty ,opeitm.itms_id opeitm_itm_id , itm.itm_code itm_code, itm.itm_std itm_std, itm.itm_expiredate itm_expiredate, itm.itm_model itm_model, itm.itm_wide itm_wide, itm.itm_name itm_name, itm.itm_deth itm_deth, itm.itm_length itm_length, itm.itm_weight itm_weight, itm.itm_design itm_design, itm.itm_datascale itm_datascale, itm.itm_material itm_material, itm.itm_id itm_id, itm.itm_unit_id itm_unit_id, itm.unit_contents unit_contents, itm.unit_id unit_id, itm.unit_code unit_code, itm.unit_name unit_name,opeitm.remark opeitm_remark ,opeitm.created_at opeitm_created_at ,opeitm.update_ip opeitm_update_ip ,opeitm.prdpurshp opeitm_prdpurshp ,opeitm.id id,opeitm.id opeitm_id ,opeitm.persons_id_upd opeitm_person_id_upd , person_upd.person_id_upd person_id_upd, person_upd.person_code_upd person_code_upd, person_upd.person_name_upd person_name_upd,opeitm.contents opeitm_contents ,opeitm.locas_id opeitm_loca_id , loca.loca_id loca_id, loca.loca_expiredate loca_expiredate, loca.loca_code loca_code, loca.loca_name loca_name, loca.loca_abbr loca_abbr, loca.loca_zip loca_zip, loca.loca_country loca_country, loca.loca_prfct loca_prfct, loca.loca_addr1 loca_addr1, loca.loca_addr2 loca_addr2, loca.loca_tel loca_tel, loca.loca_fax loca_fax, loca.loca_mail loca_mail,opeitm.autocreate_ord opeitm_autocreate_ord ,opeitm.autocreate_inst opeitm_autocreate_inst ,opeitm.opt_fixoterm opeitm_opt_fixoterm ,opeitm.maxqty opeitm_maxqty ,opeitm.operation opeitm_operation ,opeitm.units_id_case_pur opeitm_unit_id_case_pur , unit_case_pur.unit_id unit_id_case_pur, unit_case_pur.unit_expiredate unit_expiredate_case_pur, unit_case_pur.unit_code unit_code_case_pur, unit_case_pur.unit_name unit_name_case_pur, unit_case_pur.unit_contents unit_contents_case_pur,opeitm.units_id_case opeitm_unit_id_case , unit_case.unit_id unit_id_case, unit_case.unit_expiredate unit_expiredate_case, unit_case.unit_code unit_code_case, unit_case.unit_name unit_name_case, unit_case.unit_contents unit_contents_case,opeitm.autocreate_act opeitm_autocreate_act ,opeitm.shuffle_flg opeitm_shuffle_flg ,opeitm.shuffle_loca opeitm_shuffle_loca ,opeitm.chkord opeitm_chkord ,opeitm.chkord_prc opeitm_chkord_prc ,opeitm.rule_price opeitm_rule_price ,opeitm.stktaking_f opeitm_stktaking_f ,opeitm.esttosch opeitm_esttosch ,opeitm.chkinst opeitm_chkinst ,opeitm.mold opeitm_mold ,opeitm.consumauto opeitm_consumauto ,opeitm.boxes_id opeitm_boxe_id , boxe.boxe_height boxe_height, boxe.boxe_contents boxe_contents, boxe.boxe_id boxe_id, boxe.boxe_expiredate boxe_expiredate, boxe.boxe_code boxe_code, boxe.boxe_name boxe_name, boxe.boxe_wide boxe_wide, boxe.boxe_boxtype boxe_boxtype, boxe.boxe_depth boxe_depth, boxe.boxe_outdepth boxe_outdepth, boxe.boxe_outwide boxe_outwide, boxe.boxe_outheight boxe_outheight, boxe.boxe_unit_id_box boxe_unit_id_box, boxe.unit_id_box unit_id_box, boxe.unit_expiredate_box unit_expiredate_box, boxe.unit_code_box unit_code_box, boxe.unit_name_box unit_name_box, boxe.unit_contents_box unit_contents_box, boxe.boxe_unit_id_outbox boxe_unit_id_outbox, boxe.unit_id_outbox unit_id_outbox, boxe.unit_expiredate_outbox unit_expiredate_outbox, boxe.unit_code_outbox unit_code_outbox, boxe.unit_name_outbox unit_name_outbox, boxe.unit_contents_outbox unit_contents_outbox,opeitm.opt_fix_flg opeitm_opt_fix_flg ,opeitm.autoord_p opeitm_autoord_p ,opeitm.packno_flg opeitm_packno_flg ,opeitm.prjalloc_flg opeitm_prjalloc_flg ,opeitm.autoact_p opeitm_autoact_p ,opeitm.units_lttime opeitm_units_lttime ,opeitm.qty_pur opeitm_qty_pur ,opeitm.shelfnos_id opeitm_shelfno_id , shelfno.shelfno_code shelfno_code, shelfno.shelfno_expiredate shelfno_expiredate, shelfno.shelfno_name shelfno_name, shelfno.shelfno_id shelfno_id, shelfno.shelfno_contents shelfno_contents, shelfno.shelfno_loca_id_shelfno shelfno_loca_id_shelfno, shelfno.loca_id_shelfno loca_id_shelfno, shelfno.loca_expiredate_shelfno loca_expiredate_shelfno, shelfno.loca_code_shelfno loca_code_shelfno, shelfno.loca_name_shelfno loca_name_shelfno, shelfno.loca_abbr_shelfno loca_abbr_shelfno, shelfno.loca_zip_shelfno loca_zip_shelfno, shelfno.loca_country_shelfno loca_country_shelfno, shelfno.loca_prfct_shelfno loca_prfct_shelfno, shelfno.loca_addr1_shelfno loca_addr1_shelfno, shelfno.loca_addr2_shelfno loca_addr2_shelfno, shelfno.loca_tel_shelfno loca_tel_shelfno, shelfno.loca_fax_shelfno loca_fax_shelfno, shelfno.loca_mail_shelfno loca_mail_shelfno
 from opeitms opeitm ,r_itms  itm,upd_persons  person_upd,r_locas  loca,r_units  unit_case_pur,r_units  unit_case,r_boxes  boxe,r_shelfnos  shelfno
 where  itm.id = opeitm.itms_id and  person_upd.id = opeitm.persons_id_upd and  loca.id = opeitm.locas_id and  unit_case_pur.id = opeitm.units_id_case_pur and  unit_case.id = opeitm.units_id_case and  boxe.id = opeitm.boxes_id and  shelfno.id = opeitm.shelfnos_id
;




