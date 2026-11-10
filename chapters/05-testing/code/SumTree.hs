{-# LANGUAGE TemplateHaskell #-}
module SumTree where

import Test.QuickCheck

data Tree a = Leaf a | Tree a :+: Tree a
  deriving (Eq, Show)

instance Arbitrary a => Arbitrary (Tree a) where
  arbitrary = oneof [ Leaf <$> arbitrary
                    , (:+:) <$> arbitrary <*> arbitrary
                    ]

-- | The sum of all numbers in a tree.
sumTree :: Tree Int -> Int
#ifdef TEMPLATE
sumTree _ = 0
#else
sumTree (Leaf x)  = x
sumTree (l :+: r) = sumTree l + sumTree r
#endif

#ifdef TEMPLATE
-- TODO Specify properties.
#else
prop_sumLeaf :: Int -> Bool
prop_sumLeaf x = sumTree (Leaf x) == x

prop_sumNode :: Tree Int -> Tree Int -> Bool
prop_sumNode l r = sumTree (l :+: r) == sumTree l + sumTree r
#endif

return []

-- | Runs all tests.
runTests :: IO Bool
runTests = $quickCheckAll
