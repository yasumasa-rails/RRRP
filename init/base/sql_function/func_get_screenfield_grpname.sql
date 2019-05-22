create or replace function func_get_screenfield_grpname(email text,screen_code text) returns 
  table(screenfield_name text,screenfield_hideflg numeric,screenfield_editable numeric,
          screenfield_indisp numeric,pobject_code_view text,screen_strwhere text,
          screen_rows_per_page numeric,screen_rowlist text,screenfield_type text,
          screenfield_dataprecision numeric,screenfield_datascale numeric,
	  contents text,pobject_code_sfd text)
as $$
select case when x.name is null then  pobject_code_sfd else x.name end screenfield_name,
       screenfield_hideflg,screenfield_editable,screenfield_indisp ,
					pobject_code_view,screen_strwhere,screen_rows_per_page,
					screen_rowlist,screenfield_type,
					screenfield_dataprecision,screenfield_datascale,
					x.contents,pobject_code_sfd
      from r_screenfields s
	left join  ( select t.pobjects_id,t.name,t.contents from pobjgrps t 
				inner join  persons  p on p.usrgrps_id = t.usrgrps_id and email= $1) x
        on x.pobjects_id = s.screenfield_pobject_id_sfd 
 where pobject_code_scr = $2 and screenfield_expiredate > current_date and screenfield_selection = 1
        order by screenfield_seqno
$$
language sql

