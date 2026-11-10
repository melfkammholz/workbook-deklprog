// TODO let students define them in the editor first with explicit types
// this eliminates the forward reference and the need to annotate.

Welche dieser Gesetze gelten? Überlege dir zuerst eine Vermutung und prüfe sie dann mit `quickCheck` im Interpreter.
Typangaben wie `(a :: Int)` sind wichtig, siehe die nächste Lektion.

+ Addition auf `Int` ist assoziativ: `(a + b) + c == a + (b + c)`
+ Subtraktion auf `Int` ist kommutativ: `a - b == b - a`
+ Subtraktion auf `Int` ist assoziativ: `(a - b) - c == a - (b - c)`
+ Addition auf `Double` ist assoziativ: `(a + b) + c == a + (b + c)`
+ `(xs ++ ys) ++ zs == xs ++ (ys ++ zs)` für Listen
+ `reverse (xs ++ ys) == reverse xs ++ reverse ys`
+ `max` ist assoziativ: `max (max a b) c == max a (max b c)`

```haskell
ghci> quickCheck (\a b c -> (a + b) + c == (a :: Int) + (b + c))
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
