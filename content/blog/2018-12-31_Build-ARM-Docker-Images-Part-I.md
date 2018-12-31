---
title: "Build ARM Compatible Docker Images on Docker Hub Teil I"
date: 2018-12-31T14:00:00+02:00
draft: true
---

Mein Home Assistant Setup läuft seit einem halben Jahr ein einem Asus Tinker Board. Damit bin ich für mein Docker Setup weiterhin auf ARM kompatible Images angewiesen. Noch vor einem Jahr war die Suche nach ARM kompatiblen Images auf Docker Hub eine große Herausforderung. Images mit ARM oder Pi im Titel waren die besten Kandidaten. 

## Die ewige Suche nach dem ARM Image

Dies hat sich in letzter Zeit aus zwei Gründen verbessert. Zum einen gibt es nun sehr umfangreiche Sammlungen von ARM kompatiblen Images ([arm32v7](https://hub.docker.com/u/arm32v7/)oder [arm32v6](https://hub.docker.com/u/arm32v6)). Zum anderen unterstützt Docker Hub mittlerweile Multi-Arch Images. So ist das [alpine Image](https://hub.docker.com/_/alpine) für die verschiedensten Architekturen verfügbar. Je nach Docker Host wird mit `docker pull alpine` das Image für die jeweilige Architektur geladen. Somit bedarf es keiner verschiedenster Tags je nach Architektur für diese Repositories mehr. 

Statt daher aufwendig ein kompatibles und vor allem aktuelles Image zu finden, baue ich sie mir für zwei meiner Anwendungsfälle selbst:
- [Eclipse Mosquitto](https://cloud.docker.com/repository/docker/tribunex/mosquitto-pi)
- [Git Pull](https://cloud.docker.com/repository/docker/tribunex/git-pull-pi)

## Docker Build automatisieren

Bisher habe ich diese Images direkt auf meinem Tinker Board gebaut und von dort aus veröffentlicht. Somit war die ARM Kompatibilität immer gegeben. Dies ist allerdings zeitaufwendig und liese sich nur mit Mehraufwand automatisieren. 

Da sich ARM kompatible Docker Images mittlerweile auch auf x86 Hardware bauen lassen, will ich den Prozess über diesen Weg automatisieren. Damit kann ein Docker Image über ein Github Repository immer aktuell gehalten werden, sobald sich am Repository etwas ändern.

Für diesen Anwendungsfall habe ich bisher zwei Wege ausprobiert:

1. Travis CI
2. Automatisierter Build über Docker Hub

Beide Wege setzen jedoch ersteinmal einen entsprechenden ARM Emulator voraus, da beide das Image auf x86 Hardware bauen. Hierfür bietet sich [QEMU](https://www.qemu.org) an, das von vielen Repositories auf Docker Hub für das ARM kompatible Image verwendet wird. 

Um QEMU nutzen zu können müssen zwei Voraussetzungen erfüllt sein:

1. Auf dem Build Host muss QEMU registriert werden.
2. Das passende QEMU Binary muss Teil des zu bauenden Docker Images sein.

### QEMU auf dem Build Host registrieren
Die QEMU Binaries lassen sich per Docker Container einfach auf einem Build Host registrieren. Dazu muss folgender Befehl vor dem eigentlichen Bau des Images aufgerufen werden:

    docker run --rm --privileged multiarch/qemu-user-static:register --reset

Dies registriert die notwendigen Befehle auf dem Build Host, die zum Bau eines ARM kompatiblen Images auf einem x86 Host notwendig sind. 

### QEMU als Teil des Docker Images
Zusätzlich zu oben genanntem Befehl muss das QEMU Binary zusätzlich noch Teil des zu bauenden Docker Images sein. Dies war für mich anfangs nicht ersichtlich. Das Image wird zwar auch ohne dieses Binary gebaut, ist dann aber wie zu erwarten nicht auf einem ARM Board lauffähig. 

Die QEMU Binaries können entweder über das Dockerfile des jeweiligen Images kopiert werden ([Beispiel](https://github.com/davidecavestro/mariadb-docker-armhf/blob/756c3f31a117341896c37976640055fb43d5b004/Dockerfile#L3)) oder man baut auf einem BASE Image auf, das bereits das QEMU Binary eingebunden hat.

Beide Varianten zeige ich im folgenden am Beispiel eines Travis CI und eines Builds mittels Docker Hub.




## Was will ich erwähnen

- QEMU Binaries
  - Binary muss Teil des Images sein
  - 1. Copy
  - 2. Entsprechendes BASE Image nutzen
- Travis Build
- Docker Hub 
  - Hooks










