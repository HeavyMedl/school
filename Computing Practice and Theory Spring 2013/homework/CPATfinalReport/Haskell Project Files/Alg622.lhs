-- Construction of a Regular Expression from a Finite Automaton
-- (c) Kurt Medley
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
> import Data.List (nub, nubBy, permutations, union, groupBy, partition, intersperse)

> data Fsm a = 	FSM [a] 		-- States
>		    [Move a]		-- Transitions
>		     a			-- Q0
>		     a			-- Qt
>		deriving (Show, Eq, Ord)

> data Move a = Move a String a deriving (Ord, Show, Eq)

> type FsmT = StateT (Fsm Int) IO

----------------------------------------
-- A monadic transformer to minimize the FSM and generate
-- the regular expression. ex. run: runStateT <func> fsm
----------------------------------------

> generator :: FsmT ()
> generator = do
>	fsm <- get
>	liftIO $ putStrLn $ "\n" ++ "Inputed Finite State Machine: " ++ "\n" ++ (show fsm) ++ "\n"
>	put $ compile (qi fsm) fsm
>	newfsm@(FSM sts' moves q0 qt) <- get
>	liftIO $ putStrLn $ "Resulting Finite State Machine: " ++ "\n" ++ show (FSM (newStates newfsm) moves q0 qt) ++ "\n"
>	liftIO $ putStrLn $ "Regular Expression Generated: " ++ "\n" ++ (regexp newfsm) ++ "\n"

----------------------------------------
-- Final Or'ing together of the transitions and generation
-- of the regular expression
----------------------------------------

> regexp (FSM sts moves q0 qt) = (process startloops) ++ 
>				 (connect startfinish) ++
>				 (process finishloops) ++
>				 (doesExist finishstart)
> 	where
>	startloops  = 	[ Move x y z | Move x y z <- moves, Move x y z == Move q0 y q0 ]
>	finishloops = 	[ Move x y z | Move x y z <- moves, Move x y z == Move qt y qt ]
>	startfinish = 	[ Move x y z | Move x y z <- moves, Move x y z == Move q0 y qt ]
>	finishstart = 	[ Move x y z | Move x y z <- moves, Move x y z == Move qt y q0 ]
> 	process loops
>		| length loops == 1	= "(" ++ head [ y | Move x y z <- loops ] ++ ")" ++ "*"
>		| length loops > 1	= "(" ++ (init $ foldr (++) [] [ s ++ "|" | Move x s y <- loops ]) ++ ")" ++ "*"
>		| otherwise		= []
>	-- base case for connect does not prepend and append ( ) * because this arc doesn't connect its current and end nodes.	
>	connect loops
>		| length loops == 1 	= head [ y | Move x y z <- loops ]
>		| length loops > 1	= "(" ++ (init $ foldr (++) [] [ s ++ "|" | Move x s y <- loops  ] ) ++ ")"
>		| otherwise		= []
>	
>	doesExist loops
>		| length loops >= 1 	
>		= "(" ++ connect finishstart ++ process startloops ++ connect startfinish ++ process finishloops ++ ")" ++ "*"
>		| otherwise		= []
	
----------------------------------------
-- Compile: where the magic happens.
-- Recursively call partIII (which works on deleting
-- intermediate transitions) until only q0 and qt remain.
-- ex usage: compile (qi fsm1) fsm1
----------------------------------------

> compile [] fsm = fsm
> compile (i:is) fsm@(FSM sts moves q0 qt) = compile is (FSM sts newMoves q0 qt)
>		where 	
>		newMoves 	= partIII i fsm
 
----------------------------------------
 -- partIandII and partIII correlate to the algorithm above;
 -- These functions are piped together in 'compile' and reduce
 -- a FSM G to a minimal state, namely Q = [ q0, qt ]
----------------------------------------

> partIandII i fsm@(FSM sts moves q0 qt) 
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
> partIII i fsm@(FSM sts moves q0 qt) =
>		-- iii) 
>		replace $ (nub $ groupN newMoves newMoves)
>				where
>				newMoves = [ Move j s k | Move j s k <- partIandII i fsm,
>								j /= i, k /= i ]
>				replace [] = []
>				replace (xs:xss) = merge xs : replace xss
>				merge strings@(x:xs) = Move (getJ x) (getOr strings) (getK x)

----------------------------------------
-- Auxillary Functions
----------------------------------------

> getOr [] = []
> getOr ms = (init $ foldr (++) [] [ y ++ "|" | Move x y z <- ms ] )

> -- group takes a list of moves and sorts them by eqArc; ex. [Move 1 "a" 2, Move 1 "bb" 2, Move 0 "a" 1, Move 0 "ab" 1] = [ [Move 1 "a" 2, Move 1 "bb" 2],[Move 0 "a" 1, Move 0 "ab" 1] ] There is a bug here that may need to be addressed.  fst partition produces the correct groupings with already used arcs.  May add unncessary but correct arcs..
> group [] = []
> group (x:xs) = aux x (x:xs) : group xs
>	where
> 	aux x = (\xs -> fst $ partition (eqArc x) xs)

> groupN [] _ = []
> groupN ((Move x y z):xs) mvs =
>	 (fst $ partition (\m -> eqArc m (Move x y z)) mvs)
>		: groupN xs mvs

> min' mvs = minimum $ concat [ [a] ++ [c] | Move a b c <- mvs ]
> max' mvs = maximum $ concat [ [a] ++ [c] | Move a b c <- mvs ]

> eqArc (Move a b c) (Move x y z) = a == x && c == z
> getStr (Move x y z) = y
> getJ (Move x y z) = x
> getK (Move x y z) = z
> getAlpha (FSM sts [] q0 qt)		= []
> getAlpha (FSM sts (x:xs) q0 qt)	= getStr x : getAlpha (FSM sts xs q0 qt)

> -- Generate the nodes to be deleted
> qi (FSM states moves q0 qt) = [ sts | sts <- states, sts /= q0, sts /= qt ]

> -- Add an arc to a provided FSM, produce a new FSM with added arc
> addarc x (FSM sts moves q0 qt) = FSM sts (x:moves) q0 qt

> addarcs [] fsm@(FSM sts moves q0 qt) = fsm
> addarcs (x:xs) (FSM sts moves q0 qt) = addarcs xs (FSM sts (x:moves) q0 qt)

> addarcs' [] ys = ys
> addarcs' (x:xs) ys = x : addarcs' xs ys 

> -- Delete the states of the machine; only the start and finish states remain
> newStates (FSM sts moves q0 qt) = [ states | states <- [q0,qt] ]

----------------------------------------
-- Test FSMs
----------------------------------------

> fsm1 :: Fsm Int
> fsm1 = FSM [0..3] [ Move 0 "a" 1, Move 1 "b" 2, Move 2 "a" 3 ] 0 3

> fsm2 :: Fsm Int
> fsm2 = FSM [0..3] [ Move 0 "a" 2, Move 0 "a" 3, Move 1 "b" 0, Move 2 "b" 2, Move 2 "a" 1, Move 3 "b" 1, Move 3 "b" 0] 0 3

> fsm3 :: Fsm Int -- From Sudkamp's example 6.3.4 DFA M
> fsm3 = FSM [0..3] [ Move 0 "a" 1, Move 0 "b" 3, Move 1 "b" 2, Move 1 "b" 0, Move 2 "b" 1, Move 2 "a" 3, Move 3 "a" 2, Move 3 "b" 0] 0 3
