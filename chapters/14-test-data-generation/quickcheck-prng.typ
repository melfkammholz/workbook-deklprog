Bevor du diese Challenge bestreitest, sage #xref("quickcheck-simple") den Kampf an!

Während QuickCheck #link("https://dl.acm.org/doi/10.1145/2660193.2660195")[SplitMix64]
als Pseudozufallszahlengenerator nutzt, nutzen wir ein einfacheres Verfahren,
um solche Zahlen zu erzeugen.
#link("https://en.wikipedia.org/wiki/Xorshift")[Xorshift] erzeugt
Pseudozufallszahlen nach dem folgenden Schema:
$
x &<- x plus.o (x << 13) \
x &<- x plus.o (x >> 7) \
x &<- x plus.o (x << 17) \
$
wobei $x$ eine 64-Bit Ganzzahl ist.

- Implementiere eine Funktion `xorshift64 :: Word64 -> Word64`, die das
  obige Verfahren umsetzt. Folgende imports könnten hilfreich sein. Werte vom
  Typ `Word64` können direkt mit den Bit-Operationen verwendet werden.
  Wir nutzen den Typ `Word64`, weil für diesen im Gegensatz zum
  `Int` garantiert ist, dass dieser 64-Bit hat. Wir gehen danach aber
  wieder direkt zum Typ `Int`.
  ```haskell
  import Data.Bits (shiftL, shiftR, xor)
  import Data.Word (Word64)
  ```

Eine zufällige Ganzzahl kann nun mithilfe der Funktion `nextInt`
generiert werden. Ein Zufallszahlengenerator kann mit der Funktion
`mkPRNG` erzeugt werden. Dieser muss mit einer Zahl (seed)
initialisiert werden.
```haskell
data PRNG = PRNG Word64
  deriving Show

mkPRNG :: Word64 -> PRNG
mkPRNG s = PRNG (xorshift64 s)

nextInt :: PRNG -> (Int, PRNG)
nextInt (PRNG s) = (fromIntegral r, PRNG r)
  where r = xorshift64 s
```

Damit der Zufallsgenerator bei der Definition von `arbitrary` zur
Verfügung steht, passen wir die Definition der zugehörigen Typklasse an.
Weiter erhält diese auch einen Größen-Parameter, um die generierten
Zufallswerte in ihrer Größe zu kontrollieren. Andere Definitionen aus der
vorherigen Challenge müssen wir auch anpassen.

```haskell
newtype Property = Property { unProperty :: Gen Bool }

newtype Gen a = Gen { unGen :: PRNG -> Int -> (a, PRNG) }

class Arbitrary a where
  arbitrary :: Gen a
```

- Passe deine alte Implementierung aus #xref("quickcheck-simple") bzgl. der neuen
  Typen an.
- Definiere `Functor`-, `Applicative`- und `Monad`-Instanzen
  für den Typkonstruktor `Gen`. (Hier passiert im Wesentlichen etwas Ähnliches wie in #xref("sequence-state").)
- Definiere eine Funktion `chooseInt :: (Int, Int) -> Gen Int`, die
  eine zufällige Ganzzahl im übergebenen Intervall generiert. Um eine
  zufällige Zahl $x in ZZ$ in ein Intervall $[l, r)$ zu zwingen, können wir
  z.B. $l + x "mod" (r - l)$ rechnen. In Haskell ist `mod` für einen positiven zweiten Parameter nie negativ, im Gegensatz zu `rem`.
- Definiere eine `Arbitrary`-Instanz für den Typ `Int`. Dabei
  soll eine generierte Ganzzahl im Intervall `(-s, s)` liegen, wobei
  `s` der übergegebene Größen-Parameter der Generator-Funktion ist.
- Passe `quickCheck` so an, dass ein Zufallsgenerator und ein
  Größenwert an die Generator-Funktionen weitergegeben wird.

#remark[
  Die Vereinfachungen, die wir gemacht haben:
  - einfacheren PRNG nutzen (anstatt SplitMix64)
  - in `Gen` wird in QuickCheck der PRNG gesplittet, anstatt dass
    er durchgereicht wird
  - `chooseInt`, so wie vorgeschlagen, erzeugt keine gleichverteilten
    Zufallswerte in dem Intervall. Für Genaueres:
    - #link("https://stackoverflow.com/questions/2509679/how-to-generate-a-random-integer-number-from-within-a-range")[How to generate a random integer number from within a range -- StackOverflow]
    - #link("https://hackage-content.haskell.org/package/splitmix/docs/src/System.Random.SplitMix.html#nextInteger")[`nextInteger`] aus `System.Random.SplitMix`
  - wir haben einen festen seed gewählt (in SplitMix64 wird
    #link("https://hackage-content.haskell.org/package/splitmix/docs/src/System.Random.SplitMix.Init.html#initialSeed")[initialSeed]
    basierend auf der aktuellen Uhrzeit gesetzt, damit immer neue zufällige
    Zahlen generiert werden, wenn das Programm erneut gestartet wird)
  - und vieles mehr!
]
