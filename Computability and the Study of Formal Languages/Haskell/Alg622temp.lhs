Construction of a Regular Expression from a Finite Automaton
-- Kurt Medley
-- April 2013
-------------------------------------
From Thomas Sudkamp's Languages and Machines (pgs 193-194):
An expression graph is a labeled directed graph in which the arcs are labeled by regular expressions.  An expression graph, like a state diagram, contains a distinguished start node and a set of accepting nodes.  A procedure is developed to reduce an arbitrary expression graph to an expression graph containing at most two nodes.  The reduction is accomplished by repeatedly removing nodes from the graph in a manner that preserves the language of the graph.

Algorithm 6.2.2

input: state diagram G of a finite automaton with one accepting state

Let Q0 be the start state and Qt the accepting state of G.
1. repeat
	1.1 choose a node Qi that is neither Q0 nor Qt
	1.2 delete the node Qi from G according to the following procedure
		1.2.1	for every j,k not equal to i (this includes j=k) do
			i) if Wj,i /= 0, Wi,k /= 0 and Wi,i = 0, then add an
				arc from node j to node k labeled Wj,iWi,k
			ii) if Wj,i /= 0, Wi,k /= 0 and Wi,i /= 0 then add
				an arc from node Qj to node Qk labeled 
				Wj,i(Wi,i)*Wi,k
			iii) if nodes Qj and Qk have arcs labeled W1,W2,..,Ws
				connecting them, then replace the arcs by
				a single arc labeled W1 U W2 U .. U Ws
		1.2.2	remove the node Qi and all arcs incident to it in G
			until the only nodes in G are Q0 and Qt
2. determine the expression accepted by G
---------------------------------------

> import Control.Monad.State
> import Data.List (nub, nubBy, union, groupBy, partition, intersperse)

> data Fsm a = 	FSM [a] 		-- States
>		    [Move a]		-- Transitions
>		     a			-- Q0
>		     a			-- Qt
>		deriving (Show, Eq, Ord)

> data Move a = Move a String a deriving (Ord, Show, Eq)

> type FsmT = StateT (Fsm Int) IO

----------------------------------------
-- Potentially useful functions
----------------------------------------

> -- Example using a state monadic function; runStateT func1 <FSM>
> func1 :: FsmT ()
> func1 = do
>	st <- get
>	put st
>	liftIO $ putStrLn "iddy biddy"

> -- Generate the nodes to be deleted
> qi (FSM states moves q0 qt) = [ sts | sts <- states, sts /= q0, sts /= qt ]

> -- Add an arc to a provided FSM, produce a new FSM with added arc
> addarc x (FSM sts moves q0 qt) = FSM sts (x:moves) q0 qt

> addarcs [] fsm@(FSM sts moves q0 qt) = fsm
> addarcs (x:xs) (FSM sts moves q0 qt) = addarcs xs (FSM sts (x:moves) q0 qt)

> addarcs' [] ys = ys
> addarcs' (x:xs) ys = x : addarcs' xs ys 

> -- Append two FSM's; Creates a FSM by the union of states and transitions
> appendFsm (FSM a bs c d) (FSM e fs q0 qt) = FSM (union a e) (union bs fs) c d

----------------------------------------

> partI i fsm@(FSM sts moves q0 qt) 
>	= addarcs' (nub $ funci newArcs fsm) moves
>		where
>		newArcs = 
>			[ [Move j set1 i,Move i set2 i,Move i set3 k] | 
>				j <- sts, k <- sts, j /= i, k /= i,
>				Move a set1 c <- moves, -- Get Strings from trans
>				Move q set2 w <- moves,
>				Move t set3 u <- moves,
>				Move j set1 i `elem` moves
>			 	&& Move i set3 k `elem` moves ]
>				-- Filter all triples [x,y,z]'s whose
>				-- j,i i,k exist within moves otherwise no arc exists

				
> funci ([x,y,z] : xyzs) fsm@(FSM sts moves start finish)
>	-- i)
>	| x `elem` moves && not (y `elem` moves) && z `elem` moves 
>		= (Move (getJ x) (getStr x ++ getStr z) (getK z)) 
>			: funci xyzs fsm
>	-- ii)
>	| x `elem` moves && y `elem` moves && z `elem` moves
>		= (Move (getJ x) ( getStr x ++ "(" ++ getStr y ++ ")" ++ "*"
>			++ getStr z) (getK z)) : funci xyzs fsm
>	| otherwise = 	  funci xyzs fsm
> funci [] fsm = []
>	
> funciii i fsm@(FSM sts moves q0 qt) = replace $ group [ Move j s k | Move j s k <- partI i fsm,
>							j /= i, k /= i ]

> replace [] = [] 
> replace (xs:xss) = merge xs : replace xss

> -- merge is addressing lists of lists.
> -- [[ Move 1 "a" 2, Move 1 "b" 2], [ Move 2 "a" 3, Move 2 "b" 3]]
> merge strings@(x:xs) = Move (getJ x) (getOr strings) (getK x)

> getOr [] = []
> getOr ms = (init $ foldr (++) [] [ y ++ "|" | Move x y z <- ms ] )

> -- group takes a list of moves and sorts them by eqArc; ex. [Move 1 "a" 2, Move 1 "bb" 2, Move 0 "a" 1, Move 0 "ab" 1] = [ [Move 1 "a" 2, Move 1 "bb" 2],[Move 0 "a" 1, Move 0 "ab" 1] ] There is a bug here that may need to be addressed.  fst partition produces the correct groupings with already used arcs.  May add unncessary but correct arcs..
> group [] = []
> group (x:xs) = aux x (x:xs) : group xs
>	where
> 	aux x = (\xs -> fst $ partition (eqArc x) xs)

> flatten :: [[Move a]] -> [Move a]
> flatten xs = concat xs

> eqArc (Move a b c) (Move x y z) = a == x && c == z
> getStr (Move x y z) = y
> getJ (Move x y z) = x
> getK (Move x y z) = z
> getAlpha (FSM sts [] q0 qt)		= []
> getAlpha (FSM sts (x:xs) q0 qt)	= getStr x : getAlpha (FSM sts xs q0 qt)


----------------------------------------
-- Test FSM's
----------------------------------------

> fsm1 :: Fsm Int
> fsm1 = FSM [0..3] [ Move 0 "a" 1, Move 1 "b" 2, Move 2 "a" 3 ] 0 3
