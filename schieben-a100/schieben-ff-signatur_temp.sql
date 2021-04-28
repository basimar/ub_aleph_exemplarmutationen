/* Liste Fortsetzungen   */
SET HEADING OFF;
SET PAUSE OFF;
SET NEWPAGE 0;
SET SPACE 1;
SET LINESIZE 5000;
SET PAGESIZE 0;
SET TRIMSPOOL ON;
SET VERIFY OFF;
SET FEEDBACK ON;
SET TERMOUT OFF;
SET ECHO OFF;
SET FEEDBACK ON;

SPOOL output/a130_fortsetzungen.csv

select substr(z68_library_note,1,60)||CHR(9)||z68_order_number from z68
 where (z68_library_note like '%AD IV%' or
        z68_library_note like '%AD VII%' or
        z68_library_note like '%BP II %' or
        z68_library_note like '%BP III %' or
        z68_library_note like '%Ba %' or
        z68_library_note like '%B.A %' or
        z68_library_note like '%ed %' or
        z68_library_note like '%.E.D %' or
        z68_library_note like '%ee %' or
        z68_library_note like '%.E.E %') 
 and z68_sub_library='A100' 
 and z68_order_type = 'O'
-- and z68_order_type in ('O', 'S')
 and z68_order_status = 'SV'
 order by z68_library_note;
SPOOL OFF; 
EXIT;
