#import "@preview/cetz:0.5.3"

Oft kommt es vor, dass Berechnungen zustandabhängig verschiedene Ergebnisse
liefern. Zum Beispiel merken wir uns in einer Tiefensuche durch einen
Graph, welche Knoten bereits besucht wurden, damit die Tiefensuche sich nicht
in einem Kreis verläuft. Allgemein können wir solche Berechnungen als
Funktionen vom Typ `s -> (a, s)` auffassen. Sie bekommen ein Zustand
vom Typ `s` und liefern ein Ergebnis vom Typ `a` und einen
(möglicherweise) neuen Zustand (ebenso vom Typ `s`).

Implementiere eine Funktion `sequence :: [s -> (a, s)] -> s -> ([a], s)`,
die Liste zustandabhängiger Berechnungen nimmt und der Reihe nach ausführt.
Es wird dabei ein erster Zustand übergegeben, der die erste Berechnung
anstößt. Das Ergebnis soll der letzte Zustand mit allen Ergebnissen der
Berechnungen sein.

Betrachte folgendes Beispiel:
```haskell
--     Zustand        Ergebnis  neuer Zustand
fib :: (Int, Int) -> (Int     , (Int, Int)   )
fib (f0, f1) = (f0, (f1, f0 + f1))

fibs :: Int -> [Int]
fibs n = fst (sequence (replicate n fib) (0, 1))
```
Hier wird der erste Zustand mit den ersten beiden Fibonacci-Zahlen
initialisiert, also $(0, 1)$. In jedem Schritt wird der Zustand mit der
nächsten Fibonacci-Zahl aktualisiert und die kleinere Fibonacci-Zahl des
Zustands zurückgegeben. Zuletzt projizieren wir mit `fst` das
Ergebnis von `sequence` und verwerfen so den letzten Zustand.

Hier ist der Datenfluss von `sequence` nochmal visualisiert:
#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    // s_0 in
    set-style(mark: (end: ")>"))
    line((-1.0, 0.35), (0.0, 0.35), name: "state0")
    content("state0.mid", padding: 0.25em, anchor: "north", [$s_0$])

    // f_1
    rect((0, 0), (1.0, 1.25))
    content((0.5, 0.625), [$f_1$])

    // y_1 out
    set-style(mark: (end: "o"))
    line((1.0, 0.85), (2.0, 0.85), name: "output1")
    content("output1.mid", padding: 0.25em, anchor: "south", [$y_1$])

    // s_1 out
    set-style(mark: (end: ")>"))
    line((1.0, 0.35), (3.0, 0.35), name: "state1")
    content("state1.mid", padding: 0.25em, anchor: "north", [$s_1$])

    // f_2
    rect((3.0, 0), (4.0, 1.25))
    content((3.5, 0.625), [$f_2$])

    // y_2 out
    set-style(mark: (end: "o"))
    line((4.0, 0.85), (5.0, 0.85), name: "output2")
    content("output2.mid", padding: 0.25em, anchor: "south", [$y_2$])

    // s_2 out with fade out
    set-style(mark: (end: ")>"))
    line((5.0, 0.35), (6.0, 0.35), name: "state2", stroke: (dash: "dotted"))
    content("state2.start", padding: 0.25em, anchor: "north", [$s_2$])
    set-style(mark: (end: none))
    line((4.0, 0.35), (5.0, 0.35))

    // s_(n-1) in with fade in
    line((7.0, 0.35), (8.0, 0.35), stroke: (dash: "dotted"))
    set-style(mark: (end: ")>"))
    line((8.0, 0.35), (9.0, 0.35), name: "stateN-1")
    content("stateN-1.start", padding: 0.25em, anchor: "north", [$s_(n-1)$])

    // f_n
    rect((9.0, 0), (10.0, 1.25))
    content((9.5, 0.625), [$f_n$])

    // y_n out
    set-style(mark: (end: "o"))
    line((10.0, 0.85), (11.0, 0.85), name: "outputN")
    content("outputN.mid", padding: 0.25em, anchor: "south", [$y_n$])

    // s_n out
    set-style(mark: (end: ")>"))
    line((10.0, 0.35), (11.0, 0.35), name: "stateN")
    content("stateN.end", padding: 0.25em, anchor: "north", [$s_n$])
  })
]
Es soll also
`sequence [f1, f2, ..., fn] s0 = ([y1, y2, ..., yn], sn)` gelten.

#remark[
  Diese Implementierung von `sequence` ist ein Spezialfall für die
  #link("https://learnyouahaskell.github.io/for-a-few-monads-more.html#state")[`State`-Monade].
  Mit der Intuition, dass wir hier Berechnungen sequenzieren, sollte es nicht
  überraschend sein, dass `s -> (a, s)` eine Monade ist. Alternativ
  kannst du die `State`-Monade implementieren und das vorimplementierte
  (oder von dir implementierte) Funktion `sequence` verwenden.
]
