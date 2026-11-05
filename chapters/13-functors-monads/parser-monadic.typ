Wenn du nochmal einen genaueren Blick auf ein Paar der Funktionen wirfst,
die wir in unserem Parser-Code verwendet haben, dann könnte dir im Kontext
dieses Kapitels etwas auffallen. Hier sind zwei Funktionen, die wir
insbesondere hervorheben möchten.

```haskell
succeed :: a -> Parser a
succeed x = \s -> [(x, s)]

andThen :: Parser a -> (a -> Parser b) -> Parser b
andThen p k = concatMap (uncurry k) . p
```

Arbeite deinen bisherigen Code so um, dass anstatt des Typs
`type Parser a = String -> [(a, String)]` nun
#align(center)[`newtype Parser a = Parser { getParser :: String -> [(a, String)] }`]
verwendet wird und implementiere `Functor`-, `Applicative`- und
`Monad`-Instanzen für den neuen Typen. (Falls du #xref("guard-monadzero") gemacht hast, kannst du auch diese nutzen, um `failure` in diese Typklasse auszulagern. Ebenso kannst du dir `Alternative` bzw. `MonadPlus`
anschauen, um Alternation zu implementieren.)
