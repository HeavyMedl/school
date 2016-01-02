Assignment 3 - Applicative Functors

 For this assignment you'll need to read the Typeclassopedia (TCOP) paper through the section on Applicative functors. Also read the LYAH chapter 11 on Applicative functors that we went over in class - particularly the part on the Maybe functor that you can use to model your solution to the (Either a) questions below. You'll need to read and study the first 5 pages of the McBride and Paterson paper to do the last questions.

1.  Code your own Applicative class using what you know from the Typeclassopedia (TCOP) paper.

> class Functor f => Kurplicative f where
>	kure :: a -> f a
>	(<!>) :: f (a -> b) -> f a -> f b

> (<@@>) :: (Kurplicative f) => (a -> b) -> f a -> f b
> g <@@> x = fmap g x
 
> instance Kurplicative Maybe where
>	kure = Just
>	Nothing <!> _ = Nothing
>	(Just g) <!> x = fmap g x

> instance Kurplicative [] where
>	kure = \x -> [x]
>	gs <!> xs = [ g x | g <- gs, x <- xs ]

2.  Code the (Either a) as an instance of your Applicative class. Write some interesting test examples. 

> instance Functor (Either a) where
>	fmap g (Right x) = Right (g x)
>	fmap g (Left x) = Left x

> instance Kurplicative (Either a) where
>	kure = Right
>	(Right g) <!> x = fmap g x
>	(Left g) <!> x = Left g

*Main> (:) <@@> Right [1,2,3,4,5] <!> Right []
Right [[1,2,3,4,5]]

*Main> (:) <@@> Right 1337  <!> Right [1,2,3,4,5]
Right [1337,1,2,3,4,5]

3.  Prove the one Applicative law given in the TCOP paper for the (Either a) applicative functor. 

TCOP Listing 13: Law relating Applicative to Functor

fmap g x = pure g <*> x

------------------------------------
(a) Claim : fmap g x = pure g <*> x
------------------------------------
Show: fmap g (Left x) = pure g <*> x

i) Left side of equation
fmap g (Left x) = fmap g (Left x)
		= Left x

*Main> fmap (+3) (Left 3)
Left 3

ii) Right side of equation
pure g <*> x = Left g <*> x
	     = Left x

Left (+3) <*> Left 3 :: (Num (a -> a), Num a) => Either (a -> a) b

True: fmap g (Left x) = pure g <*> x
------------------------------------
Show: fmap g (Right x) = pure g <*> x

i) Left side of equation
fmap g (Right x) = fmap g (Right x)
		 = Right (g x)

*Main> fmap (+3) (Right 3)
Right 6

ii) Right side of equation
pure g <*> x = (Right g) <*> x
	     = fmap g (Right x)
	     = Right (g x)

*Main> pure (+3) <*> Right 3
Right 6

True: fmap g (Right x) = pure g <*> x
QED proof of fmap g x = pure g <*> x
---------------------------------------------------------------------
4.  Modeling computations in an environment using the arrow applicative functor ((->) env). You'll need to read and study the first 5 pages of the McBride and Paterson paper.
a) At the top of page 3 of the McBride and Paterson paper they code a standard evaluator for simple arithmetic expressions with constants and variables. Code this program in Haskell and test it. 

> data Exp = Var String | Val Int | Add Exp Exp deriving (Show,Eq,Ord)

> type Env = [(String, Int)]

> eval :: Exp -> Env -> Int
> eval (Val i) env = i
> eval (Var s) env = fetch s env
> eval (Add p q) env = (eval p env) + (eval q env)

> fetch :: String -> Env -> Int
> fetch s (x:xs)
>	| s == fst x	= snd x 
>	| otherwise	= fetch s xs
> fetch s [] = error "No such variable in environment"

>-- Test environments
> env1 :: Env
> env1 = [("a",1),("b",2),("c",3),("d",4),("e",5)]
> env2 :: Env
> env2 = [("a",40),("b",32),("c",561)]

*Main> eval (Add (Var "a") (Var "b")) env1
3
*Main> eval (Add (Var "a") (Var "b")) env2
72

b) Now using your ((->) env) instance of the applicative class, recode your expression evaluator of the previous problem. You can find the code at the bottom of page 4 of the paper, but you'll have to translate their notation into Haskell. Read the McBride and Paterson paper up through the top of page 5. 

> class Functor f => Applicative f where
>	pure :: a -> f a
>	(<*>) :: f (a -> b) -> f a -> f b

> instance Functor ((->) env) where
>	fmap f g = (\x -> f (g x))

> instance Applicative ((->) env) where
>	pure x = (\_ -> x)
>	f <*> g = \env -> f env (g env)

> evalA :: Exp -> Env -> Int 
> evalA (Val i) = pure i
> evalA (Var s) = fetch s
> evalA (Add p q) = pure (+) <*> eval p <*> eval q

*Main> evalA (Add (Var "a") (Var "b")) env1
3
*Main> evalA (Add (Var "a") (Var "b")) env2
72

5.  Combining the ((->) env) and Maybe functors. Modeling a computation in an environment that can fail. This is the most instructive challenge that highlights the power of Applicative Functors.
a) The evaluators you have written above use a fetch function that is assumed to always work. But, of course, a referenced variable may not always exist in the environment. You probably wrote fetch so it bailed out of the evaluator using the Haskell error function. Now go back and re-code your two evaluators so they use the prelude function lookup that returns a (Maybe a) type. You'll probably still need to bail out in the code case for (Var x) if lookup returns Nothing.

> (<$>) :: Functor f => (a -> b) -> f a -> f b
> f <$> g = fmap f g

> instance Applicative Maybe where
>	pure = Just
>	Nothing <*> _ = Nothing
>	(Just g) <*> x = fmap g x

>-- evaluator using a lift function to propogate a failure state
> liftA2 :: (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
> liftA2 op Nothing _ 		= Nothing
> liftA2 op _ Nothing 		= Nothing
> liftA2 op (Just x) (Just y)	= Just (op x y)

> eval5a :: Exp -> Env -> Maybe Int
> eval5a (Val i) env	= Just i
> eval5a (Var s) env   	= lookup s env
> eval5a (Add p q) env 	= liftA2 (+) (eval5a p env) (eval5a q env)

b) Rewrite your standard evaluator (the one that doesn't use the applicative functor) so that it uses the Maybe type to propogate failure using the Nothing value. Your computation should now not bail using the error function but, rather, produce a final answer of the Maybe type. The code should look messy because you keep having to match two return cases after every function call. This illustrates a serious plumbing problem. 

>-- evaluator using case statements to illustrate verbose code
> eval5b :: Exp -> Env -> Maybe Int
> eval5b (Val i) env = Just i
> eval5b (Var s) env = lookup s env
> eval5b (Add p q) env = 
>	case (eval5b p env) of Nothing -> Nothing
>			       Just x  -> case (eval5b q env) of
>						Nothing -> Nothing
>						Just y -> Just (x + y)

c) Now see if you fix the serious plumbing problem by using applicative functors. Combine your code above using the applicative functor ((->) env) for an environment and using the Maybe functor to propogate failure using the Nothing value. See if you can achieve significant code cleanup by hiding the plumbing in the applicative functors. You may find the following reference helpful, particularly sections 2-5 (section 1 is a bit ahead of us since we haven't done graphics programming yet).

> evalM :: Exp -> Env -> Maybe Int
> evalM (Val i) env 	= pure i
> evalM (Var s) env	= lookup s env
> evalM (Add p q) env	= (+) <$> (evalM p env) <*> (evalM q env)

*Main> evalM (Add (Var "a") (Var "b")) [("c",3),("a",2)]
Nothing

