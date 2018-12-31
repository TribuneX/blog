---
title: "Fokus auf Datensparsamkeit"
date: 2018-10-06T14:00:00+02:00
draft: false
---

Ein Gutes hat die [Datenschutzgrundverordnung](https://dsgvo-gesetz.de) dann vielleicht doch: Als Besitzer einer Webseite macht man sich nun "gezwungenermaßen" mehr Gedanken zum Thema Datensparsamkeit und Datenschutz. 

Dieser Blog wird mit [Hugo](https://gohugo.io) erstellt. Hugo generiert alle Seiten als statische HTML Seiten. Eigentlich erwarte ich bereits mit der Default Konfiguration eine auf Datensparsamkeit optimierte Webseite. 

## Privacy Check
Bevor ich mit Anpassungen beginnen kann, muss ich mir ein Bild der aktuellen Lage machen. Hierfür nutze ich [webbkoll](https://webbkoll.dataskydd.net/en/results?url=http%3A%2F%2Fsascha-bleidner.de%2F
). Webbkoll wertet verschiedene Konfigurationen des Blogs aus und zeigt Empfehlungen für eine datensparsamere Konfiguration von TLS, Cookies und externen Abhängigkeiten.

## TLS 
Als erster Punkt auf der Checkliste von webbkoll wird die Unterstützung von `https` überprüft. Der Blog leitet Besucher automatisch auf Port 443 weiter und ist mit einem Zertifikat von [Let`s Encrypt](https://letsencrypt.org) ausgestattet. Die Verlängerung des Zertifikats übernimmt mein [Hoster](https://all-inkl.com) automatisch inkl. der Unterstützung für [HSTS](https://de.wikipedia.org/wiki/HTTP_Strict_Transport_Security).

## Cookies & Tracking
Kein Login, kein Tracking, keine Social Media Plugins. Hugo erstellt bereits ab Werk eine Seite, die komplett ohne Cookies auskommt. Auch habe ich mich gegen ein Tracking der Besucher entschieden, sodass weder der Webserver, noch ein externes Tracking Tool zum Einsatz kommt. Mein [Hoster](https://all-inkl.com) erlaubt seit der Einführung der DSGVO das Deaktivieren des Loggings der Besucher. Dies ist im KAS unter Settings, Logs & Statistics möglich.

{{< figure src="/img/all_inkl_logs.png" >}}

## Externe Abhängigkeiten (Third-party requests)
An diesem Punkt gibt es zum ersten Mal wirklich etwas zu tun. Für diesen Blog nutze ich das Theme [cocoa](https://github.com/nishanths/cocoa-hugo-theme). Dieses nutzt ab Werk Google Fonts und bietet Syntax-Highlighting über [highlight.js](https://highlightjs.org) an. Beides führt dazu, dass beim Aufruf des Blogs einmal die Google Fonts von Google Servern abgerufen werden und zum zweiten die Highlight.js Datei abgerufen wird. Webbkoll emphiehlt bei solchen externen Abhängkeiten die abgerufenen Dateien stattdessen selbt zu hosten. 

Für diese Anpassungen muss ich das Theme anpassen, daher habe ich einen entsprechenden [Fork](https://github.com/TribuneX/cocoa-hugo-theme) erstellt. 

### Google Fonts
Statt die Google Fonts von Google Servern zu beziehen, kann man mit wenigen Anpassungen die benötigten Schriftarten auch auf dem eigenen Server bereitstellen.

Hierzu verwende ich den [google-webfonts-helper](https://google-webfonts-helper.herokuapp.com/fonts), der sowohl die Schriftarten, als auch den benötigten CSS Code bereitstellt. 

Den CSS Code habe ich in ein eigenen [fonts.css](https://github.com/TribuneX/blog/blob/master/static/css/fonts.css) Datei abgelegt, die unter `hugo-root/static/css/` liegt. Damit diese CSS Datei eingebunden wird, habe ich das Theme ensprechend [ergänzt](https://github.com/TribuneX/cocoa-hugo-theme/blob/master/layouts/partials/footer.html). 

Die Schriftarten sind im Ordner `hugo-root/static/fonts/` gespeichert. Damit diese Schriften nun verwendet werden und nicht mehr die CSS Datei bei Google angefordert wird, muss folgende Zeile aus dem Theme entfernt werden:

```html
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,700|Ubuntu+Mono:400,400i,700,700i|Raleway:500">
```

Statt von Google Servern werden die Schriftarten nun direkt vom Webserver genutzt. 

### Javascript Abhängigkeiten
Das Theme nutzt highlight.js für das Syntax-Highlighting. Die dafür benötigte Javascript Datei wird ebenfalls von einem externen CDN bezogen. Um dies zu verhindern habe ich die benötigte Datei ebenfalls direkt auf dem Webserver gespeichert und den Pfad im Theme entsprechend [angepasst](https://github.com/TribuneX/cocoa-hugo-theme/blob/master/layouts/partials/footer_scripts.html). Gleiches gilt für die [default.min.css](https://github.com/TribuneX/cocoa-hugo-theme/blob/master/layouts/partials/footer.html) Datei. Diese werden nun auch direkt von Hugo über die Ordner `css` und `js` [lokal](https://github.com/TribuneX/blog/tree/master/static) eingebunden.

Damit wurden alle externen Abhängkeiten des Blogs beseitigt, sodass kein  Request zu externen Servern vom Browser durchgeführt werden muss. Alle benötigten Dateien liegen bei meinem Hoster.

## HTTP Headers
Im nächsten Schritt überprüft webbkoll die gesetzten HTTP Header. Diese Header können über die `.htaccess` Datei entsprechend gesetzt werden. Ich verwende die Konfiguration, die Matjaž auf seinem [Blog geteilt hat](https://matjaz.it/lets-encrypt-matjaz-it/#extra-security-headers). Diese Konfiguration habe ich minimal angepasst und dabei die hart codierte URL durch `'self'` ersetzt.

```
## Security headers: HSTS, CSP etc.
## --------------------------------------------------------
<ifModule mod_headers.c>
    # Make browsers remember that this website prefers HTTPS over HTTP
    Header set Strict-Transport-Security "max-age=31536000; includeSubDomains" env=HTTPS
    # Allowed domains to load scripts, style sheets, images etc.
    Header set Content-Security-Policy "default-src 'self'"
    # Don't allow the website to be iframed
    Header always set X-Frame-Options "DENY"
    # Disable MIME type sniffing, which can e.g. make IE execute an innocent looking .img URL as a javascript.
    Header always set X-Content-Type-Options nosniff
    # Enable the built in reflective XSS protection in some browsers
    Header always set X-Xss-Protection "1; mode=block"
    # When navigating within this website, send full URL as referrer,
    # when from this to another HTTPS website send only home URL,
    # when from this to another HTTP website, send nothing.
    Header always set Referrer-Policy strict-origin-when-cross-origin
</ifModule>
```

Die Security Header könnten zusätzlich über [securityheaders.com](https://securityheaders.com/?q=https%3A%2F%2Fsascha-bleidner.de) überprüft werden.

## Resultate

{{< figure src="/img/webbkoll.png" >}}

Als Ergebnis der bisherigen Anpassungen stuft webbkoll alle Aspekte als positiv / grün ein! Auch bei statischen Webseiten ist Datenschutz ein relevantes Thema, bei dem es sich lohnt ein paar Stellschrauben zu justieren.

Als Resultat konnte ich meine [Datenschutzerklärung](/impressum) übersichtlich gestalten.









