import Workbook.Check hiding (Arbitrary (..), Property, Testable (..), quickCheck)
import SimpleQuickCheck

prop_comm :: Int -> Int -> Bool
prop_comm x y = x + y == y + x

prop_inv :: Int -> Bool
prop_inv x = x + (-x) == 0

prop_wrong :: Int -> Bool
prop_wrong x = x /= 42

main :: IO ()
main = runChecks
  [ check "a Bool"                    (quickCheck True)
  , check "False fails"               (not (quickCheck False))
  , check "a Property"                (quickCheck (Property True))
  , check "one argument"              (quickCheck prop_inv)
  , check "two arguments"             (quickCheck prop_comm)
  , check "the argument is arbitrary" (not (quickCheck prop_wrong))
  , check "a function returning a Property" (quickCheck (\x -> Property (x == (42 :: Int))))
  ]
