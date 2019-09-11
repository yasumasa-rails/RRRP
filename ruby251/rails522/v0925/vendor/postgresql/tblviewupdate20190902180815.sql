
 alter table nditms DROP COLUMN duration CASCADE;

 ---- 使用しているview 
 ---- select * from pobject_code_scr,pobject_code_sfd,
							   case screenfield_selection when 1 then '選択有' else '' end select,
								case screenfield_hideflg when 1 then '' else '表示有' end display,
							   case screenfield_indisp when 1 then '必須' else '' end inquire from r_screenfields 
 ---- where  pobject_code_sfd = 'duration'
 ---- update screenfields set expiredate ='2000/01/01',remark =' 項目　durationが削除　2019-09-02 18:08:15 +0900' 
 ---- where  pobject_code_sfd = 'duration'
 alter table  nditms  ADD COLUMN consumminqty numeric(22,6);

 alter table  nditms  ADD COLUMN consumchgoverqty numeric(22,6);
