module ZipWith where

import Prelude hiding (zip, zipWith)
#ifndef TEMPLATE
import qualified Prelude as P
#endif

zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
#ifdef TEMPLATE
zipWith = undefined
#else
zipWith f xs ys = map (uncurry f) (P.zip xs ys)
#endif

zip :: [a] -> [b] -> [(a, b)]
#ifdef TEMPLATE
zip = undefined
#else
zip = zipWith (,)
#endif

isSorted :: Ord a => [a] -> Bool
#ifdef TEMPLATE
isSorted = undefined
#else
isSorted xs = and (zipWith (<=) xs (drop 1 xs))
#endif
