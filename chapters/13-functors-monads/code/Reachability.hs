module Reachability (Graph (..), succs, reachable, yGraph) where

import Prelude hiding (sequence)

data Graph a b = Graph [(Int, a)] [(Int, b, Int)]
  deriving Show

succs :: Int -> Graph a b -> [Int]
#ifdef TEMPLATE
succs v g = undefined
#else
succs v (Graph _ es) = [w | (u, _, w) <- es, u == v]
#endif

reachable :: Int -> Int -> Graph a b -> Bool
#ifdef TEMPLATE
reachable v w g = undefined
#else
reachable v w g = fst (go v [])
  where
    go u us
      | u == w      = (True, us)
      | u `elem` us = (False, us)
      | otherwise   = let (rs, us') = sequence (map go (succs u g)) (u : us)
                       in (or rs, us')

    sequence []     s = ([], s)
    sequence (f:fs) s =
      let (y, s')   = f s
          (ys, s'') = sequence fs s'
       in (y : ys, s'')
#endif

yGraph :: Int -> Graph () ()
yGraph k = Graph [(v, ()) | v <- [0 .. 2 * k]]
                 (let left = [(v, (), v + 1) | v <- [1 .. k - 1]]
                      right = [(v, (), v + 1) | v <- [k + 1 .. 2 * k - 1]]
                   in (0, (), 1) : (0, (), k + 1) : (left ++ right))
