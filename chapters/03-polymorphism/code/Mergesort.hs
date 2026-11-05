module Mergesort (mergesort) where

-- | Sorts a list, making use of the parts of it that are already sorted.
mergesort :: [Int] -> [Int]
#ifdef TEMPLATE
mergesort xs = undefined
#else
mergesort = mergeAll . runs
  where
    runs []     = []
    runs (x:xs) = go [x] xs
      where
        go acc (y:ys) | head acc <= y = go (y : acc) ys
        go acc ys                     = reverse acc : runs ys

    mergeAll []   = []
    mergeAll [xs] = xs
    mergeAll xss  = mergeAll (mergePairs xss)

    mergePairs (xs:ys:xss) = merge xs ys : mergePairs xss
    mergePairs xss         = xss

    merge [] ys = ys
    merge xs [] = xs
    merge (x:xs) (y:ys)
      | x <= y    = x : merge xs (y : ys)
      | otherwise = y : merge (x : xs) ys
#endif
