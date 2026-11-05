Gib für die folgenden Funktionsdefinitionen den allgemeinsten Typ an.
- ```haskell
  f x []     = [x]
  f x (y:ys)
    | x < y     = x : y : ys
    | otherwise = y : f x ys
  ```

- `f = (.) . (.)`
- `f = uncurry const`
