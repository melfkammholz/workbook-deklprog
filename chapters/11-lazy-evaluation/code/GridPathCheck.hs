import Workbook.Check
import GridPath

main :: IO ()
main = runChecks
  [ eq "the example"             (pathsum [[1, 2, 3, 4], [-8, 4, 6, 1], [5, 2, 3, 4 :: Int]]) 6
  , eq "one cell"                (pathsum [[7 :: Int]]) 7
  , eq "one row"                 (pathsum [[1, 2, 3 :: Int]]) 6
  , eq "one column"              (pathsum [[1], [2], [3 :: Int]]) 6
  , eq "stays fast: a 40x40 grid" (pathsum (replicate 40 (replicate 40 (1 :: Int)))) 79
  ]
