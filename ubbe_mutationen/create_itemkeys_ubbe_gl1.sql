drop table itemkeys_ubbe_gl1; 
create table itemkeys_ubbe_gl1 
   (ITEMKEY CHAR (15),
    ITEM_PROCESS_STATUS CHAR (2),
    ITEM_COLLECTION CHAR (5),
    ITEM_STATUS CHAR (2),
    ITEM_SUBLIB CHAR (5))
   storage (initial 20M next 5M maxextents 200)
    tablespace ts0;
exit;
