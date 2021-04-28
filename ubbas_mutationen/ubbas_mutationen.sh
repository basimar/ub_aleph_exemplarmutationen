#!/bin/csh -f

# Script zur Verarbeitung von Mutationsdaten der UB Basel   
# Dateien werden per Taskmanager Upload auf dsv51/scratch hochgeladen
# Autor: bernd.luchner@unibas.ch
# History:
# Stand: 18.07.2016
# 21.02.2018: Mailadresse geandert, fbo
# 22.02.2018: Trennung Zwischenprodukte, bmt
# 26.02.2018: Ausbau: gl1 auch fuer Basler-Skript, bmt
# 22.06.2018: Anpassung fÃr Virtualisierung, bmt

set datum = `date +%Y%m%d`
set datum_timestamp = `date +"%Y%m%d%H%M000"`
set start_time = `date +%T`
set line = '----------------------------------------------------------------------------'
set listtype=(nv ag gl1 gl2)
set workdir = "$alephe_dev/dsv51/scripts/ubbas_mutationen"
set logdir = "$alephe_dev/dsv51/scripts/ubbas_mutationen/log"
set inputdir = "$alephe_dev/dsv51/scratch"
set log = $logdir/ubbas_$datum.log

echo "Verarbeitung UB Basel-Mutationen vom $datum um $start_time gestartet:"

while ($#listtype)
    echo $line 
    echo "While... ubbas_$listtype[1]_$datum.csv"
    set success = 'Erfolg'
    cd $inputdir
    if (! -e ubbas_$listtype[1]_$datum.csv) then
       echo "Keine Datei ubbas_$listtype[1]_$datum.csv heute..."
       set filehandle = "Kein Input Typ $listtype[1]"
       echo $line >> $log
       echo "Keine Datei vom Datum $datum vom Typ ubbas_$listtype[1] gefunden" >> $log
       set success = 'Abbruch'
    else
       echo $line
       echo "Verarbeitung ubbas_$listtype[1]_$datum.csv"
       set runtype = $listtype[1]
       set filehandle = `ls -1 ubbas_$listtype[1]_$datum.csv`
       echo $line >> $log
       echo "UB Basel Import Mutationsdaten fuer $filehandle gestartet: $start_time" >> $log
       echo $line >> $log
       chmod -x $filehandle
       set filecheck = `file $filehandle | awk '{print $2$3}'`
       set check_key_error = `grep -c 'E+' $filehandle`
       if ( $check_key_error > 0 || $filecheck != 'ASCIItext' ) then
          set success = 'Abbruch'
          echo "Abbruch: $filehandle enthaelt Formeln statt Exemplarkeys oder ist keine ascii-Datei" >> $log
          mv $filehandle $filehandle.error
          set filehandle = "Fehler in Input Typ $listtype[1]"
       else 
          cp $filehandle $workdir/ubbas_$listtype[1].dat
          echo "1.: $filehandle importieren" >> $log
          echo $line >> $log
          cd $workdir
          switch ($runtype)
            case nv:
              mv ubbas_$listtype[1].dat itemkeys_ubbas_nv.dat
              sqlldr dsv51/dsv51 control=load_itemkeys_ubbas_nv
              set nv_import = `grep 'data errors' load_itemkeys_ubbas_nv.log | awk '{print $1}'`
              if ( $nv_import == '0' ) then
                 echo "2.: Mutationen $filehandle ausfuehren (ohne Indexierung)" >> $log
                 sqlplus dsv51/dsv51 @korr-item_ubbas_nv.sql $datum_timestamp
                 mv $inputdir/$filehandle $inputdir/$filehandle.done
              else
                 echo "Import von $filehandle gescheitert, Fehlerliste:" >> $log
                 cat itemkeys_ubbas_nv.bad >> $log
                 mv $inputdir/$filehandle $inputdir/$filehandle.error
                 set filehandle = "Fehler in Input Typ $listtype[1]"
                 set success = 'Abbruch'
              endif
              breaksw
            case ag:
              mv ubbas_$listtype[1].dat itemkeys_ubbas_ag.dat
              sqlldr dsv51/dsv51 control=load_itemkeys_ubbas_ag
              set ag_import = `grep 'data errors' load_itemkeys_ubbas_ag.log | awk '{print $1}'`
              if ( $ag_import == '0' ) then
                 echo "2.: Mutationen $filehandle ausfuehren (mit Indexierung)" >> $log
                 sqlplus dsv51/dsv51 @korr-item_ubbas_ag.sql $datum_timestamp
                 mv $inputdir/$filehandle $inputdir/$filehandle.done
                 cat itemkeys_ubbas_ag.dat >> itemkeys_ubbas.dat
                 rm itemkeys_ubbas_ag.dat
              else
                 echo "Import von $filehandle gescheitert, Fehlerliste:" >> $log
                 cat itemkeys_ubbas_ag.bad >> $log
                 mv $inputdir/$filehandle $inputdir/$filehandle.error
                 set filehandle = "Fehler in Input Typ $listtype[1]"
                 set success = 'Abbruch'
              endif
              breaksw
            case gl1:
              mv ubbas_$listtype[1].dat itemkeys_ubbas_gl1.dat
              sqlldr dsv51/dsv51 control=load_itemkeys_ubbas_gl1
              set gl1_import = `grep 'data errors' load_itemkeys_ubbas_gl1.log | awk '{print $1}'`
              if ( $gl1_import == '0' ) then
                 echo "2.1: Mutationen $filehandle ausfuehren (mit Indexierung)" >> $log
                 sqlplus dsv51/dsv51 @korr-item_ubbas_gl1.sql $datum_timestamp
                 echo "2.2: Signaturtausch $filehandle ausfuehren" >> $log
                 sqlplus dsv51/dsv51 @create_callno_tausch_ubbas_gl1.sql 
                 sqlplus dsv51/dsv51 @korr-callno-tausch_ubbas_gl1.sql 
                 mv $inputdir/$filehandle $inputdir/$filehandle.done
                 cat itemkeys_ubbas_gl1.dat >> itemkeys_ubbas.dat
                 rm itemkeys_ubbas_gl1.dat 
              else
                 echo "Import von $filehandle gescheitert, Fehlerliste:" >> $log
                 cat itemkeys_ubbas_gl1.bad >> $log
                 mv $inputdir/$filehandle $intputdir/$filehandle.error
                 set filehandle = "Fehler in Input Typ $listtype[1]"
                 set success = 'Abbruch'
              endif
              breaksw
            case gl2:
              mv ubbas_$listtype[1].dat itemkeys_ubbas_gl2.dat
              sqlldr dsv51/dsv51 control=load_itemkeys_ubbas_gl2
              set gl2_import = `grep 'data errors' load_itemkeys_ubbas_gl2.log | awk '{print $1}'`
              if ( $gl2_import == '0' ) then
                 echo "2.: Mutationen $filehandle ausfuehren (mit Indexierung)" >> $log
                 sqlplus dsv51/dsv51 @korr-item_ubbas_gl2.sql $datum_timestamp
                 mv $inputdir/$filehandle $inputdir/$filehandle.done
                 cat itemkeys_ubbas_gl2.dat >> itemkeys_ubbas.dat
                 rm itemkeys_ubbas_gl2.dat 
              else
                 echo "Import von $filehandle gescheitert, Fehlerliste:" >> $log
                 cat itemkeys_ubbas_gl2.bad >> $log
                 mv $inputdir/$filehandle $inputdir/$filehandle.error
                 set filehandle = "Fehler in Input Typ $listtype[1]"
                 set success = 'Abbruch'
              endif
              breaksw
            default:
              echo "Error with Runtype: $runtype, Filehandle: $filehandle, Log: $log"
              set success = 'Fehler'
              breaksw
          endsw
       endif
    endif

    echo $line
    echo " "
    echo $line >> $log
    set end_time = `date +%T`

    if ( $success == 'Erfolg' ) then
       echo "Mutationen UB Basel fuer $filehandle um $end_time mit $success beendet." >> $log
    else
       echo "Keine Mutationen UB Basel fuer ubbas_$listtype[1] am $datum" >> $log
    endif
    set runtype =
    set filehandle =
    shift listtype 
end

cd $workdir

if ( -e itemkeys_ubbas.dat ) then
   echo "Indexierungslauf UB Basel-Lauf am $datum"
   mv itemkeys_ubbas.dat itemkeys_basel_mut.dat
   sqlldr dsv51/dsv51 control=load_itemkeys_basel_mut
   sqlplus dsv51/dsv51 @bib-zu-adm-basel-mut.sql
   csh -f $aleph_proc/p_manage_40 DSV01,bibkey_reind_basel_mut.sys,,,00000000, > $alephe_scratch/dsv01_p_manage_40_basel_mut_$datum.log &
else
   echo "Keine Indexierung, UB Basel-Lauf am $datum"
   echo "Keine Indexierung, UB Basel-Lauf am $datum, Status: $success" >> $log
endif

echo "Verarbeitung UB Basel-Mutationen vom $datum um $start_time beendet."
echo "Verarbeitung UB Basel-Mutationen vom $datum um $start_time beendet." >> $log
set joblog = `ls -1rt $alephe_scratch/dsv01_p_manage_40_basel_mut* | tail -1 | awk -F'/' '{print $7}'`
echo ' ' >> $log
echo "Logfile des Laufs in alephe/scratch: http://ub-alprod.ub.unibas.ch/dirlist/u/alephe/scratch/$joblog" >> $log

cat $log | mailx -s "UB Basel Mutationsbericht Produktion am $datum" aleph-ub@unibas.ch,verbund-ub@unibas.ch
#cat $log | mailx -s "UB Basel Mutationsbericht Produktion am $datum" aleph-ub@unibas.ch
exit
