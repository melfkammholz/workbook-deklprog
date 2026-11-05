import Workbook.Check
import GradientDescent

main :: IO ()
main = runChecks
  [ check "(x - 3)^2 has its minimum at 3"   (abs (minimize (\x -> 2 * (x - 3)) 0 - 3) < 0.05)
  , check "x^2 from the other side"          (abs (minimize (* 2) 4) < 0.05)
  , eq "a start at the minimum stays there"  (minimize (* 2) 0) 0
  ]
