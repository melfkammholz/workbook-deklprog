{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}
import Workbook.Check
import Brzozowski
import RegExp

-- A matcher that does not use derivatives. The tests compare languages, not
-- expressions, so a derivative may be simplified in any way that keeps its language.
matches :: RegExp -> String -> Bool
matches re str = go re str null
  where
    go Empty     _ _ = False
    go Epsilon   s k = k s
    go (Let c)   s k = case s of
      x : xs -> c == x && k xs
      []     -> False
    go (r :|: t) s k = go r s k || go t s k
    go (r :*: t) s k = go r s (\s' -> go t s' k)
    go (Kleene r) s k = k s || go r s (\s' -> s' /= s && go (Kleene r) s' k)

newtype Word' = Word' String deriving Show

instance Arbitrary Word' where
  arbitrary = do
    n <- chooseInt (0, 6)
    Word' <$> vectorOf n (elements ['a', 'b'])

instance Arbitrary RegExp where
  arbitrary = gen (3 :: Int)
    where
      leaf = oneof [pure Empty, pure Epsilon, Let <$> elements ['a', 'b']]
      gen 0 = leaf
      gen d = oneof
        [ leaf
        , (:|:) <$> gen (d - 1) <*> gen (d - 1)
        , (:*:) <$> gen (d - 1) <*> gen (d - 1)
        , Kleene <$> gen (d - 1)
        ]
  shrink (r :|: s)  = [r, s]
  shrink (r :*: s)  = [r, s]
  shrink (Kleene r) = [r]
  shrink _          = []

-- (Plankton|Krabs)^* Spongebob
bikiniBottom :: RegExp
bikiniBottom = Kleene ("Plankton" :|: "Krabs") :*: "Spongebob"

main :: IO ()
main = runChecks
  [ check "Empty is not nullable"        (not (nullable Empty))
  , check "Epsilon is nullable"          (nullable Epsilon)
  , check "a letter is not nullable"     (not (nullable (Let 'a')))
  , check "Kleene is always nullable"    (nullable (Kleene (Let 'a')))
  , check ":|: needs one nullable side"  (nullable (Let 'a' :|: Epsilon))
  , check ":*: needs both sides nullable" (not (nullable (Let 'a' :*: Epsilon)))
  , prop "nullable agrees with the empty word" $ \(r :: RegExp) -> nullable r == matches r ""

  , check "a removes the letter a"       (matches (brzozowski 'a' (Let 'a')) "")
  , check "a does not remove the letter b" (not (matches (brzozowski 'a' (Let 'b')) ""))
  , check "derivative of (ab)^* by a accepts b"
      (matches (brzozowski 'a' (Kleene "ab")) "b")
  , check "derivative of a^* b by b accepts the empty word, a nullable left side"
      (matches (brzozowski 'b' (Kleene (Let 'a') :*: Let 'b')) "")
  , prop "brzozowski removes a first letter" $ \(r :: RegExp) (Word' v) ->
      forAll (elements ['a', 'b']) $ \a -> matches (brzozowski a r) v == matches r (a : v)

  , check "derivative by the empty word changes nothing"
      (matches (derivative "" (Let 'a')) "a")
  , check "derivative by ab goes from left to right"
      (matches (derivative "ab" "abc") "c")
  , prop "derivative removes a prefix" $ \(r :: RegExp) (Word' u) (Word' v) ->
      matches (derivative u r) v == matches r (u ++ v)

  , check "member: Spongebob"            (member "Spongebob" bikiniBottom)
  , check "member: KrabsPlanktonSpongebob" (member "KrabsPlanktonSpongebob" bikiniBottom)
  , check "member: Krabs alone is not in the language" (not (member "Krabs" bikiniBottom))
  , prop "member agrees with a second matcher" $ \(r :: RegExp) (Word' w) -> member w r == matches r w
  ]
