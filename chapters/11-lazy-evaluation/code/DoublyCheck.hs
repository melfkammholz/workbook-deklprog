{-# LANGUAGE ScopedTypeVariables #-}
import Workbook.Check
import Doubly

main :: IO ()
main = runChecks
  [ eq "the first element"          (value (fromList [1, 2 :: Int])) (Just 1)
  , eq "next goes forward"          (value (next (fromList [1, 2 :: Int]))) (Just 2)
  , eq "the end is Null"            (value (next (next (fromList [1, 2 :: Int])))) Nothing
  , eq "the start has no prev"      (value (prev (fromList [1, 2 :: Int]))) Nothing
  , eq "an empty list has no value" (value (fromList ([] :: [Int]))) Nothing
  , eq "the example gives Just 8"   (value . prev . next . next . next . next $ fromList [1, 6, 1, 8, 0, 3 :: Int]) (Just 8)
  , prop "next then prev comes back" $ \(x :: Int) (y :: Int) (xs :: [Int]) ->
      value (prev (next (fromList (x : y : xs)))) == Just x
  ]
