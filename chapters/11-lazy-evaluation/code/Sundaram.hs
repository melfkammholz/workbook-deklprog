module Sundaram (Tree (..), preorder, tree, merge, preorderMerge, diff, primes) where

data Tree a = Empty | Node (Tree a) a (Tree a)

preorder :: Tree a -> [a]
#ifdef TEMPLATE
preorder t = undefined
#else
preorder Empty        = []
preorder (Node l x r) = x : preorder l ++ preorder r
#endif

tree :: Tree Int
#ifdef TEMPLATE
tree = undefined
#else
tree = go 1 1
  where
    go i j = Node (if i < j then go (i + 1) j else Empty)
                  (i + j + 2 * i * j)
                  (go i (j + 1))
#endif

merge :: Ord a => [a] -> [a] -> [a]
#ifdef TEMPLATE
merge xs ys = undefined
#else
merge xs     []     = xs
merge []     ys     = ys
merge (x:xs) (y:ys)
  | x <= y    = x : merge xs (y : ys)
  | otherwise = y : merge (x : xs) ys
#endif

preorderMerge :: Ord a => Tree a -> [a]
#ifdef TEMPLATE
preorderMerge t = undefined
#else
preorderMerge Empty        = []
preorderMerge (Node l x r) = x : merge (preorderMerge l) (preorderMerge r)
#endif

diff :: Ord a => [a] -> [a] -> [a]
#ifdef TEMPLATE
diff xs ys = undefined
#else
diff []     _      = []
diff xs     []     = xs
diff (x:xs) (y:ys)
  | x == y    = diff xs (y : ys)
  | x > y     = diff (x : xs) ys
  | otherwise = x : diff xs (y : ys)
#endif

primes :: [Int]
primes = 2 : map (\x -> 2 * x + 1) ([1 ..] `diff` preorderMerge tree)
