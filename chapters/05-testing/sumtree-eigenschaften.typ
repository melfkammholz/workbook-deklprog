Wir verwenden den Datentyp für Binärbäume mit Werten in den Blättern. Gegeben
ist eine unsinnige Implementierung von `sumTree`, die die Summe aller Zahlen
im Baum berechnen soll:

```haskell
data Tree a = Leaf a | Tree a :+: Tree a

sumTree :: Tree Int -> Int
sumTree _ = 0
```

Gehe in kleinen Schritten vor:

+ Schreibe eine Eigenschaft für `sumTree`, die diese Implementierung verletzt.
+ Rufe `runTests` auf. Findet QuickCheck ein Gegenbeispiel?
+ Korrigiere `sumTree` so, dass das Gegenbeispiel verschwindet, und prüfe erneut.
+ Wiederhole das, bis `sumTree` überzeugend richtig ist.


#hint[
  Ein Baum hat zwei Konstruktoren. Schreibe für jeden eine Eigenschaft: Was ist `sumTree (Leaf x)`? Was ist `sumTree (l :+: r)`, wenn du `sumTree l` und `sumTree r` kennst?
]
#hint[
  Funktioniert die Eigenschaft für den Knoten schon bei der unsinnigen
  Implementierung? Probiere es aus. Warum besteht sie? Sobald du den Fall `Leaf`
  korrigiert hast, ändert sich das.
]
#remark[
  Hängt ein Test, oder ist ein Gegenbeispiel riesig, liegt das am Generator der Bäume, siehe #xref("quickcheck-generatoren"). Brich ab und starte `runTests` erneut.
]
