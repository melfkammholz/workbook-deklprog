Die ganzzahligen Nullstellen eines Polynoms $p = sum_(i=0)^d a_i t^i in ZZ[t]$ mit $a_d = plus.minus 1$ lassen sich mithilfe des Satzes über rationale Nullstellen bestimmen. Dieser besagt, dass jede Nullstelle $x$ von $p$ ganzzahlig ist und das Absolutglied $a_0$ teilt. Wenn wir $p$ als Polynomfunktion auffassen, erhalten wir also
$ p(x) = 0 ==> x "teilt" a_0. $
Diese notwendige Bedingung an eine Nullstelle können wir für einen Brute-Force-Algorithmus ausnutzen. Beachte, dass auch negative Teiler und, falls $a_0 = 0$ ist, auch $0$ infrage kommen.

In der Vorlage zur Challenge findest du zusätzliche Hilfsfunktionen, die du
gerne verwenden darfst.

Wir repräsentieren ein ganzzahliges Polynom mit dem Typen
```haskell
data PolyE a = Const a              -- Constant
             | T                    -- Variable
             | PolyE a :+: PolyE a  -- Polynomial addition
             | PolyE a :-: PolyE a  -- Polynomial subtraction
             | PolyE a :*: PolyE a  -- Polynomial multiplication
  deriving (Eq, Show)
```
Der angegebene Typ zusammen mit einer `Num`-Instanz (siehe Vorlage)
erlaubt es uns, Polynome in Haskell hübsch aufzuschreiben. Zum Beispiel
entspricht $(t - 3) dot (t + 2)$ dem Wert `(T - 3) * (T + 2)`. Diese
Darstellung ist für die weitere Verarbeitung allerdings ungeeignet -- besser
eignet sich eine normalisierte Darstellung. Hier wollen wir ein ganzzahliges Polynom durch die Liste seiner Koeffizienten repräsentieren, wobei das $i$-te Element der Liste dem $i$-ten Koeffizienten des Polynoms entspricht, wenn das Polynom die Form $sum_(i=0)^d a_i t^i$ hat. In der Vorlage verpackt der Typ `Poly a` so eine Liste. Zum Beispiel entspricht $2t^2 + 2t - 4$
der Liste `[-4, 2, 2]`.

- Implementiere zuerst die Polynomaddition, -subtraktion und -multiplikation
  für Polynome in Normalform, also Funktionen
  `polyadd, polysub, polymul :: Num a => [a] -> [a] -> [a]`.

  Die Polynomdivision kann als Funktion `polydiv :: Integral a => PolyE a -> PolyE a -> Maybe (PolyE a)` implementiert werden. Diese benötigt im Vergleich zu den anderen Operationen etwas mehr Arbeit.
  Sie ist im Folgenden nicht wichtig, sofern du nicht einen alternativen
  Ansatz zur Berechnung der Nullstellen ausprobieren möchtest.
- Implementiere als Nächstes eine Funktion `fromPolyE :: (Eq a, Num a) => PolyE a -> Poly a`,
  die ein beliebiges Polynom in Normalform bringt. Für die rekursiven
  Konstruktoren können die zuvor definierten Funktionen hilfreich sein.
- Implementiere eine Funktion `horner :: Num a => Poly a -> a -> a`,
  die ein Polynom in Normalform und einen Punkt nimmt, an dem das Polynom
  ausgewertet wird. Nutze dafür das Horner-Schema.
- Implementiere eine Funktion `divisors :: Integral a => a -> [a]`, die alle positiven Teiler einer gegebenen positiven Ganzzahl berechnet.
- Implementiere zuletzt eine Funktion `roots :: Integral a => PolyE a -> [a]`,
  die die ganzzahligen Nullstellen eines Polynoms berechnet.

#remark[
  Wenn du aus irgendeinem Grund richtig Langeweile oder sehr viel Spaß haben solltest, kannst du versuchen, die Polynommultiplikation über die schnelle
  Fourier-Transformation zu berechnen.
]
