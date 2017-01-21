---
layout: post
status: publish
published: true
title: Vagrant Tutorial - get your own BOX
author:
  display_name: ben
  login: ben
  email: post@benmatheja.de
  url: http://benmatheja.de
author_login: ben
author_email: post@benmatheja.de
author_url: http://benmatheja.de
excerpt: "Vagrant ist toll. &nbsp;Nachdem ich mich durch zahlreiche Tutorials geklickt
  habe, l&auml;uft der Vagrant auch bei mir. &nbsp;Vagrant erm&ouml;glicht eine Vorkonfiguration
  von Testumgebungen. Im Idealfall hat man nur noch ein recht kleines Archiv < 1 MB,
  welches eine lauff&auml;hige Testumgebung erstellt.&nbsp;<span style=\"line-height:
  1.5;\">Auf das Tool aufmerksam geworden, bin Ich durch <a title=\"Oracle Seminar:
  Effizienter LAMP-Stack &ndash; Some Insights\" href=\"http:&#47;&#47;benmatheja.de&#47;2013&#47;09&#47;oracle-seminar-effizienter-lamp-stack&#47;\">einen
  Vortrag bei &nbsp;Oracle Deutschland<span style=\"line-height: 1.5;\">.<&#47;span><&#47;a><&#47;span>\r\n\r\nSehr
  geholfen hat das &nbsp;Konfigurationstool <a href=\"https:&#47;&#47;puphpet.com\">puPHPet<&#47;a>.\r\n\r\n"
wordpress_id: 180
wordpress_url: http://benmatheja.de/?p=180
date: '2013-09-13 16:28:00 +0200'
date_gmt: '2013-09-13 14:28:00 +0200'
categories:
- frontpage
- Dev
tags:
- Linux
- vagrant
- VirtualBox
- VM
- dev
- Apache2
disqus_comments: true
---
<p>Vagrant ist toll. &nbsp;Nachdem ich mich durch zahlreiche Tutorials geklickt habe, l&auml;uft der Vagrant auch bei mir. &nbsp;Vagrant erm&ouml;glicht eine Vorkonfiguration von Testumgebungen. Im Idealfall hat man nur noch ein recht kleines Archiv < 1 MB, welches eine lauff&auml;hige Testumgebung erstellt.&nbsp;<span style="line-height: 1.5;">Auf das Tool aufmerksam geworden, bin Ich durch <a title="Oracle Seminar: Effizienter LAMP-Stack &ndash; Some Insights" href="http:&#47;&#47;benmatheja.de&#47;2013&#47;09&#47;oracle-seminar-effizienter-lamp-stack&#47;">einen Vortrag bei &nbsp;Oracle Deutschland<span style="line-height: 1.5;">.<&#47;span><&#47;a><&#47;span></p>
<p>Sehr geholfen hat das &nbsp;Konfigurationstool <a href="https:&#47;&#47;puphpet.com">puPHPet<&#47;a>.</p>
<p><a id="more"></a><a id="more-180"></a></p>
<h3>Installation<&#47;h3><br />
Vagrant l&auml;sst sich &uuml;ber&nbsp;<a href="http:&#47;&#47;downloads.vagrantup.com&#47;">downloads.vagrantup.com<&#47;a>&nbsp;herunterladen. Die Installation erfolgt ohne Konfigurationsbedarf. Zu beachten ist: Vagrant setzt <a href="https:&#47;&#47;www.virtualbox.org&#47;wiki&#47;Downloads">Oracle VirtualBo<&#47;a>x voraus. Also beides herunterladen und installieren.</p>
<h3>puPHPet<&#47;h3></p>
<p style="text-align: left;">Jetzt geht es daran, die Entwicklungsumgebung zu konfigurieren. <a href="https:&#47;&#47;puphpet.com&#47;">puPHPet<&#47;a> erstellt die ben&ouml;tigten Konfigurationsdateien damit Vagrant die entsprechenden Pakete durch Puppet installiert. Puppet ist ein Autokonfigurationstool f&uuml;r Unix-Systeme. Durch eine Konfigurationsdatei werden ben&ouml;tigte Pakete und Abh&auml;ngigkeiten definiert, die beim Start der Box automatisch aufgel&ouml;st und instaliert werden.<&#47;p></p>
<p style="text-align: center;"><a href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;pu_1.png"><img class="aligncenter  wp-image-184" alt="pu_1" src="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;pu_1.png" width="649" height="420" &#47;><&#47;a><&#47;p></p>
<p style="text-align: left;">PuPHPet bietet die M&ouml;glichkeit zwischen 4 Linux Distributionen zu w&auml;hlen. Ich habe mich f&uuml;r Ubuntu 12.04 - 64bit entschieden.<&#47;p></p>
<p style="text-align: center;"><a href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;pu_2.png"><img class="aligncenter  wp-image-185" alt="pu_2" src="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;pu_2.png" width="641" height="337" &#47;><&#47;a><&#47;p></p>
<p style="text-align: left;">Weiterhin kann die Adresse der Box, der verf&uuml;gbare Arbeitsspeicher und der weitergeleitete Port definiert werden. &nbsp;Die Weiterleitung funktioniert so, dass ein Request an <em>localhost:8080<&#47;em> auf den Port 80 (also den HTTP-Server) umgeleitet wird. In der n&auml;chsten Zeile wird ein Shared Folder definiert, ich habe hier den Document-Root des Apache auf c:\www gelegt um meine Projektdateien zu platzieren.<&#47;p></p>
<p style="text-align: left;"><a href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;pu_3.png"><img class="aligncenter  wp-image-186" alt="pu_3" src="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;pu_3.png" width="652" height="416" &#47;><&#47;a><&#47;p></p>
<p style="text-align: left;">Der Apache l&auml;sst sich weitgehend konfigurieren. Ben&ouml;tigte Module, &nbsp;Virtual Hosts etc. k&ouml;nnen definiert werden.<&#47;p></p>
<p style="text-align: left;"><a href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;pu_4.png"><img class="wp-image-187" alt="pu_4" src="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;pu_4.png" width="524" height="302" &#47;><&#47;a><&#47;p></p>
<p style="text-align: left;">Auch PHP l&auml;sst sich durchkonfigurieren.&nbsp;Das kann ausreichen. Jedoch brauchten wir f&uuml;r unsere Umgebung das PHP-Modul Process_Control, welches kompiliert werden muss. Soweit reichten die puPHPet-M&ouml;glichkeiten leider nicht.<&#47;p></p>
<p style="text-align: left;"><a style="line-height: 1.5;" href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;pu_5.png"><img class="wp-image-188" alt="pu_5" src="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;pu_5.png" width="536" height="486" &#47;><&#47;a><&#47;p></p>
<p style="text-align: left;">Die unterliegende Datenbank kann auch vordefiniert werden. Hier empfiehlt sich die Vagrant-Config nochmals anzupassen um den Datenbankport 3306 des Gastsystems auch auf den Port 3306 des Hostsystems umzuleiten. Nachdem das Package heruntergeladen ist, am besten in ein Verzeichnis entpacken wo die Box euch nicht st&ouml;rt. Ich habe dazu C:\VM genommen und das Basisverzeichnis des Apache auf C:\VM\www umgeleitet.<&#47;p></p>
<p>[ruby]Vagrant.configure("2") do |config|<br />
  config.vm.box = "precise32"<br />
  config.vm.box_url = "http:&#47;&#47;files.vagrantup.com&#47;precise32.box"</p>
<p>  config.vm.network :private_network, ip: "192.168.56.101"<br />
    config.vm.network :forwarded_port, guest: 80, host: 8080<br />
	config.vm.network :forwarded_port, guest: 3306, host: 3306<br />
    config.ssh.forward_agent = true</p>
<p>  config.vm.provider :virtualbox do |v|<br />
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]<br />
    v.customize ["modifyvm", :id, "--memory", 512]<br />
    v.customize ["modifyvm", :id, "--name", "devEnv"]<br />
  end</p>
<p>  config.vm.synced_folder "C:&#47;VM&#47;www", "&#47;var&#47;www", id: "vagrant-root"<br />
  config.vm.provision :shell, :inline =><br />
    "if [[ ! -f &#47;apt-get-run ]]; then sudo apt-get update &amp;&amp; sudo touch &#47;apt-get-run; fi"</p>
<p>  config.vm.provision :shell, :inline => 'echo -e "mysql_root_password=root<br />
controluser_password=awesome" > &#47;etc&#47;phpmyadmin.facts;'</p>
<p>  config.vm.provision :puppet do |puppet|<br />
    puppet.manifests_path = "manifests"<br />
    puppet.module_path = "modules"<br />
    puppet.options = ['--verbose']<br />
  end<br />
end<br />
[&#47;ruby]</p>
<h3>Vagrant starten<&#47;h3><br />
Um den Vagrant nun zu starten gen&uuml;gt "cd" in das Verzeichnis und ein "vagrant up" von der Kommandozeile aus.<em> (Windows-taste + R &nbsp;... "cmd" eingeben <Enter>).<&#47;em> Nun f&auml;ngt der Vagrant an, das vorher angegebene Basissystem (hier Ubuntu 12.04 64-Bit) herunterzuladen. Anschlie&szlig;end wird die VM gebootet und Puppet &uuml;bernimmt die Autokonfiguration (Pakete herunterladen und konfigurieren)</p>
<p><a href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;vagrant-up.png"><img class="aligncenter size-full wp-image-204" alt="vagrant up" src="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;vagrant-up.png" width="659" height="351" &#47;><&#47;a></p>
<h3>Schl&uuml;sselkind<&#47;h3><br />
Um die VM weiter zu konfigurieren, verwende ich SSH. Vagrant bietet per "Vagrant SSH" einen vorkonfigurierten Schl&uuml;ssel mit der sich unsere Client gegen die Box authentifizieren kann.</p>
<p><a href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;5.png"><img class="aligncenter size-full wp-image-205" alt="5" src="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;5.png" width="677" height="448" &#47;><&#47;a>Um sich nun mit der VM zu verbinden sind drei Dinge erforderlich:</p>
<p>1.) Wir brauchen einen SSH Client, dazu empfehle ich <a href="http:&#47;&#47;www.chiark.greenend.org.uk&#47;~sgtatham&#47;putty&#47;download.html">Putty<&#47;a></p>
<p>2.) Wir brauchen einen Schl&uuml;sselmanager, der SSH-Authentifizierung &uuml;ber Public&#47;Private-Key-Infrastruktur erm&ouml;glicht - <a href="http:&#47;&#47;www.chiark.greenend.org.uk&#47;~sgtatham&#47;putty&#47;download.html">Pageant<&#47;a></p>
<p>3.) Wir brauchen einen Konverter, der aus Unix ssh-Keygens .ppk Dateien erzeugen kann, damit Windows unseren PrivateKey auch versteht. - <a href="http:&#47;&#47;www.chiark.greenend.org.uk&#47;~sgtatham&#47;putty&#47;download.html">Puttygen<&#47;a></p>
<p>Also herunterladen - Installation ist nicht erforderlich.</p>
<p>Als n&auml;chstes laden wir den Schl&uuml;ssel den uns Vagrant schon erzeugt hat in&nbsp;<strong>PuttyGen<&#47;strong></p>
<p>[gallery ids="208,209,210"]</p>
<p>Im Endeffekt nur Reinladen, die Einstellungen w&auml;hlen wie auf dem letzten Bild und per "Save Private Key" Schl&uuml;ssel als .ppk abspeichern. Jetzt starten wir Pageant um unseren Schl&uuml;ssel auch nachher beim Verbinden mit der VM benutzen zu k&ouml;nnen.<a href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;pageant.png"><img class="aligncenter size-medium wp-image-212" alt="pageant" src="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;pageant-300x213.png" width="300" height="213" &#47;><&#47;a><br />
&Uuml;ber "add Key" den erzeugten Schl&uuml;ssel hinzuf&uuml;gen.</p>
<h3>Hello Box<&#47;h3><br />
Wir haben es fast geschafft. Der Vagrant l&auml;uft, wir haben den Schl&uuml;ssel zur Box. Nun k&ouml;nnen wir uns auf die Box verbinden.<br />
Dazu per <strong>Putty<&#47;strong> auf "localhost:2222" verbinden.<br />
<a href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;9.png"><img class="aligncenter size-medium wp-image-214" alt="9" src="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;9-300x288.png" width="300" height="288" &#47;><&#47;a><br />
Benutzername ist <strong>"vagrant"<&#47;strong> - Passwort gibt es Dank PrivateKey keines.</p>
<p><a href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;putty.png"><img class="aligncenter size-medium wp-image-217" alt="putty" src="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;putty-300x256.png" width="300" height="256" &#47;><&#47;a><strong>Wir haben es geschafft!<&#47;strong></p>
<p>Die vorkonfigurierte Box l&auml;uft und ist per SSH auf <em>localhost:2222<&#47;em> erreichbar. Der integrierte Apache liegt auf <em>localhost:8080<&#47;em> und die angeschlossene MySQL auf <em>localhost:3306<&#47;em></p>
<h3>Ein paar Tweaks<&#47;h3><br />
Leider schafft es die vorkonfigurierte Datei das Modul Rewrite zwar zu inkludieren, aber schaltet die Direktive AllowRewrite nicht richtig. Ohne Rewrite - keine Domains wie <em>meinweb.de&#47;blog&#47;artikel-was-passiert-heute&nbsp;<&#47;em>und REST services + MVC funktionieren ohne Dispatcher auch nicht so gut, wie auch immer.</p>
<p>[shell]<br />
cd etc&#47;apache2&#47;sites-available<br />
sudo vim default<br />
[&#47;shell]</p>
<p>Die beiden Befehle bringen Euch genau in die Datei, in der ihr die Direktiven setzen m&uuml;sst.</p>
<p><a href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;rewr1-1.png"><img class="aligncenter size-medium wp-image-220" alt="rewr1-1" src="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2013&#47;09&#47;rewr1-1-300x256.png" width="300" height="256" &#47;><&#47;a>Die beiden Verzeichnisse m&uuml;ssen f&uuml;r Rewrite erlaubt sein, also <strong>AllowOverride all<&#47;strong> statt <em>AllowOverride none<&#47;em>. Das ganze speichern per "<strong>:wq!<&#47;strong>". Nun den Apache2 per "<strong>sudo apache2ctl restart<&#47;strong>" neustarten und die Sache l&auml;uft.</p>
<h3>Ein paar Gedanken<&#47;h3><br />
Ich habe mich jetzt relativ lange mit Vagrant befasst und kann daher auch schon ein Paar Klischees abr&auml;umen. Einfach out-of-the-Box l&auml;uft die VM tendenziell gar nicht. Es kann funktionieren, aber ohne Grundwissen von Unix Systemen w&uuml;rde ich dem Vagranten, wenn es nur um Web-Development geht den WAMP-Server vorziehen.</p>
<p>Warum? Er ist mega einfach zu installieren und l&auml;uft out of the box. Der Vagrant ist super und hat definitiv seine Daseinsberechtigung, aber die Konfiguration kann einem echt graue Haare verschaffen.</p>
