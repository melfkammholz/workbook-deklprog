import Workbook.Check
import SumTree

-- The tests bring their own generator: it keeps the trees small, whatever instance the student's file has.
genTree :: Gen (Tree Int)
genTree = sized go
  where
    go 0 = Leaf <$> arbitrary
    go n = oneof [Leaf <$> arbitrary, (:+:) <$> go (n `div` 2) <*> go (n `div` 2)]

leaves :: Tree a -> [a]
leaves (Leaf x)  = [x]
leaves (l :+: r) = leaves l ++ leaves r

main :: IO ()
main = runChecks
  [ eq "sumTree (Leaf 5) = 5"                          (sumTree (Leaf 5)) 5
  , eq "sumTree (Leaf 1 :+: Leaf 2) = 3"               (sumTree (Leaf 1 :+: Leaf 2)) 3
  , eq "sumTree (Leaf (-4) :+: (Leaf 4 :+: Leaf 10)) = 10"
                                                       (sumTree (Leaf (-4) :+: (Leaf 4 :+: Leaf 10))) 10
  , prop "sumTree ist die Summe aller Blätter"         $ forAll genTree $ \t -> sumTree t == sum (leaves t)
  ]
