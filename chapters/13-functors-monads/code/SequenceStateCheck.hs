import Prelude hiding (sequence)
import Workbook.Check
import SequenceState

tick :: Int -> (Int, Int)
tick s = (s * 10, s + 1)

main :: IO ()
main = runChecks
  [ eq "no steps keep the state"      (sequence ([] :: [Int -> (Int, Int)]) 7) ([], 7)
  , eq "one step"                     (sequence [tick] 1) ([10], 2)
  , eq "the state is handed on"       (sequence [tick, tick, tick] 1) ([10, 20, 30], 4)
  , eq "the Fibonacci example"        (fibs 7) [0, 1, 1, 2, 3, 5, 8]
  ]
