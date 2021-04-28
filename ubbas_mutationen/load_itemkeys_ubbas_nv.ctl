LOAD DATA
INFILE 'itemkeys_ubbas_nv.dat'
BADFILE 'itemkeys_ubbas_nv.bad'
REPLACE 
INTO TABLE itemkeys_ubbas_nv
(
ITEMKEY                   POSITION(1:15)      CHAR)
