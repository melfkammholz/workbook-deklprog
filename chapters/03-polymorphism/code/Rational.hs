module Rational (Ratio, ratio, numerator, denominator, add, sub, mul, divide, toDecimal) where

#ifdef TEMPLATE
-- | Add the constructors of your data type here.
data Ratio

-- | Builds a normalised number from a numerator and a denominator other than 0.
ratio :: Integer -> Integer -> Ratio
ratio p q = undefined

numerator, denominator :: Ratio -> Integer
numerator r = undefined
denominator r = undefined

add, sub, mul, divide :: Ratio -> Ratio -> Ratio
add a b = undefined
sub a b = undefined
mul a b = undefined
divide a b = undefined

-- | Shows the number with the given number of decimal places, cutting off the rest.
toDecimal :: Int -> Ratio -> String
toDecimal n r = undefined
#else
data Ratio = Ratio Integer Integer

ratio :: Integer -> Integer -> Ratio
ratio p q = Ratio (signum q * p `div` d) (abs q `div` d)
  where d = gcd p q

numerator, denominator :: Ratio -> Integer
numerator (Ratio p _) = p
denominator (Ratio _ q) = q

add, sub, mul, divide :: Ratio -> Ratio -> Ratio
add (Ratio a b) (Ratio c d) = ratio (a * d + c * b) (b * d)
sub (Ratio a b) (Ratio c d) = ratio (a * d - c * b) (b * d)
mul (Ratio a b) (Ratio c d) = ratio (a * c) (b * d)
divide (Ratio a b) (Ratio c d) = ratio (a * d) (b * c)

toDecimal :: Int -> Ratio -> String
toDecimal n (Ratio p q) = sign ++ show whole ++ "." ++ places n rest
  where
    sign = if p < 0 then "-" else ""
    (whole, rest) = abs p `divMod` q
    places 0 _ = ""
    places k r = show (r * 10 `div` q) ++ places (k - 1) (r * 10 `mod` q)
#endif
