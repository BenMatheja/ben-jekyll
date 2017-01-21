---
layout: post
status: publish
published: true
title: Raspberry Pi - configuration from scratch - Part 2
author:
  display_name: ben
  login: ben
  email: post@benmatheja.de
  url: http://benmatheja.de
author_login: ben
author_email: post@benmatheja.de
author_url: http://benmatheja.de
excerpt: "Unser System ist gebootet. Der n&auml;chste Schritt ist das Dateisystem
  erweitern um den ganzen Platz der Karte auch wirklich auszunutzen. Anschlie&szlig;end
  dem PI etwas mehr Power per &Uuml;bertakten zu geben, das Keyboard Layout einstellen
  (falls ihr den PI wie ich direkt an einem Monitor zur Konfiguration betreibt), SSH
  f&uuml;r Fernzugang aktivieren und zuletzt werde ich noch das Passwort &auml;ndern.\r\n\r\n"
wordpress_id: 287
wordpress_url: http://benmatheja.de/?p=287
date: '2014-03-15 12:56:36 +0100'
date_gmt: '2014-03-15 11:56:36 +0100'
categories:
- frontpage
- raspberryPi
tags:
- tutorial
- Linux
- WLAN
- Vi
- RaspberryPi
comments: []
---
<p>Unser System ist gebootet. Der n&auml;chste Schritt ist das Dateisystem erweitern um den ganzen Platz der Karte auch wirklich auszunutzen. Anschlie&szlig;end dem PI etwas mehr Power per &Uuml;bertakten zu geben, das Keyboard Layout einstellen (falls ihr den PI wie ich direkt an einem Monitor zur Konfiguration betreibt), SSH f&uuml;r Fernzugang aktivieren und zuletzt werde ich noch das Passwort &auml;ndern.</p>
<p><a id="more"></a><a id="more-287"></a></p>
<h3>Raspi-Config<&#47;h3><br />
Direkt beim ersten Start des PI's wird das raspi-config tool geladen.<br />
Wir arbeiten uns nun wie folgt durch.</p>
<ol>
<li>Expand Filesystem<&#47;li>
<li>Overclock -> High 950 MHz ARM, 250 MHz core, 450 MHz SDRAM, 6 overvolt<&#47;li>
<li>Internationalisation Options -> Change Keyboard Layout<&#47;li>
<li>Advanced Options -> Enable SSH access<&#47;li><br />
<&#47;ol><br />
Anschlie&szlig;end best&auml;tigen wir die Frage nach einem Neustart.<br />
Nach dem Neustart loggen wir uns mit pi &#47; raspberry wieder ein. Dabei vorsicht: im regelfall ist das Tastaturlayout auf englisch, das hei&szlig;t um das Y in raspberry zu erreichen m&uuml;sst ihr auf einer deutschen Tastatur Z dr&uuml;cken.</p>
<p><strong>Edit:<&#47;strong> Setzt ihr ebenfalls raspbian wheezy ein - solltet ihr &uuml;berlegen das Paket "wolfram-engine" zu deinstallieren (macht ca 400mb aus und das update der apt-get dauert eine Ewigkeiten)<br />
[bash]<br />
sudo apt-get purge wolfram-engine<br />
[&#47;bash]</p>
<p>&nbsp;</p>
<h3>Wlan einrichten<&#47;h3><br />
Wir benutzen zuhause ein ziemliches klassiches Netzwerksetup. Ein Netgear-Router der eine sichtbare SSID aussendet und das Netz mit WPA2 verschl&uuml;sselt. Per <em> ifconfig <&#47;em> wird uns bereits das passende Ger&auml;t <em>Wlan0<&#47;em> angezeigt.</p>
<p>[bash]</p>
<p>eth0      Link encap:Ethernet  HWaddr b8:27:eb:39:4b:ce<br />
          UP BROADCAST MULTICAST  MTU:1500  Metric:1<br />
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0<br />
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0<br />
          collisions:0 txqueuelen:1000<br />
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)</p>
<p>lo        Link encap:Local Loopback<br />
          inet addr:127.0.0.1  Mask:255.0.0.0<br />
          UP LOOPBACK RUNNING  MTU:65536  Metric:1<br />
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0<br />
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0<br />
          collisions:0 txqueuelen:0<br />
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)</p>
<p>wlan0     Link encap:Ethernet  HWaddr 00:13:ef:b0:11:49<br />
          UP BROADCAST MULTICAST  MTU:1500  Metric:1<br />
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0<br />
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0<br />
          collisions:0 txqueuelen:1000<br />
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)<br />
[&#47;bash]</p>
<p>Um nun eine Verbindung herzustellen m&uuml;ssen wir die Datei <em>&#47;etc&#47;network&#47;interfaces <&#47;em>&auml;ndern.</p>
<p>[bash]<br />
sudo vi &#47;etc&#47;network&#47;interfaces<br />
[&#47;bash]</p>
<h4>Kurzer Exkurs zu VI<&#47;h4><br />
VI hat zwei Modi. Ein Editiermodus und einen Funktionsmodus. Den Editiermodus erreicht ihr durch Druck auf <kbd>i<&#47;kbd> und verlasst ihn durch Druck von <kbd>ESC<&#47;kbd><br />
Im Editiermodus k&ouml;nnt ihr nicht navigieren - im Funktionsmodus nicht editieren (straight forward, huh?).<br />
Das hei&szlig;t ihr startet im Funktionsmodus, benutzt die Pfeiltasten um an die gew&uuml;nschte Stelle zu kommen. Dabei hat sich <kbd>SHIFT + A<&#47;kbd> f&uuml;r "spring ans Ende der Zeile und aktivier den Editiermodus" und <kbd>SHIFT + G<&#47;kbd> f&uuml;r Springen in die letzte Zeile des Dokuments bew&auml;hrt. An der richtigen Stelle angekommen, aktiviert ihr den Editiermodus per <kbd>i<&#47;kbd> und schreibt drauf los. L&ouml;schen geht per Backspace oder per <kbd>x<&#47;kbd> im Funktionsmodus f&uuml;r einzelne Zeichen oder auch mit <kbd>dd<&#47;kbd> f&uuml;r die ganze Zeile. Letzte &Auml;nderung r&uuml;ckg&auml;ngig macht ihr per <kbd>u<&#47;kbd>.</p>
<p>Um den Editor zu verlassen wechselt ihr in den Funktionsmodus per <kbd>ESC<&#47;kbd> und schreibt :q f&uuml;r quit bzw <em>:q!<&#47;em> f&uuml;r quit mit verwerfen der &auml;nderungen. Wollt ihr &Auml;nderungen speichern schreibt ihr <em>:wq!<&#47;em> f&uuml;r write &amp; quit.</p>
<p>Nun aber zur&uuml;ck zur Konfiguration. Eure interfaces Datei sollte wie folgt aussehen. Dies gilt f&uuml;r ein Netz welches seine SSID aussendet und WPA-Verschl&uuml;sselung einsetzt.</p>
<p>[bash]<br />
auto lo</p>
<p>iface lo inet loopback<br />
iface eth0 inet dhcp</p>
<p>allow-hotplug wlan0<br />
auto wlan0<br />
iface wlan0 inet dhcp<br />
        wpa-ssid "NameEuresWlans"<br />
        wpa-psk "euerPasswort"<br />
#iface default inet dhcp<br />
[&#47;bash]</p>
<p>Schlie&szlig;t den Editor und speichert die Datei. Per</p>
<p>[bash]<br />
sudo ifdown wlan0<br />
sudo ifup wlan0<br />
[&#47;bash]</p>
<p>weist ihr den Kernel an die neue Konfiguration zu laden und zu nutzen. Startet den PI per</p>
<p>[bash]<br />
sudo shutdown -r now<br />
[&#47;bash]</p>
<p>neu. Der PI sollte sich nun direkt von Start an mit dem WLAN verbinden.<br />
<em>Dazu noch eine Anmerkung: Wlan kann relativ schwierig einzurichten sein. Teilweise treten Fehler auf, die man nicht versteht. Ich hatte beispielsweise von der letzten Installation eine IP f&uuml;r den RaspberryPI im Router festgelegt - dieses Festlegen hinderte den gleichen PI mit anderem hostname daran eine IP zu beziehen.<&#47;em><br />
Ist das erfolgt sind die Grundvoraussetzungen geschaffen um das Projekt weiterzuf&uuml;hren</p>
