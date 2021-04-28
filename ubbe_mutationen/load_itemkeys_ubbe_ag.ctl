LOAD DATA
INFILE 'itemkeys_ubbe_ag.dat'
BADFILE 'itemkeys_ubbe_ag.bad'
REPLACE
INTO TABLE itemkeys_ubbe_ag
FIELDS TERMINATED BY ';' 
(ITEMKEY, ITEM_PROCESS_STATUS)
