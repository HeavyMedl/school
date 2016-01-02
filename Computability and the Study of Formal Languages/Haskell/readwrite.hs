import Data.Char
import System.IO

main = do
	putStrLn "Name of file to convert: "
	input <- getLine 
	file <- readFile input
	writeFile "capsfile.txt" (reverse $ map toUpper file)
			
