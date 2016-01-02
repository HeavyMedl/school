Assignment 4 - Kurt Medley

------------------------------------------------------------------------------
-- The Applicative Class
------------------------------------------------------------------------------

> class Functor f => Applicative f where
>	pure 	:: a -> f a
> 	(<*>) 	:: f (a -> b) -> f a -> f b

>-- Utility functions for Applicative
> liftA2 :: Applicative f => (a -> b -> c) -> f a -> f b -> f c
> liftA2 g x y 	= pure g <*> x <*> y

Instances of the Applicative Class

The ((->) r) Reader instance of the Applicative Class for evaluation in an Environment

> instance Functor ((->) env) where
>	fmap f g = (\x -> f (g x))

> instance Applicative ((->) r) where
>	pure g = (\_ -> g)
>	f <*> g = (\x -> f x (g x))

The Maybe instance of the Applicative Class for failure propogation
This Functor instance for Maybe is already in the Prelude

>-- instance Functor Maybe where
>-- 	fmap g Nothing 	= Nothing
>--	fmap g (Just x)	= Just (g x)

> instance Applicative Maybe where
>	pure 	       = Just
>	Nothing <*> _  = Nothing
>	(Just g) <*> x = fmap g x

Exercise
instance Applicative (Either a)

> instance Functor (Either a) where
> 	fmap g (Right x) = Right (g x)
>	fmap g (Left x)  = Left x

> instance Applicative (Either a) where
>	pure = Right
> 	(Left g) <*> _ = Left g
>	(Right g) <*> x = fmap g x

3. Exercise on Asn4
Utility functions for the Applicative class

> (<$>) :: Applicative f => (a -> b) -> f a -> f b
> g <$> af = fmap g af

> sequenceA :: Applicative f => [f a] -> f [a]
> sequenceA [] = pure []
> sequenceA (x:xs) = (:) <$> x <*> sequenceA xs

> mapA :: Applicative f => (a -> f b) -> [a] -> f [b]
> mapA g [] = pure [] 
> mapA g (x:xs) = (:) <$> g x <*>  mapA g xs

------------------------------------------------------------------------------
-- MyMonad class
------------------------------------------------------------------------------

> class Applicative f => Kmonad f where
> 	bind :: f a -> (a -> f b) -> f b

> instance Kmonad Maybe where
> 	bind Nothing _ 	= Nothing
>	bind (Just x) g = g x

*Main> bind Nothing (\x -> Just (x+2))
Nothing
*Main> bind (Just 2) (\x -> Just (x*2))
Just 4

1. Exercise on Asn4

> instance Kmonad (Either a) where
> 	bind (Left x) _ 	= Left x 
>	bind (Right x) g	= g x

> instance Monad (Either a) where
> 	return 	= Right
>	Right x >>= f = f x
>	Left e >>= _ = Left e

2. Exercise on Asn4
Utility functions for MyMonad

-- myap :: Monad m -> m (a -> b) -> m a -> m b, the applicative operator of the applicative class. 

> myap :: Monad m => m (a -> b) -> m a -> m b
> myap mf mx = do
>	f <- mf
>	m <- mx
>	return (f m)

-- mysequence :: Monad m -> [m a] -> m [a], the sequence operator. This is a generalization of the "accumulate" that you already wrote wrote in a previous assignment (see Thompson problem 18.7 p461-62). Give a test example of using your sequence function. 

> mysequence :: Monad m => [m a] -> m [a]
> mysequence [] = return []
> mysequence (x:xs) = do
>	v  <- x
>	vs <- mysequence xs
>	return (v:vs)

*Main> mysequence [getLine, getLine]
kurt
medley
["kurt","medley"]

--  mymapM :: Monad m -> (a -> m b) -> [a] -> m [b], the monadic version of list map. Give a test example of using your mapM function.

> mymapM :: Monad m => (a -> m b) -> [a] -> m [b]
> mymapM f [] = return []
> mymapM f (x:xs) = do
>	r  <- f x
>	rs <- mymapM f xs
>	return (r:rs)

*Main> mymapM (\x -> Just (x*2)) [1,2,3]
Just [2,4,6]

--  (fish) :: Monad m => (a -> m b) -> (b -> m c) -> (a -> m c), the (>=>) operator described in TCOP. 

> fish :: Monad m => (b -> m c) -> (a -> m b) -> (a -> m c)
> fish f g = (\x -> g x >>= f)

--  (join) :: Monad m => (m (m a) -> m a), the join operator.f

> join' :: Monad m => m (m a) -> m a
> join' mc = do
> 	x <- mc
>	y <- x
>	return y

------------------------------------------------------------------------------
-- JoinMonad class
------------------------------------------------------------------------------

-- 4. Exercise on Asn4

> class Applicative m => JoinMonad m where
>	join :: m (m a) -> m a


-- 5. Exercise on Asn4

join n ≡ n >>= id
m >>= g ≡ join ((fmap g) m)
  
> instance JoinMonad Maybe where
>	join (Just x) = x
>	join _        = Nothing

-- 6a. Exercise on Asn4

> instance JoinMonad (Either a) where
> 	join (Right x) = x
> 	join (Left x)  = Left x

-- 6b. Exercise on Asn4
-- JoinMonad Laws satisfied for (Either a)

i) 	claim : join n = n >>= id
	
	Case 1	: Left x
	Show	: join (Left x) = Left x >>= id
	
	LHS	: join (Left x)  = Left x
	RHS	: Left x >>= id  = Left x
	Case 1  : True

	Case 2	: Right x
	Show	: join (Right x) = Right x >>= id

	LHS	: join (Right x) = x
		*Main> join (Right (Right 4))
		Right 4
	RHS	: Right x >>= id = x
		*Main> (Right 4) >>= (\x -> id (Right x))
		Right 4
	Case 2	: True 
		: QED proof of JM Law i

ii)	claim	: m >>= g = join ((fmap g) m)

	Case 1	: Left x
	Show	: Left x >>= g = join ((fmap g) Left x)

	LHS	: Left x >>= g 		 = Left x
	RHS	: join ((fmap g) Left x) = Left x
		*Main> join (fmap (\x -> Left (x+2)) (Left 1))
		Left 1
	Case 1	: True

	Case 2 	: Right x
	Show	: Right x >>= g = join ((fmap g) Right x)
	
	LHS	: Right x >>= g			= Right (g x)
	RHS	: join ((fmap g) Right x)	= join (fmap g (Right x))
						= join (Right (g x))
						= Right (g x)
		*Main> join (fmap (\x -> Right (x+1)) (Right 1))
		Right 2
	Case 2	: True
		: QED proof of JM Law ii

-- 7. Exercise on Asn4
-- Utility Functions for JoinMonad

bindWithJoin :: JoinMonad m => m a -> (a -> m b) -> m b
bindWithJoin m g = join (fmap g m)

> foo = Just 3  >>= (\x ->
>       Just 3  >>= (\y ->
>       Just (x + y)))

> bar = do
>	x <- Just 3
>	y <- Just 3
>	Just (x+y)

> app' :: Monad m => m (a -> b) -> m a -> m b
> app' mg mx = do
>	g <- mg
>	x <- mx
>	return (g x)

> app'' :: Monad m => m (a -> b) -> m a -> m b
> app'' mg mx = mg >>= (\g -> 
>		mx >>= (\x -> 
>		return (g x)))

--  ap :: JoinMonad m -> m (a -> b) -> m a -> m b, the applicative operator of the applicative class. 

> ap :: JoinMonad m => m (a -> b) -> m a -> m b
> ap mg mx = mg `jbind` (\g ->
>	     mx `jbind` (\x ->
>	     pure (g x)))

--  sequence :: JoinMonad m -> [m a] -> m [a], the sequence operator.

> sequenceJ :: JoinMonad m => [m a] -> m [a]
> sequenceJ [] = pure []
> sequenceJ (x:xs) = x `jbind` (\v ->
>		     (sequenceJ xs) `jbind` (\vs ->
>		     pure (v:vs)))

-- mapM :: JoinMonad m -> (a -> m b) -> [a] -> m [b], the monadic version of list map.

> mapJ :: JoinMonad m => (a -> m b) -> [a] -> m [b]
> mapJ g [] = pure []
> mapJ g (x:xs) = (g x) `jbind` (\v ->
>		  (mapJ g xs) `jbind` (\vs ->
>		  pure (v:vs)))

> jbind :: JoinMonad m => m a -> (a -> m b) -> m b
> jbind m g = join (fmap g m)

-- (
fish) :: JoinMonad m => (a -> m b) -> (b -> m c) -> (a -> m c), the (>=>) operator described in TCOP.

> fishJ :: JoinMonad m => (b -> m c) -> (a -> m b) -> (a -> m c)
> fishJ f g = (\x -> g x `jbind` f)


------------------------------------------------------------------------------
-- FishMonad class (left to right fish (>=>) )
------------------------------------------------------------------------------

-- 8. Exercise on Asn4

> class Applicative m => FishMonad m where 
>	fish' :: (a -> m b) -> (b -> m c) -> (a -> m c)

> instance FishMonad Maybe where
> 	fish' g h = \x -> case (g x) of
>                     Nothing  -> Nothing
>                     (Just y) -> h y

-- 9a. Exercise on Asn4 (actually this one was not on Asn4, but you'll need it)
-- FishMonad Laws Listed

Left identity: 	return a >>= k = k a
Right identity:	m >>= return   = m
Associativity:	m >>= (\x -> k x >>= h) = (m >>= k) >>= h


Left identity:	return >=> g ≡ g
The left identity law states that for every monadic function f, f <=< return is the same as writing just f 

Right identity:	f >=> return ≡ f
right identity law says that return <=< f is also no different from f

Associativity:	(f >=> g) >=> h ≡ f >=> (g >=> h)
when we look at the law as a law of compositions, it states that f <=< (g <=< h) should be the same as (f <=< g) <=< h
  
-- 9b. Exercise on Asn4

> instance FishMonad (Either a) where
>	fish' g h = \x -> case (g x) of
>		    (Left n)  -> Left n
>		    (Right n) -> h n 

	instance Monad (Either a) where 
		return = Right
		Left e >>= _ = Left e
		Right x >>= g = g x

> (>=>) :: Monad m => (a -> m b) -> (b -> m c) -> (a -> m c)
> f >=> g = (\x -> f x >>= g)

-- 9c. Exercise on Asn4
-- FishMonad Laws satisfied for (Either a)

i	claim 	: Left Identity : return >=> g = g (return x >>= g = g x)

	Case 1	: In the context of Left n
	Show	: return >=> g = g 
		  Left n >=> (\g -> Right (g+2)) 
		  Left n >=> (\g -> Right (g+2)) = Left n
		  
		  Because VC Left is not defined for the instance of Monad, its evaluation is trivial.
		  Any monadic function composition beginning with (Left n) ends with (Left n)
		  *Main> ((\x -> Left (x+1)) >=> (\y -> Right (y+2))) 1
		  Left 2

	Case 2	: In the context of Right n
	Show	: return >=> g = g
		  Right n >=> (\g -> Right (g+2)) 
		  Right n >=> (\g -> Right (g+2)) x
		  = (\g -> Right (g+2)) <- This is our function waiting for input

		  *Main> ((\x -> return x) >=> (\y -> Right (y+2))) 1
		  Right 3

		  which is equal to

		  *Main> (\y -> Right (y+2)) 1
		  Right 3

	QED proof of Left identity

ii	claim	: Right Identity : g >=> return = g

	Case 1 	: In the context of Left n
	Show	: g >=> return = g	
		 Again, this case is trivial because there isn't a definition of Monad for this VC
		 It will always return (Left n)
		 *Main> ((\x -> Left (x+2)) >=> (\y -> return y)) 1
		 Left 3

	Case 2	: In the context of Right n
	Show	: g >=> return = g
		  (\x -> Right (x+2)) >=> Right n = (\x -> Right (x+2))
			
		  *Main> ((\x -> Right (x+2)) >=> (\y -> return y)) 1
		  Right 3
		  
		  which is equal to

		  *Main> (\x -> Right (x+2)) 1
		  Right 3

	QED proof of Right identity
		 

iii	claim	: Associativity (g >=> h) >=> k	= g >=> (h >=> k)

	Case 1	: In the context of Left n
	Show	: Associativity law in the context of Left n
		  Again, the application of Left n is trivial here as Left is not instantiated

	Case 2 	: In the context of Right n
	Show	: Associativity law in the context of Right n
	LHS	: (g >=> h) >=> k
		  

		  First define functions to compose

> g = (\x -> Right (x+1))
> h = (\y -> Right (y*2))
> k = (\z -> Right (z+2))

		  second let part1 = (g >=> h)

> part1 = ( g >=> h )

		  Where part1 represents monadic function composition.
		  Given an argument, part1 behaves like (h.g) x = g (h x)

		  *Main> part1 1
		  Right 4

> part2 = (\x -> (x >=> k))
		
		 For less detail..

> assoc1 = (g >=> h) >=> k

		 part2 represents (..) >=> k where k = (\z -> (Right (z+2)))
		 I'll now pipe these two functions to represent an answer.

		 *Main> part1 `part2` 1
		 Right 6

	RHS	: g >=> (h >=> k)
		
		First let htok = (h >=> k)
		
> htok = (h >=> k)

		*Main> htok 1
		Right 4
		
> gto = g >=> htok

		*Main> gto 1
		Right 6

		And so we see that the Associativity law holds for (Either a) instatiation of Monad
		QED proof of Associativity law	
			
-- 10. Utility Functions for FishMonad

>-- bindWithfish :: JoinMonad m => m a -> (a -> m b) -> m b
>-- bindWithfish m g = (fish (\x -> m) g z)  -- where do I get z of type a?

-- joinWithFish


