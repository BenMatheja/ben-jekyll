---
layout: post
status: publish
published: true
title: CPU Temperatur des Raspberry PI ausgeben
author:
  display_name: ben
  login: ben
  email: post@benmatheja.de
  url: http://benmatheja.de
author_login: ben
author_email: post@benmatheja.de
author_url: http://benmatheja.de
wordpress_id: 368
wordpress_url: http://benmatheja.de/?p=368
date: '2014-03-16 15:03:51 +0100'
date_gmt: '2014-03-16 14:03:51 +0100'
categories:
- frontpage
- raspberryPi
tags:
- RaspberryPi
- CPU
- GPU
- Monitoring
- bash
comments: []
---
<p>Um die GPU&#47;CPU temperatur des Raspberry PI auszulesen ist mir ein recht interessantes Skript untergekommen.<br />
Gesehen <a href="http:&#47;&#47;raspberrypi.stackexchange.com&#47;questions&#47;9105&#47;raspberry-pi-onboard-temp-sensors-in-raspbianwheezy">hier<&#47;a>.</p>
<p>[bash]<br />
#!&#47;bin&#47;bash<br />
cpuTemp0=$(cat &#47;sys&#47;class&#47;thermal&#47;thermal_zone0&#47;temp)<br />
cpuTemp1=$(($cpuTemp0&#47;1000))<br />
cpuTemp2=$(($cpuTemp0&#47;100))<br />
cpuTempM=$(($cpuTemp2 % $cpuTemp1))</p>
<p>echo CPU temp"="$cpuTemp1"."$cpuTempM"'C"<br />
echo GPU $(&#47;opt&#47;vc&#47;bin&#47;vcgencmd measure_temp)<br />
[&#47;bash]</p>
<p>Das Skript in den Texteditor eurer Wahl gepackt (VI nat&uuml;rlich). Als .sh Datei abspeichern. Per <em>chmod +x<&#47;em> ausf&uuml;hrbar machen und gib ihm.<br />
[bash]<br />
CPU temp=53.5'C<br />
GPU temp=53.0'C<br />
[&#47;bash]</p>
