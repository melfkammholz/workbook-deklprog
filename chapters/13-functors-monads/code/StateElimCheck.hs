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

main :: IO ()
main = runChecks
  [ check "a single letter"           (matches (stateElim (compile (Let 'a'))) "a")
  , check "self-loops with two letters" (matches (stateElim (compile (Kleene (Let 'a' :|: Let 'b')))) "abba")
  , check "no reachable final state"  (not (matches (stateElim (compile Empty)) ""))
  , prop "the expression has the language of the automaton" $ \(R r) (W w) ->
      matches (stateElim (compile r)) w == matches r w
  ]
