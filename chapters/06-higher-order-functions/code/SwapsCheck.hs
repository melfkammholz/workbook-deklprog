import Workbook.Check
import Swaps

newtype Input = Input (Int, [(Int, Int)]) deriving Show

instance Arbitrary Input where
  arbitrary = do
    n <- chooseInt (1, 12)
    let i = chooseInt (0, n - 1)
    Input . (,) n <$> listOf ((,) <$> i <*> i)

main :: IO ()
main = runChecks
  [ eq "no swaps: the identity"            (swaps 3 []) [0, 1, 2]
  , eq "one swap"                          (swaps 3 [(0, 2)]) [2, 1, 0]
  , eq "later swaps apply to earlier images" (swaps 3 [(0, 1), (1, 2)]) [2, 0, 1]
  , eq "a swap with itself changes nothing" (swaps 3 [(1, 1)]) [0, 1, 2]
  , eq "swaps' with no swaps"              (map (swaps' 3 []) [0, 1, 2]) [0, 1, 2]
  , eq "swaps' applies them in order too"  (map (swaps' 3 [(0, 1), (1, 2)]) [0, 1, 2]) [2, 0, 1]
  , prop "both ways agree" $ \(Input (n, ps)) -> map (swaps' n ps) [0 .. n - 1] == swaps n ps
  ]
