module FoldTree where

import Prelude hiding (all, any, elem, length, maximum, minimum, notElem, null, product, sum)

data Tree a = Empty | Node (Tree a) a (Tree a)
  deriving Show

foldTree :: r -> (r -> a -> r -> r) -> Tree a -> r
foldTree e _ Empty        = e
foldTree e f (Node l x r) = f (foldTree e f l) x (foldTree e f r)

any, all :: (a -> Bool) -> Tree a -> Bool
#ifdef TEMPLATE
any p t = undefined
all p t = undefined
#else
any p = foldTree False (\l x r -> l || p x || r)
all p = foldTree True (\l x r -> l && p x && r)
#endif

elem, notElem :: Int -> Tree Int -> Bool
#ifdef TEMPLATE
elem y t = undefined
notElem y t = undefined
#else
elem y = any (== y)
notElem y = all (/= y)
#endif

toList :: Tree a -> [a]
#ifdef TEMPLATE
toList t = undefined
#else
toList = foldTree [] (\l x r -> l ++ [x] ++ r)
#endif

null :: Tree a -> Bool
#ifdef TEMPLATE
null t = undefined
#else
null = foldTree True (\_ _ _ -> False)
#endif

length :: Tree a -> Int
#ifdef TEMPLATE
length t = undefined
#else
length = foldTree 0 (\l _ r -> l + 1 + r)
#endif

maximum, minimum :: Tree Int -> Int
#ifdef TEMPLATE
maximum t = undefined
minimum t = undefined
#else
maximum = foldTree minBound (\l x r -> max l (max x r))
minimum = foldTree maxBound (\l x r -> min l (min x r))
#endif

sum, product :: Tree Int -> Int
#ifdef TEMPLATE
sum t = undefined
product t = undefined
#else
sum = foldTree 0 (\l x r -> l + x + r)
product = foldTree 1 (\l x r -> l * x * r)
#endif
