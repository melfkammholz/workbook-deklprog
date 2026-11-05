Das #link("https://de.wikipedia.org/wiki/Gradientenverfahren")[Gradientenverfahren]
sucht ein lokales Minimum einer Funktion. Dafür benötigen wir die erste Ableitung.
Du kannst sie mithilfe des Differenzenquotienten approximieren oder die Lösung von
#xref("symbolic-differentiation") oder #xref("automatic-differentiation") nutzen.

Eine vereinfachte Iterationsvorschrift des Verfahrens ist gegeben durch
$ x_(k + 1) = x_k - 3 dot 10^(-4) dot f'(x_k) quad "für alle" k in NN $
und einen Startpunkt $x_0 in RR$. Implementiere das Verfahren mithilfe von `iterate`
als Funktion `minimize :: (Double -> Double) -> Double -> Double`, die die Ableitung
und den Startpunkt nimmt. Wähle als Ergebnis die erste Näherung $x_(n+1)$, die
$abs(x_(n+1) - x_n) < epsilon$ für $epsilon = 10^(-5)$ erfüllt.

#remark[Schau dir für `iterate` #xref("fixed-point") an.]
