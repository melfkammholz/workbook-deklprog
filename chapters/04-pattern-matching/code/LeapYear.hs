module LeapYear (isLeap) where

-- | Whether a year is a leap year in the Gregorian calendar.
isLeap :: Int -> Bool
#ifdef TEMPLATE
isLeap year
  | year `mod` 4 == 0   = True
  | year `mod` 100 == 0 = False
  | year `mod` 400 == 0 = True
  | otherwise           = False
#else
isLeap year
  | year `mod` 400 == 0 = True
  | year `mod` 100 == 0 = False
  | year `mod` 4 == 0   = True
  | otherwise           = False
#endif
