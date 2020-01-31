ALTER TABLE public.alloctbls
				ADD CONSTRAINT alloctbls_uky10 UNIQUE(srctblname,id,srctblid);
ALTER TABLE public.alloctbls
				ADD CONSTRAINT alloctbls_uky20 UNIQUE(destblname,id,destblid);
ALTER TABLE public.alloctbls
				ADD CONSTRAINT alloctbls_uky30 UNIQUE(allocfree,id,qty,destblname);
ALTER TABLE public.alloctbls
				ADD CONSTRAINT alloctbls_uky40 UNIQUE(allocfree,id,qty_stk,destblname);
ALTER TABLE public.billacts
				ADD CONSTRAINT billacts_ukysno UNIQUE(sno);
ALTER TABLE public.billests
				ADD CONSTRAINT billests_ukysno UNIQUE(sno);
ALTER TABLE public.billinsts
				ADD CONSTRAINT billinsts_ukysno UNIQUE(sno);
ALTER TABLE public.billords
				ADD CONSTRAINT billords_ukysno UNIQUE(sno);
ALTER TABLE public.billschs
				ADD CONSTRAINT billschs_ukysno UNIQUE(sno);
ALTER TABLE public.blktbs
				ADD CONSTRAINT blktbs_uky1 UNIQUE(pobjects_id_tbl);
