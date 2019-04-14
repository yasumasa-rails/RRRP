CREATE OR REPLACE VIEW UPD_PERSONS (ID, PERSON_ID_UPD, PERSON_CODE_UPD, PERSON_NAME_UPD) AS 
  select  person.id, person.id person_id_upd ,person.code person_code_upd,person.name person_name_upd
 from persons person
 ;



    CREATE OR REPLACE  VIEW SGRP_POBJECTS
 (POBJECT_CODE,  POBJECT_EXPIREDATE, POBJECT_UPDATED_AT,
  POBJECT_REMARK,
  POBJECT_CREATED_AT, POBJECT_UPDATE_IP, ID, POBJECT_ID,POBJECT_PERSON_ID_UPD,
 PERSON_ID_UPD, PERSON_CODE_UPD,PERSON_NAME_UPD,
 POBJECT_CONTENTS) AS
   select
   pobject.code pobject_code
   , pobject.expiredate pobject_expiredate
   , pobject.updated_at pobject_updated_at
   , pobject.remark pobject_remark
   , pobject.created_at pobject_created_at
   , pobject.update_ip pobject_update_ip
   , pobject.id id  , pobject.id pobject_id
   , pobject.PERSONS_ID_UPD pobject_person_id_upd
   , person_upd.id person_id_upd
   , person_upd.code person_code_upd
   , person_upd.name person_name_upd
   , pobject.contents pobject_contents
 from
   pobjects pobject
   , persons person_upd
 where
   person_upd.id = pobject.persons_id_upd
   and pobject.objecttype = 'screen_group'
   ;

--------------------------
CREATE OR REPLACE VIEW R_SCREENS (SCREEN_POBJECT_ID_VIEW, POBJECT_CODE_VIEW, 
                                   POBJECT_OBJECTTYPE_VIEW,
                                   POBJECT_EXPIREDATE_VIEW,  POBJECT_ID_VIEW,
                                   POBJECT_CONTENTS_VIEW, 
                                   SCREEN_FORM_PS, SCREEN_ROWS_PER_PAGE,
                                   SCREEN_ROWLIST,
                                   SCREEN_HEIGHT, SCREEN_STRSELECT,
                                   SCREEN_STRWHERE,
                                   SCREEN_STRGROUPORDER, SCREEN_YMLCODE,
                                   SCREEN_CDRFLAYOUT,
                                   SCREEN_CONTENTS, 
                                   ID, SCREEN_ID,
                                   SCREEN_REMARK, SCREEN_EXPIREDATE,
                                   SCREEN_UPDATE_IP,
                                   SCREEN_CREATED_AT, SCREEN_UPDATED_AT,
                                   SCREEN_PERSON_ID_UPD,
                                   PERSON_ID_UPD, PERSON_CODE_UPD,
                                   PERSON_NAME_UPD,
                                   SCREEN_POBJECT_ID_SCR, POBJECT_CODE_SCR,
                                   POBJECT_OBJECTTYPE_SCR,
                                   POBJECT_EXPIREDATE_SCR,  POBJECT_ID_SCR,
                                   POBJECT_CONTENTS_SCR,
                                   SCREEN_SCRLV_ID, SCRLV_LEVEL1,
                                   SCRLV_ID,
                                   SCRLV_EXPIREDATE, SCRLV_CODE,
                                   SCREEN_STRORDER,
                                   SCREEN_POBJECT_ID_SGRP, POBJECT_CODE_SGRP,
                                   POBJECT_EXPIREDATE_SGRP,  POBJECT_ID_SGRP,
                                   POBJECT_CONTENTS_SGRP,SCREEN_SEQNO) AS 
  select screen.pobjects_id_view screen_pobject_id_view , pobject_view.pobject_code pobject_code_view,
         pobject_view.pobject_objecttype pobject_objecttype_view,
         pobject_view.pobject_expiredate pobject_expiredate_view,  pobject_view.pobject_id pobject_id_view,
         pobject_view.pobject_contents pobject_contents_view,screen.form_ps screen_form_ps ,
         screen.rows_per_page screen_rows_per_page ,screen.rowlist screen_rowlist ,
         screen.height screen_height ,
         screen.strselect screen_strselect ,screen.strwhere screen_strwhere ,
         screen.strgrouporder screen_strgrouporder ,
         screen.ymlcode screen_ymlcode ,screen.cdrflayout screen_cdrflayout ,
         screen.contents screen_contents ,
         screen.id id,screen.id screen_id ,
         screen.remark screen_remark ,screen.expiredate screen_expiredate ,
         screen.update_ip screen_update_ip ,
         screen.created_at screen_created_at ,screen.updated_at screen_updated_at ,
         screen.persons_id_upd screen_person_id_upd ,
         person_upd.person_id_upd person_id_upd, person_upd.person_code_upd person_code_upd,
         person_upd.person_name_upd person_name_upd,
         screen.pobjects_id_scr screen_pobject_id_scr , pobject_scr.pobject_code pobject_code_scr,
         pobject_scr.pobject_objecttype pobject_objecttype_scr,
         pobject_scr.pobject_expiredate pobject_expiredate_scr,   pobject_scr.pobject_id pobject_id_scr,
         pobject_scr.pobject_contents pobject_contents_scr,
         screen.scrlvs_id screen_scrlv_id , scrlv.scrlv_level1 scrlv_level1, 
         scrlv.scrlv_id scrlv_id, scrlv.scrlv_expiredate scrlv_expiredate, 
         scrlv.scrlv_code scrlv_code,screen.strorder screen_strorder ,
         screen.pobjects_id_SGRP screen_pobject_id_SGRP , pobject_SGRP.pobject_code pobject_code_SGRP,
         pobject_SGRP.pobject_expiredate pobject_expiredate_SGRP,   pobject_SGRP.pobject_id pobject_id_SGRP,
         pobject_SGRP.pobject_contents pobject_contents_SGRP,SCREEN.seqno SCREEN_SEQNO
 from screens screen ,r_pobjects  pobject_view,upd_persons  person_upd,
      r_pobjects  pobject_scr,SGRP_POBJECTS pobject_sgrp,
      r_scrlvs  scrlv
 where  pobject_view.id = screen.pobjects_id_view and  person_upd.id = screen.persons_id_upd and
        pobject_scr.id = screen.pobjects_id_scr and pobject_sgrp.id = screen.pobjects_id_sgrp and
        scrlv.id = screen.scrlvs_id
;

------------------------55555555555555555555555


CREATE OR REPLACE VIEW R_POBJGRPS (POBJGRP_POBJECT_ID, POBJECT_CODE, POBJECT_OBJECTTYPE, POBJECT_ID, POBJECT_CONTENTS, 
ID, POBJGRP_ID, POBJGRP_REMARK, POBJGRP_EXPIREDATE, POBJGRP_UPDATE_IP, POBJGRP_CREATED_AT, POBJGRP_UPDATED_AT, POBJGRP_PERSON_ID_UPD,
 PERSON_ID_UPD, PERSON_CODE_UPD, PERSON_NAME_UPD, POBJGRP_NAME, POBJGRP_USRGRP_ID, USRGRP_ID, USRGRP_CODE, USRGRP_NAME, USRGRP_CONTENTS,POBJGRP_CONTENTS) AS 
  select pobjgrp.pobjects_id pobjgrp_pobject_id , pobject.pobject_code pobject_code, pobject.pobject_objecttype pobject_objecttype,  pobject.pobject_id pobject_id, pobject.pobject_contents pobject_contents,
pobjgrp.id id,pobjgrp.id pobjgrp_id ,pobjgrp.remark pobjgrp_remark ,pobjgrp.expiredate pobjgrp_expiredate ,pobjgrp.update_ip pobjgrp_update_ip ,pobjgrp.created_at pobjgrp_created_at ,
pobjgrp.updated_at pobjgrp_updated_at ,pobjgrp.persons_id_upd pobjgrp_person_id_upd , person_upd.person_id_upd person_id_upd, person_upd.person_code_upd person_code_upd,
 person_upd.person_name_upd person_name_upd,pobjgrp.name pobjgrp_name ,pobjgrp.usrgrps_id pobjgrp_usrgrp_id , usrgrp.usrgrp_id usrgrp_id, usrgrp.usrgrp_code usrgrp_code, 
usrgrp.usrgrp_name usrgrp_name, usrgrp.usrgrp_contents usrgrp_contents, pobjgrp.contents pobjgrp_contents
 from pobjgrps pobjgrp ,r_pobjects  pobject,upd_persons  person_upd,r_usrgrps  usrgrp
 where  pobject.id = pobjgrp.pobjects_id and  person_upd.id = pobjgrp.persons_id_upd and  usrgrp.id = pobjgrp.usrgrps_id
;


 CREATE OR REPLACE  VIEW R_CHRGS (
  ID
  , CHRG_ID
  , CHRG_REMARK
  , CHRG_EXPIREDATE
  , CHRG_UPDATE_IP
  , CHRG_CREATED_AT
  , CHRG_UPDATED_AT
  , CHRG_PERSON_ID_UPD
  , PERSON_ID_UPD
  , PERSON_CODE_UPD
  , PERSON_NAME_UPD
  , CHRG_PERSON_ID
  , PERSON_CODE_CHRG
  , PERSON_EXPIREDATE_CHRG
  , PERSON_NAME_CHRG
  , PERSON_REMARK_CHRG
  ,                                               ---PERSON_USRGRP_ID_CHRG,
  USRGRP_NAME_CHRG
  , USRGRP_CODE_CHRG
  ,                                               -----USRGRP_REMARK_CHRG, USRGRP_ID_CHRG,
  PERSON_EMAIL_CHRG
  , PERSON_ID_CHRG
  , PERSON_SECT_ID
  , SECT_ID
  , LOCA_ID_SECT
  , LOCA_CODE_SECT
  , LOCA_NAME_SECT
  , LOCA_ABBR_SECT
  , LOCA_ZIP_SECT
  , LOCA_COUNTRY_SECT
  , LOCA_PRFCT_SECT
  , LOCA_ADDR1_SECT
  , LOCA_ADDR2_SECT
) AS
select
  person_chrg.person_id  id
  , person_chrg.person_id  CHRG_id
  , person_chrg.person_remark  CHRG_remark
  , person_chrg.person_expiredate  CHRG_expiredate
  , person_chrg.person_update_ip  CHRG_update_ip
  , person_chrg.person_created_at  CHRG_created_at
  , person_chrg.person_updated_at  CHRG_updated_at
  , person_chrg.person_id_upd chrg_person_id_upd
  , person_upd.person_id_upd person_id_upd
  , person_upd.person_code_upd person_code_upd
  , person_upd.person_name_upd person_name_upd
  , person_chrg.person_id  CHRG_person_id_chrg
  , person_chrg.person_code person_code_chrg
  , person_chrg.person_expiredate person_expiredate_chrg
  , person_chrg.person_name person_name_chrg
  , person_chrg.person_remark person_remark_chrg
  ,person_chrg.usrgrp_name usrgrp_name_chrg
  , person_chrg.usrgrp_code usrgrp_code_chrg
  ,person_chrg.person_email person_email_chrg
  , person_chrg.person_id person_id_chrg
  , person_chrg.person_sect_id person_sect_id_chrg
  , person_chrg.sect_id sect_id_chrg
  , person_chrg.loca_id_sect loca_id_sect_chrg
  , person_chrg.loca_code_sect loca_code_sect_chrg
  , person_chrg.loca_name_sect loca_name_sect_chrg
  , person_chrg.loca_abbr_sect loca_abbr_sect_chrg
  , person_chrg.loca_zip_sect loca_zip_sect_chrg
  , person_chrg.loca_country_sect loca_country_sect_chrg
  , person_chrg.loca_prfct_sect loca_prfct_sect_chrg
  , person_chrg.loca_addr1_sect loca_addr1_sect_chrg
  , person_chrg.loca_addr2_sect loca_addr2_sect_chrg
from upd_persons person_upd
  , r_persons person_chrg
where
  person_upd.id = person_chrg.person_id_upd
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
  CREATE OR REPLACE  VIEW R_TBLINKFLDS (TBLINKFLD_EXPIREDATE, TBLINKFLD_UPDATED_AT, TBLINKFLD_SEQNO,
  TBLINKFLD_REMARK, TBLINKFLD_CREATED_AT, TBLINKFLD_UPDATE_IP, TBLINKFLD_RUBYCODE, ID, TBLINKFLD_ID, TBLINKFLD_TBLFIELD_ID,
  TBLFIELD_CONTENTS, TBLFIELD_BLKTB_ID, BLKTB_CONTENTS, BLKTB_ID, BLKTB_POBJECT_ID_TBL, POBJECT_CODE_TBL, POBJECT_OBJECTTYPE_TBL,
  POBJECT_ID_TBL, POBJECT_CONTENTS_TBL, BLKTB_SELTBLS, TBLFIELD_FIELDCODE_ID, FIELDCODE_SEQNO,
  FIELDCODE_FTYPE, FIELDCODE_DATASCALE, FIELDCODE_DATAPRECISION, FIELDCODE_FIELDLENGTH, FIELDCODE_ID, FIELDCODE_CONTENTS,
  FIELDCODE_POBJECT_ID_FLD, POBJECT_CODE_FLD, POBJECT_OBJECTTYPE_FLD, POBJECT_ID_FLD, POBJECT_CONTENTS_FLD,
  TBLFIELD_ID, TBLFIELD_EXPIREDATE, TBLFIELD_SEQNO, TBLFIELD_VIEWFLMK, TBLINKFLD_PERSON_ID_UPD, PERSON_ID_UPD, PERSON_CODE_UPD,
  PERSON_NAME_UPD, TBLINKFLD_CONTENTS, TBLINKFLD_TBLINK_ID, TBLINK_CONTENTS, TBLINK_ID, TBLINK_EXPIREDATE,
  TBLINK_SEQNO, TBLINK_BLKTB_ID_DEST, BLKTB_CONTENTS_DEST, BLKTB_ID_DEST, BLKTB_POBJECT_ID_TBL_DEST, POBJECT_CODE_TBL_DEST,
  POBJECT_OBJECTTYPE_TBL_DEST, POBJECT_ID_TBL_DEST, POBJECT_CONTENTS_TBL_DEST, BLKTB_SELTBLS_DEST,
  TBLINK_BEFOREAFTER, TBLINK_HIKISU, TBLINK_SCREEN_ID_SRC, SCREEN_STRWHERE_SRC, SCREEN_ROWS_PER_PAGE_SRC, SCREEN_ROWLIST_SRC,
  SCREEN_HEIGHT_SRC, SCREEN_POBJECT_ID_VIEW_SRC, POBJECT_CODE_VIEW_SRC, POBJECT_OBJECTTYPE_VIEW_SRC,
  POBJECT_ID_VIEW_SRC, POBJECT_CONTENTS_VIEW_SRC, SCREEN_FORM_PS_SRC,  SCREEN_STRSELECT_SRC,
  SCREEN_CDRFLAYOUT_SRC, SCREEN_YMLCODE_SRC, SCREEN_ID_SRC,  SCREEN_POBJECT_ID_SCR_SRC, POBJECT_CODE_SCR_SRC,
  POBJECT_OBJECTTYPE_SCR_SRC,  POBJECT_ID_SCR_SRC, POBJECT_CONTENTS_SCR_SRC, SCREEN_CONTENTS_SRC,
  SCREEN_SCRLV_ID_SRC, SCRLV_LEVEL1_SRC, SCRLV_ID_SRC, SCRLV_CODE_SRC, TBLINK_CODEL, TBLINKFLD_COMMAND_C) AS
  select tblinkfld.expiredate tblinkfld_expiredate ,tblinkfld.updated_at tblinkfld_updated_at ,tblinkfld.seqno tblinkfld_seqno ,
  tblinkfld.remark tblinkfld_remark ,tblinkfld.created_at tblinkfld_created_at ,tblinkfld.update_ip tblinkfld_update_ip ,
  tblinkfld.rubycode tblinkfld_rubycode ,tblinkfld.id id,tblinkfld.id tblinkfld_id ,tblinkfld.tblfields_id tblinkfld_tblfield_id ,
  tblfield.tblfield_contents tblfield_contents, tblfield.tblfield_blktb_id tblfield_blktb_id, tblfield.blktb_contents blktb_contents,
  tblfield.blktb_id blktb_id, tblfield.blktb_pobject_id_tbl blktb_pobject_id_tbl, tblfield.pobject_code_tbl pobject_code_tbl,
  tblfield.pobject_objecttype_tbl pobject_objecttype_tbl, tblfield.pobject_id_tbl pobject_id_tbl,
  tblfield.pobject_contents_tbl pobject_contents_tbl, tblfield.blktb_seltbls blktb_seltbls, tblfield.tblfield_fieldcode_id tblfield_fieldcode_id,
  tblfield.fieldcode_seqno fieldcode_seqno, tblfield.fieldcode_ftype fieldcode_ftype, tblfield.fieldcode_datascale fieldcode_datascale,
  tblfield.fieldcode_dataprecision fieldcode_dataprecision, tblfield.fieldcode_fieldlength fieldcode_fieldlength, tblfield.fieldcode_id fieldcode_id,
  tblfield.fieldcode_contents fieldcode_contents, tblfield.fieldcode_pobject_id_fld fieldcode_pobject_id_fld, tblfield.pobject_code_fld pobject_code_fld,
  tblfield.pobject_objecttype_fld pobject_objecttype_fld, tblfield.pobject_id_fld pobject_id_fld,
  tblfield.pobject_contents_fld pobject_contents_fld, tblfield.tblfield_id tblfield_id, tblfield.tblfield_expiredate tblfield_expiredate,
  tblfield.tblfield_seqno tblfield_seqno, tblfield.tblfield_viewflmk tblfield_viewflmk,tblinkfld.persons_id_upd tblinkfld_person_id_upd ,
  person_upd.person_id_upd person_id_upd, person_upd.person_code_upd person_code_upd, person_upd.person_name_upd person_name_upd,
  tblinkfld.contents tblinkfld_contents ,tblinkfld.tblinks_id tblinkfld_tblink_id , tblink.tblink_contents tblink_contents, tblink.tblink_id tblink_id,
  tblink.tblink_expiredate tblink_expiredate, tblink.tblink_seqno tblink_seqno,
  tblink.tblink_blktb_id_dest tblink_blktb_id_dest, tblink.blktb_contents_dest blktb_contents_dest, tblink.blktb_id_dest blktb_id_dest,
  tblink.blktb_pobject_id_tbl_dest blktb_pobject_id_tbl_dest, tblink.pobject_code_tbl_dest pobject_code_tbl_dest,
  tblink.pobject_objecttype_tbl_dest pobject_objecttype_tbl_dest,
  tblink.pobject_id_tbl_dest pobject_id_tbl_dest, tblink.pobject_contents_tbl_dest pobject_contents_tbl_dest, tblink.blktb_seltbls_dest blktb_seltbls_dest,
  tblink.tblink_beforeafter tblink_beforeafter, tblink.tblink_hikisu tblink_hikisu, tblink.tblink_screen_id_src tblink_screen_id_src,
  tblink.screen_strwhere_src screen_strwhere_src, tblink.screen_rows_per_page_src screen_rows_per_page_src, tblink.screen_rowlist_src screen_rowlist_src,
  tblink.screen_height_src screen_height_src, tblink.screen_pobject_id_view_src screen_pobject_id_view_src, tblink.pobject_code_view_src pobject_code_view_src,
  tblink.pobject_objecttype_view_src pobject_objecttype_view_src, tblink.pobject_id_view_src pobject_id_view_src,
  tblink.pobject_contents_view_src pobject_contents_view_src, tblink.screen_form_ps_src screen_form_ps_src,
  tblink.screen_strselect_src screen_strselect_src, tblink.screen_cdrflayout_src screen_cdrflayout_src, tblink.screen_ymlcode_src screen_ymlcode_src,
  tblink.screen_id_src screen_id_src,  tblink.screen_pobject_id_scr_src screen_pobject_id_scr_src,
  tblink.pobject_code_scr_src pobject_code_scr_src, tblink.pobject_objecttype_scr_src pobject_objecttype_scr_src,
  tblink.pobject_id_scr_src pobject_id_scr_src, tblink.pobject_contents_scr_src pobject_contents_scr_src, tblink.screen_contents_src screen_contents_src,
  tblink.screen_scrlv_id_src screen_scrlv_id_src, tblink.scrlv_level1_src scrlv_level1_src, tblink.scrlv_id_src scrlv_id_src, tblink.scrlv_code_src scrlv_code_src,
  tblink.tblink_codel tblink_codel,tblinkfld.command_c tblinkfld_command_c
 from tblinkflds tblinkfld ,r_tblfields  tblfield,upd_persons  person_upd,r_tblinks  tblink
 where  tblfield.id = tblinkfld.tblfields_id and  person_upd.id = tblinkfld.persons_id_upd and  tblink.id = tblinkfld.tblinks_id
 ;

   CREATE OR REPLACE  VIEW SCR_POBJECTS
 (POBJECT_CODE,  POBJECT_EXPIREDATE, POBJECT_UPDATED_AT,
  POBJECT_REMARK, POBJECT_CONTENTS,POBJECT_CREATED_AT, POBJECT_UPDATE_IP, ID, POBJECT_ID,
 PERSON_CODE_UPD, PERSON_NAME_UPD, POBJECT_PERSON_ID_UPD) AS
   select
   pobject.code pobject_code
   , pobject.expiredate pobject_expiredate
   , pobject.updated_at pobject_updated_at
   , pobject.remark pobject_remark
   , pobject.contents pobject_contents
   , pobject.created_at pobject_created_at
   , pobject.update_ip pobject_update_ip
   , pobject.id id
   , pobject.id pobject_id
   , person_upd.code updperson_code_upd
   , person_upd.name updperson_name_upd
   ,pobject.persons_id_upd pobject_person_id_upd
 from
   pobjects pobject
   , persons person_upd
 where
   person_upd.id = pobject.persons_id_upd

   and pobject.objecttype = 'screen'
   ;

   CREATE
 OR REPLACE  VIEW VIEW_POBJECTS (
   POBJECT_CODE
   , POBJECT_EXPIREDATE
   , POBJECT_UPDATED_AT
   , POBJECT_REMARK
   , POBJECT_CONTENTS
   , POBJECT_CREATED_AT
   , POBJECT_UPDATE_IP
   , ID
   , POBJECT_ID
   , POBJECT_PERSON_ID_UPD
   , PERSON_ID_UPD
   , PERSON_CODE_UPD
   , PERSON_NAME_UPD
 ) AS
 select
   pobject.code pobject_code
   , pobject.expiredate pobject_expiredate
   , pobject.updated_at pobject_updated_at
   , pobject.remark pobject_remark
   , pobject.contents pobject_contents
   , pobject.created_at pobject_created_at
   , pobject.update_ip pobject_update_ip
   , pobject.id id
   , pobject.id pobject_id
   , pobject.persons_id_upd pobject_person_id_upd
   , person_upd.id person_id_upd
   , person_upd.code person_code_upd
   , person_upd.name person_name_upd
 from
   pobjects pobject
   , persons person_upd
 where
   person_upd.id = pobject.persons_id_upd
   and pobject.objecttype = 'view';


   CREATE OR REPLACE  VIEW TBL_POBJECTS
 (POBJECT_CODE,  POBJECT_EXPIREDATE, POBJECT_UPDATED_AT,
  POBJECT_REMARK, POBJECT_CREATED_AT, POBJECT_UPDATE_IP, ID, POBJECT_ID, POBJECT_PERSON_ID_UPD,
 PERSON_ID_UPD, PERSON_CODE_UPD, PERSON_NAME_UPD) AS
 select
   pobject.code pobject_code
   , pobject.expiredate pobject_expiredate
   , pobject.updated_at pobject_updated_at
   , pobject.remark pobject_remark
   , pobject.created_at pobject_created_at
   , pobject.update_ip pobject_update_ip
   , pobject.id id
   , pobject.id pobject_id
   , pobject.persons_id_upd pobject_person_id_upd
   , person_upd.id updperson_id_upd
   , person_upd.code updperson_code_upd
   , person_upd.name updperson_name_upd
 from
   pobjects pobject
   , persons person_upd
 where
   person_upd.id = pobject.persons_id_upd
   and pobject.objecttype = 'tbl'
   ;


   CREATE OR REPLACE  VIEW FLD_POBJECTS
 (POBJECT_CODE,  POBJECT_EXPIREDATE, POBJECT_UPDATED_AT,
 POBJECT_REMARK, POBJECT_CREATED_AT, POBJECT_UPDATE_IP, ID, POBJECT_ID, POBJECT_PERSON_ID_UPD,
 POBJECT_CONTENTS,
 PERSON_CODE_UPD, PERSON_ID_UPD,PERSON_NAME_UPD) AS
   select
   pobject.code pobject_code
   , pobject.expiredate pobject_expiredate
   , pobject.updated_at pobject_updated_at
   , pobject.remark pobject_remark
   , pobject.created_at pobject_created_at
   , pobject.update_ip pobject_update_ip
   , pobject.id
   , pobject.id pobject_id
     , pobject.persons_id_upd pobject_person_id_upd
 	,pobject.contents pobject_contents
   , person_upd.code updperson_code_upd
   , person_upd.id updperson_id_upd
   , person_upd.name updperson_name_upd
 from
   pobjects pobject
   , persons person_upd
 where
   person_upd.id = pobject.persons_id_upd
   and pobject.objecttype = 'tbl_field'
   ;


     CREATE OR REPLACE  VIEW SFD_POBJECTS
 (POBJECT_CODE,  POBJECT_EXPIREDATE, POBJECT_UPDATED_AT,
  POBJECT_REMARK, POBJECT_CREATED_AT, POBJECT_UPDATE_IP, ID, POBJECT_ID,POBJECT_PERSON_ID_UPD,
 PERSON_ID_UPD, PERSON_CODE_UPD,PERSON_NAME_UPD) AS
   select
   pobject.code pobject_code
   , pobject.expiredate pobject_expiredate
   , pobject.updated_at pobject_updated_at
   , pobject.remark pobject_remark
   , pobject.created_at pobject_created_at
   , pobject.update_ip pobject_update_ip
   , pobject.id id  , pobject.id pobject_id
   , pobject.PERSONS_ID_UPD pobject_person_id_upd
   , person_upd.id person_id_upd
   , person_upd.code person_code_upd
   , person_upd.name person_name_upd
 from
   pobjects pobject
   , persons person_upd
 where
   person_upd.id = pobject.persons_id_upd
   and pobject.objecttype = 'view_field'
   ;


     CREATE OR REPLACE  VIEW SGRP_POBJECTS
 (POBJECT_CODE,  POBJECT_EXPIREDATE, POBJECT_UPDATED_AT,
  POBJECT_REMARK, POBJECT_CREATED_AT, POBJECT_UPDATE_IP, ID, POBJECT_ID,POBJECT_PERSON_ID_UPD,
 PERSON_ID_UPD, PERSON_CODE_UPD,PERSON_NAME_UPD) AS
   select
   pobject.code pobject_code
   , pobject.expiredate pobject_expiredate
   , pobject.updated_at pobject_updated_at
   , pobject.remark pobject_remark
   , pobject.created_at pobject_created_at
   , pobject.update_ip pobject_update_ip
   , pobject.id id  , pobject.id pobject_id
   , pobject.PERSONS_ID_UPD pobject_person_id_upd
   , person_upd.id person_id_upd
   , person_upd.code person_code_upd
   , person_upd.name person_name_upd
 from
   pobjects pobject
   , persons person_upd
 where
   person_upd.id = pobject.persons_id_upd
   and pobject.objecttype = 'screen_group'
   ;

CREATE OR REPLACE  VIEW R_BLKTBS (BLKTB_CONTENTS, ID, BLKTB_ID, BLKTB_POBJECT_ID_TBL, POBJECT_CODE_TBL, POBJECT_OBJECTTYPE_TBL, POBJECT_REMARK_TBL, POBJECT_ID_TBL, POBJECT_CONTENTS_TBL, BLKTB_REMARK, BLKTB_EXPIREDATE, BLKTB_UPDATE_IP, BLKTB_CREATED_AT, BLKTB_UPDATED_AT, BLKTB_PERSON_ID_UPD, PERSON_ID_UPD, PERSON_CODE_UPD, PERSON_NAME_UPD, BLKTB_SELTBLS) AS 
  select
  blktb.contents blktb_contents
  , blktb.id id
  , blktb.id blktb_id
  , blktb.pobjects_id_tbl blktb_pobject_id_tbl
  , pobject_tbl.pobject_code pobject_code_tbl
  , pobject_tbl.pobject_objecttype pobject_objecttype_tbl
  , pobject_tbl.pobject_remark pobject_remark_tbl
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

CREATE OR REPLACE  VIEW R_TBLFIELDS (TBLFIELD_CONTENTS, TBLFIELD_BLKTB_ID, BLKTB_CONTENTS, BLKTB_ID, BLKTB_POBJECT_ID_TBL, POBJECT_CODE_TBL, POBJECT_OBJECTTYPE_TBL, POBJECT_ID_TBL, POBJECT_CONTENTS_TBL, BLKTB_SELTBLS, TBLFIELD_FIELDCODE_ID, FIELDCODE_SEQNO, FIELDCODE_FTYPE, FIELDCODE_DATASCALE, FIELDCODE_DATAPRECISION, FIELDCODE_FIELDLENGTH, FIELDCODE_ID, FIELDCODE_CONTENTS, FIELDCODE_POBJECT_ID_FLD, POBJECT_CODE_FLD, POBJECT_OBJECTTYPE_FLD, POBJECT_CONTENTS_FLD, ID, TBLFIELD_ID, TBLFIELD_REMARK, TBLFIELD_EXPIREDATE, TBLFIELD_UPDATE_IP, TBLFIELD_CREATED_AT, TBLFIELD_UPDATED_AT, TBLFIELD_PERSON_ID_UPD, PERSON_ID_UPD, PERSON_CODE_UPD, PERSON_NAME_UPD, TBLFIELD_SEQNO, TBLFIELD_VIEWFLMK) AS 
  select tblfield.contents tblfield_contents ,
   tblfield.blktbs_id tblfield_blktb_id ,
    blktb.blktb_contents blktb_contents,
	 blktb.blktb_id blktb_id,
	  blktb.blktb_pobject_id_tbl blktb_pobject_id_tbl,
	   blktb.pobject_code_tbl pobject_code_tbl,
	    blktb.pobject_objecttype_tbl pobject_objecttype_tbl, 
		blktb.pobject_id_tbl pobject_id_tbl,
		 blktb.pobject_contents_tbl pobject_contents_tbl,
		  blktb.blktb_seltbls blktb_seltbls,
		  tblfield.fieldcodes_id tblfield_fieldcode_id , 
		  fieldcode.fieldcode_seqno fieldcode_seqno, 
		  fieldcode.fieldcode_ftype fieldcode_ftype,
		   fieldcode.fieldcode_datascale fieldcode_datascale,
		    fieldcode.fieldcode_dataprecision fieldcode_dataprecision,
			 fieldcode.fieldcode_fieldlength fieldcode_fieldlength,
			  fieldcode.fieldcode_id fieldcode_id,
			   fieldcode.fieldcode_contents fieldcode_contents,
			    fieldcode.fieldcode_pobject_id_fld fieldcode_pobject_id_fld,
				 fieldcode.pobject_code_fld pobject_code_fld, 
				 fieldcode.pobject_objecttype_fld pobject_objecttype_fld,
				    fieldcode.pobject_contents_fld pobject_contents_fld,
					tblfield.id id,
					tblfield.id tblfield_id ,
					tblfield.remark tblfield_remark ,
					tblfield.expiredate tblfield_expiredate ,
					tblfield.update_ip tblfield_update_ip ,
					tblfield.created_at tblfield_created_at ,
					tblfield.updated_at tblfield_updated_at ,
					tblfield.persons_id_upd tblfield_person_id_upd ,
					 person_upd.person_id_upd person_id_upd, 
					 person_upd.person_code_upd person_code_upd,
					  person_upd.person_name_upd person_name_upd,
					  tblfield.seqno tblfield_seqno ,
					  tblfield.viewflmk tblfield_viewflmk 
 from tblfields tblfield ,r_blktbs  blktb,r_fieldcodes  fieldcode,upd_persons  person_upd
 where  blktb.id = tblfield.blktbs_id and  fieldcode.id = tblfield.fieldcodes_id and  person_upd.id = tblfield.persons_id_upd
 ;
CREATE OR REPLACE VIEW R_SCREENFIELDS (SCREENFIELD_POBJECT_ID_SFD, POBJECT_CODE_SFD, POBJECT_OBJECTTYPE_SFD, POBJECT_ID_SFD, POBJECT_CONTENTS_SFD, SCREENFIELD_EXPIREDATE, SCREENFIELD_UPDATED_AT,
 SCREENFIELD_EDOPTCOLS, SCREENFIELD_EDOPTROW, SCREENFIELD_WIDTH, SCREENFIELD_INDISP, SCREENFIELD_ROWPOS, SCREENFIELD_SEQNO, SCREENFIELD_HIDEFLG, SCREENFIELD_MAXVALUE, SCREENFIELD_EDITABLE, 
SCREENFIELD_PARAGRAPH, SCREENFIELD_SELECTION, SCREENFIELD_CRTFIELD, SCREENFIELD_EDOPTVALUE, SCREENFIELD_SUBINDISP, SCREENFIELD_TYPE, SCREENFIELD_SUMKEY, SCREENFIELD_REMARK, SCREENFIELD_CREATED_AT,
 SCREENFIELD_UPDATE_IP, SCREENFIELD_EDOPTMAXLENGTH, SCREENFIELD_DATASCALE, SCREENFIELD_DATAPRECISION, SCREENFIELD_MINVALUE, SCREENFIELD_EDOPTSIZE, SCREENFIELD_COLPOS, ID, SCREENFIELD_ID, 
SCREENFIELD_FORMATTER, SCREENFIELD_TBLFIELD_ID, TBLFIELD_CONTENTS, TBLFIELD_BLKTB_ID, BLKTB_CONTENTS, BLKTB_ID, BLKTB_POBJECT_ID_TBL, POBJECT_CODE_TBL, POBJECT_OBJECTTYPE_TBL, POBJECT_ID_TBL,
 POBJECT_CONTENTS_TBL, BLKTB_SELTBLS, TBLFIELD_FIELDCODE_ID, FIELDCODE_SEQNO, FIELDCODE_FTYPE, FIELDCODE_DATASCALE, FIELDCODE_DATAPRECISION, FIELDCODE_FIELDLENGTH, FIELDCODE_ID, FIELDCODE_CONTENTS,
 POBJECT_CODE_FLD, POBJECT_OBJECTTYPE_FLD, POBJECT_CONTENTS_FLD, TBLFIELD_ID, TBLFIELD_SEQNO, TBLFIELD_VIEWFLMK, SCREENFIELD_PERSON_ID_UPD, PERSON_ID_UPD, PERSON_CODE_UPD, PERSON_NAME_UPD,
 SCREENFIELD_CONTENTS, SCREENFIELD_SCREEN_ID, SCREEN_STRWHERE, SCREEN_ROWS_PER_PAGE, SCREEN_ROWLIST, SCREEN_HEIGHT, SCREEN_POBJECT_ID_VIEW, POBJECT_CODE_VIEW, POBJECT_OBJECTTYPE_VIEW, 
POBJECT_ID_VIEW, POBJECT_CONTENTS_VIEW, SCREEN_FORM_PS, SCREEN_STRGROUPORDER, SCREEN_STRSELECT, SCREEN_CDRFLAYOUT, SCREEN_YMLCODE, SCREEN_ID, 
SCREEN_POBJECT_ID_SCR, POBJECT_CODE_SCR, POBJECT_OBJECTTYPE_SCR, POBJECT_ID_SCR, POBJECT_CONTENTS_SCR, SCREEN_CONTENTS, SCREEN_SCRLV_ID, SCRLV_LEVEL1, SCRLV_ID, SCRLV_CODE) AS 
  select screenfield.pobjects_id_sfd screenfield_pobject_id_sfd , pobject_sfd.pobject_code pobject_code_sfd, pobject_sfd.pobject_objecttype pobject_objecttype_sfd, 
 pobject_sfd.pobject_id pobject_id_sfd, pobject_sfd.pobject_contents pobject_contents_sfd,screenfield.expiredate screenfield_expiredate ,screenfield.updated_at screenfield_updated_at ,
screenfield.edoptcols screenfield_edoptcols ,screenfield.edoptrow screenfield_edoptrow ,screenfield.width screenfield_width ,screenfield.indisp screenfield_indisp ,
screenfield.rowpos screenfield_rowpos ,screenfield.seqno screenfield_seqno ,screenfield.hideflg screenfield_hideflg ,screenfield.maxvalue screenfield_maxvalue ,screenfield.editable screenfield_editable ,
screenfield.paragraph screenfield_paragraph ,screenfield.selection screenfield_selection ,screenfield.crtfield screenfield_crtfield ,screenfield.edoptvalue screenfield_edoptvalue ,
screenfield.subindisp screenfield_subindisp ,screenfield.type screenfield_type ,screenfield.sumkey screenfield_sumkey ,screenfield.remark screenfield_remark ,
screenfield.created_at screenfield_created_at ,screenfield.update_ip screenfield_update_ip ,screenfield.edoptmaxlength screenfield_edoptmaxlength ,screenfield.datascale screenfield_datascale ,
screenfield.dataprecision screenfield_dataprecision ,screenfield.minvalue screenfield_minvalue ,screenfield.edoptsize screenfield_edoptsize ,screenfield.colpos screenfield_colpos ,
screenfield.id id,screenfield.id screenfield_id ,screenfield.formatter screenfield_formatter ,screenfield.tblfields_id screenfield_tblfield_id , tblfield.tblfield_contents tblfield_contents, 
tblfield.tblfield_blktb_id tblfield_blktb_id, tblfield.blktb_contents blktb_contents, tblfield.blktb_id blktb_id, tblfield.blktb_pobject_id_tbl blktb_pobject_id_tbl, tblfield.pobject_code_tbl pobject_code_tbl, 
tblfield.pobject_objecttype_tbl pobject_objecttype_tbl,  tblfield.pobject_id_tbl pobject_id_tbl, tblfield.pobject_contents_tbl pobject_contents_tbl, tblfield.blktb_seltbls blktb_seltbls,
 tblfield.tblfield_fieldcode_id tblfield_fieldcode_id, tblfield.fieldcode_seqno fieldcode_seqno, tblfield.fieldcode_ftype fieldcode_ftype, tblfield.fieldcode_datascale fieldcode_datascale,
 tblfield.fieldcode_dataprecision fieldcode_dataprecision, tblfield.fieldcode_fieldlength fieldcode_fieldlength, tblfield.fieldcode_id fieldcode_id, tblfield.fieldcode_contents fieldcode_contents,
 tblfield.pobject_code_fld pobject_code_fld, tblfield.pobject_objecttype_fld pobject_objecttype_fld,  tblfield.pobject_contents_fld pobject_contents_fld, tblfield.tblfield_id tblfield_id, 
tblfield.tblfield_seqno tblfield_seqno, tblfield.tblfield_viewflmk tblfield_viewflmk,screenfield.persons_id_upd screenfield_person_id_upd , person_upd.person_id_upd person_id_upd, 
person_upd.person_code_upd person_code_upd, person_upd.person_name_upd person_name_upd,screenfield.contents screenfield_contents ,screenfield.screens_id screenfield_screen_id ,
 screen.screen_strwhere screen_strwhere, screen.screen_rows_per_page screen_rows_per_page, screen.screen_rowlist screen_rowlist, screen.screen_height screen_height, 
screen.screen_pobject_id_view screen_pobject_id_view, screen.pobject_code_view pobject_code_view, screen.pobject_objecttype_view pobject_objecttype_view,  screen.pobject_id_view pobject_id_view,
 screen.pobject_contents_view pobject_contents_view, screen.screen_form_ps screen_form_ps, screen.screen_strgrouporder screen_strgrouporder, screen.screen_strselect screen_strselect,
 screen.screen_cdrflayout screen_cdrflayout, screen.screen_ymlcode screen_ymlcode, screen.screen_id screen_id, screen.screen_pobject_id_scr screen_pobject_id_scr,
 screen.pobject_code_scr pobject_code_scr, screen.pobject_objecttype_scr pobject_objecttype_scr, screen.pobject_id_scr pobject_id_scr, screen.pobject_contents_scr pobject_contents_scr,
 screen.screen_contents screen_contents, screen.screen_scrlv_id screen_scrlv_id, screen.scrlv_level1 scrlv_level1, screen.scrlv_id scrlv_id, screen.scrlv_code scrlv_code
 from screenfields screenfield ,r_pobjects  pobject_sfd,r_tblfields  tblfield,upd_persons  person_upd,r_screens  screen
 where  pobject_sfd.id = screenfield.pobjects_id_sfd and  tblfield.id = screenfield.tblfields_id and  person_upd.id = screenfield.persons_id_upd and  screen.id = screenfield.screens_id

 ;


 CREATE OR REPLACE  VIEW R_RUBYCODINGS (RUBYCODING_POBJECT_ID, POBJECT_CODE, POBJECT_OBJECTTYPE,
          POBJECT_ID, POBJECT_CONTENTS, RUBYCODING_CONTENTS, ID, RUBYCODING_ID, RUBYCODING_REMARK, RUBYCODING_EXPIREDATE,
         RUBYCODING_UPDATE_IP, RUBYCODING_CREATED_AT, RUBYCODING_UPDATED_AT, RUBYCODING_PERSON_ID_UPD, PERSON_ID_UPD, PERSON_CODE_UPD, PERSON_NAME_UPD,
          RUBYCODING_RUBYCODE, RUBYCODING_HIKISU, RUBYCODING_CODEL) AS
select rubycoding.pobjects_id rubycoding_pobject_id , pobject.pobject_code pobject_code, pobject.pobject_objecttype pobject_objecttype,
pobject.pobject_id pobject_id, pobject.pobject_contents pobject_contents,
rubycoding.contents rubycoding_contents ,rubycoding.id id,rubycoding.id rubycoding_id ,rubycoding.remark rubycoding_remark ,rubycoding.expiredate rubycoding_expiredate ,
rubycoding.update_ip rubycoding_update_ip ,rubycoding.created_at rubycoding_created_at ,rubycoding.updated_at rubycoding_updated_at ,
rubycoding.persons_id_upd rubycoding_person_id_upd , person_upd.person_id_upd person_id_upd, person_upd.person_code_upd person_code_upd,
person_upd.person_name_upd person_name_upd,rubycoding.rubycode rubycoding_rubycode ,rubycoding.hikisu rubycoding_hikisu ,rubycoding.codel rubycoding_codel
from rubycodings rubycoding ,r_pobjects  pobject,upd_persons  person_upd
where  pobject.id = rubycoding.pobjects_id and  person_upd.id = rubycoding.persons_id_upd
;

