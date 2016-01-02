-- Construction of a Regular Expression from a Finite Automaton
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
> import Data.List (nub)

> data Fsm a = 	FSM [a] 		-- States
>		    [Move a]		-- Transitions
>		     a			-- Q0
>		     a			-- Qt
>		deriving (Show, Eq, Ord)

> data Move a = Move a String a deriving (Eq, Ord, Show)

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

> partI (i:is) fsm@(FSM sts moves q0 qt) = do
>	let ([x,y,z]:xyzs) =
>		 [ [Move j set1 i,Move i set2 i,Move i set3 k] | 
>			j <- sts, k <- sts, j /= i, k /= i,
>			Move a set1 c <- moves, -- Get Strings from trans
>			Move q set2 w <- moves,
>			Move t set3 u <- moves,
>				Move j set1 i `elem` moves
>			 	&& Move i set3 k `elem` moves ]
>				-- Filter all triples [x,y,z]'s whose
>				-- j,i i,k exist within moves otherwise no arc exists
>	-- addarcs used to add the new arcs to the machine
>	-- nub (remove duplicates) is necessary to remove excess permutations
>	addarcs (nub $ funcI ([x,y,z]:xyzs) fsm) fsm
				
> funcI ([x,y,z] : xyzs) fsm@(FSM sts moves start finish)
>	-- i)
>	| x `elem` moves && not (y `elem` moves) && z `elem` moves 
>		= (Move (getJ x) (getStr x ++ getStr z) (getK z)) 
>			: funcI xyzs fsm
>	-- ii)
>	| x `elem` moves && y `elem` moves && z `elem` moves
>		= (Move (getJ x) ( getStr x ++ "(" ++ getStr y ++ ")" ++ "*"
>			++ getStr z) (getK z)) : funcI xyzs fsm
>	| otherwise = 	  funcI xyzs fsm
> funcI [] fsm = []
>		
> getStr (Move x y z) = y
> getJ (Move x y z) = x
> getK (Move x y z) = z


> -- partIa generates the list of pairs /= i to
> partIa fsm@(FSM sts moves q0 qt) = do 
>	let (i:is) = qi fsm
>	[ (j,k) | j <- sts, k <- sts, j /= i, k /= i ]



----------------------------------------
-- Test FSM's
----------------------------------------

> fsm1 :: Fsm Int
> fsm1 = FSM [0..3] [ Move 0 "a" 1, Move 1 "b" 2, Move 2 "a" 3 ] 0 3
