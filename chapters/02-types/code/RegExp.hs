-- | Regular expressions, used throughout this adventure.
--
-- You only need to know the data type and how to use it. You do not need to
-- understand 'IsString' or 'ReadP' here. They are not part of the exercise and
-- only make regular expressions more comfortable to write down and look at:
--
-- >>> "ab" :*: Kleene ("c" :|: "d")
-- ab(c|d)*
-- >>> read "ab(c|d)*" :: RegExp
-- ab(c|d)*
module RegExp (RegExp (..)) where

import Data.String (IsString (..))
import Text.ParserCombinators.ReadP

-- (In a different challenge we want to use RegExp as keys for Map. Thus, we
-- derive Ord here.)
data RegExp = Empty
            | Epsilon
            | Let Char
            | RegExp :|: RegExp
            | RegExp :*: RegExp
            | Kleene RegExp
  deriving (Eq, Ord)

infixl 6 :|:
infixl 7 :*:

-- Lets us write @"abc"@ instead of @Let 'a' :*: Let 'b' :*: Let 'c'@. This is
-- switched on in the interpreter of this exercise, through OverloadedStrings.
--
-- See https://hackage-content.haskell.org/package/base/docs/Data-String.html#t:IsString
instance IsString RegExp where
  fromString "" = Epsilon
  fromString cs = foldr1 (:*:) (map Let cs)

-- Pretty printing for regular expressions
instance Show RegExp where
  showsPrec _ Empty       = showString "\x2205"
  showsPrec _ Epsilon     = showString "\x03b5"
  showsPrec _ (Let c)     = showChar c
  showsPrec p (r1 :*: r2) = showParen (p > 7) (showsPrec 7 r1 . showsPrec 7 r2)
  showsPrec p (r1 :|: r2) = showParen (p > 6) (showsPrec 6 r1 . showChar '|' . showsPrec 7 r2)
  showsPrec _ (Kleene r)  = showsPrec 9 r . showChar '*'

-- Parsing, the other way around. The whole text has to be a regular expression.
instance Read RegExp where
  readsPrec _ = readP_to_S (regexpP <* eof)

regexpP :: ReadP RegExp
regexpP = do
  t <- termP
  ts <- many (char '|' *> termP)
  return (foldl (:|:) t ts)

termP :: ReadP RegExp
termP = do
  fs <- many factorP
  case fs of
    []      -> return Epsilon
    (f:fs') -> return (foldl (:*:) f fs')

factorP :: ReadP RegExp
factorP = do
  a <- atomP
  ks <- many (char '*')
  return (foldl (\r _ -> Kleene r) a ks)

atomP :: ReadP RegExp
atomP = (char '(' *> regexpP <* char ')') +++ (toAtom <$> satisfy (`notElem` ['(', ')', '|', '*']))
  where
    toAtom '\x2205' = Empty
    toAtom '\x03b5' = Epsilon
    toAtom c        = Let c
