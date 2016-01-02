
{- Two players, A and B, play the following game:
 - a. Initially there are 300 coins on the table.
 - b. Each player, in turn, removes either 1, 3, or 4 coins.
 - c. Player A makes the first move.
 - d. The player who removes the last coin(s) wins.
 - One of the two players will always win if he plays intelligently. 
 - Which player is it and what is his winning strategy? -}

-- Every 7 iterations of the pool > 6, the pattern "PNPNNNN" repeats sequentially.
-- 0 is not included as it is not a valid integer, for if 0 is reached, the game
-- is over and either player A or B has won.

import Data.List

--subgame :: Int -> [(Char,Int)]
subgame 0 = error "Game pool must be > 0"
subgame pool = last ((zip (cycle ['N','P','N','N','N','N','P']) [1..pool]))


