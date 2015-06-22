---
layout: post
status: publish
published: true
title: Redirect Mopidy HTTP Client auf Port 80 mit Iptables
author:
  display_name: ben
  login: ben
  email: post@benmatheja.de
  url: http://benmatheja.de
author_login: ben
author_email: post@benmatheja.de
author_url: http://benmatheja.de
excerpt: "Nachdem wir letztens Mopidy installiert haben war noch diese kleine Unsauberkeit,
  dass das Webinterface von Mopidy nur per Port 6680 erreichbar war. Mopidy selbst
  l&auml;sst sich aber (warum auch immer) nicht auf Port 80 direkt legen.\r\nIn einer
  fr&uuml;heren Installation habe ich f&uuml;r die Weiterleitung NGinx als Proxy eingesetzt,
  jedoch gab es Komplikationen mit den Websockets des Webclients.\r\nDer einfachere
  Weg ist per iptables eine Regel einzurichten, die den Port 80 auf den Port 6680
  legt.\r\n\r\n[bash]\r\nsudo iptables -A PREROUTING -t nat -i wlan0 -p tcp --dport
  80 -j REDIRECT --to-port 6680\r\n[&#47;bash]\r\n\r\n"
wordpress_id: 398
wordpress_url: http://benmatheja.de/?p=398
date: '2014-03-17 12:55:52 +0100'
date_gmt: '2014-03-17 11:55:52 +0100'
categories:
- frontpage
- raspberryPi
tags:
- Mopidy
- RaspberryPi
- iptables
- Redirect
comments:
- id: 35
  author: Raspberry PI als Streambox dank Mopidy | benmatheja.de
  author_email: ''
  author_url: http://benmatheja.de/2014/03/raspberry-pi-als-streambox-mopidy/
  date: '2014-04-04 11:11:23 +0200'
  date_gmt: '2014-04-04 09:11:23 +0200'
  content: "[&#8230;] EDIT: Um den Port 6680 auf 80 zu routen siehe folgendes [&#8230;]"
- id: 59
  author: Fadi Asbih
  author_email: fadi_asbih@yahoo.de
  author_url: ''
  date: '2014-12-22 16:24:00 +0100'
  date_gmt: '2014-12-22 15:24:00 +0100'
  content: "Danke f&uuml;r den Tipp, verstehe ich auch nicht warum es einfach im config
    mit port 80 nicht geht! \nPS: mit iptables-persistent ist es evtl. einfacher den
    iptables zu speichern."
- id: 60
  author: Ben
  author_email: post@benmatheja.de
  author_url: http://www.benmatheja.de/
  date: '2014-12-23 14:26:00 +0100'
  date_gmt: '2014-12-23 13:26:00 +0100'
  content: |-
    Kein Thema - ist mir auch unverst&auml;ndlich.
    Bzgl. iptables-persistent bin ich voll bei dir. Habe das eben kurz recherchiert, kannte es noch nicht. Macht den ganzen Prozess wesentlich einfacher.
- id: 63
  author: Emanuel K.
  author_email: Emanuel.Kardinal@t-online.de
  author_url: ''
  date: '2015-02-15 23:15:00 +0100'
  date_gmt: '2015-02-15 22:15:00 +0100'
  content: |-
    Ports unter 1024 kann nur root &ouml;ffnen. Demzufolge m&uuml;sste man Mopidy als root ausf&uuml;hren um Port 80 f&uuml;r das Webinterface zu nutzen.

    In der &#47;etc&#47;init.d&#47;mopidy findet sich relativ weit oben der Eintrag DAEMON_USER, welcher den User bestimmt der f&uuml;r Mopidy verwendet wird. Allerdings ist davon abzuraten, Mopidy als Root auszuf&uuml;hren!
- id: 65
  author: Ben
  author_email: post@benmatheja.de
  author_url: http://www.benmatheja.de/
  date: '2015-02-16 17:37:00 +0100'
  date_gmt: '2015-02-16 16:37:00 +0100'
  content: |-
    Hi Emanuel,


    Danke f&uuml;r die Klarstellung, das erkl&auml;rt warum Mopidy sich mit Port 80 nicht starten l&auml;sst.
    Zusammenfassend nehme ich mit, dass kein besserer Weg besteht, als den Port per iptables umzuleiten.


    Viele Gr&uuml;&szlig;e
- id: 68
  author: Michael W&ouml;lk
  author_email: m.woelk@isp-werbung.de
  author_url: ''
  date: '2015-06-17 00:09:00 +0200'
  date_gmt: '2015-06-16 22:09:00 +0200'
  content: wie kann ich einen beliebigen port freigeben? bsp 7788 (um damit auf UDP
    eben zu arbeiten)
- id: 69
  author: Ben Matheja
  author_email: post@benmatheja.de
  author_url: http://www.benmatheja.de/
  date: '2015-06-17 14:49:00 +0200'
  date_gmt: '2015-06-17 12:49:00 +0200'
  content: "Probier mal folgendes:\n<code>\niptables -P OUTPUT ACCEPT\niptables -A
    INPUT -p udp --dport 7788 -j ACCEPT\n<&#47;code>\n(Erste Regel erlaubt generell
    alle ausgehenden Pakete)\n(Zweite Regel &ouml;ffnet Port 7788 f&uuml;r UDP in)\n\nWenn
    du Ubuntu einsetzt, empfehle ich dir ufw (http:&#47;&#47;wiki.ubuntuusers.de&#47;ufw)
    zu benutzen - ist einfacher zu konfigurieren. \n\nObiges erreichst du da per ufw
    allow 7788&#47;udp"
---
<p>Nachdem wir letztens Mopidy installiert haben war noch diese kleine Unsauberkeit, dass das Webinterface von Mopidy nur per Port 6680 erreichbar war. Mopidy selbst l&auml;sst sich aber (warum auch immer) nicht auf Port 80 direkt legen.<br />
In einer fr&uuml;heren Installation habe ich f&uuml;r die Weiterleitung NGinx als Proxy eingesetzt, jedoch gab es Komplikationen mit den Websockets des Webclients.<br />
Der einfachere Weg ist per iptables eine Regel einzurichten, die den Port 80 auf den Port 6680 legt.</p>
<p>[bash]<br />
sudo iptables -A PREROUTING -t nat -i wlan0 -p tcp --dport 80 -j REDIRECT --to-port 6680<br />
[&#47;bash]</p>
<p><a id="more"></a><a id="more-398"></a></p>
<p>Das kleine Problem an iptables ist: angelegte Regeln werden nicht automatisch gespeichert, das hei&szlig;t wir m&uuml;ssen daf&uuml;r sorgen, dass unsere neue Regel nicht direkt beim n&auml;chsten reboot verschwindet.</p>
<p>[bash]<br />
sudo iptables-save > iptables-rules<br />
sudo vi &#47;etc&#47;rc.local<br />
[&#47;bash]</p>
<p>Wir laden die rc.local und f&uuml;gen die folgende Zeile hinzu.</p>
<p>[bash]<br />
#!&#47;bin&#47;sh -e<br />
#<br />
# rc.local<br />
#<br />
# This script is executed at the end of each multiuser runlevel.<br />
# Make sure that the script will "exit 0" on success or any other<br />
# value on error.<br />
#<br />
# In order to enable or disable this script just change the execution<br />
# bits.<br />
#<br />
# By default this script does nothing.<br />
# Diese Zeile hinzuf&uuml;gen - Restore Iptables Rules<br />
&#47;sbin&#47;iptables-restore < &#47;home&#47;pi&#47;iptables-rules<br />
# Bring up the wlan0 on startup<br />
ifup wlan0<br />
# Print the IP address<br />
_IP=$(hostname -I) || true<br />
if [ "$_IP" ]; then<br />
  printf "My IP address is %s\n" "$_IP"<br />
fi</p>
<p>exit 0<br />
[&#47;bash]</p>
<p>Anschlie&szlig;end springen wir per VI in die interfaces.</p>
<p>[bash]<br />
sudo vi &#47;etc&#47;network&#47;interfaces<br />
[&#47;bash]</p>
<p>und f&uuml;gen die Zeile "post-up iptables-restore" hinzu</p>
<p>[bash]<br />
auto lo</p>
<p>iface lo inet loopback<br />
iface eth0 inet dhcp<br />
auto wlan0<br />
allow-hotplug wlan0<br />
iface wlan0 inet dhcp<br />
        wpa-ssid ""<br />
        wpa-psk ""<br />
post-up iptables-restore<br />
iface default inet dhcp</p>
<p>[&#47;bash]</p>
<p>Das wars! :)</p>
