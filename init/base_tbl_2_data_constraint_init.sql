insert into  Persons(id,code,name, UsrGrps_id,Sects_id,email,Expiredate,Persons_id_Upd,scrlvs_id)
values(0,'0','system',0,0,'system@rrrp.com','2099/12/31',0,0)
;

insert into  locas(id,code,name, persons_id_upd,Expiredate)
values(0,'0','system',0,'2099/12/31')
;

insert into  sects(id,Locas_id_sect, persons_id_upd,Expiredate)
values(0,0,0,'2099/12/31')
;

insert into  scrlvs(id,code, persons_id_upd,Expiredate)
values(0,'0',0,'2099/12/31')
;

insert into  usrgrps(id,code,name, persons_id_upd,Expiredate)
values(0,'0','system',0,'2099/12/31')
;

insert into PRJNOS(id,code,name, persons_id_upd,Expiredate,priority,prjnos_id_chil)
values(0,'dummy','共通',0,'2099/12/31',0,0)
;


ALTER TABLE userprocs ADD  CONSTRAINT userprocs_Persons_id_Upd  FOREIGN KEY ( Persons_id_Upd ) REFERENCES Persons(id );

ALTER TABLE persons ADD  CONSTRAINT persons_Persons_id_Upd  FOREIGN KEY ( Persons_id_Upd ) REFERENCES Persons(id );

ALTER TABLE persons ADD  CONSTRAINT persons_UsrGrps_id   FOREIGN KEY ( UsrGrps_id  ) REFERENCES UsrGrps (id );

ALTER TABLE persons ADD  CONSTRAINT persons_sects_id  FOREIGN KEY ( sects_id ) REFERENCES sects (id );

ALTER TABLE persons ADD  CONSTRAINT persons_scrlvs_id  FOREIGN KEY ( scrlvs_id ) REFERENCES scrlvs (id );

ALTER TABLE locas ADD  CONSTRAINT locas_Persons_id_Upd  FOREIGN KEY ( Persons_id_Upd ) REFERENCES Persons(id );

ALTER TABLE sects ADD  CONSTRAINT sects_Persons_id_Upd  FOREIGN KEY ( Persons_id_Upd ) REFERENCES Persons(id );

ALTER TABLE sects ADD  CONSTRAINT sects_locas_id_sect   foreign key(locas_id_sect) REFERENCES locas(id );

ALTER TABLE scrlvs ADD  CONSTRAINT scrlvs_Persons_id_Upd  FOREIGN KEY ( Persons_id_Upd ) REFERENCES Persons(id );

ALTER TABLE prjnos ADD CONSTRAINT PRJNO_PRJNOS_ID_CHIL FOREIGN KEY (PRJNOS_ID_CHIL)	  REFERENCES PRJNOS (ID);

---seqをmaxに変更