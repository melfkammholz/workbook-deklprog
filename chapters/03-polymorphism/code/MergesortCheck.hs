{-# LANGUAGE ScopedTypeVariables #-}
import Data.List (sort)
import Workbook.Check
import Mergesort

main :: IO ()
main = runChecks
  [ eq "the empty list"                 (mergesort []) []
  , eq "one element"                    (mergesort [1]) [1]
  , eq "already sorted"                 (mergesort [1, 2, 3, 4]) [1, 2, 3, 4]
  , eq "sorted the wrong way around"    (mergesort [4, 3, 2, 1]) [1, 2, 3, 4]
  , eq "keeps duplicates"               (mergesort [3, 1, 2, 1, 3]) [1, 1, 2, 3, 3]
  , eq "several sorted parts"           (mergesort [1, 4, 2, 5, 3, 6]) [1, 2, 3, 4, 5, 6]
  , prop "agrees with Data.List.sort" $ \(xs :: [Int]) -> mergesort xs == sort xs
  , eq "copes with a long sorted list"  (length (mergesort [1 .. 50000])) 50000
  ]
