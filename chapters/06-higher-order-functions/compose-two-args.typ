Gegeben seien die Funktionen
```haskell
f :: d -> a
g :: a -> b -> c
```
sowie die Kompositionsfunktion `(.) :: (b -> c) -> (a -> b) -> a -> c`.

In der Typdefinition von `(.)` scheint das erste Argument, eine
einstellige Funktion zu sein. Ist der Ausdruck
#align(center)[`g . f`]
trotzdem typkorrekt, obwohl `g` eine zweistellige Funktion ist?
Wenn ja, wie werden die Typvariablen -- insbesondere das `c` der
Komposition -- unifiziert?
