Wie hängen die Listenmonade und list comprehensions zusammen?
- Schreibe den folgenden Ausdruck
  ```haskell
  do
    x <- [0..10]
    y <- [0..10]
    guard (x + y == 10)
    return (x, y)
  ```
  mithilfe von list comprehensions. Der Wert des ausgerechneten Ausdrucks ist
  #align(center)[
    ```haskell
    [(0, 10), (1, 9), (2, 8), (3, 7), (4, 6), (5, 5),
     (6, 4), (7, 3), (8, 2), (9, 1), (10, 0)]
    ```
  ]
  Anhand des Ergebnisses kannst du dir die Semantik von `guard`
  herleiten (oder schaust dir vorher #xref("guard-monadzero") an).
- Schreibe den folgenden Ausdruck
  ```haskell
  [f | n <- [0..], let f = fib n, f `mod` 2 == 0]
  ```
  mithilfe der Listenmonade.
