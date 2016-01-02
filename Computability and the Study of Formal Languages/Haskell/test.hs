
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

reverse'' :: [a] -> [a]
reverse'' [] = []
reverse'' xs = [last xs] ++ reverse'' (init xs)

double :: Integer -> Integer
double n = 2 * n

square :: Integer -> Integer
square n = n * n

doubThenSq :: Integer -> Integer
doubThenSq n = square (double n)

sqThenDoub :: Integer -> Integer
sqThenDoub n = double (square n)

-- main = do putStrLn greeting
--	  name <- getLine
--	  putStrL --		("Hello, "++name++".")
--  where
--	greeting = "Type your name"

myeXor :: Bool -> Bool -> Bool
myeXor True True = False
myeXor True False = True
myeXor False True = True
myeXor False False = False

threeDifferent :: Int -> Int -> Int -> Bool
threeDifferent m n p = (m /= n) && (m /= p) && (p /= n)

aMin :: Int -> Int -> Int
aMin x y = if x >= y then y else x

minThree :: Int -> Int -> Int -> Int
minThree a b c 
	|a < b && a < c		= a
	|b < c			= b
	|otherwise		= c

threeStrings :: String -> String -> String -> String
threeStrings a b c = a ++ "\n" ++ b ++ "\n" ++ c

romanDigit :: Char -> String
romanDigit d
	|d == '1'	= "I"
	|d == '2'	= "II" 

averageThree :: Integer -> Integer -> Integer -> Float
averageThree a b c = fromIntegral (a+b+c) / 3

howManyAboveAverage :: Integer -> Integer -> Integer -> Integer
howManyAboveAverage a b c 
	|aa > a3 && bb > a3 && cc > a3			=3
	|aa > a3 && bb > a3				=2
	|aa > a3 && cc > a3				=2
	|bb > a3 && cc > a3				=2
	|aa > a3					=1
	|bb > a3					=1
	|cc > a3					=1
	|otherwise					=0
		where
			a3 = averageThree a b c
			aa = fromInteger a
			bb = fromInteger b
			cc = fromInteger c

-- Quadratic Equation
-- a*x^2 + b*X + c = 0.0

numberNDroots :: Float -> Float -> Float -> Integer
numberNDroots a b c
	| b == 0.0 && c /= 0.0	= noRealRoots
	| b == 0.0 && c == 0.0	= everyRealNumberaRoot	
	| b /= 0.0		= oneRealRoot
	| b^2 > discriminant	= twoRealRoots
	| b^2 == discriminant	= oneRealRoot
	| b^2 < discriminant	= noRealRoots
		where 
			discriminant = 4.0 * (a*c)
			twoRealRoots = 2
			oneRealRoot  = 1
			noRealRoots  = 0
			everyRealNumberaRoot = 3

length' :: [a] -> Int
length' [] = 0
length' (x:xs) = 1 + length xs

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = let
	smallerOrEqual = [ a | a <- xs, a <= x ]
	larger	       = [ a | a <- xs, a > x  ]
	in quicksort smallerOrEqual ++ [x] ++ quicksort larger

elem' :: (Eq a) => a -> [a] -> Bool
elem' a [] = False
elem' a (x:xs)
	|a == x		= True
	|otherwise	= elem' a xs
