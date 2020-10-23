
 --- drop view r_shpinsts cascade  
 create or replace view r_shpinsts as select  
shpinst.prjnos_id   shpinst_prjno_id,
shpinst.transports_id   shpinst_transport_id,
shpinst.paretblid  shpinst_paretblid,
shpinst.paretblname  shpinst_paretblname,
  outstk.shelfno_code_out  shelfno_code_out ,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
  transport.transport_code  transport_code ,
shpinst.itms_id   shpinst_itm_id,
shpinst.outstks_id   shpinst_outstk_id,
  transport.transport_name  transport_name ,
  outstk.shelfno_name_out  shelfno_name_out ,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  prjno.prjno_name  prjno_name ,
shpinst.qty_shortage  shpinst_qty_shortage,
shpinst.qty_stk  shpinst_qty_stk,
shpinst.shelfnos_id_fm   shpinst_shelfno_id_fm,
  outstk.trngantt_itm_id  trngantt_itm_id ,
  outstk.unit_code_pare  unit_code_pare ,
  itm.unit_code  unit_code ,
  outstk.unit_name_pare  unit_name_pare ,
  itm.unit_name  unit_name ,
  outstk.trngantt_loca_id  trngantt_loca_id ,
  outstk.itm_code_pare  itm_code_pare ,
  itm.itm_code  itm_code ,
  outstk.itm_name_pare  itm_name_pare ,
  itm.itm_name  itm_name ,
  chrg.scrlv_code_chrg  scrlv_code_chrg ,
shpinst.id  shpinst_id,
shpinst.id id,
shpinst.starttime  shpinst_starttime,
shpinst.locas_id_to   shpinst_loca_id_to,
shpinst.sno  shpinst_sno,
shpinst.remark  shpinst_remark,
shpinst.expiredate  shpinst_expiredate,
shpinst.update_ip  shpinst_update_ip,
shpinst.created_at  shpinst_created_at,
shpinst.updated_at  shpinst_updated_at,
shpinst.persons_id_upd   shpinst_person_id_upd,
shpinst.amt  shpinst_amt,
shpinst.qty  shpinst_qty,
shpinst.tax  shpinst_tax,
shpinst.price  shpinst_price,
  outstk.loca_code_shelfno_out  loca_code_shelfno_out ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  outstk.loca_code_pare  loca_code_pare ,
  chrg.loca_code_sect_chrg  loca_code_sect_chrg ,
  loca_to.loca_code  loca_code_to ,
  outstk.loca_code  loca_code ,
  outstk.loca_name_shelfno_out  loca_name_shelfno_out ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  outstk.loca_name_pare  loca_name_pare ,
  chrg.loca_name_sect_chrg  loca_name_sect_chrg ,
  loca_to.loca_name  loca_name_to ,
  chrg.person_code_chrg  person_code_chrg ,
  chrg.person_name_chrg  person_name_chrg ,
  outstk.itm_unit_id_pare  itm_unit_id_pare ,
  itm.itm_unit_id  itm_unit_id ,
  outstk.itm_classlist_id_pare  itm_classlist_id_pare ,
  itm.itm_classlist_id  itm_classlist_id ,
  outstk.trngantt_shelfno_id_fm  trngantt_shelfno_id_fm ,
  outstk.trngantt_itm_id_pare  trngantt_itm_id_pare ,
  outstk.outstk_alloctbl_id  outstk_alloctbl_id ,
  outstk.trngantt_loca_id_pare  trngantt_loca_id_pare ,
  outstk.outstk_shelfno_id_out  outstk_shelfno_id_out ,
  chrg.usrgrp_name_chrg  usrgrp_name_chrg ,
  itm.classlist_code  classlist_code ,
  outstk.alloctbl_trngantt_id  alloctbl_trngantt_id ,
shpinst.chrgs_id   shpinst_chrg_id,
  chrg.person_sect_id_chrg  person_sect_id_chrg ,
  chrg.usrgrp_code_chrg  usrgrp_code_chrg ,
  itm.classlist_name  classlist_name ,
  prjno.prjno_code_chil  prjno_code_chil ,
shpinst.processseq  shpinst_processseq,
  prjno.prjno_code  prjno_code ,
  outstk.shelfno_loca_id_shelfno_out  shelfno_loca_id_shelfno_out ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
  outstk.trngantt_prjno_id  trngantt_prjno_id ,
  chrg.chrg_person_id_chrg  chrg_person_id_chrg ,
shpinst.contents  shpinst_contents,
shpinst.contract_price  shpinst_contract_price,
shpinst.gno  shpinst_gno,
shpinst.isudate  shpinst_isudate,
shpinst.box  shpinst_box,
shpinst.duedate  shpinst_duedate,
shpinst.cno  shpinst_cno,
shpinst.qty_case  shpinst_qty_case,
shpinst.cartonno  shpinst_cartonno
 from shpinsts   shpinst,
  r_prjnos  prjno ,  r_transports  transport ,  r_itms  itm ,  r_outstks  outstk ,  r_shelfnos  shelfno_fm ,  r_locas  loca_to ,  r_persons  person_upd ,  r_chrgs  chrg 
  where       shpinst.prjnos_id = prjno.id      and shpinst.transports_id = transport.id      and shpinst.itms_id = itm.id      and shpinst.outstks_id = outstk.id      and shpinst.shelfnos_id_fm = shelfno_fm.id      and shpinst.locas_id_to = loca_to.id      and shpinst.persons_id_upd = person_upd.id      and shpinst.chrgs_id = chrg.id     ;
 DROP TABLE IF EXISTS sio.sio_r_shpinsts;
 CREATE TABLE sio.sio_r_shpinsts (
          sio_id numeric(22,0)  CONSTRAINT SIO_r_shpinsts_id_pk PRIMARY KEY           ,sio_user_code numeric(22,0)
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
,shpinst_sno  varchar (40) 
,shpinst_gno  varchar (40) 
,shpinst_cno  varchar (40) 
,prjno_code_chil  varchar (50) 
,prjno_name  varchar (100) 
,unit_name  varchar (100) 
,shelfno_code_out  varchar (50) 
,shelfno_code_fm  varchar (50) 
,transport_code  varchar (50) 
,itm_code_pare  varchar (50) 
,itm_code  varchar (50) 
,itm_name_pare  varchar (100) 
,itm_name  varchar (100) 
,scrlv_code_chrg  varchar (50) 
,prjno_code  varchar (50) 
,shelfno_name_fm  varchar (100) 
,classlist_name  varchar (100) 
,usrgrp_code_chrg  varchar (50) 
,classlist_code  varchar (50) 
,usrgrp_name_chrg  varchar (100) 
,transport_name  varchar (100) 
,shelfno_name_out  varchar (100) 
,loca_code_shelfno_out  varchar (50) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_pare  varchar (50) 
,loca_code_sect_chrg  varchar (50) 
,loca_code_to  varchar (50) 
,loca_code  varchar (50) 
,loca_name_shelfno_out  varchar (100) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_pare  varchar (100) 
,loca_name_sect_chrg  varchar (100) 
,loca_name_to  varchar (100) 
,person_code_chrg  varchar (50) 
,person_name_chrg  varchar (100) 
,unit_code_pare  varchar (50) 
,unit_code  varchar (50) 
,unit_name_pare  varchar (100) 
,shpinst_box  varchar (50) 
,shpinst_qty_shortage  numeric (22,5)
,shpinst_isudate   timestamp(6) 
,shpinst_paretblname  varchar (30) 
,shpinst_cartonno  varchar (20) 
,shpinst_starttime   timestamp(6) 
,shpinst_processseq  numeric (38,0)
,shpinst_qty_stk  numeric (22,6)
,shpinst_paretblid  numeric (38,0)
,shpinst_duedate   timestamp(6) 
,shpinst_qty_case  numeric (22,0)
,shpinst_amt  numeric (18,4)
,shpinst_expiredate   date 
,shpinst_qty  numeric (22,6)
,shpinst_tax  numeric (38,4)
,shpinst_price  numeric (38,4)
,shpinst_contract_price  varchar (1) 
,itm_wide  numeric (22,0)
,outstk_qty  numeric (22,6)
,trngantt_processseq  numeric (38,0)
,itm_std  varchar (50) 
,itm_model  varchar (50) 
,itm_material  varchar (50) 
,itm_design  varchar (50) 
,itm_weight  numeric (22,0)
,itm_length  numeric (22,0)
,itm_deth  numeric (22,0)
,loca_abbr_to  varchar (50) 
,loca_zip_to  varchar (10) 
,loca_country_to  varchar (20) 
,loca_prfct_to  varchar (20) 
,loca_addr1_to  varchar (50) 
,loca_addr2_to  varchar (50) 
,loca_tel_to  varchar (20) 
,loca_fax_to  varchar (20) 
,loca_mail_to  varchar (20) 
,person_email_chrg  varchar (50) 
,scrlv_level1_chrg  varchar (1) 
,itm_datascale  numeric (22,0)
,trngantt_duedate   timestamp(6) 
,outstk_starttime   timestamp(6) 
,outstk_qty_stk  numeric (22,6)
,outstk_lotno  varchar (50) 
,outstk_packno  varchar (10) 
,outstk_inoutflg  varchar (20) 
,unit_contents  varchar (4000) 
,transport_contents  varchar (4000) 
,alloctbl_srctblname  varchar (30) 
,alloctbl_srctblid  numeric (38,0)
,shelfno_contents_fm  varchar (4000) 
,outstk_qty_sch  numeric (22,6)
,shpinst_remark  varchar (4000) 
,shpinst_contents  varchar (4000) 
,shpinst_prjno_id  numeric (38,0)
,shpinst_person_id_upd  numeric (38,0)
,shpinst_updated_at   timestamp(6) 
,shpinst_chrg_id  numeric (38,0)
,shpinst_created_at   timestamp(6) 
,shpinst_update_ip  varchar (40) 
,shpinst_loca_id_to  numeric (38,0)
,shpinst_shelfno_id_fm  numeric (22,0)
,shpinst_outstk_id  numeric (22,0)
,id  numeric (38,0)
,shpinst_itm_id  numeric (38,0)
,shpinst_transport_id  numeric (38,0)
,shpinst_id  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,chrg_person_id_chrg  numeric (38,0)
,shelfno_loca_id_shelfno_out  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,itm_unit_id  numeric (22,0)
,outstk_shelfno_id_out  numeric (22,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,itm_classlist_id_pare  numeric (38,0)
,alloctbl_trngantt_id  numeric (38,0)
,itm_classlist_id  numeric (38,0)
,person_sect_id_chrg  numeric (22,0)
,outstk_alloctbl_id  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,trngantt_shelfno_id_fm  numeric (22,0)
,trngantt_itm_id_pare  numeric (38,0)
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
 CREATE INDEX sio_r_shpinsts_uk1 
  ON sio.sio_r_shpinsts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_shpinsts_seq ;
 create sequence sio.sio_r_shpinsts_seq ;
