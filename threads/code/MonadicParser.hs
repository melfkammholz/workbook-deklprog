module MonadicParser where

import Prelude hiding ((<*))
import Data.Char (isDigit)

newtype Parser a = Parser { getParser :: String -> [(a, String)] }

instance Functor Parser where
#ifdef TEMPLATE parser-monadic
  fmap = undefined
#else
  fmap f p = Parser (\s -> [(f x, s') | (x, s') <- getParser p s])
#endif

instance Applicative Parser where
#ifdef TEMPLATE parser-monadic
  pure = undefined
  (<*>) = undefined
#else
  pure x = Parser (\s -> [(x, s)])
  pf <*> px = Parser (\s -> [(f x, s'') | (f, s') <- getParser pf s, (x, s'') <- getParser px s'])
#endif

instance Monad Parser where
#ifdef TEMPLATE parser-monadic
  (>>=) = undefined
#else
  px >>= k = Parser (\s -> [(y, s'') | (x, s') <- getParser px s, (y, s'') <- getParser (k x) s'])
#endif

-- | Applies a parser. Succeeds when a value comes with no input left.
parse :: Parser a -> String -> Maybe a
#ifdef TEMPLATE parser-monadic
parse = undefined
#else
parse p s = case [a | (a, "") <- getParser p s] of
  a : _ -> Just a
  []    -> Nothing
#endif

failure :: Parser a
#ifdef TEMPLATE parser-monadic
failure = undefined
#else
failure = Parser (const [])
#endif

satisfy :: (Char -> Bool) -> Parser Char
#ifdef TEMPLATE parser-monadic
satisfy = undefined
#else
satisfy p = Parser go
  where
    go (c : cs) | p c = [(c, cs)]
    go _              = []
#endif

char :: Char -> Parser Char
#ifdef TEMPLATE parser-monadic
char = undefined
#else
char c = satisfy (== c)
#endif

digit :: Parser Int
#ifdef TEMPLATE parser-monadic
digit = undefined
#else
digit = fmap (\c -> read [c]) (satisfy isDigit)
#endif

many :: Parser a -> Parser [a]
#ifdef TEMPLATE parser-monadic
many = undefined
#else
many p = Parser go
  where
    go s = case getParser p s of
      []      -> [([], s)]
      results -> [(a : as, s'') | (a, s') <- results, (as, s'') <- go s']
#endif

number :: Parser Int
#ifdef TEMPLATE parser-monadic
number = undefined
#else
number = do
  d <- digit
  ds <- many digit
  return (foldl (\n x -> 10 * n + x) 0 (d : ds))
#endif
