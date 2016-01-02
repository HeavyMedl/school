R:egular Expressions and Automata using Haskell by Simon Thompson
-- Notes by Kurt Medley

> module RegExp where

E 	- epsilon; which matches the empty string
x 	- x is any character.  This matches the character itself
(r1|r2) - r1 and r2 are regular expressions.
(r1r2)	- r1 and r2 are regular expressions.
(r)*	- r is a regular expression

> data Reg = 	Epsilon | Literal Char | Or Reg Reg | Then Reg Reg | Star Reg
>		deriving Eq

	Functions over the type

> literals :: Reg -> [Char]
> literals Epsilon 	= []
> literals (Literal ch) = [ch]
> literals (Or r1 r2)	= literals r1 ++ literals r2
> literals (Then r1 r2)	= literals r1 ++ literals r2
> literals (Star r)	= literals r

> printRE :: Reg -> [Char]
> printRE Epsilon 	= "@"
> printRE (Literal ch) 	= [ch]
> printRE (Or r1 r2)	= "(" ++ printRE r1 ++ "|" ++ printRE r2 ++ ")"
> printRE (Then r1 r2)	= "(" ++ printRE r1 ++ printRE r2 ++ ")"
> printRE (Star r)	= "(" ++ printRE r ++ ")" ++ "*"

Using printFE we can make Reg an instance of Show

> instance Show Reg where
>	show = printRE

> matches :: Reg -> String -> Bool
> matches Epsilon st		= ( st == "" )
> matches (Literal ch) st	= ( st == [ch] )
> matches (Or r1 r2) st		= matches r1 st || matches r2 st
> matches (Then r1 r2) st	= or [ matches r1 s1 && matches r2 s2 | (s1,s2) <- splits st ]
>	where  splits st 	= [ splitAt n st | n <- [0..length st] ]
> matches (Star r) st		= matches Epsilon st || or [ matches r s1 && matches (Star r) s2 |
>								(s1, s2) <- frontSplits st ]
> 	where frontSplits st = [ splitAt n st | n <- [1..length st] ]

