main = do
	line <- getLine
	if null line
		then return ()
		else do
			putStrLn $ reverseWords line
			main

reverseWords :: String -> String
reverseWords st = reverse st

--recursively defining putStr with putChar | I/O action

putStr' :: String -> IO ()
putStr' [] = return ()
putStr' (x:xs) = do
	putChar x
	putStr' xs
