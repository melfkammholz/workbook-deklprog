Das Hamming-Gewicht lässt sich effizienter als in #xref("imperative-variables") implementieren.
Betrachte dafür folgende Haskell-Funktion.
```haskell
popcnt :: Int -> Int
popcnt 0 = 0
popcnt w = 1 + popcnt (w .&. (w - 1))
```
Wieso sind `(.&.)` oder `(-)` auf `Int`-Werte anwendbar?
