{-# LANGUAGE TemplateHaskell #-}
module MirrorTree where

import Test.QuickCheck

data Tree a = Leaf a | Tree a :+: Tree a
  deriving (Eq, Show)

instance Arbitrary a => Arbitrary (Tree a) where
  arbitrary = oneof [ Leaf <$> arbitrary
                    , (:+:) <$> arbitrary <*> arbitrary
                    ]

-- | Sums all labels of leaves (from a previous exercise).
sumTree :: Tree Int -> Int
sumTree (Leaf x)  = x
sumTree (l :+: r) = sumTree l + sumTree r

-- | Mirrors a tree.
mirrorTree :: Tree Int -> Tree Int
#ifdef TEMPLATE
mirrorTree = id
#else
mirrorTree (Leaf x)  = Leaf x
mirrorTree (l :+: r) = mirrorTree r :+: mirrorTree l
#endif

#ifdef TEMPLATE
-- TODO Specify properties.
#else
prop_mirrorLeaf :: Int -> Bool
prop_mirrorLeaf x = mirrorTree (Leaf x) == Leaf x

prop_mirrorNode :: Tree Int -> Tree Int -> Bool
prop_mirrorNode l r = mirrorTree (l :+: r) == mirrorTree r :+: mirrorTree l

prop_mirrorTwice :: Tree Int -> Bool
prop_mirrorTwice t = mirrorTree (mirrorTree t) == t

prop_mirrorSum :: Tree Int -> Bool
prop_mirrorSum t = sumTree (mirrorTree t) == sumTree t
#endif

return []

runTests :: IO Bool
runTests = $quickCheckAll
