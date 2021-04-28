drop table itemkeys_ubbe; 
create table itemkeys_ubbe 
   (ITEMKEY CHAR (15),
    ITEM_COLLECTION CHAR (5),
    ITEM_STATUS CHAR (2),
    ITEM_PROCESS_STATUS CHAR (2),
    ITEM_NOTE_CIRC CHAR (200),
    ITEM_NOTE_OPAC CHAR (200))
   storage (initial 20M next 5M maxextents 200)
    tablespace ts0;
exit;
