module RegExpGen (randomWord, WithPositiveSample (..)) where

import RegExp
import Test.QuickCheck

instance Arbitrary RegExp where
#ifdef TEMPLATE
  arbitrary = undefined
#else
  arbitrary = sized $ \n -> do
    -- We use Kleene sparingly, since it allows random words to grow quickly.
    f <- frequency [(1, return Kleene), (9, return id)]
    case n of
      0 -> return Epsilon
      1 -> fmap (f . Let) (elements ['a' .. 'z'])
      _ -> do
        k <- chooseInt (1, n)
        l <- resize k arbitrary
        r <- resize (n - k) arbitrary
        op <- elements [(:|:), (:*:)]
        return (f (op l r))
#endif

-- | A random word of the language. The language must not be empty.
randomWord :: RegExp -> Gen String
#ifdef TEMPLATE
randomWord r = undefined
#else
randomWord Empty       = error "the language is empty"
randomWord Epsilon     = return ""
randomWord (Let c)     = return [c]
randomWord (r1 :|: r2) = elements [r1, r2] >>= randomWord
randomWord (r1 :*: r2) = (++) <$> randomWord r1 <*> randomWord r2
randomWord (Kleene r)  = do
  k <- chooseInt (0, 3)
  concat <$> vectorOf k (randomWord r)
#endif

newtype WithPositiveSample = WithPositiveSample (RegExp, String)
  deriving Show

instance Arbitrary WithPositiveSample where
#ifdef TEMPLATE
  arbitrary = undefined
#else
  arbitrary = do
    re <- arbitrary
    w <- randomWord re
    return (WithPositiveSample (re, w))
#endif
