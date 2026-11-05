Hin und wieder kommt es vor, dass wir Datentypen haben, die von mehreren
Typvariablen abhängen. Zum Beispiel haben wir den Datentyp `Either a b`
(oder `(,)`) kennengelernt. Weiter haben wir gesehen, dass es uns
nur möglich war, eine `Functor`-Instanz für `Either a`
anzugeben. Unter Umständen möchten wir aber sowohl das `a` als auch
`b` auf andere Typen abbilden.

- Überlege dir, wie du die `Functor`-Typkonstruktorklasse für solche
  Typen verallgemeinern kannst. Gib eine konkrete Typkonstruktorklasse und
  Instanzen für `Either` und `(,)` an.
- Wie kannst du `fmap` aus deiner Definition zurückgewinnen?
- Kannst du nun auch eine Funktion `bf a b -> (a -> c) -> bf c b`
  angeben -- also quasi ein `fmap` für den anderen Typen?
