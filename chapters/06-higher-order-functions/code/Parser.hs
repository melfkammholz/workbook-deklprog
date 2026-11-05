module Parser where

import Data.Char (isDigit)
import Prelude hiding ((<*))

type Parser a = String -> [(a, String)]

infixl 4 <*

-- | Applies a parser. Succeeds when a value comes with no input left.
parse :: Parser a -> String -> Maybe a
#ifdef TEMPLATE
parse p s = undefined
#else
parse p s = case [a | (a, "") <- p s] of
  a : _ -> Just a
  []    -> Nothing
#endif

-- | Gives a value and leaves the input as it is.
succeed :: a -> Parser a
#ifdef TEMPLATE
succeed a = undefined
#else
succeed a s = [(a, s)]
#endif

-- | Has no result.
failure :: Parser a
#ifdef TEMPLATE
failure = undefined
#else
failure _ = []
#endif

satisfy :: (Char -> Bool) -> Parser Char
#ifdef TEMPLATE
satisfy p = undefined
#else
satisfy p (c : cs) | p c = [(c, cs)]
satisfy _ _              = []
#endif

anyChar :: Parser Char
#ifdef TEMPLATE
anyChar = undefined
#else
anyChar = satisfy (const True)
#endif

char :: Char -> Parser Char
#ifdef TEMPLATE
char c = undefined
#else
char c = satisfy (== c)
#endif

digit :: Parser Int
#ifdef TEMPLATE
digit = undefined
#else
digit s = [(read [c], rest) | (c, rest) <- satisfy isDigit s]
#endif

andThen :: Parser a -> (a -> Parser b) -> Parser b
#ifdef TEMPLATE
andThen p f = undefined
#else
andThen p f s = concatMap (\(a, rest) -> f a rest) (p s)
#endif

many :: Parser a -> Parser [a]
#ifdef TEMPLATE
many p = undefined
#else
many p s = case p s of
  []      -> [([], s)]
  results -> concatMap (\(a, rest) -> [(a : as, rest') | (as, rest') <- many p rest]) results
#endif

(<*) :: Parser a -> Parser b -> Parser a
#ifdef TEMPLATE
p <* q = undefined
#else
p <* q = p `andThen` \a -> q `andThen` \_ -> succeed a
#endif

number :: Parser Int
#ifdef TEMPLATE
number = undefined
#else
number =
  digit `andThen` \d ->
    many digit `andThen` \ds ->
      succeed (foldl (\n x -> 10 * n + x) 0 (d : ds))
#endif
