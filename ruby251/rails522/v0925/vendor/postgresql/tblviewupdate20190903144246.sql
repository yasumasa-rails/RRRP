ALTER TABLE public.screenfields
				ADD CONSTRAINT screenfields_uky1 UNIQUE(screens_id,pobjects_id_sfd);
ALTER TABLE public.screenfields
				ADD CONSTRAINT screenfields_uky2 UNIQUE(paragraph,id);
