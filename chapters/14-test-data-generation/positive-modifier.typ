Wenn du folgende (etwas künstliche) Eigenschaft mithilfe von QuickCheck
prüfst, muss im Durchschnitt jeder zweite Test verworfen werden, weil die
Vorbedingung der Eigenschaft nicht erfüllt ist.
```haskell
prop_prop :: Int -> Property
prop_prop k = k > 0 ==> True
```
Um dieses Verhalten zu unterbinden, können wir die Eigenschaft leicht
abändern.
```haskell
prop_prop :: Positive Int -> Property
prop_prop (Positive k) = k > 0 ==> True
```
Jetzt werden keine Testeingaben verworfen.

Überlege dir, wie die Lösung des Problems funktioniert und implementiere sie.

#remark[
  QuickCheck hat viele solche
  #link("https://hackage-content.haskell.org/package/QuickCheck/docs/Test-QuickCheck.html")[type-level modifiers],
  die das Generator-Verhalten verändern.
]

#sample[
  ```haskell
  newtype Positive a = Positive { getPositive :: a }

  instance (Arbitrary a, Num a, Ord a) => Arbitrary (Positive a) where
    arbitrary = fmap Positive (fmap abs arbitrary `suchThat` (> 0))
  ```
]
