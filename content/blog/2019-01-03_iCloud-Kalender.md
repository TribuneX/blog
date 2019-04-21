---
title: "iCloud Kalender unter lesbarer URL verfügbar machen"
date: 2019-01-03T14:00:00+02:00
draft: false
---

{{< figure src="/img/cal.png" >}}

Als Kalender Server nutze ich seit mehreren Jahren zuverlässig [Baïkal](https://github.com/sabre-io/Baikal). Dort liegen meinen privaten Kalender, sowie gemeinsame Kalender für die Familie. Baïkal wird leider nicht mehr weiterentwickelt, sodass öffentliche Kalender oder Einladungen per email wohl nicht mehr nachgerüstet werden. 

Für beide Anwendungsfälle nutze ich einen iCloud Kalender. Dieser lässt sich leicht als [URL veröffentlichen](https://support.apple.com/kb/PH2690?locale=en_US&viewlocale=de_DE). Die URLs sind alles andere als kurz. Um den Kalender z.B. unseres Uni Stammtisch unter einer lesbaren URL verfügbar zu machen reicht ein einfacher 301 Redirect auf die iCloud URL. Das Protokoll webcal hierzu durch https ersetzen. 

Für Apache reicht ein Eintrag in der .htaccess Datei:

    Redirect 301 "/cal.ics" "https://p38-calendars.icloud.com/..."

Voilá. Der Kalender kann nun über `https://example.net/cal.ics` abonniert werden. 

{{< figure src="/img/cal-sub.png" >}}

Weiterer Vorteil eines solchen Redirects: Sollte ich doch eine Alternative zum iCloud Kalender finden, kann ich den Redirect anpassen, ohne das ein Client davon etwas mitbekommt. Vorausgesetzt er speichert die URL und nicht die Ziel-URL des Redirects.