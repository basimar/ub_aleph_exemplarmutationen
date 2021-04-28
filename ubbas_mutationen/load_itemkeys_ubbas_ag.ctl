LOAD DATA
INFILE 'itemkeys_ubbas_ag.dat'
BADFILE 'itemkeys_ubbas_ag.bad'
REPLACE
INTO TABLE itemkeys_ubbas_ag
FIELDS TERMINATED BY ';' 
(ITEMKEY, ITEM_PROCESS_STATUS)
