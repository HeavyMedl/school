import System.IO

main = do
	todoItem <- getLine
	appendFile "todo.txt" (todoItem ++ "\n")

-- explicit addition of the newline character because 'getLine' doesn't provide this.
