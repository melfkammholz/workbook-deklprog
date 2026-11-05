{-# LANGUAGE ScopedTypeVariables #-}
import Workbook.Check
import Rational

parts :: Ratio -> (Integer, Integer)
parts r = (numerator r, denominator r)

main :: IO ()
main = runChecks
  [ eq "ratio 2 4 is normalised to 1/2"       (parts (ratio 2 4)) (1, 2)
  , eq "the sign moves to the numerator"      (parts (ratio 1 (-2))) (-1, 2)
  , eq "two minus signs cancel"               (parts (ratio (-2) (-4))) (1, 2)
  , eq "0/5 is normalised to 0/1"             (parts (ratio 0 5)) (0, 1)
  , eq "1/2 + 1/3 = 5/6"                      (parts (add (ratio 1 2) (ratio 1 3))) (5, 6)
  , eq "1/2 + 1/2 = 1/1"                      (parts (add (ratio 1 2) (ratio 1 2))) (1, 1)
  , eq "1/2 - 1/3 = 1/6"                      (parts (sub (ratio 1 2) (ratio 1 3))) (1, 6)
  , eq "2/3 * 3/4 = 1/2"                      (parts (mul (ratio 2 3) (ratio 3 4))) (1, 2)
  , eq "1/2 / (-1/3) = -3/2"                  (parts (divide (ratio 1 2) (ratio (-1) 3))) (-3, 2)
  , prop "results are always normalised" $ \(a :: Integer) (Positive (b :: Integer)) (c :: Integer) (Positive (d :: Integer)) ->
      let (p, q) = parts (add (ratio a b) (ratio c d)) in q > 0 && gcd p q == 1
  , eq "toDecimal 3 (1/3)"                    (toDecimal 3 (ratio 1 3)) "0.333"
  , eq "toDecimal 3 (-1/3)"                   (toDecimal 3 (ratio (-1) 3)) "-0.333"
  , eq "toDecimal 2 (1/2) fills up with 0"    (toDecimal 2 (ratio 1 2)) "0.50"
  , eq "toDecimal 2 (7/4)"                    (toDecimal 2 (ratio 7 4)) "1.75"
  , eq "toDecimal 2 (2/3) cuts off"           (toDecimal 2 (ratio 2 3)) "0.66"
  ]
