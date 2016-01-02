Assignment 5 -- Kurt Medley

> import Control.Monad.Instances
> import Control.Monad

Recode your evaluator from Assignment 3 part 4b using Monad instead of Applicative. This is the evaluator that just bails with error instead of using the Maybe type and propogating Nothing. You can use the do notation and you may actually find this easier than the original Applicative version. 

> data Exp = Var String | Val Int | Add Exp Exp deriving (Show,Eq,Ord)

> type Env = [(String, Int)]

> fetch :: String -> Env -> Int
> fetch s (x:xs)
>	| s == fst x	= snd x
>	| otherwise	= fetch s xs
> fetch s [] = error "Variable does not exist within environment"

>-- Test environments
> env1 :: Env
> env1 = [("a",1),("b",2),("c",3),("d",4),("e",5)]
> env2 :: Env
> env2 = [("a",40),("b",32),("c",561)]

> evalM :: Exp -> Env -> Int
> evalM (Val i) = return i
> evalM (Var s) = fetch s
> evalM (Add p q) = do
>	a <- evalM p
>	b <- evalM q
>	return (a+b)

Recode your evaluator of step 1 using the Reader Monad in the Control.Monad library. 

> class Functor f => Applicative f where
>	pure  :: a -> f a
>	(<*>) :: f (a -> b) -> f a -> f b

> (<$>) :: Applicative f => (a -> b) -> f a -> f b
> g <$> x = fmap g x

> instance Applicative ((->) r) where
>	pure g = (\x -> g)
>	g <*> h = (\x -> g x (h x))


> evalRM :: Exp -> Env -> Int
> evalRM (Val i) = return i
> evalRM (Var s) = fetch s
> evalRM (Add p q) = (+) `liftM` (evalRM p) `ap` (evalRM q) 

 Now take your evaluator from step 1 and combine the ((->) r) Reader Monad with the Maybe functor for values and code the evaluator so that it propogates Nothing on errors. This is the Monadic version of the evaluator from Assignment 3 part 5c. 

> evalMM :: Exp -> Env -> Maybe Int
> evalMM (Val i) env = return i
> evalMM (Var s) env = lookup s env
> evalMM (Add p q) env = (+) `liftM` (evalMM p env) `ap` (evalMM q env)

Finally, use the Monad Transformer library (mtl) to recode your Reader+Maybe evaluator. See if this is a more elegant solution to the previous step.

> eval :: Exp -> Env -> Maybe Int
> eval (Val i) env = return i
> eval (Var s) env = lookup s env
> eval (Add p q) env = do
>	a <- eval p env
>	b <- eval q env
>	return (a+b)

> data Expr = Val' Int 
>	    | Var' String 
>	    | BinOp (Int -> Int -> Int) Expr Expr

> evalA :: Expr -> Env -> Int
> evalA (Val' i) = pure i
> evalA (Var' s) = fetch s
> evalA (BinOp op e1 e2) = op <$> evalA e1 <*> evalA e2

> evalM' :: Expr -> Env -> Int
> evalM' (Val' i) = return i
> evalM' (Var' s) = fetch s
> evalM' (BinOp op e1 e2) = do
>	a <- evalM' e1
>	b <- evalM' e2
> 	return (a `op` b)

> newtype EnvEither a b c = S (a -> Either b c)

>-- instance Functor (EnvEither b c) where
>--	fmap g (S h) = S (\x -> case (h x) of Left x -> Left x
>--					      Right x -> Right (g x))

> instance Functor (EnvEither b c) where
> 	fmap g (S h) = S (\x -> fmap (g.h) x)
