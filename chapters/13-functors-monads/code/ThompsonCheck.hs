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

-- Runs an epsilon NFA without any help from the exercises after this one.
close :: EpsNFA -> Set Int -> Set Int
close a qs =
  let new = Set.unions (qs : [lookupT q Nothing (transitions a) | q <- Set.toList qs])
   in if new == qs then qs else close a new

accepts :: EpsNFA -> String -> Bool
accepts a w = any (isFinal a) (Set.toList (foldl step (close a (Set.singleton (start a))) w))
  where step qs c = close a (Set.unions [lookupT q (Just c) (transitions a) | q <- Set.toList qs])

main :: IO ()
main = runChecks
  [ check "Empty accepts nothing"     (not (accepts (thompson Empty) ""))
  , check "Epsilon accepts the empty word" (accepts (thompson Epsilon) "")
  , check "a letter accepts itself"   (accepts (thompson (Let 'a')) "a")
  , check "a letter rejects others"   (not (accepts (thompson (Let 'a')) "b"))
  , check "concatenation"             (accepts (thompson (Let 'a' :*: Let 'b')) "ab")
  , check "alternation"               (accepts (thompson (Let 'a' :|: Let 'b')) "b")
  , check "a star repeats"            (accepts (thompson (Kleene (Let 'a'))) "aaa")
  , check "a star accepts the empty word" (accepts (thompson (Kleene (Let 'a'))) "")
  , prop "the automaton has the language of the expression" $ \(R r) (W w) ->
      accepts (thompson r) w == matches r w
  ]
