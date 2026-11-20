Bevor wir Lazy Evaluation weiter ausnutzen, wiederholen wir, welche
Auswertungsstrategien es gibt. Eine Strategie legt fest, welchen Redex (reduzierbaren
Teilausdruck) wir als Nächstes auswerten, wenn es mehrere gibt. Das Ergebnis ist
fast immer dasselbe, der Weg dahin nicht.

= Innermost, outermost und Sharing

- *Innermost* wertet zuerst die Argumente aus und ruft dann die Funktion auf.
  Das ist die Strategie fast aller Programmiersprachen (_call by value_).
- *Outermost* setzt zuerst die Funktion ein und wertet ein Argument erst aus,
  wenn die Funktion es braucht (_call by name_). Wird ein Argument im Funktionsrumpf
  mehrfach benutzt, steht dort mehrfach derselbe Ausdruck.
- *Outermost mit Sharing* ist outermost, aber alle Stellen, an die dasselbe Argument
  eingesetzt wurde, teilen sich eine Auswertung (_call by need_). Das ist Haskell.

Wir rechnen zwei Beispiele aus. Das erste zeigt, wo outermost ohne Sharing Arbeit
verdoppelt:

#tabs(
  label: "Beispiel",
  tab("square (2 + 3)")[
    Mit `square x = x * x`:
    #tabs(
      label: "Strategie",
      tab("Innermost")[
        #steps(
          step(label: "Start")[
            ```haskell
            square (2 + 3)
            ```
          ],
          step(label: "Argument auswerten")[
            ```haskell
            square (2 + 3)
            == square 5
            ```
            `2 + 3` ist der innerste Redex.
          ],
          step(label: "Funktion einsetzen")[
            ```haskell
            square 5
            == 5 * 5
            ```
          ],
          step(label: "Ergebnis")[
            ```haskell
            5 * 5
            == 25
            ```
            Eine Addition, eine Multiplikation.
          ],
        )
      ],
      tab("Outermost")[
        #steps(
          step(label: "Start")[
            ```haskell
            square (2 + 3)
            ```
          ],
          step(label: "Funktion einsetzen")[
            ```haskell
            square (2 + 3)
            == (2 + 3) * (2 + 3)
            ```
            Das Argument wird nicht ausgewertet, sondern kopiert.
          ],
          step(label: "Linken Faktor auswerten")[
            ```haskell
            (2 + 3) * (2 + 3)
            == 5 * (2 + 3)
            ```
          ],
          step(label: "Rechten Faktor auswerten")[
            ```haskell
            5 * (2 + 3)
            == 5 * 5
            ```
            Dieselbe Addition ein zweites Mal.
          ],
          step(label: "Ergebnis")[
            ```haskell
            5 * 5
            == 25
            ```
            Zwei Additionen, eine Multiplikation.
          ],
        )
      ],
      tab("Outermost mit Sharing")[
        #steps(
          step(label: "Start")[
            ```haskell
            square (2 + 3)
            ```
          ],
          step(label: "Funktion einsetzen")[
            ```haskell
            square (2 + 3)
            == x * x   where x = 2 + 3
            ```
            Beide `x` zeigen auf denselben Ausdruck.
          ],
          step(label: "Linken Faktor auswerten")[
            ```haskell
            x * x   where x = 5
            ```
            Die Auswertung ersetzt `x` an _beiden_ Stellen.
          ],
          step(label: "Ergebnis")[
            ```haskell
            5 * 5
            == 25
            ```
            Eine Addition, eine Multiplikation: so viel wie bei innermost.
          ],
        )
      ],
    )

    In GHC sieht man das mit `Debug.Trace`: `square (trace "2+3" (2 + 3))` gibt
    `2+3` nur einmal aus.
  ],
  tab("const 1 (1 `div` 0)")[
    Mit `const x _ = x`. Hier geht es nicht um Aufwand, sondern darum, ob die
    Rechnung überhaupt gelingt:
    #tabs(
      label: "Strategie",
      tab("Innermost")[
        #steps(
          step(label: "Start")[
            ```haskell
            const 1 (1 `div` 0)
            ```
          ],
          step(label: "Argument auswerten")[
            ```haskell
            1 `div` 0
            == *** Exception: divide by zero
            ```
            Das zweite Argument wird ausgewertet, obwohl `const` es wegwirft. Der
            Fehler bricht die ganze Rechnung ab.
          ],
        )
      ],
      tab("Outermost (mit oder ohne Sharing)")[
        #steps(
          step(label: "Start")[
            ```haskell
            const 1 (1 `div` 0)
            ```
          ],
          step(label: "Funktion einsetzen")[
            ```haskell
            const 1 (1 `div` 0)
            == 1
            ```
            `const` braucht das zweite Argument nicht, die Division wird nie
            ausgeführt.
          ],
        )
      ],
    )
  ],
)

#quiz(
  [Welche Strategie wertet in `const 1 (length [1..])` das zweite Argument
  aus?],
  choice(correct: true)[Innermost][Genau: Die Liste `[1..]` ist unendlich, `length`
    kommt nie zurück. Die Rechnung hängt, obwohl das Ergebnis `1` heißt.],
  choice[Outermost][Nein: Outermost setzt `const` zuerst ein und ignoriert das
    zweite Argument.],
  choice[Outermost mit Sharing][Nein: Sharing ändert nur, wie oft ausgewertet wird,
    nicht ob.],
)

= Welche Strategie ist am besten?

Outermost ist _normalisierend_: Hat ein Ausdruck eine Normalform, dann findet
outermost sie. Andere Strategien, zum Beispiel innermost, können für einen
solchen Ausdruck in eine Endlosschleife laufen oder einen Fehler werfen
(`const 1 (1 `div` 0)`). Der Preis ist das Verdoppeln von Arbeit, und genau das
behebt Sharing. Haskell nutzt deshalb *leftmost outermost mit Sharing*: Von
mehreren äußersten Redexes wird der linke zuerst ausgewertet.

= Andere Sprachen

Fast alle Sprachen, die du kennst, rechnen innermost:

#table(
  columns: 3,
  [*Sprache*], [*Strategie*], [*`f(1, 1/0)` mit `f(x, y) = x`*],
  [Python (auch Java, C)], [innermost: Argumente zuerst], [`ZeroDivisionError`],
  [Haskell], [outermost mit Sharing], [`1`],
)

#quiz(
  [In Python ruft `f(1, 1 / 0)` eine Funktion `f(x, y)` auf, die `y` nie benutzt.
  Was passiert?],
  choice(correct: true)[`ZeroDivisionError`][Genau: Python wertet beide Argumente
    aus, bevor `f` läuft (innermost).],
  choice[`f` gibt `1` zurück][Das wäre outermost, wie in Haskell. Python
    rechnet `1 / 0` aber schon vor dem Aufruf aus.],
)

= Selbst auswerten

Jetzt wählst du die Redexe selbst. Klick jeweils auf den Teilausdruck, den die
genannte Strategie als Nächstes auswertet. Ein falscher Klick kostet nichts und
sagt dir, warum er nicht passt.

*Innermost:*

#eval-path("square x = x * x", "square (2 + 3)", rule: "innermost")

*Outermost:*

#eval-path("square x = x * x", "square (2 + 3)", rule: "outermost")

*Outermost mit Sharing:* Das Argument wird beim Einsetzen zu einer `let`-Bindung,
und eine Auswertung zählt für alle Stellen, die es benutzen.

#eval-path("square x = x * x", "square (2 + 3)", rule: "outermostShared")

Bei `double (inc 3)` gibt es mehr Redexe. Hier darfst du jeden Redex wählen
(*frei*); die Karte darunter zeigt alle Wege zum Ergebnis, dazu die Wege der drei
Strategien und deinen eigenen.

#eval-path("inc n = n + 1\ndouble x = x + x", "double (inc 3)", rule: "free", map: true)

#quiz(
  [Ein Rechenweg für `double (inc 3)` beginnt mit `double (inc 3)` und
  `(inc 3) + (inc 3)`. Zu welcher Strategie gehört er?],
  choice(correct: true)[Outermost ohne Sharing][Genau: `double` wird zuerst
    eingesetzt, das Argument `inc 3` steht danach doppelt da und wird zweimal
    ausgewertet.],
  choice[Innermost][Nein: Innermost würde zuerst `inc 3` zu `4` auswerten.],
  choice[Outermost mit Sharing][Nein: Mit Sharing stünde dort eine gemeinsame
    `let`-Bindung und `inc 3` würde nur einmal ausgewertet.],
)

#quiz(
  [Ein anderer Weg für `double (inc 3)`: erst `double 4`, dann `4 + 4`, dann `8`.
  Welche Strategie ist das?],
  choice(correct: true)[Innermost][Genau: Das Argument `inc 3` ist der innerste
    Redex und wird vor dem Aufruf von `double` ausgewertet.],
  choice[Outermost][Nein: Outermost setzt zuerst `double` ein.],
  choice[Outermost mit Sharing][Nein: Der erste Schritt wäre das Einsetzen von
    `double`, nicht die Auswertung von `inc 3`.],
)

#practice("lazy-sharing")
