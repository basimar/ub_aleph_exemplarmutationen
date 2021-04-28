/* Liste Fortsetzungen   */

SPOOL output/&&SIGNATUR..fortsetzungen.csv;

select substr(z68_library_note,1,40), z68_order_number from z68
  where (z68_library_note like '%&&SIGNATUR %'
  or z68_library_note like '%AP VII %')
  and z68_sub_library='&&ZWEIGSTELLE' and z68_order_type in ('O', 'S')
order by z68_library_note;
SPOOL OFF; 

/***********************************************************************/
/*   Variante, wenn Signatur Kleinbuchstaben enthaelt                 **/
/* where (z68_library_note like '%&&SIGNATUR %' or                     */
/* z68_library_note like '%A.P X %')  -- Ap X                          */
/* z68_library_note like '%.K.K VI %')  -- kk VI                       */
/***********************************************************************/
