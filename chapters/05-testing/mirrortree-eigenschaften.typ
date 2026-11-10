Die Funktion `mirrorTree` soll einen blattbeschrifteten Binärbaum spiegeln. 
Dafür werden an jedem Knoten werden der linke und rechte Teilbaum vertauscht.
Gegeben ist eine fehlhafte Implementierung.

```haskell
mirrorTree :: Tree Int -> Tree Int
mirrorTree = id
```

Gehe in kleinen Schritten vor:

+ Schreibe eine Eigenschaft für `mirrorTree`, die diese Implementierung verletzt.
+ Rufe `runTests` auf. Findet QuickCheck ein Gegenbeispiel?
+ Korrigiere `mirrorTree` so, dass das Gegenbeispiel verschwindet, und prüfe erneut.
+ Wiederhole das, bis `mirrorTree` überzeugend richtig ist.

Diesmal sind die Wahlen der Eigenschaften wichtiger. Probiere zum Beispiel diese beiden aus und frage dich, was sie über `mirrorTree` aussagen:

```haskell
mirrorTree (mirrorTree t) == t
sumTree (mirrorTree t) == sumTree t
```

#hint[Eine Eigenschaft, die `id` verletzt, muss beschreiben, _wie_ der Spiegelbaum aussieht. Wie sieht der Spiegelbaum
  eines Knotens `l :+: r` aus, wenn du die Spiegelbäume von `l` und `r` schon kennst?]
#hint[Wenn du nur `mirrorTree (l :+: r) = r :+: l` schreibst, bestehen beide schwachen Eigenschaften oben immer noch.
  Welche Eigenschaft verrät dir, dass der Fehler tiefer im Baum liegt?]

#remark[
  Nicht zu wissen, wie ein Binärbaum gespiegelt wird, könnte einen Job bei
  Google kosten.

  #quote(block: true, attribution: [Max Howell, Erfinder von homebrew auf #link("https://x.com/mxcl/status/608682016205344768")[Twitter]])[
    Google: 90% of our engineers use the software you wrote (Homebrew), but you can't invert a binary tree on a whiteboard so fuck off.
  ]
]
