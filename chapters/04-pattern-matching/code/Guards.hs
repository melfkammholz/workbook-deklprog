module Guards where

describe :: Int -> String
describe n
  | n > 10 = "groß"
  | n > 0  = "positiv"
describe 0 = "null"
describe _ = "negativ"

sign :: Int -> Int
#ifdef TEMPLATE
sign n
  | n < 0  = -1
  | n == 0 = 0
  | n > 0  = 1
#else
sign n
  | n < 0     = -1
  | n == 0    = 0
  | otherwise = 1
#endif

grade :: Int -> String
#ifdef TEMPLATE
grade points
  | points >= 50 = "bestanden"
  | points >= 90 = "sehr gut"
  | otherwise    = "nicht bestanden"
#else
grade points
  | points >= 90 = "sehr gut"
  | points >= 50 = "bestanden"
  | otherwise    = "nicht bestanden"
#endif

safeDiv :: Int -> Int -> Maybe Int
safeDiv x y
  | y == 0    = Nothing
  | otherwise = Just q
  where
    q = x `div` y
