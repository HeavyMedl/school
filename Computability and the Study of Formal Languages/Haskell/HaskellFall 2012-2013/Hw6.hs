-- Assignment 6 -- Kurt Medley
-- In CRFP do exercises 17.2, 17.4, 17.10, 17.11, 17.12, 17.14, 17.17, 17.18, 17.22, 17.23, 17.26, 17.27, 17.29, 17.30

{-- Lazy evaluation - an argument which is not needed will not be evaluated.  Like in the case of f x y = x + 12 where f (9-3) (f 32 5) ~ f (6) (f 32 5) ~ 6 + 12 ~ 18.  Y is not calculated into the result --} 
import Data.List
import Data.Char

switch :: Integer -> a -> a -> a
switch n x y
	|n > 0		= x -- restriction n.  If n > 0 return x ie (a -> a), Int, etc.
	|otherwise	= y -- else y ie (a -> a), Int, etc.

--17.2 define subLists,subSequences :: [a] -> [[a]]

subLists :: [a] -> [[a]]
subLists [] = [[]]
subLists (x:xs) = [ x:ss | ss <- subLists xs ] ++ subLists xs

subSequences :: [a] -> [[a]]
subSequences [] = [[]]
subSequences xs = [ s | i <- inits xs, s <- tails i, not $ null s  ]
-- inits: returns the list of initial segments of its argument list, shortest first
-- inits [1,3,5] ~ [[],[1],[1,3],[1,3,5]]
-- tails:  returns the list of initial segments of its argument list, shortest last 
-- tails [1,3,5] ~ [[1,3,5],[3,5],[5],[]]

--17.4 Give a definition of scalarProduct using zipWith

type Vector = [Float]

scalarProduct :: Vector -> Vector -> Float
scalarProduct xs ys = sum [ x*y | (x,y) <- zip xs ys ]

scalarProduct' :: Vector -> Vector -> Float
scalarProduct' xs ys = sum (zipWith (*) xs ys)

maxlist :: [Int] -> Int
maxlist xs = foldr (\x acc -> if x > acc then x else acc) 0 xs

-- Basic Parser functions
--infixr 5 >*>

type Parser a b = [a] -> [(b,[a])]

--A parser that always fails, so accepts nothing.
none :: Parser a b 
none inp = []

--A parser that succeeds immediately, without reading any input.
succeed :: b -> Parser a b
succeed val inp = [(val,inp)]

--A parser to recognize a single object or token, t, say.
token :: Eq a => a -> Parser a a
token t (x:xs)
	|t==x		= [(t,xs)]
	|otherwise	= []
token t []		= []

--Spot objects with a particular property
spot :: (a -> Bool) -> Parser a a
spot p (x:xs)
	| p x		= [(x,xs)]
	| otherwise	= []
spot p []		= []

--Recognizing a bracket token '('
bracket = token '('

--Recognizing a digit
dig = spot isDigit

--Combining parsers
alt :: Parser a b -> Parser a b -> Parser a b
alt p1 p2 inp = p1 inp ++ p2 inp

infixr 5 >*>
(>*>) :: Parser a b -> Parser a c -> Parser a (b, c)

(>*>) p1 p2 inp = [((y,z),rem2) | (y,rem1) <- p1 inp, (z,rem2) <- p2 rem1 ]

build :: Parser a b -> (b -> c) -> Parser a c
build p f inp = [ (f x, rem) | (x,rem) <- p inp ]

list :: Parser a b -> Parser a [b]
list p = (succeed []) `alt` ((p >*> list p) `build` (uncurry (:)))

--17.10
neList :: Parser a b -> Parser a [b]
neList p = (p `build` (:[])) `alt` ((p >*> list p) `build` (uncurry (:)))

optional :: Parser a b -> Parser a [b]
optional p input
 = let res = p input
   in case res of [] 	     -> [([],input)]
		  (x, res):_ -> [([x], res)]

--17.11
nTimes :: Integer -> Parser a b -> Parser a [b]
nTimes 0 p	= succeed []
nTimes n p	= (p >*> nTimes (n+1) p) `build` (uncurry (:))

{--
parser :: Parser Char Expr
parser = litParse `alt` varParse `alt` opExpParse

varParse :: Parser Char Expr
varParse = spot isVar `build` Var

isVar :: Char -> Bool
isVar x = ('a' <= x && x <= 'z')

opExpParse = (token '(' >*>
	      parser	>*>
	      spot isOp >*>
	      parser	>*>
	      token ')')
	      build` makeExpr

makeExpr (_, (e1, (bop, (e2,_) )  ) ) = Op (charToOp bop) e1 e2 
--}
data Expr = Lit Integer | Var  | Op Ops Expr Expr deriving (Eq,Read)
data Ops = Add | Sub | Mul | Div | Mod deriving (Eq,Read)

instance Show Expr where
	show (Lit n) 		= show n
	show (Op Add e1 e2) 	= "(" ++ show e1 ++ "+" ++ show e2 ++ ")" 
	show (Op Sub e1 e2)	= "(" ++ show e1 ++ "-" ++ show e2 ++ ")"
	show (Op Mul e1 e2)	= "(" ++ show e1 ++ "*" ++ show e2 ++ ")"
	show (Op Div e1 e2)	= "(" ++ show e1 ++ "/" ++ show e2 ++ ")"
	show (Op Mod e1 e2)	= "(" ++ show e1 ++ "%" ++ show e2 ++ ")"

-- 17.12
isOp :: Char -> Bool
isOp o | o == '+' || o == '-' || o == '/' || o == '*' || o == '%' = True
       | otherwise = False

charToOp :: Char -> Ops
charToOp ch = case ch of 
		'+' -> Add
		'-' -> Sub
		'*' -> Mul
		'/' -> Div
		'%' -> Mod
-- 17.14
charlistToExpr :: [Char] -> Expr
charlistToExpr (x:xs)
	| x == '~'	= Lit (negate(read xs :: Integer))
	| otherwise	= Lit (read (x:xs) :: Integer)

--17.17
-- I would change my Var constructor from Char to String and delimit an expression by a variable declaration and its following whitespace

--17.18
-- spot isSpace >*> parser from the Data.Char library.

--17.22 

spotWhile :: (a -> Bool) -> Parser a [a]
spotWhile p (x:xs)
	| p x == False 	= [([],(x:xs))]
	| otherwise	= [(takeWhile p (x:xs), dropWhile p (x:xs))]
spotWhile p [] 		= []

--17.23 INFINITE LISTS
-- Define the infinite lists of faactorial and Fibonacci numbers,
-- factorial = [1,1,2,6,24,120,720,..]
-- fibonacci = [0,1,1,2,3,5,8,13,21..]

fac 0 = 1
fac n = n * fac (n-1)

facLs = [ fac x | x <- [0..] ]

fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

--17.26
infiniteProduct :: [a] -> [b] -> [c] -> [(a,b,c)]
infiniteProduct (x:xs) (y:ys) (z:zs) = (x,y,z): infiniteProduct xs ys zs

pythagTriples = [ (x,y,z) | z <- [2 .. ], y <- [2 .. z-1], x <- [2 .. y-1],
			    x*x + y*y == z*z ]

pythagTriples2 = [ (x,y,z) | (x,y,z) <- infiniteProduct [2..] [3..] [4..], x*x + y*y == z*z ]

--17.27
--Give a definition of the list [ 2^n | n <- [0 .. ] ] using scanl
scanl' :: (a -> b -> b) -> b -> [a] -> [b] 
scanl' f st iList = out
		    where
		    out = st : zipWith f iList out

pow2 = scanl' (^) 1 [2,2..]

pow2ls xs = zipWith (^) xs [2,2..]

--17.29
arbpow xs n = zipWith (^) xs [n,n..]

merge :: Num a => [a] -> [a] -> [a]
merge xs ys = nub (zipWith (^) xs [2,2..] ++ zipWith (^) ys [3,3..])

sortedMerge xs ys = quickSort $ merge xs ys

quickSort [] = []
quickSort (x:xs) = quickSort small ++ [x] ++ quickSort big 
		   where small 	= [ a | a <- xs, a <= x ]
	      		 big    = [ b | b <- xs, b > x ]

rd xs = foldr (\x acc -> if x == acc then acc else x) [] xs

--17.30
factors :: Int -> [Int]
factors n = [ x | x <- [1..n], n `mod` x == 0 ]

hamming :: [Integer]
hamming = 1:[ x | x <- [1..], x `mod` 2 == 0 || x `mod` 3 == 0 || x `mod` 5 == 0 ]

mergefh xs ys = quickSort $ nub (xs ++ ys)

