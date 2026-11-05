`guard :: MonadZero m => Bool -> m ()` kann genutzt werden, um eine
Berechnung bedingt fehlschlagen zu lassen.
Zum Beispiel können wir mithilfe von `guard` eine sichere Division
definieren.
```haskell
safeDiv :: (Integral a, MonadZero m) => a -> a -> m a
safeDiv a b = guard (b /= 0) >> return (a `div` b)
```

- Implementiere die Funktion `guard :: Bool -> Maybe ()` mit
  `Maybe ()` als konkreten Ergebnistypen.
- Die Typklasse `MonadZero` wird gängigerweise wie folgt definiert.
  ```haskell
  class Monad m => MonadZero m where
    mzero :: m a
  ```
  Zu ihr gehören die folgenden Gesetze.
  ```haskell
  mzero >>= f     = mzero
  m     >>= const mzero = mzero
  ```
  Damit verhält sich `mzero` wie eine "monadische Null" bzw.
  absorbierend bzgl. der Operationen `(>>=)` und `(>>)`.
  Betrachte den folgenden Ausdruck.
  #block[`m1 >> ... >> mzero >> ... >> mn`]
  Was ist das Ergebnis dieses Ausdrucks?
- Implementiere `guard` mit den Gedanken der vorherigen Teilaufgabe.
- Berechne ```hs 1 `safeDiv` 0 :: m Int``` für `Maybe` und `[]`.
  Bevor das möglich ist, benötigst du entsprechende `MonadZero`-Instanzen.

#remark[
  `guard` ist auf Basis von `Alternative` bzw.
  `MonadPlus` implementiert. `MonadZero` ist nicht Teil der
  Standardbibliothek, aber es ist definiert als Teil von `MonadPlus`.
]

#sample[
  ```haskell
  class Monad m => MonadZero m where
    mzero :: m a

  instance MonadZero Maybe where
    mzero = Nothing

  instance MonadZero [] where
    mzero = []

  guard :: MonadZero m => Bool -> m ()
  guard False = mzero
  guard True  = return ()
  ```
]
