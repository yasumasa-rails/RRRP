
 alter table inamts DROP COLUMN trngantts_id CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'trngantts_id'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　trngantts_idが削除　2020-04-06 22:22:49 +0900' 
 ---- where  pobject_code_sfd = 'trngantts_id'
 alter table  inamts  ADD COLUMN alloctbls_id numeric(38,0);

 alter table  incustwhs  ADD COLUMN alloctbls_id numeric(38,0);

 alter table  instks  ADD COLUMN alloctbls_id numeric(38,0);

 alter table outamts DROP COLUMN trngantts_id CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'trngantts_id'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　trngantts_idが削除　2020-04-06 22:22:50 +0900' 
 ---- where  pobject_code_sfd = 'trngantts_id'
 alter table  outamts  ADD COLUMN alloctbls_id numeric(38,0);

 alter table  outstks  ADD COLUMN alloctbls_id numeric(38,0);

 ALTER TABLE inamts ADD CONSTRAINT inamt_alloctbls_id FOREIGN KEY (alloctbls_id)
																		 REFERENCES alloctbls (id);
 ALTER TABLE incustwhs ADD CONSTRAINT incustwh_alloctbls_id FOREIGN KEY (alloctbls_id)
																		 REFERENCES alloctbls (id);
 ALTER TABLE instks ADD CONSTRAINT instk_alloctbls_id FOREIGN KEY (alloctbls_id)
																		 REFERENCES alloctbls (id);
 ALTER TABLE outamts ADD CONSTRAINT outamt_alloctbls_id FOREIGN KEY (alloctbls_id)
																		 REFERENCES alloctbls (id);
 ALTER TABLE outstks ADD CONSTRAINT outstk_alloctbls_id FOREIGN KEY (alloctbls_id)
																		 REFERENCES alloctbls (id);
 --- drop view r_inamts cascade  
 create or replace view r_inamts as select  
  alloctbl.shelfno_code_fm  shelfno_code_fm ,
  alloctbl.shelfno_name_fm  shelfno_name_fm ,
  alloctbl.prjno_name  prjno_name ,
  alloctbl.unit_code_pare  unit_code_pare ,
  alloctbl.unit_code  unit_code ,
  alloctbl.unit_name_pare  unit_name_pare ,
  alloctbl.unit_name  unit_name ,
  alloctbl.trngantt_itm_id  trngantt_itm_id ,
  alloctbl.itm_code_pare  itm_code_pare ,
  alloctbl.itm_code  itm_code ,
  alloctbl.itm_name_pare  itm_name_pare ,
  alloctbl.itm_name  itm_name ,
  alloctbl.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  loca_in.loca_code  loca_code_in ,
  alloctbl.loca_code_pare  loca_code_pare ,
  alloctbl.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  loca_in.loca_name  loca_name_in ,
  alloctbl.loca_name_pare  loca_name_pare ,
  alloctbl.itm_unit_id_pare  itm_unit_id_pare ,
  alloctbl.itm_unit_id  itm_unit_id ,
  alloctbl.itm_classlist_id_pare  itm_classlist_id_pare ,
  alloctbl.itm_classlist_id  itm_classlist_id ,
  trngantt.trngantt_duedate  trngantt_duedate ,
  alloctbl.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  alloctbl.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  alloctbl.trngantt_loca_id_pare  trngantt_loca_id_pare ,
inamt.id  inamt_id,
inamt.id id,
inamt.starttime  inamt_starttime,
inamt.amt  inamt_amt,
inamt.crrs_id   inamt_crr_id,
inamt.inoutflg  inamt_inoutflg,
inamt.expiredate  inamt_expiredate,
inamt.remark  inamt_remark,
inamt.persons_id_upd   inamt_person_id_upd,
inamt.created_at  inamt_created_at,
inamt.updated_at  inamt_updated_at,
inamt.update_ip  inamt_update_ip,
inamt.alloctbls_id   inamt_alloctbl_id,
inamt.locas_id_in   inamt_loca_id_in,
  alloctbl.classlist_code_pare  classlist_code_pare ,
  alloctbl.classlist_code  classlist_code ,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
  alloctbl.alloctbl_trngantt_id  alloctbl_trngantt_id ,
  alloctbl.classlist_name_pare  classlist_name_pare ,
  alloctbl.classlist_name  classlist_name ,
  alloctbl.prjno_code_chil  prjno_code_chil ,
  alloctbl.prjno_code  prjno_code ,
  alloctbl.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  alloctbl.trngantt_prjno_id  trngantt_prjno_id 
 from inamts   inamt,
  r_crrs  crr ,  r_persons  person_upd ,  r_alloctbls  alloctbl ,  r_locas  loca_in 
  where       inamt.crrs_id = crr.id      and inamt.persons_id_upd = person_upd.id      and inamt.alloctbls_id = alloctbl.id      and inamt.locas_id_in = loca_in.id     ;
 DROP TABLE IF EXISTS sio.sio_r_inamts;
 CREATE TABLE sio.sio_r_inamts (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_inamts_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,shelfno_code_fm  varchar (50) 
,shelfno_name_fm  varchar (100) 
,prjno_name  varchar (100) 
,unit_code_pare  varchar (50) 
,unit_code  varchar (50) 
,unit_name_pare  varchar (100) 
,unit_name  varchar (100) 
,itm_code_pare  varchar (50) 
,itm_code  varchar (50) 
,itm_name_pare  varchar (100) 
,itm_name  varchar (100) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_in  varchar (50) 
,loca_code_pare  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_in  varchar (100) 
,loca_name_pare  varchar (100) 
,classlist_code_pare  varchar (50) 
,classlist_code  varchar (50) 
,crr_code  varchar (50) 
,crr_name  varchar (100) 
,classlist_name_pare  varchar (100) 
,classlist_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,prjno_code  varchar (50) 
,inamt_amt  numeric (18,4)
,inamt_starttime   timestamp(6) 
,inamt_inoutflg  varchar (3) 
,inamt_expiredate   date 
,loca_country_in  varchar (20) 
,alloctbl_srctblname  varchar (30) 
,crr_pricedecimal  numeric (22,0)
,loca_abbr_in  varchar (50) 
,loca_zip_in  varchar (10) 
,loca_addr2_in  varchar (50) 
,alloctbl_contents  varchar (4000) 
,alloctbl_srctblid  numeric (38,0)
,crr_contents  varchar (4000) 
,alloctbl_qty_alloc  numeric (22,6)
,loca_tel_in  varchar (20) 
,loca_addr1_in  varchar (50) 
,loca_prfct_in  varchar (20) 
,loca_fax_in  varchar (20) 
,crr_amtdecimal  numeric (22,0)
,loca_mail_in  varchar (20) 
,trngantt_duedate   timestamp(6) 
,inamt_remark  varchar (4000) 
,inamt_update_ip  varchar (40) 
,inamt_id  numeric (38,0)
,id  numeric (38,0)
,inamt_crr_id  numeric (22,0)
,inamt_person_id_upd  numeric (38,0)
,inamt_created_at   timestamp(6) 
,inamt_updated_at   timestamp(6) 
,inamt_alloctbl_id  numeric (38,0)
,inamt_loca_id_in  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_unit_id_pare  numeric (22,0)
,alloctbl_trngantt_id  numeric (38,0)
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
 CREATE INDEX sio_r_inamts_uk1 
  ON sio.sio_r_inamts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_inamts_seq ;
 create sequence sio.sio_r_inamts_seq ;
 ALTER TABLE inamts ADD CONSTRAINT inamt_alloctbls_id FOREIGN KEY (alloctbls_id)
																		 REFERENCES alloctbls (id);
 ALTER TABLE incustwhs ADD CONSTRAINT incustwh_alloctbls_id FOREIGN KEY (alloctbls_id)
																		 REFERENCES alloctbls (id);
 ALTER TABLE instks ADD CONSTRAINT instk_alloctbls_id FOREIGN KEY (alloctbls_id)
																		 REFERENCES alloctbls (id);
 ALTER TABLE outamts ADD CONSTRAINT outamt_alloctbls_id FOREIGN KEY (alloctbls_id)
																		 REFERENCES alloctbls (id);
 ALTER TABLE outstks ADD CONSTRAINT outstk_alloctbls_id FOREIGN KEY (alloctbls_id)
																		 REFERENCES alloctbls (id);
 --- drop view r_outamts cascade  
 create or replace view r_outamts as select  
  alloctbl.shelfno_code_fm  shelfno_code_fm ,
  alloctbl.shelfno_name_fm  shelfno_name_fm ,
  alloctbl.prjno_name  prjno_name ,
  alloctbl.unit_code_pare  unit_code_pare ,
  alloctbl.unit_code  unit_code ,
  alloctbl.unit_name_pare  unit_name_pare ,
  alloctbl.unit_name  unit_name ,
  alloctbl.trngantt_itm_id  trngantt_itm_id ,
  alloctbl.itm_code_pare  itm_code_pare ,
  alloctbl.itm_code  itm_code ,
  alloctbl.itm_name_pare  itm_name_pare ,
  alloctbl.itm_name  itm_name ,
  alloctbl.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  loca_out.loca_code  loca_code_out ,
  alloctbl.loca_code_pare  loca_code_pare ,
  alloctbl.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  loca_out.loca_name  loca_name_out ,
  alloctbl.loca_name_pare  loca_name_pare ,
  alloctbl.itm_unit_id_pare  itm_unit_id_pare ,
  alloctbl.itm_unit_id  itm_unit_id ,
  alloctbl.itm_classlist_id_pare  itm_classlist_id_pare ,
  alloctbl.itm_classlist_id  itm_classlist_id ,
  trngantt.trngantt_duedate  trngantt_duedate ,
  alloctbl.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  alloctbl.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  alloctbl.trngantt_loca_id_pare  trngantt_loca_id_pare ,
outamt.id  outamt_id,
outamt.id id,
outamt.starttime  outamt_starttime,
outamt.amt  outamt_amt,
outamt.crrs_id   outamt_crr_id,
outamt.inoutflg  outamt_inoutflg,
outamt.expiredate  outamt_expiredate,
outamt.remark  outamt_remark,
outamt.persons_id_upd   outamt_person_id_upd,
outamt.created_at  outamt_created_at,
outamt.updated_at  outamt_updated_at,
outamt.update_ip  outamt_update_ip,
outamt.alloctbls_id   outamt_alloctbl_id,
outamt.locas_id_out   outamt_loca_id_out,
  alloctbl.classlist_code_pare  classlist_code_pare ,
  alloctbl.classlist_code  classlist_code ,
  crr.crr_code  crr_code ,
  crr.crr_name  crr_name ,
  alloctbl.alloctbl_trngantt_id  alloctbl_trngantt_id ,
  alloctbl.classlist_name_pare  classlist_name_pare ,
  alloctbl.classlist_name  classlist_name ,
  alloctbl.prjno_code_chil  prjno_code_chil ,
  alloctbl.prjno_code  prjno_code ,
  alloctbl.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  alloctbl.trngantt_prjno_id  trngantt_prjno_id 
 from outamts   outamt,
  r_crrs  crr ,  r_persons  person_upd ,  r_alloctbls  alloctbl ,  r_locas  loca_out 
  where       outamt.crrs_id = crr.id      and outamt.persons_id_upd = person_upd.id      and outamt.alloctbls_id = alloctbl.id      and outamt.locas_id_out = loca_out.id     ;
 DROP TABLE IF EXISTS sio.sio_r_outamts;
 CREATE TABLE sio.sio_r_outamts (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_outamts_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,shelfno_code_fm  varchar (50) 
,shelfno_name_fm  varchar (100) 
,prjno_name  varchar (100) 
,unit_code_pare  varchar (50) 
,unit_code  varchar (50) 
,unit_name_pare  varchar (100) 
,unit_name  varchar (100) 
,itm_code_pare  varchar (50) 
,itm_code  varchar (50) 
,itm_name_pare  varchar (100) 
,itm_name  varchar (100) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_out  varchar (50) 
,loca_code_pare  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_out  varchar (100) 
,loca_name_pare  varchar (100) 
,classlist_code_pare  varchar (50) 
,classlist_code  varchar (50) 
,crr_code  varchar (50) 
,crr_name  varchar (100) 
,classlist_name_pare  varchar (100) 
,classlist_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,prjno_code  varchar (50) 
,outamt_amt  numeric (18,4)
,outamt_starttime   timestamp(6) 
,outamt_inoutflg  varchar (3) 
,outamt_expiredate   date 
,loca_country_out  varchar (20) 
,alloctbl_srctblname  varchar (30) 
,crr_pricedecimal  numeric (22,0)
,loca_abbr_out  varchar (50) 
,loca_zip_out  varchar (10) 
,loca_addr2_out  varchar (50) 
,alloctbl_contents  varchar (4000) 
,alloctbl_srctblid  numeric (38,0)
,crr_contents  varchar (4000) 
,alloctbl_qty_alloc  numeric (22,6)
,loca_tel_out  varchar (20) 
,loca_addr1_out  varchar (50) 
,loca_prfct_out  varchar (20) 
,loca_fax_out  varchar (20) 
,crr_amtdecimal  numeric (22,0)
,loca_mail_out  varchar (20) 
,trngantt_duedate   timestamp(6) 
,outamt_remark  varchar (4000) 
,outamt_update_ip  varchar (40) 
,outamt_id  numeric (38,0)
,id  numeric (38,0)
,outamt_crr_id  numeric (22,0)
,outamt_person_id_upd  numeric (38,0)
,outamt_created_at   timestamp(6) 
,outamt_updated_at   timestamp(6) 
,outamt_alloctbl_id  numeric (38,0)
,outamt_loca_id_out  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_unit_id_pare  numeric (22,0)
,alloctbl_trngantt_id  numeric (38,0)
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
 CREATE INDEX sio_r_outamts_uk1 
  ON sio.sio_r_outamts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_outamts_seq ;
 create sequence sio.sio_r_outamts_seq ;
