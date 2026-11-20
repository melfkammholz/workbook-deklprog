Verwende wieder den Typ `BTree a` aus der vorigen Aufgabe.

Implementiere eine Funktion `replaceMaxRec :: BTree Int -> a -> (BTree a, Int)`, die die beiden Berechnungen (Beschriftungen ersetzen und Maximum bestimmen) _parallel_ in einem Durchlauf ausführt. Nutze `where`-Blöcke oder `let`-Ausdrücke, um auf die Zwischenergebnisse zuzugreifen.

Definiere dann mithilfe von `replaceMaxRec` die Funktion `replaceMax :: BTree Int -> BTree Int`, die alle Beschriftungen in einem Baum durch die größte Beschriftung ersetzt. Der Baum soll dabei nur ein einziges Mal durchlaufen werden.

#hint[`replaceMaxRec` gibt ein Paar zurück: den neuen Baum und das Maximum der alten Beschriftungen. Bei einem `Node` kommen beide Teile aus den rekursiven Aufrufen für den linken und rechten Teilbaum.]
#hint[In `replaceMax` ist das Maximum, das `replaceMaxRec` _berechnet_, zugleich die Beschriftung, die `replaceMaxRec` _einsetzt_. Binde das Paar in einem `where` und verwende die zweite Komponente als Argument des Aufrufs, der sie erzeugt.]
#hint[Zeichne die Abhängigkeiten der Thunks: Das Maximum hängt nur von den alten Beschriftungen ab, nicht vom neuen Baum. Darum gibt es keinen Kreis, obwohl `m` in seiner eigenen Definition vorkommt.]

== Warum das funktioniert

Ein Bang Pattern erzwingt ein Argument und verhält sich dabei wie ein Match auf einen Konstruktor: Auswertung wird nicht nur durch Bang Patterns angestoßen, sondern unter anderem durch Pattern Matching (siehe #xref("lazy-trigger")). Bang Patterns machen das nur explizit. Das Beispiel zeigt, wie der Trick damit kaputtgeht.

```haskell
{-# LANGUAGE BangPatterns #-}

replaceMax :: BTree Int -> BTree Int
replaceMax t = t'
  where
    (t', m) = go t m
    go (Leaf x)     !mm = (Leaf mm, x)   -- forces mm
    go (Node l x r)  mm = ...
```

Im kompilierten Programm bricht `replaceMax` mit `<<loop>>` ab (im Interpreter hängt es). Ein Bang auf dem Ergebnis, `(t', !m) = go t m`, läuft dagegen durch und liefert den richtigen Baum.

#quiz(
  [Warum ergibt `go (Leaf x) !mm` ein `<<loop>>`?],
  choice[Bang Patterns sind in `where`-Blöcken nicht erlaubt.][Sie sind erlaubt, das Programm wird sogar übersetzt.],
  choice(correct: true)[`mm` ist das Maximum, das gerade erst berechnet wird; es zu erzwingen heißt, auf das eigene Ergebnis zu warten.][Genau: `mm` ist `m`, und `m` kommt aus `go t m`, das ohne `mm` nicht weiterkommt.],
  choice[`!mm` macht `go` strikt im Baum.][Der Bang betrifft nur `mm`, nicht den Baum.],
)

Das ist dasselbe Prinzip wie bei #xref("tying-the-knot"): Ein Wert darf in seiner eigenen Berechnung vorkommen, solange niemand ihn auswertet, bevor er fertig ist.
