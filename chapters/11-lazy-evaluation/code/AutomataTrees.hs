module AutomataTrees (State (..), asbs, accept, language) where

data State a = State Bool [(a, State a)]

asbs :: State Char
#ifdef TEMPLATE
asbs = undefined
#else
asbs = q0
  where
    q0 = State True  [('a', q0), ('b', q1)]
    q1 = State True  [('a', q2), ('b', q1)]
    q2 = State False [('a', q2), ('b', q2)]
#endif

accept :: Eq a => [a] -> State a -> Bool
#ifdef TEMPLATE
accept w q = undefined
#else
accept []     (State final _) = final
accept (x:xs) (State _ ts)    = any (accept xs) [u | (y, u) <- ts, x == y]
#endif

language :: State a -> [[a]]
#ifdef TEMPLATE
language q = undefined
#else
language q = bfs [([], q)]
  where
    bfs [] = []
    bfs ((w, State final ts) : qs) =
      let ws = bfs (qs ++ [(w ++ [c], u) | (c, u) <- ts])
       in if final then w : ws else ws
#endif
