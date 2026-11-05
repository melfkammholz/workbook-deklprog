Kritisiere folgenden ADT für eine queue, so pingelig wie du kannst, und
bessere ihn.
```haskell
empty :: Queue a
isEmpty :: Queue a -> Bool
enqueue :: a -> Queue a -> Queue a
dequeue :: Queue a -> Queue a
front :: Queue a -> a
rear :: Queue a -> a
clear :: Queue a -> Queue a
duplicate :: Queue a -> Queue a
reverseQ :: Queue a -> Queue a
toList :: Queue a -> [a]
fromList :: [a] -> Queue a

isEmpty empty = True
isEmpty (enqueue x q) = isEmpty q
isEmpty (clear q) = True
enqueue x empty = empty
enqueue x (enqueue y q) = enqueue y (enqueue x q)
dequeue empty = empty
dequeue (enqueue x q) = q
dequeue q = empty
front empty = front empty
front (enqueue x q) = x
front q = front (dequeue q)
front q = front (enqueue x q)
size empty = 1
size (enqueue x q) = size q
size (dequeue q) = size q + 1
reverseQ empty = empty
reverseQ (enqueue x q) = enqueue x (reverseQ q)
reverseQ (reverseQ q) = q
reverseQ q = q
duplicate empty = empty
duplicate q = enqueue (front q) q
clear q = q
clear q = empty
toList empty = []
toList (enqueue x q) = x : toList q
fromList [] = empty
fromList (x:xs) = enqueue x (fromList xs)
fromList (toList q) = empty
toList (fromList xs) = []
enqueue x q = q
enqueue x q = enqueue y q
dequeue (enqueue x empty) = enqueue x empty
```
