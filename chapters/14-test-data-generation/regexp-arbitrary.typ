Gegeben sei folgender Datentyp für reguläre Ausdrücke.
```haskell
data RegExp = Empty
            | Epsilon
            | Let Char
            | RegExp :|: RegExp
            | RegExp :*: RegExp
            | Kleene RegExp

infixl 6 :|:
infixl 7 :*:
```

- Gib eine `Arbitrary`-Instanz für reguläre Ausdrücke an.
- Implementiere eine Funktion `randomWord :: RegExp -> Gen String`, die
  ein Wort generiert, das in der Sprache des regulären Ausdrucks liegt. Für die leere Sprache gibt es kein solches Wort. Sorge deshalb dafür, dass deine `Arbitrary`-Instanz `Empty` nicht erzeugt.
- Implementiere mithilfe des Typen
  #align(center)[`newtype WithPositiveSample = WithPositiveSample (RegExp, String)`]
  eine `Arbitrary`-Instanz, die ein positives Beispiel mit einem
  regulären Ausdruck kombiniert.
- (Wieso ist rejection sampling mit einem Prädikat
  `String -> Bool`#note[Um zu testen, ob ein Wort $w in Sigma^*$ in
  der Sprache $L(R)$ eines regulären Ausdrucks $R$ liegt, kann man z.B.
  $epsilon in w^(-1) L(R)$ testen. Siehe
  #link("https://en.wikipedia.org/wiki/Brzozowski_derivative")[Brzozowski
  derivative].] nicht die beste Idee, um ein negatives Beispiel zu
  generieren? Angenommen du hast den DEA zum regulären Ausdruck, wie könntest
  du dann ein negatives Beispiel finden?)
