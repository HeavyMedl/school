> import Prelude hiding (Monad,(>>),(>>=),return,fail)

The bind operator (>>=)

(>>=) :: (Monad m) => m a -> (a -> m b) -> m b

(>>=) takes a monadic value and a function that takes a normal value.  It returns a monadic value and manages to apply that function to the monadic value.

(\x -> Just (x+1)) : A function that takes a number and adds 1 to it, and then wraps it in a Maybe VC, Just..

> applyMaybe :: Maybe a -> (a -> Maybe b) -> Maybe b
> applyMaybe Nothing f = Nothing
> applyMaybe (Just x) f = f x

*Main> applyMaybe Nothing (\x -> Just (x+1))
Nothing
*Main> applyMaybe (Just 3) (\x -> Just (x+1))
Just 4

*Main> applyMaybe (Just 3) (\x -> if x > 2 then Just (x+1) else Nothing)
Just 4

> class Monad' m where
>	return	:: a -> m a
> 	(>>=)	:: m a -> (a -> m b) -> m b
>	
>	(>>)	:: m a -> m b -> m b
>	x >> y 	= x >>= \_ -> y
>
>	fail :: String -> m a
>	fail msg = error msg

Every monad is an applicative functor. Making Maybe an instance of Monad

> instance Monad' Maybe where
> 	return = Just
>	Nothing >>= f = Nothing
>	(Just x) >>= f = f x
>	fail _ = Nothing

*Main> Just 10 >>= (\x -> return (x*2))
Just 20

Note that return is equivalent to pure, its simply placing a value into a computational context.  In the above expression, the bind operator takes a Maybe a, and a function with a normal value, converts it to a computational context Maybe using return, and then applys x*2 to the argument (Just 10).

do Notation

Just 3 >>= (\x -> Just "!" >>= (\y -> Just (show x ++ y)))

> foo :: Maybe String
> foo = do
> 	x <- Just 3
>	y <- Just "!"
>	Just (show x ++ y)

> bar :: Maybe Bool
> bar = do
> 	x <- Just 8
>	Just (x > 9)

Pattern matching with monadic values:

> justH :: Maybe Char
> justH = do
> 	(x:xs) <- Just "Hello"
>	return x

For reference to applicative functors

> class Functor f => Applicative f where
> 	pure :: a -> f a
> 	(<*>) :: f (a -> b) -> f a -> f b

> instance Applicative [] where
>	pure = (\x -> [x])
> 	gs <*> xs = [ g x | g <- gs, x <- xs ]

fmap synonym

> (<$>) :: Applicative f => (a -> b) -> f a -> f b
> g <$> x = fmap g x 

*Main> (+) <$> [1,2,3,4] <*> [1,2,3]
[2,3,4,3,4,5,4,5,6,5,6,7]

> instance Monad' [] where
>	return = (\x -> [x])
>	xs >>= f = concat (map f xs)
>	fail _ = []

*Main> [1,2,3] >>= (\x -> [x,-x])
[1,-1,2,-2,3,-3]

[1,2,3] = concat [[1,-1],[[2,-2],[3,-3]] : Every element of the argument list gets thrown into the function (a -> m b) where m b represents the monadic list.  Its then flattened by concat to give us our resulting list.

*Main> [1,2] >>= \n -> ['a','b'] >>= \ch -> return (n,ch)
[(1,'a'),(1,'b'),(2,'a'),(2,'b')]

or this may be written with the do notation

> listofTups :: [(Int,Char)]
> listofTups = do
>	n <- [1,2]
>	ch <- ['a','b']
>	return (n,ch)

do Notation and List comprehensions

> t1 = [ (n, ch) | n <- [1,2], ch <- ['a','b'] ] 

list comprehensions are just syntactic sugar for using lists as monads.

MonadPlus and the guard Function

> class Monad' m => MonadPlus m where
> 	mzero :: m a
> 	mplus :: m a -> m a -> m a

> instance MonadPlus [] where
> 	mzero = []
>	mplus = (++)

> guard :: (MonadPlus m) => Bool -> m ()
> guard True = return ()
> guard False = mzero

> t2 = [1..50] >>= (\x -> guard (elem '7' (show x)) >> return x)

*Main> t2
[7,17,27,37,47]

> sevensOnly :: [Int]
> sevensOnly = do
>	x <- [1..50]
>	guard ('7' `elem` show x)
>	return x

Monad Laws

Left Identity : return x >>= f = f x 

return 3 >>= (\x -> Just (x+10))
Just 13

(\x -> Just (x+10)) 3
Just 13

Right Identity : m >>= return = m  --OR-- m a >>= return x = m a

*Main> Just "move on up" >>= (\x -> return x)
Just "move on up"

The monadic Just value "move on up" is bound (>>=) to \x, return puts this value into a default minimal context and its result is the identity.

Associativity : (m >>= f) >>= g = m >>= (\x -> f x >>= g)

> (<=<) :: (Monad' m) => (b -> m c) -> (a -> m b) -> (a -> m c)
> f <=< g = (\x -> g x >>= f)
