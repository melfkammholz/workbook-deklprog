Die Funktion `toList` soll alle Blatt-Beschriftungen zurückgeben. Dabei soll
die Liste alle Beschriftungen in der Reihenfolge enthalten, wie Blätter in einem
Links-nach-Rechts-Durchlauf besucht werden. Gegeben ist die unsinnige 
Implementierung.

```haskell
toList :: Tree Int -> [Int]
toList = const [1, 2, 3]
```

Dazu sind `sumTree` und `mirrorTree` schon korrekt gegeben. Das macht neue Eigenschaften möglich: Du kannst `toList` in Beziehung zu den anderen Funktionen setzen.

+ Schreibe Eigenschaften für `toList` allein, eine pro Konstruktor.
+ Schreibe Eigenschaften, die `toList` mit `sumTree` verbinden und mit `mirrorTree`.
+ Korrigiere `toList` anhand der Gegenbeispiele.

#hint[Was ist `sum (toList t)` im Vergleich zu `sumTree t`? Und `toList (mirrorTree t)` im Vergleich zu `toList t`?]
#remark[
  Eigenschaften dieser Art heißen auch _Modelleigenschaften_: Eine Funktion wird mit einer anderen verglichen, die wir
  schon kennen und der wir vertrauen.
]
