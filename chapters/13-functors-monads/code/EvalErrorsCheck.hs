import Prelude hiding (MonadFail (..))
import Workbook.Check
import EvalErrors

isLeft :: Either a b -> Bool
isLeft = either (const True) (const False)

ev :: Exp Int -> Either String Int
ev = eval

main :: IO ()
main = runChecks
  [ eq "a number"              (ev (Num 3)) (Right 3)
  , eq "addition"              (ev (Num 3 :+: Num 4)) (Right 7)
  , eq "subtraction"           (ev (Num 3 :-: Num 4)) (Right (-1))
  , eq "multiplication"        (ev (Num 3 :*: Num 4)) (Right 12)
  , eq "division"              (ev (Num 9 :/: Num 2)) (Right 4)
  , check "division by zero fails" (isLeft (ev (Num 1 :/: Num 0)))
  , check "a failure inside fails" (isLeft (ev (Num 1 :+: (Num 1 :/: (Num 1 :-: Num 1)))))
  , check "the failure says why" (either (not . null) (const False) (ev (Num 1 :/: Num 0)))
  ]
