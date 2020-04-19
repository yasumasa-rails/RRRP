
 alter table alloctbls DROP COLUMN packqty CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'packqty'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　packqtyが削除　2020-04-06 14:29:38 +0900' 
 ---- where  pobject_code_sfd = 'packqty'
 alter table alloctbls DROP COLUMN amt CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'amt'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　amtが削除　2020-04-06 14:29:38 +0900' 
 ---- where  pobject_code_sfd = 'amt'
 alter table alloctbls DROP COLUMN shuffle_flg CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'shuffle_flg'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　shuffle_flgが削除　2020-04-06 14:29:38 +0900' 
 ---- where  pobject_code_sfd = 'shuffle_flg'
 alter table alloctbls DROP COLUMN allocfree CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'allocfree'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　allocfreeが削除　2020-04-06 14:29:38 +0900' 
 ---- where  pobject_code_sfd = 'allocfree'
 alter table alloctbls DROP COLUMN allocfreeid CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'allocfreeid'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　allocfreeidが削除　2020-04-06 14:29:38 +0900' 
 ---- where  pobject_code_sfd = 'allocfreeid'
 alter table alloctbls DROP COLUMN shuffle_loca CASCADE;

 --- 使用しているview 
 --- select * from pobject_code_scr,pobject_code_sfd,
							---   case screenfield_selection when 1 then '選択有' else '' end select,
							---	case screenfield_hideflg when 1 then '' else '表示有' end display,
							---   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'shuffle_loca'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　shuffle_locaが削除　2020-04-06 14:29:38 +0900' 
 ---- where  pobject_code_sfd = 'shuffle_loca'
 alter table  alloctbls ALTER COLUMN qty  TYPE numeric(22,6);

 alter table  alloctbls  ADD COLUMN trngantts_id numeric(38,0);
