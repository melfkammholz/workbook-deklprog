Gegeben sind die Datentypen

```haskell
data Maybe a    = Nothing | Just a
data Either a b = Left a | Right b
```

Implementiere die natürlichen Faltungen `foldMaybe` für `Maybe a` und
`foldEither` für `Either a b`. Überlege dir zuerst ihre Typsignaturen. Die
Argumente stehen in der Reihenfolge der Konstruktoren.

#hint[
  Ersetze in den Typen der Konstruktoren jedes Vorkommen von `Maybe a` durch eine
  neue Typvariable `r`. So erhältst du die Typen der Argumente.
  Bei `Just` wird aus `a -> Maybe a` dann `a -> r`.
]
#hint[
  Unterscheide mit einem `case`-Ausdruck die Konstruktoren und übergib die Felder
  an die passende Funktion.
]
#hint[
  ```haskell
  foldMaybe fnothing fjust value =
    case value of
      Nothing -> ...
      Just x  -> ...
  ```
]

#remark[Beide Faltungen gibt es schon im Prelude: `foldMaybe` heißt dort `maybe` und `foldEither` heißt `either`.]
