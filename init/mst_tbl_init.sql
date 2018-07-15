
  CREATE TABLE SHELFNOS
   (	CONTENTS varchar(4000),
	REMARK varchar(4000),
	EXPIREDATE DATE,
	PERSONS_ID_UPD numeric(38,0),
	CREATED_AT TIMESTAMP (6),
	UPDATED_AT TIMESTAMP (6),
	CODE varchar(50),
	ID numeric(38,0),
	LOCAS_ID_SHELFNO numeric(38,0),
	NAME varchar(100),
	UPDATE_IP varchar(40),
	 CONSTRAINT SHELFNOS_ID_PK PRIMARY KEY (ID)
  ,
	 CONSTRAINT SHELFNO_LOCAS_ID_SHELFNO FOREIGN KEY (LOCAS_ID_SHELFNO)
	  REFERENCES LOCAS (ID) ,
	 CONSTRAINT SHELFNO_PERSONS_ID_UPD FOREIGN KEY (PERSONS_ID_UPD)
	  REFERENCES PERSONS (ID)
   );


  CREATE OR REPLACE  VIEW R_SHELFNOS (SHELFNO_CODE, SHELFNO_EXPIREDATE, SHELFNO_UPDATED_AT, SHELFNO_NAME, SHELFNO_REMARK, SHELFNO_CREATED_AT, SHELFNO_UPDATE_IP, ID, SHELFNO_ID, SHELFNO_PERSON_ID_UPD, PERSON_ID_UPD, PERSON_CODE_UPD, PERSON_NAME_UPD, SHELFNO_CONTENTS, SHELFNO_LOCA_ID_SHELFNO, LOCA_ID_SHELFNO, LOCA_EXPIREDATE_SHELFNO, LOCA_CODE_SHELFNO, LOCA_NAME_SHELFNO, LOCA_ABBR_SHELFNO, LOCA_ZIP_SHELFNO, LOCA_COUNTRY_SHELFNO, LOCA_PRFCT_SHELFNO, LOCA_ADDR1_SHELFNO, LOCA_ADDR2_SHELFNO, LOCA_TEL_SHELFNO, LOCA_FAX_SHELFNO, LOCA_MAIL_SHELFNO) AS
  select shelfno.code shelfno_code ,shelfno.expiredate shelfno_expiredate ,shelfno.updated_at shelfno_updated_at ,shelfno.name shelfno_name ,shelfno.remark shelfno_remark ,shelfno.created_at shelfno_created_at ,shelfno.update_ip shelfno_update_ip ,shelfno.id id,shelfno.id shelfno_id ,shelfno.persons_id_upd shelfno_person_id_upd , person_upd.person_id_upd person_id_upd, person_upd.person_code_upd person_code_upd, person_upd.person_name_upd person_name_upd,shelfno.contents shelfno_contents ,shelfno.locas_id_shelfno shelfno_loca_id_shelfno , loca_shelfno.loca_id loca_id_shelfno, loca_shelfno.loca_expiredate loca_expiredate_shelfno, loca_shelfno.loca_code loca_code_shelfno, loca_shelfno.loca_name loca_name_shelfno, loca_shelfno.loca_abbr loca_abbr_shelfno, loca_shelfno.loca_zip loca_zip_shelfno, loca_shelfno.loca_country loca_country_shelfno, loca_shelfno.loca_prfct loca_prfct_shelfno, loca_shelfno.loca_addr1 loca_addr1_shelfno, loca_shelfno.loca_addr2 loca_addr2_shelfno, loca_shelfno.loca_tel loca_tel_shelfno, loca_shelfno.loca_fax loca_fax_shelfno, loca_shelfno.loca_mail loca_mail_shelfno
 from shelfnos shelfno ,upd_persons  person_upd,r_locas  loca_shelfno
 where  person_upd.id = shelfno.persons_id_upd and  loca_shelfno.id = shelfno.locas_id_shelfno;


---drop sequence shelfnos_seq
;
create sequence shelfnos_seq
;
insert into  shelfnos(id,code,name, Expiredate,Persons_id_Upd)
values(0,'0','none','2099/12/31',0)
;
