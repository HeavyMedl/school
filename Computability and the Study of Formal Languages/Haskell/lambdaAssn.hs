type Var = String

data Constant = Plus
		| Minus
		| Times
		| Div
		| BTrue
		| BFalse
		| Num Int
	deriving (Show, Eq)

data Exp = Lam Var Exp
	 | App Exp Exp
	 | Var Var
	 | Cons Constant
	deriving (Show, Eq)

-- fv(exp) returns free vars

fv :: Exp -> [Var]

fv (Lam v e) = setdiff (fv e) [v]
fv (App e1 e2) = un (fv e1) (fv e2)
fv (Var v) = [v]

------------------------------------
-- setdiff and un
------------------------------------
setdiff [] _ = []
setdiff x [] = x
setdiff (x:xs) ys
	| elem x ys	= setdiff xs ys
	| otherwise	= x:(setdiff xs ys)

un x [] = x
un [] x = x
un (x:xs) ys
	| elem x ys	= un xs ys
	| otherwise	= x:(un xs ys)
-------------------------------------

fresh vars = minimum vars ++ "'"

-- do beta substitution
-- sub m x e: sub m for x in e

sub m (Var x) (Cons c)	= (Cons c)
sub m (Var x) (Var v)
	| x == v	= m
	| x /= v	= (Var v)
sub m (Var x) (App e1 e2)	= (App (sub m (Var x) e1) (sub m (Var x) e2))

sub m (Var x) (Lam v e)
	| x == v			= (Lam v e)
	| notElem x (fv e)
		|| notElem v (fv m)	= (Lam v (sub m (Var x) e))

	| otherwise			= (Lam z (sub m (Var x) (sub (Var z) (Var v) e )))
		where
		  z = fresh (un (fv m) (fv e))

-- Beta Reduction

reduce (Cons c) = (Cons c)
reduce (Var x) = (Var x)
reduce (App (Lam v e) e2) = sub e2 (Var v) e
reduce (App e1 e2) = App (reduce e1) (reduce e2)
reduce (Lam v e) = Lam v (reduce e)


-- Church Numerals

one = Lam "f" (Lam "x" (App (Var "f") (Var "x")))
two = Lam "f" (Lam "x" (App (Var "f") (App (Var "f") (Var "x"))))
three = Lam "f" (Lam "x" (App (Var "f") (App (Var "f") (App (Var "f") (Var "x")))))
four = Lam "f" (Lam "x" (App (Var "f") (App (Var "f") (App (Var "f") (App (Var "f") (Var "x"))))))


add = Lam "n" (Lam "m" (Lam "f" (Lam "x" (App (App (Var "n") (Var "f")) 
			(App (App (Var "m") (Var "f"))
	                     (Var "x"))))))

add34 = App (App add three) four

-- App (App (Lam "n" (Lam "m" (Lam "f" (Lam "x" (App (App (Var "n") (Var "f")) (App (App (Var "m") (Var "f")) (Var "x"))))))) (Lam "f" (Lam "x" (App (Var "f") (App (Var "f") (App (Var "f") (Var "x"))))))) (Lam "f" (Lam "x" (App (Var "f") (App (Var "f") (App (Var "f") (App (Var "f") (Var "x")))))))

-- reduces to

-- *Main> reduce $ reduce $ reduce $ reduce $ reduce add34
-- Lam "f" (Lam "x" (App (Var "f") (App (Var "f") (App (Var "f") (App (Var "f") (App (Var "f") (App (Var "f") (App (Var "f") (Var "x")))))))))

-- church numeral for 7 \f.\x.f (f (f (f (f (f (f x))))))

suc = App add one

-- delta rules
delta (App (App (Cons Plus) (Cons (Num a))) (Cons (Num b))) = a + b
t1 = delta (App (App (Cons Plus) (Cons (Num 4))) (Cons (Num 5)))

-- if-then-else = \p.\a.\b.p a b
-- *Main> :t (\p a b -> if (p a) then a else b)

ifthenelse = Lam "p" ( Lam "a" (Lam "b" (App (App (Var "p") (Var "a")) (Var "b"))))

b_reduce (App (Lam x t1) t2) 	= return (sub t2 (Var x) t1)
b_reduce _			= Nothing

outer :: Exp -> Maybe Exp
outer (Cons x)	= Nothing
outer (Var x) 	= Nothing
outer (Lam x e) = case (outer e) of
			Nothing -> Nothing
			Just e' -> return (Lam x e')
outer t@(App t1 t2) = case (b_reduce t) of
			Nothing -> case (outer t1) of
				Nothing -> Nothing
				Just t1' -> return (App t1' t2)
			Just t' -> Just t'

inner :: Exp -> Maybe Exp
inner (Cons x)	= Nothing
inner (Var x)	= Nothing
inner (Lam x e) = case (inner e) of
			Nothing -> Nothing
			Just e' -> return (Lam x e')
inner t@(App t1 t2) = case (inner t1) of
			Nothing -> case (inner t2) of
				Nothing  -> b_reduce t
				Just t2' -> return (App t1 t2')
			Just t1' -> return (App t1' t2)

reduce_all strat t = case (strat t) of
			Nothing -> t
			Just t' -> reduce_all strat t'

{-- Church pairs are the Church encoding of the pair (two-tuple) type. The pair is represented as a function that takes a function argument. When given its argument it will apply the argument to the two components of the pair. --}

true = Lam "x" (Lam "y" (Var "x"))
false = Lam "x" (Lam "y" (Var "y"))

pair = Lam "x" ( Lam "y" ( Lam "z" (App (App (Var "z") (Var "x")) (App (Var "z") (Var "y")))))
nil  = App (App pair true) true
fstl = Lam "p" ( App (Var "p") (Lam "x" (Lam "y" (Var "x"))))
sndl = Lam "p" ( App (Var "p") (Lam "x" (Lam "y" (Var "y"))))
cons = Lam "h" ( Lam "t" ( App pair (App (App pair (Var "h")) (Var "t"))))
headl= Lam "z" ( App fstl ( App sndl (Var "z")))
taill= Lam "z" ( App sndl ( App sndl (Var "z")))
isnil= fstl

r = reduce_all outer

zipL l1 l2 = if (r $ App isnil l1) == true || (r $ App isnil l2) == true then (r $ nil)
		else r $ App (App cons (App pair (App (App headl l1) (App headl l2)))) 
			(zipL (App taill l1) (App taill l2))

list1 = App (App cons one) nil
list2 = zipL list1 list2

zip' :: [a] -> [b] -> [(a,b)]
zip' xs [] = []
zip' [] ys = []
zip' (x:xs) (y:ys) = (x,y) : zip' xs ys
