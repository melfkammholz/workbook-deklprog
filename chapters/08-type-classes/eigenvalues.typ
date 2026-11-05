Ich möchte versuchen, deine Gedanken zu lesen. Das funktioniert allerdings nur, wenn du #xref("tropical") und #xref("polynomial-roots") erfolgreich gemeistert hast.
Ohh, du denkst auch häufiger über das römische Reich nach. Interessant. Was
sehe ich noch, hmm... ich nehme wahr, dass du so langsam daran zweifelst,
warum du diese Challenges überhaupt machen solltest. Deren Inhalte sind jenseits
des Programmierens kein Inhalt der Vorlesung und die Inhalte sind teilweise
etwas schwierig. Ich kann dich beruhigen, in der Challenge wird es nicht
besser. Es ist aber schön, dass du dich trotzdem dazu entschieden hast
weiterzumachen.

Im Grunde hast du diese Challenge schon fertig. In dieser wollen wir
die Determinante einer Matrix mithilfe der Leibniz-Formel berechnen. Es gilt
$ det(A) = sum_(sigma in S_n) "sgn"(sigma) product_(i=1)^n a_(i,sigma(i)) $
für alle $A in R^(n times n)$, wobei $R$ ein kommutativer Ring ist. Falls du $S_n$ und
$"sgn"$ noch nie gesehen hast, kein Problem,
- $S_n = { sigma : {1, ..., n} -> {1, ..., n} | sigma "bijektiv" }$
  ist die Menge aller Permutationen von ${1, ..., n}$,
- $"sgn"(sigma) = (-1)^("inv"(sigma))$ für alle $sigma in S_n$ und
- $"inv"(sigma) = abs({(i, j) in {1, ..., n}^2 | i < j and sigma(i) > sigma(j) })$
  für alle $sigma in S_n$. $"inv"$ gibt die Anzahl der Fehlstellungen in einer
  Permutationen an.

Kommen wir nun zu unserem Vorhaben.
- Implementiere eine Funktion `det :: Num a => Mat a -> a`, die die
  Determinante einer Matrix mithilfe der Leibniz-Formel berechnet.
  Dafür benötigst du die Funktionen `inv :: (Num b, Ord a) => [a] -> b`
  und `sgn :: (Num b, Ord a) => [a] -> b`.
- Zu guter Letzt, implementiere eine Funktion `eigen :: Integral a => Mat a -> [a]`,
  die die ganzzahligen Eigenwerte der gegebenen Matrix berechnet. Berechne dafür
  die Nullstellen von $det(A - t dot I) in ZZ[t]$. Zum Testen: Die
  Eigenwerte der Matrix $mat(-4, 11, -5; -15, 30, -13; -27, 51, -22)$ sind
  $-1$, $2$ und $3$.

  Glückwunsch, du hast Eigenwerte berechnet! #emoji.face.party

#remark[
  Falls du weitere Matrizen zum Testen generieren möchtest, dann kannst du
  $A = S^(-1) D S$ nutzen, wobei $D in ZZ^(n times n)$ eine Diagonalmatrix und
  $S in "GL"_n (ZZ)$ eine unimodulare Matrix sind. Die Inverse kannst du dir
  mit deiner Sammlung von Funktionen berechnen lassen.

  Hier kannst du wieder `(!!)` und ähnliche Funktionen nutzen, falls du
  die Einschränkung aus #xref("lr-decomposition") noch im Kopf hast.
]
