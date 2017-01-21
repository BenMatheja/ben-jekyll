---
layout: post
status: publish
published: true
title: CUPS, RaspberryPi & Brother DCP-7030
author:
  display_name: ben
  login: ben
  email: post@benmatheja.de
  url: http://benmatheja.de
author_login: ben
author_email: post@benmatheja.de
author_url: http://benmatheja.de
excerpt: "Heute habe ich mich daran gesetzt meinen Drucker (DCP-7030) per CUPS &uuml;ber
  den PI verf&uuml;gbar zu machen. Um das zu erreichen, installieren wir CUPS.\r\n\r\n"
wordpress_id: 445
wordpress_url: http://benmatheja.de/?p=445
date: '2014-04-08 00:52:47 +0200'
date_gmt: '2014-04-07 22:52:47 +0200'
categories:
- raspberryPi
tags:
- RaspberryPi
- CUPS
- Brother
- DCP-7030
disqus_comments: true
---
<p>Heute habe ich mich daran gesetzt meinen Drucker (DCP-7030) per CUPS &uuml;ber den PI verf&uuml;gbar zu machen. Um das zu erreichen, installieren wir CUPS.</p>
<p><a id="more"></a><a id="more-445"></a></p>
<p>[bash]<br />
sudo apt-get update<br />
sudo apt-get install cups<br />
[&#47;bash]</p>
<p><strong>Configuration von CUPS<&#47;strong></p>
<p>Die Konfiguration findet ihr unter &#47;etc&#47;cups&#47;cupsd.conf . Dort m&uuml;sst ihr einige Anpassungen vornehmen. Schaut euch mein fertiges Gist an - es enth&auml;lt die Konfig. Um nach zu vollziehen, was getan werden muss hilft folgende Liste.</p>
<p>&Auml;ndert folgende Bereiche:</p>
<ol>
<li>#Only listen for connections from the local machine<&#47;li>
<li>#Default authentication type<&#47;li>
<li>#Restrict access to the server<&#47;li>
<li>#Restrict access to the admin pages<&#47;li>
<li>#Restrict access to the configuration files<&#47;li><br />
<&#47;ol><br />
<script src="https:&#47;&#47;gist.github.com&#47;BenMatheja&#47;10068241.js"><&#47;script></p>
<p>Speichert die Konfiguration und startet den CUPS per folgendem Befehl neu.<br />
[bash]<br />
sudo service cups restart<br />
[&#47;bash]</p>
<p>Nun sollte das CUPS Webinterface unter http:&#47;&#47;<strong>IPEuresPi<&#47;strong>:631 erreichbar sein (gesetzt dem Fall, ihr habt den Port in der Konfig ebenfalls auf 631 gesetzt).</p>
<p>Um die Administration vorzunehmen, m&uuml;sst ihr auf dem PI einen Systembenutzer haben, der der Gruppe lpadmin angeh&ouml;rt. Dies erledigt ihr bspw. f&uuml;r den Nutzer pi per</p>
<p>[bash]<br />
pi@airpi &#47;etc&#47;cups $ sudo usermod -aG lpadmin pi<br />
[&#47;bash]</p>
<h3>Einh&auml;ngen des Druckers<&#47;h3><br />
Um den Drucker einzuh&auml;ngen, navigiert ihr auf http:&#47;&#47;<strong>IPEuresPi<&#47;strong>:631&#47;admin .<br />
Die Aufforderung von CUPS auf https zu wechseln akzeptieren wir und befinden uns nun im "Add Printer"-Window von CUPS.</p>
<p><a href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2014&#47;04&#47;step1.png"><img class="aligncenter size-medium wp-image-449" src="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2014&#47;04&#47;step1-241x300.png" alt="Schritt 1 - Add Printer" width="241" height="300" &#47;><&#47;a></p>
<p>Dort erscheint bereits unser DCP-7030 als Local Printer. Perfekt - wir w&auml;hlen ihn aus und gehen auf weiter. Im n&auml;chsten Schritt k&ouml;nnt ihr den Drucker noch charakterisieren - Wichtig ist, dass ihr den Haken bei <strong>Sharing<&#47;strong> setzt.</p>
<p><a href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2014&#47;04&#47;step2.png"><img class="aligncenter size-medium wp-image-450" src="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2014&#47;04&#47;step2-241x300.png" alt="Schritt 2 - Add Printer" width="241" height="300" &#47;><&#47;a></p>
<p>Im letzten Schritt fragt euch CUPS, welchen Treiber ihr benutzen m&ouml;chtet. Da CUPS keinen spezifischen Treiber f&uuml;r den 7030 mitliefert, w&auml;hle ich hier den <strong>Brother DCP-1200 Foomatic&#47;hl1250 (recommended) (en) <&#47;strong>aus<a href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2014&#47;04&#47;step3.png"><img class="aligncenter size-medium wp-image-451" src="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2014&#47;04&#47;step3-241x300.png" alt="Schritt 3 - Add Printer" width="241" height="300" &#47;><&#47;a></p>
<p>Wir best&auml;tigen per "Add Printer".</p>
<p>Der Drucker sollte nun h&auml;ngen, ob er auch funktioniert lassen wir uns per Testseite aus CUPS best&auml;tigen. Dazu wechseln wir zum Men&uuml;punkt "Printers" und w&auml;hlen unter der Schaltfl&auml;che "Maintenance" - "Print Test Page" aus.</p>
<p><a href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2014&#47;04&#47;step-4.png"><img class="aligncenter size-medium wp-image-454" src="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2014&#47;04&#47;step-4-241x300.png" alt="Schritt 4 - Testseite drucken" width="241" height="300" &#47;><&#47;a></p>
<p>Ist das ebenfalls erfolgreich k&ouml;nnt ihr den Drucker bspw. in Windows einh&auml;ngen. Er ist nun unter folgender Adresse erreichbar: http:&#47;&#47;<<strong>IpEuresPi<&#47;strong>>:631&#47;printers&#47;<<strong>NameDesDruckers<&#47;strong>> . <em>Meiner l&auml;uft bspw unter http:&#47;&#47;192.168.1.4:631&#47;printers&#47;Brother_DCP-7030<&#47;em></p>
