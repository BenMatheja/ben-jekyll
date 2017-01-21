---
layout: post
status: publish
published: true
title: 'Mein Raspberry Pi Project : Printserver und Musicbox'
author:
  display_name: ben
  login: ben
  email: post@benmatheja.de
  url: http://benmatheja.de
author_login: ben
author_email: post@benmatheja.de
author_url: http://benmatheja.de
wordpress_id: 306
wordpress_url: http://benmatheja.de/?p=306
date: '2014-03-15 13:10:57 +0100'
date_gmt: '2014-03-15 12:10:57 +0100'
categories:
- frontpage
- raspberryPi
tags:
- Linux
- Projekt
- RaspberryPi
comments:
- id: 33
  author: Marcus
  author_email: offline.mtb@gmail.com
  author_url: ''
  date: '2014-04-03 23:28:00 +0200'
  date_gmt: '2014-04-03 21:28:00 +0200'
  content: "Hey Ben, \n\nwenn Du es schaffst deinen Brother DCP7030 zum laufen bekommst.
    Lass es mich bitte wissen. Bis jetzt sind alle meine Versuche diesen Drucker in
    CUPS einzubinden und &uuml;ber meinen Raspberry Pi zu drucken fehlgeschlagen....
    Ich hoffe Du hast mehr Gl&uuml;ck und l&auml;sst es mich wissen. :) \n\nGru&szlig;e
    Marcus"
- id: 34
  author: ben
  author_email: post@benmatheja.de
  author_url: http://benmatheja.de
  date: '2014-04-04 11:06:09 +0200'
  date_gmt: '2014-04-04 09:06:09 +0200'
  content: "Hallo Marcus,\n\nich hatte das Setup bereits in Betrieb und Drucken ging
    problemlos, wenn man in CUPS den richtigen Treiber ausw&auml;hlt. \n\nIch hatte
    den Brother Treiber installiert und die Pakete von CUPS &uuml;ber den Paketmanager
    reingezogen. Nun ist mir leider mein System gecrasht und ich habe CUPS noch nicht
    in Betrieb - werde mich aber heute dransetzen und das ganze bloggen.\n\nLG"
- id: 36
  author: Ben
  author_email: post@benmatheja.de
  author_url: http://www.benmatheja.de
  date: '2014-04-08 00:57:00 +0200'
  date_gmt: '2014-04-07 22:57:00 +0200'
  content: |-
    Hallo Marcus

    unter http:&#47;&#47;benmatheja.de&#47;2014&#47;04&#47;cups-brother-dcp-7030&#47; findest du ein tutorial wie ich den DCP zum Drucken gebracht habe.


    Viele Gr&uuml;&szlig;e
---
<p>Wie der Titel es schon vermuten l&auml;sst, ich werde den Raspberry Pi als Printserver und Streambox benutzen.</p>
<h3>Musik<&#47;h3><br />
Meine ganze Musik liegt seit circa einem Jahr komplett bei <a href="http:&#47;&#47;www.spotify.com">Spotify<&#47;a> - abgesehen von iTunes Match, welches meine MP3's zum Auflegen speichert.</p>
<p>Daher muss meine Streambox unbedingt<a href="https:&#47;&#47;www.spotify.com&#47;de&#47;"> Spotify<&#47;a> verstehen. Weiterhin bin ich ziemlicher Fan vom Social Music Service Last.FM. Idealerweise sollten gespielte Tracks direkt an die<a href="http:&#47;&#47;www.last.fm&#47;"> Last.FM<&#47;a> Plattform gesendet werden. Und im besten Fall will ich das ganze per Smartphone &uuml;ber einen Webclient steuern k&ouml;nnen.</p>
<h3>Drucken<&#47;h3><br />
Der PI sollte im besten Fall in der Lage sein meinen Brother DCP 7030 Laserdrucker&#47;Scanner ins Netzwerk zu bef&ouml;rdern, sodass ich von allen Ger&auml;ten drahtlos Druckauftr&auml;ge versenden kann.</p>
<h3>Welche Techniken werden verwendet?<&#47;h3></p>
<ul>
<li><a href="http:&#47;&#47;www.mopidy.com&#47;">Mopidy<&#47;a> als Streamingserver mit Extensions f&uuml;r Spotify &amp; Last.fm<&#47;li>
<li><a href="https:&#47;&#47;github.com&#47;martijnboland&#47;moped">Moped<&#47;a> webclient um Mopidy steuern zu k&ouml;nnen<&#47;li>
<li><a href="https:&#47;&#47;github.com&#47;abrasive&#47;shairport">Shairport<&#47;a> um den PI als AirportReceiver nutzen zu k&ouml;nnen<&#47;li>
<li><a href="https:&#47;&#47;www.cups.org&#47;">CUPS<&#47;a> als Printserver<&#47;li>
<li><a href="http:&#47;&#47;nginx.org&#47;">Nginx<&#47;a> als HTTP Proxy ( dazu sp&auml;ter mehr )<&#47;li><br />
<&#47;ul></p>
