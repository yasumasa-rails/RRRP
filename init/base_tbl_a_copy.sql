<<<<<<< HEAD
﻿copy pobjects   (id, remark, persons_id_upd, update_ip, created_at, expiredate,  updated_at, code, contents, objecttype )   FROM '/mnt/c/ubuntu/RRRP/init/v10data/POBJECTS.csv' CSV HEADER ;

copy screens(ID,STRSELECT,STRWHERE,STRGROUPORDER,YMLCODE,CDRFLAYOUT,EXPIREDATE,REMARK,PERSONS_ID_UPD,UPDATE_IP,CREATED_AT,UPDATED_AT,POBJECTS_ID_SCR,POBJECTS_ID_VIEW, pobjects_id_sgrp,SEQNO,ROWS_PER_PAGE,ROWLIST,HEIGHT,FORM_PS,SCRLVS_ID,CONTENTS,STRORDER) 
FROM '/mnt/c/ubuntu/RRRP/init/v10data/RAILS.SCREENS.csv' CSV HEADER ;

copy blktbs( ID , POBJECTS_ID_TBL , REMARK , PERSONS_ID_UPD , UPDATE_IP , CREATED_AT , EXPIREDATE , UPDATED_AT , SELTBLS , CONTENTS ) FROM '/mnt/c/ubuntu/RRRP/init/v10data/BLKTBS.csv' CSV HEADER ;

copy fieldcodes( ID , POBJECTS_ID_FLD , FTYPE , FIELDLENGTH , DATASCALE , REMARK , PERSONS_ID_UPD , UPDATE_IP , CREATED_AT , EXPIREDATE , UPDATED_AT , DATAPRECISION , SEQNO , CONTENTS ) FROM '/mnt/c/ubuntu/RRRP/init/v10data/FIELDCODES.csv' CSV HEADER ;

copy tblfields( ID , BLKTBS_ID , FIELDCODES_ID , EXPIREDATE , REMARK , PERSONS_ID_UPD , UPDATE_IP , CREATED_AT , UPDATED_AT , SEQNO , CONTENTS , VIEWFLMK )  FROM '/mnt/c/ubuntu/RRRP/init/v10data/TBLFIELDS.csv' CSV HEADER ;

copy screenfields (ID,SCREENS_ID,SELECTION,HIDEFLG,SEQNO,ROWPOS,COLPOS,WIDTH,TYPE,DATAPRECISION,DATASCALE,INDISP,SUBINDISP,EDITABLE,MAXVALUE,MINVALUE,EDOPTSIZE,EDOPTMAXLENGTH,EDOPTROW,EDOPTCOLS,EDOPTVALUE,SUMKEY,CRTFIELD,EXPIREDATE,REMARK,PERSONS_ID_UPD,UPDATE_IP,CREATED_AT,UPDATED_AT,POBJECTS_ID_SFD,PARAGRAPH,FORMATTER,CONTENTS,TBLFIELDS_ID)  FROM '/mnt/c/ubuntu/RRRP/init/v10data/SCREENFIELDS.csv' CSV HEADER ;


;

select pobjects_id_sgrp from screens; 

select * from pobjects where id = 13198;

select * from pobjects where id = 17489;

select * from pobjects where objecttype = 'screen_group';
=======
copy pobjects   (id, remark, persons_id_upd, update_ip, created_at, expiredate,  updated_at, code, contents, objecttype )   FROM '/mnt/c/ubuntu/RRRP/init/v10data/POBJECTS.csv' CSV HEADER ;

copy screens   (ID,STRSELECT,STRWHERE,STRGROUPORDER,YMLCODE,CDRFLAYOUT,EXPIREDATE,REMARK,PERSONS_ID_UPD,UPDATE_IP,CREATED_AT,UPDATED_AT,POBJECTS_ID_SCR,POBJECTS_ID_VIEW,ROWS_PER_PAGE,ROWLIST,HEIGHT,FORM_PS,GRPCODENAME,SCRLVS_ID,CONTENTS,STRORDER)  FROM '/mnt/c/ubuntu/RRRP/init/v10data/SCREENS.csv' CSV HEADER ;

copy blktbs( ID , POBJECTS_ID_TBL , REMARK , PERSONS_ID_UPD , UPDATE_IP , CREATED_AT , EXPIREDATE , UPDATED_AT , SELTBLS , CONTENTS ) FROM '/mnt/c/ubuntu/RRRP/init/v10data/BLKTBS.csv' CSV HEADER ;

copy fieldcodes( ID , POBJECTS_ID_FLD , FTYPE , FIELDLENGTH , DATASCALE , REMARK , PERSONS_ID_UPD , UPDATE_IP , CREATED_AT , EXPIREDATE , UPDATED_AT , DATAPRECISION , SEQNO , CONTENTS ) FROM '/mnt/c/ubuntu/RRRP/init/v10data/FIELDCODES.csv' CSV HEADER ;

copy tblfields( ID , BLKTBS_ID , FIELDCODES_ID , EXPIREDATE , REMARK , PERSONS_ID_UPD , UPDATE_IP , CREATED_AT , UPDATED_AT , SEQNO , CONTENTS , VIEWFLMK )  FROM '/mnt/c/ubuntu/RRRP/init/v10data/TBLFIELDS.csv' CSV HEADER ;

copy screenfields (ID,SCREENS_ID,SELECTION,HIDEFLG,SEQNO,ROWPOS,COLPOS,WIDTH,TYPE,DATAPRECISION,DATASCALE,INDISP,SUBINDISP,EDITABLE,MAXVALUE,MINVALUE,EDOPTSIZE,EDOPTMAXLENGTH,EDOPTROW,EDOPTCOLS,EDOPTVALUE,SUMKEY,CRTFIELD,EXPIREDATE,REMARK,PERSONS_ID_UPD,UPDATE_IP,CREATED_AT,UPDATED_AT,POBJECTS_ID_SFD,PARAGRAPH,FORMATTER,CONTENTS,TBLFIELDS_ID)  FROM '/mnt/c/ubuntu/RRRP/init/v10data/SCREENFIELDS.csv' CSV HEADER ;
>>>>>>> 843829d17aa56bb9d40c70f15ccfde4646042b07
