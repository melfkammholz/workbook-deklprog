Die #link("https://de.wikipedia.org/wiki/Pomodoro-Technik")[Pomodoro-Technik]
ist eine Zeitmanagement-Methode, die einen Kurzzeitwecker nutzt, um Arbeits-
und Pauseabschnitte einzuteilen. Um ein Informatik-Studierenden-Klischee zu
bedienen, entscheidest du dich, den Timer selbst zu bauen. Da du dich nicht
planlos in die Implementierung stürzen möchtest, formulierst du zuerst einen
ADT.

Der ADT soll folgende Operationen unterstützen. Es soll möglich sein, ...
- ... einen Timer mit einer Zeiteingabe zu starten -- die Zeiteingabe soll aus
  Stunden und Minuten bestehen,
- die verbleibende Zeit auf dem Timer abzufragen, und
- zu prüfen, ob der Alarm bereits ausgelöst wurde. Der Alarm wird ausgelöst,
  sobald die verbleibende Zeit vorüber ist.
- Um das Vergehen von Zeit zu modellieren, soll der ADT weiter eine Funktion
  bereitstellen, die eine Sekunde vergehen lässt. Wenn keine Zeit mehr
  verblieben ist, dann hat diese Operation keine Auswirkung.

Gib für jede Funktion mindestens ein Gesetz an.

#sample[
  Beschreibe `Timer` den zu spezifizierenden ADT. Dann sollen für diesen folgende
  Funktionen existieren und Gesetze gelten.

  _Konstruktoren_
  - `new :: Int -> Int -> Timer` erzeugt einen neuen Timer mit einer Zeiteingabe
    bestehend aus Stunden und Minuten.
  _Selektoren_
  - `display :: Timer -> (Int, Int, Int)` gibt die verbleibende Zeit auf dem Timer
    in Stunden, Minuten und Sekunden an.
  _Testfunktionen_
  - `wentOff :: Timer -> Bool` gibt an, ob der Timer bereits klingelte.
  _Operationen_
  - `tick :: Timer -> Timer` lässt eine Sekunde auf einem Timer vergehen.

  _Gesetze_

  Seien $h in NN_0$, $m in {0, ..., 59}$ und $t$ ein beliebiger Timer.
  - `display (new h m) == (h, m, 0)`
  - `wentOff t <=> display t == (0, 0, 0)`
  - `display t == (h, m, s) && s > 0 ==> display (tick t) == (h, m, s - 1)`
  - `display t == (h, m, 0) && m > 0 ==> display (tick t) == (h, m - 1, 59)`
  - `display t == (h, 0, 0) && h > 0 ==> display (tick t) == (h - 1, 59, 59)`
  - `display t == (0, 0, 0) ==> display (tick t) == (0, 0, 0)`
]

#remark[
  In der Klausur des 1. Prüfungszeitraums WS25/26 gab es eine ADT-Aufgabe, in der
  eine Uhr modelliert werden sollte. Die häufigsten Fehler sind hier auf diese
  Aufgabe übertragen.
  - Die Definition von Konstruktoren als Teil einer `data`-Deklaration des ADT.
    `data Timer = Timer Int Int` ist bereits eine Implementierung. Eine wesentliche
    Eigenschaft eines ADTs ist, dass man sich über Implementierungsdetails keine
    Gedanken machen muss (und soll). Dazu gehört die konkrete Darstellung des Typen,
    die wir mit der obigen Deklaration angeben. Stattdessen geben wir eine Funktion
    mit dem Typ `Int -> Int -> Timer` als Konstruktor an. So ist die interne
    Darstellung weiterhin offen.
  Die nächsten Anmerkungen fallen in die Kategorie "Nicht unbedingt falsch, aber fehl
  am Platz". Der ADT soll die Funktionsweise einer Schnittstelle angeben und sich
  nicht mit Implementierungsdetails aufhalten.
  - Es kam häufiger vor, dass Hilfsfunktionen angegeben wurden, die die Konsistenz
    des internen Zustands eines Wertes überprüfen sollten -- möglicherweise aus der
    Motivation heraus, dass so etwas wie z.B. `display (new 0 73)` nicht passieren kann.
  - Unter der Annahme einer Vergleichsoperation auf Timern gab es z.B. auch das Gesetz
    `t1 == t2 <=> display t1 == display t2`. Es gilt zwar, wann zwei Timer gleich
    sind, aber sagt nichts darüber aus, wie ein Timer funktionieren soll.
]
