module FoldMaybeEither where

#ifdef TEMPLATE
-- Think about the type signature first.
foldMaybe = undefined
#else
foldMaybe :: b -> (a -> b) -> Maybe a -> b
foldMaybe fnothing fjust value =
  case value of
    Nothing -> fnothing
    Just x  -> fjust x
#endif

#ifdef TEMPLATE
-- Think about the type signature first.
foldEither = undefined
#else
foldEither :: (a -> c) -> (b -> c) -> Either a b -> c
foldEither fleft fright value =
  case value of
    Left x  -> fleft x
    Right y -> fright y
#endif
