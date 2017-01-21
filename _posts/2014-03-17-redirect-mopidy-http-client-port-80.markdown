---
layout: post
status: publish
published: true
title: Redirect Mopidy HTTP Client auf Port 80 mit Iptables
author:
  display_name: ben
  login: ben
  email: post@benmatheja.de
  url: http://benmatheja.de
author_login: ben
author_email: post@benmatheja.de
author_url: http://benmatheja.de
excerpt: "Nachdem wir letztens Mopidy installiert haben war noch diese kleine Unsauberkeit,
  dass das Webinterface von Mopidy nur per Port 6680 erreichbar war. Mopidy selbst
  lässt sich aber (warum auch immer) nicht auf Port 80 direkt legen.\r\nIn einer
  früheren Installation habe ich für die Weiterleitung NGinx als Proxy eingesetzt,
  jedoch gab es Komplikationen mit den Websockets des Webclients.\r\nDer einfachere
  Weg ist per iptables eine Regel einzurichten, die den Port 80 auf den Port 6680
  legt.\r\n\r\n```bash\r\nsudo iptables -A PREROUTING -t nat -i wlan0 -p tcp --dport
  80 -j REDIRECT --to-port 6680\r\n[&#47;bash]\r\n\r\n"
wordpress_id: 398
wordpress_url: http://benmatheja.de/?p=398
date: '2014-03-17 12:55:52 +0100'
date_gmt: '2014-03-17 11:55:52 +0100'
categories:
- frontpage
- raspberryPi
tags:
- Mopidy
- RaspberryPi
- iptables
- Redirect
disqus_comments: true
---
Nachdem wir letztens Mopidy installiert haben war noch diese kleine Unsauberkeit, dass das Webinterface von Mopidy nur per Port 6680 erreichbar war. Mopidy selbst lässt sich aber (warum auch immer) nicht auf Port 80 direkt legen.
In einer früheren Installation habe ich für die Weiterleitung NGinx als Proxy eingesetzt, jedoch gab es Komplikationen mit den Websockets des Webclients.
Der einfachere Weg ist per iptables eine Regel einzurichten, die den Port 80 auf den Port 6680 legt.

```bash
sudo iptables -A PREROUTING -t nat -i wlan0 -p tcp --dport 80 -j REDIRECT --to-port 6680
```

Das kleine Problem an iptables ist: angelegte Regeln werden nicht automatisch gespeichert, das heißt wir müssen dafür sorgen, dass unsere neue Regel nicht direkt beim nächsten reboot verschwindet.

```bash
sudo iptables-save > iptables-rules
sudo vi /etc/rc.local
```

Wir laden die rc.local und fügen die folgende Zeile hinzu.

```bash
  #!/bin/sh -e
  #
  # rc.local
  #
  # This script is executed at the end of each multiuser runlevel.
  # Make sure that the script will "exit 0" on success or any other
  # value on error.
  #
  # In order to enable or disable this script just change the execution
  # bits.
  #
  # By default this script does nothing.
  # Diese Zeile hinzufügen - Restore Iptables Rules
  /sbin/iptables-restore < /home/pi/iptables-rules
  # Bring up the wlan0 on startup
  ifup wlan0
  # Print the IP address
  _IP=$(hostname -I) || true
  if [ "$_IP" ]; then
    printf "My IP address is %s\n" "$_IP"
  fi
  exit 0
```
Anschließend springen wir per VI in die interfaces.

```bash
sudo vi /etc/network/interfaces
```

und fügen die Zeile "post-up iptables-restore" hinzu

```bash
auto lo
iface lo inet loopback
iface eth0 inet dhcp
auto wlan0
allow-hotplug wlan0
iface wlan0 inet dhcp
        wpa-ssid ""
        wpa-psk ""
post-up iptables-restore
iface default inet dhcp
```

Das wars! :)
