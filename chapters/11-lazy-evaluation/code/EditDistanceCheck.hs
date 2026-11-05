{-# LANGUAGE ScopedTypeVariables #-}
import Workbook.Check
import EditDistance

main :: IO ()
main = runChecks
  [ eq "two empty words"            (editdist "" "") 0
  , eq "one empty word"             (editdist "abc" "") 3
  , eq "the other empty word"       (editdist "" "abc") 3
  , eq "the same word"              (editdist "abc" "abc") 0
  , eq "kitten and sitting"         (editdist "kitten" "sitting") 3
  , eq "works for other types"      (editdist [1, 2, 3] [1, 3 :: Int]) 1
  , prop "it is symmetric" $ \(a :: [Bool]) (b :: [Bool]) ->
      let (x, y) = (take 12 a, take 12 b) in editdist x y == editdist y x
  , eq "stays fast: memoized for 60 letters" (editdist (replicate 60 'a') (replicate 60 'b')) 60
  ]
