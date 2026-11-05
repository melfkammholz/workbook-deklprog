module Swaps (swaps, swaps') where

#ifndef TEMPLATE
sw :: (Int, Int) -> Int -> Int
sw (a, b) x | x == a    = b
            | x == b    = a
            | otherwise = x
#endif

-- | The final permutation, as the list of its images.
swaps :: Int -> [(Int, Int)] -> [Int]
#ifdef TEMPLATE
swaps n ps = undefined
#else
swaps n = foldl (\ys ab -> map (sw ab) ys) [0 .. n - 1]
#endif

-- | The final permutation, as a function.
swaps' :: Int -> [(Int, Int)] -> Int -> Int
#ifdef TEMPLATE
swaps' n ps = undefined
#else
swaps' _ = foldl (\p ab -> sw ab . p) id
#endif
