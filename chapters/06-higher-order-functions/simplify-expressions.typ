Versuche in den folgenden Ausdrücken, Teilausdrücke schrittweise durch
bekannte Funktionen zu ersetzen oder gegebenenfalls zu vereinfachen.
- `foldr (\x ys -> f x : ys) [] (foldr (\x ys -> g x : ys) [] xs)`,
- `map (\_ -> y) xs`,
- ```hs foldr (\x ys -> if x `mod` 2 == 1 then x - 1 : ys else ys) [] xs```,
- `foldl (\ys x -> x : ys) [] xs` und
- `flip (curry snd) x`.

#remark[
  #link("https://www.youtube.com/watch?v=_oNgyUAEv0Q")["Your scientists were
  so preoccupied with whether or not they could, that they didn't stop to
  think if they should."] Jenseits solcher kleinen Verständnisfragen gilt
  weiterhin, dass wir verständlichen Code schreiben wollen. Solche Ausdrücke
  wie `flip (curry snd) x` sind häufig schwieriger zu verstehen -- auch
  wenn es unterhaltsam ist, sich solche Ausdrücke auszudenken.
]

#sample[
  ```haskell
    foldr (\x ys -> f x : ys) [] (foldr (\x ys -> g x : ys) [] xs)    -- Definition map über foldr
  = foldr (\x ys -> f x : ys) [] (map g xs)                           -- Definition map über foldr
  = map f (map g xs)                                                  -- Komposition von map
  = map (f . g) xs

    map (\_ -> y) xs                                                  -- Definition const
  = map (const y) xs

    foldr (\x ys -> if x `mod` 2 == 1 then x - 1 : ys else ys) [] xs
  = foldr (\x ys -> x - 1 : ys) [] (filter odd xs)                    -- Definition map über foldr
  = map (\x -> x - 1) (filter odd xs)                                 -- Definition pred
  = map pred (filter odd xs)

    foldl (\ys x -> x : ys) [] xs                                     -- Kopfnormalform xs
  = foldl (\ys x -> x : ys) [] (x1 : ... : xn : [])                   -- Definition foldl
  = foldl (\ys x -> x : ys) (x1 : []) (x2 : ... : xn : [])            -- Definition foldl
  = ...
  = foldl (\ys x -> x : ys) (xn : ... : x1 : []) []                   -- Definition foldl
  = xn : ... : x2 : x1 : []                                           -- Definition reverse
  = reverse xs

    flip (curry snd) x                                                -- Definition snd
  = flip (curry (\(a, b) -> b)) x                                     -- Definition curry
  = flip (\a b -> b) x                                                -- Definition flip
  = (\b a -> b) x                                                     -- Lambda-Applikation
  = \a -> x
  ```
]
