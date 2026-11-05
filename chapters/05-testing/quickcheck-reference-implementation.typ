#draft-note[
  Finde ein besseres Beispiel dafür, dass es keine gute Idee ist, eine
  Implementierung mit einer Referenz-Implementierung zu vergleichen, wenn diese
  sich nicht wesentlich unterscheiden (Fehler in beiden Implementierungen).
]

Gegeben sei folgendes Haskell-Programm.
```haskell
data Rose a = Rose a [Rose a]

sumRose :: Rose Int -> Int
sumRose (Rose x ts) = x + sumSubtrees ts
  where
    sumSubtrees []     = 0
    sumSubtrees (t:ts) = sumRose t + sumSubtrees ts

prop_sum :: Rose Int -> Bool
prop_sum t = sumRose t == sumRose' t
  where
    sumRose' :: Rose Int -> Int
    sumRose' (Rose x ts) = x + sumSubtrees' ts
      where
        sumSubtrees' []     = 0
        sumSubtrees' (t:ts) = sumRose' t + sumSubtrees' ts
```
Bewerte dieses Programm hinsichtlich `prop_sum`. Ist die Referenz-Implementierung
`sumRose'` geeignet gewählt? Wie könnte `sumRose` besser getestet werden?#note[Die
Funktion ist vergleichsweise einfach, sodass Referenz-Implementierungen vermutlich
sehr dicht an der tatsächlichen Implementierung liegen werden. Für komplexere
Algorithmen ist der Vergleich mit einer Referenz-Implementierung geeigneter.]
