{-# LANGUAGE ScopedTypeVariables #-}
import Workbook.Check
import FoldTree

t :: Tree Int String
t = Node "x" [Leaf 3, Node "y" [Leaf 4, Empty], Leaf 5]

instance (Arbitrary a, Arbitrary b) => Arbitrary (Tree a b) where
  arbitrary = sized go
    where
      go 0 = oneof [pure Empty, Leaf <$> arbitrary]
      go n = frequency
        [ (1, pure Empty)
        , (2, Leaf <$> arbitrary)
        , (3, do k <- choose (0, 3)
                 Node <$> arbitrary <*> vectorOf k (go (n `div` 2)))
        ]

-- The signature the task asks for. The starter has none, so the tests fix it here.
typedFoldTree :: r -> (a -> r) -> (b -> [r] -> r) -> Tree a b -> r
typedFoldTree = foldTree

main :: IO ()
main = runChecks
  [ eq "count the leaves of t"   (typedFoldTree 0 (const 1) (\_ rs -> sum rs) t) (3 :: Int)
  , eq "add up the leaves of t"  (typedFoldTree 0 id (\_ rs -> sum rs) t) 12
  , eq "height of t"             (typedFoldTree 0 (const 1) (\_ rs -> 1 + maximum (0 : rs)) t) (3 :: Int)
  , eq "node labels of t"        (typedFoldTree [] (const []) (\x rs -> x : concat rs) t) ["x", "y"]
  , eq "folding Empty gives the first argument" (typedFoldTree 'e' (const 'l') (\_ _ -> 'n') (Empty :: Tree Int Int)) 'e'
  , eq "foldTree Empty Leaf Node t = t" (typedFoldTree Empty Leaf Node t) t
  , prop "foldTree Empty Leaf Node is the identity" $ \(u :: Tree Int Bool) ->
      typedFoldTree Empty Leaf Node u == u
  ]
