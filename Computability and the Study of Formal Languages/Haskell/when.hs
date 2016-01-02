import Control.Monad

-- "when" is useful when we want some IO action to meet a conditional and return NOTHING IF FALSE

main = do
	input <- getLine
	when (input == "SWORDFISH") $ do
		putStrLn input

-- equivalence
{-- main = do
 - 	input <- getLine
 - 	if (input == "SWORDFISH")
 - 		then putStrLn input
 - 		else return () --}
