---
layout: post
title: Logjam - HTTPS Server updaten Tutorial
date: 2015-05-21 10:54:00.000000000 +02:00
categories:
- Dev
tags:
- bash
- https
- Linux
- NGinx
- security
- tutorial
status: publish
type: post
published: true
meta:
author:
  login: ben
  email: post@benmatheja.de
  display_name: ben
  first_name: Ben
  last_name: Matheja
---
<p>Laut <a href="http://www.heise.de/security/meldung/Logjam-Attacke-Verschluesselung-von-zehntausenden-Servern-gefaehrdet-2657502.html">Heise Security</a> gibt es eine neue Möglichkeit die HTTPS Verschlüsselung zu umgehen. Dies lässt sich auf eine Schwäche im Protokoll, welches den Diffie-Hellman-Schlüsselaustausch nutzt, zurückführen.</p>
<p>Der Angriff zwingt Server und Client die leichter knackbare 512-Bit-Variante zu verwenden. Um dies zu verhindern empfiehlt sich die Konfig des Webservers anzupassen.</p>
<p>Ich habe das eben für diese Domain vorgenommen - ist relativ einfach.</p>
<p><!--more--></p>
<p>Abhilfe kommt in zwei Schritten - Wir erzeugen erstmal 2048-bit Starke Diffie-Hellmann Parameter und weisen den Webserver an diese zu verwenden.</p>

```bash
sudo openssl dhparam -out dhparams.pem 2048
```
Ich habe die dhparams.pem in den Ordner der Zertifikate verschoben.

```bash
sudo vi /etc/nginx/sites-available/benmatheja.de
```
Im zweiten Schritt verhindern wir, dass der Server sich darauf einlässt die schwächere Variante zu akzeptieren. Dies erfolgt durch Limitierung der erlaubten SSL-Ciphers</p>

```bash
	#logjam additions
    ssl_dhparam /etc/nginx/certs/dhparams.pem;
    ssl_ciphers 'ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA';
	ssl_prefer_server_ciphers on;
```
Nun noch ein Test, ob die Konfiguration von Nginx akzeptiert wird.

```bash
ben@vps:/etc/nginx/sites-enabled$ sudo nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```
<p>Nginx ist glücklich. Nun noch ein Reload und die neue Konfiguration ist aktiviert.</p>

```bash
sudo service nginx reload
```
Über die weakdh.org Seite lässt sich nun prüfen, ob der Server gegen die Angriffsart gesichert ist.

![Screenshot](/res/Screen-Shot-2015-05-21-at-10.50.20.png)

Das sieht gut aus. 
Weitere infos wie die Konfiguration für Apache und der Zugang zum Test finden sich [hier](https://weakdh.org/sysadmin.html).
#####Mehr dazu
* [Heise Security - Logjam](
http://www.heise.de/security/meldung/Logjam-Attacke-Verschluesselung-von-zehntausenden-Servern-gefaehrdet-2657502.html)
* [Logjam DH Deployment Guide](https://weakdh.org/sysadmin.html)
