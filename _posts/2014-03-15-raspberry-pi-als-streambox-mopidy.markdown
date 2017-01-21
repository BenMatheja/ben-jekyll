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
comments:
- id: 40
  author: faxe2110
  author_email: ptkunze@me.com
  author_url: ''
  date: '2014-04-11 13:02:00 +0200'
  date_gmt: '2014-04-11 11:02:00 +0200'
  content: "Hallo,\nleider bekomme ich noch eine Fehlermeldung. \n[quote]404 Not Found\n\nThe
    path '&#47;' was not found.\n\nTraceback (most recent call last):\n  File \"&#47;usr&#47;lib&#47;python2.7&#47;dist-packages&#47;cherrypy&#47;_cprequest.py\",
    line 656, in respond\n    response.body = self.handler()\n  File \"&#47;usr&#47;lib&#47;python2.7&#47;dist-packages&#47;cherrypy&#47;lib&#47;encoding.py\",
    line 188, in __call__\n    self.body = self.oldhandler(*args, **kwargs)\n  File
    \"&#47;usr&#47;lib&#47;python2.7&#47;dist-packages&#47;cherrypy&#47;_cperror.py\",
    line 386, in __call__\n    raise self\nNotFound: (404, u\"The path '&#47;' was
    not found.\")[&#47;quote]\n\nWie bekomme ich meine Online Radio Playlist mit geladen.
    Wo muss die m3u Datei gespeichert werden?\n\nMfG\nfaxe2110\n\n"
- id: 41
  author: Ben
  author_email: post@benmatheja.de
  author_url: http://www.benmatheja.de
  date: '2014-04-11 13:25:00 +0200'
  date_gmt: '2014-04-11 11:25:00 +0200'
  content: "Hi!\n\n\nIn deinem Fall w&uuml;rde ich gucken, ob du das Verzeichnis in
    dem der Webclient liegt &#47;opt&#47;webclient dem Nutzer Mopidy &uuml;bereignet
    hast und du das Kopieren genauso gemacht hast, wie das Tutorial es beschreibt.
    \n\n\nUm das Online Radio zu benutzen, musst du dir eine m3u-playlist herunterladen.
    Diese mit einem Texteditor &ouml;ffnen. Dort enthalten sind streamadressen. Du
    nimmst eine und f&uuml;gst sie in das Feld des Webradio's ein."
- id: 42
  author: faxe2110
  author_email: ptkunze@me.com
  author_url: ''
  date: '2014-04-11 14:51:00 +0200'
  date_gmt: '2014-04-11 12:51:00 +0200'
  content: "Hallo danke f&uuml;r die Antwort. \nJa ich bin nach der Anleitung vorgegangen.
    Habe eben nochmal versucht die nutzerrechte neu zu vergeben nur will er sie anschwindle
    nicht.\n\ndrwxr-xr-x 4 root root 4.0K Apr 11 11:08 &#47;opt&#47;webclient\npi@raspberrypi
    &#47;opt&#47;webclient $ sudo service mopidy stop\npi@raspberrypi &#47;opt&#47;webclient
    $ sudo cp ~&#47;.config&#47;mopidy&#47;mopidy.conf &#47;etc&#47;mopidy\npi@raspberrypi
    &#47;opt&#47;webclient $ sudo chown mopidy &#47;etc&#47;mopidy&#47;mopidy.conf\npi@raspberrypi
    &#47;opt&#47;webclient $ sudo service mopidy restart\n[ ok ] Restarting Mopidy
    music server: mopidy.\npi@raspberrypi &#47;opt&#47;webclient $ ls -ldh &#47;opt&#47;webclient\ndrwxr-xr-x
    4 root root 4.0K Apr 11 11:08 &#47;opt&#47;webclient\npi@raspberrypi &#47;opt&#47;webclient
    $\n\nMit den m3u im editor &ouml;ffnen ist klar und dann den link raus kopieren.
    \nIn meinem noch laufendem MPD konnte ich in dem Playlist Verzeichnis eine selbsterstellte
    m3u ablegen, in welcher alle Streams hinterlegt waren. Diese konnte ich dann in
    der Playlist im MPaD abrufen und zwischen den einzelnen Sendern zappen. Deshalb
    meine frage."
- id: 43
  author: Ben
  author_email: post@benmatheja.de
  author_url: http://www.benmatheja.de
  date: '2014-04-11 15:07:00 +0200'
  date_gmt: '2014-04-11 13:07:00 +0200'
  content: |-
    Hi

    Meine antwort bezog sich auch eher auf den Webclient.

    Wie sieht das Verzeichnis &#47;opt&#47;webclient bei dir aus?

    Ich habe unten mal meines angehangen. Ich gehe davon aus, dass dein Mopidy HTTP den webclient nicht finden kann.

    &Uuml;berpr&uuml;fe auch nochmal deine Config, ob das static_dir auf &#47;opt&#47;webclient zeigt.

    pi@airpi &#47;opt&#47;webclient $ ls -al
    total 16
    drwxr-xr-x 3 root   root 4096 Apr 11 13:03 .
    drwxr-xr-x 6 root   root 4096 Apr  9 22:25 ..
    drwxr-xr-x 5 mopidy root 4096 Mar 18 15:08 assets
    -rw-r--r-- 1 mopidy root 2719 Mar 18 15:08 index.html
    pi@airpi &#47;opt&#47;webclient $

    Zu deiner anderen Frage - M&ouml;glicherweise kannst du, wenn du Mopidy f&uuml;r lokale Dateien aktivierst deine m3u Playlist weiterhin benutzen. Ich vermute aber, dass du dann auf einzelne m3u dateien (eine pro Sender) zur&uuml;ckgreifen m&uuml;ssen wirst. Genaueres kann ich dir dazu nicht sagen, da ich das nicht ausprobiert habe.



    LG
- id: 44
  author: faxe2110
  author_email: ptkunze@me.com
  author_url: ''
  date: '2014-04-11 15:20:00 +0200'
  date_gmt: '2014-04-11 13:20:00 +0200'
  content: "Hi \nBei mir sieht es so aus.\n\npi@raspberrypi &#47;opt&#47;webclient
    $ ls -al\ntotal 16\ndrwxr-xr-x 4 root   root 4096 Apr 11 11:08 .\ndrwxr-xr-x 6
    root   root 4096 Apr 11 11:07 ..\ndrwxr-xr-x 8 root   root 4096 Apr 11 11:08 moped\ndrwxr-xr-x
    3 mopidy root 4096 Apr 11 11:08 webclient\npi@raspberrypi &#47;opt&#47;webclient
    $\n\nUnd hier nochmals Eintr&auml;ge der conf\n\n\n[scrobbler]\n#enabled = true\n#username
    =\n#password =\n\n[http]\n#enabled = true\nhostname = ::\n#port = 6680\nstatic_dir
    = &#47;opt&#47;webclient\n#zeroconf = Mopidy HTTP server on $hostname\n\n[mpd]\n#enabled
    = true\nhostname = ::\n#port = 6600\n#password =\n#max_connections = 20\n#connection_timeout
    = 60\n#zeroconf = Mopidy MPD server on $hostname\n\n[local]\nenabled = false\n\n"
- id: 45
  author: Ben
  author_email: post@benmatheja.de
  author_url: http://www.benmatheja.de
  date: '2014-04-11 15:43:00 +0200'
  date_gmt: '2014-04-11 13:43:00 +0200'
  content: |-
    Okay. Du musst noch den webclient and die adresse schieben an der deine Konfig ihn erwartet. Das Git-Repo Moped enth&auml;lt zwei verschiedene webclients einmal auf Basis von angular und der andere auf Basis von durandal. Finden sich beide in moped&#47;dist.


    Um den Client auf Angular basis zu installieren benutze die folgenden Kommandos

    cd &#47;opt&#47;webclient
    sudo mv moped&#47;dist&#47;angular&#47;* .



    Gut, dass du darauf aufmerksam gemacht hast - die Stelle ist im tutorial fehlerhaft!
- id: 46
  author: faxe2110
  author_email: ptkunze@me.com
  author_url: ''
  date: '2014-04-11 16:04:00 +0200'
  date_gmt: '2014-04-11 14:04:00 +0200'
  content: "Jetzt hat es geklappt. \nDanke f&uuml;r die Hilfe.\nDu hast nicht zuf&auml;llig
    noch ein HowTo um eine XY Fernbedienung mit einem TSOP4843 in mopidy einzubinden
    ;)\n\nDanke nochmals \nfaxe2110"
- id: 47
  author: Ben
  author_email: post@benmatheja.de
  author_url: http://www.benmatheja.de
  date: '2014-04-11 16:07:00 +0200'
  date_gmt: '2014-04-11 14:07:00 +0200'
  content: |-
    Sehr gut, das freut mich!


    Nein leider nicht - mit Fernbedienung hab ich mich noch gar nicht befasst .. nutze daf&uuml;r den webclient per smartphone.


    LG
- id: 48
  author: faxe2110
  author_email: ptkunze@me.com
  author_url: ''
  date: '2014-04-11 16:11:00 +0200'
  date_gmt: '2014-04-11 14:11:00 +0200'
  content: |-
    Ahh super Danke f&uuml;r die R&uuml;ckmeldung.
    Eine kleine Frage habe ich noch, da das selbe Problem hier auch auftritt wie bei Pi musicbox.
    Ich versuche verzweifelt diesen Stream zum laufen zu bekommen.
    http:&#47;&#47;stream-ice.mtgradio.com:8080&#47;stat_rix_fm
    Mein MPD Server spielt ihn ohne Probleme ab.
    Hier und auch beim Pi Musicbox Project habe ich probleme. Vieleicht kannst du da weiterhelfen??
    So wie ich es sehe sollte es ein AAC sein und kein mp3.
    Muss da noch ein Codec dazu??

    Mfg
    faxe2110
- id: 49
  author: Ben
  author_email: post@benmatheja.de
  author_url: http://www.benmatheja.de
  date: '2014-04-11 16:16:00 +0200'
  date_gmt: '2014-04-11 14:16:00 +0200'
  content: |-
    M&ouml;glicherweise fehlt da ein AAC-Codec, wie du bereits vermutet hast ... genaueres kann ich dir leider nicht sagen.

    Guck dir mal folgendem Link an, dort hatte jemand ein &auml;hnliches Problem mit lokalen mp4-Dateien.

    https:&#47;&#47;github.com&#47;mopidy&#47;mopidy&#47;issues&#47;455
- id: 50
  author: faxe2110
  author_email: ptkunze@me.com
  author_url: ''
  date: '2014-04-11 16:31:00 +0200'
  date_gmt: '2014-04-11 14:31:00 +0200'
  content: |-
    Hmmm hat leider zu keinem Erfolg gef&uuml;hrt.

    pi@raspberrypi ~ $ gst-inspect-0.10 | grep aac
    ffmpeg:  ffenc_aac: FFmpeg Advanced Audio Coding encoder
    ffmpeg:  ffdec_aac: FFmpeg Advanced Audio Coding decoder
    ffmpeg:  ffdec_aac_latm: FFmpeg AAC LATM (Advanced Audio Codec LATM syntax) decoder
    ffmpeg:  ffmux_adts: FFmpeg ADTS AAC muxer (not recommended, use aacparse instead)
    audioparsers:  aacparse: AAC audio stream parser
    typefindfunctions: audio&#47;aac: aac, adts, adif, loas
    pi@raspberrypi ~ $

    Vieleicht k&ouml;nntest du es ja mal versuchen wenn es deine Zeit zul&auml;sst.
    W&uuml;rde mich freuen.

    Mfg
    faxe2110
- id: 53
  author: KAlukki
  author_email: lukas.klee@online.de
  author_url: ''
  date: '2014-09-27 15:15:00 +0200'
  date_gmt: '2014-09-27 13:15:00 +0200'
  content: wenn ich ~&#47;.config&#47;mopidy eingebe findet er das verzeichniss nicht
    ... was ist mein fehler?
- id: 54
  author: Ben
  author_email: post@benmatheja.de
  author_url: http://www.benmatheja.de/
  date: '2014-09-27 16:33:00 +0200'
  date_gmt: '2014-09-27 14:33:00 +0200'
  content: |-
    damit der ordner erstellt wird, musst du mopidy von der konsole erstmalig ausf&uuml;hren.
    ein simples "mopidy" als eingeloggter user sollte reichen
- id: 55
  author: KAlukki
  author_email: lukas.klee@online.de
  author_url: ''
  date: '2014-09-27 17:08:00 +0200'
  date_gmt: '2014-09-27 15:08:00 +0200'
  content: |-
    oke und wie funktioneiert das ?
    sry das ich so fragen stelle habe aber absolut keinen plan ;&#47;
- id: 56
  author: Ben
  author_email: post@benmatheja.de
  author_url: http://www.benmatheja.de/
  date: '2014-09-27 19:59:00 +0200'
  date_gmt: '2014-09-27 17:59:00 +0200'
  content: |-
    pass die Konfig von Mopidy in dem Verzeichnis so an, wie oben beschrieben - dann kopierst du diese, wie oben beschrieben.
    Bist auf dem richtigen weg, keine Sorge :)
- id: 57
  author: Markus
  author_email: humanchaos77@gmail.com
  author_url: ''
  date: '2014-10-25 00:07:00 +0200'
  date_gmt: '2014-10-24 22:07:00 +0200'
  content: "hi ben - \n\nwenn ich das hier mache\n\nsudo git clone https:&#47;&#47;github.com&#47;martijnboland&#47;moped.git\n\nsudo
    mv moped&#47;dist&#47;angular&#47;* .\n\nbekomme ich diese Fehlermeldung\n\npi@raspberrypi
    &#47;opt&#47;webclient $ sudo mv moped&#47;dist&#47;angular&#47;* .\n\nmv: Aufruf
    von stat f&uuml;r &bdquo;moped&#47;dist&#47;angular&#47;*&ldquo; nicht m&ouml;glich:
    Datei oder Verzeichnis nicht gefunden\n\npi@raspberrypi &#47;opt&#47;webclient
    $ \n\nin der dist finde ich nur assets und index\n\nlgmarkus"
- id: 58
  author: Ben
  author_email: post@benmatheja.de
  author_url: http://www.benmatheja.de/
  date: '2014-10-25 00:50:00 +0200'
  date_gmt: '2014-10-24 22:50:00 +0200'
  content: |-
    Hi Markus,


    die Entwickler von Moped haben sich anscheinend f&uuml;r die angular version final entschieden.
    Du musst nun lediglich den inhalt von &#47;dist in &#47;opt&#47;webclient kopieren.

    edit: ich habs im tutorial angepasst, danke dir f&uuml;r den hinweis! :)


    LG
- id: 61
  author: Fabi
  author_email: refa@online.de
  author_url: ''
  date: '2015-01-08 21:43:00 +0100'
  date_gmt: '2015-01-08 20:43:00 +0100'
  content: |-
    Hi Ben,

    ich bekomme beim Testen diesen Fehler:

    ERROR    Frontend (MpdFrontend) initialization error: MPD server startup failed: [Errno 98] Die Adresse wird bereits verwendet



    ich hab die Config Datei wie du ausgef&uuml;llt und eingestellt.
    ich habe auch noch nicht die config r&uuml;berkopiert o&auml;.


    gr&uuml;&szlig;e Fabi
- id: 62
  author: Ben
  author_email: post@benmatheja.de
  author_url: http://www.benmatheja.de/
  date: '2015-01-09 11:24:00 +0100'
  date_gmt: '2015-01-09 10:24:00 +0100'
  content: "Hi Fabi,\n\n\nh&ouml;rt sich f&uuml;r mich ganz danach an, als w&uuml;rde
    bereits eine Mopidy Instanz oder eine andere Anwendung auf dem Port den du eingestellt
    hast laufen. \nWelchen Port hast du verwendet? Falls 6680 Kannst du per \n<code>\nsudo
    service mopidy status\n<&#47;code>\npr&uuml;fen ob mopidy bereits als service
    l&auml;uft?\n\nLG"
---
<p>Um den Pi in eine (standalone) Streambox zu verwandeln gibt es mindestens drei M&ouml;glichkeiten.</p>
<p><img class="alignnone" src="http:&#47;&#47;www.woutervanwijk.nl&#47;pimusicbox&#47;images&#47;logo-small.png" alt="" width="340" height="213" &#47;></p>
<p><a href="http:&#47;&#47;www.woutervanwijk.nl&#47;pimusicbox&#47;">Musicbox -&nbsp;Audio Player for Spotify and Google Music<&#47;a></p>
<p>Die eine ist das fertig konfigurierte Image von Wouter van Wijk zu benutzen. Alle ben&ouml;tigten Features sind vorinstalliert, lediglich die Nutzerdaten m&uuml;ssen in einer .txt Datei hinterlegt<br />
werden und die Sache l&auml;uft sofort. (sehr bequem)</p>
<p><img class="alignnone" style="line-height: 1.714285714; font-size: 1rem;" src="http:&#47;&#47;volumio.org&#47;wp-content&#47;uploads&#47;2013&#47;11&#47;logo1.png" alt="" width="380" height="50" &#47;></p>
<p><a href="http:&#47;&#47;volumio.org&#47;">Volumio - A revoluationary Audiophile Music Player<&#47;a></p>
<p>Die andere ist Volumio einzusetzen - eine Distribution die auf hochwertige Audio-ausgabe optimiert wurde. Bietet jedoch keine Spotify-Integration und war daher f&uuml;r mich uninteressant.</p>
<p><span style="line-height: 1.714285714; font-size: 1rem;">Die dritte M&ouml;glichkeit? Wir konfigurieren selbst, nach unseren Bed&uuml;rfnissen.<&#47;span></p>
<p><a id="more"></a><a id="more-313"></a><br />
Im Folgenden werden wir <a href="http:&#47;&#47;www.mopidy.com">Mopidy<&#47;a> einsetzen. Mopidy ist ein Standalone Musik-Server, der Euch hilft eure lokale Musiksammlung per MPD oder Webinterface abzuspielen. Das Tolle an Mopidy ist, dass es Erweiterung f&uuml;r bspw. Spotify oder Google Music gibt. Das hei&szlig;t ihr k&ouml;nnt ihn, wie hier beschrieben als standalone Spotify-Client benutzen, sobald ihr einen Spotify Premium Account besitzt.</p>
<h3>Installation von Mopidy<&#47;h3><br />
Um Mopidy zu installieren k&ouml;nnen wir dank Debian Wheezy auf das Software-Repository APT zur&uuml;ckgreifen.</p>
<p>Wir f&uuml;gen den GPG-Schl&uuml;ssel des Archivs hinzu um zu die Quelle als vertrauensw&uuml;rdig zu markieren und hinterlagen sie in unser globalen Liste.<br />
Von nun an wird bei jedem apt-get update auch nach neuen Versionen von Mopidy und seinen Extensions gepr&uuml;ft.</p>
<p>[bash]<br />
wget -q -O - http:&#47;&#47;apt.mopidy.com&#47;mopidy.gpg | sudo apt-key add -<br />
sudo wget -q -O &#47;etc&#47;apt&#47;sources.list.d&#47;mopidy.list http:&#47;&#47;apt.mopidy.com&#47;mopidy.list<br />
[&#47;bash]</p>
<p>Um Probleme mit Mopidy zu vermeiden laden wir das IPv6 Kernel modul nach und sorgen daf&uuml;r, dass es direkt bei Startup geladen wird</p>
<p>[bash]<br />
sudo modprobe ipv6<br />
echo ipv6 | sudo tee -a &#47;etc&#47;modules<br />
[&#47;bash]</p>
<p>Nun f&uuml;hren wir eine Aktualisierung der Quellen durch und installieren Mopidy und Extensions (Spotify Binding und Last.FM Scrobbler in meinem Fall) per</p>
<p>[bash]sudo apt-get update<br />
sudo apt-get install mopidy mopidy-scrobbler mopidy-spotify<br />
[&#47;bash]</p>
<h3>Konfiguration von Mopidy<&#47;h3><br />
Um schnell eine Sample Konfigurationsdatei von Mopidy zu erzeugen starten wir mopidy als Nutzer Pi.<br />
Bei Startup wird die Config in ~&#47;.config&#47;mopidy hinterlegt und wir k&ouml;nnen sie nutzen. Hierbei komfortabel ist, dass geladene Extension direkt aktiviert werden, das hei&szlig;t wir m&uuml;ssen in der Config nur die markierten Teile anpassen um die gew&uuml;nschte Funktion zu erreichen.</p>
<p>[bash]<br />
[audio]<br />
#mixer = software<br />
#mixer_track =<br />
#mixer_volume =<br />
output = alsasink<br />
#visualizer =</p>
<p>[scrobbler]<br />
#enabled = true<br />
username = name<br />
password = passwort</p>
<p>[http]<br />
#enabled = true<br />
hostname = ::<br />
#port = 6680<br />
static_dir = &#47;opt&#47;webclient<br />
#zeroconf = Mopidy HTTP server on $hostname</p>
<p>[mpd]<br />
#enabled = true<br />
hostname = ::<br />
#port = 6600<br />
#password =<br />
#max_connections = 20<br />
#connection_timeout = 60<br />
#zeroconf = Mopidy MPD server on $hostname</p>
<p>[local]<br />
enabled = false<br />
#library = json<br />
#media_dir =<br />
#data_dir = $XDG_DATA_DIR&#47;mopidy&#47;local<br />
#playlists_dir = $XDG_DATA_DIR&#47;mopidy&#47;local&#47;playlists<br />
#scan_timeout = 1000<br />
#scan_flush_threshold = 1000<br />
#excluded_file_extensions =<br />
#  .html<br />
#  .jpeg<br />
#  .jpg<br />
#  .log<br />
#  .nfo<br />
#  .png<br />
#  .txt</p>
<p>[spotify]<br />
#enabled = true<br />
username = nutzername<br />
password = passwort<br />
#bitrate = 160<br />
#timeout = 10<br />
#cache_dir = $XDG_CACHE_DIR&#47;mopidy&#47;spotify<br />
#settings_dir = $XDG_CONFIG_DIR&#47;mopidy&#47;spotify<br />
[&#47;bash]</p>
<p>Ist der Vorgang abgeschlossen unterziehen wir die Konfig einem Test indem wir mopidy ausf&uuml;hren.<br />
Davor stoppen wir den Mopidy service.</p>
<p>[bash]<br />
pi@airPi ~&#47;.config&#47;mopidy $ sudo service stop mopidy<br />
pi@airPi ~&#47;.config&#47;mopidy $ mopidy</p>
<p>INFO     Starting Mopidy 0.18.3<br />
INFO     Loading config from: builtin defaults, &#47;etc&#47;xdg&#47;mopidy&#47;mopidy.conf, &#47;home&#47;pi&#47;.config&#47;mopidy&#47;mopidy.conf, command line options<br />
INFO     Enabled extensions: spotify, mpd, http, scrobbler, stream<br />
INFO     Disabled extensions: local<br />
INFO     Starting Mopidy audio<br />
INFO     Starting Mopidy backends: StreamBackend, SpotifyBackend<br />
INFO     Audio output set to "alsasink"<br />
INFO     Audio mixer is using software mixing<br />
INFO     Mopidy uses SPOTIFY(R) CORE<br />
INFO     Starting Mopidy core<br />
INFO     Starting Mopidy frontends: ScrobblerFrontend, HttpFrontend, MpdFrontend<br />
INFO     Scrobbler connected to Last.fm<br />
INFO     MPD server running at [::]:6600<br />
INFO     Connected to Spotify<br />
INFO     HTTP server running at http:&#47;&#47;airPi:6680<br />
[&#47;bash]</p>
<p>Anschlie&szlig;end verschieben wir die Konfigurationsdatei nach &#47;etc&#47;mopidy und &uuml;bergeben das Eigentum an den Nutzer mopidy, welcher auch den Streamserver ausf&uuml;hrt.</p>
<p>[bash]<br />
sudo cp ~&#47;.config&#47;mopidy&#47;mopidy.conf &#47;etc&#47;mopidy<br />
sudo chown mopidy &#47;etc&#47;mopidy&#47;mopidy.conf<br />
[&#47;bash]</p>
<p>Um auf unsere Streambox zugreifen zu k&ouml;nnen installieren wir Moped den Webclient.&nbsp;Das Git-Repo von Moped enth&auml;lt den Webclient auf Basis von <a href="http:&#47;&#47;angularjs.org&#47;">AngularJS<&#47;a>. Findet sich in moped&#47;dist.&nbsp;Wie in der Konfiguration schon angedeutet, packen wir den Client in &#47;opt&#47;webclient.</p>
<p>[bash]<br />
sudo mkdir &#47;opt&#47;webclient<br />
cd &#47;opt&#47;webclient<br />
sudo git clone https:&#47;&#47;github.com&#47;martijnboland&#47;moped.git<br />
sudo mv moped&#47;dist&#47;* .<br />
cd ..<br />
sudo chown -R mopidy webclient<br />
sudo service mopidy restart<br />
[&#47;bash]</p>
<p>Mopidy l&auml;uft und verbindet sich mit Spotify &amp; Last.FM das ist gut.</p>
<p><a href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2014&#47;03&#47;moped-running.png"><img class="aligncenter size-medium wp-image-343" src="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2014&#47;03&#47;moped-running-250x300.png" alt="Moped served via RaspberryPI" width="250" height="300" &#47;><&#47;a> Jedoch ein paar Anpassungen verbleiben noch.<br />
Zum einen fehlt dem PI noch etwas Druck - die Musik ist doch arg leise.<br />
Das &auml;ndern wir indem wir den Pegel per <em>alsamixer<&#47;em> erh&ouml;hen.</p>
<p><a href="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2014&#47;03&#47;alsamix.gif"><img class="aligncenter size-medium wp-image-338" src="http:&#47;&#47;benmatheja.de&#47;wp-content&#47;uploads&#47;2014&#47;03&#47;alsamix.gif" alt="alsamix" width="300" height="295" &#47;><&#47;a>Mit der momentanen Konfiguration wird der Webclient unter AirPi.local:6680 bereitgestellt - es w&auml;re jedoch intuitiv den client direkt per AirPi.local zu erreichen. Da besteht noch Anpassungsbedarf - Ansonsten ist das Setup f&uuml;r Mopidy damit abgeschlossen.</p>
<p><strong>EDIT<&#47;strong>: Um den Port 6680 auf 80 zu routen <a title="Redirect Mopidy HTTP Client auf Port 80 mit Iptables" href="http:&#47;&#47;benmatheja.de&#47;2014&#47;03&#47;redirect-mopidy-http-client-port-80&#47;">siehe folgendes<&#47;a></p>
