LOAD DATA
INFILE 'itemkeys_ubbe_gl1.dat'
BADFILE 'itemkeys_ubbe_gl1.bad'
REPLACE
INTO TABLE itemkeys_ubbe_gl1
FIELDS TERMINATED BY ';' 
(ITEMKEY, ITEM_PROCESS_STATUS, ITEM_COLLECTION, ITEM_STATUS, ITEM_SUBLIB)