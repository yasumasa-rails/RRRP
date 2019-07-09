create or replace function func_get_screen_menu(email text) returns table(grp_name text,scr_name text,screen_code text,
						page_size numeric,contents text,pobject_code_sgrp text )
as $$
select case  when q.name is null then s.pobject_code_sgrp else q.name end as grp_name ,
	case  when x.name is null then s.pobject_code_scr else x.name end as scr_name ,
	s.pobject_code_scr screen_code,to_number(split_part(s.screen_rowlist,',',1),'9999') page_size,x.contents,
        s.pobject_code_sgrp
from r_screens s
      inner join persons on screen_scrlv_id = persons.scrlvs_id and  persons.email = $1
      left join  ( select t.pobjects_id,t.name from pobjgrps t 
			inner join  persons  p on p.usrgrps_id = t.usrgrps_id and email= $1) q
        on q.pobjects_id = s.pobject_id_sgrp 
      left join  ( select t.pobjects_id,t.name,t.contents from pobjgrps t 
			inner join  persons  p on p.usrgrps_id = t.usrgrps_id and email= $1) x
        on x.pobjects_id = s.pobject_id_scr
where s.pobject_code_sgrp !='#' order by  s.pobject_code_sgrp,s.screen_seqno
$$
language sql
