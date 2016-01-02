-- Assignment 3 -- Kurt Medley

-- This week I completed part 1 and part 2 of Assignment 3; defining my own higher order functions and their fold equivalents.  I read Ch 5 out of LYAH on higher order functions.  This week I will read chapters 6 and 7 from LYAH and CH 14-15 from CRFP.

-- Part 1
-- Without looking at the Prelude write your own versions of the functions takeWhile, dropWhile, any, all 

takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' f [] = []
takeWhile' f (x:xs)
	|f x		= x : takeWhile' f xs
	|otherwise 	= []

dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' f [] = []
dropWhile' f (x:xs)
	| f x		= xs
	| otherwise	= x : dropWhile' f xs

any' :: (a -> Bool) -> [a] -> Bool
any' f [] = False
any' f (x:xs)
	|f x		= True
	|otherwise	= any' f xs

all' :: (a -> Bool) -> [a] -> Bool
all' f [] = True
all' f (x:xs)
	|f x		= all' f xs
	|otherwise 	= False

-- Without looking at the Prelude, write the simple looping function until p f a that keeps applying the function f starting at value a until the condition p holds for the function result. Write the similar function while p f a.

until' :: (a -> Bool) -> (a -> a) -> a -> a
until' p f x
	|p x 		= x
	|otherwise	= until p f (f x)

while :: (a -> Bool) -> (a -> a) -> a -> a
while p f x
	|p x == False 	= x 
	|otherwise	= while p f (f x)

-- Without looking at the Prelude, write the functions curry and uncurry. The curry function converts a function on pairs into a curried function. The uncurry function does the reverse. 

curry' :: ((a,b) -> c) -> a -> b -> c
curry' f x y	= f (x,y)

uncurry' :: (a->b->c) -> ((a,b) -> c)
uncurry' f p = f (fst p) (snd p)

--  Define a function composeList that composes a list of functions into a single function. 

composeList :: [(a -> a)] -> (a -> a)
composeList [] = id
composeList (f:fs) = f.composeList fs

--  Rewrite the pipeline of your groupByN function of Assignment 2 above as a simple composition of functions rather than a sequence of applications.


groupByN :: Int -> [t] -> [[t]]
groupByN n [] = []
groupByN n xs = ys : groupByN n zs
        where (ys,zs) = splitAt n xs 

-- Without looking at the library definition, write the function groupBy::(a->a->Bool) -> [a] -> [[a]] that aggregates neighboring elements in a list according the given equality predicate. 

groupBy :: (a -> a -> Bool) -> [a] -> [[a]]
groupBy _ [] 		= []
groupBy eq (x:xs)	= (x:ys) : groupBy eq zs
			   where (ys,zs) = span (eq x) xs


--  Part 2 - Writing functions with fold

ftakeWhile :: (a -> Bool) -> [a] -> [a]
ftakeWhile p = foldr (\x xs -> if p x then x:xs else []) []

fdropWhile :: (a -> Bool) -> [a] -> [a]
fdropWhile p = foldr (\x xs -> if p x then xs else x:xs) []

fAny :: (a -> Bool) -> [a] -> Bool
fAny p = foldr (\x xs -> if p x then True else xs) False

fAll :: (a -> Bool) -> [a] -> Bool
fAll p = foldr (\x xs -> if not(p x) then False else xs) True
