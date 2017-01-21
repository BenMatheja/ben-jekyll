---
layout: post
title: 'Backupstrategie Part2: ownCloud zu OneDrive sichern'
date: 2016-10-06 23:06:33.000000000 +02:00
categories:
- Dev
- frontpage
tags:
- amazon
- Backup
- dev
- Duply
- Linux
- Onedrive
- s3
status: publish
type: post
disqus_comments: true
published: true
author:
  login: ben
  email: post@benmatheja.de
  display_name: ben
  first_name: Ben
  last_name: Matheja
---
Nachdem ich bereits vorgestellt habe, wie sich die Daten meiner <a href="https://owncloud.org/">Owncloud </a><a href="https://benmatheja.de/2015/03/owncloud-s3-backup-einrichten/">verschlüsselt zu Amazon's S3 sichern</a> lassen, bin ich in letzter Zeit davon abgewichen.
Idealerweise, würde ich gerne wöchentliche full backups mit täglichen Incrementals durchführen.
Dies ist mit dem Geschäftsmodel von <a href="https://aws.amazon.com/de/s3/pricing/">Amazon's S3</a> bzw. den verursachten Kosten nicht vereinbar. Alternativ ließe sich Glacier von Amazon benutzen, jedoch stört die vorgeschriebene Wartezeit bis ein komplett Backup wiederhergestellt werden kann (unter Umständen <a href="https://aws.amazon.com/de/glacier/faqs/">mehrere Stunden</a>).
<!--more-->
Meine Alternative war bisher der Storage Space von <a href="https://www.netcup.de/">Netcup</a>. 
Dort wird ein NFS-Volume angeboten, welches für 3€ im Monat 100GB inklusives Volumen mitbringt.
Jedes GB darüber wird mit 5 ct veranschlagt.

Derzeit hat meine Owncloud einen Datensatz von 131GB zu sichern, heißt monatlich 3€ + 31*0,05 = 4,55€.
Erwartungsgemäß wird der Datensatz bis Mitte 2017 auf 200GB anwachsen. Das hat einerseits damit zu tun, dass ich Owncloud hauptsächlich für das Sichern der Bilder meiner Canon EOS benutze.
Andererseits haben meine Familienmitglieder so langsam auch den Gefallen an der Lösung gefunden.
In der Kostenbetrachtung hieße das dann 3€ + 100*0,05 = 8€.

Für das Geld könnte ich monatlich bereits einen <a href="http://www.netcup-sonderangebote.de/vserver/root-server-1000-plus/">Rootserver bei Netcup mit 640GB Speicher </a>bekommen. Meine Schmerzgrenze ist also erreicht.

In Gesprächen mit einem Kollegen wurde mir <a href="https://onedrive.live.com/">Microsoft's OneDrive</a> ans Herz gelegt.
Die Performance sei etwas dürftig, was sich mit den Erfahrungen von <a href="https://techbox.rocks/offsite-backup-vom-synology-nas-mit-duplicity-duply-banana-pi-und-onedrive/">Techbox</a> deckt.
Jedoch bekommt man im Office 365 Plan, den ich durch die Universität noch besitze, 1 TB Speicher umsonst.
Heißt also: solange es möglich ist, den Backupcycle der Owncloud durchzuführen ist die Performance nebensächlich.

####Backup der Owncloud mittels Duplicity einrichten

Für das Backuptool meiner Wahl Duplicity gibt es bereits einen <a href="http://duplicity.nongnu.org/duplicity.1.html">Wrapper</a> für das oneDrive-Backend.
Der Wrapper benötigt die beiden komponenten, welche sich über den Python Paketmanager (pip) installieren lassen.

<b>python-requests</b> - <a href="http://python-requests.org/">http://python-requests.org</a>

<b>python-requests-oauthlib</b> - <a href="https://github.com/requests/requests-oauthlib">https://github.com/requests/requests-oauthlib</a>

Nach der Installation lässt sich in der Konfiguration von Duplicity als Target OneDrive auswählen. Bei den Parametern habe ich mich an dem <a href="https://techbox.rocks/offsite-backup-vom-synology-nas-mit-duplicity-duply-banana-pi-und-onedrive/">Artikel von techbox.rocks</a> orientiert.

```bash
	TARGET='onedrive://backup'
	SOURCE='/'
	# Time frame for old backups to keep, Used for the "purge" command.
	# see duplicity man page, chapter TIME_FORMATS)
	MAX_AGE=6M
	# Number of full backups to keep. Used for the "purge-full" command.
	MAX_FULL_BACKUPS=1
	# Number of full backups for which incrementals will be kept for.
	# Used for the "purge-incr" command.
	# See duplicity man page, action "remove-all-inc-of-but-n-full".
	#MAX_FULLS_WITH_INCRS=1
	# activates duplicity --full-if-older-than option (since duplicity v0.4.4.RC3)
	# forces a full backup if last full backup reaches a specified age, for the
	# format of MAX_FULLBKP_AGE see duplicity man page, chapter TIME_FORMATS
	# Uncomment the following two lines to enable this setting.
	MAX_FULLBKP_AGE=2M
	DUPL_PARAMS="$DUPL_PARAMS --full-if-older-than $MAX_FULLBKP_AGE "
	# sets duplicity --volsize option (available since v0.4.3.RC7)
	# set the size of backup chunks to VOLSIZE MB instead of the default 25MB.
	# VOLSIZE must be number of MB's to set the volume size to.
	# Uncomment the following two lines to enable this setting.
	VOLSIZE=250
	DUPL_PARAMS="$DUPL_PARAMS --volsize $VOLSIZE "
	# verbosity of output (error 0, warning 1-2, notice 3-4, info 5-8, debug 9)
	# default is 4, if not set
	VERBOSITY=5
	DUPL_PARAMS="$DUPL_PARAMS --asynchronous-upload"
```

Danach Duply (idealerweise in einer screen-session) starten

```bash
	screen
	duply profilname backup_verify_purge --force
```

####Mehr zu dem Thema
<ul>
<li><a href="https://benmatheja.de/2015/03/owncloud-s3-backup-einrichten/">https://benmatheja.de/2015/03/owncloud-s3-backup-einrichten/</a></li>
<li><a href="https://techbox.rocks/offsite-backup-vom-synology-nas-mit-duplicity-duply-banana-pi-und-onedrive/">https://techbox.rocks/offsite-backup-vom-synology-nas-mit-duplicity-duply-banana-pi-und-onedrive/</a></li>
<li><a href="http://www.ifdattic.com/howto-encrypted-backup-with-duplicity/">http://www.ifdattic.com/howto-encrypted-backup-with-duplicity/</a></li>
</ul>
