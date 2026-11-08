module Maximum where

import Prelude hiding (maximum)

-- | Returns the largest integer in a non-empty list.  
maximum :: [Int] -> Int
#ifdef TEMPLATE
maximum xs = undefined
#else
maximum (x : xs) = foldr max x xs
maximum []       = error "empty list"
#endif
