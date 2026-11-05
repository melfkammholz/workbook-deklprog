import Workbook.Check
import LinearAlgebra (Mat (..))
import Tropical

n :: Int -> WithInf Int
n = Number

t :: Int -> Tropical Int
t = Tropical . n

inf :: Tropical Int
inf = Tropical Inf

main :: IO ()
main = runChecks
  [ eq "shows infinity"                 (show (Inf :: WithInf Int)) "∞"
  , eq "a number plus infinity"         (n 1 + Inf) Inf
  , eq "1 + 2 on numbers"               (n 1 + n 2) (n 3)
  , check "numbers are below infinity"  (n 1000 < Inf)
  , eq "tropical + is the minimum"      (t 3 + t 5) (t 3)
  , eq "tropical * is the sum"          (t 3 * t 5) (t 8)
  , eq "infinity is neutral for +"      (inf + t 5) (t 5)
  , eq "infinity absorbs *"             (inf * t 5) inf
  , eq "matrix addition"                (Mat [[1, 2]] + Mat [[3, 4 :: Int]]) (Mat [[4, 6]])
  , eq "matrix multiplication"          (Mat [[1, 2], [3, 4]] * Mat [[0, 1], [1, 0 :: Int]]) (Mat [[2, 1], [4, 3]])
  , eq "shortestPaths of the example"   (shortestPaths w)
      (Mat [[n 0, n (-2), n 1, n 3], [Inf, n 0, n 3, n 5], [Inf, Inf, n 0, n 2], [Inf, Inf, Inf, n 0]])
  , eq "shortestPaths takes a detour"   (shortestPaths (Mat [[n 0, n 10, n 1], [Inf, n 0, Inf], [Inf, n 2, n 0]]))
      (Mat [[n 0, n 3, n 1], [Inf, n 0, Inf], [Inf, n 2, n 0]])
  ]
