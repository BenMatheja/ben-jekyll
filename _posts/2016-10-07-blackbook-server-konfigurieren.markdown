---
layout: post
title: 'Blackbook: Server konfigurieren'
date: 2016-10-07 22:15:28.000000000 +02:00
categories:
- frontpage
tags: []
status: publish 
type: post
published: false 
author:
  login: ben
  email: post@benmatheja.de
  display_name: ben
  first_name: Ben
  last_name: Matheja
---
<h3>Basics</h3>
<h4>Update Packages</h4>
<p>[code lang="bash"]<br />
apt-get update &amp;&amp; apt-get upgrade [/code]</p>
<h4>Harden SSH</h4>
<p>(restrict password authentication, move SSH Port away from 22)</p>
<h4>Enable UFW</h4>
<p>Installieren von der uncomplicated Firewall und den Standard SSH Port erlauben.<br />
Jeder eingehender Traffic der nicht explizit erlaubt ist, wird nun geblockt</p>
<p>[code lang="bash"]<br />
apt-get install ufw<br />
ufw allow 22/tcp<br />
ufw enable<br />
[/code]</p>
<ul>
<li>Retrieve Files from previous server (http://johnveldboom.com/posts/sync-files-between-servers-using-rsync/)</li>
</ul>
<h3>LEMP Stack</h3>
<ul>
<li>https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-in-ubuntu-16-04</li>
<li>LetsEncrypt (http://letsencrypt.readthedocs.io/en/latest/using.html#webroot) https://serversforhackers.com/video/letsencrypt-for-free-easy-ssl-certificates</li>
<li>PHPmyAdmin</li>
</ul>
<h3>Owncloud</h3>
<ul>
<li>Basic APP</li>
<li>Redis (https://www.techandme.se/install-redis-cache-on-ubuntu-server-with-php-7-and-owncloud/)</li>
<li>PHP-FPM (http://myshell.co.uk/blog/2012/07/adjusting-child-processes-for-php-fpm-nginx/)</li>
<li>Fail2Ban</li>
</ul>
<h3>Wordpress</h3>
<ul>
<li>https://www.digitalocean.com/community/tutorials/how-to-configure-redis-caching-to-speed-up-wordpress-on-ubuntu-14-04</li>
</ul>
<h3>Teamspeak3</h3>
<ul>
<li>https://www.digitalocean.com/community/questions/setup-teamspeak-server-ubuntu-15-04</li>
</ul>
<h3>Backup</h3>
<ul>
<li>Duplicity -&gt; OneDrive / NFS</li>
<li>http://www.ifdattic.com/howto-encrypted-backup-with-duplicity/</li>
</ul>
<p>&nbsp;</p>
