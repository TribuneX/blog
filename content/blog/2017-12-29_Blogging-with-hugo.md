---
title: "Git-based Blogging mit Hugo"
date: 2017-12-29T19:00:00+01:00
draft: true
---

Eigentlich war ich bisher ein großer Fan von Wordpress. MySQL Datenbank erstellen, Wordpress Dateien kopieren und schon kann es los gehen. Doch welche Plugins sollten es noch sein: Caching, Gallery, Contact Form, Login Security? Das muss doch auch einfacher und minimaler gehen! 

## Static Site Generator

Nach kurzer Recherche bin ich auf [Hugo](https://gohugo.io) gestoßen. Hugo ist ein Static Site Generator. Statische Webseiten? Das klingt so nach den 90er, als das Web noch überwiegend aus handgemachten HTML Seiten bestand. Doch braucht es für einen einfachen Blog wirklich PHP und MySQL mit allem drum und dran? Wir werden sehen! Momentan glaube ich, dass statisch generierte Seiten vollkommen ausreichen. Diese bieten gegenüber dynamischer Seiten einige Vorteile:

* schnelle Ladezeit besonders mobil
* Plaintext Dateien 
* keine Datenbank notwendig
* Versionierung mittels Git
* offline editieren


## Hugo

Der [Quick Start Guide](https://gohugo.io/getting-started/quick-start/) ist äußert kompakt. Markdown Dateien im Ordner /content werden in statische HTML Seiten umgewandelt und entsprechend verlinkt. Das folgende Kommando startet einen lokalen Webserver, mit dem die generierte Seite aufgerufen werden kann:

```bash
hugo server -D
```

## Hosting

Wohin nun mit den generierten HTML und CSS Dateien? Da alle Inhalte statisch sind, kann jeder Webserver die generierten Dateien ausliefern. Seit 2009 liefert [all-inkl](https://all-inkl.com) meine Webseiten aus. Auch dieser Blog ist keine Ausnahme. Einfach die Dateien im /public Verzeichnis auf den Webserver kopieren und die entsprechende URL aufrufen. 

## Versionierung







## Deployment mittels Travis CI

```bash
language: go

go:
  - master

install:
  - go get github.com/spf13/hugo 

script:
  - hugo

deploy:
  - provider: script
    script: chmod +x ./scripts/deploy.sh && ./scripts/deploy.sh
    skip_cleanup: true
    on:
      branch: master
```

[http://singapur.cbs-service.net](http://singapur.cbs-service.net)