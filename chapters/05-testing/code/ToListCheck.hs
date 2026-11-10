import Workbook.Check
import ToList

genTree :: Gen (Tree Int)
genTree = sized go
  where
    go 0 = Leaf <$> arbitrary
    go n = oneof [Leaf <$> arbitrary, (:+:) <$> go (n `div` 2) <*> go (n `div` 2)]

main :: IO ()
main = runChecks
  [ eq "toList (Leaf 7) = [7]"                         (toList (Leaf 7)) [7]
  , eq "toList (Leaf 1 :+: Leaf 2) = [1, 2]"           (toList (Leaf 1 :+: Leaf 2)) [1, 2]
  , eq "toList liest von links nach rechts"            (toList ((Leaf 5 :+: Leaf 3) :+: (Leaf 9 :+: Leaf 1)))
                                                       [5, 3, 9, 1]
  , prop "die Summe der Liste ist sumTree"             $ forAll genTree $ \t -> sum (toList t) == sumTree t
  , prop "mirrorTree dreht die Liste um"               $ forAll genTree $ \t ->
                                                         toList (mirrorTree t) == reverse (toList t)
  ]
