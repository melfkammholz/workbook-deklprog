module Avl (SearchTree (..), height, rotate, insert, delete) where

data SearchTree a = Empty | Node (SearchTree a) a (SearchTree a)
  deriving (Eq, Show)

height :: SearchTree a -> Int
height Empty        = 0
height (Node l _ r) = max (height l) (height r) + 1

-- | Rebalances a tree at its root, if needed.
rotate :: SearchTree a -> SearchTree a
#ifdef TEMPLATE
rotate t = undefined
#else
rotate Empty          = Empty
rotate t@(Node l v r) =
  case (balance t, balance l, balance r) of
    (2, _, -1) -> rotateL (Node l v (rotateR r))
    (2, _, _)  -> rotateL (Node l v r)
    (-2, 1, _) -> rotateR (Node (rotateL l) v r)
    (-2, _, _) -> rotateR (Node l v r)
    _          -> t
  where
    rotateR (Node (Node ll lv lr) x y) = Node ll lv (Node lr x y)
    rotateR _                          = error "should not happen"

    rotateL (Node x y (Node rl rv rr)) = Node (Node x y rl) rv rr
    rotateL _                          = error "should not happen"

balance :: SearchTree a -> Int
balance Empty        = 0
balance (Node l _ r) = height r - height l
#endif

-- | Inserts an element, keeping the tree balanced.
insert :: Ord a => a -> SearchTree a -> SearchTree a
#ifdef TEMPLATE
insert x t = undefined
#else
insert x Empty = Node Empty x Empty
insert x t@(Node l v r)
  | x < v     = rotate (Node (insert x l) v r)
  | x > v     = rotate (Node l v (insert x r))
  | otherwise = t
#endif

-- | Deletes an element, keeping the tree balanced.
delete :: Ord a => a -> SearchTree a -> SearchTree a
#ifdef TEMPLATE
delete x t = undefined
#else
delete _ Empty = Empty
delete x (Node l v r)
  | x < v     = rotate (Node (delete x l) v r)
  | x > v     = rotate (Node l v (delete x r))
  | otherwise = case r of
      Empty -> l
      _     -> let m = smallest r in rotate (Node l m (delete m r))
  where
    smallest (Node Empty y _) = y
    smallest (Node a _ _)     = smallest a
    smallest Empty            = error "should not happen"
#endif
