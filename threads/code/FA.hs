{-# LANGUAGE OverloadedLists #-}
module FA where

import Control.Monad.State.Lazy (State, evalState, state)
import Data.List (intercalate, nub, sort)
import Data.Map.Lazy (Map)
import qualified Data.Map.Lazy as Map
import Data.Set (Set)
import qualified Data.Set as Set
import Data.Maybe (fromJust, isJust, listToMaybe)

import RegExp (RegExp (..))


-- | Transition map.
type TransitionMap s c = Map s (Map c (Set s))

-- | Finite automaton.
data FA s c = FA { states :: Set s
                 , transitions :: TransitionMap s c
                 , start :: s
                 , finals :: Set s
                 }
  deriving Show


-- | Get the dot code of a finite automaton.
--
-- You can paste the code to https://dreampuf.github.io/GraphvizOnline/ to
-- inspect your automaton for debugging or entertainment.
graphviz :: (Eq s, Show c, Show s) => FA s c -> String
graphviz (FA qs delta s fs) = 
  unlines [ "digraph {"
          , "  node [shape=circle];"
          , "  -1 [style=invis];\n  -1 -> " ++ show s ++ ";"
          , intercalate "\n" nodes
          , intercalate "\n" edges
          , "}"
          ]
  where
    nodes = map (\q -> "  " ++ node q ++ ";") (Set.toList qs)

    node q | q `elem` fs = show q ++ " [shape=doublecircle]"
           | otherwise   = show q
          
    edges = 
      ["  " ++ show s ++ " -> " ++ show t ++ " [label=\"" ++ show c ++ "\"];" 
         | (s, m) <- Map.assocs delta
         , (c, ts) <- Map.assocs m
         , t <- Set.toList ts
         ]

-- | Map each state to a different one.
mapState :: Ord s2 => (s1 -> s2) -> FA s1 c -> FA s2 c
mapState f (FA qs delta s fs) = 
  FA (Set.map f qs)
     (Map.mapKeys f (fmap (fmap (Set.map f)) delta))
     (f s)
     (Set.map f fs)

-- | Map each edge label to a different one.
mapTrans :: Ord c2 => (c1 -> c2) -> FA s c1 -> FA s c2
mapTrans f fa = fa { transitions = Map.map (\m -> Map.mapKeys f m) (transitions fa) }

-- | Epsilon NFA
type EpsNFA = FA Int (Maybe Char)

-- | NFA
type NFA = FA Int Char

-- | Intermediate powerset DFA that has lists as states
type PDFA = FA [Int] Char

-- | DFA
type DFA = FA Int Char


-- | Checks if a state is a final state.
isFinal :: Ord s => FA s c -> s -> Bool
isFinal fa q = q `Set.member` finals fa

-- | Lookups if any targets can be reached from a state via a letter.
lookupT :: (Ord c, Ord s) => s -> c -> TransitionMap s c -> Set s
lookupT s c tm = Map.findWithDefault [] c (Map.findWithDefault Map.empty s tm)

-- | Computes the union of two transitions maps. If both maps include a mapping
-- of @(q, c)@ to some states @ts1@ and @ts2@, then the resulting map will 
-- include a mapping of @(q, c)@ to @union ts1 ts2@.
unionT :: (Ord c, Ord s) => TransitionMap s c -> TransitionMap s c -> TransitionMap s c
unionT = Map.unionWith (Map.unionWith Set.union)

-- | Same as 'unionT' but for multiple maps.
unionsT :: (Ord c, Ord s) => [TransitionMap s c] -> TransitionMap s c
unionsT = foldr unionT []

-- | Constructs a map including one transition.
trans :: (Ord c, Ord s) => s -> c -> Set s -> TransitionMap s c
trans s c ts = [(s, [(c, ts)])]

-- | Constructs a map including one epsilon transition.
eps :: (Ord c, Ord s) => s -> Set s -> TransitionMap s (Maybe c)
eps s ts = trans s Nothing ts


-- | Returns a fresh state
newState :: State [Int] Int
newState = state (\(q : qs) -> (q, qs)) 

-- | Construct an epsilon NFA from a regular expression
thompson :: RegExp -> EpsNFA
thompson r = evalState (go r) ([0..] :: [Int])
#ifdef TEMPLATE thompson
  where
    go = undefined
#else
  where
    go Empty       = do 
      q <- newState
      return (FA [q] [] q [])
    go Epsilon     = do 
      q <- newState
      return (FA [q] [] q [q])
    go (Let c)     = do 
      q1 <- newState 
      q2 <- newState 
      return (FA [q1, q2] (trans q1 (Just c) [q2]) q1 [q2])
    go (r1 :|: r2) = do
      enfa1 <- go r1
      enfa2 <- go r2
      q1 <- newState
      return (FA ([q1] `Set.union` states enfa1 `Set.union` states enfa2)
                 (eps q1 [start enfa1, start enfa2] 
                   `unionT` transitions enfa1 
                   `unionT` transitions enfa2)
                 q1
                 (finals enfa1 `Set.union` finals enfa2))
    go (r1 :*: r2) = do
      enfa1 <- go r1
      enfa2 <- go r2
      return (FA (states enfa1 `Set.union` states enfa2)
                 (unionsT [eps f [start enfa2] | f <- Set.toList (finals enfa1)] 
                   `unionT` transitions enfa1 
                   `unionT` transitions enfa2)
                 (start enfa1)
                 (finals enfa2))
    go (Kleene r) = do
      enfa <- go r
      q1 <- newState
      q2 <- newState
      return (FA ([q1, q2] `Set.union` states enfa)
                 (eps q1 [start enfa] 
                   `unionT` eps q2 [q1] 
                   `unionT` unionsT [eps f [q2] | f <- Set.toList (finals enfa)] 
                   `unionT` transitions enfa)
                 q1
                 [q1, q2])
#endif


-- | Compute epsilon closure from a set of states in an epsilon NFA.
epsilonClosure :: EpsNFA -> Int -> Set Int
#ifdef TEMPLATE epsilon-elimination
epsilonClosure = undefined
#else
epsilonClosure enfa q = go [q] Set.empty
  where
    go [] seen = seen
    go (v : vs) seen
      | v `Set.member` seen = go vs seen
      | otherwise = go (Set.toList (lookupT v Nothing (transitions enfa)) ++ vs) (Set.insert v seen)
#endif


-- | Removes all epsilon transitions from an epsilon NFA and converts
-- the automaton into an NFA
epsilonElim :: EpsNFA -> NFA
#ifdef TEMPLATE epsilon-elimination
epsilonElim = undefined
#else
epsilonElim enfa = FA newStates newTransitions (start enfa) newFinals
  where 
    -- Memoize epsilon closures for each state
    epsilonClosures = Map.fromList (map (\q -> (q, epsilonClosure enfa q)) (Set.toList (states enfa)))

    newStates = states enfa

    nonEpsTransitions = Map.mapKeysMonotonic fromJust . Map.filterWithKey (\k _ -> isJust k)

    -- Collect all transitions go from a state in the epsilon closure to some
    -- target via a letter and merge all sets of transitions from a given state
    -- with the same letter.
    newTransitions = 
      unionsT [[(q, m')] | q <- Set.toList (states enfa)
                         , let ec = epsilonClosures Map.! q
                         , (v, m) <- Map.toList (transitions enfa)
                         , let m' = nonEpsTransitions m
                         , v `Set.member` ec
                         ]

    -- Final states are all original states that have a final state in their
    -- epsilon closure
    newFinals = Set.filter (any (isFinal enfa) . (epsilonClosures Map.!)) (states enfa)
#endif


-- | Constructs an intermediate DFA via the powerset construction from an NFA.
powerset :: NFA -> PDFA
#ifdef TEMPLATE powerset-construction
powerset = undefined
#else
powerset nfa = FA (Set.fromList seen) tm [start nfa] (Set.filter (any (`Set.member` finals nfa)) (Set.fromList seen))
  where
    (seen, tm) = go [[start nfa]] [] Map.empty

    -- We assume that all letters of the alphabet occurred as a label of a transition.
    alph = nub [c | m <- Map.elems (transitions nfa), c <- Map.keys m]

    -- [-1] is the sink: the state for "no state of the NFA is left".
    succs qs c =
      let ts = Set.unions [lookupT q c (transitions nfa) | q <- qs]
       in if Set.null ts then [-1] else Set.toList ts

    go [] done acc = (done, acc)
    go (qs : rest) done acc
      | qs `elem` done = go rest done acc
      | otherwise =
          let nexts = [(c, succs qs c) | c <- alph]
              acc' = acc `unionT` unionsT [trans qs c (Set.singleton t) | (c, t) <- nexts]
           in go (map snd nexts ++ rest) (qs : done) acc'
#endif


-- | Converts an intermediate DFA into a DFA.
relabel :: PDFA -> DFA
#ifdef TEMPLATE powerset-construction
relabel = undefined
#else
relabel pdfa = mapState label pdfa
  where label = (Map.fromList (zip (Set.toList (states pdfa)) [0..]) Map.!)
#endif


-- | Constructs a DFA from a regular expression.
compile :: RegExp -> DFA
#ifdef TEMPLATE powerset-construction
compile = undefined
#else
compile = relabel . powerset . epsilonElim . thompson
#endif


-- | Checks is a word is a member of the language of an regular expression.
member :: String -> DFA -> Bool
#ifdef TEMPLATE powerset-construction
member = undefined
#else
member w a = go w (start a)
  where
    go [] q = isFinal a q
    go (c : cs) q = any (go cs) (Set.toList (lookupT q c (transitions a)))
#endif


-- | Constructs a regular expression from a DFA.
stateElim :: DFA -> RegExp
#ifdef TEMPLATE state-elimination
stateElim = undefined
#else
stateElim dfa@(FA qs _ s fs) = case Map.elems (transitions (foldr elim gnfa qs)) of
  m : _ | re : _ <- Map.keys m -> re
  -- No final state can be reached.
  _ -> Empty
  where
    -- Two states that are not used in the original DFA
    s' = maximum qs + 1
    f' = maximum qs + 2

    -- If two edges s -> t exist, merge them into one by alternation.
    mergeParallel tm =
      unionsT [ trans a (foldr1 (:|:) res) (Set.singleton b) | ((a, b), res) <- Map.assocs grouped ]
      where
        grouped = Map.fromListWith (++)
                    [ ((a, b), [re])
                    | (a, m) <- Map.assocs tm
                    , (re, ts) <- Map.assocs m
                    , b <- Set.toList ts
                    ]

    -- Sipser's GNFA state-elimination procedure
    elim q g = g { states = Set.filter (/= q) (states g)
                 , transitions = mergeParallel (others `unionT` bridgeOverQ) }
      where
        out = Map.findWithDefault Map.empty q (transitions g)

        -- q's own self-loop becomes a Kleene star that gets spliced into every
        -- path that used to pass through q.
        selfLoop = listToMaybe [ c | (c, ts) <- Map.assocs out, q `Set.member` ts ]

        splice re1 Nothing    re3 = re1 :*: re3
        splice re1 (Just re2) re3 = re1 :*: Kleene re2 :*: re3

        -- For every predecessor a of q and successor b of q, add a direct
        -- transition a -> b labelled prefix selfLoop* suffix.
        bridgeOverQ =
          unionsT [ trans a (splice prefix selfLoop suffix) (Set.singleton b)
                  | (a, m) <- Map.assocs (transitions g)
                  , a /= q
                  , (prefix, ts) <- Map.assocs m
                  , q `Set.member` ts
                  , (suffix, ts') <- Map.assocs out
                  , b <- Set.toList ts'
                  , b /= q
                  ]

        -- Drop every edge incident to q.
        others = Map.map (Map.filter (not . Set.null) . Map.map (Set.filter (/= q))) (Map.delete q (transitions g))

    -- Convert the DFA into a generalized NFA by turning transition labels into
    -- regular expressions and introducing a new start and a new final state.
    gnfa = FA { states = Set.insert s' (Set.insert f' qs)
              , transitions = mergeParallel
                  (trans s' Epsilon [s]
                    `unionT` unionsT [trans f Epsilon [f'] | f <- Set.toList fs]
                    `unionT` transitions (mapTrans Let dfa))
              , start = s'
              , finals = [f']
              }
#endif
