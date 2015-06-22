---
layout: post
status: publish
published: true
title: Sicher deine OwnCloud via Amazon S3
---
Ich habe meine persönlichen Daten vor 3 Monaten aus Dropbox in eine selbst-gehostete Cloud-Lösung (Owncloud) umgezogen. 

Einerseits hat mich die Speicherbeschränkung von Dropbox genervt. Die Aktion, die mit meinem Samsung S3 kam (+25GB Dropbox-Speicher für 2 Jahre) lief aus. Andererseits wuchs nach und nach das Misstrauen gegenüber dem Datenhafen Amerika – zumindest für alles, was unverschlüsselt bleibt.

###Requirements

Den notwendigen Server hatte ich bereits bei Netcup in Betrieb. Wir reden hier von einem Single-Core Xeon (virtualisiert) getaktet mit 2,0 Ghz bei 4GB Ram und einer konventionellen 220GB HDD auf der ich Ubuntu 14.04.2 LTS installiert habe. Netcup bietet dies für 9,95€ den Monat bei unbegrenztem Traffic an – ziemlich fair, wie ich finde.

Da Owncloud eine „einfache“ PHP-Webanwendung ist, fiel die Konfiguration auch relativ simpel aus.
Ich betriebe die Anwendung unter einer eigenen Subdomain via nginx, php-fpm und mysql 5.5. Die Performance ist bei 3-4 Nutzern zufriedenstellend.

###OwnCloud scaling out

Owncloud wird auch von der Initiative [Sciebo](http://sciebo.org) eingesetzt. Das Projekt stellt eine Campuscloud bereit, an der die WWU Münster führend beteiligt ist (yay Münster!).  Der Speicherservice ist für 500.000 Nutzern bei 5 Petabyte (5000 Terrabyte) dimensioniert. Eingesetzt wird die kostenpflichtige Enterprise-Version.

###Backupstrategie – Quo Vadis?

Das Problem vor dem ich momentan stehe, ist meine fehlende Backupstrategie. So schlimm wie Dropbox und alle anderen Speicherdienste auch sein mögen, sie liefern dem Kunden eine automatische Replika und Backupstrategie mit. Spielen wir selbst Cloud-Anbieter, müssen wir uns darum kümmern.

Ich habe mir überlegt, die Backups client-seitig zu verschlüsseln und dann auf Amazons Datenscheibe S3 zu packen. Am besten mit einer Backup-Lösung die inkrementiell arbeitet. Also nur dann Daten zu Amazon schiebt, wenn sich wirklich etwas geändert hat. Davon erhoffe ich mir, dass das Volumen und damit auch die Kosten (Amazon rechnet u.a. über das genutzte Volumen ab) im Rahmen bleiben – armer Student eben ;).

###Tools of the trade

Nach Recherche habe ich mich für folgende Tools entschieden:

duplicity – Encrypted bandwidth-efficient backup using the rsync algorithm
duply – Simple Duplicity
python-boto – Python interface to Amazon Web Services
Legen wir los! Mit dem Kommando

```
sudo apt-get install python-pip duplicity duply
```
installiert Ihr das Backuptool duplicity und das python-commandline interface duply.

Anschließend installieren wir noch via
```
sudo pip install boto
```
das interface python-boto um mit den Amazon Web Services zu kommunizieren.

Hinweis: zwar gibt es das Modul python-boto auch in den Ubuntu Paketquellen – jedoch führte die dort gepflegte Version zu Problemen bei mir. Erst die neuste Version, installiert via  Python-Paketmanager „pip“, kommunizierte erfolgreich mit dem S3 Storage.

####Anlegen des Profils

Ist die Installation erfolgreich durchlaufen, erstellen wir ein Duply-Profil. Das Profil beschreibt die Backupstrategie. Primär,

* Was soll gesichert werden
* Wie soll verschlüsselt werden
* Wohin soll das Backup gespeichert werden

Das Profil erzeugt ihr mit dem Kommando
```duply test create```
Duply erzeugt nun ein beispielhaftes Profil und legt es unter dem Pfad ```~/.duply/test``` ab.
Da ich meine Backups verschlüsseln möchte, generiere ich per
```
openssl rand -base64 40
```
eine Zeichenfolge, die für die anschließende Verschlüsselung genutzt wird.
Die Zeichenfolge trage ich in das Profil unter *GPG_PW* ein.
Achtung: Speichert diese Zeichenfolge oder druckt sie aus – geht sie verloren und eure Maschine verliert die Konfigurationsdatei sind die Backups wertlos, da Ihr sie nicht mehr entschlüsseln könnt.

```
# gpg encryption settings, simple settings:
#  GPG_KEY='disabled' - disables encryption alltogether
#  GPG_KEY='<key1>[,<key2>]'; GPG_PW='pass' - encrypt with keys, sign
#    with key1 if secret key available and use GPG_PW for sign & decrypt
#  GPG_PW='passphrase' - symmetric encryption using passphrase only
#GPG_KEY='_KEY_ID_'
GPG_PW='_GPG_PASSWORD_'
```

####Das Ziel: Amazon Simple Storage Service (S3)

Als nächstes lege ich bei Amazon S3 ein Bucket (ein „Datenkasten“) an, in welchem ich meine Backups speichern will. Dazu nutze ich die S3 AWS Console. „Create Bucket“
<img src="/res/Screen-Shot-2015-03-14-at-21.27.30.png" width="50%" class="materialboxed">

Im Formular muss ich dem Bucket einen Namen und einen Standort zuweisen.
Frankfurt ist geschickt für mich, da die Server in Karlsruhe stehen. Als Namen wähle ich „oc-backup-benmat“ – ist aber relativ egal was ihr benutzt.

Nun ist der Bucket angelegt – jetzt brauche ich Access Key und zugehöriges Passwort.
Per Klick auf „Security Credentials“, anschließend einen neuen Access Key mit Secret erzeugen.<img src="/res/Screen-Shot-2015-03-14-at-21.33.39.png" width="100%" class="materialboxed">

Diesen fügen wir in unsere Backup-Profil ein. Jetzt wird auch wieder wichtig, welcher Standort für das Bucket ausgewählt wurde. Abhängig davon, ändert sich die Adresse an die boto die Requests schicken muss. Hier findet ihr die Zuordnung [Ort des Buckets <->S3 Adresse](http://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region)

```
#http://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region
TARGET='s3://s3.< AWS Region eures Buckets>.amazonaws.com/< Bucket_name >/< Ordner im Bucket>'
# optionally the username/password can be defined as extra variables
# setting them here _and_ in TARGET results in an error
TARGET_USER='< Euer AWS ACCESS KEY hier >'
TARGET_PASS='< Euer AWS SECRET ACCESS Key hier >'
```

Anschließend setze ich das Basisverzeichnis des Backups. Da ich fürs erste den kompletten OwnCloud Ordner sichern will, ergibt sich folgender Eintrag im Profil

```
# base directory to backup
SOURCE='/var/www/owncloud'
```

####Starten des Backups

Wir sind jetzt soweit, das erste Backup auszuprobieren.  Der Job läuft erfahrungsgemäß sehr lange. Damit wir die SSH-Session trotzdem verlassen können, ohne dass der Job abbricht, bietet sich Screen an.

```
sudo apt-get install screen
```
Nachdem Screen installiert ist, führe ich die Anwendung per screen im Terminal aus.
Jetzt kann ich den Backup-Job starten, ohne dass er abbricht, sobald die SSH-Session geschlossen wird.

```sudo duply test backup``` Um das aktive Fenster zu verlassen drücke ich CTRL+A und anschließend D.
Per ```screen -x``` kann ich es wieder hervor holen.

####Das erste Ergebnis
Okay, das Backup ist eingerichtet und auf S3 hochgeladen. Für verschlüsseln und hochladen von 65GB Daten hat der Job 1:38h gebraucht. Meiner Einschätzung nach, ein gutes Ergebnis.

```
--------------[ Backup Statistics ]--------------
StartTime 1426361554.34 (Sat Mar 14 20:32:34 2015)
EndTime 1426367415.56 (Sat Mar 14 22:10:15 2015)
ElapsedTime 5861.23 (1 hour 37 minutes 41.23 seconds)
SourceFiles 63415
SourceFileSize 70019582190 (65.2 GB)
NewFiles 63415
NewFileSize 70019582190 (65.2 GB)
DeletedFiles 0
ChangedFiles 0
ChangedFileSize 0 (0 bytes)
ChangedDeltaSize 0 (0 bytes)
DeltaEntries 63415
RawDeltaSize 69980010689 (65.2 GB)
TotalDestinationSizeChange 30244956738 (28.2 GB)
Errors 0
-------------------------------------------------</code>
 
Releasing lockfile
Removing still remembered temporary file /tmp/duplicity-oGtMAX-tempdir/mkstemp-11THC_-1
--- Finished state OK at 22:12:05.065 - Runtime 01:39:33.036 ---
 
--- Start running command POST at 22:12:05.116 ---
Skipping n/a script '/home/ben/.duply/test/post'.
--- Finished state OK at 22:12:05.144 - Runtime 00:00
```

Ein weiterer Backup-Lauf direkt im Anschluss demonstriert die Arbeitsweise von duplicity. Da kaum Änderungen vorliegen, sind die vebrauchte Zeit und übertragenen Daten sehr gering – wie eingeplant.

```
--------------[ Backup Statistics ]--------------
StartTime 1426368079.83 (Sat Mar 14 22:21:19 2015)
EndTime 1426368209.37 (Sat Mar 14 22:23:29 2015)
ElapsedTime 129.53 (2 minutes 9.53 seconds)
SourceFiles 63414
SourceFileSize 70019577866 (65.2 GB)
NewFiles 5
NewFileSize 16563 (16.2 KB)
DeletedFiles 2
ChangedFiles 1
ChangedFileSize 218 (218 bytes)
ChangedDeltaSize 0 (0 bytes)
DeltaEntries 8
RawDeltaSize 404 (404 bytes)
TotalDestinationSizeChange 594 (594 bytes)
Errors 0
```

Macht bisher einen ziemlich guten Eindruck!
Ich habe bisher zwei Backups durchgeführt – Amazon S3 veranschlagt dafür momentan laut Console 0,12$.


