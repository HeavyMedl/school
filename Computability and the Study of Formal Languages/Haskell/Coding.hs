module Coding ( codeMessage, decodeMessage ) where

import Types (Tree(Leaf,Node), Bit(L,R), HCode, Table)

-- The purpose of this module is to define functions to code and decode messages.  We export only these.

-- codeMessage concats the list of L's and R's given by the defintion of a table
codeMessage :: Table -> [Char] -> HCode
codeMessage tbl = concat.map (lookupTable tbl)

-- lookupTable takes a table of the form [(char,HCode)] and a char to look up and returns the HCode ie [L,L] if the parameterized c matches any of the chars given in the HCode.
lookupTable :: Table -> Char -> HCode
lookupTable [] c = error "lookupTable"
lookupTable ((ch,n):tb) c
	|ch == c	= n
	|otherwise	= lookupTable tb c

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
mess1 = [R,L,L,R,R,R,R,L,R,R]

table1 = [('a',[L]),('b',[R,L]),('t',[R,R])]
--Coding> codeMessage table1 "battab"
--[R,L,L,R,R,R,R,L,R,L]

