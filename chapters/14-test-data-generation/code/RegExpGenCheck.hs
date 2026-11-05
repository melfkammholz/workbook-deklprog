import Control.Monad (replicateM)
import System.IO.Unsafe (unsafePerformIO)
import Workbook.Check
import RegExp
import RegExpGen

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

depth :: RegExp -> Int
depth (a :|: b)  = 1 + max (depth a) (depth b)
depth (a :*: b)  = 1 + max (depth a) (depth b)
depth (Kleene a) = 1 + depth a
depth _          = 0

main :: IO ()
main = runChecks
  [ checkIO "arbitrary gives different expressions" $ do
      rs <- generate (replicateM 30 (resize 8 arbitrary)) :: IO [RegExp]
      pure (any (/= head rs) rs)
  , checkIO "arbitrary respects the size" $ do
      rs <- generate (replicateM 30 (resize 10 arbitrary)) :: IO [RegExp]
      pure (all ((< 40) . depth) rs)
  , prop "randomWord of Epsilon is empty" $ forAll (randomWord Epsilon) null
  , prop "randomWord of a letter is that letter" $ forAll (randomWord (Let 'x')) (== "x")
  , prop "randomWord of (ab|c)* is in the language" $
      let r = Kleene ((Let 'a' :*: Let 'b') :|: Let 'c') in forAll (randomWord r) (matches r)
  , prop "positive samples are in the language" $
      forAll (resize 10 arbitrary) $ \(WithPositiveSample (r, w)) -> matches r w
  ]
