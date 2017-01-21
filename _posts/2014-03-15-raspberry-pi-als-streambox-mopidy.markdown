---
layout: post
status: publish
published: true
title: Raspberry PI als Spotify Streambox dank Mopidy
author:
  display_name: ben
  login: ben
  email: post@benmatheja.de
  url: http://benmatheja.de
author_login: ben
author_email: post@benmatheja.de
author_url: http://benmatheja.de
excerpt: "Um den Pi in eine (standalone) Streambox zu verwandeln gibt es mindestens
  drei M&ouml;glichkeiten.\r\n\r\n<img class=\"alignnone\" src=\"http:&#47;&#47;www.woutervanwijk.nl&#47;pimusicbox&#47;images&#47;logo-small.png\"
  alt=\"\" width=\"340\" height=\"213\" &#47;>\r\n\r\n<a href=\"http:&#47;&#47;www.woutervanwijk.nl&#47;pimusicbox&#47;\">Musicbox
  -&nbsp;Audio Player for Spotify and Google Music<&#47;a>\r\n\r\nDie eine ist das
  fertig konfigurierte Image von Wouter van Wijk zu benutzen. Alle ben&ouml;tigten
  Features sind vorinstalliert, lediglich die Nutzerdaten m&uuml;ssen in einer .txt
  Datei hinterlegt\r\nwerden und die Sache l&auml;uft sofort. (sehr bequem)\r\n\r\n<img
  class=\"alignnone\" style=\"line-height: 1.714285714; font-size: 1rem;\" src=\"http:&#47;&#47;volumio.org&#47;wp-content&#47;uploads&#47;2013&#47;11&#47;logo1.png\"
  alt=\"\" width=\"380\" height=\"50\" &#47;>\r\n\r\n<a href=\"http:&#47;&#47;volumio.org&#47;\">Volumio
  - A revoluationary Audiophile Music Player<&#47;a>\r\n\r\nDie andere ist Volumio
  einzusetzen - eine Distribution die auf hochwertige Audio-ausgabe optimiert wurde.
  Bietet jedoch keine Spotify-Integration und war daher f&uuml;r mich uninteressant.\r\n\r\n<span
  style=\"line-height: 1.714285714; font-size: 1rem;\">Die dritte M&ouml;glichkeit?
  Wir konfigurieren selbst, nach unseren Bed&uuml;rfnissen.<&#47;span>\r\n\r\n"
wordpress_id: 313
wordpress_url: http://benmatheja.de/?p=313
date: '2014-03-15 13:22:58 +0100'
date_gmt: '2014-03-15 12:22:58 +0100'
categories:
- frontpage
title: Raspberry PI als Spotify Streambox dank Mopidy
description: "Um den RaspberryPi in eine Streambox zu verwandeln gibt es drei Möglichkeiten. Volumio, Musicbox oder wir konfigurieren einfach selbst. Wie werde ich hier zeigen."
date: '2014-03-15 13:22:58 +0100'
date_gmt: '2014-03-15 12:22:58 +0100'
disqus_comments: true
categories:
- raspberryPi
tags:
- Musicbox
- Streambox
- Volumio
- Mopidy
- Spotify
- Last.FM
- Moped
- libspotify
- alsa
- RaspberryPi
- angularJS
- DurandalJS
disqus_comments: true
---
[1]: http://www.woutervanwijk.nl/pimusicbox/ 'Pi MusicBox'
[2]: https://volumio.org 'Volumio'
[3]: https://www.mopidy.com/
[4]: https://spotify.com
[5]: https://music.google.com


Um den Pi in eine (standalone) Streambox zu verwandeln gibt es mindestens drei Möglichkeiten.
Die eine ist das fertig [*konfigurierte Image*][1] von Wouter van Wijk zu benutzen. 

![Musicbox Logo](/res/logo-small.png)

Alle benötigten Features sind vorinstalliert, lediglich die Nutzerdaten müssen in einer .txt Datei hinterlegt werden und die läuft sofort. (sehr bequem)

![Volumio Logo](/res/logo1.png)

Die andere ist [Volumio][2] einzusetzen.
Eine Distribution die auf hochwertige Audio-ausgabe optimiert wurde. Bietet jedoch keine Spotify-Integration und war daher für mich uninteressant.

### Selber machen!

Im Folgenden werden wir [Mopidy][3] einsetzen. [Mopidy][3] ist ein Standalone Musik-Server, der Euch hilft eure lokale Musiksammlung per MPD oder Webinterface abzuspielen. Das Tolle an [Mopidy][3]ist, dass es Erweiterung für bspw. [Spotify][4] oder [Google Music][5] gibt. Das heißt ihr könnt ihn, wie hier beschrieben als standalone Spotify-Client benutzen, sobald ihr einen Spotify Premium Account besitzt.

#### Installation von Mopidy
Um Mopidy zu installieren können wir dank Debian Wheezy auf das Software-Repository APT zurückgreifen.

Wir fügen den GPG-Schlüssel des Archivs hinzu um zu die Quelle als vertrauenswürdig zu markieren und hinterlagen sie in unser globalen Liste.
Von nun an wird bei jedem apt-get update auch nach neuen Versionen von Mopidy und seinen Extensions geprüft.

```
wget -q -O - http://apt.mopidy.com/mopidy.gpg | sudo apt-key add -
sudo wget -q -O /etc/apt/sources.list.d/mopidy.list http://apt.mopidy.com/mopidy.list
```

Um Probleme mit Mopidy zu vermeiden laden wir das IPv6 Kernel modul nach und sorgen dafür, dass es direkt bei Startup geladen wird

```
sudo modprobe ipv6
echo ipv6 | sudo tee -a /etc/modules
```

Nun führen wir eine Aktualisierung der Quellen durch und installieren Mopidy und Extensions (Spotify Binding und Last.FM Scrobbler in meinem Fall) per

```sh
sudo apt-get update
sudo apt-get install mopidy mopidy-scrobbler mopidy-spotify
```

#### Konfiguration von Mopidy
Um schnell eine Sample Konfigurationsdatei von Mopidy zu erzeugen starten wir mopidy als Nutzer Pi.
Bei Startup wird die Config in ``` ~/.config/mopidy ``` hinterlegt und wir können sie nutzen. Hierbei komfortabel ist, dass geladene Extension direkt aktiviert werden, das heißt wir müssen in der Config nur die markierten Teile anpassen um die gewünschte Funktion zu erreichen.

```
#mixer = software
#mixer_track =
#mixer_volume =
output = alsasink
#visualizer =
 
[scrobbler]
#enabled = true
username = name
password = passwort
 
[http]
#enabled = true
hostname = ::
#port = 6680
static_dir = /opt/webclient
#zeroconf = Mopidy HTTP server on $hostname
 
[mpd]
#enabled = true
hostname = ::
#port = 6600
#password =
#max_connections = 20
#connection_timeout = 60
#zeroconf = Mopidy MPD server on $hostname
 
[local]
enabled = false
#library = json
#media_dir =
#data_dir = $XDG_DATA_DIR/mopidy/local
#playlists_dir = $XDG_DATA_DIR/mopidy/local/playlists
#scan_timeout = 1000
#scan_flush_threshold = 1000
#excluded_file_extensions =
#  .html
#  .jpeg
#  .jpg
#  .log
#  .nfo
#  .png
#  .txt
 
[spotify]
#enabled = true
username = nutzername
password = passwort
#bitrate = 160
#timeout = 10
#cache_dir = $XDG_CACHE_DIR/mopidy/spotify
#settings_dir = $XDG_CONFIG_DIR/mopidy/spotify
```

Ist der Vorgang abgeschlossen unterziehen wir die Konfig einem Test indem wir mopidy ausführen.
Davor stoppen wir den Mopidy service.

```
pi@airPi ~/.config/mopidy $ sudo service stop mopidy
pi@airPi ~/.config/mopidy $ mopidy
 
INFO     Starting Mopidy 0.18.3
INFO     Loading config from: builtin defaults, /etc/xdg/mopidy/mopidy.conf, /home/pi/.config/mopidy/mopidy.conf, command line options
INFO     Enabled extensions: spotify, mpd, http, scrobbler, stream
INFO     Disabled extensions: local
INFO     Starting Mopidy audio
INFO     Starting Mopidy backends: StreamBackend, SpotifyBackend
INFO     Audio output set to "alsasink"
INFO     Audio mixer is using software mixing
INFO     Mopidy uses SPOTIFY(R) CORE
INFO     Starting Mopidy core
INFO     Starting Mopidy frontends: ScrobblerFrontend, HttpFrontend, MpdFrontend
INFO     Scrobbler connected to Last.fm
INFO     MPD server running at [::]:6600
INFO     Connected to Spotify
INFO     HTTP server running at http://airPi:6680
```

Anschließend verschieben wir die Konfigurationsdatei nach /etc/mopidy und übergeben das Eigentum an den Nutzer mopidy, welcher auch den Streamserver ausführt.

```
sudo cp ~/.config/mopidy/mopidy.conf /etc/mopidy
sudo chown mopidy /etc/mopidy/mopidy.conf
```

Um auf unsere Streambox zugreifen zu können installieren wir Moped den Webclient. Das Git-Repo von Moped enthält den Webclient auf Basis von AngularJS. Findet sich in moped/dist. Wie in der Konfiguration schon angedeutet, packen wir den Client in ```/opt/webclient``` .

```
sudo mkdir /opt/webclient
cd /opt/webclient
sudo git clone https://github.com/martijnboland/moped.git
sudo mv moped/dist/* .
cd ..
sudo chown -R mopidy webclient
sudo service mopidy restart
```
Mopidy läuft und verbindet sich mit Spotify & Last.FM das ist gut.
Jedoch ein paar Anpassungen verbleiben noch.
Zum einen fehlt dem PI noch etwas Druck – die Musik ist doch arg leise.
Das ändern wir indem wir den Pegel per alsamixer erhöhen.

![alsamixer gif](/res/alsamix.gif)

Mit der momentanen Konfiguration wird der Webclient unter AirPi.local:6680 bereitgestellt – es wäre jedoch intuitiv den client direkt per AirPi.local zu erreichen. Da besteht noch Anpassungsbedarf – Ansonsten ist das Setup für Mopidy damit abgeschlossen.
