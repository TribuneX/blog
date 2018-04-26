---
title: "Wofür steht 'Smart' in Smart-Home?"
date: 2018-01-07T21:41:53+01:00
draft: false
---

Diese Frage stellte ich mir nach einigen Monaten basteln und experimentieren mit WIFI Steckdosen, Temperatur Sensoren oder [Staubsauger Roboter](http://www.mi.com/roomrobot/). Die Grundregel lautet: Alles was eine IP-Adresse hat kann auch in Home Assistant eingebunden werden. Meine [TRÅDFRI](http://www.ikea.com/de/de/catalog/categories/departments/lighting/smart_lighting/) Lampen werden statt mit dem Lichtschalter an der Wand nun mit dem iPhone gesteuert. Der Fernseher wird nicht mehr per Fernbedienung eingeschaltet, sondern ebenfalls über das iPhone. Doch ist das nun 'smarter' als früher?

## Smart?

Laut [Duden](https://www.duden.de/rechtschreibung/smart) steht 'smart' für clever oder gewitzt. Ein gewitztes Zuhause klingt zwar interessant, doch clever klingt schon nach der richtigen Richtung. Technisch mag es eine nette Spielerei sein wenn die Lampen statt mit dem Schalter an der Wand, der übrigens bereits kurz nach der Glühbirne erfunden wurde, mit dem iPhone gesteuert werden. Ein Wettrennen gegen den Lichtschalter gewinnt das iPhone trotz A11 Fusion Chip dennoch nur schwer. 
Die Temperatur im Wohnzimmer kann nun auch über das iPhone abgerufen werden. Doch wo liegt hier der Vorteil gegenüber dem Digital-Thermometer direkt auf dem Regal? Ist ein Blick auf ein kleines LCD-Display nicht schneller, als das iPhone erst aus der Hosentasche zu kramen? Doch Geschwindigkeit ist nicht immer alles.

Zurück zum Begriff 'smart' oder auch clever. Könnten wir nicht eher von einem Smart-Home sprechen, wenn die Temperatur zur Heizungssteuerung genutzt wird (mir fehlen leider noch die passenden Thermostate mit Home Assistant Integration) oder die Lampen erst einschalten, wenn jemand nach Hause kommt? Und sich auch gleich am Abend ausschalten, sobald alle im Bett sind?

## No-Button-Paradigma

Mit steigender Anzahl Komponenten in meinem Smart-Home, zeigte sich mehr und mehr, dass ich statt iPhone Steuerung lieber gar keine Steuerung bevorzugen würde. Die Geräte sollen sich idealerweise selbst regulieren. Seitdem entwickle ich die [Automationen](https://home-assistant.io/components/automation/) in Home Assistant genau nach diesem Grundsatz: Keine Buttons! Geräte sollen anhand von beliebigen Sensordaten ihren Schaltzustand ableiten, ohne dass ich erst den korrekten Button drücken muss. 

![Home Assistant GUI](/img/home_assistant_automations.png)

Ein vernetztes Zuhause ist für mich erst dann 'smart', wenn es den Großteil der Aktionen automatisiert auslöst. Der Bewohner sollte nicht aktiv in die Steuerung der Geräte eingreifen müssen. Denn wer erst einen Button drücken muss, der muss auch erst einmal darüber nachdenken, was er gerade einschalten, auslösen oder ausschalten möchte. Diese Denkaufgabe sollte einem das Smart-Home schon abnehmen können, sonst hat es meiner Meinung nach den Zusatz 'smart' nicht verdient. Jedes Smart-Home ist damit gleichzeitig auch ein vernetztes Zuhause, umgekehrt gilt dies aber nicht automatisch.





