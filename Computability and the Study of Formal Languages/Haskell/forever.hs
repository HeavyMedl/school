import Data.Char
import Control.Monad

main = forever $ do
	putStrLn "Give me some input: "
	l <- getLine
	putStrLn $ map toUpper l
