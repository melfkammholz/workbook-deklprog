import Prelude hiding ((<*))
import Workbook.Check
import RegExp
import RegExpParser

a, b, c :: RegExp
(a, b, c) = (Let 'a', Let 'b', Let 'c')

main :: IO ()
main = runChecks
  [ eq "one letter"                   (parseRegExp "a") (Just a)
  , eq "concatenation"                (parseRegExp "ab") (Just (a :*: b))
  , eq "alternation"                  (parseRegExp "a|b") (Just (a :|: b))
  , eq "a star"                       (parseRegExp "a*") (Just (Kleene a))
  , eq "the star binds tightest"      (parseRegExp "ab*") (Just (a :*: Kleene b))
  , eq "concatenation binds before |" (parseRegExp "ab|c") (Just ((a :*: b) :|: c))
  , eq "parentheses"                  (parseRegExp "(a|b)*c") (Just (Kleene (a :|: b) :*: c))
  , eq "nothing is the empty word"    (parseRegExp "") (Just Epsilon)
  , eq "an open parenthesis fails"    (parseRegExp "(a") Nothing
  , eq "a star alone fails"           (parseRegExp "*") Nothing
  ]
