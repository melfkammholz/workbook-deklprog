Die Funktor-Typkonstruktorklasse ist wie folgt definiert.
```haskell
class Functor f where
  fmap :: (a -> b) -> f a -> f b
```
Welchen kind hat `f`?
