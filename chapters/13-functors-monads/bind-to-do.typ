Wie übersetzen wir die Ausdrücke
#align(center)[
  ```haskell
  eval e1 >>= \x -> eval e2
          >>= \y -> if y == 0
                      then Nothing
                      else return (x + y)
  ```
]
und
#align(center)[
  ```haskell
  getLine >> read <$> getLine
          >>= \x -> case f x of
                      Nothing -> return 0
                      Just _  -> return x
  ```
]
in einen äquivalenten Ausdruck mithilfe der `do`-Notation?
