module AllTrees (Tree (..), splits, allTrees) where

data Tree a = Leaf a | Tree a :+: Tree a
  deriving (Eq, Show)

splits :: [a] -> [([a], [a])]
#ifdef TEMPLATE
splits xs = undefined
#else
splits []     = []
splits [_]    = []
splits [x, y] = [([x], [y])]
splits (x:xs) = ([x], xs) : ((\(ys, zs) -> (x : ys, zs)) <$> splits xs)
#endif

allTrees :: [a] -> [Tree a]
#ifdef TEMPLATE
allTrees xs = undefined
#else
allTrees []  = []
allTrees [x] = [Leaf x]
allTrees xs  = [l :+: r | (ls, rs) <- splits xs, l <- allTrees ls, r <- allTrees rs]
#endif
