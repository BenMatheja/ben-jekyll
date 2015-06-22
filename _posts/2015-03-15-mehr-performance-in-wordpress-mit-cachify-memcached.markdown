---
layout: post
status: publish
published: true
title: Mehr Performance mit Cachify & Memcached
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

