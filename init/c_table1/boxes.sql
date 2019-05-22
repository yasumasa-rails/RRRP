CREATE TABLE BOXES 
   (	PERSONS_ID_UPD numeric(38,0), 
	CREATED_AT TIMESTAMP (6), 
	UPDATED_AT TIMESTAMP (6), 
	UPDATE_IP varchar(40), 
	BOXTYPE varchar(20), 
	CONTENTS varchar(4000), 
	DEPTH numeric(7,2), 
	EXPIREDATE DATE, 
	HEIGHT numeric(7,2), 
	ID numeric(38,0), 
	OUTDEPTH numeric(7,2), 
	OUTHEIGHT numeric(7,2), 
	OUTWIDE numeric(7,2), 
	REMARK varchar(4000), 
	UNITS_ID_BOX numeric(38,0), 
	UNITS_ID_OUTBOX numeric(38,0), 
	WIDE numeric(7,2), 
	CODE varchar(50), 
	NAME varchar(100), 
	 CONSTRAINT BOXES_UKYS10 UNIQUE (CODE),
	 CONSTRAINT BOXES_ID_PK PRIMARY KEY (ID),
	 CONSTRAINT BOXE_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
	  REFERENCES PERSONS (ID) , 
	 CONSTRAINT BOXE_UNITS_ID_BOX FOREIGN KEY (UNITS_ID_BOX)
	  REFERENCES UNITS (ID) , 
	 CONSTRAINT BOXE_UNITS_ID_OUTBOX FOREIGN KEY (UNITS_ID_OUTBOX)
	  REFERENCES UNITS (ID) 
   ) 
;

CREATE SEQUENCE  BOXES_SEQ  INCREMENT BY 1 START WITH 10000
;

CREATE OR REPLACE  VIEW R_BOXES (BOXE_HEIGHT, BOXE_CONTENTS, ID, BOXE_ID, BOXE_REMARK, BOXE_EXPIREDATE, BOXE_UPDATE_IP, BOXE_CREATED_AT, BOXE_UPDATED_AT, BOXE_PERSON_ID_UPD, PERSON_ID_UPD, PERSON_CODE_UPD, PERSON_NAME_UPD, BOXE_CODE, BOXE_NAME, BOXE_WIDE, BOXE_BOXTYPE, BOXE_DEPTH, BOXE_OUTDEPTH, BOXE_OUTWIDE, BOXE_OUTHEIGHT, BOXE_UNIT_ID_BOX, UNIT_ID_BOX, UNIT_EXPIREDATE_BOX, UNIT_CODE_BOX, UNIT_NAME_BOX, UNIT_CONTENTS_BOX, BOXE_UNIT_ID_OUTBOX, UNIT_ID_OUTBOX, UNIT_EXPIREDATE_OUTBOX, UNIT_CODE_OUTBOX, UNIT_NAME_OUTBOX, UNIT_CONTENTS_OUTBOX) AS 
  select boxe.height boxe_height ,boxe.contents boxe_contents ,boxe.id id,boxe.id boxe_id ,boxe.remark boxe_remark ,boxe.expiredate boxe_expiredate ,boxe.update_ip boxe_update_ip ,boxe.created_at boxe_created_at ,boxe.updated_at boxe_updated_at ,boxe.persons_id_upd boxe_person_id_upd , person_upd.person_id_upd person_id_upd, person_upd.person_code_upd person_code_upd, person_upd.person_name_upd person_name_upd,boxe.code boxe_code ,boxe.name boxe_name ,boxe.wide boxe_wide ,boxe.boxtype boxe_boxtype ,boxe.depth boxe_depth ,boxe.outdepth boxe_outdepth ,boxe.outwide boxe_outwide ,boxe.outheight boxe_outheight ,boxe.units_id_box boxe_unit_id_box , unit_box.unit_id unit_id_box, unit_box.unit_expiredate unit_expiredate_box, unit_box.unit_code unit_code_box, unit_box.unit_name unit_name_box, unit_box.unit_contents unit_contents_box,boxe.units_id_outbox boxe_unit_id_outbox , unit_outbox.unit_id unit_id_outbox, unit_outbox.unit_expiredate unit_expiredate_outbox, unit_outbox.unit_code unit_code_outbox, unit_outbox.unit_name unit_name_outbox, unit_outbox.unit_contents unit_contents_outbox
 from boxes boxe ,upd_persons  person_upd,r_units  unit_box,r_units  unit_outbox
 where  person_upd.id = boxe.persons_id_upd and  unit_box.id = boxe.units_id_box and  unit_outbox.id = boxe.units_id_outbox
;

