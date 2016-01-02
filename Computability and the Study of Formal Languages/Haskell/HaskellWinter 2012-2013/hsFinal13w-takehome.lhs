-- hsFinal13w-takehome.lhs
-- Individual Work Only


-- Posfix calculator and Monadic postfix calculator

------------------------------------------------------------------------------
-- Fill in the missing code definitions for the two evaluators and calculators.
-- Make sure all the tests give correct answers.
-- Do not change the tests. (But you may add your own tests).
--
-- Due Friday March 8th at 3pm by cnc_submit. Submit with this same filename.
------------------------------------------------------------------------------

-- Runs in two phases - a parsePf phase that produces an
-- internal representation of a postfix expression and then
-- an evalPf phase that evaluates the postfix expression
-- produced by the parsePf. Uses a Stack module.


-- The Stack module is available on the Final Exam Exercises page for your use.
-- Do not change the Stack module signature.
-- Using the Stack module is optional, but if you don't use it then you
-- must at least supply a Stack type and a makeStack function.

> import Data.Char
> import Stack

------------------------------------------------------------------------------
-- Stack ADT signature

-- makeStack :: Stack t
-- push      :: t -> Stack t -> Stack t
-- top       :: Stack t -> t
-- pop       :: Stack t -> Stack t
-- isEmpty   :: Stack t -> Bool
-----------------------------------------------------------------------------
The internal representation of a postfix expression

> data IntOrOp 	= Dat Int | Op Aop deriving (Read, Show, Eq)
> data Aop	= Add | Sub deriving (Read, Show, Eq)

> type PfExpr = [IntOrOp]

-- A postfix expression parser

> parsePf :: String -> PfExpr
> parsePf "" = []
> parsePf (c:cs) | isSpace c	= parsePf (dropWhile isSpace cs)
> parsePf ('+':cs)		= Op Add : parsePf cs
> parsePf ('-':cs)		= Op Sub : parsePf cs
> parsePf s@(c:cs) | isDigit c	= Dat (read lexeme) : parsePf cs'
>	where (lexeme, cs')	= span isDigit s
> parsePf _			= error "parsePf: invalid postfix expression"

-- A postfix expression evaluator

> evalPf :: PfExpr -> (Stack Int) -> Int
> evalPf [] st	= if (isEmpty (pop st)) then top st
>				     	else error "Malformed PF expression"
> evalPf ((Dat n): p) st = evalPf p $ push n st
> evalPf ((Op op): p) st = case op of
>			Add -> evalPf p $ push addRes $ pop $ pop st
>				where addRes = applyOp Add (top newtop1) (top st)
>				      newtop1 = pop st
>			Sub -> evalPf p $ push subRes $ pop $ pop st
>				where subRes = applyOp Sub (top newtop2) (top st)
>				      newtop2 = pop st

> pfEven :: PfExpr -> Bool
> pfEven pf
>	| length pf `mod` 2 == 0	= True
>	| otherwise			= False

> applyOp :: Aop -> Int -> Int -> Int
> applyOp Add = (+)
> applyOp Sub = (-)

> -- Running the postfix evaluator
> calcPf :: String -> Int
> calcPf s = evalPf (parsePf s) makeStack

------------------------------------------------------------------------------
-- A simple Monadic postfix expression evaluator
------------------------------------------------------------------------------

> newtype State env a = ST { runState :: (env -> (a,env)) }
>
> -- Functor instance
> instance Functor (State env) where
>   fmap f (ST s) = ST $ \env -> let (x, env') = s env   -- s :: env -> (a,env)
>                                in  (f x, env')
>
> -- Monad instance
> instance Monad (State env) where
>   ST s >>= g    = ST $ \env -> let (x, env') = s env
>                                    (ST h) = g x
>                                in h env'
>   return g = ST $ \env -> (g, env)

> evalPfM :: PfExpr -> (State (Stack Int) Int)
> evalPfM [] = do 
>	a <- popM
>	stack <- get
>	if (not $ isEmpty stack) then error "Malformed PF Expression"
>			   	 else return a

> evalPfM ((Dat n):p) = do
>	pushM n
>	evalPfM p

> evalPfM ((Op op):p) = do
>	stack <- get
>	let addRes = applyOp Add (top $ pop stack) (top stack)
>	let subRes = applyOp Sub (top $ pop stack) (top stack)
>	if (op == Add) then do popM
>			       popM
>			       pushM addRes
>			       evalPfM p
>		       else do popM
>			       popM
>			       pushM subRes
>			       evalPfM p 			       

> stacktest = do
>	st <- get
>	put st

> r = runState
> m = makeStack

> popM :: State (Stack Int) Int
> popM = do
>	st <- get
>	put $ pop st
>	return $ top st

> isEmptytest = do
>	st <- get
>	return (isEmpty st)

> pushM :: Int -> State (Stack Int) ()
> pushM x = do
>	st <- get
>	put (push x st)

> get = ST $ \s -> (s, s)
> put newState = ST $ \s -> ((), newState)

>-- Running the Monadic postfix evaluator
> calcPfM :: String -> Int
> calcPfM s = fst $ r (evalPfM (parsePf s)) m

------------------------------------------------------------------------------
-- A simple interactive postfix calculator using an imperative style IO.
------------------------------------------------------------------------------

> main :: IO ()
> main = do putStr "Enter a postfix expression (q to quit): "
>           l <- getLine
>           if l == [] || (head l) == 'q'
>             then return ()
>             else do
>                     putStr "The Answer is: "
>                     print (calcPf l)
>                     main

------------------------------------------------------------------------------
-- Testing
------------------------------------------------------------------------------

> -- Parset tests
> tp1 = parsePf "38 4 +"
> tp2 = parsePf "3 43 + 5 -"
> tp3 = parsePf "37 4 5 + -"
> tp4 = parsePf "3 4 50+-"
> tp5 = parsePf "3 4 52+- "
> tp6 = parsePf "19 27 13 +"
> tp7 = parsePf "17 +"

> -- Postfix evaluator tests
> te1 = evalPf [Dat 38, Dat 4, Op Add] makeStack
> te2 = evalPf [Dat 3, Dat 43, Op Add, Dat 5, Op Sub] makeStack
> te3 = evalPf [Dat 37, Dat 4, Dat 5, Op Add, Op Sub] makeStack
> te4 = evalPf [Dat 398] makeStack

> -- Postfix calculator tests
> t1 = calcPf "38 4 +"
> t2 = calcPf "3 43 + 5 -"
> t3 = calcPf "37 4 5 + -"
> t4 = calcPf "398"
>
> -- Should fail with appropriate message
> t5 = calcPf " 56  398 "
> t6 = calcPf "19 27 13 +"
> t7 = calcPf "17 +"

> -- Monadic postfix evaluator tests
> tem1 = fst $ runState (evalPfM [Dat 38, Dat 4, Op Add]) makeStack
> tem2 = fst $ runState (evalPfM [Dat 3, Dat 43, Op Add, Dat 5, Op Sub]) makeStack
> tem3 = fst $ runState (evalPfM [Dat 37, Dat 4, Dat 5, Op Add, Op Sub]) makeStack
> tem4 = fst $ runState (evalPfM [Dat 398]) makeStack

> -- Monadic postfix calculator tests
> tm1 = calcPfM "38 4 +"
> tm2 = calcPfM "3 43 + 5 -"
> tm3 = calcPfM "37 4 5 + -"
> tm4 = calcPfM "398"

> -- Should fail with appropriate message
> tm5 = calcPfM " 56  398 "
> tm6 = calcPfM "19 27 13 +"
> tm7 = calcPfM "17 +"


> -- Comparison tests
> testalleval = [te1,te2,te3,te4]
> testallevalM = [tem1,tem2,tem3,tem4]
> okeval = testalleval == testallevalM
>
> testallCalc = [t1,t2,t3,t4]
> testallCalcM = [tm1,tm2,tm3,tm4]
> okcalc = testallCalc == testallCalcM 
