{-# LANGUAGE TemplateHaskell #-}
module ToList where

import Test.QuickCheck

data Tree a = Leaf a | Tree a :+: Tree a
  deriving (Eq, Show)

instance Arbitrary a => Arbitrary (Tree a) where
  arbitrary = oneof [ Leaf <$> arbitrary
                    , (:+:) <$> arbitrary <*> arbitrary
                    ]

-- | Fertig und korrekt: die Summe aller Zahlen im Baum.
sumTree :: Tree Int -> Int
sumTree (Leaf x)  = x
sumTree (l :+: r) = sumTree l + sumTree r

-- | Fertig und korrekt: spiegelt einen Baum.
mirrorTree :: Tree Int -> Tree Int
mirrorTree (Leaf x)  = Leaf x
mirrorTree (l :+: r) = mirrorTree r :+: mirrorTree l

-- | Alle Zahlen des Baums, von links nach rechts.
toList :: Tree Int -> [Int]
#ifdef TEMPLATE
toList = const [1, 2, 3]
#else
toList (Leaf x)  = [x]
toList (l :+: r) = toList l ++ toList r
#endif

-- Eigenschaften: Namen beginnen mit prop_
#ifdef TEMPLATE
-- prop_toListLeaf :: Int -> Bool
-- prop_toListLeaf x = ...
#else
prop_toListLeaf :: Int -> Bool
prop_toListLeaf x = toList (Leaf x) == [x]

prop_toListNode :: Tree Int -> Tree Int -> Bool
prop_toListNode l r = toList (l :+: r) == toList l ++ toList r

prop_toListSum :: Tree Int -> Bool
prop_toListSum t = sum (toList t) == sumTree t

prop_toListMirror :: Tree Int -> Bool
prop_toListMirror t = toList (mirrorTree t) == reverse (toList t)
#endif

return []

runTests :: IO Bool
runTests = $quickCheckAll
