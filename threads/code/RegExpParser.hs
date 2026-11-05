module RegExpParser where

import Prelude hiding ((<*))
import MonadicParser
import RegExp

-- | Parses a regular expression, for example "(a|b)*c".
parseRegExp :: String -> Maybe RegExp
#ifdef TEMPLATE regexp-parser
parseRegExp = undefined
#else
parseRegExp = parse regexpP
  where
    regexpP = do
      t <- termP
      ts <- many (char '|' *> termP)
      return (foldl (:|:) t ts)

    termP = do
      fs <- many factorP
      return (case fs of
        []     -> Epsilon
        f : gs -> foldl (:*:) f gs)

    factorP = do
      a <- atomP
      ks <- many (char '*')
      return (foldl (\r _ -> Kleene r) a ks)

    atomP = Parser (\s -> getParser letterP s ++ getParser groupP s)
    letterP = Let <$> satisfy (`notElem` ['(', ')', '|', '*'])
    groupP = char '(' *> regexpP >>= \r -> char ')' >> return r
#endif
