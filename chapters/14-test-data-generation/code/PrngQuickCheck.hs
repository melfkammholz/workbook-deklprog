module PrngQuickCheck where

import Data.Bits (shiftL, shiftR, xor)
import Data.Word (Word64)

xorshift64 :: Word64 -> Word64
#ifdef TEMPLATE
xorshift64 x = undefined
#else
xorshift64 z0 = z3
  where
    z1 = z0 `xor` (z0 `shiftL` 13)
    z2 = z1 `xor` (z1 `shiftR` 7)
    z3 = z2 `xor` (z2 `shiftL` 17)
#endif

data PRNG = PRNG Word64
  deriving Show

mkPRNG :: Word64 -> PRNG
mkPRNG s = PRNG (xorshift64 s)

nextInt :: PRNG -> (Int, PRNG)
nextInt (PRNG s) = (fromIntegral r, PRNG r)
  where r = xorshift64 s

newtype Gen a = Gen { unGen :: PRNG -> Int -> (a, PRNG) }

newtype Property = Property { unProperty :: Gen Bool }

class Testable a where
  property :: a -> Property

class Arbitrary a where
  arbitrary :: Gen a

#ifdef TEMPLATE
-- Add the Functor, Applicative and Monad instances for Gen here, the Testable
-- instances, and the Arbitrary instance for Int.

chooseInt :: (Int, Int) -> Gen Int
chooseInt range = undefined

quickCheck :: Testable a => a -> Bool
quickCheck p = undefined
#else
instance Functor Gen where
  fmap f m = Gen (\g s -> let (x, g') = unGen m g s in (f x, g'))

instance Applicative Gen where
  pure x = Gen (\g _ -> (x, g))

  mf <*> mx = Gen (\g s -> let (f, g')  = unGen mf g s
                               (x, g'') = unGen mx g' s
                            in (f x, g''))

instance Monad Gen where
  mx >>= k = Gen (\g s -> let (x, g') = unGen mx g s
                           in unGen (k x) g' s)

chooseInt :: (Int, Int) -> Gen Int
chooseInt (lo, hi) = Gen (\g _ -> let (x, g') = nextInt g
                                   in (lo + x `mod` (hi - lo), g'))

instance Arbitrary Int where
  arbitrary = Gen (\g s -> unGen (chooseInt (-s, s)) g s)

instance Testable Bool where
  property b = Property (return b)

instance Testable Property where
  property = id

instance (Arbitrary a, Testable b) => Testable (a -> b) where
  property f = Property $ do
    x <- arbitrary
    unProperty (property (f x))

quickCheck :: Testable a => a -> Bool
quickCheck p = fst (unGen (unProperty (property p)) (mkPRNG 0x9e3779b97f4a7c15) 30)
#endif
