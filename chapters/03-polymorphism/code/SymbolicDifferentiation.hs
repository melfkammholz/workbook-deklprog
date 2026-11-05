module SymbolicDifferentiation (Fun (..), sigma, ($$), derive) where

data Fun = X            -- x     (Variable x)
         | E            -- e     (Euler's constant)
         | Num Double   -- c     (Constant)
         | Ln Fun       -- ln    (Natural logarithm)
         | Fun :+: Fun  -- f + g (Addition)
         | Fun :-: Fun  -- f - g (Subtraction)
         | Fun :*: Fun  -- f * g (Multiplication)
         | Fun :/: Fun  -- f / g (Division)
         | Fun :<: Fun  -- f o g (Composition)
         | Fun :^: Fun  -- f ^ g (Exponentiation)
  deriving Show

-- | The function 1 / (1 + e^(-x)).
sigma :: Fun
#ifdef TEMPLATE
sigma = undefined
#else
sigma = Num 1 :/: (Num 1 :+: (E :^: (Num 0 :-: X)))
#endif

-- | Evaluates a function at a point.
($$) :: Fun -> Double -> Double
#ifdef TEMPLATE
f $$ x = undefined
#else
X         $$ x = x
E         $$ _ = exp 1
Num c     $$ _ = c
Ln f      $$ x = log (f $$ x)
(f :+: g) $$ x = (f $$ x) + (g $$ x)
(f :-: g) $$ x = (f $$ x) - (g $$ x)
(f :*: g) $$ x = (f $$ x) * (g $$ x)
(f :/: g) $$ x = (f $$ x) / (g $$ x)
(f :<: g) $$ x = f $$ (g $$ x)
(f :^: g) $$ x = (f $$ x) ** (g $$ x)
#endif

-- | The derivative of a function. It does not have to be simplified.
derive :: Fun -> Fun
#ifdef TEMPLATE
derive f = undefined
#else
derive X         = Num 1
derive E         = Num 0
derive (Num _)   = Num 0
derive (Ln f)    = derive f :/: f
derive (f :+: g) = derive f :+: derive g
derive (f :-: g) = derive f :-: derive g
derive (f :*: g) = (derive f :*: g) :+: (f :*: derive g)
derive (f :/: g) = ((derive f :*: g) :-: (f :*: derive g)) :/: (g :*: g)
derive (f :<: g) = (derive f :<: g) :*: derive g
derive (f :^: g) = (f :^: g) :*: ((derive g :*: Ln f) :+: (g :*: (derive f :/: f)))
#endif
