Betrachten wir die Typen von `fmap` und `(>>=)`, dann sehen
wir gewisse Ähnlichkeiten.
#align(center)[
  `fmap :: (a -> b) -> f a -> f b` \
  `(>>=) :: m a -> (a -> m b) -> m b`
]
Wie können wir bereits an den Typen sehen, dass `(>>=)` die mächtigere
Funktion der beiden ist? Beziehe in deine Überlegungen ein, dass
#align(center)[
  `fmap f (Right x) = Left y`
]
nie gelten kann. Kann `fmap`, die Struktur in Abhängigkeit
des Wertes vom Typ `a` verändern?
