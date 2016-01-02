-- Breadth-First Search 
-- (c) Kurt Medley
-- May 2013
-------------------------------------
Discrete Mathematics 5th edition by Dossey et al. (pg 183)
"This algorithm determines the distance and a shortest path in a graph from vertex S to every other vertex for which there is a path from S.  In the algorithm, L denotes the set of labeled vertices, and the predecessor of vertex A is a vertex in L that is used in labeling A.

Step 1	(label S)
			(a) Assign S the label 0, and let S have no predecessor.
			(b) Set L = {S} and k = 0.
Step 2	(label vertices)
		repeat
			Step 2.1 (increase the label)
				Replace k with k+1
			Step 2.2 (enlarge labeling)
				while L contains a vertex V with label k-1 that is adjacent to a vertex W not in L
					(a) Assign the label k to W.
					(b) Assign V to be the predecessor of W.
					(c) Include W in L
				endwhile
		until no vertex in L is adjacent to a vertex not in L
Step 3	(construct a shortest path to a vertex)
		if a vertex T is in L
			The label on T is its distance from S. A shortest path from S to T is formed by taking
			in reverse order T, the predecessor of T, the predecessor of the predecessor of T,
			and so forth, until S is reached.
		otherwise
			There is no path from S to T.
		endif
-------------------------------------

> import Control.Monad.State
> import Data.List

> data Graph a = G [(a,a)]	-- Edges
>		   [Label a]		-- Vertex label and predecessor [Label "S" (0,"-")]
>		  deriving (Eq, Ord, Show, Read)

> data Label a = Label a (Int,a) deriving (Eq, Ord, Show, Read)

> type GraphT = StateT (Graph [Char]) IO

-------------------------------------
-- Monadic BFS Runner 
-------------------------------------

> bfsRunner = runStateT bfsRunT g1

> bfsRunT :: GraphT ()
> bfsRunT = do
>	graph <- get
>	put $ labelVs graph
>	liftIO $ putStrLn $ "Shortest path to which vertex?" ++ "\n" ++ show (vertices graph)
>	vertex <- liftIO $ getLine
>	graph <- get
>	if vertex `notElem` (vertLabels graph)
>			then do error $ "Vertex is not labeled and is therefore not connected " ++
>							"to root S or Vertex does not exist. Case Sensistive." ++ "\n"
>							++ "\n" ++ "Labeled vertices: " ++ show (vertLabels graph)
>			else liftIO $ putStrLn $ 
>				"\n" ++ "Shortest path to " ++ vertex ++ " is: " ++
>				show (construct vertex graph) ++ "\n"

-------------------------------------
-- Steps 1 and 2: Label S and Vertices
-------------------------------------

> labelVs g@(G edges labels) = propogate lbs g
>	where
>	labelS = assign (Label "S" (0,"-")) g
>	lbs = getLabels (labelS)

-------------------------------------
-- Step 3: Construct a Shortest Path
-------------------------------------

> construct v g@(G edges labels) = reverse $ (v : shortestPath v g) 

> shortestPath v g@(G edges labels)
>	| v `elem` vertLabels g && v /= "S" 	= predecessor v g : shortestPath (predecessor v g) g
>	| otherwise				= []

-------------------------------------
-- Auxillary Functions
-------------------------------------

> -- propogate generates the list of labels associated with step 2
> propogate [] graph = graph
> propogate (Label v (k,pred):lbs) graph@(G edges labels) = do
>	let gLabels = [ Label a (k+1,v) | a <- adjacencyList v graph, not $ hasLabel a graph, a /= "S" ]
>	propogate (lbs ++ gLabels) (assignLabels gLabels graph)

> -- return the list of labels in a graph; [Label x (y,z)]
> getLabels (G edges labels) = labels

> -- List of vertices with labels; Label x (y,z) -> [x]
> vertLabels (G edges []) = []
> vertLabels (G edges (Label x (y,z):labels)) = x : vertLabels (G edges labels)

> -- assign a label to a vertex: Label v (<int>, <pred>)
> assign l (G edges labels) = G edges (labels ++ [l])

> -- assign a list of labels to a graph
> assignLabels [] graph = graph
> assignLabels (x:xs) graph = assign x (assignLabels xs graph)

> -- give the list of vertices in a graph
> vertices :: Eq a => Graph a -> [a]
> vertices (G edges labels) = nub [ e1 | (e1,e2) <- edges ]

> -- give the list of edges in a graph
> edges :: Eq a => Graph a -> [(a,a)]
> edges (G edges labels) = edges

> -- tests if two vertices are adjacent
> isAdj x y edges
>	| (x,y) `elem` edges || (y,x) `elem` edges 	= True
>	| otherwise									= False

> -- adjacencyList gives the list of vertices adjacent to x
> adjacencyList x graph@(G edges labels) = [ y | y <- vertices graph, isAdj x y edges ]

> -- predecessor returns the predecessor of a given vertex
> predecessor x (G edges []) = []
> predecessor x (G edges (Label a (k,pred):labels)) 
> 	| x == a	= pred
>	| otherwise	= predecessor x (G edges labels)

> -- hasLabel tests if a vertex "x" already has a label assigned to it
> hasLabel x (G edges labels) = any (==x) [ a | Label a (lb,pred) <- labels ]

> -- k returns the label (integer) of a given vertex
> k x (G edges []) = error "No label associated with vertex"
> k x (G edges (Label a (y,pred):labels))
>	| x == a	= y
>	| otherwise	= k x (G edges labels)

-------------------------------------
-- Test Graphs
-------------------------------------

> g1 :: Graph [Char]
> g1 = G [	("S","A"),("S","B"),("A","E"),("A","C"),
>		("A","S"),("B","S"),("B","C"),("B","D"),
>		("C","E"),("C","H"),("D","G"),("E","C"),
>		("E","F"),("F","E"),("F","H"),("G","J"),
>		("H","C"),("H","F"),("H","I"),("I","H"),
>		("I","J"),("J","I"),("J","G"),("K","L"),
>		("K","M"),("L","K"),("L","M"),("M","K"),
>		("M","L") ] []
