`(++) :: [a] -> [a] -> [a]` wird verwendet, um zwei Listen
aneinanderzuhängen. Wenn wir eine Funktion induktiv über den Listentypen
definieren wie z.B. `square :: [Int] -> [Int]`, die jeden Listeneintrag
quadrieren soll, dann können wir das wie folgt tun.
```haskell
square :: [Int] -> [Int]
square []     = []
square (x:xs) = [x * x] ++ square xs
```
Die Funktion ist zwar korrekt, aber nicht Haskell-idiomatisch, d.h., eine
Person, die erfahren im Programmieren von Haskell ist, würde dies nicht so
schreiben. Was müssten wir an der Funktion ändern, damit sie idiomatisch wäre?
