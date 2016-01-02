-- Assignment 8 Part 2 -- GraphSE.hs - Graph module using set-of-edges
-- representation of Graphs. 
-- Kurt Medley

module GraphSE {--(Graph, makeGraph, makeDiGraph, showGraph, vertices, edges,
		   adjacent, isAdjacent)--} where

import SetUL

{-- Graph ADT signature
 - makeGraph 	:: Ord a => [a] -> [(a,a)] -> Graph a
 - makeDigraph 	:: Ord a => [a] -> [(a,a)] -> Graph a
 - showGraph	:: Ord a => Graph a -> ([a],[(a,a)])
 - vertices	:: Ord a => Graph a -> [a]		-- return vertices of graph
 - edges	:: Ord a => Graph a -> [(a,a)]		-- return edges of graph
 - adjacent	:: Ord a => Graph a -> a -> [a]		-- return the adjacency list
 - isAdjacent	:: Ord a => Graph a -> a -> a -> Bool	-- is (x,y) an edge
 --}

------------------------------------------------------------------------------------
--PRIVATE (imported functions from SetUL)
------------------------------------------------------------------------------------
{--
null :: Set a -> Bool
member  :: Ord a => a -> Set a -> Bool
empty :: Set a
fromList :: Ord a => [a] -> Set a
toList :: Ord a => Set a -> [a]   -- Data.Set doesn't have (Ord a) context
insert  :: Ord a => a -> Set a -> Set a
delete  :: Ord a => a -> Set a -> Set a
--}
-----------------------------------------------------------------------------------
{--
Definition: (From Dossey p152, 3rd Ed) A directed graph is a pair (V,E)
where V is a finite non-empty set of "vertices", and E is a set
of "directed edges", which are ordered pairs of distinct elements of V.
Directed graphs allow an edge from a node to itself.

In the definition for undirected graphs that we are using there
are no edges from a node to itself and there is at most one
edge between any two nodes.

A graph in this module is represented as set of nodes and a set of directed
edges. Thus, a digraph is directly represented, however, if the graph
is undirected, then makeGraph must generate all of the symetric pairs of
directed edges as needed. It will also need to dis-allow loop edges.

The fact that graphs are represented as di-graphs is NOT hidden from the
user of the Graph module. This is manifest in "showGraph" and "edges" which
produce symetric pairs of directed edges. All other implementation details
are hidden.
--}
----------------------------------------------------------------------------------

newtype Graph a = Graph (Set a, Set (a,a))

instance Show a => Show (Graph a) where
	show (Graph n) = show n

makeGraph :: Ord a => [a] -> [(a,a)] -> Graph a
makeGraph vs es = Graph (fromList vs, fromList es)

makeDiGraph :: Ord a => [a] -> [(a,a)] -> Graph a
makeDiGraph vs es = Graph (fromList vs, fromList es)

--Undirected graphs do not allow loop edges

checkGraph :: Eq a => [a] -> [(a,a)] -> Bool
checkGraph vs es 
   | not (subset endpoints vs) 	= error "makeGraph - Some endpoints are not in vertex list"
   | isLoopEdge es 		= error "makeGraph - Loop edges not allowed in edge list"
   | otherwise    		= True
   where
     isLoopEdge = or . map (\(x,y) -> x == y) 
     (xs,ys) = unzip es
     endpoints = xs ++ ys


--DiGraphs allow loop edges

checkDiGraph :: Eq a => [a] -> [(a,a)] -> Bool
checkDiGraph vs es 
   | not (subset endpoints vs)	 = error "makeGraph - Some endpoints are not in vertex list"
   | otherwise    = True
   where
     (xs,ys) = unzip es
     endpoints = xs ++ ys


showGraph :: Ord a => Graph a -> ([a],[(a,a)])
showGraph (Graph (vs, es)) = (toList vs, toList es)

vertices :: Ord a => Graph a -> [a]
vertices (Graph (vs, es)) = toList vs

edges :: Ord a => Graph a -> [(a,a)]
edges (Graph (vs, es)) = toList es

{-- First attempt adjacent; can't pattern match Graph because
 - type constructor not visible.
adjacent :: Ord a => Graph a -> a -> [a]
adjacent (Graph (ns, (e:es))) v
	| not (v `elem` ns)	= error "Vertice not in graph"
	| v == fst $ toList e	= snd $ toList e : adjacent (Graph (ns, es)) v
	| v == snd $ toList e	= fst $ toList e : adjacent (Graph (ns, es)) v
adjacent (Graph (ns, [])) v 	= []
--}
isAdjacent :: Ord a => Graph a -> a -> a -> Bool
isAdjacent (Graph (ns, es)) v1 v2
	| member (v1,v2) es || member (v2,v1) es	= True
	| otherwise					= False

adjacent :: Ord a => Graph a -> a -> [a]
adjacent (Graph (ns, es)) v = [ x | x <- toList ns, isAdjacent (Graph (ns, es)) v x ]

---- Support Function ----
subset :: Eq a => [a] -> [a] -> Bool
subset xs ys = and [elem x ys | x <- xs ]
