-- Assignment 4 -- Kurt Medley
-- I have completed all of the reading from LYAH and CRFP and all of the assignments from CRFP. I now have a sufficient understanding of polymorphic algebraic data types and how to write functions over these data structures.  I am still a little iffy coercing types of my own data structures but will revisit this next week.
--
numEqual :: Eq a => [a] -> a -> Bool
numEqual [] n = False
numEqual (x:xs) n
	|n == x		= True
	|otherwise	= numEqual xs n

oneLookupFirst :: Eq a => [(a,b)] -> a -> b
oneLookupFirst (x:xs) n
	|n == fst x	= snd x
	|otherwise	= oneLookupFirst xs n

iSort :: Ord a => [a] -> [a]
iSort [] = []
iSort (x:y:xs)
	| x < y		= x:y:iSort xs
	| otherwise	= y: iSort xs ++ [x]

quickSort :: [Integer] -> [Integer]
quickSort [] = []
quickSort (x:xs) = quickSort small ++ [x] ++ quickSort big
	where small = [ a | a <- xs, a <= x ]
              big   = [ b | b <- xs, b > x  ]

dup :: Eq a => [a] -> [a]
dup [] = []
dup (x:xs) = x : dup (filter (\y -> not(x==y)) xs)

filt :: (a -> Bool) -> [a] -> [a]
filt p [] = []
filt p (x:xs)
	|p x		= x : filt p xs
	|otherwise	= filt p xs 

data Configuration = Configuration { username     :: String,
  localhost    :: String,
  remotehost   :: String,
  isguest      :: Bool,
  issuperguest :: Bool,
  currentdir   :: String,
  homedir      :: String,
  timeconnected:: Integer }


eitherExample :: Int -> Either Int String
eitherExample a | even a = Left (a `div` 2)
		| a `mod` 3 == 0 = Right "three"
		| otherwise = Right "Neither two nor three"

-- Textbook Exercises
-- Do the exercise questions 1,2,3 posed on the Hutton slides for Chapter 10.
-- In CRFP do exercises 14.4, 14.5, 14.6, 14.8, 14.10, 14.13, 14.15 on simple integer expression trees. Be sure your evaluator handles divide by zero exceptions somehow.
-- CFRP exercises 14.19, 14.20 on the Either type.
-- CFRP exercises 14.23, 14.25, 14.26, 14.27 on the Maybe type. 

data NTree = NilT | Node Integer NTree NTree
	deriving (Show, Eq)

-- where NTree is a Type constructor and Node t1..tn is a value constructor.
-- 14.2 Recursive algebraic types

data Expr = Lit Integer | Add Expr Expr | Sub Expr Expr | Mul Expr Expr | Div Expr Expr
	deriving (Show, Eq)

eval :: Expr -> Integer
eval (Lit n) = n
eval (Add e1 e2) = (eval e1) + (eval e2)
eval (Sub e1 e2) = (eval e1) - (eval e2)
eval (Mul e1 e2) = (eval e1) * (eval e2)
eval (Div e1 e2) = (eval e1) `div` (eval e2)

show1 :: Expr -> String
show1 (Lit n) = show n
show1 (Add e1 e2) = "(" ++ show e1 ++ "+" ++ show e2 ++ ")"
show1 (Sub e1 e2) = "(" ++ show e1 ++ "-" ++ show e2 ++ ")"

-- finding the sum and depth of a tree.

sumTree NilT = 0
sumTree (Node n t1 t2) = n + sumTree t1 + sumTree t2

depth NilT = 0
depth (Node n t1 t2) = 1 + max (depth t1) (depth t2)

-- finding how many times p occurs

occurs :: NTree -> Integer -> Integer
occurs NilT p = 0
occurs (Node n t1 t2) p
	| p == n	= 1 + occurs t1 p + occurs t2 p -- first node (+1) + nodes down t1 and t2
	| otherwise	=     occurs t1 p + occurs t2 p -- p /= first node, traverse t1 and t2

assoc :: Expr -> Expr
assoc (Add (Add e1 e2) e3) = assoc (Add e1 (Add e2 e3))

--14.4
size' :: Expr -> Integer
size' (Lit n) = 0
size' (Add e1 e2) = 1 + size' e1 + size' e2
size' (Sub e1 e2) = 1 + size' e1 + size' e2

--14.5
--I have added Mul Expr Expr & Div Expr Expr to my type constructor, Expr, which uses the div prelude function to handle cases of division by 0 in eval (Div e1 e2) = (eval e1) `div` (eval e2)
--Main> eval (Div (Lit 4) (Lit 0))
--Exception: divide by zero

--14.6
data Exp = Lit' Integer | Op Ops Exp Exp
	deriving (Show, Eq)

data Ops = Add' | Sub' | Mul' | Div' | Mod' 
	deriving (Show, Ord, Eq)
eval' :: Exp -> Integer
eval' (Lit' n) = n
eval' (Op Add' e1 e2) = (eval' e1) + (eval' e2)
eval' (Op Sub' e1 e2) = (eval' e1) - (eval' e2)
eval' (Op Mul' e1 e2) = (eval' e1) * (eval' e2)
eval' (Op Div' e1 e2) = (eval' e1) `div` (eval' e2)
eval' (Op Mod' e1 e2) = (eval' e1) `mod` (eval' e2) 

sh :: Exp -> String
sh (Lit' n) = show n
sh (Op Add' e1 e2) = "[ " ++ show e1 ++ " + " ++ show e2 ++ " ]"
-- etc etc

si :: Exp -> Integer
si (Lit' n) = 0
si (Op Add' e1 e2) = 1 + si e1 + si e2
-- etc etc

-- Following the new data type Ops, the only benefit appears to be shortening the definition of data type Exp.  As the value constructor Op must be added as a prefix before the actual operation is pattern matched within the definition of a particular function.

--14.8 infix operators
data E = L Integer | E :+: E | E :-: E | E :*: E | E :/: E | E :#: E
	deriving (Show, Eq)
-- I have defined E :#: E to mean E mod E
ev :: E -> Integer
ev (L n) = n
ev (e1 :+: e2) = (ev e1) + (ev e2)
ev (e1 :-: e2) = (ev e1) - (ev e2)
ev (e1 :*: e2) = (ev e1) * (ev e2)
ev (e1 :/: e2) = (ev e1) `div` (ev e2)
ev (e1 :#: e2) = (ev e1) `mod` (ev e2)

s :: E -> String
s (L n) = show n
s (e1 :+: e2) = "[" ++ show e1 ++ "+" ++ show e2 ++ "]"
-- etc etc

sz :: E -> Integer
sz (L n) = 0
sz (e1 :+: e2) = 1 + sz e1 + sz e2
-- etc etc

--14.10 Define a function to decide whether a number is an element of an NTree
mem :: Integer -> NTree -> Bool
mem p NilT = False
mem p (Node n lb rb)
	|p == n		= True
	|otherwise	= mem p lb || mem p rb

--14.13

trees = [ NilT,
	  Node 4 NilT NilT,
	  Node 2 (Node 4 NilT NilT) NilT,
	  Node 3 (Node 6 (Node 7 NilT NilT) NilT) NilT,
	  Node 8 (Node 4 (Node 2 (Node 1 NilT NilT) NilT) NilT) NilT,
	  Node 5 (Node 3 (Node 2 (Node 9 (Node 8 NilT NilT) NilT) NilT) NilT) NilT ]

collapse :: NTree -> [Integer]

collapse NilT = []
collapse (Node n lb rb) = n : collapse lb ++ collapse rb

sort :: NTree -> [Integer]
sort NilT = []
sort (Node n lb rb) = quickSort listofnodes
	where listofnodes = collapse (Node n lb rb)

data Tree' a = NilT' | Node' a (Tree' a) (Tree' a)
	deriving (Eq, Show)

treetolist NilT' = []
treetolist (Node' x lb rb) = x: treetolist lb ++ treetolist rb

--sorttreelist :: Num a => Tree' a -> [Integer]
sorttreelist NilT' = []
sorttreelist tree = quickSort $ treetolist tree

--14.15
data Ex = Lt Integer | Opr Ops Ex Ex | If BExp Ex Ex
	deriving (Show, Ord, Eq)
data BExp = BoolLit Bool | And BExp BExp | Not BExp | Equal Ex Ex | Greater Ex Ex
	deriving (Show, Ord, Eq)

eva :: Ex -> Integer
eva (Lt n) = n
eva (Opr Add' e1 e2) = (eva e1) + (eva e2)
eva (Opr Sub' e1 e2) = (eva e1) - (eva e2)
eva (Opr Mul' e1 e2) = (eva e1) * (eva e2)
eva (Opr Div' e1 e2) = (eva e1) `div` (eva e2)
eva (Opr Mod' e1 e2) = (eva e1) `mod` (eva e2)

bEval :: BExp -> Bool
bEval (BoolLit n) = n
bEval (And b1 b2) = b1 == b2
bEval (Not (BoolLit n)) = not n
bEval (Equal e1 e2) = e1 == e2
bEval (Greater e1 e2) = e1 > e2

ifEx :: Ex -> Ex
ifEx (If b e1 e2)
	|bEval b	= e1
	|otherwise	= e2

-- *Main> eva $ ifEx (If (BoolLit True) (Opr Add' (Lt 4) (Lt 3)) (Lt 3))
-- 7
-- ifEx (If expression) takes a predicate expression like just the boolean literal True | False or something like " bEval (Greater e1 e2) " which is equivalent to e1 > e2, and then returns e1 if the predicate is bEval'd as True.  "eva $" actually returns the integer value of the expression returned by the if expression.

--14.19,14.20
data Pairs a = Pr a a

equalPair :: Eq a => Pairs a -> Bool
equalPair (Pr x y) = x == y

--Binary Trees and Polymorphic Algebraic Data types..
data Tree a = Nil | Vertex a (Tree a) (Tree a)
	deriving (Eq,Ord,Show,Read)

dep :: Tree a -> Integer
dep Nil			= 0
dep (Vertex n t1 t2)	= 1 + max (dep t1) (dep t2)

col :: Tree a -> [a]
col Nil	= []
col (Vertex n t1 t2) = col t1 ++ [n] ++ col t2

mtree :: (a -> b) -> Tree a -> Tree b
mtree f Nil		= Nil
mtree f (Vertex n t1 t2) = Vertex (f n) (mtree f t1) (mtree f t2)

isLeft :: Either a b -> Bool
isLeft (Left _) = True
isLeft (Right _) = False

either' :: (a->c)->(b->c)-> Either a b -> c
either' f g (Left x) = f x
either' f g (Right y) = g y

--14.19
mapL :: (a -> b) -> (a -> Either b c)
mapL f x = Left (f x)

mapR :: (a -> b) -> (a -> Either c b)
mapR f x = Right (f x)

--14.20
join :: (a -> c) -> (b -> d) -> Either a b -> Either c d
join f g (Left x) = Left (f x)
join f g (Right x) = Right (g x)

mapMaybe g Nothing = Nothing
mapMaybe g (Just x) = Just (g x)

--14.23
process xs n m
	| n < 0 || m < 0 || n >= length xs || m >= length xs = Nothing
	|otherwise = Just (xs!!n + xs!!m)

--14.25
squashMaybe :: Maybe (Maybe a) -> Maybe a
squashMaybe Nothing = Nothing
squashMaybe (Just (Nothing)) = Nothing
squashMaybe (Just (Just x)) = Just x

--14.26
composeMaybe :: (a -> Maybe b) -> (b -> Maybe c) -> (a -> Maybe c)
composeMaybe f g x = case (f x) of
			Just y -> g y
			Nothing -> Nothing

--14.27
data Err a = OK a | Error String
	deriving (Eq,Ord,Show,Read)

--mapM' :: (a -> b) -> Err a -> Err b
mapM' f (OK x)
	| x <= 0 	= Error "DAR!"
	| otherwise	= OK (f x)

may :: b -> (a -> b) -> Maybe a -> b
may n f Nothing	= n
may n f (Just x) = f x

