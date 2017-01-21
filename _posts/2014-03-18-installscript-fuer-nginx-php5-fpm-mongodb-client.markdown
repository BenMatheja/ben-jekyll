---
layout: post
status: publish
published: true
title: Installscript f&uuml;r NGinx, PHP5-FPM & MongoDB + Client
author:
  display_name: ben
  login: ben
  email: post@benmatheja.de
  url: http://benmatheja.de
author_login: ben
author_email: post@benmatheja.de
author_url: http://benmatheja.de
excerpt: "F&uuml;r mein neustes Projekt greife ich auf die Kombination aus Nginx,
  PHP5-FPM und einer MongoDB zur&uuml;ck. Daf&uuml;r habe ich auf <a href=\"http:&#47;&#47;www.github.com\">Github<&#47;a>
  ein ziemlich cooles installationsscript gefunden, welches einem die Arbeit abnimmt.
  Das Skript als .sh abspeichern, per <em>chmod a+x<&#47;em> ausf&uuml;hrbar machen
  und per <em>sudo .&#47;skriptname.sh<&#47;em> ausf&uuml;hren.\r\nGesehen&nbsp;<a
  href=\"https:&#47;&#47;github.com&#47;djit&#47;install-nginx-php-fpm-mongodb\">hier<&#47;a>.\r\n\r\n"
wordpress_id: 428
wordpress_url: http://benmatheja.de/?p=428
date: '2014-03-18 18:14:06 +0100'
date_gmt: '2014-03-18 17:14:06 +0100'
categories:
- Dev
tags:
- php
- tutorial
- bash
- NGinx
- MongoDB
comments: []
---
<p>F&uuml;r mein neustes Projekt greife ich auf die Kombination aus Nginx, PHP5-FPM und einer MongoDB zur&uuml;ck. Daf&uuml;r habe ich auf <a href="http:&#47;&#47;www.github.com">Github<&#47;a> ein ziemlich cooles installationsscript gefunden, welches einem die Arbeit abnimmt. Das Skript als .sh abspeichern, per <em>chmod a+x<&#47;em> ausf&uuml;hrbar machen und per <em>sudo .&#47;skriptname.sh<&#47;em> ausf&uuml;hren.<br />
Gesehen&nbsp;<a href="https:&#47;&#47;github.com&#47;djit&#47;install-nginx-php-fpm-mongodb">hier<&#47;a>.</p>
<p><a id="more"></a><a id="more-428"></a></p>
<p>[bash]<br />
#!&#47;usr&#47;bin&#47;env bash</p>
<p># add 10gen package GPG key and repository<br />
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10<br />
echo "deb http:&#47;&#47;downloads-distro.mongodb.org&#47;repo&#47;ubuntu-upstart dist 10gen" >> &#47;etc&#47;apt&#47;sources.list</p>
<p># add latest nginx package PGP key and repository<br />
apt-key adv --keyserver keyserver.ubuntu.com --recv C300EE8C<br />
echo "deb http:&#47;&#47;ppa.launchpad.net&#47;nginx&#47;stable&#47;ubuntu $(lsb_release -cs) main" >> &#47;etc&#47;apt&#47;sources.list</p>
<p># update apt and install<br />
apt-get update<br />
apt-get install -y --force-yes build-essential libcurl4-gnutls-dev php5-fpm php5-dev php-pear php5-cli php5-curl php5-mcrypt php5-gd nginx mongodb-10gen git</p>
<p># install php-fpm pecl extensions<br />
pecl install pecl_http<br />
pecl install mongo</p>
<p># enable extensions<br />
echo "extension=mongo.so" >> &#47;etc&#47;php5&#47;fpm&#47;php.ini<br />
echo "extension=http.so" >> &#47;etc&#47;php5&#47;fpm&#47;php.ini</p>
<p># create socket dir for php-fpm pool<br />
mkdir &#47;var&#47;run&#47;php5-fpm</p>
<p># create webroot dir<br />
sudo mkdir -p &#47;var&#47;www&#47;default.local<br />
touch &#47;var&#47;www&#47;default.local&#47;index.php<br />
echo "<?php phpinfo();" >> &#47;var&#47;www&#47;default.local&#47;index.php</p>
<p># remove default nginx server conf<br />
cd &#47;etc&#47;nginx&#47;sites-enabled<br />
rm default</p>
<p># download default website conf<br />
wget https:&#47;&#47;raw.github.com&#47;djit&#47;install-nginx-php-fpm-mongodb&#47;master&#47;default.local.conf<br />
service nginx restart</p>
<p># download default pool conf<br />
wget https:&#47;&#47;raw.github.com&#47;djit&#47;install-nginx-php-fpm-mongodb&#47;master&#47;default.local.pool<br />
mv default.local.pool &#47;etc&#47;php5&#47;fpm&#47;pool.d&#47;default.local.conf<br />
service php5-fpm restart</p>
<p>[&#47;bash]</p>
