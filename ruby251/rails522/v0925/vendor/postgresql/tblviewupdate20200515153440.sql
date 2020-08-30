ALTER TABLE public.opeitms
				drop CONSTRAINT opeitms_uky1 cascade;
ALTER TABLE public.opeitms
				ADD CONSTRAINT opeitms_uky1 UNIQUE(itms_id,processseq,priority);
ALTER TABLE public.opeitms
				drop CONSTRAINT opeitms_uky2 cascade;
ALTER TABLE public.opeitms
				ADD CONSTRAINT opeitms_uky2 UNIQUE(itms_id,processseq,locas_id);
ALTER TABLE public.opeitms
				ADD CONSTRAINT opeitms_uky3 UNIQUE(itms_id,id);
