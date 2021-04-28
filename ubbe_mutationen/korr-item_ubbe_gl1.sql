/******************************************************************************/
/* Script zum Veraendern von z30-Saetzen mit cursor ueber die temp. Tabelle   */
/* itemkeys.                                                                  */
/******************************************************************************/
-- ALTER SESSION SET OPTIMIZER_MODE = CHOOSE;
declare
cursor loca_cursor is
   select * from itemkeys_ubbe_gl1;
allkeys loca_cursor%ROWTYPE;
begin 
open loca_cursor;
loop
fetch loca_cursor into allkeys;
exit when loca_cursor%NOTFOUND;
update dsv51.z30
 set z30_upd_time_stamp = '&1',
     z30_item_process_status = allkeys.item_process_status,
     z30_collection = allkeys.item_collection,
     z30_item_status = allkeys.item_status,
     z30_sub_library = allkeys.item_sublib
 where z30_rec_key=allkeys.itemkey;
commit;
end loop;
close loca_cursor;
end;
.
/
EXIT;
