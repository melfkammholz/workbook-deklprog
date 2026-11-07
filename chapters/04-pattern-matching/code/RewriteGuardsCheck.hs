import Workbook.Check
import RewriteGuards

main :: IO ()
main = runChecks
  [ eq "clampGuards 0 10 (-5) = 0"            (clampGuards 0 10 (-5)) 0
  , eq "clampGuards 0 10 15 = 10"             (clampGuards 0 10 15) 10
  , eq "clampGuards 0 10 7 = 7"               (clampGuards 0 10 7) 7
  , prop "clampGuards behaves like clamp" $ \lo hi x -> clampGuards lo hi x == clamp lo hi x
  , eq "temperatureIf at the boundaries"      (map temperatureIf [-1, 0, 9, 10, 24, 25]) (map temperature [-1, 0, 9, 10, 24, 25])
  , prop "temperatureIf behaves like temperature" $ \t -> temperatureIf t == temperature t
  , eq "temperatureCase at the boundaries"    (map temperatureCase [-1, 0, 9, 10, 24, 25]) (map temperature [-1, 0, 9, 10, 24, 25])
  , prop "temperatureCase behaves like temperature" $ \t -> temperatureCase t == temperature t
  ]
