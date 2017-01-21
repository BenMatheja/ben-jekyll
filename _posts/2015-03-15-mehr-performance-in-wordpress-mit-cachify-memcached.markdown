---
layout: post
status: publish
published: true
title: Mehr Performance mit Cachify & Memcached
author:
  display_name: ben
  login: ben
  email: post@benmatheja.de
  url: http://benmatheja.de
author_login: ben
author_email: post@benmatheja.de
author_url: http://benmatheja.de
excerpt: Seit einer Weile setze ich das Wordpress-Plugin <a href="http:&#47;&#47;cachify.de">Cachify<&#47;a>
  auf diesem und anderen Blogs ein. <a href="http:&#47;&#47;cachify.de">Cachify<&#47;a>&nbsp;sorgt
  als Page-Cache daf&uuml;r, dass bei jedem Seitenaufruf&nbsp;nicht erneut der PHP-Interpreter
  f&uuml;r die gesamte Seite angeworfen wird. Das Plugin speichert das HTML-Ergebnis&nbsp;f&uuml;r
  eine gewisse Dauer zwischen und versorgt damit die Besucher.&nbsp;Der Nutzer merkt
  davon nichts, au&szlig;er dass sich die Ladezeit des Blogs wesentlich verbessert.
wordpress_id: 541
wordpress_url: https://benmatheja.de/?p=541
date: '2015-03-15 14:30:11 +0100'
date_gmt: '2015-03-15 13:30:11 +0100'
categories:
- Dev
tags:
- php
- tutorial
- MySQL
- Linux
- memcached
- NGinx
- wordpress
- cachify
- review
- pagespeed
comments: []
---
<<<<<<< HEAD
<p>Seit einer Weile setze ich das Wordpress-Plugin <a href="http:&#47;&#47;cachify.de">Cachify<&#47;a> auf diesem und anderen Blogs ein. <a href="http:&#47;&#47;cachify.de">Cachify<&#47;a>&nbsp;sorgt als Page-Cache daf&uuml;r, dass bei jedem Seitenaufruf&nbsp;nicht erneut der PHP-Interpreter f&uuml;r die gesamte Seite angeworfen wird. Das Plugin speichert das HTML-Ergebnis&nbsp;f&uuml;r eine gewisse Dauer zwischen und versorgt damit die Besucher.&nbsp;Der Nutzer merkt davon nichts, au&szlig;er dass sich die Ladezeit des Blogs wesentlich verbessert.<a id="more"></a><a id="more-541"></a></p>
<h3>Why not memcached?<&#47;h3><br />
W&auml;hrend ich relativ lange den Cache in der MySQL-Datenbank gespeichert habe, kam mir vorhin die Idee <a href="http:&#47;&#47;memcached.org">Memcached<&#47;a> auszuprobieren. <a href="http:&#47;&#47;memcached.org">Memcached<&#47;a> benutzt den Arbeitsspeicher als Cache, ist damit (theoretisch)&nbsp;wesentlich schneller als die tr&auml;gere Festplatte.</p>
<p>Hier erweist sich der Einsatz von <a href="http:&#47;&#47;nginx.org">Nginx<&#47;a> als gl&uuml;cklicher Zufall. Der Webserver erlaubt es, direkt mit <a href="http:&#47;&#47;memcached.org">Memcached<&#47;a>&nbsp;zu kommunizieren. Das Nginx-Modul <a href="http:&#47;&#47;nginx.org&#47;en&#47;docs&#47;http&#47;ngx_http_memcached_module.html">HttpMemcachedModule<&#47;a> geh&ouml;rt bereits zum Lieferumgang und kann Seiten direkt aus dem Arbeitsspeicher ausliefern. Wird <a href="http:&#47;&#47;httpd.apache.org">Apache <&#47;a>eingesetzt, verliert sich der Vorteil, da <a href="http:&#47;&#47;memcached.org">Memcached<&#47;a>&nbsp;durch ein PHP-Skript angeworfen werden m&uuml;sste.</p>
<p>Die Installation gestaltet sich einfach. Die Pakete werden &uuml;ber das untere Kommando nachinstalliert und sind direkt lauff&auml;hig.</p>
<p>[bash] sudo apt-get install memcached php5-memcached [&#47;bash]</p>
<p>Um nachzupr&uuml;fen, ob <a href="http:&#47;&#47;memcached.org">Memcached<&#47;a>&nbsp;l&auml;uft rufe ich den kurz den processmonitor auf</p>
<p>[bash]ben@ben-dev.de:&#47;etc&#47;nginx&#47;sites-available$ ps aux | grep memcache<br />
memcache 24688 0.0 0.1 332412 7732 ? Sl 11:57 0:00<br />
&#47;usr&#47;bin&#47;memcached -m 64 -p 11211 -u memcache -l 127.0.0.1[&#47;bash]</p>
<p><a href="http:&#47;&#47;memcached.org">Memcached<&#47;a>&nbsp;ist aktiviert und l&auml;uft unter localhost:11211.</p>
<h3>Nginx Konfiguration<&#47;h3><br />
Die Webserver-Konfiguration ist etwas aufw&auml;ndiger. Wir m&uuml;ssen <a href="http:&#47;&#47;nginx.org">Nginx<&#47;a> instruieren, nicht bei jedem Aufruf dumm den PHP-Interpreter anzuwerfen, sondern alles was geht aus <a href="http:&#47;&#47;memcached.org">Memcached<&#47;a>&nbsp;zu beziehen. Hier angeh&auml;ngt ist die Nginx-Konfiguration f&uuml;r dieses Blog.<br />
<script src="https:&#47;&#47;gist.github.com&#47;BenMatheja&#47;1128a6d8ac0b689c99f5.js"><&#47;script><br />
Um die Aufrufe entsprechend umzuleiten, habe ich die Anpassungen (gekennzeichnet mit Memcache-Erweiterungen hinzugef&uuml;gt).</p>
<h3>Cachify konfigurieren<&#47;h3><br />
Nun noch bei Cachify memcached aktivieren und die Sache l&auml;uft.<a href="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;03&#47;Screen-Shot-2015-03-15-at-13.48.40.png"><img class="  wp-image-556 alignright" src="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;03&#47;Screen-Shot-2015-03-15-at-13.48.40.png" alt="Screen Shot 2015-03-15 at 13.48.40" width="427" height="304" &#47;><&#47;a></p>
<h3>Fazit &#47; Performance Review<&#47;h3><br />
Um eine grobe Einsch&auml;tzung zu bieten, wie sich die Performance unter Memcached verh&auml;lt, habe ich zwei <a href="http:&#47;&#47;www.webpagetest.org&#47;">Webpagetests<&#47;a> durchgef&uuml;hrt und die Ergebnisse per Screenshot unten angehangen.</p>
<p>[caption id="attachment_559" align="aligncenter" width="617"]<a href="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;03&#47;memcache-off.png"><img class="wp-image-559 " src="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;03&#47;memcache-off.png" alt="memcached off" width="617" height="214" &#47;><&#47;a> memcached off[&#47;caption]</p>
<p>[caption id="attachment_565" align="alignright" width="633"]<a href="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;03&#47;Screen-Shot-2015-03-15-at-14.34.40.png"><img class="wp-image-565 " src="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2015&#47;03&#47;Screen-Shot-2015-03-15-at-14.34.40.png" alt="memcached on" width="633" height="221" &#47;><&#47;a> memcached on[&#47;caption]</p>
<p>Auff&auml;llig ist, dass Memcache die Zeit bis das Erste Byte an den Browser ausgeliefert wird um mehr als das 3-fache verringert (0,791s zu 0,207s). Dies wirkt sich schlussendlich auch positiv auf die insgesamte PageLoad-Time aus.</p>
<p>Wo dieses Blog trotzdem Zeit verliert, ist bei der Disqus-Kommentarfunktion, die &uuml;ber JavaScript nachgeladen wird. Zus&auml;tzlich w&uuml;rde sich ein CDN zur Bereitstellung der statische Inhalte positiv auf die Performance auswirken.</p>
<h3>Mehr zu dem Thema<&#47;h3></p>
<ul>
<li><a class="crp_title" href="https:&#47;&#47;www.kadder.de&#47;2013&#47;11&#47;nginx-mit-ssl-und-spdy&#47;">Nginx mit SSL und SPDY<&#47;a><&#47;li>
<li><a class="crp_title" href="https:&#47;&#47;www.kadder.de&#47;2014&#47;04&#47;pagespeed-nginx-memcached-php5-fpm&#47;">Pagespeed: Nginx + Memcached + PHP5-FPM<&#47;a><&#47;li>
<li><a href="http:&#47;&#47;www.patrick-gotthard.de&#47;wordpress-rasend-schnell-mit-apc-memcached-und-weiteren-optimierungen">WordPress rasend schnell mit APC, memcached und weiteren Optimierungen<&#47;a><&#47;li>
<li><a href="https:&#47;&#47;timmehosting.de&#47;high-performance-wordpress-mit-wp-ffpc-memcached-nginx-und-ispconfig">High-performance WordPress mit WP-FFPC, memcached, nginx und ISPConfig<&#47;a><&#47;li><br />
<&#47;ul></p>
=======
Seit einer Weile setze ich das WordPress-Plugin Cachify auf diesem und anderen Blogs ein. Cachify sorgt als Page-Cache dafür, dass bei jedem Seitenaufruf nicht erneut der PHP-Interpreter für die gesamte Seite angeworfen wird. 

Das Plugin speichert das HTML-Ergebnis für eine gewisse Dauer und versorgt damit die Besucher. Der Nutzer merkt davon nichts, außer dass sich die Ladezeit des Blogs verringert.

## Why not memcached?

Während ich relativ lange den Cache in der MySQL-Datenbank gespeichert habe, kam mir vorhin die Idee Memcached auszuprobieren. Memcached benutzt den Arbeitsspeicher als Cache, ist damit (theoretisch) wesentlich schneller als die trägere Festplatte. Hier erweist sich der Einsatz von Nginx als glücklicher Zufall. Der Webserver erlaubt es, direkt mit Memcached zu kommunizieren. Das Nginx-Modul *HttpMemcachedModule* gehört bereits zum Lieferumgang und kann Seiten direkt aus dem Arbeitsspeicher ausliefern. Wird Apache eingesetzt, verliert sich der Vorteil, da Memcached durch ein PHP-Skript angeworfen werden müsste.

Die Installation gestaltet sich einfach. Die Pakete werden über das untere Kommando nachinstalliert und sind direkt lauffähig.
```
sudo apt-get install memcached php5-memcached
```

Um nachzuprüfen, ob Memcached läuft rufe ich den kurz den processmonitor auf

```
ben@ben-dev.de:/etc/nginx/sites-available$ ps aux | grep memcache
memcache 24688  0.0  0.1 332412  7732 ?        Sl   11:57   0:00
/usr/bin/memcached -m 64 -p 11211 -u memcache -l 127.0.0.1
```

Memcached ist aktiviert und läuft unter localhost:11211.

### Nginx Konfiguration

Die Webserver-Konfiguration ist etwas aufwändiger. Wir müssen Nginx instruieren, nicht bei jedem Aufruf dumm den PHP-Interpreter anzuwerfen, sondern alles was geht aus Memcached zu beziehen. Hier angehängt ist die Nginx-Konfiguration für dieses Blog.
{% gist BenMatheja/1128a6d8ac0b689c99f5 %}
Um die Aufrufe entsprechend umzuleiten, habe ich die Anpassungen (gekennzeichnet mit Memcache-Erweiterungen hinzugefügt).

###Cachify konfigurieren
<img src="/res/Screen-Shot-2015-03-15-at-13.48.40.png" width="100%" class="materialboxed">
Nun noch bei Cachify memcached aktivieren und die Sache läuft.
### Fazit / Performance Review

Um eine grobe Einschätzung zu bieten, wie sich die Performance unter Memcached verhält, habe ich zwei Webpagetests durchgeführt und die Ergebnisse per Screenshot unten angehangen.
<img src="/res/memcache-off.png" data-caption="Memcache off" width="100%" class="materialboxed">
<img src="/res/memcache-on.png" data-caption="Memcache on" width="100%" class="materialboxed">
Auffällig ist, dass Memcache die Zeit bis das Erste Byte an den Browser ausgeliefert wird um mehr als das 3-fache verringert (0,791s zu 0,207s). Dies wirkt sich schlussendlich auch positiv auf die insgesamte PageLoad-Time aus.

Wo dieses Blog trotzdem Zeit verliert, ist bei der Disqus-Kommentarfunktion, die über JavaScript nachgeladen wird. Zusätzlich würde sich ein CDN zur Bereitstellung der statische Inhalte positiv auf die Performance auswirken.
