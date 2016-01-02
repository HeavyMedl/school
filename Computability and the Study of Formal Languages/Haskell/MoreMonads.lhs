Notes on LYAH Chapter 14 -- For a Few Monads More

> import Data.Monoid
> import Control.Monad.Writer
> import qualified Control.Monad.Instances

Writer Monad -- allows us to do computations while making sure that all the log values combined into one log value, which then is attached to the result.

> isBigGang :: Int -> (Bool, String)
> isBigGang x = (x > 9, "Compared to gang of size 9")

> applyLog :: (a, String) -> (a -> (b, String)) -> (b, String)
> applyLog (x, log) f = let (y, newLog) = f x in (y, log ++ newLog)

We just take the value, which is x, and we apply the function f to it.  We get a pair of (y, newLog), where y is the new result and newLog is the new log.  We use ++ to append the new log to the old one.

*Main> (3, "Small gang.") `applyLog` isBigGang
(False,"Small gang.Compared to gang of size 9")

*Main> ("kurt","Its my first name.") `applyLog` (\x -> (reverse x, "Reversed.."))
("truk","Its my first name.Reversed..")

MONOIDS - This works on any kind of list.

applyLog' :: (a, [c]) -> (a -> (b, [c])) -> (b, [c])

applyLog :: (Monoid m) => (a, m) -> (a -> (b, m)) -> (b, m)
applyLog (x, log) f = let (y, newLog) = f x in (y, log `mappend` newLog)

>-- newtype Writer w a = Writer { runWriter :: (a, w) }

>-- instance (Monoid w) => Monad (Writer w) where
>-- 	return x = Writer (x, mempty)
>-- 	(Writer (x, v)) >>= f = let (Writer (y, v')) = f x in Writer (y, v `mappend` v')

We take the value x and apply the function f to it.  This gives us a Writer w a value, and we use a let expression to pattern match on it. 

Using do Notation with Writer

> logNumber :: Int -> Writer [String] Int
> logNumber x = writer (x, ["Got number: " ++ show x])

*Main> :t writer
writer :: (a, w) -> Writer w a

> multWithLog :: Writer [String] Int
> multWithLog = do
>	a <- logNumber 3
>	b <- logNumber 5
>	tell ["Gonna multiply these two!"]
>	return (a*b)

> gcd' :: Int -> Int -> Int
> gcd' a b
>	| b == 0	= a
>	| otherwise	= gcd' b (a `mod` b)

> gcd'' :: Int -> Int -> Writer [String] Int
> gcd'' a b
>	| b == 0 = do
>		tell ["Finished with " ++ show a ]
>		return a
>	| otherwise = do
>		tell [ show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b) ]
>		gcd'' b (a `mod` b)

This function takes two normal Int values and returns a Writer [String] Int - that is, an Int that has a log context. Alternatively written

> gCd :: Int -> Int -> Writer [String] Int
> gCd a b
>	| b == 0	 = writer (a, ["Finished with " ++ show a])
>	| otherwise	 = do 
>		tell [ show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b) ]
>		gCd b (a `mod` b)

*Main> runWriter $ gCd 24 10
(2,["24 mod 10 = 4","10 mod 4 = 2","4 mod 2 = 0","Finished with 2"])

Using mapM_ to map putStrLn over a list of strings

*Main> mapM_ putStrLn $ snd $ runWriter (gCd 24 10)
24 mod 10 = 4
10 mod 4 = 2
4 mod 2 = 0
Finished with 2

You can add a logging mechanism to pretty much any function.  You just replace normal values with Writer values where you want and change normal function application to >>= (or do expressions if it increases readability).

Using Difference Lists -- A difference list is actually a function that takes a list and prepends another list to it. \xs -> [1,2,3] ++ xs

>-- summ :: Int -> [Int] -> Writer [String] [Int]
>-- summ n [] = writer ([], ["Finished with: " ++ show []])
>-- summ n (x:xs) = do
>--	tell [ show n ++ " plus " ++ show x ++ " plus " ++ show xs ]

> append f g = \xs -> f (g xs)

Functions as Monads

 instance Monad ((->) r) where
	return g = \_ -> g
	h >>= f = \w -> f (h w) w

To get the result from a function, we need to apply it to something, which is why we use (h w) here, and then we apply f to that.  f returns a monadic value, which is a function in our case, so we apply it to w as well. 

The Reader Monad

> addStuff :: Int -> Int
> addStuff = do
>	a <- (*2)
>	b <- (+10)
>	return (a+b)

Both (*2) and (+10) are applied to the number 3 in this case.  return (a+b) does as well, but it ignores that value and always presents a+b as the result.  For this reason, the function monad is also called the reader monad.  All the functions read from a common source.
