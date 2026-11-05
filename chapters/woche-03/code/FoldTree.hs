module FoldTree where

data Tree a b = Empty
              | Leaf a
              | Node b [Tree a b]
  deriving (Show, Eq)

#ifdef TEMPLATE
-- Think about the type signature first.
foldTree = undefined
#else
foldTree :: r -> (a -> r) -> (b -> [r] -> r) -> Tree a b -> r
foldTree fempty fleaf fnode value =
  case value of
    Empty     -> fempty
    Leaf x    -> fleaf x
    Node x ts -> fnode x (map foldTree' ts)
  where
    foldTree' = foldTree fempty fleaf fnode
#endif
