Die `do`-Notation erlaubt es uns, statements der Form `p <- e`
zu schreiben, wobei `p` ein beliebiges Muster sein kann. Zum Beispiel
ist folgender Ausdruck valide und berechenbar.
```haskell
do
  Just x <- [Just 1, Nothing, Just 2]
  return x
```
Der Wert dieses Ausdrucks ist `[1, 2]`.
- In welches Problem läufst du, wenn du diesen Ausdruck mithilfe von
  `(>>=)` und `(>>)` ausdrücken möchtest?
- Wie kannst du das Problem in diesem konkreten Fall beheben?
- Fällt dir möglicherweise eine allgemeine Übersetzungsvorschrift für
  statements dieser Form unter der Verwendung von `MonadFail` aus #xref("eval-errors") ein?

#remark[
  Der Haskell Report spezifiziert in der
  #link("https://www.haskell.org/onlinereport/haskell2010/haskellch3.html#x8-470003.14")[Sektion über die `do`-Notation],
  wie diese übersetzt wird.
]
