module ReplaceMaxRec (BTree (..), replaceMaxRec, replaceMax) where

data BTree a = Leaf a
             | Node (BTree a) a (BTree a)
  deriving (Show, Eq)

-- Returns the relabeled tree and the maximum of the original labels.
-- The new label is the result of the same pass, so it is a parameter of the helper.
replaceMaxRec :: BTree Int -> a -> (BTree a, Int)
#ifdef TEMPLATE
replaceMaxRec t y = undefined
#else
replaceMaxRec (Leaf x) y = (Leaf y, x)
replaceMaxRec (Node l n r) y = (Node l' y r', maximum [ml, n, mr])
  where
    (l', ml) = replaceMaxRec l y
    (r', mr) = replaceMaxRec r y
#endif

-- Replaces all labels by the maximum label in a single traversal.
replaceMax :: BTree Int -> BTree Int
#ifdef TEMPLATE
replaceMax t = undefined
#else
replaceMax t = t'
  where
    (t', m) = replaceMaxRec t m
#endif
