#*******************************************************************************************#
# Steuerungs-Shellscript fuer Verschiebeaktionen von Exemplaren ins Magazin
#
# Alle Variablen werden hier gesetzt:
# Die Variable SIGNATUR wird fuer Dateinamen und Suche in z68_library_note benutzt.
# Sie ist so anzugeben, wie sie ist: Gross-/Kleinbuchstaben, Leerzeichen als Unterstrich.
# ACHTUNG: die UB-Signaturen haben nun einen Vorspann 'UBH', nicht jedoch in der z68_library_note.
# Daher hier die Signatur noch einmal, ohne Vorspann 'UBH' eingeben. blu/04.04.2016
# Die Variable SIG_KEY wird fuer die Selektion in z30 (z30_call_no_key) benutzt.
# Sie ist daher IMMER in Kleinbuchstaben anzugeben.
# ANFANG und ENDE: lfd. Signatur siebenstellig mit Nullen oder '0000000', '9999999', wenn alle.
# COLLECTION: i.d.R. 100FM, denn die Verschiebung findet vom Freihandmagazin ins Magazin statt. 
#
# ACHTUNG: 
# 1. Signaturen mit Gross- u. Kleinbuchstaben muessen in Script schieben-ff-signatur.sql
# VOR dem Start dieses Scripts zusaetzlich in alter Schreibweise angegeben werden.
# 
# 2. Signaturen mit mehrteiligen Praefixen muessen in SIG_KEY
# nochmal mit Anfuehrungszeichen umgeben werden, z.B. set SIG_KEY = '"ad iv"' und in SIGNATUR
# mit Unterstrich (da sonst Parmeteruebergabe nicht stimmt), z.B. set SIGNATUR = 'Bi_IX'.
# Unterstrich ist Wildcardzeichen in "like".
#
# Dieses Script erstellt nur die Listen.
# In dsv51/scripts wird eine Datei itemkeys_SIGNATUR.dat abgelegt als Input fuer die eigentliche 
# Exemplarumstellung.
#
# blu, 04.04.2016
#*******************************************************************************************#

set datum = `date +%d.%m.%Y,%H:%M:%S`
set SIGNATUR = 'UBH_AP_VII'
set SIGNOUBH = 'AP_VII'
set SIG_KEY = '"ubh ap vii"'
set ANFANG = '0006001'
set ENDE = '0006700'
set COLLECTION = '100FM'
set SUBLIB = 'A100'

echo '-------------------------------------------------------------------------------------'
echo 'Selektion und Listenproduktion fuer' $SIGNATUR'-Verschiebeaktion gestartet: '$datum
echo '-------------------------------------------------------------------------------------'

sqlplus dsv51/dsv51 @schieben-steuerung.sql $SIGNATUR $SIGNOUBH $SIG_KEY $ANFANG $ENDE $COLLECTION $SUBLIB

echo '-------------------------------------------------------------------------------------'
echo 'Ausgaben sortieren und ins abholfach stellen'
echo '-------------------------------------------------------------------------------------'

cat output/$SIGNATUR.vermisst output/$SIGNATUR.ausgeliehen | sort > output/$SIGNATUR.nicht_da.csv
rm output/$SIGNATUR.vermisst output/$SIGNATUR.ausgeliehen
fixsigsort.pl output/$SIGNATUR.nicht_da.csv
fixsigsort.pl output/$SIGNATUR.fortsetzungen.csv
fixsigsort.pl output/$SIGNATUR.siglist.csv
cp output/$SIGNATUR.nicht_da.csv $alephe_dev/abholfach/
cp output/$SIGNATUR.fortsetzungen.csv $alephe_dev/abholfach/
cp output/$SIGNATUR.siglist.csv $alephe_dev/abholfach/
cp output/$SIGNATUR.ff_orderliste.csv $alephe_dev/abholfach/

ls -al $alephe_dev/abholfach/$SIGNATUR.*
ls -al $dsv51_dev/dsv51/scripts/schieben-a100/itemkeys_$SIGNATUR.dat

set datum = `date +%d.%m.%Y,%H:%M:%S`
echo '-------------------------------------------------------------------------------------'
echo 'Selektion und Listenproduktion fuer Verschiebeaktion beendet: '$datum
echo '-------------------------------------------------------------------------------------'
