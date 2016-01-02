mysum n [] = []
mysum n (x:xs) = n+x: mysum n xs

rightTriangles' = [(a,b,c)|c<-[1..10],a<-[1..c],b<-[1..a],
			   			     a^2+b^2==c^2,
					     a+b+c==24]
addThree :: Int->Int->Int->Int
addThree x y z = x + y + z

factorial :: Integer -> Integer
factorial n = product [1..n]

circumference :: Float -> Float
circumference r = 2 * r * pi

addVectors :: (Double, Double) -> (Double, Double) -> (Double, Double)
addVectors (x1,y1) (x2,y2) = (x1+x2,y1+y2)

addThem xs = [ a+b+c | (a,b,c) <- xs, (a+b+c)`mod`2==0]

firstLetter :: String -> String
firstLetter "" = "Empty String"
firstLetter all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]

firstLetter' :: [Char] -> [Char]
firstLetter' "" = "Empty String"
firstLetter' (x:xs) = "The first letter of " ++ (x:xs) ++ " is " ++ [x]

myCompare :: Ord a => a -> a -> Ordering
myCompare a b
	|a == b		= EQ
	|a < b	 	= LT
	|otherwise 	= GT

calcBmis :: [(Double, Double)] -> [Double]
calcBmis xs = [bmi w h | (w, h) <- xs]
	where bmi weight height = weight/height ^ 2

test = [let a = 100; b = 200; c = 300 in a*b*c]

filter' :: (a -> Bool) -> [a] -> [a]
filter' p []= []
filter' p (x:xs)
	| p x		= x : filter' p xs
	| otherwise	= filter p xs
