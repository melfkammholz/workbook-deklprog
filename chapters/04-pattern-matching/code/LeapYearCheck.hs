import Workbook.Check
import LeapYear

-- The rule as a formula, without guards.
leap :: Int -> Bool
leap y = (y `mod` 4 == 0 && y `mod` 100 /= 0) || y `mod` 400 == 0

main :: IO ()
main = runChecks
  [ check "isLeap 2024"                      (isLeap 2024)
  , check "not (isLeap 2023)"                (not (isLeap 2023))
  , check "not (isLeap 1900)"                (not (isLeap 1900))
  , check "not (isLeap 2100)"                (not (isLeap 2100))
  , check "isLeap 2000"                      (isLeap 2000)
  , check "isLeap 1600"                      (isLeap 1600)
  , prop "agrees with the rule for any year" $ \y -> isLeap y == leap y
  , prop "agrees with the rule for any century year" $ \c -> isLeap (100 * c) == leap (100 * c)
  ]
