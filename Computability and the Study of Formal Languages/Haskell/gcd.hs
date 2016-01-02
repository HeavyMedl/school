-- GCD
import Prelude hiding (gcd, rem)

--gcd :: Int -> Int -> Int
gcd x y
	| y == 0	= x
	| x == 0	= y
	| otherwise	= gcd y (rem x y)

--rem :: Int -> Int -> Int
rem x y = x - (x `div` y) * y
