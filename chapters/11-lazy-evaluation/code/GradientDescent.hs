module GradientDescent (minimize) where

-- | Takes the derivative and a starting point.
minimize :: (Double -> Double) -> Double -> Double
#ifdef TEMPLATE
minimize f' x0 = undefined
#else
minimize f' x0 = prec (iterate (\x -> x - 3e-4 * f' x) x0)
  where
    prec (x : y : xs)
      | abs (y - x) < 1e-5 = y
      | otherwise          = prec (y : xs)
    prec _ = error "iterate is infinite"
#endif
