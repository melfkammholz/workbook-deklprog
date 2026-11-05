module UnfoldTree (Tree (..), unfoldTree, intervals) where

data Tree a = Empty | Node (Tree a) a (Tree a)
  deriving (Eq, Show)

-- | Builds a tree from a value, until the function gives Nothing.
unfoldTree :: (b -> Maybe (b, a, b)) -> b -> Tree a
#ifdef TEMPLATE
unfoldTree f b = undefined
#else
unfoldTree f b = case f b of
  Nothing        -> Empty
  Just (l, a, r) -> Node (unfoldTree f l) a (unfoldTree f r)
#endif

-- | The tree of the decompositions of the interval [l, r).
intervals :: Int -> Int -> Tree (Int, Int)
#ifdef TEMPLATE
intervals l r = undefined
#else
intervals l r = unfoldTree step (l, r)
  where
    step (a, b)
      | b <= a     = Nothing
      | b - a == 1 = Just ((b, b), (a, b), (b, b))
      | otherwise  = let m = (a + b) `div` 2 in Just ((a, m), (a, b), (m, b))
#endif
