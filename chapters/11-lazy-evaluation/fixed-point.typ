Fixpunktverfahren sind iterative Methoden, bei denen eine Funktion wiederholt
auf einen Wert angewendet wird, bis sich ein stabiler Punkt (ein sogenannter
Fixpunkt) ergibt, der sich durch weitere Anwendungen der Funktion nicht mehr
verändert.

Dieses Berechnungsmuster wird durch die Funktion
`iterate :: (a -> a) -> a -> [a]` in der Prelude festgehalten.
Sie berechnet eine unendliche Liste, bestehend aus den Ergebnissen der
wiederholten Anwendungen der übergegebenen Funktion auf den gegebenen Wert.
Das erste Ergebnis ist der gegebene Wert, auf den die Funktion noch nicht
angewendet wurde.

- Implementiere `iterate`.
- Ein klassisches Beispiel für ein Fixpunktverfahren aus der Numerik ist die
  Berechnung der Wurzel mithilfe des Heron-Verfahrens. Es ist gegeben durch
  $ x_0 = a, quad x_(n + 1) = 1/2 (x_n + a/x_n) $ Diese Folge nähert den Wert von $sqrt(a)$ für $a > 0$ mit jedem Folgeglied besser an. Implementiere das Verfahren
  mithilfe von `iterate`. Wähle die erste Näherung $x_(n+1)$, die
  $abs(x_(n+1) - x_n) < epsilon$ erfüllt, für ein gegebenes $epsilon > 0$.
- Implementiere die Fibonacci-Folge als unendliche Liste `fibs :: [Integer]` mithilfe von `iterate`. Du brauchst
  eine Hilfsfunktion, die die Elemente der Ergebnisliste von `iterate`
  projiziert.
- Solange eine Liste Inversionen enthält, d.h., es existieren $i, j$ mit
  $i < j$, sodass $a_i > a_j$ gilt, gilt eine Liste als unsortiert. Das
  schrittweise Entfernen solcher Fehlstellungen führt zu einer sortierten
  Liste.
  - Implementiere eine Funktion `resolve :: Ord a => [a] -> [a]`, die
    eine Fehlstellung findet und sie auflöst, indem sie die Elemente an den
    entsprechenden Positionen tauscht.
  - Implementiere das daraus resultierende Sortierverfahren mithilfe von
    `iterate`.
