ALTER TABLE public.custschs
				ADD CONSTRAINT custschs_uky10 UNIQUE(sno);
ALTER TABLE public.custschs
				ADD CONSTRAINT custschs_uky20 UNIQUE(custs_id,cno);
