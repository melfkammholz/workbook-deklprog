module LogFib (Mat22 (..), fib) where

data Mat22 a = Mat22 a a a a
  deriving (Eq, Show)

-- | The instance from the exercise before. Copy yours here.
instance Num a => Num (Mat22 a) where
  Mat22 a b c d + Mat22 e f g h = Mat22 (a + e) (b + f) (c + g) (d + h)
  Mat22 a b c d - Mat22 e f g h = Mat22 (a - e) (b - f) (c - g) (d - h)
  Mat22 a b c d * Mat22 e f g h = Mat22 (a * e + b * g) (a * f + b * h) (c * e + d * g) (c * f + d * h)
  abs (Mat22 a b c d) = Mat22 (abs a) (abs b) (abs c) (abs d)
  signum (Mat22 a b c d) = Mat22 (signum a) (signum b) (signum c) (signum d)
  fromInteger n = Mat22 (fromInteger n) 0 0 (fromInteger n)

-- | The n-th Fibonacci number.
fib :: Integer -> Integer
#ifdef TEMPLATE
fib n = undefined
#else
fib n = f
  where Mat22 _ f _ _ = Mat22 1 1 1 0 ^ n
#endif
