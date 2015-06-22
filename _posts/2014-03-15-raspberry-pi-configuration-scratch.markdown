---
layout: post
status: publish
published: true
title: Raspberry Pi - configuration from scratch - Part 1
author:
  display_name: ben
  login: ben
  email: post@benmatheja.de
  url: http://benmatheja.de
author_login: ben
author_email: post@benmatheja.de
author_url: http://benmatheja.de
wordpress_id: 275
wordpress_url: http://benmatheja.de/?p=275
date: '2014-03-15 11:05:49 +0100'
date_gmt: '2014-03-15 10:05:49 +0100'
categories:
- frontpage
- raspberryPi
tags:
- tutorial
- Linux
- RaspberryPi
comments: []
---
<p>Nachdem mein durchkonfigurierter PI letztens den Dienst versagte - war eine Neuinstallation unausweichlich.</p>
<h3>Kurze R&uuml;ckblende<&#47;h3><br />
Die letzten Tage war mein PI nach einer gewissen Zeit unerreichbar im Netzwerk. Meistens fiel mir das am n&auml;chsten Morgen auf, wenn ich Musik h&ouml;ren wollte :).<br />
Der Fehler lie&szlig; nicht lange auf sich warten : <em>"kernel:journal commit I&#47;O error"<&#47;em>.<br />
Das Dateisystem hatte wohl Schaden genommen.</p>
<p><strong>Edit:<&#47;strong> Der Schaden vom Dateisystem kann mit Overclocking zusammen h&auml;ngen. Es gibt F&auml;lle bei denen das so auftrat - daher habe ich bei der j&uuml;ngsten Installation darauf verzichtet.</p>
<p><strong>Edit2:<&#47;strong> hat leider auch nichts gebracht - Dateisystem ist wieder kaputt - nehme an die Karte ist hin&uuml;ber.</p>
<h3>SD Karte Vorbereiten<&#47;h3><br />
Die SD Karte habe ich mit Gparted von allen Partitionen befreit. Per <em>df -h<&#47;em> l&auml;sst sich der Name der SD-karte ermitteln.<br />
Es ist wichtig, dass alle Partitionen davor unmounted werden. Dies geschieht mit dem Befehl <em> umount &#47;dev&#47;mmcblk0p1 <&#47;em>.<br />
Meine Karte hie&szlig; mmcblk0 intern und jede Partition auf der Karte wird durch p dargestellt.</p>
<p>[bash]<br />
umount &#47;dev&#47;mmcblk0p1<br />
umount &#47;dev&#47;mmcblk0p2<br />
[&#47;bash]</p>
<h3>Betriebssystem flashen<&#47;h3><br />
Als System habe ich Raspbian eine f&uuml;r Pi optimierte Version von Debian ausgew&auml;hlt.<br />
Per <a href="http:&#47;&#47;www.raspberrypi.org&#47;downloads">http:&#47;&#47;www.raspberrypi.org&#47;downloads<&#47;a> l&auml;sst sich die neuste Version herunterladen.<br />
Danach direkt entpacken (wird meist als .zip ausgeliefert) und direkt per</p>
<p>[bash]<br />
sudo dd if=2014-01-07-wheezy-raspian.img of=&#47;dev&#47;mmcblk0 bs=4M<br />
[&#47;bash]</p>
<p>auf die Karte schreiben. Wir sind nun bereit den PI zu starten und die Konfiguration dort weiterzuf&uuml;hren.</p>
