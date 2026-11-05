import Prelude hiding ((<*))
import Workbook.Check
import MonadicParser

main :: IO ()
main = runChecks
  [ eq "fmap changes the result"     (getParser (fmap (+ 1) digit) "1a") [(2, "a")]
  , eq "pure leaves the input alone" (getParser (pure 'x') "abc") [('x', "abc")]
  , eq "(<*>) applies in order"      (getParser ((,) <$> digit <*> digit) "12a") [((1, 2), "a")]
  , eq "(>>=) hands on the result"   (getParser (digit >>= \d -> if d == 1 then char 'a' else char 'b') "1a") [('a', "")]
  , eq "(>>=) fails with either"     (getParser (digit >>= const failure :: Parser Int) "1") []
  , eq "failure has no result"       (getParser (failure :: Parser Int) "abc") []
  , eq "satisfy"                     (getParser (satisfy (== 'a')) "ab") [('a', "b")]
  , eq "char rejects another letter" (getParser (char 'a') "b") []
  , eq "many takes all it can"       (getParser (many digit) "12a") [([1, 2], "a")]
  , eq "many can take nothing"       (getParser (many digit) "a") [([], "a")]
  , eq "number"                      (getParser number "19851026backintime") [(19851026, "backintime")]
  , eq "parse wants all the input"   (parse number "12a") Nothing
  , eq "parse with number"           (parse number "42") (Just 42)
  , eq "the first complete result"   (parse (Parser (const [(1 :: Int, "x"), (2, "")])) "") (Just 2)
  ]
