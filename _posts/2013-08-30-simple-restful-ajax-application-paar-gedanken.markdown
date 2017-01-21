---
layout: post
status: publish
published: true
title: 'Simple Restful AJAX Application - Ein paar Gedanken - #1'
author:
  display_name: ben
  login: ben
  email: post@benmatheja.de
  url: http://benmatheja.de
author_login: ben
author_email: post@benmatheja.de
author_url: http://benmatheja.de
excerpt: "Hier ein paar Gedanken, wie man schnellstm&ouml;glich eine &nbsp;Simple
  Restful AJAX Application&nbsp;mit &nbsp;jQuery &amp; PHP umsetzt. &nbsp;Im nachfolegenden
  Teil werde ich euch zeigen, wie ihr den Webservice konfiguriert um eure Daten per
  JS zu visualisieren.\r\n\r\nBasis der Architektur ist das Framework <a href=\"http:&#47;&#47;peej.github.io&#47;tonic&#47;\">Tonic
  : The Restful Web App Micro-PHP Framework<&#47;a>. Es zeichnet sich durch effizienz
  und sehr einfache Konfiguration der Ressourcen durch Annotation aus.\r\n\r\n"
wordpress_id: 107
wordpress_url: http://benmatheja.de/?p=107
date: '2013-08-30 11:02:17 +0200'
date_gmt: '2013-08-30 09:02:17 +0200'
categories:
- dev
tags:
- restful
- php
- javascript
- tutorial
disqus_comments: true
---
<p>Hier ein paar Gedanken, wie man schnellstm&ouml;glich eine &nbsp;Simple Restful AJAX Application&nbsp;mit &nbsp;jQuery &amp; PHP umsetzt. &nbsp;Im nachfolegenden Teil werde ich euch zeigen, wie ihr den Webservice konfiguriert um eure Daten per JS zu visualisieren.</p>
<p>Basis der Architektur ist das Framework <a href="http:&#47;&#47;peej.github.io&#47;tonic&#47;">Tonic : The Restful Web App Micro-PHP Framework<&#47;a>. Es zeichnet sich durch effizienz und sehr einfache Konfiguration der Ressourcen durch Annotation aus.</p>
<p><a id="more"></a><a id="more-107"></a></p>
<h2>Installation<&#47;h2><br />
Installation &nbsp;&uuml;ber den Dependency-Manager<a href="http:&#47;&#47;getcomposer.org&#47;">&nbsp;Composer<&#47;a> mit der angegebenen Dependency oder durch Download und entpacken &uuml;ber die Tonic Site.</p>
<p>[javascript]<br />
{<br />
"require": {<br />
"peej&#47;tonic": "dev-master"<br />
}<br />
}<br />
[&#47;javascript]</p>
<p>Die Struktur von Tonic ist ziemlich straightforward. Ich habe das Hauptverzeichnis von Tonic in Rest umbenannt. Da Tonic nativ keine Datenbankkomponente<br />
mitliefert, habe ich den ordner components erstellt in dem sich der Datenbank-Konnektor befindet.&nbsp;Ansonsten liegen unter Services die einzelnen Resourcen die &uuml;ber Tonic bereitgestellt werden. Hier ein Beispielservice, der Kunden bei gegebenem Nachnamen retourniert (getCustomer.php). Unter vendor sind die Kerndateien von Tonic abgelegt. Die Composer.json wurde oben bereits angesprochen. Der Dispatcher (dispatch.php) handhabt die Zugriffe auf das Framework. Das Konzept wird nachher auch in Verbindung mit der .htaccess-Datei erl&auml;utert.</p>
<p>[code]<br />
rest<br />
| -- components<br />
| -- services<br />
     | -- 1.0<br />
          | -- json<br />
               | -- getCustomer.php<br />
     | -- info<br />
| -- vendor<br />
| -- composer.json<br />
| -- dispatch.php<br />
| -- .htaccess<br />
[&#47;code]</p>
<h2>Konfiguration<&#47;h2><br />
Damit diese Resourcen auch durch Tonic bereitgestellt werden k&ouml;nnen, m&uuml;ssen sie in der <strong>dispatch.php <&#47;strong>aktiviert werden.</p>
<p>[php]<br />
$config = array(<br />
    'load' => array(<br />
        	DIR_SERV.'1.0&#47;json&#47;*.php',       &#47;&#47;load services for 1.0<br />
    		DIR_SERV.'info&#47;*.php'		&#47;&#47;load services for info<br />
    ),<br />
);<br />
[&#47;php]</p>
<p>Ich habe hier &uuml;ber eine Config die Globale Variable DIR_SERV auf das &#47;services verzeichnis setzen lassen um PHP automatisch absolute Pfade verwenden zu lassen. Dies minimiert die Probleme, die entstehen wenn Dateien durch relative Pfade nicht erreichbar sind.</p>
<h2>Die Resource<&#47;h2><br />
Eine Resource sieht beispielsweise in Tonic wie folgt aus:<br />
<strong>http:&#47;&#47;meinserver.de&#47;rest&#47;1.0&#47;json&#47;kunde&#47;:nachname&#47;<&#47;strong></p>
<p>Sie wird &uuml;ber <strong>@uri<&#47;strong> annotiert. Damit wei&szlig; Tonic, dass die Adresse folgt, auf die der Service reagieren soll.&nbsp;Vor der Funktion wird der HTTP-Header spezifiziert, mit <strong>@method<&#47;strong> welches HTTP-Verb der Webservices erwartet.&nbsp;Wir wollen Daten bereitstellen, daher ist GET die richtige Wahl. Ebenfalls denkbar f&uuml;r Upload durch den Webservice sind bspw. POST oder PUT. Hier der Aufbau unser <strong>GetCustomer.php <&#47;strong>. Sie liegt unter <em>rest&#47;services&#47;1.0&#47;json&#47;<&#47;em></p>
<p>[php]<br />
&#47;&#47;GetCustomer.php</p>
<p>use Tonic\Resource, Tonic\Response;<br />
require_once DIR_COMP . 'Database.php';</p>
<p>&#47;**<br />
* @uri &#47;1.0&#47;json&#47;kunde&#47;:nachname&#47;<br />
*&#47;<br />
class GetCustomer extends Resource {<br />
&#47;**<br />
*<br />
* @method GET<br />
* @return str<br />
*&#47;<br />
public function get($surname) {<br />
$link = Database::Get ();<br />
&#47;&#47;transform Inputs<br />
$surname = $this->transformInput($surname);<br />
                &#47;&#47;build query<br />
		$where = 'WHERE surname = "'.$surname.'"';<br />
		$select = 'SELECT * FROM customer ';<br />
		$qry = $select.$where;</p>
<p>		&#47;&#47;return the Response<br />
		mysql_query('SET CHARACTER SET utf8');<br />
		$response = mysql_query ( $qry, $link );<br />
		$all_rows = array ();<br />
		while ( $row = mysql_fetch_assoc ( $response ) ) {<br />
			$all_rows [] = $row;<br />
		}<br />
                &#47;&#47;encode Array as JSON<br />
		return json_encode ( $all_rows );<br />
	}</p>
<p>	private function transformInput($input) {<br />
		$input = urldecode ( $input );<br />
		return mysql_real_escape_string ( $input );<br />
	}<br />
}</p>
<p>[&#47;php]</p>
<p><span style="line-height: 1.5;">Wichtig ist, die erhaltenen Daten f&uuml;r den Nachnamen zu dekodieren und zu escapen um schadhaften Code von der Datenbank fernzuhalten. Dies geschieht in <em>transformInput()<&#47;em>.&nbsp;<&#47;span>Hier ist <strong>wirklich<&#47;strong> vorsicht geboten, da jeder String der zwischen den Slash's die f&uuml;r den Nachnamen reservert wurden, sonst direkt an die unterliegende Datenbank gesendet w&uuml;rde.</p>
<p>Nach erfolgter Query wird das Ergebnis-Array durch json_encode() in JSON &uuml;berf&uuml;hrt. Da ich die Daten nachher in jQuery weiterverwenden m&ouml;chte, enkodiere ich die Antwort der Datenbank als JSON ( JavaScript Object Notation ). Der Encode produziert eine lange Zeichenkette mit Annotation, die von JS interpretiert werden k&ouml;nnen. Diese Zeichenkette sieht beispielsweise ( in einem anderen Kontext ) so aus. Hier sieht man dass es zwei Attribute pro Eintrag zur&uuml;ckgegeben werden. Der ListName und die Description der Liste. Dies kann sehr einfach in JS weiterverwendet werden.</p>
<p>[javascript]<br />
[{"ListName":"Metro","Description":"Metro ADM"},{"ListName":"NL-IP-OTP","Description":"NL_NETWORK"},{"ListName":"NL_NETWORK","Description":"NL_NETWORK"},{"ListName":"noname","Description":"hosts not classified"},{"ListName":"SuperMux","Description":"SuperMux"}]<br />
[&#47;javascript]</p>
<h2>Routing<&#47;h2><br />
Ein paar Worte zur Funktionsweise. Die Webserver erh&auml;lt einen request (GET) &nbsp;auf www.meinhost.de&#47;rest&#47;kunde&#47;mustermann&#47;. Normalerweise w&uuml;rde er die Schr&auml;gstriche als Trennzeichen f&uuml;r Verzeichnisse ansehen, also im Ordner<em> rest<&#47;em>, den Ordner k<em>unde,<&#47;em> den Ordner <em>Mustermann<&#47;em> &ouml;ffnen. Jedoch existiert diese Ordnerstruktur &uuml;berhaupt nicht.</p>
<p>Um den Service trotzdem unter dem Punkt anzubieten muss die Anfrage geroutet werden. Das hei&szlig;t die enthaltenen Informationen m&uuml;ssen an die richtigen Empf&auml;nger weitergereicht werden.<br />
Tonic legt dazu im Hauptverzeichnis eine .htaccess Datei an. Diese wird vom Webserver (Apache bspw.) ausgewertet. Um Seitenzugriffe umzuleiten (was wir in diesem Fall ben&ouml;tigen) wird auf das Apache Modul mod_rewrite zur&uuml;ckgegriffen.</p>
<p>[php]</p>
<p>    RewriteEngine On<br />
    RewriteCond %{REQUEST_URI} !dispatch\.php$<br />
    RewriteCond %{REQUEST_FILENAME} !-f<br />
    RewriteRule .* dispatch.php [L,QSA]</p>
<p>[&#47;php]</p>
<p>Die Datei enth&auml;lt Anweisungen, sogenannte Direktiven (directives) f&uuml;r das Modul. In Pseudocode steht in der oberen Datei:</p>
<p><em><span style="line-height: 1.5;">Wenn das Modul mod_rewrite im Apache aktiviert ist, schalte die RewriteEngine an. Kommt eine Anfrage auf ein Verzeichnis leite die Anfrage&nbsp;<&#47;span><span style="line-height: 1.5;">an die dispatch.php weiter. Wird jedoch direkt eine Datei angefordert, liefere die Datei aus.&nbsp;<&#47;span><&#47;em></p>
<p>Der Dispatcher(dispatch.php) erh&auml;lt die Anfrage, bricht die relevanten Teile heraus (&#47;kunde&#47;mustermann&#47;) und sucht ob er eine passende Resource ausliefern kann</p>
<p>In Teil 2 zeige ich wie , man die Daten in einem UI per jQuery asynchron anfordert und sie durch HTML-Elemente visualisiert.</p>
