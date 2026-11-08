Gegeben ist der Datentyp für knoten- und blattbeschriftete Bäume beliebigen
Verzweigungsgrads

```haskell
data Tree a b = Empty
              | Leaf a
              | Node b [Tree a b]
```

Implementiere die natürliche Faltung `foldTree` für `Tree a b`. Überlege dir
zuerst ihre Typsignatur und orientiere dich dabei an den bisherigen Faltungen.
Die Argumente stehen in der Reihenfolge der Konstruktoren.

#hint[
  Ersetze in den Typen der Konstruktoren jedes Vorkommen von `Tree a b` durch eine
  neue Typvariable `r`. So erhältst du die Typen der Argumente.
  Bei `Node` wird aus `b -> [Tree a b] -> Tree a b` dann `b -> [r] -> r`.
]
#hint[
  In der Zeile für `Node x ts` hast du `ts :: [Tree a b]`, die Funktion für `Node`
  will aber eine `[r]`. Welche Funktion vom Typ `(a -> b) -> [a] -> [b]` hilft,
  zusammen mit einem partiell applizierten `foldTree`?
]
#hint[
  ```haskell
  foldTree fempty fleaf fnode value =
    case value of
      Empty     -> fempty
      Leaf x    -> fleaf x
      Node x ts -> fnode x (... foldTree' ts)
    where
      foldTree' = ...
  ```
]

#remark[
  Ein paar Gewohnheiten sparen beim Herleiten von Faltungen das Nachdenken:
  - Die Argumente heißen `f` plus Konstruktorname, etwa `fleaf`.
  - Ein `case`-Ausdruck ist schneller geschrieben, als die linke Seite für jede Regel zu wiederholen.
  - Bei einem rekursiven Typ lohnt sich eine Hilfsfunktion wie `foldTree'`, besonders wenn der Typ an mehreren Stellen rekursiv ist.
]
