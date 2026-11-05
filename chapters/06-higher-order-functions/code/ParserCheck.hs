import Prelude hiding ((<*))
import Data.Char (isUpper)
import Workbook.Check
import Parser

main :: IO ()
main = runChecks
  [ eq "parse: a value with no input left"   (parse (succeed 'a') "") (Just 'a')
  , eq "parse: input left over is a failure" (parse (succeed 'a') "b") Nothing
  , eq "parse: a failing parser"             (parse (failure :: Parser Char) "") Nothing
  , eq "parse: the first value with no input left, wherever it is"
      (parse (\_ -> [(1, "x"), (2, ""), (3, "")]) "" :: Maybe Int) (Just 2)
  , eq "succeed leaves the input alone"      (succeed 'x' "abc") [('x', "abc")]
  , eq "failure has no result"               ((failure :: Parser Char) "abc") []
  , eq "satisfy takes a matching letter"     (satisfy isUpper "Ab") [('A', "b")]
  , eq "satisfy rejects other letters"       (satisfy isUpper "ab") []
  , eq "satisfy on the empty input"          (satisfy isUpper "") []
  , eq "anyChar"                             (anyChar "xy") [('x', "y")]
  , eq "char takes the right letter"         (char 'a' "ab") [('a', "b")]
  , eq "char rejects another letter"         (char 'a' "ba") []
  , eq "digit gives a number"                (digit "7a") [(7, "a")]
  , eq "digit rejects a letter"              (digit "a7") []
  , eq "andThen hands on the result"         ((anyChar `andThen` char) "aab") [('a', "b")]
  , eq "andThen tries every result"
      (((\s -> [(1 :: Int, s), (2, s)]) `andThen` (\n -> succeed (n * 10))) "x") [(10, "x"), (20, "x")]
  , eq "many takes all it can"               (many digit "20151021") [([2, 0, 1, 5, 1, 0, 2, 1], "")]
  , eq "many stops at the first failure"     (many digit "12a") [([1, 2], "a")]
  , eq "many can take nothing"               (many digit "a") [([], "a")]
  , eq "(<*) keeps the first result"         ((char 'a' <* char 'b') "abc") [('a', "c")]
  , eq "(<*) fails with its second parser"   ((char 'a' <* char 'b') "acb") []
  , eq "number stops after the digits"       (number "19851026backintime") [(19851026, "backintime")]
  , eq "number needs a digit"                (number "x") []
  , eq "number on the empty input"           (number "") []
  , eq "parse with number"                   (parse number "42") (Just 42)
  ]
