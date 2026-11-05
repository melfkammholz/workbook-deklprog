import Workbook.Check
import AutomataTrees

main :: IO ()
main = runChecks
  [ check "accepts the empty word"        (accept "" asbs)
  , check "accepts aabb"                  (accept "aabb" asbs)
  , check "accepts bbb"                   (accept "bbb" asbs)
  , check "rejects ba"                    (not (accept "ba" asbs))
  , check "rejects aba"                   (not (accept "aba" asbs))
  , check "accept stops on letters without a transition"
      (not (accept "x" (State True [('a', State True [])])))
  , eq "language of a finite automaton"   (language (State True [('a', State True [])])) ["", "a"]
  , check "language reaches words with a" ("aa" `elem` take 50 (language asbs))
  , check "language reaches words with b" ("bb" `elem` take 50 (language asbs))
  , check "language only has accepted words" (all (`accept` asbs) (take 50 (language asbs)))
  ]
