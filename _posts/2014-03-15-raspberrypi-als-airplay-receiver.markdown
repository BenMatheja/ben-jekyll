---
layout: post
status: publish
published: true
title: RaspberryPi als AirPlay receiver
author:
  display_name: ben
  login: ben
  email: post@benmatheja.de
  url: http://benmatheja.de
author_login: ben
author_email: post@benmatheja.de
author_url: http://benmatheja.de
excerpt: "<p style=\"text-align: left;\">Im letzten Tutorial haben wir Mopidy f&uuml;r
  den standalone-Betrieb eingerichtet. Doch was ist, wenn von anderen Quellen als
  Spotify gestreamt werden soll? Beispielsw<span style=\"line-height: 1.714285714;
  font-size: 1rem;\">eise YouTube oder Soundcloud.&nbsp;<&#47;span><span style=\"line-height:
  1.714285714; font-size: 1rem;\">AirPlay bietet sich genau daf&uuml;r an. Wir werden
  die AirPlay Emulation &nbsp;<&#47;span><a style=\"line-height: 1.714285714; font-size:
  1rem;\" href=\"https:&#47;&#47;github.com&#47;hendrikw82&#47;shairport\">Shairport<&#47;a><span
  style=\"line-height: 1.714285714; font-size: 1rem;\">&nbsp;mit Anpassungen von abrasive
  benutzen.<&#47;span><&#47;p>\r\n"
wordpress_id: 345
wordpress_url: http://benmatheja.de/?p=345
date: '2014-03-15 17:42:04 +0100'
date_gmt: '2014-03-15 16:42:04 +0100'
categories:
- frontpage
- raspberryPi
tags:
- RaspberryPi
- AirPlay
- Bonjour
- Shairport
- AirFoil
disqus_comments: true
---
<p style="text-align: left;">Im letzten Tutorial haben wir Mopidy f&uuml;r den standalone-Betrieb eingerichtet. Doch was ist, wenn von anderen Quellen als Spotify gestreamt werden soll? Beispielsw<span style="line-height: 1.714285714; font-size: 1rem;">eise YouTube oder Soundcloud.&nbsp;<&#47;span><span style="line-height: 1.714285714; font-size: 1rem;">AirPlay bietet sich genau daf&uuml;r an. Wir werden die AirPlay Emulation &nbsp;<&#47;span><a style="line-height: 1.714285714; font-size: 1rem;" href="https:&#47;&#47;github.com&#47;hendrikw82&#47;shairport">Shairport<&#47;a><span style="line-height: 1.714285714; font-size: 1rem;">&nbsp;mit Anpassungen von abrasive benutzen.<&#47;span><&#47;p><br />
<a id="more"></a><a id="more-345"></a></p>
<h3>Einrichten von Shairport der AirPlay Emulation<&#47;h3><br />
Hereinladen der Pakete.</p>
<p>[bash]<br />
sudo apt-get install libao-dev libssl-dev git avahi-utils libwww-perl libcrypt-openssl-rsa-perl libio-socket-inet6-perl  libmodule-build-perl<br />
[&#47;bash]</p>
<p>Ich werde Airplay unter ~&#47;AirPlay installieren - Anfangs laden wir noch das neue Perl Net modul um Probleme mit iOS6 auszuschlie&szlig;en.</p>
<p>[bash]<br />
mkdir ~&#47;AirPlay<br />
cd Airplay<br />
git clone https:&#47;&#47;github.com&#47;njh&#47;perl-net-sdp.git<br />
cd perl-net-sdp<br />
perl Build.PL<br />
.&#47;Build<br />
.&#47;Build test<br />
sudo .&#47;Build install<br />
cd ..<br />
git clone https:&#47;&#47;github.com&#47;abrasive&#47;shairport.git<br />
cd shairport<br />
make<br />
[&#47;bash]</p>
<p>Um zu testen ob unser kompiliertes Shairport funktioniert reicht ein kurzes</p>
<p>[bash]<br />
.&#47;shairport -a AirPi<br />
[&#47;bash]</p>
<p>Nun sollte im Netzwerk ein Ger&auml;t namens AirPi auftauchen - bereit zum streamen. Dies kann via BonjourBrowser oder AirFoil Client kontrolliert werden. Idealerweise wird Shairport gestartet wenn unser Pi startet als daemon - daf&uuml;r nutzen wir folgende Anpassungen.</p>
<p>[bash]<br />
sudo make install<br />
sudo cp shairport.init.sample &#47;etc&#47;init.d&#47;shairport<br />
sudo chmod +x &#47;etc&#47;init.d&#47;shairport<br />
sudo update-rc.d shairport defaults<br />
[&#47;bash]</p>
<p>Eine letzte Anpassung betrifft das shairport file<br />
Wir &ouml;ffnen es mithilfe von</p>
<p>[bash]<br />
sudo vi &#47;etc&#47;init.d&#47;shairport<br />
[&#47;bash]</p>
<p>Suchen nach der letzten Zeile und f&uuml;gen den Parameter -a gefolgt vom Namen des AirPlay Receivers.</p>
<p>[bash]<br />
#!&#47;bin&#47;bash<br />
#<br />
# This starts and stops shairport<br />
#<br />
### BEGIN INIT INFO<br />
# Provides:          shairport<br />
# Required-Start:    $network<br />
# Required-Stop:<br />
# Short-Description: shairport - Airtunes emulator!<br />
# Description:       Airtunes emulator!<br />
# Default-Start:     2 3 4 5<br />
# Default-Stop:      0 1 6<br />
### END INIT INFO</p>
<p># Source function library.<br />
. &#47;lib&#47;lsb&#47;init-functions</p>
<p>NAME=shairport<br />
DAEMON="&#47;usr&#47;local&#47;bin&#47;shairport.pl"<br />
PIDFILE=&#47;var&#47;run&#47;$NAME.pid</p>
<p>#DAEMON_ARGS="-w $PIDFILE"<br />
DAEMON_ARGS="-w $PIDFILE -a AirPi"<br />
[&#47;bash]</p>
<p>That's all!</p>
<p>Falls euch ebenfalls kein shairport.init.sample generiert wurde - k&ouml;nnt ihr das folgende nehmen<br />
<script type="text&#47;javascript" src="https:&#47;&#47;gist.github.com&#47;BenMatheja&#47;9598380.js"><&#47;script></p>
