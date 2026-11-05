Wie übersetzen wir
#align(center)[`do x <- e1; e2` #h(1em) und #h(1em) `do e1; e2`]
in äquivalente Ausdrücke mithilfe von `(>>=)` und `(>>)`?

Wie übersetzen wir diesen etwas größeren Ausdruck?
```haskell
do
  x <- getInt
  y <- getInt
  print (x + y)
  return (x + y)
```
