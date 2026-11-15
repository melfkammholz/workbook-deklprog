Ein ADT trennt das, was eine Menge kann, davon, wie sie gebaut ist. In dieser
Lektion geht es darum, was wir von dieser Trennung haben.

= Implementierungen austauschen

Ein Programm, das nur die Funktionen des ADTs benutzt, verlässt sich nur auf
ihre Gesetze. Zum Beispiel zählt diese Funktion, wie viele verschiedene Werte
eine Liste enthält:

```haskell
distinct :: [a] -> Int
distinct xs = size (foldr insert empty xs)
```

`distinct` weiß nicht, ob die Menge eine Liste, ein Suchbaum oder eine
Hashtabelle ist. Jede Implementierung, die die Funktionen mit diesen Namen
bereitstellt und die Gesetze erfüllt, liefert dasselbe Ergebnis. Wir können
also die eine Implementierung durch eine andere ersetzen, etwa weil die
Listen zu groß und `member` zu langsam geworden ist, und `distinct` bleibt
richtig, ohne dass wir es anfassen.

Das gilt nur, solange das Programm sich wirklich nur auf die Gesetze verlässt.
Wer hineinschaut und etwa ausnutzt, dass die Listen-Implementierung die
Elemente in Einfügereihenfolge speichert, hat ein Programm, das mit einer
anderen Implementierung falsch wird.

#quiz(
  [Ein Programm benutzt nur die Funktionen des Mengen-ADTs. Du ersetzt die
  Implementierung durch eine andere, die ebenfalls alle Gesetze erfüllt. Was
  kann sich ändern?],
  choice[Die Ergebnisse des Programms][Die Ergebnisse hängen nur von dem ab,
    was die Funktionen liefern, und das legen die Gesetze fest.],
  choice(correct: true)[Laufzeit und Speicherbedarf][Genau: Wie schnell
    `insert` oder `member` sind, sagt der ADT nicht. Darin unterscheiden sich
    Implementierungen, und deshalb tauscht man sie.],
  choice[Nichts, alle Implementierungen sind gleich][Gleich sind sie nur in
    dem, was man beobachten kann. Intern und in ihrer Effizienz können sie
    sehr verschieden sein.],
)

= Wozu ADTs außerdem nützen

- *Arbeitsteilung:* Wer eine Implementierung schreibt, muss nur die Gesetze
  erfüllen. Wer sie benutzt, muss nur die Gesetze kennen. Beide können
  unabhängig voneinander arbeiten.
- *Dokumentation:* Die Gesetze beschreiben genau, was jede Funktion tut, statt
  es in Worten ungefähr zu sagen.
- *Nachdenken über Programme:* Mit den Gesetzen kannst du Aussagen über ein
  Programm wie `distinct` begründen, ohne irgendeine Implementierung zu
  kennen.
- *Testen:* Jede Implementierung kann man gegen die Gesetze testen.

= Klassen: ADTs mit veränderlichem Zustand

Eine Klasse in der objektorientierten Programmierung erweitert die Idee eines
ADTs um veränderlichen Zustand. Ein Objekt hat Methoden, die es verändern, und
was eine Methode liefert, hängt davon ab, was vorher mit dem Objekt passiert
ist.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5em,
  [
    *Haskell*
    ```haskell
    s = insert 1 empty
    t = insert 2 s

    member 2 s  -- False: s ist unverändert
    member 2 t  -- True
    ```
    `insert` liefert eine neue Menge. `s` bezeichnet für immer dieselbe Menge.
  ],
  [
    *Java*
    ```java
    Set<Integer> s = new HashSet<>();
    s.add(1);
    Set<Integer> t = s;
    t.add(2);

    s.contains(2);  // true: s und t sind dasselbe Objekt
    ```
    `add` verändert das Objekt und liefert nur einen `boolean`, ob sich etwas
    geändert hat. Wer `s` noch kennt, sieht die Änderung über `t`.
  ],
)

Mit veränderlichem Zustand ist ```java s.contains(2)``` keine feste Größe
mehr: Vor ```java t.add(2)``` ist es `false`, danach `true`. Gesetze müssen
dann über Abfolgen von Aufrufen sprechen ("nachdem `add(x)` aufgerufen wurde,
liefert `contains(x)` den Wert `true`"). Das ist möglich, aber deutlich
schwerer aufzuschreiben und zu prüfen als eine Gleichung zwischen Werten, die
sich nie ändern.

#practice("adt-encapsulation")
