module RewriteGuards where

-- | Limits x to the range from lo to hi.
clamp :: Int -> Int -> Int -> Int
clamp lo hi x =
  if x < lo
    then lo
    else if x > hi
      then hi
      else x

clampGuards :: Int -> Int -> Int -> Int
#ifdef TEMPLATE
clampGuards lo hi x = undefined
#else
clampGuards lo hi x
  | x < lo    = lo
  | x > hi    = hi
  | otherwise = x
#endif

-- | Describes a temperature in degrees Celsius.
temperature :: Int -> String
temperature t
  | t < 0     = "eisig"
  | t < 10    = "kalt"
  | t < 25    = "angenehm"
  | otherwise = "heiß"

temperatureIf :: Int -> String
#ifdef TEMPLATE
temperatureIf t = undefined
#else
temperatureIf t =
  if t < 0
    then "eisig"
    else if t < 10
      then "kalt"
      else if t < 25
        then "angenehm"
        else "heiß"
#endif

temperatureCase :: Int -> String
#ifdef TEMPLATE
temperatureCase t = undefined
#else
temperatureCase t = case t of
  _ | t < 0     -> "eisig"
    | t < 10    -> "kalt"
    | t < 25    -> "angenehm"
    | otherwise -> "heiß"
#endif
