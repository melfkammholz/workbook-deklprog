Die `Applicative`-Typkonstruktorklasse erlaubt es uns, `fmap`
auf Funktionen mit mehreren Argumenten zu verallgemeinern. Dadurch können wir
#align(center)[
  `(+) <$> Just 1 <*> Just 2` #h(1em) oder #h(1em) `Just (+) <*> Just 1 <*> Just 2`
]
schreiben. Die Operatoren `(<$>)` und `(<*>)` funktionieren
dabei ähnlich wie `($)` -- mit `(<$>)` muss die Funktion nicht
explizit in den entsprechenden `Applicative` gehoben werden.

Ein Typ, der uns konzeptionell auf Ebene der applikativen Funktoren näher an
die gewöhnliche Funktionsapplikation heranführt, ist
#align(center)[`newtype Identity a = Identity { runIdentity :: a }`.]
Implementiere `Functor`-, `Applicative`- und
`Monad`-Instanzen für `Identity`.

Wenn du die Instanzen definierst, solltest du feststellen, dass du im
Wesentlichen nur den enthaltenden Wert aus der `Identity` holst,
verarbeitest und anschließend wieder hereinpackst.
