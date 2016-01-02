Assignment 2 - Functors and Pointed Functors 

Do the following assignment in a Haskell lhs file so you can intermix code and proofs. Test all your code.

Read TCOP pp18-24 through the sections on Functors and Pointed Functors. Also read LYAH Ch 11 on Functors (up to Applicative Functors) including the back-link to the LYAH Ch 8 section on the Functor type class.

1. Partial Application. One simple way to combine functions to produce other functions is by partial application (we can also think of sections as a special form of partial application). Recall that partial application goes hand-in-hand with functions in curried form. Explain how to define list to list functions (ie, ones with type [a] -> [b]) with a simple partial application given an (a -> b) function. Give two examples. Hint: think about List as a functor type class. Your example(s) will be "lifts" as described in TCOP p23.

> func :: (a -> b) -> ([a] -> [b])
> func f = map f

*Main> func (+2) [1,2,3]
[3,4,5]

> rep :: (a -> b) -> ([a] -> [b])
> rep g = (\xs -> (concat.(replicate 3).(map g)) xs)

*Main> rep (+3) [1,2,3]
[4,5,6,4,5,6,4,5,6]

"func" describes a function that works on lists by partial application.  It has the same structural behavior as map given a different name.  f is the function that map uses to map over a list.  The difference here is that it is partially applied; it waits for a list to be supplied which is apparent given func :: (a -> b) -> ([a] -> [b]).  Similiarly, rep's type signature is (a -> b) -> ([a] -> [b]).  It waits for a provided list and then executes the functions composed within the body.

foo :: Functor f => (a -> b) -> f a -> f b

> foo f = fmap f

bar :: Functor f => (b1 -> b) -> (a -> b1) -> f a -> f b

> bar f g = fmap (f.g) 

Characteristically similar examples foo and bar are partially applied functions that work on functor values, and so they can be considered lifts onto some computational context.

2. Define an instance of Functor on the following Tree type. Prove that the laws for functor hold for your fmap. Note: you can do this problem for binary trees if you want somewhat easier proofs. You'll be doing a structural induction proof on the tree.

      data GTree a = EmptyGtree | Node a [Gtree a]
      
------------------------------------------------------------------------------------
Notes on Functor Laws from FunctorNotes.lhs
------------------------------------------------------------------------------------
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

------------------------------------------------------------------------------------

> data GTree a = EmptyGtree | Node a [GTree a] deriving (Show,Eq,Read)

> instance Functor GTree where
>	fmap f EmptyGtree = EmptyGtree
>	fmap f (Node x trees) = Node (f x) (map (fmap f) trees)

I'm curbing the inductive proof of this ADT and attempting a proof on a binary tree of the form..
------------------------------------------------------------------------------------

> data Tree a = NilT | Node' a (Tree a) (Tree a) deriving (Show,Eq,Read)

> instance Functor Tree where
>	fmap f NilT = NilT
>	fmap f (Node' x lt rt) = Node' (f x) (fmap f lt) (fmap f rt)

>-- Prove the Functor Laws for the Tree functor (tf.1 and tf.2)

(tf.1)	fmap id	= id
(tf.2)	fmap (g.h) = fmap g . fmap h	-- OR fmap (f.g) x = fmap f (fmap g x)

------------------------------------
(a) Claim : (tf.1) fmap id = id
------------------------------------
Base Case: Tree of the form NilT
Show: fmap id NilT = id NilT
------------------------------------
i) Left side of equation
fmap id NilT = NilT

>-- *Main> fmap id NilT
>-- NilT

ii) Right side of equation
id NilT = NilT

>-- *Main> id NilT
>-- NilT

True: fmap id NilT = id NilT
------------------------------------
Inductive Step:  Tree of the form (Node' x lt rt)
Show: fmap id (Node x lt rt) = id (Node x lt rt)
------------------------------------
i) Left side of equation
fmap id (Node' x lt rt) = Node' (id x) (fmap id lt) (fmap id rt)
		        = Node' (id x) lt rt -- IH
		        = Node' x lt rt      -- definition of id
Ex. 1 Case of no sub-trees

>-- *Main> fmap id (Node' 1 NilT NilT)
>-- Node' 1 NilT NilT

Ex. 2 Case of a left sub-tree and a nil right sub-tree

>-- *Main> fmap id (Node' 1 (Node' 2 NilT NilT) NilT)
>-- Node' 1 (Node' 2 NilT NilT) NilT

Ex. 3 Case of two subtrees

>-- *Main> fmap id (Node' 1 (Node' 2 NilT NilT) (Node' 3 NilT NilT))
>-- Node' 1 (Node' 2 NilT NilT) (Node' 3 NilT NilT)

ii) Right side of equation
id (Node x lt rt) = Node x lt rt

>-- *Main> id (Node' 1 NilT NilT)
>-- Node' 1 NilT NilT

True: fmap id (Node x lt rt) = id (Node x lt rt)
QED proof of (tf.1)
------------------------------------
(b) Claim : (tf.2) fmap (g.h) = fmap g . fmap h
------------------------------------
Base Case: Tree of the form NilT
Show: fmap (f.g) NilT = fmap f (fmap g NilT)
------------------------------------
i) Left side of equation
fmap (f.g) NilT = NilT

>-- *Main> fmap ((+2).(+3)) NilT
>-- NilT

ii) Right side of equation
fmap f (fmap g NilT) = NilT

>-- *Main> fmap (+2) (fmap (+3) NilT)
>-- NilT

And just to show the equivalence to the formal law
fmap f . fmap g = NilT

>-- *Main> ((fmap (+2)).(fmap (+3))) NilT
>-- NilT

True: fmap (f.g) NilT = fmap f (fmap g NilT)
------------------------------------
Inductive Step: Tree of the form (Node' x lt rt)
Show: fmap (f.g) (Node' x lt rt) = fmap f (fmap g (Node' x lt rt))
------------------------------------
i) Left side of equation
fmap (f.g) (Node' x lt rt) = Node ((f.g) x) ((f.g) lt) ((f.g) rt)

According to the law, (f.g) will be applied to the leading Node followed by all subtrees. Here is the outcome:

>-- *Main> fmap ((+2).(+4)) (Node' 1 (Node' 1 NilT NilT) (Node' 1 NilT NilT))
>-- Node' 7 (Node' 7 NilT NilT) (Node' 7 NilT NilT)

Another application including a child of a subtree

>-- *Main> fmap ((+2).(+4)) (Node' 1 (Node' 1 (Node' 1 NilT NilT) NilT) (Node' 1 NilT NilT))
>-- Node' 7 (Node' 7 (Node' 7 NilT NilT) NilT) (Node' 7 NilT NilT)

ii) Right side of equation
fmap f (fmap g (Node' x lt rt)) = fmap f (fmap g (Node' (g x) (g lt) (g rt)))
				= fmap f (Node' (g x) (g lt) (g rt))
				= Node (f (g x)) (f (g lt) (f (g rt))
				= Node ((f.g) x) ((f.g) lt) ((f.g) rt)

>-- *Main> fmap (+2) (fmap (+4) (Node' 1 (Node' 1 NilT NilT) (Node' 1 NilT NilT)))
>-- Node' 7 (Node' 7 NilT NilT) (Node' 7 NilT NilT)

True: fmap (f.g) (Node' x lt rt) = fmap f (fmap g (Node' x lt rt))
QED proof of (tf.2)
-----------------------------------------------------------------------------------

3.  Prove that the instance of Functor defined in TCOP Listing 8 p22 does not obey the functor laws. Remember, to prove a law does not hold you only need to provide one specific counterexample.

Listing 8:

> class Functor' f where
>	fmap' :: (a -> b) -> f a -> f b


> instance Functor' [] where
>	fmap' _ [] = []
>	fmap' g (x:xs) = g x : g x : fmap' g xs 

(FL 1) fmap id = id
(FL 2) fmap (g.h) = fmap g . fmap h    -- OR fmap (f.g) x = fmap f (fmap g x)
------------------------------------
(a) Claim : (FL 1) fmap id = id
------------------------------------
Base Case: TC ([]) of the form []
Show: fmap' id [] = id []
------------------------------------
i) Left side of equation
fmap' id [] = []

>-- *Main> fmap' id []
>-- []

ii) Right side of equation
id [] = []

>-- *Main> id [] 
>-- []

True: fmap' id [] = id []
------------------------------------
Inductive Step: TC ([]) of the form (x:xs)
Show: fmap' id (x:xs) = id (x:xs)
------------------------------------
i) Left side of equation
fmap' id (x:xs) = id x : id x : fmap id xs

>-- *Main> fmap' id [1,2,3]
>-- [1,1,2,2,3,3]

ii) Right side of equation
id (x:xs) = id x : id xs

>-- *Main> id [1,2,3]
>-- [1,2,3]

fmap' id (x:xs) /= id (x:xs)
QED type class ([]) is not a Functor' in accordance with the definition of fmap'.
-----------------------------------------------------------------------------------

4.  Define an instance of Functor for the type (Either e). Prove that the laws for functor hold for your fmap. This will be a simple equational proof using the usual evaluation rules of Haskell. (TCOP p22 top). 

> instance Functor (Either e) where
>	fmap f (Right x) = Right (f x)
>	fmap f (Left x) = Left x

Too qualify as a functor, (Either e) must obey the functor laws according to the definition of fmap.

(FL 1) fmap id = id
(FL 2) fmap (g.h) = fmap g . fmap h    -- OR fmap (f.g) x = fmap f (fmap g x)

------------------------------------
(a) Claim : (FL 1) fmap id = id
------------------------------------
Base Case: Value constructor (Left) of the form (Left x)
Show: fmap id (Left x) = id (Left x)
------------------------------------
i) Left side of equation
fmap id (Left x) = Left x
Note: fmap f is not defined for VC because TC Either is of kind * -> * -> * and was isolated in the instantiation of Functor by (Either e) which corresponds with VC Right.

>-- *Main> fmap id (Left [])
>-- Left []

ii) Right side of equation
id (Left x) = Left x

>-- *Main> id (Left [])
>-- Left []

True: fmap id (Left x) = Left x
------------------------------------
Inductive Step: Value constructor (Right) of the form (Right x)
Show: fmap id (Right x) = id (Right x)
------------------------------------
i) Left side of equation
fmap id (Right x) = fmap (Right (id x)
		  = Right (id x)
		  = Right x

>-- *Main> fmap id (Right [])
>-- Right []

ii) Right side of equation
id (Right x) = Right x

>-- *Main> id (Right [])
>-- Right []

Note:  This is slightly redundant but necessary, fmap is defined on the VC Right by fmap f = Right (f x) which corresponds with instance declaration (Either e) of functor
True: fmap id (Right x) = id (Right x)
QED proof of (FL 1)
------------------------------------
(b) Claim : (FL 2) fmap (g.h) = fmap g . fmap h  -- OR fmap (f.g) x = fmap f (fmap g x)
------------------------------------
Base Case: Value constructor (Left) of the form (Left x)
Show: fmap (g.h) (Left x) = fmap g . fmap h (Left x)
------------------------------------
i) Left side of equation
fmap (g.h) (Left x) = Left x

>-- *Main> fmap ((+2).(+3)) (Left 1)
>-- Left 1

ii) Right side of equation
fmap g . fmap h (Left x) = Left x

>-- *Main> ((fmap (+1)).(fmap (+2))) (Left 1)
>-- Left 1

True: fmap (g.h) = fmap g . fmap h
------------------------------------
Inductive Step: Value constructor (Right) of the form Right x
Show: fmap (g.h) (Right x) = fmap g . fmap h (Right x)
------------------------------------
i) Left side of equation
fmap (g.h) (Right x) = fmap (Right (g.h) x)
		     = fmap (Right g (h x))
		     = Right (g (h x))

>-- *Main> fmap ((+1).(*2)) (Right 2)
>-- Right 5

ii) Right side of equation
fmap g . fmap h (Right x) = fmap g . fmap (Right (h x))
			  = fmap g (Right (h x))
			  = fmap (Right g (h x))
			  = Right (g (h x))

>-- *Main> ((fmap (+1)).(fmap (*2))) (Right 2)
>-- Right 5

True: fmap (g.h) (Right x) = fmap g . fmap h (Right x)
QED of (FL 2)
-----------------------------------------------------------------------------------
5.  Make your (Either e) type from the previous problem an instance of the Pointed class. Define Pointed with Functor as a context and then provide the definition for pure. 

From LYAH Ch 11 on Applicative Functors 
pure :: a -> f a. f plays the role of our Pointed functor instance here.  pure should take a value of any type and return an Pointed value with that value inside it.  We take a value that has that value as the result inside it. A better way of thinking about pure would be to say that it takes a value and puts it in some sort of default (or pure) context - a minimal context that still yiels that value.

> class Functor f => Pointed f where
>	pure :: a -> f a

Test instantiations..

> instance Pointed Maybe where
> 	pure = Just

> instance Pointed [] where
>	pure = (\x -> [x])

> instance Pointed (Either e) where
>	pure = Right

>-- For problems 6 and 7
>-- instance Functor ((->) e) where
>-- 	fmap f g = (\x -> f (g x))

>-- instance Pointed ((->) e) where
>--	pure = const

-----------------------------------------------------------------------------------
6.  Prove that the Pointed law of Listing 10 in the Typeclassopedia paper holds for the definitions of fmap and pure you gave for your (Either e) type in the previous two problems. 

instance Functor (Either e) where
	fmap f (Right x) = Right (f x)
	fmap f (Left x) = Left x

instance Pointed (Either e) where
	pure = Right


Listing 10: The Pointed Law (PL 1)
fmap g . pure = pure . g
------------------------------------
Show: fmap g (pure x) = g (pure x)
------------------------------------
Left side of equation:
fmap g (pure x) = fmap (pure (g (x)))
		= Right (g (x))
		= Right (g x)

Right side of equation:
g (pure x) = pure (g x)
	   = Right (g x)

True: fmap g . pure = pure . g
QED proof of (PL 1)
------------------------------------

> v1 = pure 1 :: Either a Int 

> v2 = fmap (+2) (Left [])

> v3 = pure [] :: Either a [b]

-----------------------------------------------------------------------------------
7. Define a class called Pointed following the Typeclassopedia paper and then define an instance of Pointed for the type ((->) t). You can define Pointed with Functor as a context, or not. Either way you'll need to define both fmap and pure. 

class Functor f => Pointed f where
	pure :: a -> f a

> instance Functor ((->) r) where
>	fmap f g = (\x -> f (g x))  -- f.g or (.)

> instance Pointed ((->) r) where
>	pure x y = x

To logically define pure for ((->) r), deconstruct the types.  We need to define pure in terms of the signature pure :: a -> f a.

1. a -> f a
2. a -> ((->) r) a	<- substitute ((->) r) for f (functor)
3. a -> ((r ->) a)	<- can be thought of as
4. a -> (r -> a)	<- another reconfiguration 
5. a -> r -> a		<- construct a function based on this signature (or previous)

pure x y = x 		<- equivalent to const :: a -> b -> a
OR
pure x = (\y -> x)	<- type signature equivalent to 4. a -> (r -> a) 
-----------------------------------------------------------------------------------
8. Prove that the Functor laws of Listing 7 hold for the ((->) t) type. 

>-- instance Functor ((->) r) where
>--	 fmap f g = (\x -> f (g x))

Functor laws
(FL 1) fmap id = id
(FL 2) fmap (g.h) = fmap g . fmap h    -- OR fmap (f.g) x = fmap f (fmap g x)
------------------------------------
(a) Claim : fmap id = id
------------------------------------
TC ((->) r) of the form ((->) r a) which is equivalent to (r -> a).  This will be represented by g. g :: (r -> a)
Show: fmap id g = id g	-- OR -- fmap (id.g) x = (id.g) x

i) Left side of equation
fmap (id.g) x = fmap id (g x)
	      = id (g x)

>-- *Main> fmap (id.id) (Just 1)
>-- Just 1

ii) Right side of equation
id g = id (g x)

True: fmap id g = id g
QED proof of (FL 1)
-----------------------------------
(b) Claim : fmap (g.h) = fmap g . fmap h   -- OR fmap (f.g) x = fmap f (fmap g x)
------------------------------------
Show: fmap (g.h) i = fmap g (fmap h i)

i) Left side of equation
fmap (g.h) i = fmap g (h i)
	     = g (h i) 

ii) Right side of equation
fmap g (fmap h i) = fmap g (h i)
		  = g (h i)

True: fmap (g.h) = fmap g . fmap h
QED proof of (FL 2)


proofb g h i = fmap (g.h.i)
----------------------------------------------------------------------------------
9.  Prove that the Pointed law of Listing 10 in the Typeclassopedia paper holds for your definitions of fmap and pure. 

Pointed Law: fmap g . pure = pure . g
------------------------------------
Show: fmap g (pure x) = g (pure x)
------------------------------------
i) Left side of equation
fmap g (pure x) = fmap g (((->) r) x)
		= fmap g (((->) r x))
		= fmap g ((r -> x))
		= g (r -> x)

ii) Right side of equation
g (pure x) = g (((->) r) x)
	   = g ((r -> x))
	   = g (r -> x)

True: fmap g (pure x) = g (pure x)
QED proof of (PL 1)
----------------------------------------------------------------------------------


