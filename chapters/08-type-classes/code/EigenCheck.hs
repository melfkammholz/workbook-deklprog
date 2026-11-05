import Data.List (sort)
import Workbook.Check
import Eigen
import Polynomial (PolyE (..))

main :: IO ()
main = runChecks
  [ eq "inv of a sorted list"       (inv [1, 2, 3 :: Int] :: Int) 0
  , eq "inv [3, 2, 1] = 3"          (inv [3, 2, 1 :: Int] :: Int) 3
  , eq "sgn of a swap"              (sgn [1, 0 :: Int] :: Int) (-1)
  , eq "sgn of the identity"        (sgn [0, 1, 2 :: Int] :: Int) 1
  , eq "det of a 2x2 matrix"        (det (Mat [[1, 2], [3, 4 :: Int]])) (-2)
  , eq "det [[0,1],[1,0]] = -1"     (det (Mat [[0, 1], [1, 0 :: Int]])) (-1)
  , eq "eigenvalues of the example" (sort (eigen (Mat [[-4, 11, -5], [-15, 30, -13], [-27, 51, -22 :: Int]]))) [-1, 2, 3]
  , eq "eigenvalues of a diagonal"  (sort (eigen (Mat [[2, 0], [0, 5 :: Int]]))) [2, 5]
  ]
