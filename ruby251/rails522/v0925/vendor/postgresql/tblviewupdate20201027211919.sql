
 alter table shpacts  ADD COLUMN paretblname varchar(30);

 alter table  shpacts  ADD COLUMN paretblid numeric(38,0) ;

 --- drop view r_shpacts cascade  
 create or replace view r_shpacts as select  
shpact.transports_id   shpact_transport_id,
shpact.prjnos_id   shpact_prjno_id,
  instk.shelfno_code_fm  shelfno_code_fm ,
  instk.shelfno_code_in  shelfno_code_in ,
  transport.transport_code  transport_code ,
  transport.transport_name  transport_name ,
  instk.shelfno_name_fm  shelfno_name_fm ,
  instk.shelfno_name_in  shelfno_name_in ,
  prjno.prjno_name  prjno_name ,
  instk.trngantt_itm_id  trngantt_itm_id ,
  itm.unit_code  unit_code ,
  itm.unit_name  unit_name ,
shpact.itms_id   shpact_itm_id,
shpact.instks_id   shpact_instk_id,
  instk.trngantt_loca_id  trngantt_loca_id ,
  instk.itm_code_pare  itm_code_pare ,
  itm.itm_code  itm_code ,
  instk.itm_name_pare  itm_name_pare ,
  itm.itm_name  itm_name ,
shpact.paretblname  shpact_paretblname,
shpact.paretblid  shpact_paretblid,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
shpact.id  shpact_id,
shpact.id id,
shpact.qty  shpact_qty,
shpact.amt  shpact_amt,
shpact.remark  shpact_remark,
shpact.expiredate  shpact_expiredate,
shpact.update_ip  shpact_update_ip,
shpact.created_at  shpact_created_at,
shpact.updated_at  shpact_updated_at,
shpact.persons_id_upd   shpact_person_id_upd,
shpact.tax  shpact_tax,
shpact.price  shpact_price,
  instk.loca_code_shelfno_fm  loca_code_shelfno_fm ,
  instk.loca_code_shelfno_in  loca_code_shelfno_in ,
  instk.loca_code_pare  loca_code_pare ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  instk.loca_code  loca_code ,
  instk.loca_name_shelfno_fm  loca_name_shelfno_fm ,
  instk.loca_name_shelfno_in  loca_name_shelfno_in ,
  instk.loca_name_pare  loca_name_pare ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  instk.loca_name  loca_name ,
  chrg.person_code_chrg  person_code_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  instk.itm_unit_id_pare  itm_unit_id_pare ,
  itm.itm_unit_id  itm_unit_id ,
  instk.itm_classlist_id_pare  itm_classlist_id_pare ,
  itm.itm_classlist_id  itm_classlist_id ,
  instk.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  instk.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  instk.instk_alloctbl_id  instk_alloctbl_id ,
  instk.trngantt_loca_id_pare  trngantt_loca_id_pare ,
  instk.instk_shelfno_id_in  instk_shelfno_id_in ,
shpact.chrgs_id   shpact_chrg_id,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  itm.classlist_code  classlist_code ,
shpact.sno  shpact_sno,
  instk.alloctbl_trngantt_id  alloctbl_trngantt_id ,
shpact.box  shpact_box,
shpact.duedate  shpact_duedate,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
shpact.starttime  shpact_starttime,
  itm.classlist_name  classlist_name ,
shpact.sno_shpord  shpact_sno_shpord,
shpact.gno_shpord  shpact_gno_shpord,
  prjno.prjno_code_chil  prjno_code_chil ,
shpact.processseq  shpact_processseq,
  prjno.prjno_code  prjno_code ,
  instk.shelfno_loca_id_shelfno_fm  shelfno_loca_id_shelfno_fm ,
  instk.shelfno_loca_id_shelfno_in  shelfno_loca_id_shelfno_in ,
  instk.trngantt_prjno_id  trngantt_prjno_id ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
shpact.gno  shpact_gno,
shpact.contents  shpact_contents,
shpact.contract_price  shpact_contract_price,
shpact.isudate  shpact_isudate,
shpact.cno  shpact_cno,
shpact.qty_case  shpact_qty_case,
shpact.cartonno  shpact_cartonno
 from shpacts   shpact,
  r_transports  transport ,  r_prjnos  prjno ,  r_itms  itm ,  r_instks  instk ,  r_persons  person_upd ,  r_chrgs  chrg 
  where       shpact.transports_id = transport.id      and shpact.prjnos_id = prjno.id      and shpact.itms_id = itm.id      and shpact.instks_id = instk.id      and shpact.persons_id_upd = person_upd.id      and shpact.chrgs_id = chrg.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shpacts;
 CREATE TABLE sio.sio_r_shpacts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shpacts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
          ,sio_Term_id varchar(30)
          ,sio_session_id numeric(22,0)
          ,sio_Command_Response char(1)
          ,sio_session_counter numeric(22,0)
          ,sio_classname varchar(50)
          ,sio_viewname varchar(30)
          ,sio_code varchar(30)
          ,sio_strsql varchar(4000)
          ,sio_totalcount numeric(22,0)
          ,sio_recordcount numeric(22,0)
          ,sio_start_record numeric(22,0)
          ,sio_end_record numeric(22,0)
          ,sio_sord varchar(256)
          ,sio_search varchar(10)
          ,sio_sidx varchar(256)
,shpact_duedate   timestamp(6) 
,shpact_qty  numeric (18,4)
,shpact_cno  varchar (40) 
,shpact_gno  varchar (40) 
,shpact_sno  varchar (40) 
,transport_code  varchar (50) 
,prjno_code  varchar (50) 
,transport_name  varchar (100) 
,shelfno_name_fm  varchar (100) 
,shelfno_name_in  varchar (100) 
,prjno_name  varchar (100) 
,prjno_code_chil  varchar (50) 
,unit_code  varchar (50) 
,unit_name  varchar (100) 
,classlist_name  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,classlist_code  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,person_name_chrg  varchar (100) 
,person_code_chrg  varchar (50) 
,loca_name  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,loca_name_pare  varchar (100) 
,itm_code_pare  varchar (50) 
,itm_code  varchar (50) 
,itm_name_pare  varchar (100) 
,itm_name  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,loca_name_shelfno_in  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,shelfno_code_fm  varchar (50) 
,shelfno_code_in  varchar (50) 
,loca_code  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_code_pare  varchar (50) 
,loca_code_shelfno_in  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,shpact_cartonno  varchar (20) 
,shpact_paretblname  varchar (30) 
,shpact_paretblid  numeric (38,0)
,shpact_amt  numeric (18,4)
,shpact_expiredate   date 
,shpact_tax  numeric (38,4)
,shpact_price  numeric (38,4)
,shpact_box  varchar (50) 
,shpact_starttime   timestamp(6) 
,shpact_sno_shpord  varchar (50) 
,shpact_gno_shpord  varchar (50) 
,shpact_processseq  numeric (38,0)
,shpact_contract_price  varchar (1) 
,shpact_isudate   timestamp(6) 
,shpact_qty_case  numeric (22,0)
,itm_model  varchar (50) 
,instk_qty  numeric (22,6)
,itm_weight  numeric (22,0)
,itm_design  varchar (50) 
,person_email_chrg  varchar (50) 
,itm_deth  numeric (22,0)
,itm_length  numeric (22,0)
,itm_material  varchar (50) 
,itm_std  varchar (50) 
,scrlv_level1_chrg  varchar (1) 
,itm_wide  numeric (22,0)
,itm_datascale  numeric (22,0)
,trngantt_duedate   timestamp(6) 
,instk_starttime   timestamp(6) 
,instk_qty_stk  numeric (22,6)
,instk_lotno  varchar (50) 
,instk_packno  varchar (10) 
,instk_inoutflg  varchar (20) 
,instk_qty_sch  numeric (22,6)
,trngantt_processseq  numeric (38,0)
,unit_contents  varchar (4000) 
,alloctbl_srctblid  numeric (38,0)
,alloctbl_srctblname  varchar (30) 
,transport_contents  varchar (4000) 
,shpact_remark  varchar (4000) 
,shpact_contents  varchar (4000) 
,shpact_created_at   timestamp(6) 
,shpact_person_id_upd  numeric (38,0)
,shpact_chrg_id  numeric (38,0)
,shpact_instk_id  numeric (22,0)
,shpact_itm_id  numeric (38,0)
,shpact_prjno_id  numeric (38,0)
,shpact_transport_id  numeric (38,0)
,shpact_updated_at   timestamp(6) 
,shpact_update_ip  varchar (40) 
,id  numeric (38,0)
,shpact_id  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,instk_shelfno_id_in  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_classlist_id_pare  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,instk_alloctbl_id  numeric (38,0)
,trngantt_itm_id_pare  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,shelfno_loca_id_shelfno_in  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,chrg_person_id_chrg  numeric (38,0)
,alloctbl_trngantt_id  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,transport_expiredate   date 
,prjno_expiredate   date 
,boxe_expiredate   date 
,chrg_expiredate   date 
          ,sio_errline varchar(4000)
          ,sio_org_tblname varchar(30)
          ,sio_org_tblid numeric(22,0)
          ,sio_add_time date
          ,sio_replay_time date
          ,sio_result_f char(1)
          ,sio_message_code char(10)
          ,sio_message_contents varchar(4000)
          ,sio_chk_done char(1)
);
 CREATE INDEX sio_r_shpacts_uk1 
  ON sio.sio_r_shpacts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpacts_seq ;
 create sequence sio.sio_r_shpacts_seq ;
