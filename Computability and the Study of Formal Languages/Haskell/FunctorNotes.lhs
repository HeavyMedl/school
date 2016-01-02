The following notes cover

	LYAH Chapter 11 (pgs 217-227) - Applicative Functors
	Typeclassopedia (pgs 18-24)

Recall LYAH Chapter 7 on Functors
Functors - types whose values can be mapped over

> import Data.Char

> class Functor' f where
>	fmap' :: (a -> b) -> f a -> f b

For type class Functor, f (type variable) is not a concrete type, but a type constructor like 'Maybe'. Maybe = Type constructor and ( Maybe a ) which is a type constructor waiting for a concrete type 'a'. Map is a fmap that only works on lists.

> instance Functor' [] where
>	fmap' = map

This is an example of how the type constructor list ( [] ) is an instance of Functor.  Making something an instance of Functor only requires us to provide a definition for fmap.  And so fmap could be alternately written like:

 instance Functor [] where
	fmap f [] = []
	fmap f (x:xs) = f x : fmap f xs

Notice that in this particular instance of Functor, fmap is definited with point-style syntax. (fmap f xs).  fmap = map represents point-free style.

MAYBE type class as an instance of Functor: Types that act like boxes can be instances of Functors.

> instance Functor' Maybe where
> 	fmap' f Nothing = Nothing
>	fmap' f (Just x) = Just (f x)

An example usage of fmap' on the Maybe type (class).
*Main> fmap' (*2) (Just 10)
Just 20

Notice the syntax for declaring instances of Functors: instance Functor' (type constructor) where .. and then the following definition creates a function for mapping (fmap') over the concrete type. Mentally define fmap's type signature like (a -> b) -> Maybe a -> Maybe b for this particular definition.

TREES as instances of Functors. We'll define a type class Tree to demonstrate.  Notice that "Tree" is a type constructor with one type parameter.  And so a suitable mental type signature of Tree as an instance of Functor would be (a -> b) -> Tree a -> Tree b 

> data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Eq,Ord,Show)

And Tree becomes an instance of Functor..

> instance Functor' Tree where
>	fmap' f Empty = Empty
>	fmap' f (Node x left right) = Node (f x) (fmap' f left) (fmap' f right)

Notice that fmap' f (Node x left right) = .. the value constructor (Node) is isolated and f is applied to the values separated by parens: (f x) (fmap' f left) (fmap' f right)

EITHER type class as an instance of Functor: If a type constructor has more than one type parameter like 'Either a b', isolate one type parameter in the declaration of an instance of Functor..

> instance Functor' (Either a) where
> 	fmap' f (Right x) = Right (f x)
>	fmap' f (Left x) = Left x

*Main> fmap' (*2) (Right 5)
Right 10

Notice that fmap' is only defined for "Right" value constructor where 'Either a b' is defined like..

 data Either a b = Right a | Left b

and the (Either a) corresponds to the fmap' defined on the value constructor "Right".

LYAH Chapter 11 (pgs 217-227) - Up to Applicative Functors

I/O Actions As Functors:  When we fmap a function over an I/O action, we want to get back an I/O action that does the same thing but has our function applied over its result value.

> instance Functor' IO where
> 	fmap' f action = do
>		result <- action
>		return (f result)

*Main> fmap' (++"s") (getLine)	<- fmap' f action
add an s			<- result <- action
"add an ss"			<- return (f result)

Recall that "return" is a function that makes an I/O action that doesn't do anything but only yields something as its result.

Applying fmap in an I/O context

> main = do
>	line <- fmap' reverse getLine
>	putStrLn (" Here's your reversed line: " ++ line)

The name will reflect the result that already has reversed applied to it
*Main> main
kurt medley
 Here's your reversed line: yeldem truk

fmap in I/O is convienient when you'd like to apply multiple functions to the result of an I/O action and bind it to a name:

> fun = do
> 	result <- fmap' (\str -> reverse $ map toUpper str) getLine
>	return result

*Main Data.Char> fun
kurt medley
"YELDEM TRUK"

FUNCTIONS as Functors: (->) r
The type signature r -> a can be read like (->) r a; a sort of prefix notation that isequivalent.  (+) 3 2 = 5.  (->) is a type constructor that takes two parameters in this context, 'r' and 'a'.

> instance Functor' ((->) r) where
>	fmap' f g = (\x -> f (g x))

As a mental strategy convert fmap's type signature: fmap :: (a -> b) -> f a -> f b
with our new context in prefix form: fmap :: (a -> b) -> ((->) r a) -> ((->) r b)
thus we have infix form: fmap :: (a -> b) -> (r -> a) -> (r -> b).  This is equivalent to function composition (.)

*Main> fmap' (+4) (+6) 1	<- Apply +6 to 1.  Then apply +4 to (+6 to 1). 
11
EQUIVALENT TO:
*Main> ((+4).(+6)) 1
11

Partial Application:  All Haskell functions actually take one parameter.  A function a -> b -> c takes just one parameter of type 'a' and returns a function 'b -> c'.  So giving a function too few parameters would be partially applying it.. A function of a -> b -> c would look like a -> (b -> c).

Lifting a function: fmap :: (a -> b) -> f a -> f b
fmap takes an a -> b function and returns a function f a -> f b

fmap (*2) :: (Num a, Functor f) => f a -> f a
fmap (replicate 3) :: (Functor f) => f a -> f [a]
	
Thinking about fmap
* A function that takes a function and a functor value and then maps that function over the functor value.
* As a function that takes a function and lifts that function so it operates on functor values.

fmap (replicate 3) (Just 3) = [[3,3,3]]
fmap (replicate 3) (Right "Blah") = [["Blah","Blah","Blah"]]

FUNCTOR LAWS
Law 1 - fmap id = id : If we map the id function over a functor value, the functor value that we get back should be the same as the original functor value.  If we do an 'fmap id' over a functor value, it should be the same as just applying id to the value.
Some test cases:
*Main> id 4 = 4
*Main> (\x -> x) 4 = 4
*Main> fmap id (Just 4) = Just 4
In the last example we see the id function is applied to the functor value which returns just the functor value.  Contextual explanation: Just 4 is a functor value because it is a value constructor of the Maybe type class, which was made an instance of Functor.  So (Just) is Maybe -> Value Constructor -> instance of Functor -> Functor value.

 	instance Functor' Maybe where
		fmap' f (Just x) = Just (f x)

>--Law 1 test 	fmap' id (Just x) = Just (id x) <- substitute id for f
>--				    Just (id x) = Just x <- Confirmed
>--Law 1 test 	fmap' f Nothing	= Nothing <- mapping id over Nothing returns Nothing

>--		fmap' id = id :-)

Law 2 - Composing two functions and then mapping the resulting function over a functor should be the same as first mapping one function over the functor and then mapping the other one. Formal properties:

fmap (f.g) = fmap f . fmap g  OR alternatively written
fmap (f.g) x = fmap f (fmap g x)

	instance Functor' Maybe where
		fmap' f (Just x) = Just (f x)
		fmap' f Nothing  = Nothing		

>-- Law 2 test	fmap (f.g) = Nothing <- mapping (f.g) over Nothing returns Nothing
>-- Law 2 test 	fmap (f.g) (Just x) = Just ((f.g) x) or Just (f (g x))
		
>--		fmap f (fmap g (Just x)) = fmap f (fmap g (Just (g x))
>--					 = fmap f (Just (g x))
>--					 = Just (f (g x))

Breaking the Law: Type constructor that acts like a functor but doesn't obey the laws.

> data CMaybe a = CNothing | CJust Int a deriving (Show)

Creating an instance of functor..

> instance Functor' CMaybe where
>	fmap' f CNothing = CNothing
>	fmap' f (CJust counter x) = CJust (counter+1) (f x)

Does this obey the functor laws?  Testing the identity property of Law 1.  Mapping the identity function 'id' over a functor value should be equivalent to calling id over that functor value.

*Main> fmap' id (CJust 0 1)
CJust 1 1
*Main> id CJust 0 1
CJust 0 1

fmap id /= id and therefore CMaybe is not a functor.

Typeclassopedia (pgs 18-24) : Pointed*
The Pointed type class represents pointed functors. Given a functor, the Pointed class represents the additional ability to put a value into a "default context". 

 class Functor f => Pointed f where
	pure :: a -> f a	-- aka singleton, return, unit, point

The Maybe instance of Pointed is pure = Just; for the list type constructor ([]), pure x = [x].

The Pointed Class Law:

fmap g . pure = pure . g

> data GTree a = EmptyGtree | Node' a [GTree a] deriving (Show,Eq,Ord)

> instance Functor GTree where
>	fmap f EmptyGtree = EmptyGtree
>	fmap f (Node' x trees) = Node' (f x) (map (fmap f) trees)

> map' :: (a -> b) -> [a] -> [b]
> map' f [] = []
> map' f (x:xs) = f x : map' f xs

> func :: (a -> b) -> ([a] -> [b])
> func f = map f

> --rep :: (a -> b) -> ([a] -> [b])
> rep :: (a -> b) -> ([a] -> [b])
> rep g = (\xs -> (concat.(replicate 3).(map g)) xs)
> {--
> flatten :: [[a]] -> [a]
> flatten []   = []
> flatten [[]] = []
> flatten [x:xs] = x ++ flatten xs
> --}
