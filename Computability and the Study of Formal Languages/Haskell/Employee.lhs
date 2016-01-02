> data Employee =
>	Employee { firstname :: String,
>                  lastname  :: String,
>                  employeeN :: Int
>                } deriving (Eq, Show)


> type Roster = [Employee]

> frontEnd :: Roster 
> frontEnd = take 50 $ repeat e1

A function that returns a legible list of employees of a given roster. Each Employee is separated by a new line in the console. The function works by taking the Roster/[Employee] and converting each configuration record into a string (Hence show :: a -> String). 'unlines' appends a newline character to each config. record.

> getRoster :: IO () 
> getRoster = do
>	putStrLn "Enter the name of a roster you'd like to view: "
>	input <- getLine
>	if input /= "frontEnd" then error "Roster does not exist."
>	else putStrLn $ unlines [ show x | x <- rost ] 
>		where rost = frontEnd

> e1 :: Employee
> e1 = Employee "Kurt" "Medley" 527010

