import Data.Char

main = do
 putStrLn "Hello, what is your first name?"
 firstName <- getLine
 putStrLn "And last name?"
 lastName <- getLine
 let	 bigFirst = map toUpper firstName
	 bigLast = map toUpper lastName
 putStrLn $ "Hey " ++ bigFirst ++ " " ++ bigLast ++  ", you rock!"
 
