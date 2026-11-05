{-# LANGUAGE ScopedTypeVariables #-}
import Data.Set (Set)
import qualified Data.Set as Set
import Workbook.Check hiding ((.&.))
import FA
import RegExp

-- A matcher that knows nothing about automata.
matches :: RegExp -> String -> Bool
matches re str = go re str null
  where
    go Empty      _ _ = False
    go Epsilon    s k = k s
    go (Let c)    s k = case s of
      x : xs -> c == x && k xs
      []     -> False
    go (r :|: t)  s k = go r s k || go t s k
    go (r :*: t)  s k = go r s (\s' -> go t s' k)
    go (Kleene r) s k = k s || go r s (\s' -> s' /= s && go (Kleene r) s' k)

newtype W = W String deriving Show

instance Arbitrary W where
  arbitrary = do
    n <- chooseInt (0, 5)
    W <$> vectorOf n (elements ['a', 'b'])

newtype R = R RegExp deriving Show

instance Arbitrary R where
  arbitrary = R <$> gen (2 :: Int)
    where
      leaf = oneof [pure Empty, pure Epsilon, Let <$> elements ['a', 'b']]
      gen 0 = leaf
      gen d = oneof
        [ leaf
        , (:|:) <$> gen (d - 1) <*> gen (d - 1)
        , (:*:) <$> gen (d - 1) <*> gen (d - 1)
        , Kleene <$> gen (d - 1)
        ]

accepts :: NFA -> String -> Bool
accepts a w = any (isFinal a) (Set.toList (foldl step (Set.singleton (start a)) w))
  where step qs c = Set.unions [lookupT q c (transitions a) | q <- Set.toList qs]

-- 0 -eps-> 1 -eps-> 2, 2 -a-> 3
chain :: EpsNFA
chain = FA (Set.fromList [0, 1, 2, 3])
             (eps 0 (Set.singleton 1) `unionT` eps 1 (Set.singleton 2) `unionT` trans 2 (Just 'a') (Set.singleton 3))
             0
             (Set.singleton 3)

main :: IO ()
main = runChecks
  [ eq "the closure follows chains"    (epsilonClosure chain 0) (Set.fromList [0, 1, 2])
  , eq "the closure holds the state"   (epsilonClosure chain 3) (Set.singleton 3)
  , check "the sample keeps its language" (accepts (epsilonElim chain) "a")
  , check "the sample rejects the empty word" (not (accepts (epsilonElim chain) ""))
  , prop "the result has no epsilon transitions, and the same language" $ \(R r) (W w) ->
      accepts (epsilonElim (thompson r)) w == matches r w
  ]
