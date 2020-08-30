
 alter table trngantts DROP COLUMN qty_handover CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'qty_handover'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　qty_handoverが削除　2020-06-19 23:49:51 +0900' 
 ---- where  pobject_code_sfd = 'qty_handover'
 --- drop view r_trngantts cascade  
 create or replace view r_trngantts as select  
trngantt.consumauto  trngantt_consumauto,
  shelfno_fm.shelfno_code  shelfno_code_fm ,
trngantt.processseq  trngantt_processseq,
  shelfno_fm.shelfno_name  shelfno_name_fm ,
  prjno.prjno_name  prjno_name ,
trngantt.starttime  trngantt_starttime,
  itm_pare.unit_code  unit_code_pare ,
  itm.unit_code  unit_code ,
  itm_pare.unit_name  unit_name_pare ,
  itm.unit_name  unit_name ,
trngantt.itms_id   trngantt_itm_id,
trngantt.shuffle_flg  trngantt_shuffle_flg,
trngantt.locas_id   trngantt_loca_id,
trngantt.consumminqty  trngantt_consumminqty,
trngantt.consumunitqty  trngantt_consumunitqty,
  itm_pare.itm_code  itm_code_pare ,
  itm.itm_code  itm_code ,
  itm_pare.itm_name  itm_name_pare ,
  itm.itm_name  itm_name ,
trngantt.consumchgoverqty  trngantt_consumchgoverqty,
trngantt.qty_stk  trngantt_qty_stk,
trngantt.tblname  trngantt_tblname,
trngantt.tblid  trngantt_tblid,
  loca_pare.loca_tel  loca_tel_pare ,
  shelfno_fm.loca_code_shelfno  loca_code_shelfno_fm ,
  loca_pare.loca_code  loca_code_pare ,
  loca.loca_code  loca_code ,
  shelfno_fm.loca_name_shelfno  loca_name_shelfno_fm ,
  loca_pare.loca_name  loca_name_pare ,
  loca.loca_name  loca_name ,
  person_upd.person_code  person_code_upd ,
  person_upd.person_name  person_name_upd ,
  itm_pare.itm_unit_id  itm_unit_id_pare ,
  itm.itm_unit_id  itm_unit_id ,
  itm_pare.itm_classlist_id  itm_classlist_id_pare ,
  itm.itm_classlist_id  itm_classlist_id ,
trngantt.id  trngantt_id,
trngantt.id id,
trngantt.remark  trngantt_remark,
trngantt.expiredate  trngantt_expiredate,
trngantt.persons_id_upd   trngantt_person_id_upd,
trngantt.update_ip  trngantt_update_ip,
trngantt.updated_at  trngantt_updated_at,
trngantt.parenum  trngantt_parenum,
trngantt.chilnum  trngantt_chilnum,
trngantt.created_at  trngantt_created_at,
trngantt.duedate  trngantt_duedate,
trngantt.mlevel  trngantt_mlevel,
trngantt.orgtblname  trngantt_orgtblname,
trngantt.key  trngantt_key,
trngantt.shelfnos_id_fm   trngantt_shelfno_id_fm,
trngantt.itms_id_pare   trngantt_itm_id_pare,
trngantt.processseq_pare  trngantt_processseq_pare,
trngantt.locas_id_pare   trngantt_loca_id_pare,
trngantt.qty_stk_pare  trngantt_qty_stk_pare,
trngantt.qty_pare  trngantt_qty_pare,
  itm_pare.classlist_code  classlist_code_pare ,
  itm.classlist_code  classlist_code ,
trngantt.qty_alloc  trngantt_qty_alloc,
trngantt.qty_pare_alloc  trngantt_qty_pare_alloc,
trngantt.duedate_org  trngantt_duedate_org,
trngantt.qty_linkto_alloctbl  trngantt_qty_linkto_alloctbl,
trngantt.qty  trngantt_qty,
  itm_pare.classlist_name  classlist_name_pare ,
  itm.classlist_name  classlist_name ,
trngantt.consumtype  trngantt_consumtype,
trngantt.paretblname  trngantt_paretblname,
trngantt.paretblid  trngantt_paretblid,
  prjno.prjno_code_chil  prjno_code_chil ,
trngantt.orgtblid  trngantt_orgtblid,
  prjno.prjno_code  prjno_code ,
  shelfno_fm.shelfno_loca_id_shelfno  shelfno_loca_id_shelfno_fm ,
trngantt.prjnos_id   trngantt_prjno_id
 from trngantts   trngantt,
  r_itms  itm ,  r_locas  loca ,  r_persons  person_upd ,  r_shelfnos  shelfno_fm ,  r_itms  itm_pare ,  r_locas  loca_pare ,  r_prjnos  prjno 
  where       trngantt.itms_id = itm.id      and trngantt.locas_id = loca.id      and trngantt.persons_id_upd = person_upd.id      and trngantt.shelfnos_id_fm = shelfno_fm.id      and trngantt.itms_id_pare = itm_pare.id      and trngantt.locas_id_pare = loca_pare.id      and trngantt.prjnos_id = prjno.id     ;
 DROP TABLE IF EXISTS sio.sio_r_trngantts;
 CREATE TABLE sio.sio_r_trngantts (
          sio_id numeric(38,0)  CONSTRAINT SIO_r_trngantts_id_pk PRIMARY KEY           ,sio_user_code numeric(38,0)
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
,trngantt_orgtblname  varchar (30) 
,trngantt_orgtblid  numeric (22,0)
,trngantt_paretblname  varchar (30) 
,trngantt_paretblid  numeric (38,0)
,trngantt_tblname  varchar (30) 
,trngantt_tblid  numeric (38,0)
,itm_code  varchar (50) 
,itm_name  varchar (100) 
,trngantt_processseq  numeric (38,0)
,trngantt_duedate   timestamp(6) 
,trngantt_qty  numeric (18,4)
,trngantt_qty_stk  numeric (22,0)
,trngantt_qty_alloc  numeric (22,6)
,trngantt_qty_linkto_alloctbl  numeric (22,0)
,trngantt_qty_pare  numeric (22,6)
,trngantt_qty_stk_pare  numeric (22,6)
,trngantt_qty_pare_alloc  numeric (22,6)
,classlist_code  varchar (50) 
,unit_name  varchar (100) 
,shelfno_code_fm  varchar (50) 
,itm_code_pare  varchar (50) 
,itm_name_pare  varchar (100) 
,loca_code_shelfno_fm  varchar (50) 
,loca_code_pare  varchar (50) 
,loca_code  varchar (50) 
,loca_name_shelfno_fm  varchar (100) 
,loca_name_pare  varchar (100) 
,loca_name  varchar (100) 
,classlist_name  varchar (100) 
,classlist_name_pare  varchar (100) 
,unit_name_pare  varchar (100) 
,classlist_code_pare  varchar (50) 
,shelfno_name_fm  varchar (100) 
,unit_code_pare  varchar (50) 
,unit_code  varchar (50) 
,trngantt_consumchgoverqty  numeric (22,6)
,trngantt_duedate_org   timestamp(6) 
,trngantt_consumunitqty  numeric (22,6)
,trngantt_consumminqty  numeric (22,6)
,trngantt_starttime   timestamp(6) 
,trngantt_consumtype  varchar (3) 
,trngantt_processseq_pare  numeric (38,0)
,trngantt_key  varchar (250) 
,trngantt_mlevel  numeric (3,0)
,itm_datascale  numeric (22,0)
,itm_std_pare  varchar (50) 
,itm_std  varchar (50) 
,itm_model_pare  varchar (50) 
,itm_model  varchar (50) 
,itm_material_pare  varchar (50) 
,itm_material  varchar (50) 
,itm_design_pare  varchar (50) 
,itm_design  varchar (50) 
,itm_weight_pare  numeric (22,0)
,itm_weight  numeric (22,0)
,itm_length_pare  numeric (22,0)
,itm_length  numeric (22,0)
,itm_wide_pare  numeric (22,0)
,itm_wide  numeric (22,0)
,itm_deth_pare  numeric (22,0)
,itm_deth  numeric (22,0)
,loca_abbr_pare  varchar (50) 
,loca_abbr  varchar (50) 
,loca_zip_pare  varchar (10) 
,loca_zip  varchar (10) 
,loca_country_pare  varchar (20) 
,loca_country  varchar (20) 
,loca_prfct_pare  varchar (20) 
,loca_prfct  varchar (20) 
,loca_addr1_pare  varchar (50) 
,loca_addr1  varchar (50) 
,loca_addr2_pare  varchar (50) 
,loca_addr2  varchar (50) 
,loca_tel_pare  varchar (20) 
,loca_tel  varchar (20) 
,loca_fax_pare  varchar (20) 
,loca_fax  varchar (20) 
,loca_mail_pare  varchar (20) 
,loca_mail  varchar (20) 
,itm_datascale_pare  numeric (22,0)
,unit_contents_pare  varchar (4000) 
,unit_contents  varchar (4000) 
,shelfno_contents_fm  varchar (4000) 
,trngantt_parenum  numeric (22,0)
,trngantt_chilnum  numeric (22,0)
,trngantt_shuffle_flg  varchar (1) 
,prjno_code  varchar (50) 
,prjno_name  varchar (100) 
,trngantt_consumauto  varchar (1) 
,trngantt_expiredate   date 
,trngantt_remark  varchar (4000) 
,trngantt_updated_at   timestamp(6) 
,trngantt_update_ip  varchar (40) 
,trngantt_shelfno_id_fm  numeric (22,0)
,trngantt_itm_id_pare  numeric (38,0)
,trngantt_person_id_upd  numeric (38,0)
,trngantt_prjno_id  numeric (38,0)
,trngantt_loca_id_pare  numeric (38,0)
,trngantt_id  numeric (38,0)
,trngantt_loca_id  numeric (38,0)
,trngantt_itm_id  numeric (38,0)
,itm_unit_id  numeric (22,0)
,itm_classlist_id  numeric (38,0)
,shelfno_loca_id_shelfno_fm  numeric (38,0)
,itm_unit_id_pare  numeric (22,0)
,itm_classlist_id_pare  numeric (38,0)
,trngantt_created_at  numeric (22,0)
,person_code_upd  varchar (50) 
,person_name_upd  varchar (100) 
,id  numeric (38,0)
,prjno_code_chil  varchar (50) 
,prjno_expiredate   date 
,prjno_id  numeric (22,0)
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
 CREATE INDEX sio_r_trngantts_uk1 
  ON sio.sio_r_trngantts(sio_user_code,sio_session_counter,sio_session_id,sio_Command_Response); 

 drop sequence  if exists sio.sio_r_trngantts_seq ;
 create sequence sio.sio_r_trngantts_seq ;
