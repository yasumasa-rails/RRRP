---DROP TABLE userprocs;
CREATE TABLE userprocs
                   ( id numeric(38)
				     ,session_counter numeric(38)
                     ,sio_code VARCHAR(30)
                     ,status VARCHAR(256)
                     ,cnt numeric(38)
                     ,cnt_out numeric(38)
                     ,Persons_id_Upd numeric(38)
                     ,Update_IP varchar(40)
                     ,created_at timestamp(6)
                     ,Expiredate date
                     ,Updated_at timestamp(6)
                     ,CONSTRAINT userprocs_id_pk PRIMARY KEY (id)
					 ,CONSTRAINT userprocs_uk1 UNIQUE(session_counter,sio_code)
                      )
					  ;
---- Drop SEQUENCE userprocs_seq;
 CREATE SEQUENCE userprocs_seq;
----DROP TABLE Persons;
CREATE TABLE Persons
  ( id numeric(38)
  ,Code varchar(10)
  ,Name VARCHAR(50)
  ,UsrGrps_id numeric(38)
  ,Sects_id numeric(38)
  ,scrlvs_id numeric(38)
  ,contents VARCHAR(4000)
  ,Remark VARCHAR(4000)
  ,Expiredate date
  ,Persons_id_Upd numeric(38)
  ,Update_IP varchar(40)
  ,created_at timestamp(6)
  ,Updated_at timestamp(6)
  ,CONSTRAINT Persons_id_pk PRIMARY KEY (id)
  , CONSTRAINT Persons_16_uk  UNIQUE (Code)
)
;
----drop sequence Persons_seq;
create sequence Persons_seq
;
-----DROP TABLE Locas;
CREATE TABLE Locas
  ( id numeric(38)
  ,Code varchar(40)
  ,Name VARCHAR(100)
  ,ABBR varchar(50)
  ,zip varchar(10)
  ,country varchar(20)
  ,PRFCT varchar(20)
  ,addr1 VARCHAR(50)
  ,addr2 VARCHAR(50)
  ,Tel varchar(20)
  ,Fax varchar(20)
  ,mail varchar(20)
  ,contents VARCHAR(4000)
  ,Remark VARCHAR(4000)
  ,Expiredate date
  ,Persons_id_Upd numeric(38)
  ,Update_IP varchar(40)
  ,created_at timestamp(6)
  ,Updated_at timestamp(6)
  , CONSTRAINT Locas_id_pk PRIMARY KEY (id)
  , CONSTRAINT Locas_23_uk  UNIQUE (Code,Expiredate)
)
;
----drop sequence Locas_seq;
create sequence Locas_seq
;
------------DROP TABLE Sects;
CREATE TABLE Sects
  ( id numeric(38)
  ,Locas_id_sect numeric(38)
  ,contents VARCHAR(4000)
  ,Remark varchar(4000)
  ,Expiredate date
  ,Persons_id_Upd numeric(38)
  ,Update_IP varchar(40)
  ,created_at timestamp(6)
  ,Updated_at timestamp(6)
  , CONSTRAINT Sects_id_pk PRIMARY KEY (id)
)
;
---drop sequence Sects_seq;
create sequence Sects_seq
;

CREATE TABLE SCRLVS
  (	CODE VARCHAR(50),
 CREATED_AT TIMESTAMP (6),
 EXPIREDATE DATE,
 ID numeric(38,0),
 LEVEL1 CHAR(1),
 PERSONS_ID_UPD numeric(38,0),
 contents VARCHAR(4000),
 REMARK VARCHAR(4000),
 UPDATE_IP VARCHAR(4),
 UPDATED_AT TIMESTAMP (6),
  CONSTRAINT SCRLVS_ID_PK PRIMARY KEY (ID),
  CONSTRAINT scrlvs_23_uk  UNIQUE (Code,Expiredate))
 ;
create sequence ScrLVS_seq
;

-----DROP TABLE usrgrps;
CREATE TABLE usrgrps
  ( id numeric(38)
  ,Code varchar(10)
  ,Name VARCHAR(50)
  ,Email VARCHAR(50)
  ,CONTENTS varchar(4000)
  ,Remark VARCHAR(4000)
  ,Expiredate date
  ,Persons_id_Upd numeric(38)
  ,Update_IP varchar(40)
  ,created_at timestamp(6)
  ,Updated_at timestamp(6)
  , CONSTRAINT usrgrps_id_pk PRIMARY KEY (id)
  , CONSTRAINT usrgrps_16_uk  UNIQUE (Code,Expiredate)
)
;
----drop sequence usrgrps_seq;
create sequence usrgrps_seq
;


  CREATE TABLE PRJNOS
   (	CONTENTS VARCHAR(4000),
  REMARK VARCHAR(4000),
	EXPIREDATE DATE,
	PERSONS_ID_UPD numeric(38,0),
	UPDATE_IP VARCHAR(40),
	CREATED_AT TIMESTAMP (6),
	UPDATED_AT TIMESTAMP (6),
	ID numeric(38,0),
	NAME VARCHAR(100),
	CODE VARCHAR(50),
	PRIORITY numeric,
	PRJNOS_ID_CHIL numeric(38,0),
	 CONSTRAINT PRJNOS_ID_PK PRIMARY KEY (ID),
	 CONSTRAINT PRJNO_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
	  REFERENCES PERSONS (ID)
   )
   ;
create sequence PRJNOS_seq
;
  CREATE TABLE POBJECTS
 (	ID numeric(38,0),
REMARK varchar(4000),
PERSONS_ID_UPD numeric(38,0),
UPDATE_IP varchar(40),
CREATED_AT TIMESTAMP (6),
EXPIREDATE DATE,
UPDATED_AT TIMESTAMP (6),
CODE varchar(50),
CONTENTS varchar(4000),
OBJECTTYPE varchar(19),
 CONSTRAINT POBJECTS_ID_PK PRIMARY KEY (ID),
 CONSTRAINT POBJECT_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
  REFERENCES PERSONS (ID)
 ) ;

CREATE UNIQUE INDEX POBJECTS_UKYS1 ON POBJECTS (CODE, OBJECTTYPE)
;

create sequence POBJECTS_seq
;


CREATE TABLE POBJGRPS
   (	ID numeric(38,0),
	POBJECTS_ID numeric(38,0),
	USRGRPS_ID numeric(38,0),
	NAME varchar(50),
	contents varchar(4000),
	REMARK varchar(4000),
	PERSONS_ID_UPD numeric(38,0),
	UPDATE_IP varchar(40),
	CREATED_AT TIMESTAMP (6),
	EXPIREDATE DATE,
	UPDATED_AT TIMESTAMP (6),
	 CONSTRAINT POBJGRPS_ID_PK PRIMARY KEY (ID),
	 CONSTRAINT POBJGRP_POBJECTS_ID FOREIGN KEY (POBJECTS_ID)
	  REFERENCES POBJECTS (ID) ,
	 CONSTRAINT POBJGRP_USRGRPs_ID FOREIGN KEY (USRGRPs_ID)
	  REFERENCES USRGRPs (ID) ,
	 CONSTRAINT POBJGRP_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
	  REFERENCES PERSONS (ID)
   )
  ;

create sequence POBJGRPS_seq
;
  
  CREATE TABLE BLKTBS
   (	ID numeric(38,0),
	POBJECTS_ID_TBL numeric(38,0),
	REMARK varchar(4000),
	PERSONS_ID_UPD numeric(38,0),
	UPDATE_IP varchar(40),
	CREATED_AT TIMESTAMP (6),
	EXPIREDATE DATE,
	UPDATED_AT TIMESTAMP (6),
	SELTBLS varchar(4000),
	CONTENTS varchar(4000),
	 CONSTRAINT BLKTABLES_ID_PK PRIMARY KEY (ID)
  ,
	 CONSTRAINT BLKTBS_UKYS1 UNIQUE (POBJECTS_ID_TBL)
  ,
	 CONSTRAINT BLKTB_POBJECTS_ID_TBL FOREIGN KEY (POBJECTS_ID_TBL)
	  REFERENCES POBJECTS (ID) ,
	 CONSTRAINT BLKTB_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
	  REFERENCES PERSONS (ID)
   )
  ;
  
create sequence BLKTBS_seq
;
  CREATE
OR REPLACE  VIEW R_BLKTBS (
  BLKTB_CONTENTS
  , ID  , BLKTB_ID  , BLKTB_POBJECT_ID_TBL  , POBJECT_CODE_TBL  , POBJECT_OBJECTTYPE_TBL  ,  POBJECT_ID_TBL
  , POBJECT_CONTENTS_TBL  , BLKTB_REMARK  , BLKTB_EXPIREDATE  , BLKTB_UPDATE_IP  , BLKTB_CREATED_AT  , BLKTB_UPDATED_AT
  , BLKTB_PERSON_ID_UPD  , PERSON_ID_UPD  , PERSON_CODE_UPD  , PERSON_NAME_UPD  , BLKTB_SELTBLS
) AS
select
  blktb.contents blktb_contents
  , blktb.id id
  , blktb.id blktb_id
  , blktb.pobjects_id_tbl blktb_pobject_id_tbl
  , pobject_tbl.pobject_code pobject_code_tbl
  , pobject_tbl.pobject_objecttype pobject_objecttype_tbl
  , pobject_tbl.pobject_id pobject_id_tbl
  , pobject_tbl.pobject_contents pobject_contents_tbl
  , blktb.remark blktb_remark
  , blktb.expiredate blktb_expiredate
  , blktb.update_ip blktb_update_ip
  , blktb.created_at blktb_created_at
  , blktb.updated_at blktb_updated_at
  , blktb.persons_id_upd blktb_person_id_upd
  , person_upd.person_id_UPD updperson_id_upd
  , person_upd.person_code_UPD updperson_code_upd
  , person_upd.person_name_UPD updperson_name_upd
  , blktb.seltbls blktb_seltbls
from
  blktbs blktb
  , r_pobjects pobject_tbl
  , upd_persons person_upd
where
  pobject_tbl.id = blktb.pobjects_id_tbl
  and person_upd.id = blktb.persons_id_upd
;


CREATE TABLE SCREENS
   (	ID numeric(38,0),
	STRSELECT varchar(4000),
	STRWHERE varchar(4000),
	STRGROUPORDER varchar(4000),
	YMLCODE varchar(4000),
	CDRFLAYOUT varchar(10),
	EXPIREDATE DATE,
	REMARK varchar(4000),
    PERSONS_ID_UPD numeric(38,0),
	UPDATE_IP varchar(40),
	CREATED_AT TIMESTAMP (6),
	UPDATED_AT TIMESTAMP (6),
	POBJECTS_ID_SCR numeric(38,0),
	POBJECTS_ID_VIEW numeric(38,0),
	POBJECTS_ID_SGRP numeric(38,0),
	ROWS_PER_PAGE numeric(38,0),
	ROWLIST varchar(30),
	HEIGHT numeric(38,0),
	FORM_PS varchar(4000),
	SCRLVS_ID numeric(38,0),
	CONTENTS varchar(4000),
	strorder varchar(4000),
	 CONSTRAINT SCREENS_ID_PK PRIMARY KEY (ID),
	 CONSTRAINT SCREENS_UKYS1 UNIQUE (POBJECTS_ID_SCR),
	 CONSTRAINT SCREEN_POBJECTS_ID_SCR FOREIGN KEY (POBJECTS_ID_SCR)
	  REFERENCES POBJECTS (ID) ,
	 CONSTRAINT SCREEN_POBJECTS_ID_VIEW FOREIGN KEY (POBJECTS_ID_VIEW)
	  REFERENCES POBJECTS (ID) ,
	 CONSTRAINT SCREEN_POBJECTS_ID_SGRP FOREIGN KEY (POBJECTS_ID_SGRP)
	  REFERENCES POBJECTS (ID) ,
	 CONSTRAINT SCREEN_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
	  REFERENCES PERSONS (ID) ,
	 CONSTRAINT SCREEN_SCRLVS_ID FOREIGN KEY (SCRLVS_ID)
	  REFERENCES SCRLVS (ID)
   )

  ;

  
create sequence SCREENS_seq
;




CREATE TABLE FIELDCODES
   (	ID numeric(38,0),
	POBJECTS_ID_FLD numeric(38,0),
	FTYPE varchar(15),
	FIELDLENGTH numeric(38,0),
	DATASCALE numeric(38,0),
	REMARK varchar(4000),
	PERSONS_ID_UPD numeric(38,0),
	UPDATE_IP varchar(40),
	CREATED_AT TIMESTAMP (6),
	EXPIREDATE DATE,
	UPDATED_AT TIMESTAMP (6),
	DATAPRECISION numeric(38,0),
	SEQNO numeric(38,0),
	CONTENTS varchar(4000),
	 CONSTRAINT FIELDCODES_ID_PK PRIMARY KEY (ID),
	 CONSTRAINT FIELDCODE_POBJECTS_ID_FLD FOREIGN KEY (POBJECTS_ID_FLD)
	  REFERENCES POBJECTS (ID) ,
	 CONSTRAINT FIELDCODE_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
	  REFERENCES PERSONS (ID)
   )
  ;

create sequence FIELDCODES_seq
;

  
  CREATE
OR REPLACE VIEW R_FIELDCODES (
  FIELDCODE_EXPIREDATE
  , FIELDCODE_UPDATED_AT
  , FIELDCODE_SEQNO
  , FIELDCODE_FTYPE
  , FIELDCODE_REMARK
  , FIELDCODE_CREATED_AT
  , FIELDCODE_UPDATE_IP
  , FIELDCODE_DATASCALE
  , FIELDCODE_DATAPRECISION
  , FIELDCODE_FIELDLENGTH
  , ID
  , FIELDCODE_ID
  , FIELDCODE_PERSON_ID_UPD
  , PERSON_ID_UPD
  , PERSON_CODE_UPD
  , PERSON_NAME_UPD
  , FIELDCODE_CONTENTS
  , FIELDCODE_POBJECT_ID_FLD
  , POBJECT_CODE_FLD
  , POBJECT_OBJECTTYPE_FLD
  , POBJECT_ID_FLD
  , POBJECT_CONTENTS_FLD
) AS
select
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
CREATE TABLE TBLFIELDS
   (	ID numeric(38,0),
	BLKTBS_ID numeric(38,0),
	FIELDCODES_ID numeric(38,0),
	EXPIREDATE DATE,
	REMARK varchar(4000),
	PERSONS_ID_UPD numeric(38,0),
	UPDATE_IP varchar(40),
	CREATED_AT TIMESTAMP (6),
	UPDATED_AT TIMESTAMP (6),
	SEQNO numeric(38,0),
	CONTENTS varchar(4000),
	VIEWFLMK varchar(4000),
	 CONSTRAINT CTLBLKTABLES_ID_PK PRIMARY KEY (ID),
	 CONSTRAINT TBLFIELDS_UKYS10 UNIQUE (BLKTBS_ID, FIELDCODES_ID)
  ,
	 CONSTRAINT TBLFIELD_BLKTBS_ID FOREIGN KEY (BLKTBS_ID)
	  REFERENCES BLKTBS (ID) ,
	 CONSTRAINT TBLFIELD_FIELDCODES_ID FOREIGN KEY (FIELDCODES_ID)
	  REFERENCES FIELDCODES (ID) ,
	 CONSTRAINT TBLFIELD_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
	  REFERENCES PERSONS (ID)
   )
  ;

create sequence TBLFIELDS_seq
;

  CREATE
OR REPLACE  VIEW R_TBLFIELDS (
  TBLFIELD_CONTENTS
  , TBLFIELD_BLKTB_ID
  , BLKTB_CONTENTS
  , BLKTB_ID
  , BLKTB_POBJECT_ID_TBL
  , POBJECT_CODE_TBL
  , POBJECT_OBJECTTYPE_TBL
  , POBJECT_ID_TBL
  , POBJECT_CONTENTS_TBL
  , BLKTB_SELTBLS
  , TBLFIELD_FIELDCODE_ID
  , FIELDCODE_SEQNO
  , FIELDCODE_FTYPE
  , FIELDCODE_DATASCALE
  , FIELDCODE_DATAPRECISION
  , FIELDCODE_FIELDLENGTH
  , FIELDCODE_ID
  , FIELDCODE_CONTENTS
  , FIELDCODE_POBJECT_ID_FLD
  , POBJECT_CODE_FLD
  , POBJECT_OBJECTTYPE_FLD
  , POBJECT_ID_FLD
  , POBJECT_CONTENTS_FLD
  , ID
  , TBLFIELD_ID
  , TBLFIELD_REMARK
  , TBLFIELD_EXPIREDATE
  , TBLFIELD_UPDATE_IP
  , TBLFIELD_CREATED_AT
  , TBLFIELD_UPDATED_AT
  , TBLFIELD_PERSON_ID_UPD
  , PERSON_ID_UPD
  , PERSON_CODE_UPD
  , PERSON_NAME_UPD
  , TBLFIELD_SEQNO
  , TBLFIELD_VIEWFLMK
) AS
select
  TBLFIELD.contents TBLFIELD_contents
  , TBLFIELD.blktbs_id TBLFIELD_blktb_id
  , blktb.blktb_contents blktb_contents
  , blktb.blktb_id blktb_id
  , blktb.blktb_pobject_id_tbl blktb_pobject_id_tbl
  , blktb.pobject_code_tbl pobject_code_tbl
  , blktb.pobject_objecttype_tbl pobject_objecttype_tbl
  , blktb.pobject_id_tbl pobject_id_tbl
  , blktb.pobject_contents_tbl pobject_contents_tbl
  , blktb.blktb_seltbls blktb_seltbls
  , TBLFIELD.fieldcodes_id TBLFIELD_fieldcode_id
  , fieldcode.fieldcode_seqno fieldcode_seqno
  , fieldcode.fieldcode_ftype fieldcode_ftype
  , fieldcode.fieldcode_datascale fieldcode_datascale
  , fieldcode.fieldcode_dataprecision fieldcode_dataprecision
  , fieldcode.fieldcode_fieldlength fieldcode_fieldlength
  , fieldcode.fieldcode_id fieldcode_id
  , fieldcode.fieldcode_contents fieldcode_contents
  , fieldcode.fieldcode_pobject_id_fld fieldcode_pobject_id_fld
  , fieldcode.pobject_code_fld pobject_code_fld
  , fieldcode.pobject_objecttype_fld pobject_objecttype_fld
  , fieldcode.pobject_id_fld pobject_id_fld
  , fieldcode.pobject_contents_fld pobject_contents_fld
  , TBLFIELD.id id
  , TBLFIELD.id TBLFIELD_ID
  , TBLFIELD.remark TBLFIELD_remark
  , TBLFIELD.expiredate TBLFIELD_expiredate
  , TBLFIELD.update_ip TBLFIELD_update_ip
  , TBLFIELD.created_at TBLFIELD_created_at
  , TBLFIELD.updated_at TBLFIELD_updated_at
  , TBLFIELD.persons_id_upd TBLFIELD_person_id_upd
  , person_upd.person_id_upd person_id_upd
  , person_upd.person_code_upd person_code_upd
  , person_upd.person_name_upd person_name_upd
  , TBLFIELD.seqno TBLFIELD_seqno
  , TBLFIELD.viewflmk TBLFIELD_viewflmk
from
  TBLFIELDS TBLFIELD
  , r_blktbs blktb
  , r_fieldcodes fieldcode
  , upd_persons person_upd
where
  blktb.id = TBLFIELD.blktbs_id
  and fieldcode.id = TBLFIELD.fieldcodes_id
  and person_upd.id = TBLFIELD.persons_id_upd

;
CREATE TABLE SCREENFIELDS
   (	ID numeric(38,0),
	SCREENS_ID numeric(38,0),
	SELECTION numeric(38,0),
	HIDEFLG numeric(38,0),
	SEQNO numeric(38,0),
	ROWPOS numeric(38,0),
	COLPOS numeric(38,0),
	WIDTH numeric(38,0),
	TYPE varchar(12),
	DATAPRECISION numeric(38,0),
	DATASCALE numeric(38,0),
	INDISP numeric(38,0),
	SUBINDISP numeric(38,0),
	EDITABLE numeric(38,0),
	MAXVALUE numeric(38,0),
	MINVALUE numeric(38,0),
	EDOPTSIZE numeric(38,0),
	EDOPTMAXLENGTH numeric(38,0),
	EDOPTROW numeric(38,0),
	EDOPTCOLS numeric(38,0),
	EDOPTVALUE varchar(800),
	SUMKEY CHAR(1),
	CRTFIELD varchar(100),
	EXPIREDATE DATE,
	REMARK varchar(4000),
	PERSONS_ID_UPD numeric(38,0),
	UPDATE_IP varchar(40),
	CREATED_AT TIMESTAMP (6),
	UPDATED_AT TIMESTAMP (6),
	POBJECTS_ID_SFD numeric(38,0),
	TBLFIELDS_ID numeric(38,0),
	PARAGRAPH varchar(30),
	FORMATTER varchar(4000),
	CONTENTS varchar(4000),
	 CONSTRAINT SCREENFIELDS_ID_PK PRIMARY KEY (ID)
  ,
	 CONSTRAINT SCREENFIELD_SCREENS_ID FOREIGN KEY (SCREENS_ID)
	  REFERENCES SCREENS (ID) ,
	 CONSTRAINT SCREENFIELD_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
	  REFERENCES PERSONS (ID) ,
	 CONSTRAINT SCREENFIELD_POBJECTS_ID_SFD FOREIGN KEY (POBJECTS_ID_SFD)
	  REFERENCES POBJECTS (ID),
	 CONSTRAINT SCREENFIELD_TBLFIELDS_ID FOREIGN KEY (TBLFIELDS_ID)
	  REFERENCES TBLFIELDS (ID)
   )
;

create sequence SCREENFIELDS_seq
;

CREATE
OR REPLACE  VIEW R_SCREENFIELDS (
  SCREENFIELD_POBJECT_ID_SFD
  , POBJECT_CODE_SFD
  , POBJECT_OBJECTTYPE_SFD
  , POBJECT_ID_SFD
  , POBJECT_CONTENTS_SFD
  , SCREENFIELD_EXPIREDATE
  , SCREENFIELD_UPDATED_AT
  , SCREENFIELD_EDOPTCOLS
  , SCREENFIELD_EDOPTROW
  , SCREENFIELD_WIDTH
  , SCREENFIELD_INDISP
  , SCREENFIELD_ROWPOS
  , SCREENFIELD_SEQNO
  , SCREENFIELD_HIDEFLG
  , SCREENFIELD_MAXVALUE
  , SCREENFIELD_EDITABLE
  , SCREENFIELD_PARAGRAPH
  , SCREENFIELD_SELECTION
  , SCREENFIELD_CRTFIELD
  , SCREENFIELD_EDOPTVALUE
  , SCREENFIELD_SUBINDISP
  , SCREENFIELD_TYPE
  , SCREENFIELD_SUMKEY
  , SCREENFIELD_REMARK
  , SCREENFIELD_CREATED_AT
  , SCREENFIELD_UPDATE_IP
  , SCREENFIELD_EDOPTMAXLENGTH
  , SCREENFIELD_DATASCALE
  , SCREENFIELD_DATAPRECISION
  , SCREENFIELD_MINVALUE
  , SCREENFIELD_EDOPTSIZE
  , SCREENFIELD_COLPOS
  , ID
  , SCREENFIELD_ID
  , SCREENFIELD_FORMATTER
  , SCREENFIELD_PERSON_ID_UPD
  , PERSON_ID_UPD
  , PERSON_CODE_UPD
  , PERSON_NAME_UPD
  , SCREENFIELD_CONTENTS
  , SCREENFIELD_SCREEN_ID
  , SCREEN_STRWHERE
  , SCREEN_ROWS_PER_PAGE
  , SCREEN_ROWLIST
  , SCREEN_HEIGHT
  , SCREEN_POBJECT_ID_VIEW
  , POBJECT_CODE_VIEW
  , POBJECT_OBJECTTYPE_VIEW
  , POBJECT_ID_VIEW
  , POBJECT_CONTENTS_VIEW
  , SCREEN_FORM_PS
  , SCREEN_STRSELECT
  , SCREEN_CDRFLAYOUT
  , SCREEN_YMLCODE
  , SCREEN_ID
  , SCREEN_GRPCODENAME
  , SCREEN_POBJECT_ID_SCR
  , POBJECT_CODE_SCR
  , POBJECT_OBJECTTYPE_SCR
  , POBJECT_ID_SCR
  , POBJECT_CONTENTS_SCR
  , SCREEN_CONTENTS
  , SCREEN_SCRLV_ID
  , SCRLV_LEVEL1
  , SCRLV_ID
  , SCRLV_CODE
  , SCREENFIELD_TBLFIELD_ID
  , TBLFIELD_CONTENTS
  , FIELDCODE_CONTENTS
) AS
select
  screenfield.pobjects_id_sfd screenfield_pobject_id_sfd
  , pobject_sfd.pobject_code pobject_code_sfd
  , pobject_sfd.pobject_objecttype pobject_objecttype_sfd
  , pobject_sfd.pobject_id pobject_id_sfd
  , pobject_sfd.pobject_contents pobject_contents_sfd
  , screenfield.expiredate screenfield_expiredate
  , screenfield.updated_at screenfield_updated_at
  , screenfield.edoptcols screenfield_edoptcols
  , screenfield.edoptrow screenfield_edoptrow
  , screenfield.width screenfield_width
  , screenfield.indisp screenfield_indisp
  , screenfield.rowpos screenfield_rowpos
  , screenfield.seqno screenfield_seqno
  , screenfield.hideflg screenfield_hideflg
  , screenfield.maxvalue screenfield_maxvalue
  , screenfield.editable screenfield_editable
  , screenfield.paragraph screenfield_paragraph
  , screenfield.selection screenfield_selection
  , screenfield.crtfield screenfield_crtfield
  , screenfield.edoptvalue screenfield_edoptvalue
  , screenfield.subindisp screenfield_subindisp
  , screenfield.type screenfield_type
  , screenfield.sumkey screenfield_sumkey
  , screenfield.remark screenfield_remark
  , screenfield.created_at screenfield_created_at
  , screenfield.update_ip screenfield_update_ip
  , screenfield.edoptmaxlength screenfield_edoptmaxlength
  , screenfield.datascale screenfield_datascale
  , screenfield.dataprecision screenfield_dataprecision
  , screenfield.minvalue screenfield_minvalue
  , screenfield.edoptsize screenfield_edoptsize
  , screenfield.colpos screenfield_colpos
  , screenfield.id id
  , screenfield.id screenfield_id
  , screenfield.formatter screenfield_formatter
  , screenfield.persons_id_upd screenfield_person_id_upd
  , person_upd.person_id_upd person_id_upd
  , person_upd.person_code_upd person_code_upd
  , person_upd.person_name_upd person_name_upd
  , screenfield.contents screenfield_contents
  , screenfield.screens_id screenfield_screen_id
  , screen.screen_strwhere screen_strwhere
  , screen.screen_rows_per_page screen_rows_per_page
  , screen.screen_rowlist screen_rowlist
  , screen.screen_height screen_height
  , screen.screen_pobject_id_view screen_pobject_id_view
  , screen.pobject_code_view pobject_code_view
  , screen.pobject_objecttype_view pobject_objecttype_view
  , screen.pobject_id_view pobject_id_view
  , screen.pobject_contents_view pobject_contents_view
  , screen.screen_form_ps screen_form_ps
  , screen.screen_strselect screen_strselect
  , screen.screen_cdrflayout screen_cdrflayout
  , screen.screen_ymlcode screen_ymlcode
  , screen.screen_id screen_id
  , screen.screen_grpcodename screen_grpcodename
  , screen.screen_pobject_id_scr screen_pobject_id_scr
  , screen.pobject_code_scr pobject_code_scr
  , screen.pobject_objecttype_scr pobject_objecttype_scr
  , screen.pobject_id_scr pobject_id_scr
  , screen.pobject_contents_scr pobject_contents_scr
  , screen.screen_contents screen_contents
  , screen.screen_scrlv_id screen_scrlv_id
  , screen.scrlv_level1 scrlv_level1
  , screen.scrlv_id scrlv_id
  , screen.scrlv_code scrlv_code
  , screenfield.TBLFIELDS_id
  , TBLFIELD.TBLFIELD_contents
  , TBLFIELD.fieldcode_contents
from
  screenfields screenfield
  , r_pobjects pobject_sfd
  , upd_persons person_upd
  , r_screens screen
  , R_TBLFIELDS TBLFIELD
where
  pobject_sfd.id = screenfield.pobjects_id_sfd
  and person_upd.id = screenfield.persons_id_upd
  and screen.id = screenfield.screens_id
  AND TBLFIELD.ID = SCREENFIELD.TBLFIELDS_ID
;
CREATE TABLE CHILSCREENS
   (	ID numeric(38,0),
	EXPIREDATE DATE,
	CONTENTS varchar(4000),
	REMARK varchar(4000),
	PERSONS_ID_UPD numeric(38,0),
	UPDATE_IP varchar(40),
	CREATED_AT TIMESTAMP (6),
	UPDATED_AT TIMESTAMP (6),
	SCREENFIELDS_ID numeric(38,0),
	SCREENFIELDS_ID_CH numeric(38,0),
	GRP varchar(10),
	 CONSTRAINT CHILSCREEN_ID_PK PRIMARY KEY (ID)
  ,
	 CONSTRAINT CHILSCREEN_SCREENFIELDS_ID_CH FOREIGN KEY (SCREENFIELDS_ID_CH)
	  REFERENCES SCREENFIELDS (ID) ,
	 CONSTRAINT CHILSCREEN_SCREENFIELDS_ID FOREIGN KEY (SCREENFIELDS_ID)
	  REFERENCES SCREENFIELDS (ID) ,
	 CONSTRAINT CHILSCREEN_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
	  REFERENCES PERSONS (ID)
   )

  ;

create sequence CHILSCREENS_seq
;

  
CREATE
OR REPLACE  VIEW R_CHILSCREENS (
  CHILSCREEN_GRP
  , CHILSCREEN_SCREENFIELD_ID
  , SCREENFIELD_POBJECT_ID_SFD
  , POBJECT_CODE_SFD
  , POBJECT_OBJECTTYPE_SFD
  , POBJECT_ID_SFD
  , POBJECT_CONTENTS_SFD
  , SCREENFIELD_EDOPTCOLS
  , SCREENFIELD_EDOPTROW
  , SCREENFIELD_WIDTH
  , SCREENFIELD_INDISP
  , SCREENFIELD_ROWPOS
  , SCREENFIELD_SEQNO
  , SCREENFIELD_HIDEFLG
  , SCREENFIELD_MAXVALUE
  , SCREENFIELD_EDITABLE
  , SCREENFIELD_PARAGRAPH
  , SCREENFIELD_SELECTION
  , SCREENFIELD_CRTFIELD
  , SCREENFIELD_EDOPTVALUE
  , SCREENFIELD_SUBINDISP
  , SCREENFIELD_TYPE
  , SCREENFIELD_SUMKEY
  , SCREENFIELD_EDOPTMAXLENGTH
  , SCREENFIELD_DATASCALE
  , SCREENFIELD_DATAPRECISION
  , SCREENFIELD_MINVALUE
  , SCREENFIELD_EDOPTSIZE
  , SCREENFIELD_COLPOS
  , SCREENFIELD_ID
  , SCREENFIELD_FORMATTER
  , SCREENFIELD_CONTENTS
  , SCREENFIELD_SCREEN_ID
  , SCREEN_STRWHERE
  , SCREEN_ROWS_PER_PAGE
  , SCREEN_ROWLIST
  , SCREEN_HEIGHT
  , SCREEN_POBJECT_ID_VIEW
  , POBJECT_CODE_VIEW
  , POBJECT_OBJECTTYPE_VIEW
  , POBJECT_ID_VIEW
  , POBJECT_CONTENTS_VIEW
  , SCREEN_FORM_PS
  , SCREEN_STRSELECT
  , SCREEN_CDRFLAYOUT
  , SCREEN_YMLCODE
  , SCREEN_ID
  , SCREEN_GRPCODENAME
  , SCREEN_POBJECT_ID_SCR
  , POBJECT_CODE_SCR
  , POBJECT_OBJECTTYPE_SCR
  , POBJECT_ID_SCR
  , POBJECT_CONTENTS_SCR
  , SCREEN_CONTENTS
  , SCREEN_SCRLV_ID
  , SCRLV_LEVEL1
  , SCRLV_ID
  , SCRLV_CODE
  , TBLFIELD_CONTENTS
  , FIELDCODE_CONTENTS
  , CHILSCREEN_SCREENFIELD_ID_CH
  , SCREENFIELD_POBJECT_ID_SFD_CH
  , POBJECT_CODE_SFD_CH
  , POBJECT_OBJECTTYPE_SFD_CH
  , POBJECT_ID_SFD_CH
  , POBJECT_CONTENTS_SFD_CH
  , SCREENFIELD_EDOPTCOLS_CH
  , SCREENFIELD_EDOPTROW_CH
  , SCREENFIELD_WIDTH_CH
  , SCREENFIELD_INDISP_CH
  , SCREENFIELD_ROWPOS_CH
  , SCREENFIELD_SEQNO_CH
  , SCREENFIELD_HIDEFLG_CH
  , SCREENFIELD_MAXVALUE_CH
  , SCREENFIELD_EDITABLE_CH
  , SCREENFIELD_PARAGRAPH_CH
  , SCREENFIELD_SELECTION_CH
  , SCREENFIELD_CRTFIELD_CH
  , SCREENFIELD_EDOPTVALUE_CH
  , SCREENFIELD_SUBINDISP_CH
  , SCREENFIELD_TYPE_CH
  , SCREENFIELD_SUMKEY_CH
  , SCREENFIELD_EDOPTMAXLENGTH_CH
  , SCREENFIELD_DATASCALE_CH
  , SCREENFIELD_DATAPRECISION_CH
  , SCREENFIELD_MINVALUE_CH
  , SCREENFIELD_EDOPTSIZE_CH
  , SCREENFIELD_COLPOS_CH
  , SCREENFIELD_ID_CH
  , SCREENFIELD_FORMATTER_CH
  , SCREENFIELD_CONTENTS_CH
  , SCREENFIELD_SCREEN_ID_CH
  , SCREEN_STRWHERE_CH
  , SCREEN_ROWS_PER_PAGE_CH
  , SCREEN_ROWLIST_CH
  , SCREEN_HEIGHT_CH
  , SCREEN_POBJECT_ID_VIEW_CH
  , POBJECT_CODE_VIEW_CH
  , POBJECT_OBJECTTYPE_VIEW_CH
  , POBJECT_ID_VIEW_CH
  , POBJECT_CONTENTS_VIEW_CH
  , SCREEN_FORM_PS_CH
  , SCREEN_STRSELECT_CH
  , SCREEN_CDRFLAYOUT_CH
  , SCREEN_YMLCODE_CH
  , SCREEN_ID_CH
  , SCREEN_GRPCODENAME_CH
  , SCREEN_POBJECT_ID_SCR_CH
  , POBJECT_CODE_SCR_CH
  , POBJECT_OBJECTTYPE_SCR_CH
  , POBJECT_ID_SCR_CH
  , POBJECT_CONTENTS_SCR_CH
  , SCREEN_CONTENTS_CH
  , SCREEN_SCRLV_ID_CH
  , SCRLV_LEVEL1_CH
  , SCRLV_ID_CH
  , SCRLV_CODE_CH
  , TBLFIELD_CONTENTS_CH
  , FIELDCODE_CONTENTS_CH
  , ID
  , CHILSCREEN_ID
  , CHILSCREEN_CONTENTS
  , CHILSCREEN_REMARK
  , CHILSCREEN_EXPIREDATE
  , CHILSCREEN_UPDATE_IP
  , CHILSCREEN_CREATED_AT
  , CHILSCREEN_UPDATED_AT
  , CHILSCREEN_PERSON_ID_UPD
  , PERSON_ID_UPD
  , PERSON_CODE_UPD
  , PERSON_NAME_UPD
) AS
select
  chilscreen.grp chilscreen_grp
  , chilscreen.screenfields_id chilscreen_screenfield_id
  , screenfield.screenfield_pobject_id_sfd screenfield_pobject_id_sfd
  , screenfield.pobject_code_sfd pobject_code_sfd
  , screenfield.pobject_objecttype_sfd pobject_objecttype_sfd
  , screenfield.pobject_id_sfd pobject_id_sfd
  , screenfield.pobject_contents_sfd pobject_contents_sfd
  , screenfield.screenfield_edoptcols screenfield_edoptcols
  , screenfield.screenfield_edoptrow screenfield_edoptrow
  , screenfield.screenfield_width screenfield_width
  , screenfield.screenfield_indisp screenfield_indisp
  , screenfield.screenfield_rowpos screenfield_rowpos
  , screenfield.screenfield_seqno screenfield_seqno
  , screenfield.screenfield_hideflg screenfield_hideflg
  , screenfield.screenfield_maxvalue screenfield_maxvalue
  , screenfield.screenfield_editable screenfield_editable
  , screenfield.screenfield_paragraph screenfield_paragraph
  , screenfield.screenfield_selection screenfield_selection
  , screenfield.screenfield_crtfield screenfield_crtfield
  , screenfield.screenfield_edoptvalue screenfield_edoptvalue
  , screenfield.screenfield_subindisp screenfield_subindisp
  , screenfield.screenfield_type screenfield_type
  , screenfield.screenfield_sumkey screenfield_sumkey
  , screenfield.screenfield_edoptmaxlength screenfield_edoptmaxlength
  , screenfield.screenfield_datascale screenfield_datascale
  , screenfield.screenfield_dataprecision screenfield_dataprecision
  , screenfield.screenfield_minvalue screenfield_minvalue
  , screenfield.screenfield_edoptsize screenfield_edoptsize
  , screenfield.screenfield_colpos screenfield_colpos
  , screenfield.screenfield_id screenfield_id
  , screenfield.screenfield_formatter screenfield_formatter
  , screenfield.screenfield_contents screenfield_contents
  , screenfield.screenfield_screen_id screenfield_screen_id
  , screenfield.screen_strwhere screen_strwhere
  , screenfield.screen_rows_per_page screen_rows_per_page
  , screenfield.screen_rowlist screen_rowlist
  , screenfield.screen_height screen_height
  , screenfield.screen_pobject_id_view screen_pobject_id_view
  , screenfield.pobject_code_view pobject_code_view
  , screenfield.pobject_objecttype_view pobject_objecttype_view
  , screenfield.pobject_id_view pobject_id_view
  , screenfield.pobject_contents_view pobject_contents_view
  , screenfield.screen_form_ps screen_form_ps
  , screenfield.screen_strselect screen_strselect
  , screenfield.screen_cdrflayout screen_cdrflayout
  , screenfield.screen_ymlcode screen_ymlcode
  , screenfield.screen_id screen_id
  , screenfield.screen_grpcodename screen_grpcodename
  , screenfield.screen_pobject_id_scr screen_pobject_id_scr
  , screenfield.pobject_code_scr pobject_code_scr
  , screenfield.pobject_objecttype_scr pobject_objecttype_scr
  , screenfield.pobject_id_scr pobject_id_scr
  , screenfield.pobject_contents_scr pobject_contents_scr
  , screenfield.screen_contents screen_contents
  , screenfield.screen_scrlv_id screen_scrlv_id
  , screenfield.scrlv_level1 scrlv_level1
  , screenfield.scrlv_id scrlv_id
  , screenfield.scrlv_code scrlv_code
  , screenfield.TBLFIELD_contents TBLFIELD_contents
  , screenfield.fieldcode_contents fieldcode_contents
  , chilscreen.screenfields_id_ch chilscreen_screenfield_id_ch
  , screenfield_ch.screenfield_pobject_id_sfd screenfield_pobject_id_sfd_ch
  , screenfield_ch.pobject_code_sfd pobject_code_sfd_ch
  , screenfield_ch.pobject_objecttype_sfd pobject_objecttype_sfd_ch
  , screenfield_ch.pobject_id_sfd pobject_id_sfd_ch
  , screenfield_ch.pobject_contents_sfd pobject_contents_sfd_ch
  , screenfield_ch.screenfield_edoptcols screenfield_edoptcols_ch
  , screenfield_ch.screenfield_edoptrow screenfield_edoptrow_ch
  , screenfield_ch.screenfield_width screenfield_width_ch
  , screenfield_ch.screenfield_indisp screenfield_indisp_ch
  , screenfield_ch.screenfield_rowpos screenfield_rowpos_ch
  , screenfield_ch.screenfield_seqno screenfield_seqno_ch
  , screenfield_ch.screenfield_hideflg screenfield_hideflg_ch
  , screenfield_ch.screenfield_maxvalue screenfield_maxvalue_ch
  , screenfield_ch.screenfield_editable screenfield_editable_ch
  , screenfield_ch.screenfield_paragraph screenfield_paragraph_ch
  , screenfield_ch.screenfield_selection screenfield_selection_ch
  , screenfield_ch.screenfield_crtfield screenfield_crtfield_ch
  , screenfield_ch.screenfield_edoptvalue screenfield_edoptvalue_ch
  , screenfield_ch.screenfield_subindisp screenfield_subindisp_ch
  , screenfield_ch.screenfield_type screenfield_type_ch
  , screenfield_ch.screenfield_sumkey screenfield_sumkey_ch
  , screenfield_ch.screenfield_edoptmaxlength screenfield_edoptmaxlength_ch
  , screenfield_ch.screenfield_datascale screenfield_datascale_ch
  , screenfield_ch.screenfield_dataprecision screenfield_dataprecision_ch
  , screenfield_ch.screenfield_minvalue screenfield_minvalue_ch
  , screenfield_ch.screenfield_edoptsize screenfield_edoptsize_ch
  , screenfield_ch.screenfield_colpos screenfield_colpos_ch
  , screenfield_ch.screenfield_id screenfield_id_ch
  , screenfield_ch.screenfield_formatter screenfield_formatter_ch
  , screenfield_ch.screenfield_contents screenfield_contents_ch
  , screenfield_ch.screenfield_screen_id screenfield_screen_id_ch
  , screenfield_ch.screen_strwhere screen_strwhere_ch
  , screenfield_ch.screen_rows_per_page screen_rows_per_page_ch
  , screenfield_ch.screen_rowlist screen_rowlist_ch
  , screenfield_ch.screen_height screen_height_ch
  , screenfield_ch.screen_pobject_id_view screen_pobject_id_view_ch
  , screenfield_ch.pobject_code_view pobject_code_view_ch
  , screenfield_ch.pobject_objecttype_view pobject_objecttype_view_ch
  , screenfield_ch.pobject_id_view pobject_id_view_ch
  , screenfield_ch.pobject_contents_view pobject_contents_view_ch
  , screenfield_ch.screen_form_ps screen_form_ps_ch
  , screenfield_ch.screen_strselect screen_strselect_ch
  , screenfield_ch.screen_cdrflayout screen_cdrflayout_ch
  , screenfield_ch.screen_ymlcode screen_ymlcode_ch
  , screenfield_ch.screen_id screen_id_ch
  , screenfield_ch.screen_grpcodename screen_grpcodename_ch
  , screenfield_ch.screen_pobject_id_scr screen_pobject_id_scr_ch
  , screenfield_ch.pobject_code_scr pobject_code_scr_ch
  , screenfield_ch.pobject_objecttype_scr pobject_objecttype_scr_ch
  , screenfield_ch.pobject_id_scr pobject_id_scr_ch
  , screenfield_ch.pobject_contents_scr pobject_contents_scr_ch
  , screenfield_ch.screen_contents screen_contents_ch
  , screenfield_ch.screen_scrlv_id screen_scrlv_id_ch
  , screenfield_ch.scrlv_level1 scrlv_level1_ch
  , screenfield_ch.scrlv_id scrlv_id_ch
  , screenfield_ch.scrlv_code scrlv_code_ch
  , screenfield_ch.TBLFIELD_contents TBLFIELD_contents_ch
  , screenfield_ch.fieldcode_contents fieldcode_contents_ch
  , chilscreen.id id
  , chilscreen.id chilscreen_id
  , chilscreen.contents chilscreen_contents
  , chilscreen.remark chilscreen_remark
  , chilscreen.expiredate chilscreen_expiredate
  , chilscreen.update_ip chilscreen_update_ip
  , chilscreen.created_at chilscreen_created_at
  , chilscreen.updated_at chilscreen_updated_at
  , chilscreen.persons_id_upd chilscreen_person_id_upd
  , person_upd.person_id_upd person_id_upd
  , person_upd.person_code_upd person_code_upd
  , person_upd.person_name_upd person_name_upd
from
  chilscreens chilscreen
  , r_screenfields screenfield
  , r_screenfields screenfield_ch
  , upd_persons person_upd
where
  screenfield.id = chilscreen.screenfields_id
  and screenfield_ch.id = chilscreen.screenfields_id_ch
  and person_upd.id = chilscreen.persons_id_upd
;

CREATE TABLE BUTTONS
   (	ID numeric(38,0),
	EXPIREDATE DATE,
	CONTENTS varchar(4000),
	REMARK varchar(4000),
	PERSONS_ID_UPD numeric(38,0),
	UPDATE_IP varchar(40),
	CREATED_AT TIMESTAMP (6),
	UPDATED_AT TIMESTAMP (6),
	SEQNO numeric(38,0),
	CAPTION varchar(20),
	TITLE varchar(30),
	BUTTONICON varchar(40),
	ONCLICKBUTTON varchar(4000),
	GETGRIDPARAM varchar(10),
	EDITGRIDROW varchar(4000),
	AFTERSHOWFORM varchar(4000),
	CODE varchar(50),
	 CONSTRAINT BUTTONS_ID_PK PRIMARY KEY (ID)
  ,
	 CONSTRAINT BUTTON_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
	  REFERENCES PERSONS (ID)
   )
  ;

create sequence BUTTONS_seq
;

   
  CREATE
OR REPLACE  VIEW R_BUTTONS (
  BUTTON_CODE
  , BUTTON_EXPIREDATE
  , BUTTON_UPDATED_AT
  , BUTTON_CONTENTS
  , BUTTON_SEQNO
  , BUTTON_REMARK
  , BUTTON_CREATED_AT
  , BUTTON_UPDATE_IP
  , BUTTON_TITLE
  , ID
  , BUTTON_ID
  , BUTTON_PERSON_ID_UPD
  , PERSON_ID_UPD
  , PERSON_CODE_UPD
  , PERSON_NAME_UPD
  , BUTTON_CAPTION
  , BUTTON_BUTTONICON
  , BUTTON_ONCLICKBUTTON
  , BUTTON_GETGRIDPARAM
  , BUTTON_EDITGRIDROW
  , BUTTON_AFTERSHOWFORM
) AS
select
  button.code button_code
  , button.expiredate button_expiredate
  , button.updated_at button_updated_at
  , button.contents button_contents
  , button.seqno button_seqno
  , button.remark button_remark
  , button.created_at button_created_at
  , button.update_ip button_update_ip
  , button.title button_title
  , button.id id
  , button.id button_id
  , button.persons_id_upd button_person_id_upd
  , person_upd.person_id_upd updperson_id_upd
  , person_upd.person_code_upd updperson_code_upd
  , person_upd.person_name_upd updperson_name_upd
  , button.caption button_caption
  , button.buttonicon button_buttonicon
  , button.onclickbutton button_onclickbutton
  , button.getgridparam button_getgridparam
  , button.editgridrow button_editgridrow
  , button.aftershowform button_aftershowform
from
  buttons button
  , upd_persons person_upd
where
  person_upd.id = button.persons_id_upd
;

CREATE TABLE USEBUTTONS
   (	BUTTONS_ID numeric(38,0),
	ID numeric(38,0),
	EXPIREDATE DATE,
	CONTENTS varchar(4000),
	REMARK varchar(4000),
	PERSONS_ID_UPD numeric(38,0),
	UPDATE_IP varchar(40),
	CREATED_AT TIMESTAMP (6),
	UPDATED_AT TIMESTAMP (6),
	SCREENS_ID_UB numeric(38,0),
	 CONSTRAINT USEBUTTONS_ID_PK PRIMARY KEY (ID)
  ,
	 CONSTRAINT USEBUTTON_SCREENS_ID_UB FOREIGN KEY (SCREENS_ID_UB)
	  REFERENCES SCREENS (ID) ,
	 CONSTRAINT USEBUTTON_BUTTONS_ID FOREIGN KEY (BUTTONS_ID)
	  REFERENCES BUTTONS (ID) ,
	 CONSTRAINT USEBUTTON_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
	  REFERENCES PERSONS (ID)
   )
  ;

create sequence USEBUTTONS_seq
;


  CREATE
OR REPLACE  VIEW R_USEBUTTONS (
  ID
  , USEBUTTON_ID
  , USEBUTTON_CONTENTS
  , USEBUTTON_REMARK
  , USEBUTTON_EXPIREDATE
  , USEBUTTON_UPDATE_IP
  , USEBUTTON_CREATED_AT
  , USEBUTTON_UPDATED_AT
  , USEBUTTON_PERSON_ID_UPD
  , PERSON_ID_UPD
  , PERSON_CODE_UPD
  , PERSON_NAME_UPD
  , USEBUTTON_BUTTON_ID
  , BUTTON_CODE
  , BUTTON_SEQNO
  , BUTTON_TITLE
  , BUTTON_ID
  , BUTTON_CAPTION
  , BUTTON_BUTTONICON
  , BUTTON_ONCLICKBUTTON
  , BUTTON_GETGRIDPARAM
  , BUTTON_EDITGRIDROW
  , BUTTON_AFTERSHOWFORM
  , USEBUTTON_SCREEN_ID_UB
  , SCREEN_STRWHERE_UB
  , SCREEN_ROWS_PER_PAGE_UB
  , SCREEN_ROWLIST_UB
  , SCREEN_HEIGHT_UB
  , SCREEN_POBJECT_ID_VIEW_UB
  , POBJECT_CODE_VIEW_UB
  , POBJECT_OBJECTTYPE_VIEW_UB
  , POBJECT_ID_VIEW_UB
  , POBJECT_CONTENTS_VIEW_UB
  , SCREEN_FORM_PS_UB
  , SCREEN_STRSELECT_UB
  , SCREEN_CDRFLAYOUT_UB
  , SCREEN_YMLCODE_UB
  , SCREEN_ID_UB
  , SCREEN_GRPCODENAME_UB
  , SCREEN_POBJECT_ID_SCR_UB
  , POBJECT_CODE_SCR_UB
  , POBJECT_OBJECTTYPE_SCR_UB
  , POBJECT_ID_SCR_UB
  , POBJECT_CONTENTS_SCR_UB
  , SCREEN_CONTENTS_UB
  , SCREEN_SCRLV_ID_UB
  , SCRLV_LEVEL1_UB
  , SCRLV_ID_UB
  , SCRLV_CODE_UB
) AS
select
  usebutton.id id
  , usebutton.id usebutton_id
  , usebutton.contents usebutton_contents
  , usebutton.remark usebutton_remark
  , usebutton.expiredate usebutton_expiredate
  , usebutton.update_ip usebutton_update_ip
  , usebutton.created_at usebutton_created_at
  , usebutton.updated_at usebutton_updated_at
  , usebutton.persons_id_upd usebutton_person_id_upd
  , person_upd.person_id_upd updperson_id_upd
  , person_upd.person_code_upd updperson_code_upd
  , person_upd.person_name_upd updperson_name_upd
  , usebutton.buttons_id usebutton_button_id
  , button.button_code button_code
  , button.button_seqno button_seqno
  , button.button_title button_title
  , button.button_id button_id
  , button.button_caption button_caption
  , button.button_buttonicon button_buttonicon
  , button.button_onclickbutton button_onclickbutton
  , button.button_getgridparam button_getgridparam
  , button.button_editgridrow button_editgridrow
  , button.button_aftershowform button_aftershowform
  , usebutton.screens_id_ub usebutton_screen_id_ub
  , screen_ub.screen_strwhere screen_strwhere_ub
  , screen_ub.screen_rows_per_page screen_rows_per_page_ub
  , screen_ub.screen_rowlist screen_rowlist_ub
  , screen_ub.screen_height screen_height_ub
  , screen_ub.screen_pobject_id_view screen_pobject_id_view_ub
  , screen_ub.pobject_code_view pobject_code_view_ub
  , screen_ub.pobject_objecttype_view pobject_objecttype_view_ub
  , screen_ub.pobject_id_view pobject_id_view_ub
  , screen_ub.pobject_contents_view pobject_contents_view_ub
  , screen_ub.screen_form_ps screen_form_ps_ub
  , screen_ub.screen_strselect screen_strselect_ub
  , screen_ub.screen_cdrflayout screen_cdrflayout_ub
  , screen_ub.screen_ymlcode screen_ymlcode_ub
  , screen_ub.screen_id screen_id_ub
  , screen_ub.screen_grpcodename screen_grpcodename_ub
  , screen_ub.screen_pobject_id_scr screen_pobject_id_scr_ub
  , screen_ub.pobject_code_scr pobject_code_scr_ub
  , screen_ub.pobject_objecttype_scr pobject_objecttype_scr_ub
  , screen_ub.pobject_id_scr pobject_id_scr_ub
  , screen_ub.pobject_contents_scr pobject_contents_scr_ub
  , screen_ub.screen_contents screen_contents_ub
  , screen_ub.screen_scrlv_id screen_scrlv_id_ub
  , screen_ub.scrlv_level1 scrlv_level1_ub
  , screen_ub.scrlv_id scrlv_id_ub
  , screen_ub.scrlv_code scrlv_code_ub
from
  usebuttons usebutton
  , upd_persons person_upd
  , r_buttons button
  , r_screens screen_ub
where
  person_upd.id = usebutton.persons_id_upd
  and button.id = usebutton.buttons_id
  and screen_ub.id = usebutton.screens_id_ub
;
CREATE TABLE REPORTS
   (	ID numeric(38,0),
	FILENAME varchar(50),
	SCREENS_ID numeric(38,0),
	USRGRPS_ID numeric(38,0),
	EXPIREDATE DATE,
	REMARK varchar(4000),
	PERSONS_ID_UPD numeric(38,0),
	UPDATE_IP varchar(40),
	CREATED_AT TIMESTAMP (6),
	UPDATED_AT TIMESTAMP (6),
	POBJECTS_ID_REP numeric(38,0),
	CONTENTS varchar(4000),
	 CONSTRAINT REPORTS_ID_PK PRIMARY KEY (ID)
  ,
	 CONSTRAINT REPORT_POBJECTS_ID_REP FOREIGN KEY (POBJECTS_ID_REP)
	  REFERENCES POBJECTS (ID) ,
	 CONSTRAINT REPORT_SCREENS_ID FOREIGN KEY (SCREENS_ID)
	  REFERENCES SCREENS (ID) ,
	 CONSTRAINT REPORT_USRGRPS_ID FOREIGN KEY (USRGRPS_ID)
	  REFERENCES USRGRPS (ID) ,
	 CONSTRAINT REPORT_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
	  REFERENCES PERSONS (ID)
   )
  ;

create sequence REPORTS_seq
;


CREATE
OR REPLACE  VIEW R_REPORTS (
  REPORT_CONTENTS
  , REPORT_POBJECT_ID_REP
  , POBJECT_CODE_REP
  , POBJECT_OBJECTTYPE_REP
  , POBJECT_ID_REP
  , POBJECT_CONTENTS_REP
  , ID
  , REPORT_ID
  , REPORT_REMARK
  , REPORT_EXPIREDATE
  , REPORT_UPDATE_IP
  , REPORT_CREATED_AT
  , REPORT_UPDATED_AT
  , REPORT_PERSON_ID_UPD
  , UPDPERSON_ID_UPD
  , UPDPERSON_CODE_UPD
  , UPDPERSON_NAME_UPD
  , REPORT_SCREEN_ID
  , SCREEN_STRWHERE
  , SCREEN_ROWS_PER_PAGE
  , SCREEN_ROWLIST
  , SCREEN_HEIGHT
  , SCREEN_POBJECT_ID_VIEW
  , POBJECT_CODE_VIEW
  , POBJECT_OBJECTTYPE_VIEW
  , POBJECT_ID_VIEW
  , POBJECT_CONTENTS_VIEW
  , SCREEN_FORM_PS
  , SCREEN_STRSELECT
  , SCREEN_CDRFLAYOUT
  , SCREEN_YMLCODE
  , SCREEN_ID
  , SCREEN_GRPCODENAME
  , SCREEN_POBJECT_ID_SCR
  , POBJECT_CODE_SCR
  , POBJECT_OBJECTTYPE_SCR
  , POBJECT_ID_SCR
  , POBJECT_CONTENTS_SCR
  , SCREEN_CONTENTS
  , SCREEN_SCRLV_ID
  , SCRLV_LEVEL1
  , SCRLV_ID
  , SCRLV_CODE
  , REPORT_FILENAME
  , REPORT_USRGRP_ID
  , USRGRP_NAME
  , USRGRP_CODE
  , USRGRP_ID
) AS
select
  report.contents report_contents
  , report.pobjects_id_rep report_pobject_id_rep
  , pobject_rep.pobject_code pobject_code_rep
  , pobject_rep.pobject_objecttype pobject_objecttype_rep
  , pobject_rep.pobject_id pobject_id_rep
  , pobject_rep.pobject_contents pobject_contents_rep
  , report.id id
  , report.id report_id
  , report.remark report_remark
  , report.expiredate report_expiredate
  , report.update_ip report_update_ip
  , report.created_at report_created_at
  , report.updated_at report_updated_at
  , report.persons_id_upd report_person_id_upd
  , person_upd.person_id_upd updperson_id_upd
  , person_upd.person_code_upd updperson_code_upd
  , person_upd.person_name_upd updperson_name_upd
  , report.screens_id report_screen_id
  , screen.screen_strwhere screen_strwhere
  , screen.screen_rows_per_page screen_rows_per_page
  , screen.screen_rowlist screen_rowlist
  , screen.screen_height screen_height
  , screen.screen_pobject_id_view screen_pobject_id_view
  , screen.pobject_code_view pobject_code_view
  , screen.pobject_objecttype_view pobject_objecttype_view
  , screen.pobject_id_view pobject_id_view
  , screen.pobject_contents_view pobject_contents_view
  , screen.screen_form_ps screen_form_ps
  , screen.screen_strselect screen_strselect
  , screen.screen_cdrflayout screen_cdrflayout
  , screen.screen_ymlcode screen_ymlcode
  , screen.screen_id screen_id
  , screen.screen_grpcodename screen_grpcodename
  , screen.screen_pobject_id_scr screen_pobject_id_scr
  , screen.pobject_code_scr pobject_code_scr
  , screen.pobject_objecttype_scr pobject_objecttype_scr
  , screen.pobject_id_scr pobject_id_scr
  , screen.pobject_contents_scr pobject_contents_scr
  , screen.screen_contents screen_contents
  , screen.screen_scrlv_id screen_scrlv_id
  , screen.scrlv_level1 scrlv_level1
  , screen.scrlv_id scrlv_id
  , screen.scrlv_code scrlv_code
  , report.filename report_filename
  , report.USRGRPs_id report_USRGRP_id
  , USRGRP.USRGRP_name USRGRP_name
  , USRGRP.USRGRP_code USRGRP_code
  , USRGRP.USRGRP_id USRGRP_id
from
  reports report
  , r_pobjects pobject_rep
  , upd_persons person_upd
  , r_screens screen
  , r_USRGRPs USRGRP
where
  pobject_rep.id = report.pobjects_id_rep
  and person_upd.id = report.persons_id_upd
  and screen.id = report.screens_id
  and USRGRP.id = report.USRGRPs_id
;
CREATE TABLE BLKUKYS
   (	ID numeric(38,0),
  contents varchar(4000),
 REMARK varchar(4000),
	EXPIREDATE DATE,
	PERSONS_ID_UPD numeric(38,0),
	UPDATE_IP varchar(40),
	CREATED_AT TIMESTAMP (6),
	UPDATED_AT TIMESTAMP (6),
	SEQNO numeric(38,0),
	TBLFIELDS_ID numeric(38,0),
	GRP varchar(10),
	 CONSTRAINT BLKUKYS_ID_PK PRIMARY KEY (ID)
  ,
	 CONSTRAINT BLKUKYS_UKYS1 UNIQUE (GRP, TBLFIELDS_ID)
  ,
	 CONSTRAINT BLKUKY_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
	  REFERENCES PERSONS (ID) ,
	 CONSTRAINT BLKUKY_TBLFIELDS_ID FOREIGN KEY (TBLFIELDS_ID)
	  REFERENCES TBLFIELDS (ID)
   )
  ;


create sequence BLKUKYS_seq
;
  
CREATE
OR REPLACE  VIEW R_BLKUKYS (
  BLKUKY_GRP
  , ID
  , BLKUKY_ID
  , BLKUKY_contents
  , BLKUKY_REMARK
  , BLKUKY_EXPIREDATE
  , BLKUKY_UPDATE_IP
  , BLKUKY_CREATED_AT
  , BLKUKY_UPDATED_AT
  , BLKUKY_PERSON_ID_UPD
  , PERSON_ID_UPD
  , PERSON_CODE_UPD
  , PERSON_NAME_UPD
  , BLKUKY_SEQNO
  , BLKUKY_TBLFIELD_ID
  , TBLFIELD_SEQNO
  , TBLFIELD_FIELDCODE_ID
  , FIELDCODE_SEQNO
  , FIELDCODE_FTYPE
  , FIELDCODE_DATASCALE
  , FIELDCODE_DATAPRECISION
  , FIELDCODE_FIELDLENGTH
  , FIELDCODE_ID
  , FIELDCODE_CONTENTS
  , FIELDCODE_POBJECT_ID_FLD
  , POBJECT_CODE_FLD
  , POBJECT_OBJECTTYPE_FLD
  , POBJECT_ID_FLD
  , TBLFIELD_BLKTB_ID
  , BLKTB_ID
  , BLKTB_POBJECT_ID_TBL
  , POBJECT_CODE_TBL
  , POBJECT_OBJECTTYPE_TBL
  , POBJECT_ID_TBL
  , BLKTB_SELTBLS
  , TBLFIELD_ID
  , TBLFIELD_CONTENTS
  , TBLFIELD_VIEWFLMK
) AS
select
  blkuky.grp blkuky_grp
  , blkuky.id id
  , blkuky.id blkuky_id
  , blkuky.contents blkuky_contents
  , blkuky.remark blkuky_remark
  , blkuky.expiredate blkuky_expiredate
  , blkuky.update_ip blkuky_update_ip
  , blkuky.created_at blkuky_created_at
  , blkuky.updated_at blkuky_updated_at
  , blkuky.persons_id_upd blkuky_person_id_upd
  , person_upd.person_id_upd person_id_upd
  , person_upd.person_code_upd person_code_upd
  , person_upd.person_name_upd person_name_upd
  , blkuky.seqno blkuky_seqno
  , blkuky.TBLFIELDS_id blkuky_TBLFIELD_ID
  , TBLFIELD.TBLFIELD_seqno TBLFIELD_seqno
  , TBLFIELD.TBLFIELD_fieldcode_id TBLFIELD_fieldcode_id
  , TBLFIELD.fieldcode_seqno fieldcode_seqno
  , TBLFIELD.fieldcode_ftype fieldcode_ftype
  , TBLFIELD.fieldcode_datascale fieldcode_datascale
  , TBLFIELD.fieldcode_dataprecision fieldcode_dataprecision
  , TBLFIELD.fieldcode_fieldlength fieldcode_fieldlength
  , TBLFIELD.fieldcode_id fieldcode_id
  , TBLFIELD.fieldcode_contents fieldcode_contents
  , TBLFIELD.fieldcode_pobject_id_fld fieldcode_pobject_id_fld
  , TBLFIELD.pobject_code_fld pobject_code_fld
  , TBLFIELD.pobject_objecttype_fld pobject_objecttype_fld
  , TBLFIELD.pobject_id_fld pobject_id_fld
  , TBLFIELD.TBLFIELD_blktb_id TBLFIELD_blktb_id
  , TBLFIELD.blktb_id blktb_id
  , TBLFIELD.blktb_pobject_id_tbl blktb_pobject_id_tbl
  , TBLFIELD.pobject_code_tbl pobject_code_tbl
  , TBLFIELD.pobject_objecttype_tbl pobject_objecttype_tbl
  , TBLFIELD.pobject_id_tbl pobject_id_tbl
  , TBLFIELD.blktb_seltbls blktb_seltbls
  , TBLFIELD.TBLFIELD_ID TBLFIELD_ID
  , TBLFIELD.TBLFIELD_contents TBLFIELD_contents
  , TBLFIELD.TBLFIELD_viewflmk TBLFIELD_viewflmk
from
  blkukys blkuky
  , upd_persons person_upd
  , r_TBLFIELDS TBLFIELD
where
  person_upd.id = blkuky.persons_id_upd
  and TBLFIELD.id = blkuky.TBLFIELDS_id

;


CREATE TABLE TBLINKS
   (	ID numeric(38,0),
	REMARK varchar(4000),
	EXPIREDATE DATE,
	PERSONS_ID_UPD numeric(38,0),
	UPDATE_IP varchar(40),
	CREATED_AT TIMESTAMP (6),
	UPDATED_AT TIMESTAMP (6),
	BLKTBS_ID_DEST numeric(38,0),
	SCREENS_ID_SRC numeric(38,0),
	SEQNO numeric(38,0),
	BEFOREAFTER varchar(15),
	CONTENTS varchar(4000),
	HIKISU varchar(400),
	CODEL varchar(50),
	 CONSTRAINT TBLINKS_ID_PK PRIMARY KEY (ID)
  ,
	 CONSTRAINT TBLINKS_UKYS1 UNIQUE (SCREENS_ID_SRC, BLKTBS_ID_DEST, BEFOREAFTER, SEQNO)
  ,
	 CONSTRAINT TBLINK_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
	  REFERENCES PERSONS (ID) ,
	 CONSTRAINT TBLINK_BLKTBS_ID_DEST FOREIGN KEY (BLKTBS_ID_DEST)
	  REFERENCES BLKTBS (ID) ,
	 CONSTRAINT TBLINK_SCREENS_ID_SRC FOREIGN KEY (SCREENS_ID_SRC)
	  REFERENCES SCREENS (ID)
   )
  ;

create sequence TBLINKS_seq
;
  
  
CREATE
OR REPLACE  VIEW R_TBLINKS (
  TBLINK_CONTENTS
  , ID
  , TBLINK_ID
  , TBLINK_REMARK
  , TBLINK_EXPIREDATE
  , TBLINK_UPDATE_IP
  , TBLINK_CREATED_AT
  , TBLINK_UPDATED_AT
  , TBLINK_PERSON_ID_UPD
  , PERSON_ID_UPD
  , PERSON_CODE_UPD
  , PERSON_NAME_UPD
  , TBLINK_CODEL
  , TBLINK_SEQNO
  , TBLINK_BLKTB_ID_DEST
  , BLKTB_CONTENTS_DEST
  , BLKTB_ID_DEST
  , BLKTB_POBJECT_ID_TBL_DEST
  , POBJECT_CODE_TBL_DEST
  , POBJECT_OBJECTTYPE_TBL_DEST
  , POBJECT_ID_TBL_DEST
  , POBJECT_CONTENTS_TBL_DEST
  , BLKTB_SELTBLS_DEST
  , TBLINK_BEFOREAFTER
  , TBLINK_HIKISU
  , TBLINK_SCREEN_ID_SRC
  , SCREEN_STRWHERE_SRC
  , SCREEN_ROWS_PER_PAGE_SRC
  , SCREEN_ROWLIST_SRC
  , SCREEN_HEIGHT_SRC
  , SCREEN_POBJECT_ID_VIEW_SRC
  , POBJECT_CODE_VIEW_SRC
  , POBJECT_OBJECTTYPE_VIEW_SRC
  , POBJECT_ID_VIEW_SRC
  , POBJECT_CONTENTS_VIEW_SRC
  , SCREEN_FORM_PS_SRC
  , SCREEN_STRSELECT_SRC
  , SCREEN_CDRFLAYOUT_SRC
  , SCREEN_YMLCODE_SRC
  , SCREEN_ID_SRC
  , SCREEN_GRPCODENAME_SRC
  , SCREEN_POBJECT_ID_SCR_SRC
  , POBJECT_CODE_SCR_SRC
  , POBJECT_OBJECTTYPE_SCR_SRC
  , POBJECT_ID_SCR_SRC
  , POBJECT_CONTENTS_SCR_SRC
  , SCREEN_CONTENTS_SRC
  , SCREEN_SCRLV_ID_SRC
  , SCRLV_LEVEL1_SRC
  , SCRLV_ID_SRC
  , SCRLV_CODE_SRC
) AS
select
  tblink.contents tblink_contents
  , tblink.id id
  , tblink.id tblink_id
  , tblink.remark tblink_remark
  , tblink.expiredate tblink_expiredate
  , tblink.update_ip tblink_update_ip
  , tblink.created_at tblink_created_at
  , tblink.updated_at tblink_updated_at
  , tblink.persons_id_upd tblink_person_id_upd
  , person_upd.person_id_upd person_id_upd
  , person_upd.person_code_upd person_code_upd
  , person_upd.person_name_upd person_name_upd
  , tblink.codel tblink_codel
  , tblink.seqno tblink_seqno
  , tblink.blktbs_id_dest tblink_blktb_id_dest
  , blktb_dest.blktb_contents blktb_contents_dest
  , blktb_dest.blktb_id blktb_id_dest
  , blktb_dest.blktb_pobject_id_tbl blktb_pobject_id_tbl_dest
  , blktb_dest.pobject_code_tbl pobject_code_tbl_dest
  , blktb_dest.pobject_objecttype_tbl pobject_objecttype_tbl_dest
  , blktb_dest.pobject_id_tbl pobject_id_tbl_dest
  , blktb_dest.pobject_contents_tbl pobject_contents_tbl_dest
  , blktb_dest.blktb_seltbls blktb_seltbls_dest
  , tblink.beforeafter tblink_beforeafter
  , tblink.hikisu tblink_hikisu
  , tblink.screens_id_src tblink_screen_id_src
  , screen_src.screen_strwhere screen_strwhere_src
  , screen_src.screen_rows_per_page screen_rows_per_page_src
  , screen_src.screen_rowlist screen_rowlist_src
  , screen_src.screen_height screen_height_src
  , screen_src.screen_pobject_id_view screen_pobject_id_view_src
  , screen_src.pobject_code_view pobject_code_view_src
  , screen_src.pobject_objecttype_view pobject_objecttype_view_src
  , screen_src.pobject_id_view pobject_id_view_src
  , screen_src.pobject_contents_view pobject_contents_view_src
  , screen_src.screen_form_ps screen_form_ps_src
  , screen_src.screen_strselect screen_strselect_src
  , screen_src.screen_cdrflayout screen_cdrflayout_src
  , screen_src.screen_ymlcode screen_ymlcode_src
  , screen_src.screen_id screen_id_src
  , screen_src.screen_grpcodename screen_grpcodename_src
  , screen_src.screen_pobject_id_scr screen_pobject_id_scr_src
  , screen_src.pobject_code_scr pobject_code_scr_src
  , screen_src.pobject_objecttype_scr pobject_objecttype_scr_src
  , screen_src.pobject_id_scr pobject_id_scr_src
  , screen_src.pobject_contents_scr pobject_contents_scr_src
  , screen_src.screen_contents screen_contents_src
  , screen_src.screen_scrlv_id screen_scrlv_id_src
  , screen_src.scrlv_level1 scrlv_level1_src
  , screen_src.scrlv_id scrlv_id_src
  , screen_src.scrlv_code scrlv_code_src
from
  tblinks tblink
  , upd_persons person_upd
  , r_blktbs blktb_dest
  , r_screens screen_src
where
  person_upd.id = tblink.persons_id_upd
  and blktb_dest.id = tblink.blktbs_id_dest
  and screen_src.id = tblink.screens_id_src
  ;
CREATE TABLE TBLINKFLDS
   (	ID numeric(38,0),
	REMARK varchar(4000),
	EXPIREDATE DATE,
	PERSONS_ID_UPD numeric(38,0),
	UPDATE_IP varchar(40),
	CREATED_AT TIMESTAMP (6),
	UPDATED_AT TIMESTAMP (6),
	COMMAND_C varchar(4000),
	TBLINKS_ID numeric(38,0),
	TBLFIELDS_ID numeric(38,0),
	SEQNO numeric(38,0),
	CONTENTS varchar(4000),
	RUBYCODE varchar(4000),
	 CONSTRAINT TBLINKFLDS_ID_PK PRIMARY KEY (ID)
  ,
	 CONSTRAINT TBLINKFLDS_UKYS10 UNIQUE (TBLINKS_ID, TBLFIELDS_ID)
  ,
	 CONSTRAINT TBLINKFLD_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
	  REFERENCES PERSONS (ID) ,
	 CONSTRAINT TBLINKFLD_TBLINKS_ID FOREIGN KEY (TBLINKS_ID)
	  REFERENCES TBLINKS (ID) ,
	 CONSTRAINT TBLINKFLD_TBLFIELDS_ID FOREIGN KEY (TBLFIELDS_ID)
	  REFERENCES TBLFIELDS (ID)
   )
  ;


create sequence TBLINKFLDS_seq
;
  
COMMIT
;