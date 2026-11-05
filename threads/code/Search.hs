module Search where

import Data.Functor.Identity (Identity (..))
import Data.List (insert, uncons)
import Data.Maybe (fromJust)
import Prelude hiding (elem)
import qualified Prelude as P

-- | Follows the map from a place to its predecessor back to where the search
-- began, which is its own predecessor. The result goes from there to the given place.
trace :: Eq a => a -> [(a, a)] -> [a]
#ifdef TEMPLATE search
trace x parent = undefined
#else
trace x parent = go x [x]
  where
    go v path =
      let p = fromJust (lookup v parent)
       in if p == v then path else go p (p : path)
#endif

searchM :: (Eq a, Monad m)
  => (a -> [a] -> [a])        -- push
  -> ([a] -> Maybe (a, [a]))  -- pop
  -> (a -> m [a])             -- next
  -> (a -> m Bool)            -- found
  -> a                        -- start
  -> m (Maybe [a], [a])       -- path, visited
#ifdef TEMPLATE search
searchM push pop next found start = undefined
#else
searchM push pop next found start = go [start] [(start, start)] [start]
  where
    go places parent visited =
      case pop places of
        Nothing -> return (Nothing, visited)
        Just (curr, places') -> do
          end <- found curr
          if end
            then return (Just (trace curr parent), visited)
            else do
              ns <- next curr
              let new = dedupe (filter (`notElem` visited) ns)
              go (foldr push places' new)
                 ([(n, curr) | n <- new] ++ parent)
                 (new ++ visited)

    dedupe []     = []
    dedupe (x:xs) = x : dedupe (filter (/= x) xs)
#endif

search :: Eq a
  => (a -> [a] -> [a])
  -> ([a] -> Maybe (a, [a]))
  -> (a -> [a])
  -> (a -> Bool)
  -> a
  -> (Maybe [a], [a])
#ifdef TEMPLATE search
search push pop next found start = undefined
#else
search push pop next found = runIdentity . searchM push pop (Identity . next) (Identity . found)
#endif

elem :: Eq a => a -> [a] -> Bool
#ifdef TEMPLATE search
elem x xs = undefined
#else
elem x xs =
  case search (:) uncons (\i -> [i + 1 | i + 1 < length xs]) (\i -> i < length xs && xs !! i == x) 0 of
    (Just _, _) -> True
    _           -> False
#endif

dfsM :: (Eq a, Monad m) => (a -> m [a]) -> (a -> m Bool) -> a -> m (Maybe [a], [a])
#ifdef TEMPLATE search
dfsM = undefined
#else
dfsM = searchM (:) uncons
#endif

bfsM :: (Eq a, Monad m) => (a -> m [a]) -> (a -> m Bool) -> a -> m (Maybe [a], [a])
#ifdef TEMPLATE search
bfsM = undefined
#else
bfsM = searchM (\x xs -> xs ++ [x]) uncons
#endif

-- | The example graph: for every node, its outgoing edges as (weight, target).
g :: [[(Int, Int)]]
g = [ [(23, 1), (8, 2)]
    , [(1, 2), (5, 3)]
    , [(30, 3)]
    , []
    ]

shortestPath :: [[(Int, Int)]] -> Int -> Int -> Maybe Int
shortestPath graph from to =
  let result = search push pop next stop (0, from)
   in case result of
        (Nothing,   _) -> Nothing
        (Just path, _) -> Just (fst (last path))
  where
    push (d, v) pq
      | v `notElem` map snd pq = insert (d, v) pq
      | otherwise = map (\(d', w) -> if v == w then (min d d', v) else (d', w)) pq
    pop = uncons
    next (d, v) = map (\(w, u) -> (d + w, u)) (graph !! v)
    stop (_, v) = v == to
