import System.IO
import System.Directory
import Data.List
import Control.Exception

main = do
	-- 1. Read the filepath "todo.txt" and binds its lines to "contents"
	contents <- readFile "todo.txt"
	-- 2. Turn contents into a list of lines ["abc","def"]
	--    Use zipWith to concat the enum. 0.. with each line
	let todoTasks = lines contents
	    numberedTasks = zipWith (\n line -> show n ++ " - " ++ line)
			    [0..] todoTasks
	putStrLn "These are your TO-DO items:"
	-- 3. Map IO action putStrln to each numberedTask
	mapM_ putStrLn numberedTasks
	-- 4. Prompt the user for an input number associated with each line.
	putStrLn "Which one do you want to delete?"
	-- 5. Bind the command line arg to "numberString"
	numberString <- getLine
	-- 6. Delete the first occurence of "number" (which is the converted
	--    string to int, using read) within the todoTasks list
	let number = read numberString
	    newToDoItems = unlines $ delete (todoTasks !! number) todoTasks
	-- 7. create a temporary file. tempName gets bound to ".", tempHandle
	--    to "temp"
	bracketOnError (openTempFile "." "temp")
		(\(tempName, tempHandle) -> do
			hClose tempHandle
			removeFile tempName)
		(\(tempName, tempHandle) -> do
			hPutStr tempHandle newToDoItems
			hClose tempHandle
			removeFile "todo.txt"
			renameFile tempName "todo.txt")

{--
	(tempName, tempHandle) <- openTempFile "." "temp"
	-- 8. hPutStr takes a handle and string and prints them to sdnout
	hPutStr tempHandle newToDoItems
	-- 9. hClose closes the handle.  Remove the original file and
	--    rename the tempFile as the new "todo" list
	hClose tempHandle
	removeFile "todo.txt"
	renameFile tempName "todo.txt"
--}
