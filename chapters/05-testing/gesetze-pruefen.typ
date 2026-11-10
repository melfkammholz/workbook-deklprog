Welche dieser Gesetze gelten? Überlege dir zuerst eine Vermutung und prüfe sie dann mit QuickCheck.

+ Addition auf `Int` ist assoziativ: `(a + b) + c == a + (b + c)`
+ Subtraktion auf `Int` ist kommutativ: `a - b == b - a`
+ Subtraktion auf `Int` ist assoziativ: `(a - b) - c == a - (b - c)`
+ Addition auf `Double` ist assoziativ: `(a + b) + c == a + (b + c)`
+ Die Konkatenation von Listen (`[Int]`) ist assoziativ: `(xs ++ ys) ++ zs == xs ++ (ys ++ zs)`
+ `reverse (xs ++ ys) == reverse xs ++ reverse ys` für Listen vom Typ `[Int]`
+ `max` auf `Int` ist assoziativ: `max (max a b) c == max a (max b c)`

Schreibe jedes Gesetz im Editor als Eigenschaft mit expliziter Typsignatur auf, und prüfe sie im Interpreter mit `quickCheck`:

```haskell
import Test.QuickCheck

prop_plusAssoc :: Int -> Int -> Int -> Bool
prop_plusAssoc a b c = (a + b) + c == a + (b + c)
```

```haskell
ghci> quickCheck prop_plusAssoc
```

Wie gehst du mit den falschen Gesetzen um? Ändere sie so ab, dass sie gelten, und prüfe die neue Fassung.

#hint[Bei Nr. 4: Wie werden Zahlen vom Typ `Double` im Rechner gespeichert? Was passiert beim Runden, wenn man die Reihenfolge der Additionen ändert?]
#hint[Nr. 6 stimmt fast: Auf der rechten Seite fehlt eine kleine Änderung.]

#sample[
  Falsch sind 2, 3, 4 und 6. Bei 2 und 3 findet QuickCheck sofort kleine Gegenbeispiele wie `a = 1, b = 0`. Bei 4 liegt
  es daran, dass `Double` nur endlich viele Stellen speichert: Je nach Reihenfolge wird anders gerundet, zum Beispiel
  `(-0.3 + 0.6) + 8.0 /= -0.3 + (0.6 + 8.0)`. Bei 6 gilt `reverse (xs ++ ys) == reverse ys ++ reverse xs`. Die Gesetze
  1, 5 und 7 gelten.
]
