Mit $ mat(f_(n+1), f_n; f_n, f_(n-1)) = mat(1, 1; 1, 0)^n $ und der binären Exponentiation (#xref("binary-exponentiation")) und `Mat22 Integer` (#xref("mat22")) aus vorherigen Tests kannst du die $n$-te Fibonacci-Zahl in logarithmischer
Laufzeit in $n$ berechnen -- zumindest wenn wir auf beliebig genaue Arithmetik verzichten. Implementiere das Verfahren als Funktion `fib :: Integer -> Integer`.

#remark[
  Da du eine `Num`-Instanz auf `Mat22` definiert hast, kannst
  du den `(^)`-Operator zur binären Exponentiation nutzen.

  Der Autor dieser Aufgabe lädt dich herzlich ein, dir auf der Zunge zergehen
  zu lassen, wie schnell logarithmische Laufzeit ist. Betrachte dafür
  `Mat22 Int`, damit die 64-bit Ganzzahl-Arithmetik verwendet wird, und
  berechne dann die $2^(100000) approx 10^#(calc.round(calc.log(2) * 100000))$-te
  Fibonacci-Zahl. Es kommt zwar das Ergebnis modulo $2^64$ heraus, aber das
  soll keine Rolle spielen. Der Witz an der Stelle ist, dass der teure Schritt
  in der Division des `Integer` des Exponenten im `(^)`-Operator liegt.
  Jetzt stelle dir zum Vergleich vor --- denn ausprobieren und ein Ergebnis
  erhalten, kannst du nicht --- wie lange es mit einem linearen Algorithmus
  dauern würde, dasselbe Ergebnis (modulo $2^64$) zu berechnen.

  #draft-note[Finde lustigen zeitlichen Vergleich.]
]
