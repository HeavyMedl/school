-- Assignment 1 -- Kurt Medley

-- This week I've read CRFP Ch 1-3, LYAH Ch 1-4, Haskell Basics, and PINH Ch slides 1-3.  I would consider all readings to have been done thouroughly.  I've completed all the assigned CRFP problems and additionally 1-4 of H99P.  I am concentrating on higher order functions and recursion now.


-- H99P
import Data.Char
import Data.List
import Text.Read
-- (*) Find the last element of a list

last' :: [a] -> a
last' [x] = x
last' (x:xs) = last' xs


-- (*) Find the last but one element of a list.

myButLast :: [a] -> a
myButLast [x] = x
myButLast xs = last' newList
	where newList = init xs

-- (*) Find the K'th element of a list. The first element in the list is number 1

elementAt :: [a] -> Int -> a
elementAt xs n
	|n > length xs	= error "List shorter than index"
elementAt [x] 0 = x
elementAt (x:xs) n = elementAt xs (n-1)

-- (*) Find the number of elements of a list
length' :: [a] -> Int
length' [] = 0
length' (x:xs) = 1 + length' xs 

-- Tim Sheard's Assignment 1
-- 1.
-- Determine the types of "3", "even", and "even 3". How do you
-- determine the last one?
-- Now, determine the types of "head", "[1,2,3]", and "head [1,2,3]". What
-- happens when applying a polymorphic function to an actual parameter?
-- (hint, use the :t top level command of the Hugs interpreter).

-- "3" :: Int, "even" :: Bool, "even 3" has the value False, as 3 is an odd Int determined by the the function "even".

-- "head" :: [a] -> a, takes a list of type-variable a and gives the first a within that list.[1,2,3] :: [Int], this finite set is a list ([]) of integers (Int). "head [1,2,3]" is of type Num a => a.  Num a is a type-class, a class constraint Num restricts the consequent from being anything aside from an Int 

-- 2.
-- For each type, write a function with that type.
-- a)   (Float -> Float) -> Float
-- b)   Float -> (Float -> Float)
-- c)   (Float -> Float) -> (Float -> Float)

-- 3.
-- Write a function: strlen which returns the length of a string. E.G.
--     strlen "abc"  --> 3           strlen ""  --> 0

len :: [a] -> Int
len [] = 0
len (x:xs) = 1 + len xs

-- 4. 
-- Write a function which computes n factorial. E.g.
--   fact 0  --> 1     fact 3  --> 6    fact 5 --> 120

fact :: Int -> Int
fact 0 = 1
fact n = product [1..n]

-- 5.
-- Write the ncopies function. For example:
-- ncopies 3 5     --> [5,5,5]
-- ncopies 4 "a"   --> ["a","a","a","a"]
-- ncopies 0 true  --> []

ncopies :: Int -> a -> [a]
ncopies 0 _ = []
ncopies n x = x : ncopies (n-1) x

-- 6.
-- Write the power function for integers. For example:
-- power 5 2 --> 25        power 3 3 --> 27       power 2 5  --> 32

power :: Int -> Int -> Int
power n m = n ^ m


-- 7.
-- Write a function which converts a string of digits into an int.
-- you will need the following predefined function:
-- ord ‘1’       --> 49         first char in arg to its ascii code
--
-- follow the following "pipeline" analysis when defining your function
-- "167"  --> ['1','6','7'] --> [49,54,55] --> [1,6,7] --> [(1,100),(6,10),(7,1)]
--                     --> [100, 60, 7] --> 167
-- (hint: the first function in the pipeline is very simple. why?)

ascii1 :: Char -> Int
ascii1 '1' = 49

convertCharInt :: [Char] -> Int
convertCharInt x = read x :: Int

convertIntList :: Int -> [Int]
convertIntList n = map digitToInt (show n)

convertStringIntL :: [Char] -> [Int]
convertStringIntL xs = (convertIntList.convertCharInt) xs

intToOrdL :: [Char] -> [Int]
intToOrdL [] = []
intToOrdL (x:xs) = ord x : intToOrdL xs

convertIntLtoChar :: [Int] -> [Char]
convertIntLtoChar [] = []
convertIntLtoChar (x:xs) = intToDigit x: convertIntLtoChar xs

ordToChr :: [Int] -> [Char]
ordToChr [] = []
ordToChr (x:xs) = chr x: ordToChr xs

tuplesPlace :: [Int] -> [(Int,Int)]
tuplesPlace [] = []
tuplesPlace xs = [([ (x,i) | x <- xs, i <- [100,10,1] ] !! 0),
		  ([ (x,i) | x <- xs, i <- [100,10,1] ] !! 4),
		  ([ (x,i) | x <- xs, i <- [100,10,1] ] !! 8) ]

tupsList :: [(Int,Int)] -> [Int]
tupsList xs = [ x * y | (x, y) <- xs ]

sumList :: [Int] -> Int
sumList [] = 0
sumList (x:xs) = x + sumList xs

-- CRAFT OF FUNCTIONAL PROGRAMMING 
-- Problems 3.9, 3.11a, 3.12, 3.17, 3.18, 3.20, 3.21, 3.22

--3.9

threeDifferent :: Integer -> Integer -> Integer -> Bool
threeDifferent x y z 
	|(x == y) || (x == z) || (z == y)	= False
	|(x == y) || (x == z)			= False
	|(y == z)				= False
	|otherwise				= True

--3.11a
--threeEqual (2+3) 5 (11 'div' 2)
--threeEqual 5 5 5
--True
--mystery (2+4) 5 (11 'div' 2)
--mystery 6 5 5
--True
--threeDifferent (2+4) 5 (11 'div' 2)
--threeDifferent 6 5 5
--False
--fourEqual (2+3) 5 (11 'div' 2) (21 'mod' 11)
--fourEqual 5 5 5 10
--False

--3.17
charToNum :: Char -> Int
charToNum x = digitToInt x

--3.18
onThreeLines :: String -> String -> String -> String
onThreeLines a b c = a ++ "\n" ++ b ++ "\n" ++ c
--3.20
averageThree :: Integer -> Integer -> Integer -> Float
averageThree x y z = fromIntegral (x+y+z) / 3

howManyAboveAverage :: Integer -> Integer -> Integer -> Integer
howManyAboveAverage a b c
	|(a > average) && (b > average) && (c > average)= 3
	|(a > average) && (b > average)			= 2
	|(b > average) && (c > average)			= 2
	|(a > average) && (c > average)			= 2
	|a > average					= 1
	|b > average					= 1
	|c > average					= 1
	|otherwise					= 0
		where average = ceiling (averageThree a b c)
--3.21
-- quickCheck prop_average
-- 	where prop average = (averageThree 1 2 3) == (average 1 2 3)
--
-- quickCheck prop_howMany
-- 	where prop_howMany = (howManyAboveAverage 1 2 3) == (howMany 1 2 3)

--3.22
numberNDroots :: Float -> Float -> Float -> Integer
numberNDroots a b c
	| b == 0.0 && c /= 0.0  = noRealRoots
        | b == 0.0 && c == 0.0  = everyRealNumberaRoot
        | b /= 0.0              = oneRealRoot
        | b^2 > discriminant    = twoRealRoots
        | b^2 == discriminant   = oneRealRoot
        | b^2 < discriminant    = noRealRoots
                where
                        discriminant = 4.0 * (a*c)
                        twoRealRoots = 2
                        oneRealRoot  = 1
                        noRealRoots  = 0
                        everyRealNumberaRoot = 3
