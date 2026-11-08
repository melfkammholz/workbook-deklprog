{-# LANGUAGE ScopedTypeVariables #-}
import Workbook.Check
import FoldMaybeEither

-- The signatures the task asks for. The starter has none, so the tests fix them here.
typedFoldMaybe :: b -> (a -> b) -> Maybe a -> b
typedFoldMaybe = foldMaybe

typedFoldEither :: (a -> c) -> (b -> c) -> Either a b -> c
typedFoldEither = foldEither

main :: IO ()
main = runChecks
  [ eq "foldMaybe 0 (+ 1) Nothing = 0"          (typedFoldMaybe 0 (+ 1) Nothing) (0 :: Int)
  , eq "foldMaybe 0 (+ 1) (Just 41) = 42"       (typedFoldMaybe 0 (+ 1) (Just 41)) (42 :: Int)
  , eq "foldMaybe \"leer\" show (Just 3) = \"3\"" (typedFoldMaybe "leer" show (Just (3 :: Int))) "3"
  , prop "foldMaybe Nothing Just is the identity" $ \(m :: Maybe Int) ->
      typedFoldMaybe Nothing Just m == m
  , prop "agrees with maybe" $ \(m :: Maybe Int) ->
      typedFoldMaybe (-1) (* 2) m == maybe (-1) (* 2) m
  , eq "foldEither length negate (Left \"abc\") = 3" (typedFoldEither length negate (Left "abc" :: Either String Int)) (3 :: Int)
  , eq "foldEither length negate (Right 5) = -5"   (typedFoldEither length negate (Right 5 :: Either String Int)) (-5 :: Int)
  , prop "foldEither Left Right is the identity" $ \(e :: Either Int Bool) ->
      typedFoldEither Left Right e == e
  , prop "agrees with either" $ \(e :: Either Int Bool) ->
      typedFoldEither (+ 1) fromEnum e == either (+ 1) fromEnum e
  ]
