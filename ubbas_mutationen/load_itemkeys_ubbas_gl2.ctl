LOAD DATA
INFILE 'itemkeys_ubbas_gl2.dat'
BADFILE 'itemkeys_ubbas_gl2.bad'
REPLACE
INTO TABLE itemkeys_ubbas_gl2
FIELDS TERMINATED BY ';' 
(ITEMKEY, ITEM_PROCESS_STATUS, ITEM_COLLECTION, ITEM_STATUS, ITEM_SUBLIB)