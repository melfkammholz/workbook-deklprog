Um zu verifizieren, dass die `Functor`-Gesetze für z.B. den Typ
`Maybe a` gelten, müssen wir
- das Identitätsgesetz `fmap id = id` und
- das Kompositionsgesetz `fmap f . fmap g = fmap (f . g)`
zeigen. Wie gehen wir konkret für den gegebenen Typ vor? Wie zeigen wir
die Gleichheit von Funktionen? Wenn wir die Gesetze nun für den Listendatentypen
`[a]` zeigen wollen, was ändert sich an deinem Vorgehen?
