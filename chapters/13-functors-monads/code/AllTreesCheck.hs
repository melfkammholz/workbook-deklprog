import Workbook.Check
import AllTrees

leaves :: Tree a -> [a]
leaves (Leaf x)  = [x]
leaves (l :+: r) = leaves l ++ leaves r

main :: IO ()
main = runChecks
  [ eq "splits of the example"     (splits [1 .. 4 :: Int]) [([1], [2, 3, 4]), ([1, 2], [3, 4]), ([1, 2, 3], [4])]
  , eq "splits of one element"     (splits [1 :: Int]) []
  , eq "no trees for no leaves"    (allTrees ([] :: [Int])) []
  , eq "one leaf"                  (allTrees [1 :: Int]) [Leaf 1]
  , eq "two leaves"                (allTrees [1, 2 :: Int]) [Leaf 1 :+: Leaf 2]
  , eq "the number of trees is Catalan" (map (\k -> length (allTrees [1 .. k :: Int])) [1 .. 6]) [1, 1, 2, 5, 14, 42]
  , check "the leaves read the input" (all ((== [1 .. 5]) . leaves) (allTrees [1 .. 5 :: Int]))
  ]
