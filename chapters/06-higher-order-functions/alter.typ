In Haskells Prelude gibt es die Funktion
`lookup :: Eq a => a -> [(a, b)] -> Maybe b`, die einen Wert vom Typ
`b` aus einer Liste vom Typ `[(a, b)]` zu einem Schlüssel vom
Typ `a` findet, sofern das entsprechende Tupel in der Liste enthalten
ist. Es gibt allerdings keine Funktion zum Erzeugen, Bearbeiten oder Löschen.
Während man sich im ersten Fall oftmals damit begnügt, ein neues Paar vorne
an die Liste zu packen, sieht es bei den anderen beiden Operationen schon
weniger rosig aus.

Implementiere eine Funktion
`alter :: Eq a => a -> (Maybe b -> Maybe b) -> [(a, b)] -> [(a, b)]`, die
die drei Operationen ausführen kann. Das soll durch die Funktion
`Maybe b -> Maybe b` ermöglicht werden.
- Wenn die Funktion ein `Nothing` erhält, bedeutet das, dass zum gegebenen Schlüssel kein Wert in der ursprünglichen Liste enthalten war.
- Wenn die Funktion dagegen `Just x` erhält, dann ist `x` der
  Wert der unter dem gegebenen Schlüssel ablegt ist.
- Wenn die Funktion ein `Nothing` zurückgibt, dann wird der Wert zum
  gegebenen Schlüssel gelöscht, sofern dieser existierte.
- Wenn die Funktion ein `Just y` zurückgibt, dann wird der Wert
  `y` unter dem gegebenen Schlüssel abgelegt.

Nutze `alter`, um `insert`, `update` und `delete`
zu implementieren.

#remark[
  Für `Data.Map` gibt es diese Funktion ebenfalls unter dem Namen
  #link("https://hackage.haskell.org/package/containers/docs/Data-Map-Strict.html#v:alter")[`alter`].
]
