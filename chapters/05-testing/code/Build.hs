{-# LANGUAGE TemplateHaskell #-}
module Build where

import Test.QuickCheck

data Tree a = Leaf a | Tree a :+: Tree a
  deriving (Eq, Show)

instance Arbitrary a => Arbitrary (Tree a) where
  arbitrary = oneof [ Leaf <$> arbitrary
                    , (:+:) <$> arbitrary <*> arbitrary
                    ]

-- | Converts a tree into a list. 
toList :: Tree a -> [a]
toList (Leaf x)  = [x]
toList (l :+: r) = toList l ++ toList r

-- | Computes the height of a tree.
height :: Tree a -> Int
height (Leaf _)  = 0
height (l :+: r) = 1 + max (height l) (height r)

-- | Checks whether a tree is balanced.
balanced :: Tree a -> Bool
#ifdef TEMPLATE
balanced = undefined
#else
balanced (Leaf _)  = True
balanced (l :+: r) = balanced l && balanced r && abs (height l - height r) <= 1
#endif

-- | Builds a balanced tree.
build :: [a] -> Tree a
#ifdef TEMPLATE
build xs = foldr1 (:+:) (map Leaf xs)
#else
build [x] = Leaf x
build xs  = build l :+: build r
  where (l, r) = splitAt (length xs `div` 2) xs
#endif

#ifdef TEMPLATE
-- TODO Specify properties.
#else
prop_buildToList :: [Int] -> Property
prop_buildToList xs = not (null xs) ==> toList (build xs) == xs

prop_buildBalanced :: [Int] -> Property
prop_buildBalanced xs = not (null xs) ==> balanced (build xs)
#endif

return []

runTests :: IO Bool
runTests = $quickCheckAll
