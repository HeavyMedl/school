-- Assignment 1 - Programming with Monads for IO

-- In CRFP do exercises 18.1 to 18.7 p461 (taken from fall quarter asn9)
-- In CRFP do exercises 8.10 to 8.13 p188 (Note it's Chapter 8 not 18).
-- In CRFP do exercises 8.14 to 8.19 
import Data.Char
import System.IO (isEOF)
-- 8.10 to 8.13
-- 8.10 Write an IO program which will read a line of input and test whether the input is a palindrome.  The program should 'prompt' for its input and also output an appropriate message after testing.
isPalindrome :: IO ()
isPalindrome = do
		putStrLn "What string would you like to test?"
		line <- getLine
		if (reverse line == line) then putStrLn "YES INDEED"
		else putStrLn "NEGATIVE GHOST RIDER!"
-- 8.11 Write an IO program which will read two integers, each on a separate line, and return their sum.  The program should prompt for input and explain its output.
sum2 :: IO ()
sum2 = do
	putStrLn "Enter the first number to sum: "
	numS1 <- getLine
	putStrLn "Enter the second number to sum: "
	numS2 <- getLine
	putStr "Your total is: "
	print $ (read numS1) + (read numS2)
	
-- 8.12 Define a function putNtimes :: Integer -> String -> IO () so that the effect of putNtimes n str is to output str, a string, n times, one per line
putNtimes :: Integer -> String -> IO ()
putNtimes n str = do
	if (n==0) then return ()
	else do	putStrLn str
		putNtimes (n-1) str

--8.13 Write an IO program which will first read a positive integer, n say, and then read n integers and write their sum.  The program should prompt appropriately for its inputs and explain its output.
--sumArb :: IO Integer
sumArb = do
	putStrLn "Enter a number:"
	n <- getInt
	if n == 0 then return 0
	else do m <- sumArb
		return (n + m)

--8.14 to 8.19
--8.14 Define a wc function which copies input to output until an empty line is read.  The program should the nputput the number of lines, words and characters that have been copied. [wc is a standard unix command line program]
wc :: Int -> Int -> Int -> IO ()
wc l w c = do 
 	str <- getLine
	if str == "" then do putStrLn (show l ++ " lines copied.")
			     putStrLn (show w ++ " words copied.")
			     putStrLn (show c ++ " chars copied.")	
 		     else do putStrLn str
			     wc (l+1) (w + length (words str)) (c + length str)

wc' :: IO ()
wc' = do
	str <- getLine
	let l = 0
	let w = 0
	let c = 0
	if str == "" then do
	 putStrLn (show l ++ " lines copied.")
	 putStrLn (show w ++ " words copied.")
	 putStrLn (show c ++ " chars copied.")
	else do putStrLn str
		print (l + 1)
		print (w + length (words str))
		print (c + length str)
		wc'
--8.15 Define an interactive palindrome checker.  You should neglect capitalization, white space and punctuation, so that Madam I'm Adam is recognized as a palindrome.
palinCheck :: IO ()
palinCheck = do
	putStrLn "Enter a string to test:"
	str <- getLine
	if modS str == reverse (modS str) then putStrLn "IS a palindrome."
					  else putStrLn "is NOT a palindrome."

modS :: String -> String	
modS x = filter isAlpha $ map toLower (unline $ words x)

unline :: [String] -> String
unline [] = ""
unline (x:xs) = x ++ unline xs

--8.16 Write a program which repeatedly reads lines and test whether they are palindromes until an empty line is read.  The program should explain clearly to the user what input is expected and output is produced.
isPalindromeN :: IO ()
isPalindromeN = do
	putStrLn "Repeatedly test whether or not a string is a palindrome.An empty string ends the program.  Enter input:"
	str <- getLine
	if str == "" then return ()
		else do if str == reverse str then putStrLn "YES"
					      else putStrLn "NO"
			isPalindromeN

--8.17 Write a program which repeatedly reads integers (one per line) until finding a zero value and outputs the sum of the inputs read
sumIO :: Integer -> IO Integer
sumIO s = do
	n <- getInt
	if n==0 then return s
		else sumIO (s+n)

--8.18 Write a program which repeatedly reads integers (one per line) until finding a zero value and outputs a sorted version of the inputs read.  Which sorting algorithm is most appropriate in such a case.
sumIO' :: [Integer] -> IO [Integer]
sumIO' xs  = do
	n <- getInt
	if n == 0 then return xs
		  else sumIO' (xs ++ [n])

--8.19 Explain the behaviour of this copy program
copy :: IO ()
copy = do
	line <- getLine
	let whileCopy = do
		if (line == "") then (return ())
				else do putStrLn line
					line <- getLine
					whileCopy
	whileCopy
-- Initially getLine retrieves an IO String.  The local whileCopy tests if the line is empty, if so, it returns void.  If line is not empty, the line is echoed and a new line is retrieved from an IO action.
 
-- 18.1 to 18.7
-- 18.1
getInt :: IO Integer
getInt = do
	line <- getLine
	return (read line :: Integer)

sumInts :: Integer -> IO Integer
sumInts s = do
	n <- getInt
	if n == 0
		then return s
		else sumInts (s + n)

sumInts' :: IO Integer
sumInts' = do 
	n <- getInt
	if n==0
		then return 0
		else (do m <- sumInts'
		         return (n+m))
-- The tail recursive version of sumInts will be more efficient as it uses tail recursion to accumulate the next integer to sum up.

-- 18.2
fmap' :: (a -> b) -> IO a -> IO b
fmap' f action = do
	out <- action
	return (f out)

map' :: (a -> b) -> a -> b
map' f x = f x

-- 18.3
repeat' :: IO Bool -> IO () -> IO ()
repeat' test oper = do
	line <- getBool
	if (line == True) then return ()
			  else (do oper
				   repeat' test oper)
				
getBool :: IO Bool
getBool = do
	line <- getLine
	return (read line :: Bool)

-- 18.4 

whileG :: (a -> IO Bool) -> (a -> IO a) -> a -> IO a
whileG cond action initS = do
	c <- cond initS
	if (c == True)
		then do newS <- action initS
		        whileG cond action newS
		else do return initS

-- 18.5 Using the function whileG or otherwise, define an interaction which reads a number, n say, and then reads a further n numbers and finally returns their average.
-- (fromIntegral $ sum xs) / (fromIntegral $ length xs)

averageIO = do
	putStrLn "Enter a series of numbers to be averaged.. Enter '0' to produce the result"
	result <- eofList
	return $ (fromIntegral $ sum result) / (fromIntegral $ length result)

intList :: IO [Integer]
intList = do
	int1 <- getInt
	if int1 == 0 then return ([])
		     else do int2 <- intList
			     return ([int1]++int2)

getNextInt :: [Integer] -> IO [Integer]
getNextInt xs 
    = do x <- getInt
         return (x:xs)

-- 18.6 Modify your answer to the previous question so that if the end of file is reached before n numbers have been read, a message to that effect is printed.

--averageEOF n = do
--	result <- 	

-- function that decrements n until 0, producing a IO [Integer]	
paramList :: Integer -> IO [Integer]
paramList n = do
	int1 <- getInt
	if (n == 0) then return ([]) 
		    else do int2 <- paramList (n-1)
			    return ([int1]++int2)

-- EOF list 
eofList :: IO [Integer]
eofList = do
	eof <- isEOF
	if (eof) then return ([])
		 else intList
		 

--18.7 Define a function accumulate :: [IO a] -> IO [a] which performs a sequence of interactions and accumulates their result in a list.  Also give a definition of the function sequence :: [IO a] -> IO () which performs the interactions in turn, but discards their results.  Finally, show how you would sequecne a series, passing values from one to the next: seqList :: [a -> IO a] -> a -> IO a. What will be the result on an empty list?

accumulate :: [IO a] -> IO [a]
accumulate [] = return []
accumulate (a:as) = do
	v <- a
	vs <- accumulate as
	return (v:vs)

sequence' :: [IO a] -> IO ()
sequence' [] = return ()
sequence' (x:xs) = do
	v <- x
	vs <- sequence xs
	return ()

seqList :: [a -> IO a] -> a -> IO a
seqList (a:as) inits = do
	newS <- a inits
	rState <- seqList as newS
	return rState
seqList [] inits = return inits

-- test function for seqList
sumfun :: Num a => a -> IO a
sumfun n = do
	return (n + n)

