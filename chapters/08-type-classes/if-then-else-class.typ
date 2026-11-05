In nicht streng getypten Programmiersprachen haben wir es oft mit impliziter
Typkonversion zu tun. Implementiere eine Funktion `ifThenElse`, die als
Bedingung Werte beliebiger Typen entgegennehmen kann. Ziel ist es, dass der
folgende Ausdruck ausgewertet werden kann.
```haskell
let a = ifThenElse (0 :: Int) 3 4
    b = ifThenElse [5] 6 7
    c = ifThenElse Nothing 8 9
 in a + b + c  -- 19
```

#remark[
  Theoretisch könnten wir über eine Spracherweiterung des GHC sogar die
  #link("https://ghc.gitlab.haskell.org/ghc/doc/users_guide/exts/rebindable_syntax.html")[Standardimplementierung von bedingten Ausdrücken ersetzen].
  Das wollen wir aber ganz schnell wieder vergessen, genauso wie den Inhalt
  dieses Tests, nachdem wir ihn bearbeitet haben.
]
