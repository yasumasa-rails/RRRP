ALTER TABLE public.lotstkhists
				ADD CONSTRAINT lotstkhists_uky10 UNIQUE(itms_id,processseq,shelfnos_id,prjnos_id,lotno,packno,starttime);
