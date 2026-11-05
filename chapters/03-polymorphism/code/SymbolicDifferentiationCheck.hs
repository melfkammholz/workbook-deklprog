import Workbook.Check hiding (Fun)
import SymbolicDifferentiation

near :: Double -> Double -> Bool
near a b = abs (a - b) <= 1e-4 * max 1 (abs b)

-- The derivative is compared with a difference quotient, so that any correct
-- form of it passes, simplified or not.
slope :: Fun -> Double -> Double
slope f x = ((f $$ (x + h)) - (f $$ (x - h))) / (2 * h)
  where h = 1e-5

derives :: String -> Fun -> Check
derives name f = check ("derive: " ++ name) (all ok [0.5, 1, 1.5, 2.5])
  where ok x = near (derive f $$ x) (slope f x)

main :: IO ()
main = runChecks
  [ check "X at 3 is 3"                   (near (X $$ 3) 3)
  , check "E is Euler's constant"         (near (E $$ 0) (exp 1))
  , check "Num 2 at 5 is 2"               (near (Num 2 $$ 5) 2)
  , check "Ln X at e is 1"                (near (Ln X $$ exp 1) 1)
  , check "X + 1, X - 1, X * 2 and X / 2 at 4"
      (and [ near ((X :+: Num 1) $$ 4) 5, near ((X :-: Num 1) $$ 4) 3
           , near ((X :*: Num 2) $$ 4) 8, near ((X :/: Num 2) $$ 4) 2 ])
  , check "composition applies the right function first"
      (near (((X :+: Num 1) :<: (X :*: Num 2)) $$ 3) 7)
  , check "X ^ 3 at 2 is 8"               (near ((X :^: Num 3) $$ 2) 8)
  , check "sigma at 0 is 1/2"             (near (sigma $$ 0) 0.5)
  , check "sigma at 2"                    (near (sigma $$ 2) (1 / (1 + exp (-2))))

  , derives "X"                X
  , derives "E"                E
  , derives "Num 3"            (Num 3)
  , derives "X + 2"            (X :+: Num 2)
  , derives "X - E"            (X :-: E)
  , derives "product rule"     (X :*: Ln X)
  , derives "quotient rule"    (X :/: (X :+: Num 1))
  , derives "Ln (X * X)"       (Ln (X :*: X))
  , derives "chain rule"       ((E :^: X) :<: (X :*: X))
  , derives "X ^ 3"            (X :^: Num 3)
  , derives "2 ^ X"            (Num 2 :^: X)
  , derives "X ^ X"            (X :^: X)
  , derives "sigma"            sigma
  ]
