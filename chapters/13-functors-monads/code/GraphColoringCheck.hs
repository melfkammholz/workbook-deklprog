import Data.List (nub)
import Workbook.Check
import GraphColoring

valid :: [[Int]] -> [Int] -> Bool
valid g c = length c == length g && and [c !! v /= c !! w | (v, ws) <- zip [0 ..] g, w <- ws]

colors :: [Int] -> Int
colors = length . nub

example :: [[Int]]
example = [[1, 3], [0, 2, 3, 4], [1, 4], [0, 1, 5], [1, 2, 5], [3, 4]]

main :: IO ()
main = runChecks
  [ eq "no edges need one colour"      (colors (minColor [[], [], []])) 1
  , eq "one edge needs two"            (colors (minColor [[1], [0]])) 2
  , eq "a triangle needs three"        (colors (minColor [[1, 2], [0, 2], [0, 1]])) 3
  , eq "a square needs two"            (colors (minColor [[1, 3], [0, 2], [1, 3], [0, 2]])) 2
  , check "the example is coloured properly" (valid example (minColor example))
  , eq "the example needs three"       (colors (minColor example)) 3
  ]
