{-# LANGUAGE ScopedTypeVariables #-}
import Workbook.Check
import Queue

toList :: Queue a -> [a]
toList q | isEmpty q = []
         | otherwise = front q : toList (dequeue q)

fromList :: [a] -> Queue a
fromList = foldl (flip enqueue) empty

-- Just x enqueues, Nothing dequeues if there is something to dequeue.
step :: (Queue Int, [Int]) -> Maybe Int -> (Queue Int, [Int])
step (q, xs) (Just x) = (enqueue x q, xs ++ [x])
step (q, xs) Nothing
  | null xs   = (q, xs)
  | otherwise = (dequeue q, tail xs)

main :: IO ()
main = runChecks
  [ check "empty is empty"                  (isEmpty (empty :: Queue Int))
  , check "enqueue makes it non-empty"      (not (isEmpty (enqueue 1 (empty :: Queue Int))))
  , eq "front is the first one enqueued"    (front (fromList [1, 2, 3 :: Int])) 1
  , eq "dequeue removes the first one"      (front (dequeue (fromList [1, 2, 3 :: Int]))) 2
  , check "dequeue can empty it again"      (isEmpty (dequeue (fromList [1 :: Int])))
  , eq "first in, first out"                (toList (fromList [1, 2, 3 :: Int])) [1, 2, 3]
  , prop "behaves like a list under any operations" $ \(ops :: [Maybe Int]) ->
      let (q, xs) = foldl step (empty, []) ops in toList q == xs
  , eq "stays fast: 20000 elements in and out" (sum (toList (fromList [1 .. 20000 :: Int]))) 200010000
  , check "invariant: after enqueue, the dequeue list is not empty"
      (case enqueue 1 (empty :: Queue Int) of Q xs _ -> not (null xs))
  ]
