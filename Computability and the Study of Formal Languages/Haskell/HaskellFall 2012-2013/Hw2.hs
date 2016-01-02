-- Assignment 2 -- Kurt Medley

-- This week I have completed CRFP Ch 4-5.  I had problems with the last 3 problems in H099 as their scope was beyond my functional toolbox. I completed all of the exercises out CRFP, H099 and the functions given on the assignments page.  This week I'll be reading LYAH Ch 5 and 6.

import Data.Char 
maxFour :: Integer -> Integer -> Integer -> Integer -> Integer
maxFour a b c d = max (max (max a b) c) d

between :: Integer -> Integer -> Integer -> Bool
between m n p
	|(n > m) && (n < p)		= True
	|(n == m) && (n < p)		= True
	|(n == p) && (n < m)		= True
	|otherwise			= False

weakAscendingOrder :: Integer -> Integer -> Integer -> Bool
weakAscendingOrder m n p
	|(m < n) && (n == p)	= True	
	|otherwise		= False

middleNumber :: Integer -> Integer -> Integer -> Integer
middleNumber x y z
	|between x y z	= y
	|between y x z	= x
	|otherwise	= z

equal2 :: Integer -> Integer -> Bool
equal2 a b
	|a == b		= True
	|otherwise 	= False

equal3 :: Integer -> Integer -> Integer -> Bool
equal3 a b c
	|(a == b) && (b == c)	= True
	|otherwise		= False
--4.3, 4.9, 4.10, 4.17, 4.18, 4.19, 4.20, 4.21
--4.3
howManyEqual :: Integer -> Integer -> Integer -> Integer
howManyEqual a b c
	|equal3 a b c		= 3
	|equal2 a b		= 2
	|equal2 b c		= 2
	|otherwise		= 0 

howManyFourEqual :: Integer -> Integer -> Integer -> Integer -> Integer
howManyFourEqual a b c d
	|(equal3 a b c) && (d == a)		= 4
	|(equal2 a b) && (equal2 c d)		= 4
	|(equal3 a b c) || (equal3 b c d)	= 3
	|(equal2 a b) || (equal2 c d)		= 2
	|(equal2 b c)				= 2
	|otherwise				= 0

triArea :: Float -> Float -> Float -> Float
triArea a b c
	|possible	= sqrt(s*(s-a)*(s-b)*(s-c))
	|otherwise	= 0
	where
	 s = (a+b+c)/2
	 possible = (a > 0) && (b > 0) && (c > 0) && inequality
	 inequality = a < (b + c) && b < (a + c) && c < (b + a)

--4.9
maxThreeOccurs :: Int -> Int -> Int -> (Int, Int)
maxThreeOccurs a b c = (maximum, times)
	where
	 maximum = max (max a b) c
	 times
	   |(maximum == a) && (maximum == b) && (maximum == c) = 3
	   |(maximum == a) && (maximum == b)		       = 2
	   |(maximum == a) && (maximum == c)		       = 2
	   |(maximum == b) && (maximum == c)		       = 2
           |maximum == a				       = 1
	   |maximum == b				       = 1
	   |maximum == c			               = 1
	   |otherwise					       = 0
-- without a where clause, the definitions of maximum and times would have been defined elsewhere in the script.

--4.10
--Main> maxThreeOccurs 4 5 5
--(5,2)
--Main> maxThreeOccurs 4 5 4
--(5,1)

data Move = Rock | Paper | Scissors deriving (Show,Eq)

-- A function using the datatype Move
beat :: Move -> Move
beat Rock = Paper
beat Paper = Scissors
beat Scissors = Rock

lose :: Move -> Move
lose Rock = Scissors
lose Paper = Rock
lose _ = Paper

--4.17
rangeProduct :: Integer -> Integer -> Integer
rangeProduct m n
	|n < m		= 0
	|otherwise	= product [m..n]
	

--4.18
factorial :: Integer -> Integer
factorial 0 = 1
factorial n = rangeProduct 1 n

--defining a function f of type (Integer -> Integer) to be used in sumFun

sumFun :: (Integer -> Integer) -> Integer -> Integer
sumFun f n
	|n == 0		= f 0
	|n>0		= sumFun f (n-1) + f n

--4.19
addmult :: Integer -> Integer -> Integer
addmult x y
	|(x == 0) || (y == 0)	= 0
	|otherwise		= addmult x (y-1) + x

--4.20
squareRoot :: Integer -> Integer
squareRoot n
	|n == 1		= 1 
	|otherwise	= div (k + (div (n-1) k)) 2
	  where 
		k = squareRoot (n-1)
--4.21
fun :: Int -> Int
fun 0 = 0 
fun 1 = 44
fun 2 = 17
fun _ = 0

fMax :: Int -> Int
fMax n = foldr (max) 0 (listFun n)

listFun :: Int -> [Int]
listFun 0 = []
listFun n = fun n : listFun (n-1)

--4.31
cFactor :: Integer -> Integer -> Integer
cFactor a b = head [ x | x <- la, i <- lb, x == i ]
		where la = reverse (factor a)
		      lb = reverse (factor b)

factor :: Integer -> [Integer]
factor n = [ x | x <- [1..n], n `mod` x == 0]


--4.32
power2 :: Integer -> Integer
power2 n
       | n == 0		= 1
       | n `mod` 2 == 0	= (2^n)^2
       | n `mod` 2 == 1	= ((2^n)^2)*2

--5.7
data Shape =   Circle Float 
	     | Rectangle Float Float 
	     | Triangle Float Float Float

isRound :: Shape -> Bool
isRound (Circle _) = True
isRound (Rectangle _ _) = False
isRound (Triangle _ _ _) = False

area :: Shape -> Float
area (Circle r) = pi * r * r
area (Rectangle h w) = h * w
area (Triangle s1 s2 s3) = sqrt ((s1+s2+s3)/2 * (((s1+s2+s3)/2 - s3)*
				((s1+s2+s3)/2 - s2)*((s1+s2+s3)/2 - s1)))

-- 1/2 triangle perimeter
--tP s1 s2 s3 = (s1 + s2 + s3)/2

perimeter :: Shape -> Float
perimeter (Circle r) = 2 * pi * r
perimeter (Rectangle h w) = 2 * h + 2 * w
perimeter (Triangle s1 s2 s3) = s1 + s2 + s3

--5.15
--[0,0.1..1] has the type (Fractional t, Enum t) => [t]. The form [0,0.1..1] is ambigious because it contains Integers 0 and 1 which haskell parses to floats in the result[0.0,0.1,0.2,0.30000000000000004,0.4000000000000001,0.5000000000000001,0.6000000000000001,0.7000000000000001,0.8,0.9,1.0], which is obviously a list of Floats.

--5.16
--[2,3] = [Integer, Integer] 2 items of type Integer. [[2,3]] has one list of Integer [[Integer]].  [[2,3]] :: [[Integer]]

--5.17
--[2..2] = [2]; [2,7..4] = [2] [2,2..2] evaluates an infinite list of 2's.

--5.18
doubleAll :: [Integer] ->  [Integer]
doubleAll xs = [ 2*x | x<- xs ]

--5.19
capitalize :: String -> String
capitalize st = [ toUpper x | x <- st, isLetter x ]

--5.20
divisors :: Integer -> [Integer]
divisors n = [ x | x <- [1..n], n `rem` x == 0]

isPrime :: Integer -> Bool
isPrime n 
	|length (divisors n) == 2 = True
	|otherwise		  = False

--5.21
matches :: Integer -> [Integer] -> [Integer]
matches n [] = []
matches n xs = [ x | x <- xs, n == x ] 

--5.22
onSeparateLines :: [String] -> String
onSeparateLines st = unlines st

--listDiff :: [a] -> [a] -> [a]
listDiff xs [] = xs
listDiff [] ys = []
listDiff (x:xs) (y:ys)
	|x == y		= listDiff xs ys
	|otherwise	= x: listDiff xs ys

--listTrim
listTrim xs [] = xs
listTrim [] ys = []
listTrim (x:xs)(y:ys)
	|x == y 	= listTrim xs ys
	|otherwise	= x:y: listDiff xs ys

groupByN :: Int -> [t] -> [[t]]
groupByN n [] = []
groupByN n xs = ys : groupByN n zs 
	where (ys,zs) = splitAt n xs

--H099
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
       |n > length xs  = error "List shorter than index"
elementAt [x] 0 = x
elementAt (x:xs) n = elementAt xs (n-1)

-- (*) Find the number of elements of a list
length' :: [a] -> Int
length' [] = 0
length' (x:xs) = 1 + length' xs

-- (*) Reverse a list.
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

-- (*) Find out whether a list is a palindrome. A palindrome can be read forward or backward; e.g. (x a m a x). 

palindrome :: Eq a => [a] -> Bool
palindrome xs
	|xs == ys	= True
	|otherwise	= False
	  where ys = reverse xs

-- (**) Flatten a nested list structure. 

data NestedList a = Elem a | List [NestedList a]
flatten :: NestedList a -> [a]
flatten (Elem x ) = [x]
flatten (List xs) =  foldr (++) [] $ map flatten xs

--(**) Eliminate consecutive duplicates of list elements. 

compress :: Eq a => [a] -> [a]
compress [] = []
compress (x:xs) = x : (compress $ dropWhile (==x) xs) 

-- (**) Pack consecutive duplicates of list elements into sublists. If a list contains repeated elements they should be placed in separate sublists. 

pack :: (Eq a) => [a] -> [[a]]
pack [] = []
pack (x:xs) = (x : takeWhile (==x) xs) : pack (dropWhile (==x) xs)

-- (*) Run-length encoding of a list. Use the result of problem P09 to implement the so-called run-length encoding data compression method. Consecutive duplicates of elements are encoded as lists (N E) where N is the number of duplicates of the element E. 

encode [] = []
encode (x:xs) = (length $ x : takeWhile (==x) xs, x)
                 : encode (dropWhile (==x) xs)

--5.28
type Person = String
type Book = String

type Database = [(Person, Book)]

books :: Database -> Person -> [Book]
books dBase findPerson =
	[ book | (person,book) <- dBase, person==findPerson ]

borrowers :: Database -> Book -> [Person]
borrowers dBase findBk = [ person | (person,bk) <- dBase, findBk == bk ]

borrowed :: Database -> Book -> Bool
borrowed dBase findBk = 
	not (null [ person | (person,bk) <- dBase, findBk == bk ]) 

numBorrowed :: Database -> Person -> Int
numBorrowed dBase pers = length [ bk | (person,bk) <- dBase, pers == person ] 

makeLoan :: Database -> Person -> Book -> Database
makeLoan dBase pers bk = [ (pers,bk) ] ++ dBase

returnLoan :: Database -> Person -> Book -> Database
returnLoan dBase pers bk = [pair | pair <- dBase, pair /= (pers,bk) ]

exampleBase :: Database
exampleBase = 
	[("Kurt","aBook"),("Kurt","bBook"),("Jon","bBook"),("Jon","cBook")]

-- LIST TRIM
-- listTrim :: [a] -> [a] -> [a]
-- listTrim xs [] = xs
-- listTrim [] ys = []
-- listTrim (x:xs) (y:ys)
--	|y == x		= listTrim xs ys
--	|otherwise	= x:y: ListTrim xs ys
