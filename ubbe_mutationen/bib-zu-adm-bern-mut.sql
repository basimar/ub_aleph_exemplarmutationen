/******************************************************************************/
/*  Script zur Selektion von BIB-Nummern zu Exemplaren, deren Nummern in      */
/*  itemkeys bzw. zu ADM-Nummern, die in admkeys geladen sind.                */
/*  Erstellt eine Liste von BIB-Nummern, die zur Reindexierung oder zum       */
/*  Herunterladen von bibliographischen Daten verwendet werden kann.          */
/*  20.02.2018 / bmt                                                          */
/******************************************************************************/
/******************************************************************************/
/*  ACHTUNG: Dieses SQL-Script wird woechentlich fuer Berner                  */
/*  Exemplaraenderungen verwendet (ausgefuehrt von:                           */
/*  /dsv51/scripts/ubbe_mutationen/ubbe_mutationen.sh)                        */
/*  Es darf nicht veraendert oder anderweitig eingesetzt werden               */
/******************************************************************************/

-- ALTER SESSION SET OPTIMIZER_MODE = CHOOSE;
SET HEADING OFF;
SET PAUSE OFF;
SET NEWPAGE 0;
SET SPACE 1;
SET LINESIZE 5000;
SET PAGESIZE 0;
SET FEEDBACK OFF;
SET TRIMSPOOL ON;
SET VERIFY OFF;
SET TERMOUT OFF;
SET ECHO OFF;   
 
SPOOL $alephe_scratch/bibkey_reind_bern_mut.sys

select distinct lpad(z103_lkr_doc_number,9,'0')||'DSV01' from z103, itemkeys_bern_mut
  where z103_lkr_library='DSV01'
  and Z103_LKR_TYPE = 'ADM'
  and z103_rec_key_1 = 'DSV51'||substr(itemkey,1,9)                  
  and substr(itemkey,1,9) in (select substr(itemkey,1,9) from itemkeys_bern_mut)
order by lpad(z103_lkr_doc_number,9,'0')||'DSV01'; 

SPOOL OFF;
EXIT;

