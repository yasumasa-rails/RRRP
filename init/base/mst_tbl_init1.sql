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
CREATE TABLE sio.SIO_R_ITMS 
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

create SEQUENCE itms_seq
;

create SEQUENCE units_seq
;

create SEQUENCE sio.sio_r_itms_seq
;

create SEQUENCE sio.sio_r_unit_seq
;


  copy units(ID,CODE,NAME,REMARK,PERSONS_ID_UPD,EXPIREDATE,UPDATE_IP,CREATED_AT,UPDATED_AT,CONTENTS)  FROM '/mnt/c/ubuntu/RRRP/init/v10data/units.csv' CSV HEADER ;

  copy itms(ID,CODE,NAME,UNITS_ID,STD,MODEL,MATERIAL,DESIGN,WEIGHT,LENGTH,WIDE,DETH,REMARK,EXPIREDATE,PERSONS_ID_UPD,UPDATE_IP,CREATED_AT,UPDATED_AT,DATASCALE)  FROM '/mnt/c/ubuntu/RRRP/init/v10data/itms.csv' CSV HEADER ;


-- Table: public.nditms

-- DROP TABLE public.nditms;

CREATE TABLE public.nditms
(
  id numeric(38,0) NOT NULL,
  opeitms_id numeric(38,0),
  itms_id_nditm numeric(38,0),
  locas_id_nditm numeric(38,0),
  processseq_nditm numeric(38,0),
  parenum numeric(38,0),
  chilnum numeric(38,0),
  duration numeric(38,2),
  consumtype character(3),
  consumauto character(1),
  minqty numeric(38,6),
  consumunitqty numeric(38,0),
  remark character varying(4000),
  expiredate date,
  persons_id_upd numeric(38,0),
  update_ip character varying(40),
  created_at timestamp(6) without time zone,
  updated_at timestamp(6) without time zone,
  CONSTRAINT nditms_id_pk PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.nditms
  OWNER TO v10_development;

drop sequence  if exists nditms_seq ;
create sequence nditms_seq ;

create or replace view r_nditms as select  
nditm.remark  nditm_remark,
nditm.created_at  nditm_created_at,
nditm.update_ip  nditm_update_ip,
nditm.minqty  nditm_minqty,
nditm.expiredate  nditm_expiredate,
nditm.consumtype  nditm_consumtype,
nditm.updated_at  nditm_updated_at,
nditm.id id,
nditm.persons_id_upd   nditm_person_id_upd,
nditm.duration  nditm_duration,
nditm.opeitms_id   nditm_opeitm_id,
nditm.itms_id_nditm   nditm_itm_id_nditm,
nditm.parenum  nditm_parenum,
nditm.chilnum  nditm_chilnum,
nditm.consumunitqty  nditm_consumunitqty,
nditm.locas_id_nditm   nditm_loca_id_nditm,
nditm.consumauto  nditm_consumauto,
nditm.processseq_nditm  nditm_processseq_nditm,
  opeitm.opeitm_processseq  opeitm_processseq ,
  opeitm.opeitm_priority  opeitm_priority ,
  opeitm.opeitm_duration  opeitm_duration ,
  opeitm.opeitm_minqty  opeitm_minqty ,
  opeitm.opeitm_packqty  opeitm_packqty ,
  opeitm.opeitm_maxqty  opeitm_maxqty ,
  opeitm.opeitm_opt_fixoterm  opeitm_opt_fixoterm ,
  opeitm.opeitm_safestkqty  opeitm_safestkqty ,
  opeitm.opeitm_prjalloc_flg  opeitm_prjalloc_flg ,
  opeitm.opeitm_consumunitqty  opeitm_consumunitqty ,
  opeitm.opeitm_chkord_prc  opeitm_chkord_prc ,
  opeitm.opeitm_esttosch  opeitm_esttosch ,
  opeitm.opeitm_parenum  opeitm_parenum ,
  opeitm.opeitm_chilnum  opeitm_chilnum ,
  opeitm.opeitm_autoord_p  opeitm_autoord_p ,
  opeitm.unit_code  unit_code ,
  opeitm.unit_code_box  unit_code_box ,
  opeitm.unit_code_outbox  unit_code_outbox ,
  opeitm.loca_code_shelfno  loca_code_shelfno ,
  opeitm.loca_name_shelfno  loca_name_shelfno ,
  opeitm.itm_expiredate  itm_expiredate ,
  opeitm.opeitm_operation  opeitm_operation ,
  opeitm.opeitm_remark  opeitm_remark ,
  opeitm.opeitm_prdpurshp  opeitm_prdpurshp ,
  opeitm.opeitm_contents  opeitm_contents ,
  opeitm.itm_deth  itm_deth ,
  opeitm.opeitm_qty_pur  opeitm_qty_pur ,
  opeitm.opeitm_autoact_p  opeitm_autoact_p ,
  opeitm.itm_name  itm_name ,
  opeitm.loca_code  loca_code ,
  opeitm.loca_name  loca_name ,
  opeitm.itm_code  itm_code ,
  opeitm.opeitm_autocreate_ord  opeitm_autocreate_ord ,
  opeitm.unit_code_case  unit_code_case ,
  opeitm.unit_name_case  unit_name_case ,
  opeitm.opeitm_autocreate_inst  opeitm_autocreate_inst ,
  opeitm.opeitm_autocreate_act  opeitm_autocreate_act ,
  opeitm.opeitm_stktaking_f  opeitm_stktaking_f ,
  opeitm.opeitm_shuffle_flg  opeitm_shuffle_flg ,
  opeitm.opeitm_shuffle_loca  opeitm_shuffle_loca ,
  opeitm.opeitm_chkord  opeitm_chkord ,
  opeitm.opeitm_rule_price  opeitm_rule_price ,
  opeitm.opeitm_chkinst  opeitm_chkinst ,
  opeitm.opeitm_mold  opeitm_mold ,
  opeitm.boxe_code  boxe_code ,
  opeitm.unit_name_outbox  unit_name_outbox ,
  opeitm.unit_name  unit_name ,
  opeitm.boxe_name  boxe_name ,
  opeitm.unit_name_box  unit_name_box ,
  opeitm.opeitm_opt_fix_flg  opeitm_opt_fix_flg ,
  opeitm.opeitm_packno_flg  opeitm_packno_flg ,
  opeitm.opeitm_units_lttime  opeitm_units_lttime ,
  opeitm.opeitm_consumtype  opeitm_consumtype ,
  opeitm.opeitm_consumauto  opeitm_consumauto ,
  opeitm.shelfno_code  shelfno_code ,
  opeitm.shelfno_name  shelfno_name ,
  opeitm.unit_code_case_pur  unit_code_case_pur ,
  opeitm.unit_name_case_pur  unit_name_case_pur ,
  itm_nditm.itm_weight  itm_weight_nditm ,
  itm_nditm.itm_length  itm_length_nditm ,
  itm_nditm.itm_wide  itm_wide_nditm ,
  itm_nditm.itm_deth  itm_deth_nditm ,
  itm_nditm.itm_datascale  itm_datascale_nditm ,
  itm_nditm.unit_code  unit_code_nditm ,
  itm_nditm.itm_material  itm_material_nditm ,
  itm_nditm.itm_remark  itm_remark_nditm ,
  itm_nditm.itm_std  itm_std_nditm ,
  itm_nditm.itm_model  itm_model_nditm ,
  itm_nditm.itm_design  itm_design_nditm ,
  itm_nditm.itm_code  itm_code_nditm ,
  itm_nditm.itm_name  itm_name_nditm ,
  itm_nditm.unit_name  unit_name_nditm ,
  loca_nditm.loca_code  loca_code_nditm ,
  loca_nditm.loca_country  loca_country_nditm ,
  loca_nditm.loca_abbr  loca_abbr_nditm ,
  loca_nditm.loca_prfct  loca_prfct_nditm ,
  loca_nditm.loca_tel  loca_tel_nditm ,
  loca_nditm.loca_remark  loca_remark_nditm ,
  loca_nditm.loca_mail  loca_mail_nditm ,
  loca_nditm.loca_addr1  loca_addr1_nditm ,
  loca_nditm.loca_zip  loca_zip_nditm ,
  loca_nditm.loca_fax  loca_fax_nditm ,
  loca_nditm.loca_addr2  loca_addr2_nditm ,
  loca_nditm.loca_name  loca_name_nditm 
 from nditms   nditm,
  r_persons  person_upd ,  r_opeitms  opeitm ,  r_itms  itm_nditm ,  r_locas  loca_nditm 
  where       nditm.persons_id_upd = person_upd.id      and nditm.opeitms_id = opeitm.id      and nditm.itms_id_nditm = itm_nditm.id      and nditm.locas_id_nditm = loca_nditm.id     ;
 DROP TABLE IF EXISTS sio.sio_r_nditms;
 CREATE TABLE sio.sio_r_nditms (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_nditms_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,nditm_remark  varchar (4000) 
,nditm_created_at   timestamp(6) 
,nditm_update_ip  varchar (40) 
,nditm_minqty  numeric (38,6)
,nditm_expiredate   date 
,nditm_consumtype  varchar (3) 
,nditm_updated_at   timestamp(6) 
,id  numeric (38,0)
,nditm_person_id_upd  numeric (38,0)
,nditm_duration  numeric (38,2)
,nditm_opeitm_id  numeric (38,0)
,nditm_itm_id_nditm  numeric (38,0)
,nditm_parenum  numeric (38,0)
,nditm_chilnum  numeric (38,0)
,nditm_consumunitqty  numeric (38,0)
,nditm_loca_id_nditm  numeric (38,0)
,nditm_consumauto  varchar (1) 
,nditm_processseq_nditm  numeric (38,0)
,opeitm_processseq  numeric (3,0)
,opeitm_priority  numeric (3,0)
,opeitm_duration  numeric (38,2)
,opeitm_minqty  numeric (38,6)
,opeitm_packqty  numeric (38,0)
,opeitm_maxqty  numeric (22,0)
,opeitm_opt_fixoterm  numeric (5,2)
,opeitm_safestkqty  numeric (38,0)
,opeitm_prjalloc_flg  numeric (22,0)
,opeitm_consumunitqty  numeric (22,0)
,opeitm_chkord_prc  numeric (3,0)
,opeitm_esttosch  numeric (22,0)
,opeitm_parenum  numeric (22,0)
,opeitm_chilnum  numeric (22,0)
,opeitm_autoord_p  numeric (3,0)
,unit_code  varchar (50) 
,unit_code_box  varchar (50) 
,unit_code_outbox  varchar (50) 
,loca_code_shelfno  varchar (50) 
,loca_name_shelfno  varchar (100) 
,itm_expiredate   date 
,opeitm_operation  varchar (40) 
,opeitm_remark  varchar (200) 
,opeitm_prdpurshp  varchar (3) 
,opeitm_contents  varchar (4000) 
,itm_deth  numeric (22,0)
,opeitm_qty_pur  numeric (22,0)
,opeitm_autoact_p  numeric (3,0)
,itm_name  varchar (50) 
,loca_code  varchar (200) 
,loca_name  varchar (100) 
,itm_code  varchar (200) 
,opeitm_autocreate_ord  varchar (1) 
,unit_code_case  varchar (200) 
,unit_name_case  varchar (50) 
,opeitm_autocreate_inst  varchar (1) 
,opeitm_autocreate_act  varchar (1) 
,opeitm_stktaking_f  varchar (1) 
,opeitm_shuffle_flg  varchar (1) 
,opeitm_shuffle_loca  varchar (1) 
,opeitm_chkord  varchar (1) 
,opeitm_rule_price  varchar (1) 
,opeitm_chkinst  varchar (1) 
,opeitm_mold  varchar (1) 
,boxe_code  varchar (50) 
,unit_name_outbox  varchar (100) 
,unit_name  varchar (100) 
,boxe_name  varchar (100) 
,unit_name_box  varchar (10) 
,opeitm_opt_fix_flg  varchar (1) 
,opeitm_packno_flg  varchar (1) 
,opeitm_units_lttime  varchar (4) 
,opeitm_consumtype  varchar (3) 
,opeitm_consumauto  varchar (1) 
,shelfno_code  varchar (50) 
,shelfno_name  varchar (100) 
,unit_code_case_pur  varchar (50) 
,unit_name_case_pur  varchar (100) 
,itm_weight_nditm  numeric (22,0)
,itm_length_nditm  numeric (22,0)
,itm_wide_nditm  numeric (22,0)
,itm_deth_nditm  numeric (22,0)
,itm_datascale_nditm  numeric (22,0)
,unit_code_nditm  varchar (200) 
,itm_material_nditm  varchar (50) 
,itm_remark_nditm  varchar (100) 
,itm_std_nditm  varchar (50) 
,itm_model_nditm  varchar (50) 
,itm_design_nditm  varchar (50) 
,itm_code_nditm  varchar (40) 
,itm_name_nditm  varchar (50) 
,unit_name_nditm  varchar (10) 
,loca_code_nditm  varchar (40) 
,loca_country_nditm  varchar (20) 
,loca_abbr_nditm  varchar (50) 
,loca_prfct_nditm  varchar (20) 
,loca_tel_nditm  varchar (20) 
,loca_remark_nditm  varchar (100) 
,loca_mail_nditm  varchar (20) 
,loca_addr1_nditm  varchar (50) 
,loca_zip_nditm  varchar (10) 
,loca_fax_nditm  varchar (20) 
,loca_addr2_nditm  varchar (50) 
,loca_name_nditm  varchar (100) 
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
 CREATE INDEX sio.SIO_r_nditms_uk1 
  ON sio.SIO_r_nditms(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.SIO_r_nditms_seq ;
 create sequence sio.SIO_r_nditms_seq ;
