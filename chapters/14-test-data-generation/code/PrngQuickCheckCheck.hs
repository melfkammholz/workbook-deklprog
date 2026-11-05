import Data.Bits (shiftL, shiftR, xor)
import Data.Word (Word64)
import Workbook.Check hiding (Arbitrary (..), Gen, Property, Testable (..), chooseInt, quickCheck, property)
import PrngQuickCheck

run :: Gen a -> a
run m = fst (unGen m (mkPRNG 42) 30)

draws :: Int -> Gen a -> [a]
draws n m = run (mapM (const m) [1 .. n])

main :: IO ()
main = runChecks
  [ eq "xorshift64 of 1"             (xorshift64 1) 1082269761
  , eq "pure keeps the generator"    (run (pure 'x')) 'x'
  , eq "fmap changes the value"      (run (fmap (+ 1) (pure (1 :: Int)))) 2
  , check "bind hands on the generator: two draws differ"
      (run (do { a <- arbitrary; b <- arbitrary; pure (a /= (b :: Int)) }))
  , check "chooseInt stays in [3, 7)" (all (\x -> 3 <= x && x < 7) (draws 200 (chooseInt (3, 7))))
  , check "chooseInt is not constant" (length (filter (== 3) (draws 200 (chooseInt (3, 7)))) < 200)
  , check "arbitrary stays in the size" (all (\x -> -30 <= x && x < 30) (draws 200 (arbitrary :: Gen Int)))
  , check "quickCheck of True"        (quickCheck True)
  , check "quickCheck of False"       (not (quickCheck False))
  , check "quickCheck with arguments" (quickCheck (\x y -> x + y == y + (x :: Int)))
  ]
