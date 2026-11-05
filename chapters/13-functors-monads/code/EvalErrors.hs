module EvalErrors (Exp (..), MonadFail (..), eval) where

import Prelude hiding (MonadFail (..))

data Exp a = Num a
           | Exp a :+: Exp a
           | Exp a :-: Exp a
           | Exp a :*: Exp a
           | Exp a :/: Exp a
  deriving Show

class Monad m => MonadFail m where
  fail :: String -> m a

instance MonadFail (Either String) where
#ifdef TEMPLATE
  fail = undefined
#else
  fail = Left
#endif

-- | The last version of eval, for any MonadFail. Earlier versions can go in comments.
eval :: MonadFail m => Exp Int -> m Int
#ifdef TEMPLATE
eval e = undefined
#else
eval (Num x)   = return x
eval (a :+: b) = (+) <$> eval a <*> eval b
eval (a :-: b) = (-) <$> eval a <*> eval b
eval (a :*: b) = (*) <$> eval a <*> eval b
eval (a :/: b) = do
  y <- eval b
  if y == 0
    then fail "division by zero"
    else do
      x <- eval a
      return (x `div` y)
#endif
