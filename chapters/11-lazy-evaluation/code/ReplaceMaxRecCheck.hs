{-# LANGUAGE ScopedTypeVariables #-}
import Workbook.Check
import ReplaceMaxRec

tree :: BTree Int
tree = Node (Leaf 3) 7 (Node (Leaf (-2)) 1 (Leaf 5))

instance Arbitrary a => Arbitrary (BTree a) where
  arbitrary = sized go
    where
      go 0 = Leaf <$> arbitrary
      go n = oneof [Leaf <$> arbitrary, Node <$> go (n `div` 2) <*> arbitrary <*> go (n `div` 2)]

toL :: BTree a -> [a]
toL (Leaf x)     = [x]
toL (Node l n r) = toL l ++ [n] ++ toL r

main :: IO ()
main = runChecks
  [ eq "replaceMaxRec on a leaf"   (replaceMaxRec (Leaf 4) 'x') (Leaf 'x', 4)
  , eq "replaceMaxRec on a tree"   (replaceMaxRec tree "y")
      (Node (Leaf "y") "y" (Node (Leaf "y") "y" (Leaf "y")), 7)
  , prop "replaceMaxRec returns the maximum" $ \(t :: BTree Int) ->
      snd (replaceMaxRec t ()) == maximum (toL t)
  , eq "replaceMax on a leaf"      (replaceMax (Leaf 4)) (Leaf 4)
  , eq "replaceMax on a tree"      (replaceMax tree)
      (Node (Leaf 7) 7 (Node (Leaf 7) 7 (Leaf 7)))
  , prop "replaceMax sets every label to the maximum" $ \(t :: BTree Int) ->
      toL (replaceMax t) == map (const (maximum (toL t))) (toL t)
  ]
