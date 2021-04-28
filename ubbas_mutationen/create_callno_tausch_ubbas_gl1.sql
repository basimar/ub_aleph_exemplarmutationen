drop table callno_tausch_ubbas_gl1;
create table callno_tausch_ubbas_gl1
storage(initial 20M next 1M maxextents 505)
       tablespace ts0
as select
z30_REC_KEY as z30reckey,
z30_call_no_type as z30type,
z30_call_no as z30callno,
z30_call_no_key as z30callnokey,
z30_call_no_2_type as z30type2,
z30_call_no_2 as z30callno2,
z30_call_no_2_key as z30callnokey2
from z30 right outer join itemkeys_ubbas_gl1 on z30_rec_key = itemkey;

EXIT;
