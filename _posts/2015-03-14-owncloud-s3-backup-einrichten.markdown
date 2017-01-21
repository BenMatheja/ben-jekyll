---
layout: post
status: publish
published: true
title: Sicher deine OwnCloud via Amazon S3
<<<<<<< HEAD
author:
  display_name: ben
  login: ben
  email: post@benmatheja.de
  url: http://benmatheja.de
author_login: ben
author_email: post@benmatheja.de
author_url: http://benmatheja.de
excerpt: "Ich habe meine pers&ouml;nlichen Daten vor 3 Monaten aus Dropbox in eine
  selbst-gehostete Cloud-L&ouml;sung (<a href=\"http:&#47;&#47;www.owncloud.de\">Owncloud<&#47;a>)
  umgezogen. Einerseits hat mich die Speicherbeschr&auml;nkung von <a href=\"http:&#47;&#47;www.dropbox.com\">Dropbox<&#47;a>
  genervt. Die Aktion, die mit meinem Samsung S3 kam (+25GB Dropbox-Speicher f&uuml;r
  2 Jahre) lief aus. Andererseits wuchs nach und nach das Misstrauen gegen&uuml;ber
  dem Datenhafen Amerika - zumindest f&uuml;r alles, was unverschl&uuml;sselt bleibt.\r\n\r\n"
wordpress_id: 499
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
comments:
- id: 67
  author: Kostenbetrachtung Offsite-Backup via S3 - benmatheja.de
  author_email: ''
  author_url: https://benmatheja.de/2015/05/kostenbetrachtung-offsite-backup-via-s3/
  date: '2015-05-08 12:32:38 +0200'
  date_gmt: '2015-05-08 10:32:38 +0200'
  content: "[&#8230;] Sicher deine OwnCloud via Amazon S3 [&#8230;]"
---
<p>Ich habe meine pers&ouml;nlichen Daten vor 3 Monaten aus Dropbox in eine selbst-gehostete Cloud-L&ouml;sung (<a href="http:&#47;&#47;www.owncloud.de">Owncloud<&#47;a>) umgezogen. Einerseits hat mich die Speicherbeschr&auml;nkung von <a href="http:&#47;&#47;www.dropbox.com">Dropbox<&#47;a> genervt. Die Aktion, die mit meinem Samsung S3 kam (+25GB Dropbox-Speicher f&uuml;r 2 Jahre) lief aus. Andererseits wuchs nach und nach das Misstrauen gegen&uuml;ber dem Datenhafen Amerika - zumindest f&uuml;r alles, was unverschl&uuml;sselt bleibt.</p>
<p><a id="more"></a><a id="more-499"></a></p>
<p>Den notwendigen Server hatte ich bereits bei <a href="http:&#47;&#47;www.netcup.de">Netcup<&#47;a> in Betrieb. Wir reden hier von einem Single-Core Xeon (virtualisiert) getaktet mit 2,0 Ghz bei 4GB Ram und einer konventionellen 220GB HDD auf der ich <a href="http:&#47;&#47;releases.ubuntu.com&#47;14.04&#47;">Ubuntu 14.04.2 LTS<&#47;a>&nbsp;installiert habe.&nbsp;<a href="http:&#47;&#47;www.netcup.de">Netcup<&#47;a> bietet dies f&uuml;r 9,95&euro; den Monat bei unbegrenztem Traffic an - ziemlich fair, wie ich finde.</p>
<p>Da Owncloud eine "einfache" PHP-Webanwendung ist, fiel die Konfiguration auch relativ simpel aus.<br />
Ich betriebe die Anwendung unter einer eigenen Subdomain via <a href="http:&#47;&#47;nginx.org">nginx<&#47;a>, <a href="http:&#47;&#47;php-fpm.org">php-fpm<&#47;a> und <a href="http:&#47;&#47;dev.mysql.com&#47;downloads&#47;mysql&#47;5.5.html">mysql&nbsp;5.5<&#47;a>. Die Performance ist bei 3-4 Nutzern zufriedenstellend.</p>
<h2>OwnCloud scaling out<&#47;h2><br />
<a href="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;03&#47;Screen-Shot-2015-03-14-at-21.58.32.png"><img class="aligncenter wp-image-522 size-full" src="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;03&#47;Screen-Shot-2015-03-14-at-21.58.32.png" alt="Screen Shot 2015-03-14 at 21.58.32" width="958" height="440" &#47;><&#47;a>Owncloud wird auch von der Initiative&nbsp;&nbsp;<a href="https:&#47;&#47;www.sciebo.de">Sciebo<&#47;a>&nbsp;eingesetzt. Das Projekt stellt eine Campuscloud bereit, an der die <a href="http:&#47;&#47;www.uni-muenster.de&#47;de&#47;">WWU M&uuml;nster<&#47;a> f&uuml;hrend beteiligt ist (yay M&uuml;nster!). &nbsp;Der Speicherservice ist f&uuml;r 500.000 Nutzern bei 5 Petabyte (5000 Terrabyte) dimensioniert. Eingesetzt wird die kostenpflichtige Enterprise-Version.</p>
<h2>Backupstrategie - Quo Vadis?<&#47;h2><br />
Das Problem vor dem ich momentan stehe, ist meine fehlende Backupstrategie. So schlimm wie <a href="https:&#47;&#47;www.dropbox.com&#47;de&#47;">Dropbox<&#47;a> und alle anderen Speicherdienste auch sein m&ouml;gen, sie liefern dem Kunden eine automatische Replika und Backupstrategie mit. Spielen wir selbst Cloud-Anbieter, m&uuml;ssen wir uns darum k&uuml;mmern.</p>
<p>Ich habe mir &uuml;berlegt, die Backups client-seitig zu verschl&uuml;sseln und dann auf <a href="http:&#47;&#47;aws.amazon.com&#47;de&#47;s3&#47;">Amazons Datenscheibe S3<&#47;a> zu packen. Am besten mit einer&nbsp;Backup-L&ouml;sung die inkrementiell arbeitet. Also nur dann Daten zu Amazon schiebt, wenn sich wirklich etwas ge&auml;ndert hat. Davon erhoffe ich mir, dass das Volumen und damit auch die Kosten (Amazon rechnet u.a. &uuml;ber das genutzte Volumen ab) im Rahmen bleiben - armer Student eben ;).</p>
<h2>Tools of the trade<&#47;h2><br />
Nach Recherche habe ich mich f&uuml;r folgende Tools entschieden:</p>
<ul>
<li><a href="http:&#47;&#47;duplicity.nongnu.org">duplicity<&#47;a>&nbsp;-&nbsp;Encrypted bandwidth-efficient backup using the rsync algorithm<&#47;li>
<li><a href="http:&#47;&#47;duply.net">duply<&#47;a>&nbsp;- Simple Duplicity<&#47;li>
<li><a href="https:&#47;&#47;github.com&#47;boto&#47;boto">python-boto<&#47;a>&nbsp;-&nbsp;Python interface to Amazon Web Services<&#47;li><br />
<&#47;ul><br />
Legen wir los! Mit dem Kommando</p>
<p>[bash]sudo apt-get install python-pip duplicity duply [&#47;bash]</p>
<p>installiert Ihr das Backuptool <a href="http:&#47;&#47;duplicity.nongnu.org">duplicity<&#47;a>&nbsp;und das python-commandline interface <a href="http:&#47;&#47;duply.net">duply<&#47;a>.</p>
<p>Anschlie&szlig;end&nbsp;installieren wir noch via</p>
<p>[bash]sudo pip install boto [&#47;bash]</p>
<p>das interface <a href="https:&#47;&#47;github.com&#47;boto&#47;boto">python-boto<&#47;a>&nbsp;um mit den Amazon Web Services&nbsp;zu kommunizieren.</p>
<p>Hinweis: zwar gibt es das Modul python-boto auch in den Ubuntu Paketquellen - jedoch f&uuml;hrte die dort gepflegte Version zu Problemen bei mir. Erst die neuste Version, installiert via &nbsp;Python-Paketmanager "pip", kommunizierte erfolgreich&nbsp;mit dem S3 Storage.</p>
<h2>Anlegen des Profils<&#47;h2><br />
Ist die Installation erfolgreich durchlaufen, erstellen wir ein Duply-Profil. Das Profil beschreibt die Backupstrategie. Prim&auml;r,</p>
<ol>
<li>Was soll gesichert werden<&#47;li>
<li>Wie soll verschl&uuml;sselt werden<&#47;li>
<li>Wohin soll das Backup gespeichert werden<&#47;li><br />
<&#47;ol><br />
Das Profil erzeugt ihr mit dem Kommando</p>
<p>[bash]duply test create[&#47;bash]</p>
<p>Duply erzeugt nun ein beispielhaftes Profil und legt es unter dem Pfad&nbsp;<strong>~&#47;.duply&#47;test<&#47;strong> ab.<br />
Da ich meine Backups verschl&uuml;sseln m&ouml;chte, generiere ich per</p>
<p>[bash]<br />
openssl rand -base64 40[&#47;bash]</p>
<p>eine Zeichenfolge, die f&uuml;r die anschlie&szlig;ende Verschl&uuml;sselung genutzt wird.<br />
Die Zeichenfolge trage ich in das Profil unter <code>GPG_PW<&#47;code> ein.<br />
<strong>Achtung:<&#47;strong> Speichert diese Zeichenfolge oder druckt sie aus - geht sie verloren und eure Maschine verliert die Konfigurationsdatei sind die Backups wertlos, da Ihr sie nicht mehr entschl&uuml;sseln k&ouml;nnt.</p>
<p>[bash]# gpg encryption settings, simple settings:<br />
# GPG_KEY='disabled' - disables encryption alltogether<br />
# GPG_KEY='<key1>[,<key2>]'; GPG_PW='pass' - encrypt with keys, sign<br />
# with key1 if secret key available and use GPG_PW for sign &amp; decrypt<br />
# GPG_PW='passphrase' - symmetric encryption using passphrase only<br />
#GPG_KEY='_KEY_ID_'<br />
GPG_PW='_GPG_PASSWORD_'<br />
[&#47;bash]</p>
<h2>Das Ziel: Amazon Simple Storage Service (S3)<&#47;h2><br />
Als n&auml;chstes lege ich bei Amazon S3 ein Bucket (ein "Datenkasten") an, in welchem ich meine Backups speichern will. Dazu nutze ich die <a href="https:&#47;&#47;console.aws.amazon.com&#47;s3&#47;">S3 AWS Console<&#47;a>. "Create Bucket"<a href="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;03&#47;Screen-Shot-2015-03-14-at-21.27.30.png"><img class=" wp-image-512 size-full aligncenter" src="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;03&#47;Screen-Shot-2015-03-14-at-21.27.30.png" alt="Screen Shot 2015-03-14 at 21.27.30" width="522" height="114" &#47;><&#47;a></p>
<p>Im Formular muss ich dem Bucket einen Namen und einen Standort zuweisen.<a href="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;03&#47;Screen-Shot-2015-03-14-at-21.29.17.png"><img class="aligncenter wp-image-513 size-full" src="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;03&#47;Screen-Shot-2015-03-14-at-21.29.17.png" alt="Screen Shot 2015-03-14 at 21.29.17" width="723" height="349" &#47;><&#47;a>Frankfurt ist geschickt f&uuml;r mich, da die Server in Karlsruhe&nbsp;stehen. Als Namen w&auml;hle ich "oc-backup-benmat" - ist aber relativ egal was ihr benutzt. Nun ist der Bucket angelegt - jetzt brauch ich noch Access Key und zugeh&ouml;riges Passwort.<a href="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;03&#47;Screen-Shot-2015-03-14-at-21.32.25.png"><img class="aligncenter size-medium wp-image-514" src="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;03&#47;Screen-Shot-2015-03-14-at-21.32.25-300x159.png" alt="Screen Shot 2015-03-14 at 21.32.25" width="300" height="159" &#47;><&#47;a></p>
<p>Per Klick auf "Security Credentials", anschlie&szlig;end einen neuen Access Key mit Secret erzeugen.<a href="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;03&#47;Screen-Shot-2015-03-14-at-21.33.39.png"><img class="aligncenter wp-image-515 size-full" src="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;03&#47;Screen-Shot-2015-03-14-at-21.33.39.png" alt="Screen Shot 2015-03-14 at 21.33.39" width="839" height="447" &#47;><&#47;a></p>
<p>Diesen f&uuml;gen wir in unsere Backup-Profil ein. Jetzt wird auch wieder wichtig, welcher Standort f&uuml;r das Bucket ausgew&auml;hlt wurde. Abh&auml;ngig davon, &auml;ndert sich die Adresse an die boto die Requests schicken muss. Hier findet ihr die <a href="http:&#47;&#47;docs.aws.amazon.com&#47;general&#47;latest&#47;gr&#47;rande.html#s3_region">Zuordnung Ort des Buckets <->S3 Adresse<&#47;a></p>
<p>[bash]<br />
#http:&#47;&#47;docs.aws.amazon.com&#47;general&#47;latest&#47;gr&#47;rande.html#s3_region<br />
TARGET='s3:&#47;&#47;s3.< AWS Region eures Buckets>.amazonaws.com&#47;< Bucket_name >&#47;< Ordner im Bucket>'<br />
# optionally the username&#47;password can be defined as extra variables<br />
# setting them here _and_ in TARGET results in an error<br />
TARGET_USER='< Euer AWS ACCESS KEY hier >'<br />
TARGET_PASS='< Euer AWS SECRET ACCESS Key hier >'<br />
[&#47;bash]</p>
<p>Anschlie&szlig;end setze ich das Basisverzeichnis des Backups. Da ich f&uuml;rs erste den kompletten OwnCloud Ordner sichern will, ergibt sich folgender Eintrag im Profil</p>
<p>[bash]<br />
# base directory to backup<br />
SOURCE='&#47;var&#47;www&#47;owncloud'<br />
[&#47;bash]</p>
<h2>Starten des Backups<&#47;h2><br />
Wir sind jetzt soweit, das erste Backup auszuprobieren. &nbsp;Der Job l&auml;uft erfahrungsgem&auml;&szlig; sehr lange. Damit wir die SSH-Session trotzdem verlassen k&ouml;nnen, ohne dass der Job abbricht, bietet sich <code>Screen<&#47;code> an.</p>
<p>[bash] sudo apt-get install screen [&#47;bash]</p>
<p>Nachdem Screen installiert ist, f&uuml;hre ich die Anwendung per <code>screen<&#47;code> im Terminal aus.<br />
Jetzt kann ich den Backup-Job starten, ohne dass er abbricht, sobald die SSH-Session geschlossen wird.</p>
<p>[bash]sudo duply test backup[&#47;bash]</p>
<p>Um das aktive Fenster zu verlassen dr&uuml;cke ich <kbd>CTRL+A<&#47;kbd> und anschlie&szlig;end <kbd>D<&#47;kbd>.<br />
Per</p>
<p>[bash]screen -x[&#47;bash]</p>
<p>kann ich es wieder hervor holen.</p>
<h2>Das erste Ergebnis<&#47;h2><br />
Okay, das Backup ist eingerichtet und auf S3 hochgeladen. F&uuml;r verschl&uuml;sseln und hochladen von 65GB Daten hat der Job 1:38h gebraucht. Meiner Einsch&auml;tzung nach, ein gutes Ergebnis.</p>
<p>[bash]<br />
--------------[ Backup Statistics ]--------------<br />
StartTime 1426361554.34 (Sat Mar 14 20:32:34 2015)<br />
EndTime 1426367415.56 (Sat Mar 14 22:10:15 2015)<br />
ElapsedTime 5861.23 (1 hour 37 minutes 41.23 seconds)<br />
SourceFiles 63415<br />
SourceFileSize 70019582190 (65.2 GB)<br />
NewFiles 63415<br />
NewFileSize 70019582190 (65.2 GB)<br />
DeletedFiles 0<br />
ChangedFiles 0<br />
ChangedFileSize 0 (0 bytes)<br />
ChangedDeltaSize 0 (0 bytes)<br />
DeltaEntries 63415<br />
RawDeltaSize 69980010689 (65.2 GB)<br />
TotalDestinationSizeChange 30244956738 (28.2 GB)<br />
Errors 0<br />
-------------------------------------------------<&#47;code></p>
<p>Releasing lockfile<br />
Removing still remembered temporary file &#47;tmp&#47;duplicity-oGtMAX-tempdir&#47;mkstemp-11THC_-1<br />
--- Finished state OK at 22:12:05.065 - Runtime 01:39:33.036 ---</p>
<p>--- Start running command POST at 22:12:05.116 ---<br />
Skipping n&#47;a script '&#47;home&#47;ben&#47;.duply&#47;test&#47;post'.<br />
--- Finished state OK at 22:12:05.144 - Runtime 00:00<br />
[&#47;bash]</p>
<p>Ein weiterer Backup-Lauf direkt im Anschluss demonstriert die Arbeitsweise von <a href="http:&#47;&#47;duplicity.nongnu.org">duplicity<&#47;a>. Da kaum &Auml;nderungen vorliegen, sind die vebrauchte Zeit und &uuml;bertragenen Daten sehr gering - wie eingeplant.</p>
<p>[bash]<br />
--------------[ Backup Statistics ]--------------<br />
StartTime 1426368079.83 (Sat Mar 14 22:21:19 2015)<br />
EndTime 1426368209.37 (Sat Mar 14 22:23:29 2015)<br />
ElapsedTime 129.53 (2 minutes 9.53 seconds)<br />
SourceFiles 63414<br />
SourceFileSize 70019577866 (65.2 GB)<br />
NewFiles 5<br />
NewFileSize 16563 (16.2 KB)<br />
DeletedFiles 2<br />
ChangedFiles 1<br />
ChangedFileSize 218 (218 bytes)<br />
ChangedDeltaSize 0 (0 bytes)<br />
DeltaEntries 8<br />
RawDeltaSize 404 (404 bytes)<br />
TotalDestinationSizeChange 594 (594 bytes)<br />
Errors 0<br />
[&#47;bash]</p>
<p>Macht bisher einen ziemlich guten Eindruck!</p>
<h2>Kostenbetrachtung und Ausblick<&#47;h2><br />
Ich habe bisher zwei Backups durchgef&uuml;hrt - Amazon S3 veranschlagt daf&uuml;r momentan laut Console <strong>0,12$<&#47;strong>.</p>
<p><a href="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;03&#47;Screen-Shot-2015-03-15-at-15.02.14.png"><img class="aligncenter size-full wp-image-571" src="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;03&#47;Screen-Shot-2015-03-15-at-15.02.14.png" alt="Kosten S3 nach 3 Backups" width="945" height="538" &#47;><&#47;a></p>
<h3>Mehr zu dem Thema<&#47;h3></p>
<ul>
<li><a href="http:&#47;&#47;www.xentux.de&#47;linux&#47;verschlusselte-backups-mit-duply&#47;">Verschl&uuml;sselte Backups mit duply<&#47;a><&#47;li>
<li><a title="Permalink to Tiny solution for automated backups: duply" href="http:&#47;&#47;jowisoftware.de&#47;wp&#47;2011&#47;10&#47;tiny-solution-for-automated-backups-duply&#47;" rel="bookmark">Tiny solution for automated backups: duply<&#47;a><&#47;li><br />
<&#47;ul></p>
=======
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


>>>>>>> c9942624178957d5b4dcbfde2162724f36b52fe4
