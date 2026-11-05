Es kommt häufiger vor, dass zufällig generierte Werte bestimmte Eigenschaften
erfüllen sollen. QuickCheck bietet auf Generatoren-Ebene z.B. die Funktion
`suchThat :: Gen a -> (a -> Bool) -> Gen a` dafür an. Diese nimmt einen
Generator und generiert solange neue Werte, bis eine gewünschte Eigenschaft
erfüllt ist. Diese Eigenschaft wird durch ein Prädikat formuliert.

Implementiere `suchThat`.

#remark[
  Es gibt ein paar QuickCheck-spezifische Fallstricke, die mit dem
  `size`-Parameter der Generatoren zu tun haben, die du bei deiner Implementierung nicht zu beachten brauchst. Falls es dich interessiert, ist
  hier die
  #link("https://hackage-content.haskell.org/package/QuickCheck/docs/src/Test.QuickCheck.Gen.html#suchThat")[`suchThat`-Implementierung von QuickCheck].
]

#sample[
  ```haskell
  suchThat :: Gen a -> (a -> Bool) -> Gen a
  suchThat g p = g >>= \x -> if p x
                               then return x
                               else g `suchThat` p
  ```
]
