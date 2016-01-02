-- Regular Expressions and Automata using Haskell
-- (c) Simon Thompson
-- Sets.lhs implemented by Kurt Medley

> module Sets ( Set,
>	empty			, -- Set a
>	sing			, -- a -> Set a
>	memSet			, -- Ord a => Set a -> a -> Bool
>	union,inter,diff	, -- Ord a => Set a -> Set a -> Set a
>	eqSet			, -- Eq a  => Set a -> Set a -> Bool
>	subSet			, -- Ord a => Set a -> Set a -> Bool
>	makeSet			, -- Ord a => [a] -> Set a
>	mapSet			, -- Ord b => (a -> b) -> Set a -> Set b
>	filterSet		, -- (a -> Bool) -> Set a -> Set a
>	cons			, -- a -> Set a -> Set a
>	foldSet			, -- (a -> a -> a) -> a -> Set a -> a
>	showSet			, -- Show a => Set a -> String
>	card			, -- Set a -> Int
>	flatten			, -- Set a -> [a]
>	setlimit		  -- Eq a => (Set a -> Set a) -> Set a -> Set a
>	) where

> import List hiding (union)

> newtype Set a = SetI [a]

> instance Eq a => Eq (Set a) where
> 	(==) = eqSet

> instance Ord a => Ord (Set a) where
> 	s1 <= s2 = flatten s1 <= flatten s2

> instance Show a => Show (Set a) where
> 	show (SetI xs) = show xs

>-- The empty set
> empty = SetI []

>-- Singleton set
> sing x = SetI [x]

>-- memSet tests whether x is a member of the set xs; notice ord (<)
> memSet :: Ord a => Set a -> a -> Bool
> memSet (SetI []) y	= False
> memSet (SetI (x:xs)) y
>	| x < y		= memSet (SetI xs) y
>	| x == y 	= True
>	| otherwise	= False

>-- union of sets, intersection of sets, difference of sets
> union :: Ord a => Set a -> Set a -> Set a
> union (SetI xs) (SetI ys) = SetI (uni xs ys)

> uni :: Ord a => [a] -> [a] -> [a]
> uni [] ys	= ys
> uni xs []	= xs
> uni (x:xs) (y:ys)
>	| x < y		= x : uni xs (y:ys)
>	| x == y	= x : uni xs ys
>	| otherwise	= y : uni (x:xs) ys

> inter :: Ord a => Set a -> Set a -> Set a
> inter (SetI xs) (SetI ys) = SetI (int xs ys)

> int :: Ord a => [a] -> [a] -> [a]
> int [] ys		= []
> int xs []		= []
> int (x:xs) (y:ys)
>	| x < y		= int xs (y:ys)
>	| x == y 	= x : int xs ys
>	| otherwise	= int (x:xs) ys

> diff :: Ord a => Set a -> Set a -> Set a
> diff (SetI xs) (SetI ys) = SetI (dif xs ys)

> dif :: Ord a => [a] -> [a] -> [a]
> dif [] ys		= []
> dif xs []		= xs
> dif (x:xs) (y:ys)
>	| x < y		= x : dif xs (y:ys)
>	| x == y	= dif xs ys
>	| otherwise	= dif (x:xs) ys

>-- subSet xs ys tests whether xs is a subset of ys; that is whether every element of xs is an element of ys.
> subSet :: Ord a => Set a -> Set a -> Bool
> subSet (SetI xs) (SetI ys) = subS xs ys

> subS :: Ord a => [a] -> [a] -> Bool
> subS [] ys	= True
> subS xs []	= False
> subS (x:xs) (y:ys)
>	| x < y		= False
>	| x == y	= subS xs ys
>	| x > y		= subS (x:xs) ys

>-- eqSet x y tests whether two sets are equal
> eqSet :: Eq a => Set a -> Set a -> Bool
> eqSet (SetI xs) (SetI ys) = xs == ys

>-- mapSet, filterSet, foldSet are isomorphic to map, filter, and foldr except they're implented for 'Sets'.
> mapSet :: Ord b => (a -> b) -> Set a -> Set b
> mapSet g (SetI xs) = makeSet (map g xs)

> filterSet :: (a -> Bool) -> Set a -> Set a
> filterSet p (SetI xs) = SetI (filter p xs)

> foldSet :: (a -> a -> a) -> a -> Set a -> a
> foldSet f x (SetI xs)	= (foldr f x xs)

>-- makeSet turns a list into a set
> makeSet :: Ord a => [a] -> Set a
> makeSet = SetI . remDups . sort
>		where
>		remDups []		= []
>		remDups [x]		= [x]
>		remDups (x:y:xs)
>			| x < y		= x : remDups (y:xs)
>			| otherwise	= remDups (y:xs)

>-- showSet f gives a printable version of a set, one item per line, using the function f to give a printable version of each element
> showSet :: Show a => Set a -> String
> showSet (SetI xs) = concat (map ((++"\n").show) xs)

>-- card gives the number of elements in a set
> card :: Set a -> Int
> card (SetI xs) = length xs

>-- flatten turns a set into an ordered list of the elements of the set
> flatten :: Set a -> [a]
> flatten (SetI xs) = xs

> cons x (SetI xs) = SetI (x:xs)


>-- setlimit f x gives the 'limit' of the sequence.  Apply f until a fixed point is reached.
>-- setlimit :: Eq a => (Set a -> Set a) -> Set a -> Set a
> setlimit f s
>	| s == next	= s
>	| otherwise	= setlimit f next
>	  	where 
>	  	next = f s
