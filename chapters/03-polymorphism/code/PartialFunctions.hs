module PartialFunctions where

import Prelude hiding (head, last, init, tail, (!!), minimum, maximum)

head, last :: [a] -> a
#ifdef TEMPLATE
head = undefined
last = undefined
#else
head (x : _) = x

last [x]      = x
last (_ : xs) = last xs
#endif

init, tail :: [a] -> [a]
#ifdef TEMPLATE
init = undefined
tail = undefined
#else
init [_]      = []
init (x : xs) = x : init xs

tail (_ : xs) = xs
#endif

(!!) :: [a] -> Int -> a
#ifdef TEMPLATE
(!!) = undefined
#else
(x : _)  !! 0 = x
(_ : xs) !! n = xs !! (n - 1)
#endif

minimum, maximum :: Ord a => [a] -> a
#ifdef TEMPLATE
minimum = undefined
maximum = undefined
#else
minimum [x]      = x
minimum (x : xs) = min x (minimum xs)

maximum [x]      = x
maximum (x : xs) = max x (maximum xs)
#endif

fromJust :: Maybe a -> a
#ifdef TEMPLATE
fromJust = undefined
#else
fromJust (Just x) = x
#endif
