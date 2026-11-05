{-# LANGUAGE ScopedTypeVariables #-}
import Prelude hiding (map)
import qualified Prelude as P
import Workbook.Check
import Unfoldr

main :: IO ()
main = runChecks
  [ eq "unfoldr stops at Nothing"     (unfoldr (const (Nothing :: Maybe (Int, Int))) 0) []
  , eq "unfoldr counts down from 3"   (unfoldr (\n -> if n == 0 then Nothing else Just (n, n - 1)) (3 :: Int)) [3, 2, 1 :: Int]
  , eq "bits 0"                       (bits 0) []
  , eq "bits 1"                       (bits 1) [1]
  , eq "bits 6 starts with the LSB"   (bits 6) [0, 1, 1]
  , prop "bits gives the number back" $ \(NonNegative (n :: Int)) ->
      sum (zipWith (\b i -> b * 2 ^ i) (bits n) [0 :: Int ..]) == n
  , eq "map on the empty list"        (map (+ 1) ([] :: [Int])) []
  , prop "map agrees with the Prelude" $ \(xs :: [Int]) -> map (* 2) xs == P.map (* 2) xs
  ]
