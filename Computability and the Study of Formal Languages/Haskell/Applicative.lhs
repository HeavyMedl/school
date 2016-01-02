
Using Applicative Functors

	From LYAH (pg 227 - 242)

Applying a function to the functor value: fmap (*) (Just x) = Just ((*) x)
Wrapping a function in a computational context

examples: 	
	fmap (++) (Just "hey!") :: Maybe ([Char] -> [Char])
	fmap (\x y z -> x + y / z ) [1,2,3,4] :: Fractional a => [a -> a -> a]

An example of binding a function with a wrapper:

> a :: [Integer -> Integer]
> a = fmap (*) [1,2,3,4]

*Main> fmap (\n -> n 9) a
[9,18,27,36]

The Applicative Class

> class Functor f => Applicative f where
>	pure :: a -> f a
>	(<*>) :: f (a -> b) -> f a -> f b

pure : f plays the roll of our applicative functor instance here. pure should take a value of any type and return an applicative value with that value inside it. We take a value and we wrap it in an applicative value that has that value as the result inside it.  It takes a value and puts it in some sort of default (or pure) context.

<*> : takes a functor value that has a function in it and another functior, and extracts that function from the first functor and then maps it over the second one.

Maybe the Applicative Functor

> instance Applicative Maybe where
>	pure = Just
>	Nothing <*> _ = Nothing
>	(Just g) <*> something = fmap g something

Nothing <*> _ : if we try to extract a function out of Nothing, we get Nothing
(Just g) <*> something : Value constructor + function aka (Just g), we want to map that function over the second parameter. From left to right

*Main> pure (+) <*> Just 12 <*> Just 13
Just 25

*Main> Just (+3) <*> Just 12
Just 15

*Main> Just (+) <*> Just 1 <*> Just 2
Just 3

pure f <*> x = fmap f x
(Just f) -> f applied to x = fmap f (Just x)
			   = Just (f x)

<$> : fmap as an infix operator

> (<$>) :: (Functor f) => (a -> b) -> f a -> f b
> g <$> x = fmap g x 

g <$> (Just 4) = Just (g 4)

Lists are instances of Applicative

> instance Applicative [] where
> 	pure x = [x] 	-- intuitively (pure = []) and so ([] x = [x])
>	fs <*> xs = [ f x | f <- fs, x <- xs ]

Here populate f with fs (functions) and x with xs (arguments) and return a list with arguments that have each function from fs applied to them.

*Main> (+) <$> [1,2,3] <*> [3,2,1]
[4,3,2,5,4,3,6,5,4]

*Main> filter (>50) $ (*) <$> [10,20,30] <*> [1,2,3]
[60,60,90]

IO as an instance of Applicative

> instance Applicative IO where
>	pure = return
>	a <*> b = do
>		f <- a
>		x <- b
>		return (f x)

*Main> let myAction = (++) <$> getLine <*> getLine
*Main> myAction
kurt 
medley
"kurt medley"

> testIO :: IO String
> testIO = do
> 	a <- (++) <$> getLine <*> getLine
>	return $ "Iddy biddy" ++ a

Functions as Applcatives ((->) r)

> instance Functor ((->) r) where
>	fmap f g = (\x -> f (g x))

> instance Applicative ((->) r) where
>	pure x = (\_ -> x)
>	f <*> g = (\x -> f x (g x))

Zip Lists

ZipList is defined in Control.Applicative and so must be used without loading this script, lest you define your own instance of ZipList.

instance Applicative ZipList where
	pure = ZipList (repeat x)
	ZipList fs <*> ZipList xs = ZipList (zipWith (\f x -> f x) fs xs)

>-- alternatively written: ZipList gs <*> ZipList xs = ZipList (zipWith ($) gs xs)

Control.Applicative> getZipList $ (+) <$> ZipList [1,2,3] <*> ZipList [100,100,100]
[101,102,103]

Applicative Laws

1. pure g <*> x = fmap g x --OR-- g <$> x = pure g <*> x
2. pure (.) <*> u <*> v <*> w = u <*> (v <*> w)
3. pure f <*> pure x = pure (f x)
4. u <*> pure y = pure ($ y) <*> u

Useful Functions for Applicatives

liftA2 :: Applicative f => (a -> b -> c) -> f a -> f b -> f c
liftA2 f a b = f <*> a <*> b

Control.Applicative> liftA2 (:) (Just 3) (Just [2,1])
Just [3,2,1]

A function that takes a list of applicative values and returns an applicative value that has a list as its result value.

> sequenceA :: (Applicative f) => [f a] -> f [a]
> sequenceA [] = pure []
> sequenceA (x:xs) = (:) <$> x <*> sequenceA xs

Recall <$> is a synonym for fmap
(<$>) :: (Functor f) => (a -> b) -> f a -> f b
g <$> x = fmap g x
	= g x
	= g (ApplicativeContext v)
	= ApplicativeContext (g v) 
*Main> sequenceA [Just 4, Just 4, Just 5, Just 6]
Just [4,4,5,6]

