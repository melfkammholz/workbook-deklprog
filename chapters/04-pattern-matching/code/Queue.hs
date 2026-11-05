module Queue (Queue (..), empty, front, isEmpty, enqueue, dequeue) where

data Queue a = Q [a] [a]
  deriving Show

-- | A queue without elements.
empty :: Queue a
#ifdef TEMPLATE
empty = undefined
#else
empty = Q [] []
#endif

-- | The first element of a queue.
front :: Queue a -> a
#ifdef TEMPLATE
front q = undefined
#else
front (Q (x : _) _) = x
front (Q [] _)      = error "front: empty queue"
#endif

-- | Whether a queue is empty.
isEmpty :: Queue a -> Bool
#ifdef TEMPLATE
isEmpty q = undefined
#else
isEmpty (Q xs _) = null xs
#endif

-- | Adds an element at the end of a queue.
enqueue :: a -> Queue a -> Queue a
#ifdef TEMPLATE
enqueue x q = undefined
#else
enqueue x (Q xs ys) = check (Q xs (x : ys))

-- Keeps the invariant: a queue is empty exactly when its first list is.
check :: Queue a -> Queue a
check (Q [] ys) = Q (reverse ys) []
check q         = q
#endif

-- | Removes the first element of a queue.
dequeue :: Queue a -> Queue a
#ifdef TEMPLATE
dequeue q = undefined
#else
dequeue (Q (_ : xs) ys) = check (Q xs ys)
dequeue (Q [] _)        = error "dequeue: empty queue"
#endif
