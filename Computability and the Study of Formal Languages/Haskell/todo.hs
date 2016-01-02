-- todo - A program to do three different things: View, Add, Delete tasks
-- ./todo add todo.txt "Find the magic sword of power"
-- ./todo view todo.txt
-- ./todo remove todo.txt 2

import System.Environment
import System.Directory
import System.IO
import Data.List
import Control.Exception

-- A function that takes a command in the form of a string
dispatch :: String -> [String] -> IO ()
dispatch "add" 		= add
dispatch "view"		= view
dispatch "remove" 	= remove
dispatch "bump"		= bump
-----------------------------------------------------------------------
main = do
	(command:argList) <- getArgs
	if (not $ command `elem` cmdlst) 
	then error "command must = add, view, remove, bump"
	else dispatch command argList
		where cmdlst = ["add","view","remove","bump"]
-----------------------------------------------------------------------
bump :: [String] -> IO ()
bump [fileName] = do
	contents <- readFile fileName
	let todoTasks = lines contents
	    numberedTasks = zipWith (\n line -> show n ++ " - " ++ line)
			    [0..] todoTasks
	putStr $ unlines numberedTasks
	putStrLn "Which item do you want to bump to the top?"
	numberString <- getLine
	let number = read numberString
	    bumpItem = todoTasks !! number
	    newToDoItems = unlines $ headinsert bumpItem $
			   delete (todoTasks !! number) todoTasks
	bracketOnError (openTempFile "." "temp")
		(\(tempName, tempHandle) -> do
			hClose tempHandle
			removeFile tempName)
		(\(tempName, tempHandle) -> do
			hPutStr tempHandle newToDoItems
			hClose tempHandle
			removeFile "todo.txt"
			renameFile tempName "todo.txt")
bump _ = putStrLn "bump takes one parameter (filename) ./todo bump 'filename'"

headinsert :: Ord a => a -> [a] -> [a]
headinsert n xs = n:xs
-----------------------------------------------------------------------
add :: [String] -> IO ()
add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")
add _ = putStrLn "The add command takes exactly two arguments"
-----------------------------------------------------------------------
view :: [String] -> IO ()
view [fileName] = do
	contents <- readFile fileName
	let todoTasks = lines contents
	    numberedTasks = zipWith (\n line -> show n ++ " - " ++ line)
			    [0..] todoTasks
	putStr $ unlines numberedTasks
-----------------------------------------------------------------------
remove :: [String] -> IO ()
remove [fileName, numberString] = do
	contents <- readFile fileName
	let todoTasks = lines contents
	    numberedTasks = zipWith (\n line -> show n ++ " - " ++ line)
				    [0..] todoTasks
	putStrLn "These are your TO-DO items:"
	mapM_ putStrLn numberedTasks
	let number = read numberString
	    newToDoItems = unlines $ delete (todoTasks !! number) todoTasks
	bracketOnError (openTempFile "." "temp")
		(\(tempName, tempHandle) -> do
			hClose tempHandle
			removeFile tempName)
		(\(tempName, tempHandle) -> do
			hPutStr tempHandle newToDoItems
			hClose tempHandle
			removeFile "todo.txt"
			renameFile tempName "todo.txt")
