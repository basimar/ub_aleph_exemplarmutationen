LOAD DATA
INFILE 'itemkeys_ubbe_nv.dat'
BADFILE 'itemkeys_ubbe_nv.bad'
REPLACE 
INTO TABLE itemkeys_ubbe_nv
(
ITEMKEY                   POSITION(1:15)      CHAR)
