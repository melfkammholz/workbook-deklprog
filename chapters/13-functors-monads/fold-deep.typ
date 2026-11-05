Gegeben ist der Typ
`data Deep a b = Deep [Maybe (Either a (Deep a b))]`.
Die Faltungsfunktion sieht im Wesentlichen so aus.
```haskell
foldDeep :: ([Maybe (Either a r)] -> r) -> Deep a b -> r
foldDeep fdeep (Deep x) = fdeep (f x)
  where fold = foldDeep fdeep
```
Wie können wir
`f :: [Maybe (Either a (Deep a b))] -> [Maybe (Either a r)]`
definieren?

#sample[
  ```haskell
  foldDeep :: ([Maybe (Either a r)] -> r) -> Deep a b -> r
  foldDeep fdeep (Deep x) = fdeep ((fmap . fmap . fmap) fold x)
    where fold = foldDeep fdeep
  ```
]
