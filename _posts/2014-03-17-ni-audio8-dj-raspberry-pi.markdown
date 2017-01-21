---
layout: post
status: publish
published: true
title: NI Audio8 DJ & Raspberry PI
author:
  display_name: ben
  login: ben
  email: post@benmatheja.de
  url: http://benmatheja.de
author_login: ben
author_email: post@benmatheja.de
author_url: http://benmatheja.de
wordpress_id: 388
wordpress_url: http://benmatheja.de/?p=388
date: '2014-03-17 11:57:50 +0100'
date_gmt: '2014-03-17 10:57:50 +0100'
categories:
- frontpage
- raspberryPi
tags:
- Mopidy
- Spotify
- alsa
- RaspberryPi
- Audio8
- Native Instruments
- Sound
comments: []
---
<p style="text-align: left;">Heute ein kleines yolo Projekt. Sinn ist irgendwie fragw&uuml;rdig - aber Sound ist verdammt gut.&nbsp;Habe eben die Native Instruments Audio 8 an den Pi angeschlossen. Selten so guten Sound gehabt. Direkt Spotify auf 320Kbits eingestellt.<&#47;p></p>
<p style="text-align: left;"><a href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2014&#47;03&#47;IMG_20140317_114617.jpg"><img class="aligncenter size-large wp-image-390" src="https:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2014&#47;03&#47;IMG_20140317_114617-1024x768.jpg" alt="Raspberry Pi &amp; NI Audio8 DJ" width="625" height="468" &#47;><&#47;a><&#47;p><br />
Der kleine hat ziemlich mit der Karte zu&nbsp;k&auml;mpfen wird aber anstandslos direkt bei Startup erkannt. Nach restart als Standardkarte ausgew&auml;hlt und sorgt nun f&uuml;r ordentlich Druck dank Alsa. CPU-Auslastung von Mopidy bei 320kbit &amp; Audio8 ca 80-90% dauerhaft - da besteht noch Optimierungsbedarf. Derzeit Overclocking auf Medium also 900MHz Core. Vielleicht geht da noch was.</p>
<p><em>dmesg output<&#47;em></p>
<p>[bash]<br />
[  370.568944] usb 1-1.3: new high-speed USB device number 6 using dwc_otg<br />
[  370.670481] usb 1-1.3: New USB device found, idVendor=17cc, idProduct=1978<br />
[  370.670512] usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=5<br />
[  370.670525] usb 1-1.3: Product: Audio 8 DJ<br />
[  370.670539] usb 1-1.3: Manufacturer: Native Instruments<br />
[  370.670551] usb 1-1.3: SerialNumber: SN-FS8DYX9A5G<br />
[&#47;bash]</p>
