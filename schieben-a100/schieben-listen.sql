/* Liste der ausgeliehenen Stuecke erstellen     */

SPOOL output/&&SIGNATUR..ausgeliehen; 

select substr(z30_call_no,1,30), 'ausgeliehen    ', z30_barcode from z30
  where z30_rec_key in (select reckey from item_zu_schieben)
  and z30_rec_key in (select z36_rec_key from z36)
order by substr(z30_call_no,1,30);
SPOOL OFF;

/* Liste der vermissten Stuecke erstellen   */

SPOOL output/&&SIGNATUR..vermisst;

select substr(z30_call_no,1,30), 'vermisst       ', z30_barcode from z30
  where z30_rec_key in (select reckey from item_zu_schieben)
  and (z30_item_status='42' or z30_item_status='47')
order by substr(z30_call_no,1,30);
SPOOL OFF;

