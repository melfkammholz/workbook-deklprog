module Brzozowski (nullable, brzozowski, derivative, member) where

import RegExp

-- | Whether the language of the expression contains the empty word.
nullable :: RegExp -> Bool
#ifdef TEMPLATE
nullable r = undefined
#else
nullable Empty      = False
nullable Epsilon    = True
nullable (Let _)    = False
nullable (r :|: s)  = nullable r || nullable s
nullable (r :*: s)  = nullable r && nullable s
nullable (Kleene _) = True
#endif

-- | The Brzozowski derivative with respect to a letter.
brzozowski :: Char -> RegExp -> RegExp
#ifdef TEMPLATE
brzozowski a r = undefined
#else
brzozowski _ Empty   = Empty
brzozowski _ Epsilon = Empty
brzozowski a (Let b)
  | a == b    = Epsilon
  | otherwise = Empty
brzozowski a (r :|: s) = brzozowski a r :|: brzozowski a s
brzozowski a (r :*: s)
  | nullable r = brzozowski a r :*: s :|: brzozowski a s
  | otherwise  = brzozowski a r :*: s
brzozowski a (Kleene r) = brzozowski a r :*: Kleene r
#endif

-- | The Brzozowski derivative with respect to a word.
derivative :: String -> RegExp -> RegExp
#ifdef TEMPLATE
derivative w r = undefined
#else
derivative w r = foldl (flip brzozowski) r w
#endif

-- | Whether the word is in the language of the expression.
member :: String -> RegExp -> Bool
#ifdef TEMPLATE
member w r = undefined
#else
member w r = nullable (derivative w r)
#endif
