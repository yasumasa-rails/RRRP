   --- drop view r_fieldcodes cascade  
 ---DROP MATERIALIZED VIEW  r_fieldcodes;
 create MATERIALIZED view  r_fieldcodes as select  
    fieldcode.expiredate fieldcode_expiredate
  , fieldcode.updated_at fieldcode_updated_at
  , fieldcode.seqno fieldcode_seqno
  , fieldcode.ftype fieldcode_ftype
  , fieldcode.remark fieldcode_remark
  , fieldcode.created_at fieldcode_created_at
  , fieldcode.update_ip fieldcode_update_ip
  , fieldcode.datascale fieldcode_datascale
  , fieldcode.dataprecision fieldcode_dataprecision
  , fieldcode.fieldlength fieldcode_fieldlength
  , fieldcode.id id
  , fieldcode.id fieldcode_id
  , fieldcode.persons_id_upd fieldcode_person_id_upd
  , person_upd.person_id_upd person_id_upd
  , person_upd.person_code_upd person_code_upd
  , person_upd.person_name_upd person_name_upd
  , fieldcode.contents fieldcode_contents
  , fieldcode.pobjects_id_fld fieldcode_pobject_id_fld
  , pobject_fld.pobject_code pobject_code_fld
  , pobject_fld.pobject_objecttype pobject_objecttype_fld
  , pobject_fld.pobject_id pobject_id_fld
  , pobject_fld.pobject_contents pobject_contents_fld
from
  fieldcodes fieldcode
  , upd_persons person_upd
  , r_pobjects pobject_fld
where
  person_upd.id = fieldcode.persons_id_upd
  and pobject_fld.id = fieldcode.pobjects_id_fld
;

DROP TABLE sio.SIO_R_FIELDCODES;

CREATE TABLE sio.SIO_R_FIELDCODES
        (	SIO_ID numeric(38,0),
     	SIO_USER_CODE numeric(38,0),
     	SIO_TERM_ID varchar(30),
     	SIO_SESSION_ID numeric,
     	SIO_COMMAND_RESPONSE CHAR(1),
     	SIO_SESSION_COUNTER numeric(38,0),
     	SIO_CLASSNAME varchar(50),
     	SIO_VIEWNAME varchar(30),
		 SIO_email varchar(50),
     	SIO_CODE varchar(30),
     	SIO_STRSQL varchar(4000),
		SIO_PARAMS varchar(4000),
     	SIO_TOTALCOUNT numeric(38,0),
     	SIO_RECORDCOUNT numeric(38,0),
     	SIO_START_RECORD numeric(38,0),
     	SIO_END_RECORD numeric(38,0),
     	SIO_SORD varchar(256),
     	SIO_SEARCH varchar(10),
     	SIO_SIDX varchar(256),
     	FIELDCODE_CONTENTS varchar(4000),
     	FIELDCODE_FTYPE varchar(15),
     	FIELDCODE_FIELDLENGTH numeric(22,0),
     	ID numeric(22,0),
     	FIELDCODE_ID numeric(22,0),
     	FIELDCODE_REMARK varchar(4000),
     	FIELDCODE_EXPIREDATE DATE,
     	FIELDCODE_UPDATE_IP varchar(40),
     	FIELDCODE_CREATED_AT TIMESTAMP (6),
     	FIELDCODE_UPDATED_AT TIMESTAMP (6),
     	FIELDCODE_PERSON_ID_UPD numeric(22,0),
     	PERSON_ID_UPD numeric(22,0),
     	PERSON_CODE_UPD varchar(50),
     	PERSON_NAME_UPD varchar(100),
     	FIELDCODE_POBJECT_ID_FLD numeric(22,0),
     	POBJECT_CONTENTS_FLD varchar(4000),
     	POBJECT_ID_FLD numeric(22,0),
     	POBJECT_EXPIREDATE_FLD DATE,
     	POBJECT_CODE_FLD varchar(50),
     	POBJECT_OBJECTTYPE_FLD varchar(19),
     	FIELDCODE_SEQNO numeric(22,0),
     	FIELDCODE_DATAPRECISION numeric(22,0),
     	FIELDCODE_DATASCALE numeric(22,0),
     	SIO_ERRLINE varchar(4000),
     	SIO_ORG_TBLNAME varchar(30),
     	SIO_ORG_TBLID numeric(38,0),
     	SIO_ADD_TIME DATE,
     	SIO_REPLAY_TIME DATE,
     	SIO_RESULT_F CHAR(1),
     	SIO_MESSAGE_CODE CHAR(10),
     	SIO_MESSAGE_CONTENTS varchar(4000),
     	SIO_CHK_DONE CHAR(1),
     	 CONSTRAINT SIO_R_FIELDCODES_ID_PK PRIMARY KEY (SIO_ID)

        ) ;

       CREATE INDEX SIO_R_FIELDCODES_UK1 ON sio.SIO_R_FIELDCODES (SIO_USER_CODE, SIO_SESSION_COUNTER, SIO_SESSION_ID, SIO_COMMAND_RESPONSE)
        ;
