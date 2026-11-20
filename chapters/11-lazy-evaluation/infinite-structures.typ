Unendliche Datenstrukturen sind in Haskell nicht exotisch: Man baut nur so viel
davon auf, wie jemand anfragt. Hier sind drei Beispiele, in denen das gut
funktioniert, und eins, in dem es das nicht tut.

= Fibonacci-Zahlen aus sich selbst

```haskell
fib :: [Integer]
fib = 0 : 1 : zipWith (+) fib (tail fib)
```

`fib` kommt in der eigenen Definition vor. Das funktioniert, weil die ersten
beiden Elemente ohne jede Rechnung bekannt sind; ab dann liefert `zipWith (+)`
jedes weitere Element aus zwei früheren. `take 10 fib` ergibt
`[0,1,1,2,3,5,8,13,21,34]`.

#steps(
  step(label: "Startwerte")[
    ```haskell
    fib == 0 : 1 : ...
    tail fib == 1 : ...
    ```
  ],
  step(label: "Das dritte Element")[
    ```haskell
    zipWith (+) (0 : 1 : ...) (1 : ...)
      == (0 + 1) : zipWith (+) (1 : ...) (...)
    ```
    Das dritte Element ist `0 + 1`, es braucht nur die beiden Startwerte.
  ],
  step(label: "Das vierte Element")[
    ```haskell
    fib == 0 : 1 : 1 : ...
    tail fib == 1 : 1 : ...
    ```
    Jetzt ist ein weiteres Element bekannt, aus dem das nächste entsteht.
  ],
)

#quiz(
  [Was passiert bei `fib = 0 : zipWith (+) fib (tail fib)` (ein Startwert) und
  `fib !! 1`?],
  choice(correct: true)[Die Rechnung hängt (oder GHC meldet `<<loop>>`)][Genau: Für das zweite Element braucht `zipWith` den Kopf von `tail fib`, also das zweite Element von `fib`. Das ist das Element, das gerade berechnet wird.],
  choice[`0`][Nein: `zipWith (+)` addiert zwei Listenelemente, das zweite gibt es noch nicht.],
  choice[`1`][Nein: Es gibt nichts, was zu `1` führen würde.],
)

Die Startwerte müssen also so viele sein, wie die Definition zurückgreift:
`fib` greift zwei Elemente zurück, braucht also zwei Startwerte. Mit zwei
anderen Startwerten, etwa `fib = 2 : 1 : zipWith (+) fib (tail fib)`, entstehen
die Lucas-Zahlen.

= Ein Akkumulator, der unendlich wächst

Anders sieht es aus, wenn man eine unendliche Struktur in einem Akkumulator
aufbauen will. `foldl` läuft erst durch die _ganze_ Liste, bevor es ein Ergebnis
gibt. Bei einer unendlichen Liste gibt es also nie eins, auch wenn der Akkumulator
lazy ist und man nur das erste Element des Ergebnisses haben möchte:

```haskell
take 3 (foldl (flip (:)) [] [1 ..])   -- hängt
take 3 (foldr (:) [] [1 ..])          -- [1,2,3]
```

`foldr` gibt `1 :` aus, bevor es den Rest der Liste ansieht; `foldl` kommt nie
beim Ergebnis an. Unendliche Strukturen baut man deshalb mit `foldr`, `map`,
`iterate` oder Rekursion auf, die vorne Konstruktoren liefert.

#practice("foldl-infinite")

= Sieb des Eratosthenes

```haskell
primes :: [Int]
primes = sieve [2 ..]
  where
    sieve (p : xs) = p : sieve [x | x <- xs, x `mod` p /= 0]
```

Das ist elegant, aber nur nach dem Vorbild des Siebs: Es probiert jede Zahl gegen
alle bisherigen Primzahlen durch und ist deutlich langsamer als das echte Sieb
des Eratosthenes, das Vielfache streicht.

#practice("sundaram")
