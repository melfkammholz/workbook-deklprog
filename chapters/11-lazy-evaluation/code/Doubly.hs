module Doubly (Doubly (..), fromList, prev, value, next) where

data Doubly a = Null | Node (Doubly a) a (Doubly a)

fromList :: [a] -> Doubly a
#ifdef TEMPLATE
fromList xs = undefined
#else
fromList = go Null
  where
    go _ []       = Null
    go p (x : xs) = let n = Node p x (go n xs) in n
#endif

prev, next :: Doubly a -> Doubly a
#ifdef TEMPLATE
prev d = undefined
next d = undefined
#else
prev Null         = Null
prev (Node p _ _) = p

next Null         = Null
next (Node _ _ n) = n
#endif

value :: Doubly a -> Maybe a
#ifdef TEMPLATE
value d = undefined
#else
value Null         = Nothing
value (Node _ x _) = Just x
#endif
