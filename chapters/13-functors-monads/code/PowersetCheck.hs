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

deterministic :: DFA -> Bool
deterministic a = all (all ((<= 1) . Set.size)) (transitions a)

main :: IO ()
main = runChecks
  [ check "member: a word of (a|b)*c" (member "abac" (compile (Kleene (Let 'a' :|: Let 'b') :*: Let 'c')))
  , check "member: a word that is not" (not (member "abc a" (compile (Kleene (Let 'a' :|: Let 'b') :*: Let 'c'))))
  , check "Empty accepts nothing"     (not (member "" (compile Empty)))
  , prop "compile gives a deterministic automaton" $ \(R r) -> deterministic (compile r)
  , prop "compile keeps the language" $ \(R r) (W w) -> member w (compile r) == matches r w
  ]
