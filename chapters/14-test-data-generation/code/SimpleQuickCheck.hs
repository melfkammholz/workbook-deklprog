module SimpleQuickCheck where

newtype Property = Property { unProperty :: Bool }

class Testable a where
  property :: a -> Property

class Arbitrary a where
  arbitrary :: a

instance Arbitrary Int where
  arbitrary = 42  -- Normally, random values are generated here.

#ifdef TEMPLATE
-- Add the Testable instances for Bool, Property and a -> b here.

quickCheck :: Testable a => a -> Bool
quickCheck p = undefined
#else
instance Testable Bool where
  property = Property

instance Testable Property where
  property = id

instance (Arbitrary a, Testable b) => Testable (a -> b) where
  property f = property (f arbitrary)

quickCheck :: Testable a => a -> Bool
quickCheck p = unProperty (property p)
#endif
