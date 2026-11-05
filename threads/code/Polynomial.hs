module Polynomial where

import Prelude hiding (last, zipWith)
import Data.List (dropWhileEnd)
import Data.List.NonEmpty (NonEmpty (..), last, singleton, toList)

-- | Represents a polynomial.
data PolyE a = Const a             -- ^ Constant polynomial
             | T                   -- ^ Variable
             | PolyE a :+: PolyE a -- ^ Sum of two polynomials
             | PolyE a :-: PolyE a -- ^ Subtraction of two polynomials
             | PolyE a :*: PolyE a -- ^ Product of two polynomials
  deriving (Eq, Show)

infixl 6 :+:
infixl 6 :-:
infixl 7 :*:

-- | This Num instance allows you to write polynomials in terms of (+), (-), (*)
-- and integers instead of (:+:), (:-:), (:*:) and Const c. E.g., you can
-- write `(T - 3) * (T + 2)` instead of `(T :-: Const 3) :*: (T :+: Const 2)`.
instance Num a => Num (PolyE a) where
  (+) = (:+:)
  (-) = (:-:)
  (*) = (:*:)
  abs = undefined
  signum = undefined
  fromInteger = Const . fromInteger

-- | Adds two polynomials given their coefficients.
polyadd :: Num a => [a] -> [a] -> [a]
#ifdef TEMPLATE polynomial-roots
polyadd = undefined
#else
polyadd []     ys     = ys
polyadd xs     []     = xs
polyadd (x:xs) (y:ys) = x + y : polyadd xs ys
#endif

-- | Subtracts two polynomials given their coefficients.
polysub :: Num a => [a] -> [a] -> [a]
#ifdef TEMPLATE polynomial-roots
polysub = undefined
#else
polysub []     ys     = map negate ys
polysub xs     []     = xs
polysub (x:xs) (y:ys) = x - y : polysub xs ys
#endif

-- | Multiplies two polynomials given their coefficients.
polymul :: Num a => [a] -> [a] -> [a]
#ifdef TEMPLATE polynomial-roots
polymul = undefined
#else
polymul []     _  = []
polymul _      [] = []
polymul (a:as) bs = polyadd (map (a *) bs) (0 : polymul as bs)
#endif

-- | A polynomial in normal form: the coefficients [a_0, a_1, ..., a_n], without
-- trailing zeros.
newtype Poly a = MkPoly { coeffs :: NonEmpty a }
  deriving (Eq, Show)

-- | Smart constructor for polynomials.
poly :: (Eq a, Num a) => [a] -> Poly a
poly []     = MkPoly (0 :| [])
poly (c:cs) = MkPoly (c :| dropWhileEnd (== 0) cs)

-- | The degree of a polynomial.
degree :: Poly a -> Int
degree p = length (coeffs p) - 1

-- | The leading coefficient of a polynomial.
leading :: Poly a -> a
leading = last . coeffs

-- | The absolute term of a polynomial.
absolute :: Poly a -> a
absolute (MkPoly (c :| _)) = c

-- | Normalizes a polynomial.
fromPolyE :: (Eq a, Num a) => PolyE a -> Poly a
#ifdef TEMPLATE polynomial-roots
fromPolyE = undefined
#else
fromPolyE = poly . go
  where
    go (Const c)   = [c]
    go T           = [0, 1]
    go (p1 :+: p2) = polyadd (go p1) (go p2)
    go (p1 :-: p2) = polysub (go p1) (go p2)
    go (p1 :*: p2) = polymul (go p1) (go p2)
#endif

instance (Eq a, Num a) => Num (Poly a) where
  p1 + p2 = poly (polyadd (toList (coeffs p1)) (toList (coeffs p2)))
  p1 - p2 = poly (polysub (toList (coeffs p1)) (toList (coeffs p2)))
  p1 * p2 = poly (polymul (toList (coeffs p1)) (toList (coeffs p2)))
  abs = undefined
  signum = undefined
  fromInteger = MkPoly . singleton . fromInteger

-- | Evaluates a polynomial at a given point using Horner's method.
horner :: Num a => Poly a -> a -> a
#ifdef TEMPLATE polynomial-roots
horner = undefined
#else
horner p x = foldr (\c r -> c + x * r) 0 (coeffs p)
#endif

-- | All positive divisors of a positive number.
divisors :: Integral a => a -> [a]
#ifdef TEMPLATE polynomial-roots
divisors = undefined
#else
divisors a = [d | d <- takeWhile (<= a) [1 ..], a `mod` d == 0]
#endif

-- | The integer roots of a polynomial, by testing the divisors of its absolute term.
roots :: Integral a => PolyE a -> [a]
#ifdef TEMPLATE polynomial-roots
roots = undefined
#else
roots pe = filter (\x -> horner p x == 0) (map negate (reverse ds) ++ [0] ++ ds)
  where
    p = fromPolyE pe
    -- If a_0 = 0, then t divides p, and the other roots divide the first non-zero coefficient.
    ds = case dropWhile (== 0) (toList (coeffs p)) of
      []    -> []
      a : _ -> divisors (abs a)
#endif
