/* Liste der Fortsetzungsbestellungen erstellen   */

SPOOL output/&&SIGNATUR..ff_orderliste.csv;

select z68_order_number from z68 
  where substr(z68_rec_key,1,9) in 
  (select substr(z68_rec_key,1,9) from z68 right outer join item_zu_schieben
   on substr(z68_rec_key,1,9) = substr(reckey,1,9))
  and z68_sub_library='&&ZWEIGSTELLE' and z68_order_type='O';

SPOOL OFF;
