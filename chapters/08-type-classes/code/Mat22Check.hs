import Workbook.Check
import Mat22

m :: Mat22 Int
m = Mat22 1 2 3 4

main :: IO ()
main = runChecks
  [ eq "(+) is componentwise"             (m + m) (Mat22 2 4 6 8)
  , eq "(-) is componentwise"             (m - m) (Mat22 0 0 0 0)
  , eq "(*) is the matrix product"        (m * Mat22 0 1 1 0) (Mat22 2 1 4 3)
  , eq "fromInteger 1 is the identity"    (fromInteger 1 * m) m
  , eq "m ^ 0 is the identity"            (m ^ (0 :: Int)) (Mat22 1 0 0 1)
  , eq "m ^ 2"                            (m ^ (2 :: Int)) (Mat22 7 10 15 22)
  ]
