Eine Editierdistanz zwischen zwei Wörtern $u in Sigma^m, v in Sigma^n$ können
wir mithilfe der folgenden Rekurrenz bestimmen:
$
"ed"(i, j) = cases(
  0 & quad "falls" (i, j) = (0, 0)\,,
  i & quad "falls" j = 0\,,
  j & quad "falls" i = 0\,,
  "ed"(i - 1, j - 1) & quad "falls" u_(i - 1) = v_(j - 1)\,,
  min("ed"(i - 1, j - 1), "ed"(i, j - 1), "ed"(i - 1, j)) + 1 & quad "sonst"
)
$
für alle $0 <= i <= m, 0 <= j <= n$.
Um $"ed"(m,n)$ effizient auszurechnen, nutzt man dynamische Programmierung.
Das heißt, wir merken uns die Zwischenergebnisse und nutzen diese, wenn wir
sie erneut brauchen, anstatt sie neu zu berechnen und ohne die Optimalität des Ergebnisses zu gefährden.

In Haskell können wir memoization mithilfe von Lazy Evaluation umsetzen. Hier
ist ein unvollständiges Haskell-Programm, das die Editierdistanz berechnen
soll.
```haskell
editdist :: Eq a => [a] -> [a] -> Int
editdist u v = table !! m !! n
  where
    (m, n) = (length u, length v)
    table = [[ed i j | j <- [0..n]] | i <- [0..m]]
```
Die Berechnungen sind in `table` gespeichert.

- Definiere die Funktion `ed :: Int -> Int -> Int` lokal in
  `editdist`. `ed` soll hier die zwischengespeicherten
  Ergebnisse aus `table` verwenden und dadurch die Berechnungen
  anstoßen.
- Überlege dir wie hier laziness und memoization zusammenspielen.
- Welche worst-case Laufzeit hat deine Lösung, wenn du annimmst, dass die
  Laufzeit von `(!!)` konstant ist?
