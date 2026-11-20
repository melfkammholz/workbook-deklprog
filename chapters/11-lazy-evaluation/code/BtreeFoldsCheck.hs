{-# LANGUAGE ScopedTypeVariables #-}
import Workbook.Check
import BtreeFolds

tree :: BTree Int
tree = Node (Leaf 3) 7 (Node (Leaf (-2)) 1 (Leaf 5))

instance Arbitrary a => Arbitrary (BTree a) where
  arbitrary = sized go
    where
      go 0 = Leaf <$> arbitrary
      go n = oneof [Leaf <$> arbitrary, Node <$> go (n `div` 2) <*> arbitrary <*> go (n `div` 2)]

toL :: BTree a -> [a]
toL = foldBTree (: []) (\l n r -> l ++ [n] ++ r)

main :: IO ()
main = runChecks
  [ eq "maxBTree of a leaf"                     (maxBTree (Leaf 4)) 4
  , eq "maxBTree of a leaf with a negative label" (maxBTree (Leaf (-4))) (-4)
  , eq "maxBTree finds the maximum in a node"   (maxBTree tree) 7
  , eq "maxBTree finds the maximum in a leaf"   (maxBTree (Node (Leaf 1) 2 (Node (Leaf 3) 0 (Leaf 9)))) 9
  , prop "maxBTree is the maximum of all toL" $ \(t :: BTree Int) -> maxBTree t == maximum (toL t)
  , eq "replace on a leaf"                      (replace (Leaf 'a') True) (Leaf True)
  , eq "replace keeps the shape"                (replace tree "x")
      (Node (Leaf "x") "x" (Node (Leaf "x") "x" (Leaf "x")))
  , prop "replace sets every label" $ \(t :: BTree Int) (y :: Char) ->
      toL (replace t y) == map (const y) (toL t)
  ]
