Übersetze die gegebenen Funktionen in eine äquivalente Funktion, die keine
list comprehensions verwendet.
- `f xs = [x * 2 | x <- xs, x > 0]`
- `f xs ys = [x + y | x <- xs, y <- ys]`
- `f xs ys = [(x, y) | x <- xs, y <- ys, x < y]`
- `f xss = [x | xs <- xss, length xs > 2, x <- xs, even x]`
- `f xs = [(x, y) | x <- xs, y <- [1..x], even (x + y)]`
- ```hs f xs = [(x, y) | x <- xs, let y = x * x, y `mod` 3 == 0]```
Sobald du die Listenmonade kennst, kannst du diese Aufgabe auch mit ihr lösen.

#sample[
  ```haskell
  -- f xs = [x * 2 | x <- xs, x > 0]
  f xs = map (* 2) (filter (> 0) xs)
  f xs = do
    x <- xs
    guard (x > 0)
    return (x * 2)

  -- f xs ys = [x + y | x <- xs, y <- ys]
  f xs ys = concatMap (\x -> map (x +) ys) xs
  f xs ys = do
    x <- xs
    y <- ys
    return (x + y)

  -- f xs ys = [(x, y) | x <- xs, y <- ys, x < y]
  f xs ys = filter (uncurry (<)) (concatMap (\x -> map (\y -> (x, y)) ys) xs)
  f xs ys = do
    x <- xs
    y <- ys
    guard (x < y)
    return (x, y)

  -- f xss = [x | xs <- xss, length xs > 2, x <- xs, even x]
  f xss = concatMap (filter even) (filter (\xs -> length xs > 2) xss)
  f xss = do
    xs <- xss
    guard (length xs > 2)
    x <- xs
    guard (even x)
    return x

  -- f xs = [(x, y) | x <- xs, y <- [1..x], even (x + y)]
  f xs = filter (even . uncurry (+)) (concatMap (\x -> map (\y -> (x, y)) [1..x]) xs)
  f xs = do
    x <- xs
    y <- [1..x]
    guard (even (x + y))
    return (x, y)

  -- f xs = [(x, y) | x <- xs, let y = x * x, y `mod` 3 == 0]
  f xs = filter (\(_, y) -> y `mod` 3 == 0) (map (\x -> (x, x * x)) xs)
  f xs = do
    x <- xs
    let y = x * x
    guard (y `mod` 3 == 0)
    return (x, y)
  ```
]
