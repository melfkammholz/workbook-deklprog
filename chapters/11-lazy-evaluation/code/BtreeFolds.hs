module BtreeFolds (BTree (..), foldBTree, maxBTree, replace) where

data BTree a = Leaf a
             | Node (BTree a) a (BTree a)
  deriving (Show, Eq)

foldBTree :: (a -> b) -> (b -> a -> b -> b) -> BTree a -> b
foldBTree fleaf fnode bt = case bt of
  Leaf x     -> fleaf x
  Node l n r -> fnode (foldBTree fleaf fnode l) n (foldBTree fleaf fnode r)

maxBTree :: BTree Int -> Int
#ifdef TEMPLATE
maxBTree = undefined
#else
maxBTree = foldBTree id (\l n r -> maximum [l, n, r])
#endif

replace :: BTree a -> b -> BTree b
#ifdef TEMPLATE
replace = undefined
#else
replace t y = foldBTree (const (Leaf y)) (\l _ r -> Node l y r) t
#endif
