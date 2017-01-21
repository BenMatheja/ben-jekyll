---
layout: post
status: publish
published: true
title: Kostenbetrachtung Offsite-Backup via S3
author:
  display_name: ben
  login: ben
  email: post@benmatheja.de
  url: http://benmatheja.de
author_login: ben
author_email: post@benmatheja.de
author_url: http://benmatheja.de
wordpress_id: 582
wordpress_url: https://benmatheja.de/?p=582
date: '2015-05-08 08:33:27 +0200'
date_gmt: '2015-05-08 06:33:27 +0200'
categories:
- Dev
tags:
- dev
- Projekt
- owncloud
- s3
- amazon
- Duply
comments: []
---
Nachdem ich nun seit ca 2 Monaten meine Backups verschlüsselt zu AWS übertrage, musste ich gestern das erste Mal aus dem Backup wiederherstellen. Dabei sind mir zwei Dinge klar geworden:<
Ein Backupcycle von 7 Tagen für eine persönliche Cloud ist weder zweckm&auml;&szlig;ig noch sinnvoll<br />
2.) Amazon schl&auml;gt verh&auml;ltnism&auml;&szlig;ig zu, wenn Daten aus S3 angefordert werden.<
3.)&nbsp;Die Restore &#47; Fetch Funktion von Duply <&#47;a>funktioniert hervorragend</p>
<p><a id="more"></a><a id="more-582"></a></p>
<p>In meiner Region "EU-West-1" Frankfurt kostet mich eingehender Traffic bei Amazon $0.000 per GB, w&auml;hrend ausgehender mit&nbsp;$0.090 per GB veranschlagt wird. Dazu kommen vernachl&auml;ssigbare Kosten f&uuml;r die Anzahl Requests und f&uuml;r das genutzte Volumen auf der S3-Serverfarm.</p>
<p>Zum Vergleich hier einmal die Rechnung von April
Das hei&szlig;t, solange nicht wiederhergestellt werden muss, bewegt sich die monatliche Rechnung unter 5$ - Im April lag diese bei<strong> 2,60$<&#47;strong>.</p>
<p><a href="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;05&#47;Screen-Shot-2015-05-08-at-10.53.48.png"><img class="materialboxed aligncenter wp-image-587" src="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;05&#47;Screen-Shot-2015-05-08-at-10.53.48.png" alt="Screen Shot 2015-05-08 at 10.53.48" width="500" height="339" &#47;><&#47;a></p>
<p>Da ich aus eigenem Verschulden meinen v-server neu installieren musste, habe ich gestern die gesamte <a href="https:&#47;&#47;owncloud.org">OwnCloud<&#47;a>&nbsp;aus S3 wiederhergestellt (69GB). Alleine das hat mich <strong>6,22$ &nbsp;<&#47;strong>(siehe Data Transfer) gekostet.</p>
<p><strong>Mehr zu dem Thema<&#47;strong></p>
<ul>
<li><a href="https:&#47;&#47;benmatheja.de&#47;2015&#47;03&#47;owncloud-s3-backup-einrichten&#47;">Sicher deine OwnCloud via Amazon S3<&#47;a><&#47;li>
<li><a title="Permanent link to Duplicity + S3: easy, cheap, encrypted, automated full-disk backups for your servers" href="http:&#47;&#47;blog.phusion.nl&#47;2013&#47;11&#47;11&#47;duplicity-s3-easy-cheap-encrypted-automated-full-disk-backups-for-your-servers&#47;" rel="bookmark">Duplicity + S3: easy, cheap, encrypted, automated full-disk backups for your server<&#47;a><&#47;li><br />
<&#47;ul></p>
