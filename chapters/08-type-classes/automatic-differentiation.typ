In dieser Challenge sollst du automatisches Differenzieren im Vorwärtsmodus
mithilfe von (Operator-)Überladung implementieren. Dieser Ansatz des
Differenzierens führt dabei das Differenzieren komplizierter Funktionen auf
einfache, elementare Funktionen zurück.

Wir verwenden folgenden Datentyp: `data D a = D a a`.
Ein Wert vom Typ `D a` enthält einen Funktionswert und die Ableitung
an einer gegebenen Stelle.

Der Kern der Idee ist, Funktionen so zu überladen, dass sie auf
`D a`-Werte angewendet werden können. Angenommen, es sei eine Funktion
`f` und ihre Ableitungsfunktion `f'` gegeben. Dann soll ein
überladenes `f` wie folgt funktionieren
```haskell
f :: D a -> D a
f (D gx dgdx) = D (f gx) (dgdx * f' gx)
```
Der Wert `gx` ist das Ergebnis einer inneren Funktion `g`,
und `dgdx` entspricht deren Ableitung `g'` an der Stelle `x`
(bzw. $(d g)/(d x) (x)$). Die Kettenregel führt dann zu
#align(center)[`(f . g)' x = g' x * f' (g x) = dgdx * f' gx`.]
Nach dem Muster kannst du nun Standardfunktionen überladen. Für die
arithmetischen Operatoren benötigst du an der Stelle deren Ableitungsregeln
(Summenregel, Leibnizregel, usw.)

Implementiere die Typklasseninstanzen `Num`, `Fractional`
und `Floating`.

Mit den folgenden Funktionen kannst du z.B. die erste oder zweite Ableitung
bilden.

```haskell
d1 :: Num a => (D a -> D b) -> a -> b
d1 f x = let (D _ d) = f (D x 1) in d

d2 :: Num a => (D (D a) -> D (D b)) -> a -> b
d2 f x = let (D (D _ _) (D _ d)) = f (D (D x 1) 1) in d
```

#remark[
  Hier ist eine #link("https://de.wikipedia.org/wiki/Differentialrechnung#Zusammenfassung")[Zusammenfassung der Ableitungsregeln].

  Ein vergleichbares Verfahren zum Berechnen von Ableitungen basiert auf den
  #link("https://en.wikipedia.org/wiki/Dual_number#Automatic_differentiation")[dualen Zahlen].
  Alternativ kannst du diesen Ansatz implementieren.
]

#hint[
  Wenn du Anlaufschwierigkeiten hast, helfen dir möglicherweise diese ersten
  Implementierungen weiter.
  ```haskell
  instance Num a => Num (D a) where
    D x1 d1 + D x2 d2 = D (x1 + x2) (d1 + d2)  -- Summenregel
    -- ...

  instance Fractional a => Fractional (D a) where
    -- ...

  instance Floating a => Floating (D a) where
    exp (D x d) = D (exp x) (d * exp x)  -- Kettenregel und exp'(x) = exp(x)
    -- ...
  ```
]

#remark[
  Die Funktionen `d1` und `d2` lassen sich mit einigen Haskell-Spracherweiterungen
  zu einer Funktion für Ableitungen beliebiger Ordnung verallgemeinern. Das geht
  weit über die Vorlesung hinaus. Falls es dich sehr interessiert: #xref("autodiff-any-derivative").
]
