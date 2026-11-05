Die Typklasse `Ord` ist wie folgt definiert:
```haskell
class Eq a => Ord a where
  compare              :: a -> a -> Ordering
  (<), (<=), (>), (>=) :: a -> a -> Bool
  max, min             :: a -> a -> a

  -- default definitions
  -- ...

  {-# MINIMAL compare | (<=) #-}
```
Das `{-# MINIMAL compare | (<=) #-}` bedeutet, dass es genügt,
entweder `compare` oder `(<=)` zu implementieren.
- Gib Standarddefinitionen für die Funktionen der Typklasse an.
- Was ermöglicht es, eine Standarddefinition für `compare` angeben zu
  können?
- Deine Standarddefinition von `compare` ist voraussichtlich
  ineffizient -- die Vordefinierte ist es auch. Woran liegt das? Welche der
  beiden Funktionen würdest du implementieren, wenn du nur eine implementieren
  dürftest und es um die beste Laufzeit ginge?

#remark[
  Standarddefinitionen sind für den Anfang hilfreich, um mit minimalem
  Aufwand alle Funktionen einer Typklasse verwenden zu können. Häufig findet
  man aber konkrete Implementierungen für mehr als nur die notwendigen
  Funktionen, da diese eine bessere Laufzeit haben.
]
