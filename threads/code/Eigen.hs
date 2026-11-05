module Eigen where

import Data.List (nub, permutations, sort, transpose)
import Polynomial

newtype Mat a = Mat [[a]]
  deriving (Eq, Show)

instance Functor Mat where
  fmap f (Mat a) = Mat (fmap (fmap f) a)

instance Num a => Num (Mat a) where
  Mat a + Mat b = Mat (zipWith (zipWith (+)) a b)
  Mat a - Mat b = Mat (zipWith (zipWith (-)) a b)
  Mat a * Mat b = Mat [[sum (zipWith (*) r c) | c <- transpose b] | r <- a]
  abs = undefined
  signum = undefined
  fromInteger = undefined

at :: Mat a -> (Int, Int) -> a
at (Mat as) (i, j) = as !! i !! j

size :: Mat a -> (Int, Int)
size (Mat as) = (length as, length (head as))

identity :: Num a => Int -> Mat a
identity n = Mat [[if i == j then 1 else 0 | j <- [1 .. n]] | i <- [1 .. n]]

-- | The number of inversions of a permutation.
inv :: (Num b, Ord a) => [a] -> b
#ifdef TEMPLATE eigenvalues
inv = undefined
#else
inv []     = 0
inv (x:xs) = sum [1 | y <- xs, x > y] + inv xs
#endif

-- | The sign of a permutation.
sgn :: (Num b, Ord a) => [a] -> b
#ifdef TEMPLATE eigenvalues
sgn = undefined
#else
sgn p = (-1) ^ (inv p :: Int)
#endif

-- | The determinant, by the Leibniz formula.
det :: Num a => Mat a -> a
#ifdef TEMPLATE eigenvalues
det = undefined
#else
det a = sum [sgn p * product (map (\i -> a `at` (i, p !! i)) [0 .. n - 1]) | p <- ps]
  where
    (n, _) = size a
    ps = permutations [0 .. n - 1]
#endif

-- | The integer eigenvalues of a matrix.
eigen :: Integral a => Mat a -> [a]
#ifdef TEMPLATE eigenvalues
eigen = undefined
#else
eigen a = sort (nub (roots (det (fmap Const a - fmap (T *) (identity n)))))
  where (n, _) = size a
#endif
