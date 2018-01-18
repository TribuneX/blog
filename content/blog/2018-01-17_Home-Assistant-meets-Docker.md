---
title: "Home Assistant meets Docker"
date: 2018-01-17T21:29:00+01:00
draft: false
---

Mein [Home Assistant](https://home-assistant.io) Setup lief bis vor wenigen Tagen auf einem Raspberry Pi2. Alle anderen Apps (dnsmasq, resilio, nginx, etc.) hatte ich bereits auf einen Raspberry Pi3 verlagert. Auf dem Pi3 laufen lediglich Docker Container, d.h. jede App läuft in ihrem eigenen Docker Container. Der Umzug von Home Assistant war zwar bereits geplant, ich scheute aber noch die notwendigen Anpassungen an der Konfiguration. Den Ausschlag für die kurzfristige Migration gab jedoch der Pi2 selbst: Das Filesystem war plötzlich nur noch read-only. Die MicroSD-Karte schien schien nach 3 Jahren Betrieb nun langsam ihren Geist aufzugeben. Also hieß es handeln. 

## Auf das richtige Image kommt es an

![Docker Logo](/img/docker.png)

Docker Images sind plattformspezifisch. D.h. auf dem Pi laufen nur arm spezifische Images. Die Suche nach einem passenden arm32v7 [[^1]] gestaltet sich dabei häufig schwierig, da das offizielle [Docker Repository](https://hub.docker.com) nicht nach Plattformen filtern kann. 

Glücklicherweise gibt es ein [offizielles Docker Image](https://hub.docker.com/r/homeassistant/raspberrypi3-homeassistant/) von den Machern von Home Assistant, das speziell für den Pi3 ausgelegt ist. 

## Docker Compose

Docker Container lassen sich zwar bereits mit einem einfachen `docker container run` ausführen, insbesondere wenn mehrere Container parallel gestartet werden sollen, vereinfacht [Docker Compose](https://docs.docker.com/compose/overview/) das Container Handling ungemein. 

Hier ein Auszug aus meiner `docker-compose.yml:`

```
version: '3'
services:
  homeassistant:
    image: homeassistant/raspberrypi3-homeassistant:latest
    container_name: "homeassistant"
    restart: always
    dns:
      - 192.168.178.5
    ports:
      - "8123:8123/tcp"
    volumes:
      - /opt/home_assistant/:/config
      - /etc/localtime:/etc/localtime:ro
      - /opt/ssl/:/ssl
```

`container_name: "homeassistant"`: Der Container wird mit dem Namen "homeassistant" gestartet.
 
`192.168.178.5`: Zur Auflösung von internen Hostnamen verwende ich dnsmasq. Dieser DNS-Server kann über die Konfiguration `dns:` für den Docker Container festgelegt werden.

`"8123:8123/tcp"`: Die Home Assistant UI ist über den gewohnten Port 8123 per HTTPS verfügbar. Das hierzu benötigte Zertifikat wird per Volume eingebunden und unter dem Pfad `/ssl` bereitgestellt. 

`/opt/home_assistant/:/config`: Die Home Assistant Konfiguration verwalte ich außerhalb des Containers in einem eigenen Repository. Diese Repository wird ebenfalls über ein Volume eingebunden und ist im Container unter dem Pfad `/config` verfügbar.

Damit lässt sich Home Assistant bequem aus dem Verzeichnis, in dem die `docker-compose.yml` Datei gespeichert ist starten. Hierzu genügt ein einfaches `docker-compose up -d`. Gestoppt werden kann der Container jederzeit über `docker-compose down`. 

Der größte Vorteil an Docker Compose liegt darin, dass mit nur einem Befehl weitere Container gestartet werden können. Neben dem Home Assistant Container werden noch ein Container für [Homebridge](https://github.com/nfarina/homebridge) und [InfluxDB](https://www.influxdata.com) gestartet.

## Offene Baustellen

Die Migration meiner bisherigen Installation hin zu einem Docker Container verlief verhältnismäßig reibungslos. Dennoch gibt es noch folgende offene Baustellen, die im neuen Setup noch behoben werden müssen:

1. Reload der Konfiguration nach erfolgreichem Travis CI Build
2. Wake-on-LAN und Showdown meines HP Microservers

Bisher hatte ich eine Art [Continuous Integration](https://community.home-assistant.io/t/update-config-automatically-if-travis-ci-build-succeeds/19966) für mein Home Assistant Setup umgesetzt. D.h. Home Assistant hat über einen Sensor den Travis CI Build überwacht und falls dieser erfolgreich war, automatisiert die Konfiguration per `git pull` aktualisiert und anschließend einen Neustart durchgeführt. Da die Konfiguration außerhalb des Containers gespeichert ist, kann Home Assistant sie nicht mehr direkt per `git pull` aktualisieren. Des weiteren sollte statt einem Neustart von Home Assistant besser gleich der ganze Container neu gestartet werden, da aktuell auch der Homebridge Container immer mit neu gestartet werden sollte [[^2]]. 

Auch das Wake-on-LAN Kommando weckt meinen HP Microserver nicht mehr auf. Den Shutdown Befehl hatte ich bisher per SSH-Login realisiert. Dies ist aus dem Container heraus allerdings ebenfalls nicht mehr möglich. Bis der volle Funktionsumfang wiederhergestellt ist, bedarf es also noch ein paar Anpassungen. 

## Summary

Insgesamt bin ich aber mit Docker und Home Assistant sehr zufrieden. Insbesondere Docker Compose erleichtert das parallele Starten der notwendigen Container ungemein. Dabei sorgt `restart: always` für einen reibungslosen Autostart, falls der Host neugestartet wird. Vorher mussten stattdessen komplexere Autostart Skripte an die richtigen Stellen im System kopiert werden. Diese Skripte werde ich zwar nicht vermissen, die Wake-on-LAN Funktion hingegen schon!  

[^1]: Ein 64bit Raspbian Image mit Untersützung für arm64v8 ist noch nicht verfügbar.
[^2]: Ein [Bug](https://github.com/home-assistant/homebridge-homeassistant/issues/150) führt dazu, dass Homebridge die Sockets nicht schließt. 