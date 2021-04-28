LOAD DATA
INFILE 'itemkeys_basel_mut.dat'
BADFILE 'itemkeys_basel_mut.bad'
REPLACE 
INTO TABLE itemkeys_basel_mut
(
ITEMKEY                   POSITION(1:15)      CHAR)
