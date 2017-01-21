---
layout: post
status: publish
published: true
title: Sicher deine OwnCloud via Amazon S3
author:
  display_name: ben
  login: ben
  email: post@benmatheja.de
  url: http://benmatheja.de
author_login: ben
author_email: post@benmatheja.de
author_url: http://benmatheja.de
disqus_comments: true
wordpress_url: https://benmatheja.de/?p=499
date: '2015-03-14 22:06:36 +0100'
date_gmt: '2015-03-14 21:06:36 +0100'
categories:
- Dev
tags:
- php
- tutorial
- MySQL
- Linux
- bash
- NGinx
- owncloud
- s3
- amazon
- storage
- duplicity
- python
- php-fpm
---
Ich habe meine persönlichen Daten vor 3 Monaten aus Dropbox in eine selbst-gehostete Cloud-Lösung [Owncloud](http://www.owncloud.de) umgezogen. Einerseits hat mich die Speicherbeschränkung von <a href="http://www.dropbox.com">Dropbox</a> genervt. Die Aktion, die mit meinem Samsung S3 kam (+25GB Dropbox-Speicher für 2 Jahre) lief aus. Andererseits wuchs nach und nach das Misstrauen gegenüber dem Datenhafen Amerika - zumindest für alles, was unverschlüsselt bleibt.
<a id="more"></a><a id="more-499"></a>
Den notwendigen Server hatte ich bereits bei <a href="http://www.netcup.de">Netcup</a> in Betrieb. Wir reden hier von einem Single-Core Xeon (virtualisiert) getaktet mit 2,0 Ghz bei 4GB Ram und einer konventionellen 220GB HDD auf der ich <a href="http://releases.ubuntu.com/14.04/">Ubuntu 14.04.2 LTS</a>&nbsp;installiert habe.&nbsp;<a href="http://www.netcup.de">Netcup</a> bietet dies für 9,95&euro; den Monat bei unbegrenztem Traffic an - ziemlich fair, wie ich finde.
Da Owncloud eine "einfache" PHP-Webanwendung ist, fiel die Konfiguration auch relativ simpel aus.
Ich betriebe die Anwendung unter einer eigenen Subdomain via <a href="http://nginx.org">nginx</a>, <a href="http://php-fpm.org">php-fpm</a> und <a href="http://dev.mysql.com/downloads/mysql/5.5.html">mysql&nbsp;5.5</a>. Die Performance ist bei 3-4 Nutzern zufriedenstellend.

#####OwnCloud scaling out
![](/res/Screen-Shot-2015-03-14-at-21.58.32.png =400x) 

Owncloud wird auch von der Initiative&nbsp;&nbsp;<a href="https://www.sciebo.de">Sciebo</a>&nbsp;eingesetzt. Das Projekt stellt eine Campuscloud bereit, an der die <a href="http://www.uni-muenster.de/de/">WWU Münster</a> führend beteiligt ist (yay Münster!). &nbsp;Der Speicherservice ist für 500.000 Nutzern bei 5 Petabyte (5000 Terrabyte) dimensioniert. Eingesetzt wird die kostenpflichtige Enterprise-Version.

#####Backupstrategie - Quo Vadis?
Das Problem vor dem ich momentan stehe, ist meine fehlende Backupstrategie. So schlimm wie <a href="https://www.dropbox.com/de/">Dropbox</a> und alle anderen Speicherdienste auch sein mögen, sie liefern dem Kunden eine automatische Replika und Backupstrategie mit. Spielen wir selbst Cloud-Anbieter, müssen wir uns darum kümmern.
Ich habe mir überlegt, die Backups client-seitig zu verschlüsseln und dann auf <a href="http://aws.amazon.com/de/s3/">Amazons Datenscheibe S3</a> zu packen. Am besten mit einer&nbsp;Backup-Lösung die inkrementiell arbeitet. Also nur dann Daten zu Amazon schiebt, wenn sich wirklich etwas geändert hat. Davon erhoffe ich mir, dass das Volumen und damit auch die Kosten (Amazon rechnet u.a. über das genutzte Volumen ab) im Rahmen bleiben - armer Student eben ;).
#####Tools of the trade
Nach Recherche habe ich mich für folgende Tools entschieden:
<ul>
<li><a href="http://duplicity.nongnu.org">duplicity</a>&nbsp;-&nbsp;Encrypted bandwidth-efficient backup using the rsync algorithm</li>
<li><a href="http://duply.net">duply</a>&nbsp;- Simple Duplicity</li>
<li><a href="https://github.com/boto/boto">python-boto</a>&nbsp;-&nbsp;Python interface to Amazon Web Services</li>
</ul>
Legen wir los! Mit dem Kommando
```bashsudo apt-get install python-pip duplicity duply ```
installiert Ihr das Backuptool <a href="http://duplicity.nongnu.org">duplicity</a>&nbsp;und das python-commandline interface <a href="http://duply.net">duply</a>.
Anschließend&nbsp;installieren wir noch via
```bashsudo pip install boto ```
das interface <a href="https://github.com/boto/boto">python-boto</a>&nbsp;um mit den Amazon Web Services&nbsp;zu kommunizieren.
Hinweis: zwar gibt es das Modul python-boto auch in den Ubuntu Paketquellen - jedoch führte die dort gepflegte Version zu Problemen bei mir. Erst die neuste Version, installiert via &nbsp;Python-Paketmanager "pip", kommunizierte erfolgreich&nbsp;mit dem S3 Storage.

#####Anlegen des Profils
Ist die Installation erfolgreich durchlaufen, erstellen wir ein Duply-Profil. Das Profil beschreibt die Backupstrategie. Primär,
<ol>
<li>Was soll gesichert werden</li>
<li>Wie soll verschlüsselt werden</li>
<li>Wohin soll das Backup gespeichert werden</li>
</ol>
Das Profil erzeugt ihr mit dem Kommando
```bash
duply test create
```
Duply erzeugt nun ein beispielhaftes Profil und legt es unter dem Pfad <strong>~/.duply/test</strong> ab.
Da ich meine Backups verschlüsseln möchte, generiere ich per
```bash
openssl rand -base64 40
```
eine Zeichenfolge, die für die anschließende Verschlüsselung genutzt wird.
Die Zeichenfolge trage ich in das Profil unter <code>GPG_PW</code> ein.
<strong>Achtung:</strong> Speichert diese Zeichenfolge oder druckt sie aus - geht sie verloren und eure Maschine verliert die Konfigurationsdatei sind die Backups wertlos, da Ihr sie nicht mehr entschlüsseln könnt.

```bash
  # gpg encryption settings, simple settings:
  # GPG_KEY='disabled' - disables encryption alltogether
  # GPG_KEY='<key1>[,<key2>]'; GPG_PW='pass' - encrypt with keys, sign
  # with key1 if secret key available and use GPG_PW for sign &amp; decrypt
  # GPG_PW='passphrase' - symmetric encryption using passphrase only
  #GPG_KEY='_KEY_ID_'
  GPG_PW='_GPG_PASSWORD_'
```

#####Das Ziel: Amazon Simple Storage Service (S3)
Als nächstes lege ich bei Amazon S3 ein Bucket (ein "Datenkasten") an, in welchem ich meine Backups speichern will. Dazu nutze ich die [S3 AWS Console](https://console.aws.amazon.com/s3/">S3 AWS Console). "Create Bucket"
![](/res/Screen-Shot-2015-03-14-at-21.27.30.png)


Im Formular muss ich dem Bucket einen Namen und einen Standort zuweisen.
![](/res/Screen-Shot-2015-03-14-at-21.29.17.png =500x )

Frankfurt ist geschickt für mich, da die Server in Karlsruhe stehen. Als Namen wähle ich "oc-backup-benmat" - ist aber relativ egal was ihr benutzt. 

Nun ist der Bucket angelegt - jetzt brauch ich noch Access Key und zugehöriges Passwort.
![](/res/Screen-Shot-2015-03-14-at-21.32.25.png =300x )

Per Klick auf "Security Credentials", anschließend einen neuen Access Key mit Secret erzeugen.
![](/res/Screen-Shot-2015-03-14-at-21.33.39.png =60s0x )

Diesen fügen wir in unsere Backup-Profil ein. Jetzt wird auch wieder wichtig, welcher Standort für das Bucket ausgewählt wurde. Abhängig davon, ändert sich die Adresse an die boto die Requests schicken muss. Hier findet ihr die <a href="http://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region">Zuordnung Ort des Buckets <->S3 Adresse</a>

```bash
  #http://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region
  TARGET='s3://s3.< AWS Region eures Buckets>.amazonaws.com/< Bucket_name >/< Ordner im Bucket>'
  # optionally the username/password can be defined as extra variables
  # setting them here _and_ in TARGET results in an error
  TARGET_USER='< Euer AWS ACCESS KEY hier >'
  TARGET_PASS='< Euer AWS SECRET ACCESS Key hier >'
```
Anschließend setze ich das Basisverzeichnis des Backups. Da ich fürs erste den kompletten OwnCloud Ordner sichern will, ergibt sich folgender Eintrag im Profil

```bash
  # base directory to backup
  SOURCE='/var/www/owncloud'
```

#####Starten des Backups
Wir sind jetzt soweit, das erste Backup auszuprobieren. &nbsp;Der Job läuft erfahrungsgemäß sehr lange. Damit wir die SSH-Session trotzdem verlassen können, ohne dass der Job abbricht, bietet sich <code>Screen</code> an.

```sudo apt-get install screen ```

Nachdem Screen installiert ist, führe ich die Anwendung per <code>screen</code> im Terminal aus.

Jetzt kann ich den Backup-Job starten, ohne dass er abbricht, sobald die SSH-Session geschlossen wird.
```sudo duply test backup```

Um das aktive Fenster zu verlassen drücke ich <kbd>CTRL+A</kbd> und anschließend <kbd>D</kbd>.
Per
```screen -x ```
kann ich es wieder hervor holen.

#####Das erste Ergebnis
Okay, das Backup ist eingerichtet und auf S3 hochgeladen. Für verschlüsseln und hochladen von 65GB Daten hat der Job 1:38h gebraucht. Meiner Einschätzung nach, ein gutes Ergebnis.

```bash
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
Ein weiterer Backup-Lauf direkt im Anschluss demonstriert die Arbeitsweise von <a href="http://duplicity.nongnu.org">duplicity</a>. Da kaum änderungen vorliegen, sind die vebrauchte Zeit und übertragenen Daten sehr gering - wie eingeplant.

```bash
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

#####Kostenbetrachtung und Ausblick
Ich habe bisher zwei Backups durchgeführt - Amazon S3 veranschlagt dafür momentan laut Console <strong>0,12$</strong>.
![](/res/Screen-Shot-2015-03-15-at-15.02.14.png =400x)

#####Mehr zu dem Thema
<ul>
<li><a href="http://www.xentux.de/linux/verschlusselte-backups-mit-duply/">Verschlüsselte Backups mit duply</a></li>
<li><a title="Permalink to Tiny solution for automated backups: duply" href="http://jowisoftware.de/wp/2011/10/tiny-solution-for-automated-backups-duply/" rel="bookmark">Tiny solution for automated backups: duply</a></li>
</ul>