/* Ausgeliehene Stuecke markieren               */

update z30
  set z30_note_circulation=z30_note_circulation || ' (ins Magazin verschoben)'
  where z30_rec_key in (select reckey from item_zu_schieben)
  and z30_rec_key in (select z36_rec_key from z36);

