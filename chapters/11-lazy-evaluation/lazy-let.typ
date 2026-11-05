Gegeben sei folgender Haskell-Ausdruck.
```haskell
let c = x == 0
    a = u `div` x
    b = 0
 in if c then b else a
```
Der Teilausdruck ```hs a = u `div` x``` erscheint auf dem ersten Blick
problematisch, da `x` Null sein könnte. Wieso stellt das mit
Lazy Evaluation kein Problem dar?
