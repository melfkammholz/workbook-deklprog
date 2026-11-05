{-# LANGUAGE ScopedTypeVariables #-}
import Prelude hiding (iterate)
import qualified Data.List as L
import Workbook.Check
import FixedPoint

near :: Double -> Double -> Bool
near a b = abs (a - b) < 1e-5

main :: IO ()
main = runChecks
  [ eq "iterate starts with the value itself" (take 3 (iterate (+ 1) (0 :: Int))) [0, 1, 2]
  , check "heron of 2"                 (near (heron 1e-8 2) (sqrt 2))
  , check "heron of 144"               (near (heron 1e-8 144) 12)
  , eq "the first Fibonacci numbers"   (take 8 fibs) [0, 1, 1, 2, 3, 5, 8, 13]
  , eq "resolve leaves sorted lists"   (resolve [1, 2, 3 :: Int]) [1, 2, 3]
  , check "resolve changes unsorted lists" (resolve [2, 1 :: Int] /= [2, 1])
  , eq "sort with duplicates"          (sort [2, 1, 2, 1 :: Int]) [1, 1, 2, 2]
  , prop "sort agrees with Data.List" $ \(xs :: [Int]) -> sort (take 30 xs) == L.sort (take 30 xs)
  ]
