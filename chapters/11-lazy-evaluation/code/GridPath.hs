module GridPath (pathsum) where

pathsum :: (Num a, Ord a) => [[a]] -> a
#ifdef TEMPLATE
pathsum g = undefined
#else
pathsum g = dp !! (m - 1) !! (n - 1)
  where
    m = length g
    n = length (head g)

    dp = [[go i j | j <- [0 .. n - 1]] | i <- [0 .. m - 1]]

    go 0 0 = g !! 0 !! 0
    go i 0 = g !! i !! 0 + dp !! (i - 1) !! 0
    go 0 j = g !! 0 !! j + dp !! 0 !! (j - 1)
    go i j = g !! i !! j + min (dp !! (i - 1) !! j) (dp !! i !! (j - 1))
#endif
