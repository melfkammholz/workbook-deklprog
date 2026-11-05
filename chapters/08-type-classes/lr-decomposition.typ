#let bA = $bold(upright(A))$
#let bL = $bold(upright(L))$
#let bR = $bold(upright(R))$
#let ba = $bold(upright(a))$
#let bb = $bold(upright(b))$
#let be = $bold(upright(e))$
#let bx = $bold(upright(x))$
#let by = $bold(upright(y))$
#let b0 = $bold(upright(0))$

Das Abenteuer geht weiter. In #xref("tropical") haben wir ganz nebenbei einen Matrixring implementiert. Dabei haben wir Matrizen mithilfe des Typen
`newtype Mat a = Mat [[a]]` dargestellt. Ein wichtiger Algorithmus in der
numerischen Mathematik ist die #link("https://en.wikipedia.org/wiki/LU_decomposition")[LR-Zerlegung]
einer Matrix $bA in K^(n times n)$, wobei $K$ ein Körper ist.
$bA$ hat eine LR-Zerlegung, falls Matrizen $bL, bR in K^(n times n)$
existieren, sodass $bA = bL dot bR$ gilt, und $bL$ eine untere Dreiecksmatrix
und $bR$ eine obere Dreiecksmatrix sind. Sie kann unter anderem genutzt
werden, um die Regularität von $bA$ festzustellen, lineare Gleichungssysteme zu
lösen oder die Determinante von $bA$ zu berechnen.

In dieser Challenge wollen wir die LR-Zerlegung berechnen. Um die Aufgabe einfach
  zu halten, verzichten wir auf Zeilenvertauschungen. Dadurch gibt es reguläre
  Matrizen wie $mat(0, 1; 1, 0)$, für die unser Verfahren keine Zerlegung findet.
  Wir betrachten im Folgenden deshalb nur Matrizen, die entweder singulär sind oder
  ohne Zeilenvertauschungen auskommen.

  Die LR-Zerlegung lässt sich induktiv wie folgt berechnen:
- Die LR-Zerlegung einer Matrix $bA = (a_(1 1)) in K^(1 times 1)$ mit $a_(1 1) != 0$ ist gegeben durch
  $bL = (l_(1 1)) = (1) in K^(1 times 1)$ und
  $bR = (r_(1 1)) = (a_(1 1)) in K^(1 times 1)$.
  Jeder Eintrag der Hauptdiagonale von $bL$ wird per Konvention auf $1$ gesetzt.
  Hier sehen wir leicht, dass $bA = bL dot bR$ gilt.
- Seien nun $a_(1 1) in K without {0}$, $bA_(1 *) in K^(1 times (n - 1))$,
  $bA_(* 1) in K^((n - 1) times 1)$ und $bA_(**) in K^((n - 1) times (n - 1))$,
  wobei für $bA_(**) - 1/(a_(1 1)) bA_(* 1) bA_(1 *)$ eine LR-Zerlegung $(bL_(**), bR_(**))$ existiere. Wir betrachten dann
  $ bA = mat(a_(1 1), bA_(1 *); bA_(* 1), bA_(**)). $
  Wir suchen jetzt
  $
  bL = mat(l_(1 1), bL_(1 *); bL_(* 1), bL_(**))
  quad "und" quad
  bR = mat(r_(1 1), bR_(1 *); bR_(* 1), bR_(**)),
  $
  wobei $l_(1 1), r_(1 1) in K$, $bL_(1 *), bR_(1 *) in K^(1 times (n - 1))$ und $bL_(* 1), bR_(* 1) in K^((n - 1) times 1)$ sind, sodass $bA = bL dot bR$
  gilt. Die Matrix-Multiplikation funktioniert für diese Blockmatrizen
  genauso wie für Zahlen. Das heißt, es soll
  $
  bL dot bR
  =& mat(l_(1 1), bL_(1 *); bL_(* 1), bL_(**)) dot mat(r_(1 1), bR_(1 *); bR_(* 1), bR_(**)) \
  =& mat(
      l_(1 1) dot r_(1 1) + bL_(1 *) dot bR_(* 1), l_(1 1) dot bR_(1 *) + bL_(1 *) dot bR_(**);
      bL_(* 1) dot r_(1 1) + bL_(**) dot bR_(* 1), bL_(* 1) dot bR_(1 *) + bL_(**) dot bR_(**);
    ) \
  =& mat(a_(1 1), bA_(1 *); bA_(* 1), bA_(**)) \
  =& bA
  $
  gelten. Nun wissen wir, dass $bL_(1 *) = b0, bR_(* 1) = b0$ und $l_(1 1) = 1$ sind,
  da $bL$ und $bR$ untere und obere Dreiecksmatrizen sind und durch die
  festgelegte Konvention, die Diagonalelemente von $bL$ festgelegt sind.
  Damit erhalten wir folgende Gleichungen:
  $
    r_(1 1) = a_(1 1),
    quad
    bR_(1 *) = bA_(1 *),
    quad
    bL_(* 1) = 1/(a_(1 1)) bA_(* 1)
    $
    und
    $
    bL_(**) bR_(**) = bA_(**) - bL_(* 1) bR_(1 *).
    $

Nutze in keiner deiner Funktionsdefinitionen `(!!)` oder `(!?)`
und versuche stattdessen, geschickt pattern matching zu nutzen, um auf die Einträge zuzugreifen.
- Implementiere eine Funktion `lu :: (Eq a, Fractional a) => Mat a -> Maybe (Mat a, Mat a)`,
  die eine LR-Zerlegung berechnet, sofern unser Verfahren für die gegebene Matrix eine findet. Das ist genau dann der Fall, wenn $a_(1 1) != 0$ in jedem Schritt ist.
- Die Determinante einer Dreiecksmatrix ist das Produkt der Diagonaleinträge.
  Nach dem Determinantenmultiplikationssatz folgt dann
  $ det(bA) = det(bL bR) = det(bL) det(bR) = det(bR) = product_(i=1)^n r_(i i). $
  Implementiere eine Funktion `det :: (Eq a, Fractional a) => Mat a -> a`,
  die die Determinante einer gegebenen Matrix berechnet. Beachte, dass unter unserer Annahme von oben `lu` genau dann `Nothing` liefert, wenn $bA$ nicht regulär ist -- was bedeutet das für die Determinante?
- Weiter lassen sich lineare Gleichungssysteme besonders einfach lösen, wenn
  $bA$ in $bA bx = bb$ in unterer oder oberer Dreiecksgestalt ist. Auch hier
  können wir ein rekursives Verfahren angeben. Betrachte
  $ mat(l_(1 1), 0; bL_(* 1), bL_(**)) vec(x_1, bx_*) = vec(b_1, bb_*). $
  Dann ist $x_1 = b_1$, da $l_(1 1) = 1$ ist. Wir berechnen $bx_*$ nun, indem wir $bL_(**) bx_* = bb_* - x_1 bL_(* 1)$ lösen. Das wiederholen wir, bis
  der triviale Fall erreicht ist. Analog können wir $bR bx = bb$ lösen.
  Implementiere dann die Funktionen `forward :: Fractional a => Mat a -> Mat a -> Mat a`
  und `backward :: Fractional a => Mat a -> Mat a -> Mat a`, die jeweils $bL bx = bb$
  und $bR bx = bb$ lösen.
- Jetzt können wir lineare Gleichungssysteme lösen, in denen $bA$ regulär ist.
  Dafür wollen wir folgende Beobachtung nutzen:
  $ bA bx = bL bR bx = bb quad <==> quad bR bx = by and bL by = bb. $
  Implementiere eine Funktion `solve :: (Eq a, Fractional a) => Mat a -> Mat a -> Maybe (Mat a)`, die die Lösung eines linearen Gleichungssystems findet, sofern `lu` eine Zerlegung findet. Hier kannst du
  annehmen, dass der zweite Parameter, also $bb$, die Form $(n times 1)$ hat.
  Je nachdem wie du die folgende Teilaufgabe lösen möchtest, kann hier aber
  auch $(n times m)$ annehmen.
- Die Inverse einer Matrix kann durch das Lösen linearer Gleichungssysteme
  berechnet werden. Seien $tilde(ba)^((1)), ..., tilde(ba)^((n))$ die Spalten
  von $bA^(-1)$ und $be^((1)), ..., be^((n))$ die Einheitsvektoren des $K^n$.
  Dann erhalten wir $tilde(ba)^((i))$ durch das Lösen von
  $bA tilde(ba)^((i)) = be^((i))$. Implementiere eine Funktion
  `inv :: (Eq a, Fractional a) => Mat a -> Maybe (Mat a)`, die die Inverse
  einer regulären Matrix berechnet.

#remark[
  Nimm am besten an, dass die Verantwortung bei der Person, die mit den
  Funktionen arbeiten möchte, liegt zu prüfen, dass die Dimensionen der
  Matrizen passen.

  // Einen Lösungsvorschlag für diese Challenge findest du unter
  // #link(git("blob/main/src/solutions/linalg.hs"), raw("linalg.hs")).
]
