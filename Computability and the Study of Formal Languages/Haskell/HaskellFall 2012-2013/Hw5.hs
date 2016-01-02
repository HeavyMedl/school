-- Assignment 5 -- Kurt Medley
{-- I've decided to implement a partial abstract syntax of the Clite language using the nonterminals Assignment, Expression, Binary, Unary, Variable, Value, and Operator.  I will divide my functions for binary and unary expressions and try and splice them together to display expression statements.

November 13th - Update.  I'm unsure about how to implement a showAST function because I'm unsure about how to construct a binary tree to evaluate my expressions.  I have defined a general function show' that takes Assignment -> IO () for interpreting Binary and Unary expressions.  I have since realized that making making Expression an "instance of" show would have been a more efficient and readable solution.
--}
--Notes and Exercises on Modules
{--
module Types (Tree(Leaf,Node), Bit(L,R), HCode, Table) where

--Trees to represent the relative frequencies of characters and therefore the Huffman codes

data Tree = Leaf Char Int | Node Int Tree Tree

--The types of bits, Huffman codes and tables of Huffman codes.

data Bit = L | R deriving (Eq, Show)

type HCode = [Bit]

type Table = [ (Char, HCode) ]
--}

{--
module Coding ( codeMessage, decodeMessage ) where

import Types (Tree(Leaf,Node), Bit(L,R), HCode, Table)

--The purpose of this module is to define functions to code and decode messages.  We export only these.
codeMessage concats the list of L's and R's given by the defintion of a table
codeMessage :: Table -> [Char] -> HCode
codeMessage tbl = concat.map (lookupTable tbl)

--lookupTable takes a table of the form [(char,HCode)] and a char to look up and returns the HCode ie [L,L] if the parameterized c matches any of the chars given in the HCode.
lookupTable :: Table -> Char -> HCode
lookupTable [] c = error "lookupTable"
lookupTable ((ch,n):tb) c
	|ch == c        = n
	|otherwise      = lookupTable tb c

decodeMessage :: Tree -> HCode -> [Char]
decodeMessage tr
	= decodeByt tr
		where
	  decodeByt (Node n t1 t2) (L:rest)
	= decodeByt t1 rest
	  decodeByt (Node n t1 t2) (R:rest)
	= decodeByt t2 rest
	  decodeByt (Leaf c n) rest 
	= c : decodeByt tr rest
	  decodeByt t [] = []

exam1 = Node 0 (Leaf 'a' 0) (Node 0 (Leaf 'b' 0) (Leaf 't' 0))
mess1 = [R,L,L,R,R,R,R,L,R]
table1 = [('a',[L]),('b',[R,L]),('t',[R,R])]

*Coding> codeMessage table1 "battab"
[R,L,L,R,R,R,R,L,R,L]
--}

data Assignment = AV String Expression deriving (Eq,Show,Read)

data Expression = EV String | Value Integer | Binary BOps Expression Expression
		| Unary UOps Expression deriving (Eq,Show,Read)

data Binary = BO BOps Expression Expression deriving (Eq,Show,Read)

data Unary = UO UOps Expression deriving (Eq,Show,Read)

data BOps = Add | Sub | Mul | Div deriving (Eq,Show,Read)

data UOps = Negate deriving (Eq,Show,Read)

--evaluate expression value
--form: evalval (Value 5) = 5
evalval :: Expression -> Integer
evalval (Value n) = n
evalval (Binary Add e1 e2) = (evalval e1) + (evalval e2)
evalval (Binary Sub e1 e2) = (evalval e1) - (evalval e2)
evalval (Binary Mul e1 e2) = (evalval e1) * (evalval e2)
evalval (Binary Div e1 e2) = (evalval e1) `div` (evalval e2)
evalval (Unary Negate e)   = negate (evalval e)

show' :: Assignment -> IO ()
show' (AV v e) = putStrLn(show v ++ " = " ++ showB e)

{--	where binOp 
		|n == Add 	= show e1 ++ " + " ++ show e2 
		|n == Sub	= show e1 ++ " - " ++ show e2
		|n == Mul	= show e1 ++ " * " ++ show e2
		|n == Div	= show e1 ++ " / " ++ show e2 --}
showB :: Expression -> String
showB (Binary Add e1 e2) = show e1 ++ " + " ++ show e2
showB (Binary Sub e1 e2) = show e1 ++ " - " ++ show e2
showB (Binary Mul e1 e2) = show e1 ++ " * " ++ show e2
showB (Binary Div e1 e2) = show e1 ++ " / " ++ show e2

--evaluate binary expression value
--form: evalbin (BO Add (Value 3) (Value 2)) = 5
evalbin :: Binary -> Integer
evalbin (BO Add e1 e2) = (evalval e1) + (evalval e2)
evalbin (BO Sub e1 e2) = (evalval e1) - (evalval e2)
evalbin (BO Mul e1 e2) = (evalval e1) * (evalval e2)
evalbin (BO Div e1 e2) = (evalval e1) `div` (evalval e2)

--evaluate unary expression value
--form: evalun (UO Negate (Value 3)) = -3
evalun :: Unary -> Integer
evalun (UO Negate e) = negate (evalval e)

--show assignment variable
shAV :: Assignment -> IO ()
shAV (AV v e) = putStrLn (show v ++ " = " ++ " [ " ++ show e ++ " ] ")
--show expression variable
shEV :: Expression -> IO ()
shEV (EV s) = putStrLn (show s)
--show binary expression
shBE :: Binary -> IO ()
shBE (BO Add e1 e2) = putStrLn (" [ " ++ show e1 ++ " + " ++ show e2 ++ " ] ")
shBE (BO Sub e1 e2) = putStrLn (" [ " ++ show e1 ++ " - " ++ show e2 ++ " ] ")
shBE (BO Mul e1 e2) = putStrLn (" [ " ++ show e1 ++ " * " ++ show e2 ++ " ] ")
shBE (BO Div e1 e2) = putStrLn (" [ " ++ show e1 ++ " / " ++ show e2 ++ " ] ")
--show unary expression
--form: shUE (UO Negate (Value (evalun (UO Negate (Value 3)))))
shUE (UO Negate e1) = " [ " ++ show e1 ++ " ] "
--test forms:
-- shBE (BO Add (EV "a") (Value 3))
-- [ EV "a" + Value 3 ] ie  Exp Variable + Value 3
