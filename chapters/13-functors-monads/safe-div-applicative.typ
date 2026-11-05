Gegeben sei diese fehlerhafte Definition einer sicheren Division:
```haskell
safeDiv :: Int -> Int -> Maybe Int
safeDiv x y = Just (div x) <*> Just y
```
Wie können wir diese Implementierung reparieren, ohne `(>>=)` zu
verwenden und die rechte Seite soweit wie möglich zu erhalten?
Wie siehst du an diesem Beispiel, dass Monaden ausdrucksstärker als
applikative Funktoren sind?

#sample[
  ```haskell
  safeDiv :: Int -> Int -> Maybe Int
  safeDiv x y = pure (div x) <*> if y == 0 then Nothing else pure y
  -- oder: safeDiv x y = pure (div x) <*> (guard (y /= 0) *> pure y)
  ```
]
