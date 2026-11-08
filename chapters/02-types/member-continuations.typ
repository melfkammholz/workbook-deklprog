Diese Seite gehört zu #xref("brzozowski").

Mithilfe des
#link("https://en.wikipedia.org/wiki/Continuation-passing_style")[continuation-passing style]
lässt sich das Wortproblem auch direkter lösen.

```haskell
member :: RegExp -> String -> (String -> Bool) -> Bool
member Empty         _      _ = False
member Epsilon       s      k = k s
member (Let c)       (x:xs) k = x == c && k xs
member (Let _)       []     _ = False
member (re1 :|: re2) s      k = member re1 s k || member re2 s k
member (re1 :*: re2) s      k = member re1 s (\s' -> member re2 s' k)
member (Kleene re)   s      k =
  k s || member re s (\s' -> s' /= s && member (Kleene re) s' k)
```

Kurz gesagt ist `k` eine continuation bzw. eine Funktion, die das Wortproblem für
das Restwort testet. Sie wird während des Verfahrens konstruiert und an den Stellen
aufgerufen, wo wir Basisfälle oder die Alternative erreichen. Ob das ganze Wort `w`
in der Sprache von `re` liegt, sagt `member re w null`: Am Ende darf nichts übrig
bleiben.

Im Modul "Funktionale Programmierung" behandelt Frank diesen Programmierstil.
