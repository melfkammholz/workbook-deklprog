Diese und die folgende Challenge steigen tiefer in die Funktionsweise von QuickCheck
ein. Dabei werden zwar weiter viele Vereinfachungen gemacht, wir nähern uns dennoch
der tatsächlichen Implementierung von QuickCheck stark an.

Eigenschaften lassen sich mit QuickCheck z.B. mithilfe der Funktion
`quickCheck` prüfen.

Hier sind ein paar Eigenschaften.
```haskell
prop_comm :: Int -> Int -> Bool
prop_comm x y = x + y == y + x

prop_inv :: Int -> Bool
prop_inv x = x + (-x) == 0
```

- Welchen Typ muss `quickCheck` scheinbar haben, damit wir
  `prop_comm` prüfen können? Wie steht das im Konflikt mit
  `prop_inv`?
- Um `quickCheck` zu implementieren, benötigen wir die Möglichkeit,
  beliebig stellige Funktionen anwenden zu können. Das ist mithilfe von
  Typklassen möglich. Hier ist eine vereinfachte Variante der Typklasse
  `Testable`, wie sie in QuickCheck zu finden ist. Hier ist Typ
  `Property` ein einfacher Wrapper um den `Bool`-Typ. In
  QuickCheck ist dieser ein bisschen komplexer.
  ```haskell
  newtype Property = Property { unProperty :: Bool }

  class Testable a where
    property :: a -> Property
  ```
  - Implementiere `Testable`-Instanzen für `Bool` und
    `Property`, und anschließend eine Instanz für den Typ
    `a -> b`, wobei `a` eine `Arbitrary`-Instanz haben
    soll und `b` wieder `Testable` sein soll.
  - Welche Instanzen übernehmen die Rolle eines Basisfalls und welche
    Instanzen übernehmen die Rolle einer induktiven Regel?
  - Wie ist es möglich, dass wir Eigenschaften definieren können, die
    entweder ein `Bool` oder eine `Property` als Rückgabewert
    haben?
  - Als Nächstes betrachten wir eine Vereinfachung der
    `Arbitrary`-Typklasse und eine Instanz für den Typ `Int`,
    damit wir `quickCheck` implementieren und verwenden können.
    ```haskell
    class Arbitrary a where
      arbitrary :: a

    instance Arbitrary Int where
      arbitrary = 42  -- Hier werden normalerweise zufällige Werte generiert.
    ```
    Implementiere eine Funktion `quickCheck :: Testable a => a -> Bool`,
    die eine Eigenschaft nimmt und prüft.

#remark[
  In QuickCheck werden Generatoren genutzt, um zufällige Werte zu generieren.
  Diese nutzen alle einen Zufallszahlengenerator, der als Zustand mit
  weiteren Parametern durch alle `arbitrary`-Aufrufe durchgetragen wird.
  Das behandeln wir in #xref("quickcheck-prng"), damit diese Challenge nicht zu
  sehr ausartet.
]
