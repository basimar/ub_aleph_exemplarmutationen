/******************************************************************************/
/* Script zum Vertauschen von Signatur und Signatur 2, nachdem beide         **/
/* Signaturen mit REC_KEY in eine temporaere Tabelle eingelesen wurden.       */
/* WICHTIG: da die Felder z30_call_no_key und z30_call_no_2_key nicht         */
/* fuer einen definierten Bereich von z30-Saetzen aufgebaut werden koennen,   */
/* muessen sie ebenfalls verschoben werden.                                   */
/******************************************************************************/
declare
cursor callno_cursor is
   select * from callno_tausch_ubbas_gl1;
felder callno_cursor%ROWTYPE;
reckey felder.z30reckey%TYPE;
typ felder.z30type%TYPE;
callno felder.z30callno%TYPE;
callnokey felder.z30callnokey%TYPE;
type2 felder.z30type2%TYPE;
callno2 felder.z30callno2%TYPE;
callnokey2 felder.z30callnokey2%TYPE;
begin
open callno_cursor;
loop
fetch callno_cursor into felder;
exit when callno_cursor%NOTFOUND;
update dsv51.z30
   set z30_call_no=felder.z30callno2, 
       z30_call_no_type='',              
       z30_call_no_key=felder.z30callnokey2,
       z30_call_no_2_type='6', 
       z30_call_no_2=felder.z30callno, 
       z30_call_no_2_key=felder.z30callnokey
   where z30_rec_key=felder.z30reckey;
commit;
end loop;
close callno_cursor;
end;
.
/
EXIT;
