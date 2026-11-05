Sei $m, n in NN$. Gegeben seien
- die Identitätsfunktion auf ${0, ..., n - 1}$ mit
  $pi_0 : {0, ..., n - 1} -> {0, ..., n - 1}, x |-> x$ und
- eine endliche Folge von Paaren $((a_i, b_i))_(i in {1, ..., m})$ mit
  $a_i in {0, ..., n - 1}, b_i in {0, ..., n - 1}$ für alle
  $i in {1, ..., m}$.

Wir definieren $pi_(i,j)$ als
$
pi_(i,j) (k) = cases(
  i & quad "falls" k = j,
  j & quad "falls" k = i,
  k & quad "sonst"
)
$
für alle $k in {0, ..., n - 1}$.

Wir betrachten die Paare als Vertauschungen der Bilder der Abbildung
$pi_0$, d.h., $ pi_i = pi_(a_i, b_i) compose pi_(i - 1) "für" i in {1, ..., m}. $
- Implementiere eine Funktion `swaps :: Int -> [(Int, Int)] -> [Int]`,
  die $pi_m$ mithilfe von Listen berechnet. Der erste Parameter bestimmt die
  Menge ${0, ..., n - 1}$ und der zweite die Folge.
- Implementiere eine Funktion
  `swaps' :: Int -> [(Int, Int)] -> Int -> Int`, die $pi_m$
  mithilfe von Funktionen berechnet. (Hier ist der erste Parameter unter
  Umständen redundant.)
- Welche Vor- und Nachteile haben die jeweiligen Ansätze im Vergleich?
