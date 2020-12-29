ALTER TABLE public.alloctbls
				ADD CONSTRAINT alloctbls_uky10 UNIQUE(srctblname,id,srctblid,trngantts_id);
