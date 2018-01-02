---
title: "Home Automation - Wie alles begann"
date: 2018-01-01T19:00:00+01:00
draft: false
---

## Erste Gehversuche

Alles fing mit einem Raspberry Pi Model B an. Zusammen mit dem [Connair 433Mhz Gateway](http://wiki.simple-solutions.de/de/products/Conn_Air) und der passenden [Web-App](http://l3x.de/connair/) wurden die ersten Steckdosen "smart". Wobei "smart" sich damals auf einfache Timer und die Steuerung über ein iPhone beschränkte. Für 2013 fand ich das dennoch beeindruckend. Auch Siri war bereits mit von der Partie und konnte in mühevoller Handarbeit über den [SiriProxy](https://github.com/plamoni/SiriProxy) mit eigenen Befehlen erweitern werden. Der Aufwand stand dabei allerdings in keinem Verhältnis zum wirklichen nutzen.

Zwei Jahre später verstand sich Siri doch noch mit meinen Steckdosen. Dank [HomeControl](https://github.com/brutella/hc) sogar recht zuverlässig. Später bastelte ich auch noch eine Anbindung an die [netatmo Wetterstation](https://www.netatmo.com/en-US/product/weather/) dazu. Die Steckdosen und die Temperaturdaten ließen sich zwar per Siri steuern und abrufen, das Setup fühlte sich aber doch mehr nach Proof of Concept an, statt nach wirklicher Heimautomatisierung.

## Home Automation 2.0

Da muss doch noch mehr gehen! Ich machte mich also auf die Suche nach verfügbaren Open Source Projekt zur Heimautomatisierung. Von der Stange gab und gibt es oft leider immer nur sehr eingeschränkte Systeme. Mal fehlt ein Sensor, mal ist eine Cloud-Anbindung Pflicht! 

Meine Wunschliste für meine Heimautomatisierung:

* Flexibel: Es soll verschiedene Systeme miteinander verbinden können. 
* Offline: Es soll ohne Cloud-Anbindung funktionieren. 
* Hübsch: Das Frontend soll ansehnlich sein.
* Konfigurierbar: Automationen mit Zugriff auf alle Sensoren sollen kein Problem sein.

Ich wurde schließlich fündig: [Home Assistant](https://home-assistant.io). 

### Flexibel

Home Assistant basiert auf Python und integriert mittlerweile mehr als [900 Komponenten](https://home-assistant.io/components/). Dabei wird so gut wie jede Smart Home Plattform bis hin zum Bash-Skript unterstützt. Auch neue Hardware wird binnen weniger Wochen oft unterstützt. Ein Hoch auf die Developer Community. 

### Offline

Home Assistant läuft komplett lokal (aktuell auf einem Raspberry Pi 3). Es ist also komplett autark und damit unabhängig von einer Cloud-Anbindung. Damit verbleiben auch die Daten der Sensoren lokal und werden nicht außerhalb der eigenen vier Wände gespeichert. 

### Hübsch
Seht selbst:
![Home Assisant GUI](/img/home_assistant_frontend.png)

### Konfigurierbar

Home Assistant wird über YAML Dateien konfiguriert. YAML ist einfach zu schreiben und lässt sich recht gut lesen. Vorteil der Plaintext Config Dateien ist die leichte Versionierbarkeit. 

```
commit 5a76e05145ed1893f51d9083bd6d2aaedbf74773
Author: Sascha <sascha@cbs-service.net>
Date:   Sat Apr 8 22:30:34 2017 +0200
    first commit
```

Mein erster Commit war Anfang 2017. Seitdem ist meine Config auf [GitHub](https://github.com/TribuneX/home_assistant) verfügbar. Viele Home Assistant Nutzer teilen ihre Config auf GitHub, sodass man auch viel von anderen Configs lernen kann. Bei mittlerweile über 800 Commits kann man erahnen, dass schon einige Stunden in das konfigurieren und erweitern meines Setups geflossen sind. 

## Summary
Ich verbringe zwar wohl mehr Zeit mit konfigurieren, als ich am Ende durch die Automatisierung Zeit spare, dafür macht es aber eine Menge Spaß! Mit Home Assistant gibt es so gut wie keine Grenzen, die sich nicht mit ein bisschen Config Scrippting überwinden lassen. 
