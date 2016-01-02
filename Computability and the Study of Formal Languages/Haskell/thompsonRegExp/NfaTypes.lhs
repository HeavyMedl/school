-- Regular Expressions and Automata using Haskell
-- (c) Simon Thompson
-- NfaTypes.lhs implemented by Kurt Medley

Sets ADT Signature:
       Set
       empty               -- Set a
       sing                -- a -> Set a
       memSet              -- Ord a => Set a -> a -> Bool
       union,inter,diff    -- Ord a => Set a -> Set a -> Set a
       eqSet               -- Eq a  => Set a -> Set a -> Bool
       subSet              -- Ord a => Set a -> Set a -> Bool
       makeSet             -- Ord a => [a] -> Set a
       mapSet              -- Ord b => (a -> b) -> Set a -> Set b
       filterSet           -- (a -> Bool) -> Set a -> Set a
       foldSet             -- (a -> a -> a) -> a -> Set a -> a
       showSet             -- Show a => Set a -> String
       card                -- Set a -> Int
       flatten             -- Set a -> [a]
       setlimit            -- Eq a => (Set a -> Set a) -> Set a -> Set a
-----------------------------

> import RegExp
> import Sets

> data Nfa a = NFA (Set a) 
>		   (Set (Move a)) 
>		   a
>		   (Set a)
>		   deriving Show

> data Move a = Move a Char a | 
>		Emove a a 
>		deriving (Eq, Ord, Show)

> {-- The first argument, f, is the step function, taking a set and a character to the states accessible from the set on the character.  The second argument, r, is the starting state, and the final argument is the string along which to iterate --}
> foldl' :: (Set a -> Char -> Set a)
>		  -> Set a -> String -> Set a
> foldl' f r [] 	= r
> foldl' f r (c:cs) 	= foldl f (f r c) cs

> trans :: Ord a => Nfa a -> String -> Set a
> trans mach str =
>	foldl' step startset str
>	where
>	step set ch = onetrans mach ch set
>	startset = closure mach (sing (startstate mach))

> onetrans :: Ord a => Nfa a -> Char -> Set a -> Set a
> onetrans mach c x = closure mach (onemove mach c x)

> onemove :: Ord a => Nfa a -> Char -> Set a -> Set a
> onemove (NFA states moves start term) c x = 
>		makeSet [ s | t <- flatten x,
>			      Move z d s <- flatten moves,
>			      z == t, c == d ]

> startstate (NFA states moves start finish) = start

> closure :: Ord a => Nfa a -> Set a -> Set a
> closure (NFA states moves start term) =
>	setlimit add
>	where
>	add stateset = union stateset (makeSet accessible)
>		       where
>		       accessible
>			= [ s | x <- flatten stateset,
>				     Emove y s <- flatten moves,
>				     y == x ]

> build :: Reg -> Nfa Int
> build (Literal c) = 
>	NFA (makeSet [0 .. 1]) (sing (Move 0 c 1)) 0 (sing 1)

> build Epsilon =
>	NFA (makeSet [0 .. 1]) (sing (Emove 0 1)) 0 (sing 1)


>-- Example NFAs
> exnfa1 = NFA 	(makeSet [0..3])
>	       	(makeSet [ Move 0 'a' 0 ,
>	 		   Move 0 'a' 1 ,
>			   Move 0 'b' 0 ,
>			   Move 1 'b' 2 ,
>			   Move 2 'b' 3])
>	        0
>	        (sing 3)

> exnfa2 = NFA 	(makeSet [0..5])
>		(makeSet [ Move 0 'a' 1 ,
>			   Move 1 'b' 2 ,
>			   Move 0 'a' 3 ,
>			   Move 3 'b' 4 ,
>			   Emove 3 4	,
>			   Move 4 'b' 5 ])
>		0
>		(makeSet [2,5])
