import Workbook.Check
import Sundaram

small :: Tree Int
small = Node (Node Empty 2 Empty) 1 (Node Empty 3 Empty)

main :: IO ()
main = runChecks
  [ eq "preorder: node, left, right"        (preorder small) [1, 2, 3]
  , eq "the tree starts with f(1,1) = 4"    (take 1 (preorder tree)) [4]
  , eq "merge of finite lists"              (merge [1, 3] [2, 4 :: Int]) [1, 2, 3, 4]
  , eq "merge keeps what is left, either side" (merge [] [1 :: Int] ++ merge [1] []) [1, 1]
  , eq "merge works on infinite lists"      (take 4 (merge [1, 3 ..] ([2, 4 ..] :: [Int]))) [1, 2, 3, 4]
  , eq "preorderMerge is sorted at the start" (take 6 (preorderMerge tree)) [4, 7, 10, 12, 13, 16]
  , eq "diff removes elements"              (diff [1, 2, 3, 4] [2, 4 :: Int]) [1, 3]
  , eq "diff on an infinite list"           (take 3 (diff [1 ..] ([2, 4 ..] :: [Int]))) [1, 3, 5]
  , eq "the first primes"                   (take 10 primes) [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
  ]
