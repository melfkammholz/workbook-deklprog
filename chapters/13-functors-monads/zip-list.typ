Gegeben sei der Datentyp
#align(center)[
  `newtype ZipList a = ZipList { getZipList :: [a] }`.
]
Das Ziel ist es, `ZipList` als $n$-stellige Generalisierung von
`zipWith` zu verwenden:
#align(center)[`f <$> ZipList xs1 <*> ... <*> ZipList xsN`]

- Implementiere eine `Functor`-Instanz für `ZipList`.
- Bevor du eine `Applicative`-Instanz für `ZipList`
  implementierst, überlege warum
  ```haskell
  pure :: a -> ZipList a
  pure x = ZipList [x]
  ```
  keine gültige Definition ist? Welche Gesetze wären verletzt und warum, würde
  man `pure` so definieren?
- Implementiere eine `Applicative`-Instanz für `ZipList`.
- Zeige, dass sowohl die `Functor`- als auch die
  `Applicative`-Instanz die üblichen geforderten Gesetze erfüllen.

#remark[
  Das Umwickeln eines Typen mit `newtype`, für den wir bereits
  Typklasseninstanzen haben, ist ein gängiger Trick, um alternative Instanzen
  für diese Typklassen bereitzustellen.

  `ZipList` hat keine Monaden-Instanz.
]

#hint[
  Das Identitätsgesetz wäre verletzt, wenn man `pure` wie gegeben
  definieren würde. Betrachte folgendes Gegenbeispiel.
  #align(center)[
    ```haskell
       pure id      <*> ZipList [1, 2]
    == ZipList [id] <*> ZipList [1, 2]
    == ZipList [1]
    /= ZipList [1, 2]
    ```
  ]
  Es muss also dafür gesorgt sein, dass es genügend `id`s in der linken
  `ZipList` gibt.
]

#sample[
  ```haskell
  instance Functor ZipList where
    fmap f = ZipList . fmap f . getZipList

  instance Applicative ZipList where
    pure = ZipList . repeat
    zfs <*> zxs = ZipList (zipWith ($) (getZipList zfs) (getZipList zxs))

  -- Functor, Identität
  --   fmap id (ZipList xs)
  -- = ZipList (fmap id (getZipList (ZipList xs)))
  -- = ZipList (fmap id xs)
  -- = ZipList xs
  -- = id (ZipList xs)

  -- Functor, Komposition
  --   fmap (f . g) (ZipList xs)
  -- = ZipList (fmap (f . g) xs)
  -- = ZipList (fmap f (fmap g xs))
  -- = fmap f (ZipList (fmap g xs))
  -- = fmap f (fmap g (ZipList xs))
  -- = (fmap f . fmap g) (ZipList xs)

  -- Applicative, Identität
  --   pure id <*> ZipList xs
  -- = ZipList (repeat id) <*> ZipList xs
  -- = ZipList (zipWith ($) (repeat id) xs)
  -- = ZipList (($) id x1 : ($) id x2 : ... : ($) id xn : [])
  -- = ZipList xs

  -- Applicative, Komposition
  --   pure (.) <*> ZipList fs <*> ZipList gs <*> ZipList xs
  -- = ZipList (repeat (.)) <*> ZipList fs <*> ZipList gs <*> ZipList xs
  -- = ZipList (map (.) fs) <*> ZipList gs <*> ZipList xs
  -- = ZipList (zipWith (.) fs gs) <*> ZipList xs
  -- = ZipList (zipWith ($) (zipWith (.) fs gs) xs)
  -- = ZipList (f1 (g1 x1) : f2 (g2 x2) : ... : fn (gn xn) : [])
  -- = ZipList (zipWith ($) fs (zipWith ($) gs xs))
  -- = ZipList fs <*> ZipList (zipWith ($) gs xs)
  -- = ZipList fs <*> (ZipList gs <*> ZipList xs)

  -- Applicative, Homomorphismus
  --   pure f <*> pure x
  -- = ZipList (repeat f) <*> ZipList (repeat x)
  -- = ZipList (zipWith ($) (repeat f) (repeat x))
  -- = ZipList (repeat (f x))
  -- = pure (f x)

  -- Applicative, Interchange
  --   ZipList fs <*> pure y
  -- = ZipList (zipWith ($) fs (repeat y))
  -- = ZipList (f1 y : f2 y : ... : fn y : [])
  -- = ZipList (zipWith ($) (repeat ($ y)) fs)
  -- = pure ($ y) <*> ZipList fs
  ```
]
