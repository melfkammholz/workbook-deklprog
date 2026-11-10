import Workbook.Check
import MirrorTree

genTree :: Gen (Tree Int)
genTree = sized go
  where
    go 0 = Leaf <$> arbitrary
    go n = oneof [Leaf <$> arbitrary, (:+:) <$> go (n `div` 2) <*> go (n `div` 2)]

main :: IO ()
main = runChecks
  [ eq "mirrorTree (Leaf 1) = Leaf 1"                  (mirrorTree (Leaf 1)) (Leaf 1)
  , eq "mirrorTree (Leaf 1 :+: Leaf 2) = Leaf 2 :+: Leaf 1"
                                                       (mirrorTree (Leaf 1 :+: Leaf 2)) (Leaf 2 :+: Leaf 1)
  , eq "mirrorTree vertauscht auch tiefer liegende Teilbäume"
                                                       (mirrorTree (Leaf 1 :+: (Leaf 2 :+: Leaf 3)))
                                                       ((Leaf 3 :+: Leaf 2) :+: Leaf 1)
  , prop "zweimal spiegeln ergibt den Baum zurück"     $ forAll genTree $ \t -> mirrorTree (mirrorTree t) == t
  ]
