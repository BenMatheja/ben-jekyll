---
layout: post
title: Kostenbetrachtung Offsite-Backup via S3
wordpress_url: https://benmatheja.de/?p=582
date: '2015-05-08 08:33:27 +0200'
date_gmt: '2015-05-08 06:33:27 +0200'
disqus_comments: true
---
Nachdem ich nun seit ca 2 Monaten meine Backups verschlüsselt zu AWS übertrage, musste ich gestern das erste Mal aus dem Backup wiederherstellen. Dabei sind mir ein paar Dinge klar geworden.

1. Ein Backupcycle von 7 Tagen für eine persönliche Cloud ist weder zweckmäig noch sinnvoll
2. Amazon schlägt verhältnismäßig zu, wenn Daten aus S3 angefordert werden.
3. Die Restore Fetch Funktion von Duply funktioniert hervorragend.

In meiner Region "EU-West-1" Frankfurt kostet mich eingehender Traffic bei Amazon $0.000 per GB, w&auml;hrend ausgehender mit&nbsp;$0.090 per GB veranschlagt wird. 
Dazu kommen vernachl&auml;ssigbare Kosten f&uuml;r die Anzahl Requests und f&uuml;r das genutzte Volumen auf der S3-Serverfarm.

<img src="/res/Screen-Shot-2015-05-08-at-10.53.05.png" width="100%" class="materialboxed">

Zum Vergleich hier einmal die Rechnung von April
Das hei&szlig;t, solange nicht wiederhergestellt werden muss, bewegt sich die monatliche Rechnung unter 5$ - Im April lag diese bei 2,60$.Da ich aus eigenem Verschulden meinen v-server neu installieren musste, habe ich gestern die gesamte OwnCloud aus S3 wiederhergestellt (69GB).

<img src="/res/Screen-Shot-2015-05-08-at-10.53.48.png" width="100%" class="materialboxed">

Alleine das hat mich 6,22$ (siehe Data Transfer) gekostet.
