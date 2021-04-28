LOAD DATA
INFILE 'itemkeys_bern_mut.dat'
BADFILE 'itemkeys_bern_mut.bad'
REPLACE 
INTO TABLE itemkeys_bern_mut
(
ITEMKEY                   POSITION(1:15)      CHAR)
