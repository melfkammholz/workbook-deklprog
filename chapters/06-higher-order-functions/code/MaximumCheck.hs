{-# LANGUAGE ScopedTypeVariables #-}
import Prelude hiding (maximum)
import qualified Prelude as P
import Workbook.Check
import Maximum

main :: IO ()
main = runChecks
  [ eq "maximum [3, 1, 4, 1, 5] = 5"   (maximum [3, 1, 4, 1, 5]) 5
  , eq "maximum [7] = 7"               (maximum [7]) 7
  , eq "maximum [-3, -5] = -3"         (maximum [-3, -5]) (-3)
  , eq "maximum [2, 9, 9] = 9"         (maximum [2, 9, 9]) 9
  , prop "agrees with Prelude.maximum" $ \(NonEmpty (xs :: [Int])) ->
      maximum xs == P.maximum xs
  ]
