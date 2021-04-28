drop table itemkeys_ubbas_ag; 
create table itemkeys_ubbas_ag 
   (ITEMKEY CHAR (15),
    ITEM_PROCESS_STATUS CHAR (2))
   storage (initial 10M next 2M maxextents 200)
    tablespace ts0;
exit;
