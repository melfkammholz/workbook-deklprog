module FixedPoint (iterate, heron, fibs, resolve, sort) where

import Prelude hiding (iterate)

iterate :: (a -> a) -> a -> [a]
#ifdef TEMPLATE
iterate f x = undefined
#else
iterate f x = x : iterate f (f x)
#endif

-- | The square root of a > 0, up to the given epsilon.
heron :: Double -> Double -> Double
#ifdef TEMPLATE
heron eps a = undefined
#else
heron eps a = prec (iterate (\x -> (x + a / x) / 2) a)
  where
    prec (x : y : xs)
      | abs (x - y) < eps = y
      | otherwise         = prec (y : xs)
    prec _ = error "iterate is infinite"
#endif

fibs :: [Integer]
#ifdef TEMPLATE
fibs = undefined
#else
fibs = map fst (iterate (\(a, b) -> (b, a + b)) (0, 1))
#endif

-- | Resolves one inversion, if there is one.
resolve :: Ord a => [a] -> [a]
#ifdef TEMPLATE
resolve xs = undefined
#else
resolve (x : y : xs)
  | x > y     = y : x : xs
  | otherwise = x : resolve (y : xs)
resolve xs = xs
#endif

sort :: Ord a => [a] -> [a]
#ifdef TEMPLATE
sort xs = undefined
#else
sort xs = fixed (iterate resolve xs)
  where
    fixed (a : b : rest)
      | a == b    = a
      | otherwise = fixed (b : rest)
    fixed _ = error "iterate is infinite"
#endif
