module Unfoldr (unfoldr, bits, map) where

import Prelude hiding (map)

-- | Builds a list from a value, until the function gives Nothing.
unfoldr :: (b -> Maybe (a, b)) -> b -> [a]
#ifdef TEMPLATE
unfoldr f b = undefined
#else
unfoldr f b = case f b of
  Nothing      -> []
  Just (a, b') -> a : unfoldr f b'
#endif

-- | The binary digits of a natural number, least significant bit first.
bits :: Int -> [Int]
#ifdef TEMPLATE
bits n = undefined
#else
bits = unfoldr (\n -> if n == 0 then Nothing else Just (n `mod` 2, n `div` 2))
#endif

-- | map, written with unfoldr.
map :: (a -> b) -> [a] -> [b]
#ifdef TEMPLATE
map f xs = undefined
#else
map f = unfoldr step
  where
    step []     = Nothing
    step (x:xs) = Just (f x, xs)
#endif
