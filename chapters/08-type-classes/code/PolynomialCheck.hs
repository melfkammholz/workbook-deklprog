import Data.List (sort)
import Workbook.Check
import Polynomial

p :: PolyE Int
p = (T - 3) * (T + 2)

main :: IO ()
main = runChecks
  [ eq "polyadd"                 (polyadd [1, 2] [3, 4, 5 :: Int]) [4, 6, 5]
  , eq "polysub"                 (polysub [1] [3, 4 :: Int]) [-2, -4]
  , eq "polymul"                 (polymul [1, 1] [1, 1 :: Int]) [1, 2, 1]
  , eq "fromPolyE normalizes"    (fromPolyE p) (poly [-6, -1, 1])
  , eq "fromPolyE drops zeros"   (fromPolyE (T - T + 1 :: PolyE Int)) (poly [1])
  , eq "horner at 3"             (horner (poly [-6, -1, 1]) (3 :: Int)) 0
  , eq "horner at 2"             (horner (poly [1, 2, 3]) (2 :: Int)) 17
  , eq "divisors 12"             (sort (divisors (12 :: Int))) [1, 2, 3, 4, 6, 12]
  , eq "divisors 1"              (divisors (1 :: Int)) [1]
  , eq "roots of (t-3)(t+2)"     (sort (roots p)) [-2, 3]
  , eq "t^2 + 1 has no roots"    (roots (T * T + 1 :: PolyE Int)) []
  , eq "0 can be a root"         (sort (roots (T * (T - 2) :: PolyE Int))) [0, 2]
  , eq "negated polynomial"      (sort (roots (0 - (T - 1) * (T + 4) :: PolyE Int))) [-4, 1]
  ]
