CREATE TABLE UNITS 
   (	ID numeric(38,0), 
	CODE varchar(50), 
	NAME varchar(100), 
	REMARK varchar(4000), 
	PERSONS_ID_UPD numeric(38,0), 
	EXPIREDATE DATE, 
	UPDATE_IP varchar(40), 
	CREATED_AT TIMESTAMP (6), 
	UPDATED_AT TIMESTAMP (6), 
	CONTENTS varchar(4000), 
	 CONSTRAINT UNITS_ID_PK PRIMARY KEY (ID)
)
;

CREATE TABLE ITMS 
   (	ID numeric(38,0), 
	CODE varchar(50), 
	NAME varchar(100), 
	UNITS_ID numeric(38,0), 
	STD varchar(50), 
	MODEL varchar(50), 
	MATERIAL varchar(50), 
	DESIGN varchar(50), 
	WEIGHT numeric(38,6), 
	LENGTH numeric(38,6), 
	WIDE numeric(38,6), 
	DETH numeric(38,6), 
	REMARK varchar(200), 
	EXPIREDATE DATE, 
	PERSONS_ID_UPD numeric(38,0), 
	UPDATE_IP varchar(40), 
	CREATED_AT TIMESTAMP (6), 
	UPDATED_AT TIMESTAMP (6), 
	DATASCALE numeric(38,0), 
	 CONSTRAINT ITMS_ID_PK PRIMARY KEY (ID),
	 CONSTRAINT ITMS_UKYS1 UNIQUE (CODE),
	 CONSTRAINT ITM_UNITS_ID FOREIGN KEY (UNITS_ID)
	  REFERENCES UNITS (ID) ,
	 CONSTRAINT ITM_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
	  REFERENCES PERSONS (ID)
   ) 
  ;

  CREATE OR REPLACE VIEW R_UNITS (ID, UNIT_ID, UNIT_REMARK, UNIT_EXPIREDATE, UNIT_UPDATE_IP, UNIT_CREATED_AT, UNIT_UPDATED_AT, UNIT_PERSON_ID_UPD, PERSON_ID_UPD, PERSON_CODE_UPD, PERSON_NAME_UPD, UNIT_CODE, UNIT_NAME, UNIT_CONTENTS) AS 
  select unit.id id,unit.id unit_id ,unit.remark unit_remark ,unit.expiredate unit_expiredate ,unit.update_ip unit_update_ip ,unit.created_at unit_created_at ,unit.updated_at unit_updated_at ,unit.persons_id_upd unit_person_id_upd , person_upd.person_id_upd person_id_upd, person_upd.person_code_upd person_code_upd, person_upd.person_name_upd person_name_upd,unit.code unit_code ,unit.name unit_name ,unit.contents unit_contents 
 from units unit ,upd_persons  person_upd
 where  person_upd.id = unit.persons_id_upd
;

CREATE OR REPLACE VIEW R_ITMS (ITM_CODE, ITM_STD, ITM_EXPIREDATE, ITM_MODEL, ITM_UPDATED_AT, ITM_WIDE, ITM_NAME, ITM_REMARK, ITM_DETH, ITM_CREATED_AT, ITM_UPDATE_IP, ITM_LENGTH, ITM_WEIGHT, ITM_DESIGN, ITM_DATASCALE, ITM_MATERIAL, ID, ITM_ID, ITM_UNIT_ID, UNIT_CONTENTS, UNIT_ID, UNIT_REMARK, UNIT_CODE, UNIT_NAME, ITM_PERSON_ID_UPD, PERSON_ID_UPD, PERSON_CODE_UPD, PERSON_NAME_UPD) AS 
  select itm.code itm_code ,itm.std itm_std ,itm.expiredate itm_expiredate ,itm.model itm_model ,itm.updated_at itm_updated_at ,itm.wide itm_wide ,itm.name itm_name ,itm.remark itm_remark ,itm.deth itm_deth ,itm.created_at itm_created_at ,itm.update_ip itm_update_ip ,itm.length itm_length ,itm.weight itm_weight ,itm.design itm_design ,itm.datascale itm_datascale ,itm.material itm_material ,itm.id id,itm.id itm_id ,itm.units_id itm_unit_id , unit.unit_contents unit_contents, unit.unit_id unit_id, unit.unit_remark unit_remark, unit.unit_code unit_code, unit.unit_name unit_name,itm.persons_id_upd itm_person_id_upd , person_upd.person_id_upd person_id_upd, person_upd.person_code_upd person_code_upd, person_upd.person_name_upd person_name_upd
 from itms itm ,r_units  unit,upd_persons  person_upd
 where  unit.id = itm.units_id and  person_upd.id = itm.persons_id_upd
 ;
 CREATE TABLE SIO_R_UNITS 
   (	SIO_ID numeric(38,0), 
	SIO_USER_CODE numeric(38,0), 
	SIO_TERM_ID varchar(30), 
	SIO_SESSION_ID numeric, 
	SIO_COMMAND_RESPONSE CHAR(1), 
	SIO_SESSION_COUNTER numeric(38,0), 
	SIO_CLASSNAME varchar(50), 
	SIO_VIEWNAME varchar(30), 
	SIO_CODE varchar(30), 
	SIO_STRSQL varchar(4000), 
	SIO_TOTALCOUNT numeric(38,0), 
	SIO_RECORDCOUNT numeric(38,0), 
	SIO_START_RECORD numeric(38,0), 
	SIO_END_RECORD numeric(38,0), 
	SIO_SORD varchar(256), 
	SIO_SEARCH varchar(10), 
	SIO_SIDX varchar(256), 
	ID numeric(22,0), 
	UNIT_ID numeric(22,0), 
	UNIT_REMARK varchar(4000), 
	UNIT_EXPIREDATE DATE, 
	UNIT_UPDATE_IP varchar(40), 
	UNIT_CREATED_AT TIMESTAMP (6), 
	UNIT_UPDATED_AT TIMESTAMP (6), 
	UNIT_PERSON_ID_UPD numeric(22,0), 
	PERSON_ID_UPD numeric(22,0), 
	PERSON_CODE_UPD varchar(50), 
	PERSON_NAME_UPD varchar(100), 
	UNIT_CODE varchar(50), 
	UNIT_NAME varchar(100), 
	UNIT_CONTENTS varchar(4000), 
	SIO_ERRLINE varchar(4000), 
	SIO_ORG_TBLNAME varchar(30), 
	SIO_ORG_TBLID numeric(38,0), 
	SIO_ADD_TIME DATE, 
	SIO_REPLAY_TIME DATE, 
	SIO_RESULT_F CHAR(1), 
	SIO_MESSAGE_CODE CHAR(10), 
	SIO_MESSAGE_CONTENTS varchar(4000), 
	SIO_CHK_DONE CHAR(1), 
	 CONSTRAINT SIO_R_UNITS_ID_PK PRIMARY KEY (SIO_ID)
)
  ;
CREATE TABLE SIO_R_ITMS 
   (	SIO_ID numeric(38,0), 
	SIO_USER_CODE numeric(38,0), 
	SIO_TERM_ID varchar(30), 
	SIO_SESSION_ID numeric, 
	SIO_COMMAND_RESPONSE CHAR(1), 
	SIO_SESSION_COUNTER numeric(38,0), 
	SIO_CLASSNAME varchar(50), 
	SIO_VIEWNAME varchar(30), 
	SIO_CODE varchar(30), 
	SIO_STRSQL varchar(4000), 
	SIO_TOTALCOUNT numeric(38,0), 
	SIO_RECORDCOUNT numeric(38,0), 
	SIO_START_RECORD numeric(38,0), 
	SIO_END_RECORD numeric(38,0), 
	SIO_SORD varchar(256), 
	SIO_SEARCH varchar(10), 
	SIO_SIDX varchar(256), 
	PERSON_ID_UPD numeric(22,0), 
	PERSON_CODE_UPD varchar(50), 
	PERSON_NAME_UPD varchar(100), 
	ITM_CODE varchar(50), 
	ITM_STD varchar(50), 
	ITM_EXPIREDATE DATE, 
	ITM_MODEL varchar(50), 
	ITM_UPDATED_AT TIMESTAMP (6), 
	ITM_WIDE numeric(22,6), 
	ITM_NAME varchar(100), 
	ITM_REMARK varchar(200), 
	ITM_DETH numeric(22,6), 
	ITM_CREATED_AT TIMESTAMP (6), 
	ITM_UPDATE_IP varchar(40), 
	ITM_LENGTH numeric(22,6), 
	ITM_WEIGHT numeric(22,6), 
	ITM_DESIGN varchar(50), 
	ITM_DATASCALE numeric(22,0), 
	ITM_MATERIAL varchar(50), 
	ID numeric(22,0), 
	ITM_ID numeric(22,0), 
	ITM_UNIT_ID numeric(22,0), 
	UNIT_CONTENTS varchar(4000), 
	UNIT_ID numeric(22,0), 
	UNIT_REMARK varchar(200), 
	UNIT_CODE varchar(50), 
	UNIT_NAME varchar(100), 
	ITM_PERSON_ID_UPD numeric(22,0), 
	SIO_ERRLINE varchar(4000), 
	SIO_ORG_TBLNAME varchar(30), 
	SIO_ORG_TBLID numeric(38,0), 
	SIO_ADD_TIME DATE, 
	SIO_REPLAY_TIME DATE, 
	SIO_RESULT_F CHAR(1), 
	SIO_MESSAGE_CODE CHAR(10), 
	SIO_MESSAGE_CONTENTS varchar(4000), 
	SIO_CHK_DONE CHAR(1), 
	 CONSTRAINT SIO_R_ITMS_ID_PK PRIMARY KEY (SIO_ID)
)
  ;

  copy units(ID,CODE,NAME,REMARK,PERSONS_ID_UPD,EXPIREDATE,UPDATE_IP,CREATED_AT,UPDATED_AT,CONTENTS)  FROM '/mnt/c/ubuntu/RRRP/init/v10data/units.csv' CSV HEADER ;

  copy itms(ID,CODE,NAME,UNITS_ID,STD,MODEL,MATERIAL,DESIGN,WEIGHT,LENGTH,WIDE,DETH,REMARK,EXPIREDATE,PERSONS_ID_UPD,UPDATE_IP,CREATED_AT,UPDATED_AT,DATASCALE)  FROM '/mnt/c/ubuntu/RRRP/init/v10data/itms.csv' CSV HEADER ;
