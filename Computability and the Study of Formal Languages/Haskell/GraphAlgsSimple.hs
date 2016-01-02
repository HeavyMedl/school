-- Assignment 8 -- Part 3 -- Simple Graph and Digraph Algorithms in Haskell
-- Kurt Medley

module GraphAlgsSimple where

import GraphSE
import SetUL
import Data.List (group, sort, nub)
{--
 - degree		:: Ord a => Graph a -> a -> Int
 - degreeSpectrum 	:: Ord a => Graph a -> [Int]
 - isPath		:: Ord a => Graph a -> Path a -> Bool
 - isSimplePath		:: Ord a => Graph a -> Path a -> Bool
 - isCycle		:: Ord a => Graph a -> Path a -> Bool
 - simplify		:: Ord a => Path a -> Path a
 --}
---------------------------------------------------------------------------------
--PRIVATE Graph ADT Signature
---------------------------------------------------------------------------------
{--
makeGraph   :: Ord a => [a] -> [(a,a)] -> Graph a
makeDiGraph :: Ord a => [a] -> [(a,a)] -> Graph a
showGraph   :: Ord a => Graph a -> ([a],[(a,a)])
vertices    :: Ord a => Graph a -> [a]	    -- return vertices of graph
edges       :: Ord a => Graph a -> [(a,a)]	    -- return edges of graph
adjacent    :: Ord a => Graph a -> a -> [a]	    -- return the adjacency list
isAdjacent  :: Ord a => Graph a -> a -> a -> Bool -- is (x,y) an edge?
--}
---------------------------------------------------------------------------------

-- the degree (or valency) of a vertex of a graph is the number of edges incident to
-- a vertex, with loops counted twice.

degree :: Ord a => Graph a -> a -> Int
degree (Graph (vs, es)) v = length $ adjacent (Graph (vs,es)) v

--If a graph g has n vertices then the degree spectrum of g is a list of
--length n whose head is the number of vertices of degree 0, whose second element
--is the number of vertices of degree 1, and so forth.  The function only
--needs to be defined for undirected graphs.

degreeSpectrum :: Ord a => Graph a -> [Int]
degreeSpectrum (Graph (vs, es)) = deg $ lengthdegree (Graph (vs,es))

-- lengthdegree groups and sorts the degrees of	each vertex in a graph in form [[Int]]
lengthdegree (Graph (vs, es)) = 
		group $ sort $ [ degree (Graph (vs,es)) x | x <- toList vs ] 

-- deg creates a list of the length of each group of degrees
-- [[0],[1,1],[2,2,2]] = [1,2,3]
deg [] = []
deg (x:xs) = length x : deg xs

--The Path data type is an ordered list of vertices. Since we're not working
--with multigraphs, this is a sufficient representation. A path [1,2,3] denotes
-- 1 -> 2 -> 3

type Path a = [a]

----------------------------------------------------------------------------------
-- isPath - Takes a graph and a list of vertices and determines if there is a
-- path between them.  This is function works on directed graphs. Writing this
-- alogrithm with isAdjacent instead of directAdj would allow for undirected g's.
----------------------------------------------------------------------------------
isPath :: Ord a => Graph a -> Path a -> Bool
isPath (Graph (ns, es)) []	= False
isPath (Graph (ns, es)) (x:[]) 	= True
isPath (Graph (ns, es)) (x:y:xs)
	| member x ns && directAdj (Graph (ns, es)) x y = isPath (Graph (ns,es)) (y:xs)
	| otherwise	= False

directAdj :: Ord a => Graph a -> a -> a -> Bool
directAdj (Graph (ns, es)) x y
	| (x,y) `elem` toList es	= True
	| otherwise			= False
------------------------------------------------------------------------------------
-- isSimplePath - A graph has a simple path if it has a path from 1 -> 2, and there
-- are no repeated edges in the path. ex (1,2),(2,1) is a repetition.
------------------------------------------------------------------------------------
{--
isSimplePath :: Ord a => Graph a -> Path a -> Bool
isSimplePath (Graph (ns, es)) (x:y:[]) = isPath (Graph (ns,es)) (x:y:[])
isSimplePath (Graph (ns, es)) (x:y:xs)
	| isPath (Graph (ns, es)) (x:y:xs) && equallists (Graph (ns,es))	= True
	| otherwise								= False

sortedges :: Ord a => [(a,a)] -> [(a,a)]
sortedges [] = []
sortedges (x:xs)
	| fst x > snd x		= (snd x, fst x) : sortedges xs
	| otherwise		= (fst x, snd x) : sortedges xs

equallists (Graph (ns, es)) = (sortedges $ toList es) == (nub (sortedges $ toList es))

simple :: Ord a => Graph a -> Path a -> Bool
simple (Graph (ns,es)) xs
	| isPath (Graph (ns, es)) xs = and [ e == b | (a,b) <- toList es, e <- xs ]
	| otherwise		     = True

--}
-----------------------------------------------------------------------------------
-- isSimplePath - This representation tests if a given path is valid and if there
-- are any duplicates in the list of vertices. nodups [1,2,3] = T, nodups [1,2,3,3]
-- = F. ---------------------------------------------------------------------------
isSimplePath :: Ord a => Graph a -> Path a -> Bool
isSimplePath (Graph (ns, es)) xs
	| isPath (Graph (ns,es)) xs && nodups xs	= True
	| otherwise					= False

nodups xs = xs == nub xs 

----------------------------------------------------------------------------------
-- isCycle --
-- If the path is a simple path, with no repeated vertices or edges other than 
-- the starting and ending vertices, it may also be called a simple cycle, circuit, 
-- circle, or polygon. A cycle in a directed graph is called a directed cycle
----------------------------------------------------------------------------------
isCycle :: Ord a => Graph a -> Path a -> Bool
isCycle (Graph (ns, es)) xs
	| isPath (Graph (ns,es)) xs && length xs > 1 && head xs == last xs = True
	| otherwise = False

----------------------------------------------------------------------------------
-- simplify - Turn a path into a simple path by snipping out un-necessary cycles.
----------------------------------------------------------------------------------
--simplify :: Ord a => Graph a -> Path a -> Path a
--simplify (Graph (ns,es)) (

indegree :: Ord a => Graph a -> a -> Int
indegree (Graph (ns, es)) v
	| not (member v ns)	= error "Vertex not in graph."
	| otherwise 		= length [ 1 | (x,y) <- toList es, v == y ]

outdegree :: Ord a => Graph a -> a -> Int
outdegree (Graph (ns, es)) v
	| not (member v ns)	= error "Vertex not in graph."
	| otherwise		= length [ 1 | (x,y) <- toList es, v == x ]


g4 = makeGraph [1..6] [(1,2),(2,3),(1,3),(4,6)]
