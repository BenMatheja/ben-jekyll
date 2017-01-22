---
layout: post
status: publish
published: true
title: Installscript für NGinx, PHP5-FPM & MongoDB + Client
author:
  display_name: ben
  login: ben
  email: post@benmatheja.de
  url: http://benmatheja.de
author_login: ben
author_email: post@benmatheja.de
author_url: http://benmatheja.de
excerpt: "Für mein neustes Projekt greife ich auf die Kombination aus Nginx,
  PHP5-FPM und einer MongoDB zurück. Dafür habe ich auf <a href=\"http://www.github.com\">Github</a>
  ein ziemlich cooles installationsscript gefunden, welches einem die Arbeit abnimmt.
  Das Skript als .sh abspeichern, per <em>chmod a+x</em> ausführbar machen
  und per <em>sudo .&#47;skriptname.sh<&#47;em> ausführen.\r\nGesehen&nbsp;<a
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
disqus_comments: true
---
Für mein neustes Projekt greife ich auf die Kombination aus Nginx, PHP5-FPM und einer MongoDB zurück. Dafür habe ich auf <a href="http://www.github.com">Github</a> ein ziemlich cooles installationsscript gefunden, welches einem die Arbeit abnimmt. Das Skript als .sh abspeichern, per <em>chmod a+x</em> ausführbar machen und per <em>sudo ./skriptname.sh</em> ausführen.
Gesehen&nbsp;<a href="https://github.com/djit/install-nginx-php-fpm-mongodb">hier</a>.

```bash
	#!/usr/bin/env bash
	# add 10gen package GPG key and repository
	apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
	echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" >> /etc/apt/sources.list
	# add latest nginx package PGP key and repository
	apt-key adv --keyserver keyserver.ubuntu.com --recv C300EE8C
	echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu $(lsb_release -cs) main" >> /etc/apt/sources.list
	# update apt and install
	apt-get update
	apt-get install -y --force-yes build-essential libcurl4-gnutls-dev php5-fpm php5-dev php-pear php5-cli php5-curl php5-mcrypt php5-gd nginx mongodb-10gen git
	# install php-fpm pecl extensions
	pecl install pecl_http
	pecl install mongo
	# enable extensions
	echo "extension=mongo.so" >> /etc/php5/fpm/php.ini
	echo "extension=http.so" >> /etc/php5/fpm/php.ini
	# create socket dir for php-fpm pool
	mkdir /var/run/php5-fpm
	# create webroot dir
	sudo mkdir -p /var/www/default.local
	touch /var/www/default.local/index.php
	echo "<?php phpinfo();" >> /var/www/default.local/index.php
	# remove default nginx server conf
	cd /etc/nginx/sites-enabled
	rm default
	# download default website conf
	wget https://raw.github.com/djit/install-nginx-php-fpm-mongodb/master/default.local.conf
	service nginx restart
	# download default pool conf
	wget https://raw.github.com/djit/install-nginx-php-fpm-mongodb/master/default.local.pool
	mv default.local.pool /etc/php5/fpm/pool.d/default.local.conf
	service php5-fpm restart
```
