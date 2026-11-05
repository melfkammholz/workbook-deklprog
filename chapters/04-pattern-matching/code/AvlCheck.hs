{-# LANGUAGE ScopedTypeVariables #-}
import Data.List (nub, sort)
import Workbook.Check
import Avl

leaf :: Int -> SearchTree Int
leaf x = Node Empty x Empty

balancedTree :: SearchTree Int
balancedTree = Node (leaf 1) 2 (leaf 3)

toList :: SearchTree a -> [a]
toList Empty        = []
toList (Node l x r) = toList l ++ [x] ++ toList r

isAvl :: SearchTree a -> Bool
isAvl Empty        = True
isAvl (Node l _ r) = abs (height l - height r) <= 1 && isAvl l && isAvl r

fromList :: [Int] -> SearchTree Int
fromList = foldr insert Empty

main :: IO ()
main = runChecks
  [ eq "left-left: rotates right"    (rotate (Node (Node (leaf 1) 2 Empty) 3 Empty)) balancedTree
  , eq "right-right: rotates left"   (rotate (Node Empty 1 (Node Empty 2 (leaf 3)))) balancedTree
  , eq "left-right: rotates twice"   (rotate (Node (Node Empty 1 (leaf 2)) 3 Empty)) balancedTree
  , eq "right-left: rotates twice"   (rotate (Node Empty 1 (Node (leaf 2) 3 Empty))) balancedTree
  , eq "a balanced tree stays as it is" (rotate balancedTree) balancedTree
  , eq "the empty tree stays as it is"  (rotate (Empty :: SearchTree Int)) Empty
  , prop "insert keeps the tree balanced" $ \(xs :: [Int]) -> isAvl (fromList xs)
  , prop "insert keeps every element, in order" $ \(xs :: [Int]) -> toList (fromList xs) == sort (nub xs)
  , prop "delete removes the element" $ \(x :: Int) (xs :: [Int]) ->
      toList (delete x (fromList (x : xs))) == sort (nub (filter (/= x) xs))
  , prop "delete keeps the tree balanced" $ \(ds :: [Int]) (xs :: [Int]) ->
      isAvl (foldr delete (fromList (xs ++ ds)) ds)
  ]
