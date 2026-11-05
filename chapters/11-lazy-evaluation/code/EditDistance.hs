module EditDistance (editdist) where

editdist :: Eq a => [a] -> [a] -> Int
editdist u v = table !! m !! n
  where
    (m, n) = (length u, length v)
    table = [[ed i j | j <- [0 .. n]] | i <- [0 .. m]]

#ifdef TEMPLATE
    ed i j = undefined
#else
    ed 0 j = j
    ed i 0 = i
    ed i j
      | u !! (i - 1) == v !! (j - 1) = table !! (i - 1) !! (j - 1)
      | otherwise = 1 + minimum [ table !! (i - 1) !! j
                                , table !! i !! (j - 1)
                                , table !! (i - 1) !! (j - 1)
                                ]
#endif
