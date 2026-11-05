module LinearAlgebra where

import Data.Bifunctor (bimap)
import Data.List (singleton, transpose)
import Data.Maybe (fromMaybe)

newtype Mat a = Mat [[a]]
  deriving (Eq, Show)

instance Functor Mat where
  -- Applies f to each component of A
  fmap f (Mat a) = Mat (fmap (fmap f) a)

-- | All columns of A
cols :: Mat a -> [Mat a]
cols (Mat as) = map (Mat . transpose . singleton) (transpose as)

-- | The size of A
size :: Mat a -> (Int, Int)
size (Mat as) = (length as, length (head as))

-- | The identity of size n x n
identity :: Num a => Int -> Mat a
identity 1 = Mat [[1]]
identity n = Mat ((1 : replicate (n - 1) 0) : map (0 :) i)
  where Mat i = identity (n - 1)

-- | The main diagonal of A
diag :: Mat a -> [a]
diag (Mat [])           = []
diag (Mat ([] : _))     = []
diag (Mat ((d : _) : rs)) = d : diag (Mat (map tail rs))

-- | Vertically stacks two matrices.
vstack :: Mat a -> Mat a -> Mat a
#ifdef TEMPLATE block-matrices
vstack = undefined
#else
vstack (Mat as) (Mat bs) = Mat (as ++ bs)
#endif

-- | Horizontally stacks two matrices A, B to |A B|.
hstack :: Mat a -> Mat a -> Mat a
#ifdef TEMPLATE block-matrices
hstack = undefined
#else
hstack (Mat as) (Mat bs) = Mat (zipWith (++) as bs)
#endif

-- | Computes A = |a B|, where a is the first column of A and B the remaining submatrix.
hsplit1 :: Mat a -> (Mat a, Mat a)
#ifdef TEMPLATE block-matrices
hsplit1 = undefined
#else
hsplit1 (Mat [])                = (Mat [], Mat [])
hsplit1 (Mat ((a11 : a1x) : a)) = (Mat ([a11] : ax1), Mat (a1x : axx))
  where (Mat ax1, Mat axx) = hsplit1 (Mat a)
#endif

-- | Computes A = |B a|, where a is the last column of A and B the remaining submatrix.
hsplitn :: Mat a -> (Mat a, Mat a)
#ifdef TEMPLATE block-matrices
hsplitn = undefined
#else
hsplitn (Mat [])       = (Mat [], Mat [])
hsplitn (Mat (a1 : a)) = (Mat (init a1 : axx), Mat ([last a1] : axn))
  where (Mat axx, Mat axn) = hsplitn (Mat a)
#endif

-- | Computes A = |B|
--              |a|, where a is the last row of A and B the remaining submatrix.
vsplitn :: Mat a -> (Mat a, Mat a)
#ifdef TEMPLATE block-matrices
vsplitn = undefined
#else
vsplitn (Mat [])    = (Mat [], Mat [])
vsplitn (Mat [a])   = (Mat [], Mat [a])
vsplitn (Mat (a1x : a)) = (Mat (a1x : axx), manx)
  where (Mat axx, manx) = vsplitn (Mat a)
#endif

-- | Computes A = |a11 a1x|
--               |ax1 axx|
unblock :: Mat a -> (Mat a, Mat a, Mat a, Mat a)
#ifdef TEMPLATE block-matrices
unblock = undefined
#else
unblock (Mat ((a11 : a1x) : axx)) = (Mat [[a11]], Mat [a1x], max1, maxx)
  where (max1, maxx) = hsplit1 (Mat axx)
unblock _ = error "unblock: empty matrix"
#endif

-- | Computes A = |axx anx|
--               |axn ann|
unblock' :: Mat a -> (Mat a, Mat a, Mat a, Mat a)
#ifdef TEMPLATE block-matrices
unblock' = undefined
#else
unblock' a = (maxx, manx, maxn, mann)
  where
    (ma, man) = hsplitn a
    (maxx, maxn) = vsplitn ma
    (manx, mann) = vsplitn man
#endif

-- | Computes |A B|
--            |C D| given A, B, C, D.
block :: (Mat a, Mat a, Mat a, Mat a) -> Mat a
#ifdef TEMPLATE block-matrices
block = undefined
#else
block (a, b, c, d) = vstack (hstack a b) (hstack c d)
#endif

instance Num a => Num (Mat a) where
#ifdef TEMPLATE tropical
  (+) = undefined
  (-) = undefined
  (*) = undefined
  abs = undefined
  signum = undefined
  fromInteger = undefined
#else
  Mat a + Mat b = Mat (zipWith (zipWith (+)) a b)
  Mat a - Mat b = Mat (zipWith (zipWith (-)) a b)
  Mat a * Mat b = Mat [map (dot r) (transpose b) | r <- a]
    where dot x y = foldl1 (+) (zipWith (*) x y)

  abs = undefined
  signum = undefined
  fromInteger = undefined
#endif

-- | The LR decomposition of A, if our procedure finds one.
lu :: (Eq a, Fractional a) => Mat a -> Maybe (Mat a, Mat a)
#ifdef TEMPLATE lr-decomposition
lu = undefined
#else
lu a@(Mat [[a11]])
  | a11 == 0  = Nothing
  | otherwise = Just (Mat [[1]], a)
lu a
  | a11 == 0  = Nothing
  | otherwise = fmap (bimap (\lxx -> block (l11, l1x, lx1, lxx)) (\rxx -> block (r11, r1x, rx1, rxx)))
                     (lu (axx - lx1 * r1x))
  where
    (Mat [[a11]], a1x, ax1, axx) = unblock a

    r11 = Mat [[a11]]
    r1x = a1x
    rx1 = fmap (const 0) ax1

    l11 = Mat [[1]]
    lx1 = fmap (/ a11) ax1
    l1x = fmap (const 0) a1x
#endif

-- | The determinant of A.
det :: (Eq a, Fractional a) => Mat a -> a
#ifdef TEMPLATE lr-decomposition
det = undefined
#else
det = fromMaybe 0 . fmap (product . diag . snd) . lu
#endif

-- | Solves Lx = b.
forward :: Fractional a => Mat a -> Mat a -> Mat a
#ifdef TEMPLATE lr-decomposition
forward = undefined
#else
forward (Mat [[l11]]) (Mat [[b1]]) = Mat [[b1 / l11]]
forward l b = Mat ([x1] : xx)
  where
    (Mat [[l11]], _, lx1, lxx) = unblock l
    (Mat [b1], Mat bx) = (Mat [head rows], Mat (tail rows))
      where Mat rows = b
    x1 = head b1 / l11
    Mat xx = forward lxx (Mat bx - fmap (x1 *) lx1)
#endif

-- | Solves Rx = b.
backward :: Fractional a => Mat a -> Mat a -> Mat a
#ifdef TEMPLATE lr-decomposition
backward = undefined
#else
backward (Mat [[r11]]) (Mat [[b1]]) = Mat [[b1 / r11]]
backward r b = Mat (xx ++ [[xn]])
  where
    (rxx, rxn, _, Mat [[rnn]]) = unblock' r
    Mat rows = b
    bx = Mat (init rows)
    bn = head (last rows)
    xn = bn / rnn
    Mat xx = backward rxx (bx - fmap (xn *) rxn)
#endif

-- | Solves AX = B.
solve :: (Eq a, Fractional a) => Mat a -> Mat a -> Maybe (Mat a)
#ifdef TEMPLATE lr-decomposition
solve = undefined
#else
solve a b = fmap solve' (lu a)
  where solve' (l, r) = foldr1 hstack (map (backward r . forward l) (cols b))
#endif

-- | The inverse of A.
inv :: (Eq a, Fractional a) => Mat a -> Maybe (Mat a)
#ifdef TEMPLATE lr-decomposition
inv = undefined
#else
inv a = solve a (identity n)
  where (n, _) = size a
#endif
