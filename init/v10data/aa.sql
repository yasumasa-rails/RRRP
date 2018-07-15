  select s.id id,pobject_code_scr,
  case when pobjgrp_name_scr is null then  pobject_code_scr else  pobjgrp_name_scr end,
  screen_seqno seqno,
  screen_created_at created_at from r_screens s
  left join(
  select g.name  pobjgrp_name_scr,pobjects_id from pobjgrps g
  inner join (
  select p.usrgrps_id  usrgrps_id from usrgrps u
  inner join persons p on  p.usrgrps_id = u.id
  where p.email = 'system@rrrp.com') v
  on g.usrgrps_id = v.usrgrps_id
  ) gg
  on s.pobject_id_scr =  gg.pobjects_id
  where pobject_code_sgrp !='#' and screen_expiredate > current_date


select  pobject_id_sgrp id,pobject_code_sgrp ,
max(case when pobjgrp_name_sgrp is null then  pobject_code_sgrp else  pobjgrp_name_sgrp end) pobjgrp_name_sgrp,
max(screen_created_at) created_at from r_screens s
left join(
select g.name  pobjgrp_name_sgrp,pobjects_id from pobjgrps g
inner join (
select p.usrgrps_id  usrgrps_id from usrgrps u
inner join persons p on  p.usrgrps_id = u.id
where p.email = 'system@rrrp.com') v
on g.usrgrps_id = v.usrgrps_id
) gg
on s.pobject_id_sgrp =  gg.pobjects_id
where pobject_code_sgrp !='#' 
and pobject_expiredate_sgrp > current_date
group by pobject_id_sgrp,pobject_code_sgrp



select * from r_screens

select * from pobjgrps