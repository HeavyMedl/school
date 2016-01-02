determine the type BEFORE running
check your type against haskell's type inference using :t
run your functions in Haskell and cut and paste the result in your 
homework file

>	mysum [] = 0
>	mysum (x:xs) = x + mysum xs

Hugs> :r
Main> :t
ERROR - Syntax error in expression (unexpected end of input)
Main> :t mysum
mysum :: Num a => [a] -> a
Main> 

Main> mysum [1,2,3,4,5]
15
Main> mysum [4,5,2,6,8]
25
Main> mysum []
0

>	myproduct [] = 1
>	myproduct (x:xs) = x * myproduct xs

Main> :t myproduct
myproduct :: Num a => [a] -> a

Main> myproduct []
1
Main> myproduct [1,2]
2
Main> myproduct [1,2,3]
6
Main> myproduct [1,2,3,4]
24
 
>	factorial x = product [1..x]

Main> :t factorial
factorial :: (Num a, Enum a) => a -> a

Main> factorial 10
3628800
Main> factorial 12
479001600
Main> factorial 5
120

>	myOr True _  = True
>	myOr False False = False
>	myOr _ True = True

Main> :t myOr
myOr :: Bool -> Bool -> Bool

Main> myOr True True
True
Main> myOr True False
True
Main> myOr False True
True
Main> myOr False False
False


>	myAnd True True = True
>	myAnd _ False = False
>	myAnd True _ = False
>	myAnd False _ = False

Main> :t myAnd
myAnd :: Bool -> Bool -> Bool

Main> myAnd True True
True
Main> myAnd True False
False
Main> myAnd False True
False
Main> myAnd False False
False

>	mytake 0 _ = []
>	mytake n (x:xs) = x:mytake (n-1) xs


