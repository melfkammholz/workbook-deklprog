# workbook-deklprog

Übungen zur Vorlesung „Deklarative Programmierung“ an der Christian-Albrechts-Universität zu Kiel, zum Bearbeiten im
[Workbook](https://github.com/melfkammholz/workbook).

Der Kurs folgt der Vorlesung: zuerst funktionale Programmierung in Haskell, dann logische Programmierung in Prolog.
Dazu kommen die Präsenzaufgaben aus den Übungen, nach Wochen sortiert. Zu jedem Kapitel gibt es Aufgaben mit Tests,
Hinweise, Musterlösungen und eine Selbstevaluation. Einige Abenteuer führen durch mehrere Aufgaben hintereinander.
Manche Verweise (Skript, Fachschaft, Moodle, Mattermost) beziehen sich auf die Veranstaltung in Kiel.

Dieses Workbook basiert auf [DeklProgSelftests](https://github.com/Ziharrk/DeklprogSelfTests) und ist deren Weiterentwicklung.

## Loslegen

1. Richte das Workbook ein, wie es in seinem
   [README](https://github.com/melfkammholz/workbook#set-it-up) beschrieben ist.
2. Öffne <http://localhost:8080> und füge diese Adresse als Kurs hinzu:

   ```text
   https://github.com/melfkammholz/workbook-deklprog
   ```

Wenn es neue Aufgaben gibt, zeigt das Workbook das an. Deine bisherige Arbeit bleibt dabei erhalten.

## Fehler gefunden?

Bei jeder Aufgabe gibt es einen Link, der hier ein Issue mit Titel und Kennung der Aufgabe anlegt. Deine Lösung wird
dabei nicht mitgeschickt.

## Für Autorinnen und Autoren

Das Format der Aufgaben beschreibt
[docs/authoring.md](https://github.com/melfkammholz/workbook/blob/main/docs/authoring.md) im Workbook. Prüfe Änderungen
vor einem Commit mit

```sh
docker compose run --rm workbook node server/dist/cli.js lint --render --solutions
```

aus dem Ordner des Workbooks, mit diesem Kurs in `compose.override.yaml` eingebunden.
