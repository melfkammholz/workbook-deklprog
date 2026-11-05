import Data.Functor.Identity (Identity (..))
import Data.List (sort, uncons)
import Prelude hiding (elem)
import Workbook.Check
import Search

-- 0 -> 1 -> 3, 0 -> 2 -> 3, 3 -> 4
next :: Int -> [Int]
next 0 = [1, 2]
next 1 = [3]
next 2 = [3]
next 3 = [4]
next _ = []

-- Depth first goes 0, 1, 3, 4, but 0, 2, 4 is shorter.
branches :: Int -> [Int]
branches 0 = [1, 2]
branches 1 = [3]
branches 2 = [4]
branches 3 = [4]
branches _ = []

run :: (Int -> Identity [Int]) -> Int -> (Maybe [Int], [Int])
run n target = runIdentity (bfsM n (Identity . (== target)) 0)

main :: IO ()
main = runChecks
  [ eq "trace goes from the start to the place" (trace 3 [(3, 2), (2, 1), (1, 1 :: Int)]) [1, 2, 3]
  , eq "trace of the start"                 (trace 1 [(1, 1 :: Int)]) [1]
  , eq "search finds a path"                (fst (search (:) uncons next (== 4) 0) >>= Just . last) (Just 4)
  , eq "a path starts at the start"         (fmap head (fst (search (:) uncons next (== 4) 0))) (Just 0)
  , eq "search without a goal finds nothing" (fst (search (:) uncons next (== 9) 0)) Nothing
  , eq "search without a goal sees everything" (sort (snd (search (:) uncons next (== 9) 0))) [0, 1, 2, 3, 4]
  , eq "search ends on a cycle"             (fst (search (:) uncons (\i -> [(i + 1) `mod` 3]) (== 9) (0 :: Int))) Nothing
  , eq "bfsM finds a shortest path"         (fmap length (fst (run (Identity . next) 3))) (Just 3)
  , eq "bfsM takes the shorter way"         (fst (run (Identity . branches) 4)) (Just [0, 2, 4])
  , eq "dfsM visits the first branch first" (fst (runIdentity (dfsM (Identity . next) (Identity . (== 3)) 0))) (Just [0, 1, 3])
  , check "elem finds an element"           (elem 3 [1, 2, 3 :: Int])
  , check "elem without the element"        (not (elem 4 [1, 2, 3 :: Int]))
  ]
