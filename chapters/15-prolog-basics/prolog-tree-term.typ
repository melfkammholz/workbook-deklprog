In Prolog können wir Termstrukturen erzeugen. Der Haskell-Typ
#align(center)[```haskell data Maybe a = Nothing | Just a```]
kann z.B. wie folgt in Prolog umgesetzt werden.
```prolog
maybe(nothing).
maybe(just(_)).
```
Übersetze mit der gleichen Idee den Datentyp
#align(center)[```haskell data Tree a = Empty | Node (Tree a) a (Tree a)```.]
