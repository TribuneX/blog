---
title: "RSS Life Hacks"
date: 2018-04-26T20:03:13+02:00
draft: false
---

Nachfolgend eine kleine Auswahl mit Dingen, die ich aktuell sonst so mit RSS anstelle:

## Mail to RSS

E-Mail Postfächer werden täglich mit einem nicht zu unterschätzenden Anteil mit Newslettern gefüllt. Bei den meisten Newslettern hilft ein Klick auf Abmelden, einige interessieren mich aber dann doch! Statt diese auf mein Postfach loszulassen, rufe ich sie stattdessen per RSS Feed ab.

Hierfür nutze ich seit längerem den sehr zuverlässigen Dienst [kill-the-newsletter](https://www.kill-the-newsletter.com).

![Kill the Newsletter](/img/newsletter_rss.png)

 Titel anlegen, Newsletter mit der generierten E-Mail Adresse abonnieren und den neuen Feed über die generierte Feed Adresse abonnieren. Den Dienst nutze ich nicht nur für Newsletter, sondern auch für Benachrichtigungen über neue Kommentare Github oder im Home Assistant Forum.
 

## Release Benachrichtigungen

![Docker Hub](/img/docker_hub_rss.png)

Ich suche weiterhin einen Weg um über neue Images auf [Docker Hub](https://hub.docker.com) benachrichtigt zu werden. Bis es einen offiziellen Weg gibt behelfe ich mir mit dem Abonnieren der Github Release Seiten der jeweiligen Projekte. Über neue Releases von Miniflux kann man sich per Feed benachrichtigen lassen. Dazu einfach ein `.atom` an die jeweilige `github.com`-URL anfügen:

https://github.com/miniflux/miniflux/releases.atom

Da für jedes neue Release auch kurz darauf ein neues Docker Image verfügbar ist, kann ich so implizit auch die Docker Images im Auge behalten.

## RSS Frühjahrsputz

Mit der Zeit sammeln sich schnell eine große Anzahl an Feeds in Miniflux an. Diese lassen sich zwar durch Ordner nach Themen gruppieren, die Zeit, die mir zum Lesen bleibt, wird dennoch nicht mehr. 

![Todoist Task](/img/todoist_rss.png)

Daher habe ich mir in Todoist einen monatliche Aufgabe eingestellt, die mich daran erinnert nicht mehr gelesene Feeds zu entfernen. Das hält die Auswahl aktuell und lesenswert. Feeds die ich meist nur noch überspringe werden entfernt und schaffen Platz für andere Inhalte.

RSS bleibt ein spannendes Thema!