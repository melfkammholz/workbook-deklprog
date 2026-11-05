#draft-note[
  Symbolisches Differenzieren baut auf der Auswertung eines arithmetischen
  Ausdrucks auf. Diese wird oft als Beispiel genutzt, um die `Maybe`-Monade
  heranzuführen. Diese soll dort die Division durch Null auffangen. Hier ignorieren
  wir dies. Hier geht es im Wesentlichen um das Absteigen eines baumartigen
  Datentyps mithilfe einer induktiv definierten Funktion.
]

Die Ableitung einer Funktion $f : RR -> RR$ kann mithilfe des
Differenzenquotienten $(f(x+h)-f(x))/h$ für kleines $h$ approximiert werden.
Eine andere Methode zur Berechnung der Ableitung ist symbolisches Differenzieren
und ähnelt dem, wie wir händisch Ableitungen berechnen.
Eine Funktion sei dargestellt durch den folgenden Typ:
```haskell
data Fun = X            -- x     (Variable x)
         | E            -- e     (Euler's constant)
         | Num Double   -- c     (Constant)
         | Ln Fun       -- ln    (Natural logarithm)
         | Fun :+: Fun  -- f + g (Addition)
         | Fun :-: Fun  -- f - g (Subtraction)
         | Fun :*: Fun  -- f * g (Multiplication)
         | Fun :/: Fun  -- f / g (Division)
         | Fun :<: Fun  -- f o g (Composition)
         | Fun :^: Fun  -- f ^ g (Exponentiation)

-- Example
f :: Fun
f = (E :^: X) :<: (X :*: X)  -- (e^x) o (x * x) = e^(x^2)

-- Example
g :: Fun
g = let x = X
         x2 = x :*: x
         x3 = x2 :*: x
      in x3 :+: x2 :+: x :+: Num 1.0  -- x^3 + x^2 + x + 1
```
- Gib die Funktion $sigma(x) = 1/(1+e^(-x))$ als Wert des Typs `Fun`
  an.
- Implementiere eine Funktion `($$) :: Fun -> Double -> Double`, die
  eine gegebene Funktion in einem gegebenen Punkt auswertet.
- Implementiere eine Funktion `derive :: Fun -> Fun`, die eine
  gegebene Funktion ableitet. Die Funktionen müssen nach dem Ableiten nicht
  vereinfacht werden.

#remark[
  Hier findest du eine
  #link("https://de.wikipedia.org/wiki/Differentialrechnung#Zusammenfassung")[Zusammenfassung der Ableitungsregeln].
]
