import Workbook.Check
import UnfoldTree

leaves :: Tree a -> [a]
leaves Empty                = []
leaves (Node Empty x Empty) = [x]
leaves (Node l _ r)         = leaves l ++ leaves r

size :: Tree a -> Int
size Empty        = 0
size (Node l _ r) = size l + 1 + size r

node :: (Int, Int) -> Tree (Int, Int)
node x = Node Empty x Empty

main :: IO ()
main = runChecks
  [ eq "unfoldTree stops at Nothing"
      (unfoldTree (const (Nothing :: Maybe (Int, Int, Int))) 0) Empty
  , eq "unfoldTree grows both sides"
      (unfoldTree (\n -> if n == (0 :: Int) then Nothing else Just (n - 1, n, n - 1)) 2)
      (Node (Node Empty 1 Empty) (2 :: Int) (Node Empty 1 Empty))
  , eq "an empty interval is Empty"      (intervals 3 3) Empty
  , eq "one element is a leaf"           (intervals 0 1) (node (0, 1))
  , eq "[0, 2) splits in two"            (intervals 0 2) (Node (node (0, 1)) (0, 2) (node (1, 2)))
  , eq "[0, 3) rounds the middle down"   (intervals 0 3)
      (Node (node (0, 1)) (0, 3) (Node (node (1, 2)) (1, 3) (node (2, 3))))
  , prop "the leaves are the single elements" $ \(Positive n) ->
      let k = n `mod` 64 + 1 :: Int in leaves (intervals 0 k) == [(i, i + 1) | i <- [0 .. k - 1]]
  , prop "an interval of k elements has 2k - 1 nodes" $ \(Positive n) ->
      let k = n `mod` 64 + 1 :: Int in size (intervals 5 (5 + k)) == 2 * k - 1
  ]
