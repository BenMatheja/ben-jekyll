---
layout: post
status: publish
published: true
title: 'Oracle Seminar: Effizienter LAMP-Stack - Some Insights'
author:
  display_name: ben
  login: ben
  email: post@benmatheja.de
  url: http://benmatheja.de
author_login: ben
author_email: post@benmatheja.de
author_url: http://benmatheja.de
excerpt: "Heute besuchte ich die <a href=\"http:&#47;&#47;www.oracle.com&#47;de&#47;index.html\">Oracle
  Deutschland GmbH<&#47;a> in Dreieich. Ziel des Ganzen war mehr &uuml;ber die von
  Oracle pr&auml;ferierte Architektur den LAMP-Stack (Linux x Apache x MySQL x PHP&#47;Perl&#47;Python)
  herauszufinden. Neben einer durchdachten Vortragsreihe und &uuml;berraschend guter
  Bewirtung sind ein paar Dinge h&auml;ngen geblieben.\r\n<ul>\r\n\t<li>Vagrant<&#47;li>\r\n\t<li>Oracle
  VM<&#47;li>\r\n\t<li>OneNote synchronisierte Schreibzugriffe?<&#47;li>\r\n\t<li>NoSQL
  f&uuml;r MySQL durch memcached<&#47;li>\r\n<&#47;ul>\r\n"
wordpress_id: 159
wordpress_url: http://benmatheja.de/?p=159
date: '2013-09-03 18:49:17 +0200'
date_gmt: '2013-09-03 16:49:17 +0200'
categories:
- frontpage
- Dev
tags:
- Virtualization
- NoSQL
- MySQL
- Linux
- vagrant
- Oracle
comments:
- id: 7
  author: Vagrant Tutorial - Get Your own Box
  author_email: ''
  author_url: http://benmatheja.de/2013/09/vagrant-tutorial/
  date: '2013-09-13 16:33:03 +0200'
  date_gmt: '2013-09-13 14:33:03 +0200'
  content: "[&#8230;] Vagrant ist toll. &nbsp;Nachdem ich mich durch zahlreiche Tutorials
    geklickt habe, l&auml;uft der Vagrant auch bei mir. &nbsp;Vagrant erm&ouml;glicht
    eine Vorkonfiguration von Testumgebungen. Im Idealfall hat man nur noch ein recht
    kleines Archiv < 1 MB, welches eine lauff&auml;hige Testumgebung erstellt.&nbsp;Auf
    das Tool aufmerksam geworden, bin Ich durch einen Vortrag bei &nbsp;Oracle Deutschland.
    [&#8230;]"
---
<p>Heute besuchte ich die <a href="http:&#47;&#47;www.oracle.com&#47;de&#47;index.html">Oracle Deutschland GmbH<&#47;a> in Dreieich. Ziel des Ganzen war mehr &uuml;ber die von Oracle pr&auml;ferierte Architektur den LAMP-Stack (Linux x Apache x MySQL x PHP&#47;Perl&#47;Python) herauszufinden. Neben einer durchdachten Vortragsreihe und &uuml;berraschend guter Bewirtung sind ein paar Dinge h&auml;ngen geblieben.</p>
<ul>
<li>Vagrant<&#47;li>
<li>Oracle VM<&#47;li>
<li>OneNote synchronisierte Schreibzugriffe?<&#47;li>
<li>NoSQL f&uuml;r MySQL durch memcached<&#47;li><br />
<&#47;ul><br />
<a id="more"></a><a id="more-159"></a></p>
<h2>Vagrant<&#47;h2><br />
<a style="color: #ea9629; text-decoration: underline; outline: #000000;" href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;vagrant.png"><img class="aligncenter size-full wp-image-165" alt="vagrant" src="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;vagrant.png" width="444" height="315" &#47;><&#47;a></p>
<p><a href="http:&#47;&#47;www.vagrantup.com&#47;">Vagrant<&#47;a> ist eine Konfigurationsl&ouml;sung f&uuml;r Testsysteme. Sie erm&ouml;glicht das vordefinieren einer vollkonfigurierten Testumgebung mit ihren ben&ouml;tigten Abh&auml;ngigkeiten in der richtigen Version. So kann jedem Entwickler das passende Testsystem bereitgestellt werden. &Auml;nderungen werden in einer Datei vermerkt, &uuml;ber die <a href="http:&#47;&#47;www.vagrantup.com&#47;">Vagrant<&#47;a> das Testsystem konfiguriert. Beispiel: Ubuntu 12.04 mit Apache2 + MySQL + PHP 5.5.3. &nbsp;Vagrant hostet ebenfalls die konfigurierte Testversion und greift daf&uuml;r intern auf <a href="https:&#47;&#47;www.virtualbox.org&#47;">Oracle Virtualbox <&#47;a>zur&uuml;ck.</p>
<p>Die Datei &uuml;ber die die Testumgebung aufgesetzt wird sieht &auml;hnlich aus (Auszug).</p>
<p>[ruby]<br />
# -*- mode: ruby -*-<br />
# vi: set ft=ruby :</p>
<p># Vagrantfile API&#47;syntax version. Don't touch unless you know what you're doing!<br />
VAGRANTFILE_API_VERSION = "2"</p>
<p>Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|<br />
  # All Vagrant configuration is done here. The most common configuration<br />
  # options are documented and commented below. For a complete reference,<br />
  # please see the online documentation at vagrantup.com.</p>
<p>  # Every Vagrant virtual environment requires a box to build off of.<br />
  config.vm.box = "precise32"</p>
<p>  # The url from where the 'config.vm.box' box will be fetched if it<br />
  # doesn't already exist on the user's system.<br />
  config.vm.box_url = "http:&#47;&#47;files.vagrantup.com&#47;precise32.box"</p>
<p>  # Create a forwarded port mapping which allows access to a specific port<br />
  # within the machine from a port on the host machine. In the example below,<br />
  # accessing "localhost:8080" will access port 80 on the guest machine.<br />
  # config.vm.network :forwarded_port, guest: 80, host: 8080</p>
<p>  # Create a private network, which allows host-only access to the machine<br />
  # using a specific IP.<br />
  # config.vm.network :private_network, ip: "192.168.33.10"<br />
[&#47;ruby]</p>
<p>Da ich f&uuml;r die Arbeit so eine Testumgebung zusammenstellen werde, gibt es die n&auml;chsten Tage das passende Tutorial.</p>
<h2>Oracle VM<&#47;h2><br />
Nebenbei bin ich gerade daran die<a href="http:&#47;&#47;www.oracle.com&#47;technetwork&#47;server-storage&#47;vm&#47;index.html"> Oracle VM<&#47;a> L&ouml;sung zu Testen. Sie besteht aus zwei Komponenten. Einem sehr schlanken VM Server (~300mb), der die einzelnen Maschinen beheimatet und einen f&uuml;r meine Begriffe recht gro&szlig;en VM Manager (>3GB), welcher den VM Server per Webinterface konfiguriert und neue Maschinen anlegen kann. Bequem dabei ist, Oracle stellt den VM Manager auf Oracle Linux installiert als importierbare .ova-Datei zur Verf&uuml;gung. So ist einfaches Importieren in <a href="https:&#47;&#47;www.virtualbox.org&#47;">VirtualBox&nbsp;<&#47;a>zum Testen&nbsp;gew&auml;hrleistet. <em>(Props an mich f&uuml;r den Buzzword-Namen)<&#47;em></p>
<p><a href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;Unbenannt2.png"><img class="aligncenter size-full wp-image-162" alt="Oracle VM Server in VirtualBox" src="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;Unbenannt2.png" width="739" height="483" &#47;><&#47;a></p>
<h2>OneNote<&#47;h2><br />
Auf eine recht interessante Sache bin ich gesto&szlig;en. Und zwar scheint <a href="http:&#47;&#47;office.microsoft.com&#47;de-de&#47;onenote&#47;">OneNote<&#47;a> von Haus aus tolerant gegen&uuml;ber konkurrierende Schreibzugriffen sein. Wer schon einmal mit <a href="http:&#47;&#47;docs.google.com&#47;?hl=de&lrm;">Google Docs <&#47;a>kollaborativ gearbeitet hat, wei&szlig; was Ich meine.&nbsp;Ein Mitarbeiter der <a href="http:&#47;&#47;www.speedlink.com&#47;">J&ouml;llenbeck Gmbh<&#47;a> (oder auch <a href="http:&#47;&#47;www.speedlink.com&#47;">SpeedLink<&#47;a>&nbsp;) stellte die Wandlung der unternehmenseigenen Infrastruktur im Zuge von steigenden Kundenbed&uuml;rfnissen vor.&nbsp;<span style="line-height: 1.5;">Wie auch immer. Er erz&auml;hlte, wenn ein OneNote-Notizbuch in einem Directory untergebracht ist, auf welches mehrere Personen Lese und Schreibrechte besitzen, werden &Auml;nderungen in der Datei direkt an alle verbundenen Nutzer weitergereicht. Das hei&szlig;t kollaboratives Arbeiten direkt aus <a href="http:&#47;&#47;office.microsoft.com&#47;de-de&#47;onenote&#47;">OneNote<&#47;a> heraus.&nbsp;<&#47;span></p>
<h2>MySQL 5.6 implements NoSQL<&#47;h2><br />
Ein Vortrag, der &uuml;ber MySQL hinsichtlich High-Availability und Clusterf&auml;higkeit informierte, sprach die M&ouml;glichkeit an <a href="http:&#47;&#47;dev.mysql.com&#47;tech-resources&#47;articles&#47;whats-new-in-mysql-5.6.html">MySQL 5.6<&#47;a> als NoSQL l&ouml;sung einzusetzen. Dies wird vorallem durch memcached erm&ouml;glicht. <a href="http:&#47;&#47;memcached.org&#47;">memcached<&#47;a> wird dabei verwendet um direkt mit der unterliegenden <a href="http:&#47;&#47;dev.mysql.com&#47;doc&#47;refman&#47;5.6&#47;en&#47;innodb-memcached.html">innoDB zu kommunizieren<&#47;a>. Der Vorteil dabei ist zum einen, die Datenbankstruktur kann zu Gunsten der Performance hinter sich gelassen werden. Dabei werden aber trotzdem die Redundanz und Replikation und damit die Verf&uuml;gbarkeit der Datenbank beibehalten. Zudem lassen sich die Daten &uuml;ber die gewohnten SQL-Befehle ansprechen. Es entsteht quasi ein Key-Value-Store on Demand.</p>
