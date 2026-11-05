module SequenceState (sequence, fibs) where

import Prelude hiding (sequence)

sequence :: [s -> (a, s)] -> s -> ([a], s)
#ifdef TEMPLATE
sequence fs s = undefined
#else
sequence []     s = ([], s)
sequence (f:fs) s =
  let (y, s')   = f s
      (ys, s'') = sequence fs s'
   in (y : ys, s'')
#endif

fib :: (Int, Int) -> (Int, (Int, Int))
fib (f0, f1) = (f0, (f1, f0 + f1))

fibs :: Int -> [Int]
fibs n = fst (sequence (replicate n fib) (0, 1))
