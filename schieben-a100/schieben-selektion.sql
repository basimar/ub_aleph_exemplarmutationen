/* Selektion in view */

create or replace view item_zu_schieben as 
 (select substr(z30_call_no,1,15) as signatur, 
  z30_rec_key as reckey,
  z30_item_status as status,
  z30_collection as standort,
  substr(z30_call_no_key,1,40) as sigkey from z30
  where z30_call_no_key between '&&ANFANG' and '&&ENDE'
  and z30_collection='&&COLLECTION'
  and z30_sub_library='&&ZWEIGSTELLE');

SPOOL itemkeys_&&SIGNATUR..dat;
select reckey from item_zu_schieben;
SPOOL OFF;

SPOOL output/&&SIGNATUR..siglist.csv;
select signatur|| '	' ||
status|| '	' ||
standort from item_zu_schieben;
SPOOL OFF;

