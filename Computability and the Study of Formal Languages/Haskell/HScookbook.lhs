HScookbook -- functions for parsing and filtering shit

> import Text.ParserCombinators.Parsec
> import qualified Text.ParserCombinators.Parsec.Token as P

> data Customers = Customers {	prod_id :: [Char], 
>				vend_id :: [Char], 
>				prod_name :: [Char],
>				prod_price :: Float,
>				prod_desc :: [Char] }
>				deriving (Eq,Show)

> getProd_id (Customers { prod_id = x } ) = x

> simple :: Parser Char
> simple = letter

> openClose :: Parser Char
> openClose = do { char '('; letter; char ')' }

> testOr :: Parser String
> testOr = string "(a)" <|> string "(b)"

> testOr1 :: Parser Char
> testOr1 = do { char '('; char 'a' <|> char 'b'; char ')' }

> testOr2 :: Parser String
> testOr2 = try (string "(a)") <|> string "(b)"

> parens :: Parser ()
> parens = do { char '('; parens; char ')'; parens} <|> return ()

> nesting :: Parser Int
> nesting = do { char '('; n <- nesting; char ')'; word;
>		 return (n+1) } <|> return 0

> -- After parsing a letter, it is either followed by a word itself or it returns the single
> -- character as a string. 
> word :: Parser String
> word = do { c <- letter; do { cs <- word ; return (c:cs) } <|> return [c] }

> -- Less ambigious using the 'many1' parser
> word' :: Parser String
> word' = many (letter <?> "") <?> "word"

> sentence :: Parser [String]
> sentence = do { words <- sepBy1 word' separator
>			; oneOf ".?!" <?> "end of sentence"
>			; return words }

> separator :: Parser ()
> separator = skipMany1 (space <|> char ',' <|> char '^' <?> "")

> run :: Show a => Parser a -> String -> IO ()
> run p input =
>	case (parse p "" input) of
>		Left err -> do { putStr "parse error at ";
>				 print err
>				}
>		Right x -> print x		

> -------------------------------------------------------------------------------------
> ioMatchElemCount :: IO ()
> ioMatchElemCount = do
>	putStrLn $ "** ioMatchElemCount reads files using ioContents **"++"\n"++
>		   "ioMatchElemCount will give the count of duplicates of int lists. "++"\n"++		   	   "Manually enter 2 lists or read file from path?  Type 'man' or 'read'."
>	input <- getLine
>	if (notElem input cmds)
>	then error "Input must be 'man' or 'read'."
>	else do if (input == "read") 
>		then do list1 <- ioContents
>			list2 <- ioContents
>			let result = matchElemCount list1 list2
>			print $ "List 1: "++(show list1)++" read from "
>				++"C:\\Users\\Kurt\\Google Drive\\log.txt"
>			print $ "List 2: "++(show list2)++" read from "
>				++"C:\\Users\\Kurt\\Google Drive\\log.txt"
>			print $ (interpret result)
>		else do putStrLn "Enter list 1 (must be of form [1,2,3..n]"
>			inputList1 <- getLine
>			putStrLn "Enter list 2 (must be of form [1,2,3..n]"
>			inputList2 <- getLine
>			print $ "List 1: " ++ inputList1
>			print $ "List 2: " ++ inputList2
>			print $ interpret (matchElemCount (read inputList1 :: [Integer]) (read inputList2 :: [Integer]))
>		where 
>		cmds = ["read","man"]
>		interpret [] = []
>		interpret ((x,y):xs) = (show x ++ " duplicate(s) of " ++ show y) : interpret xs	

> -- Parse a string of form "[1,2,3,..]" from a file and return IO [Int]
> ioContents :: IO [Integer]
> ioContents = do
>	contents <- readFile "C:\\Users\\Kurt\\Google Drive\\log.txt"
>	return $ (read contents :: [Integer])

> -- Test to see if elements from list 1 are in list 2, return those duplicate elements
> -- from list 1.
> matchElems :: Eq a => [a] -> [a] -> [a]
> matchElems [] ys = []
> matchElems (x:xs) ys
>	| x `elem` ys	= x : matchElems xs ys
>	| otherwise	= matchElems xs ys

> -- Upgraded matching elements -- fst gives the count number of the matching element x in ys,
> -- snd gives that element (x) which is within ys.
> matchElemCount :: Eq a => [a] -> [a] -> [(Int,a)]
> matchElemCount [] ys = []
> matchElemCount (x:xs) ys
>	| x `elem` ys	= (length $ filter (==x) ys, x) : matchElemCount xs ys
>	| otherwise	= matchElemCount xs ys	
