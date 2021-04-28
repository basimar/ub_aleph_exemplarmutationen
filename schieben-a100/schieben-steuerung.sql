/* Unterscriptaufrufe  */

-- ALTER SESSION SET OPTIMIZER_MODE = CHOOSE;
SET HEADING OFF;
SET PAUSE OFF;
SET NEWPAGE 0;
SET SPACE 1;
SET LINESIZE 5000;
SET PAGESIZE 0;
SET TRIMSPOOL ON;
SET VERIFY OFF;
SET TERMOUT OFF;
SET ECHO OFF;
SET FEEDBACK OFF;

define SIGNATUR ='&1'
define SIGNOUBH='&2'
define ANFANG = '&3 &4'
define ENDE = '&3 &5'
define COLLECTION = '&6'
define ZWEIGSTELLE = '&7'

@schieben-selektion.sql
@schieben-listen.sql
@schieben-ff-signatur.sql
@schieben-forts.sql
@schieben-notaus.sql
          
EXIT;
