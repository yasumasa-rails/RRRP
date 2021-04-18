
truncate table purschs;
truncate table purords;
truncate table purinsts;
truncate table purdlvs;
truncate table puracts;
truncate table inamts;
truncate table outamts;
truncate table lotstkhists;

truncate table alloctbls cascade;

truncate table prdschs;
truncate table prdords;
truncate table prdinsts;
truncate table prdacts;


truncate table custschs;
truncate table custords cascade;
---truncate table custinsts;
---truncate table custacts;

truncate table trngantts cascade;
truncate table inspschs;
truncate table inspords;
truncate table inspinsts;
truncate table inspacts;
truncate table payschs;
truncate table payords;
truncate table payinsts;
----truncate table payacts;

truncate table processreqs;

truncate table shpschs;
truncate table shpords;
truncate table shpinsts;

truncate table shpacts;
truncate table mkordopeitms cascade;

truncate table mkords  cascade;
truncate table srctbls;
truncate table instks cascade;
truncate table outstks cascade;

commit;


truncate table sio.sio_r_purschs;
truncate table sio.sio_r_purords;
truncate table sio.sio_r_purinsts;
truncate table sio.sio_r_purdlvs;
truncate table sio.sio_r_puracts;
truncate table sio.sio_r_instks;
truncate table sio.sio_r_outstks;
truncate table sio.sio_r_inamts;
truncate table sio.sio_r_outamts;
truncate table sio.sio_r_lotstkhists;

truncate table sio.sio_r_alloctbls cascade;

truncate table sio.sio_r_prdschs;
truncate table sio.sio_r_prdords;
truncate table sio.sio_r_prdinsts;
truncate table sio.sio_r_prdacts;


truncate table sio.sio_r_custschs;
truncate table sio.sio_r_custords;
---truncate table sio.sio_r_custinsts;
---truncate table sio.sio_r_custacts;

truncate table sio.sio_r_trngantts cascade;
truncate table sio.sio_r_inspschs;
truncate table sio.sio_r_inspords;
truncate table sio.sio_r_inspinsts;
truncate table sio.sio_r_inspacts;
truncate table sio.sio_r_payschs;
truncate table sio.sio_r_payords;
truncate table sio.sio_r_payinsts;
----truncate table sio.sio_r_payacts;

truncate table sio.sio_r_processreqs;

truncate table sio.sio_r_shpschs;
truncate table sio.sio_r_shpords;

truncate table sio.sio_r_mkords;

truncate table sio.sio_r_srctbls;
truncate table sio.sio_r_shpacts;


REFRESH MATERIALIZED view  r_pobjects;
REFRESH MATERIALIZED view  r_fieldcodes;
REFRESH MATERIALIZED view r_blktbs ;
REFRESH MATERIALIZED view r_tblfields; 
REFRESH MATERIALIZED view r_screenfields; 
commit;

