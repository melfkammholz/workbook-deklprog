import Workbook.Check
import LogFib

main :: IO ()
main = runChecks
  [ eq "fib 0 = 0"          (fib 0) 0
  , eq "fib 1 = 1"          (fib 1) 1
  , eq "fib 2 = 1"          (fib 2) 1
  , eq "fib 10 = 55"        (fib 10) 55
  , eq "fib 90"             (fib 90) 2880067194370816120
  , prop "the recurrence holds" $ \(NonNegative n) -> let k = n `mod` 200 in fib (k + 2) == fib (k + 1) + fib k
  , check "is fast enough for n = 10^6" (fib 1000000 > 0)
  ]
