State Monad Notes LYAH 313

> import Control.Monad.State

A stateful computation is a function that takes some state and returns a value along with some new state.  That function has the following type:

s -> (a, s) :: s is the type of the state, and a is the result of the stateful computations.

> type Stack = [Int]

> pop :: Stack -> (Int, Stack)
> pop (x:xs) = (x, xs)

> push :: Int -> Stack -> ((), Stack)
> push a xs = ((), a:xs)

> stackManip :: Stack -> (Int, Stack)
> stackManip stack = let
>	((), newStack1) = push 3 stack
>	(a, newStack2)	= pop newStack1
>	in pop newStack2


The State Monad

>-- newtype State s a = State { runState :: s -> (a, s) }

A State s a is a stateful computation that manipulates a state of type s and has a result of type a. 

* The value constructor is not exported, so we must use the "state" function, which does the same thing that the State constructor would do.

Monad Instance:

>-- instance Monad (State s) where
>--	return x = State $ \s -> (x,s)
>--	(State h) >>= f = State $ \s -> let (a, newState) = h s
>--					    (State g)	  = f a
>--					in  g newState

We always present x as the result of the stateful computation, and the state is kept unchanged, because return must put a value in a minimal context.

(>>=) The result of feeding a stateful computation to a function with >>= must be stateful computation.  Start with the State newtype wrapper..  The lambda will be our new stateful computation.  Because we're in a stateful computation right now, we can give the stateful computation h our current state s, which results in a pair of the result and a new state: (a, newState).  Now we do f a, and we get a new stateful computation g.  Now that we have a new stateful computation and a new state (which goes by the name of newState), we just apply that stateful computation g to the newState.  The result is a tuple of the final result and final state.


> pop' :: State Stack Int
> pop' = state $ \(x:xs) -> (x, xs)

> push' :: Int -> State Stack ()
> push' a = state $ \xs -> ((), a:xs)

>-- stackStuff :: State Stack ()
>-- stackStuff = do
>-- 	a <- pop
>--	if a == 5
>--		then push 5
>--		else do
>--			push 3
>--			push 8

> pop'' :: State Stack Int
> pop'' = do
>	(x:xs) <- get
>	put xs
>	return x

