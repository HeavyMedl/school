import Data.List (subsequences)
import RegExp
import Sets
import Control.Monad.State

data Nfa a = NFA
	(Set a)
	(Set (Move a))
	a
	(Set a)
	deriving (Show, Eq)

data Move a = Move a Char a deriving (Eq, Ord, Show)

type NfaT = StateT (Nfa Int) IO

parseMoves :: Eq a => Move a -> Reg
parseMoves (Move x y z)
	| x /= z	= Literal y
	| x == z	= Star (Literal y)

-- removeTran "removes" a transition from the Nfa 
removeTran :: Ord a => Move a -> Nfa a -> Nfa a
removeTran x (NFA states moves start finish)
	= 	NFA states newmoves start finish
		where
	   	newmoves = makeSet [ mvs | 
				     mvs <- flatten moves,
				     test <- flatten $ makeSet [x],
				     mvs /= test ]
			   

-- ex. runStateT showCharsM exdfa
showCharsM :: NfaT ()
showCharsM = do
	st <- get
	liftIO $ putStrLn (show $ nfaChars st)

--processMoves :: Nfa a -> [Char] 
processMoves nfa = do
	let (ch:chars) = nfaChars nfa
	liftIO $ putStrLn (show (ch:chars))
	return (ch:chars)

convertToReg []	= Epsilon
convertToReg (c:chars) = Then (Literal c) (convertToReg chars)
	

nfaChars :: Nfa a -> [Char]
nfaChars (NFA states moves start finish)
	= [ y | Move x y z <- flatten moves ]

--------------------------------------------------------
-- Test Nfa's
--------------------------------------------------------
exdfa1 :: Nfa Int
exdfa1 = NFA (makeSet [0..1]) (makeSet [Move 0 'a' 1, 
					Move 1 'b' 1 ]) 0 (sing 1)

exdfa2 :: Nfa Int
exdfa2 = NFA (makeSet [0..3]) (makeSet [Move 0 'a' 3,
					Move 0 'a' 2,
					Move 1 'b' 0,
					Move 2 'a' 1,
					Move 2 'b' 2,
					Move 3 'b' 0,
					Move 3 'b' 1 ]) 0 (sing 3)
