-- Assignment 8 Part 1 Module SetUL -- Kurt Medley

module SetUL (Set, null, member, empty, fromList, toList, insert, delete) where

import Data.List (sort)
import Prelude hiding (null)
{--
null :: Set a -> Bool                     -- is this the empty set?
member  :: Ord a => a -> Set a -> Bool    -- is this a member of the set?
empty :: Set a                            -- create and empty set.
fromList :: Ord a => [a] -> Set a         -- create a set from a list
toList :: Set a -> [a]                    -- convert a set to a list
insert  :: Ord a => a -> Set a -> Set a
delete  :: Ord a => a -> Set a -> Set a
--}
newtype Set a = Set [a]

----------------------------------------------------------
--Instance Declaration of Show
----------------------------------------------------------
instance Show a => Show (Set a) where
	show n = showset n

showset :: Show t => Set t -> String
showset (Set n) = show n
----------------------------------------------------------
--Instance Declaration of Eq
----------------------------------------------------------
-- Here I have only defined (==) to work for sets of
-- equal length
instance Ord a => Eq (Set a) where
	(Set xs) == (Set ys) = eqlength (Set xs) (Set ys)
			       && uEqSets (Set xs) (Set ys)

eqlength :: Set a -> Set a -> Bool
eqlength (Set xs) (Set ys) = length xs == length ys
----------------------------------------------------------
-- uEqSets works on unordered lists as it firsts sorts
-- elements from both sets and tests their equality.
-- ex. [1,2,3] = [2,3,1]
uEqSets :: Ord a => Set a -> Set a -> Bool
uEqSets (Set xs) (Set ys) = (sort xs) == (sort ys)

-- oEqSets works on ordered lists and mimicks the 
-- originial (==) definition
-- ex. [1,2,3] /= [2,3,1]
oEqSets :: Eq a => Set a -> Set a -> Bool
oEqSets (Set xs) (Set ys) = xs == ys

evalset (Set n) = Set n

null :: Set a -> Bool
null (Set []) = True
null _ = False

member :: Ord a => a -> Set a -> Bool
member e (Set (x:xs))
	| e == x	= True
	| otherwise	= member e (Set xs)
member e (Set [])	= False

mem :: Ord a => a -> Set a -> Bool
mem e (Set []) = False
mem e (Set xs)
	| e `elem` xs 	= True
	| otherwise	= False

empty :: Set a
empty = Set []

fromList :: Ord a => [a] -> Set a
fromList [] = Set []
fromList xs = Set xs

toList :: Set a -> [a]
toList (Set n) = n

insert :: Ord a => a -> Set a -> Set a
insert e (Set n) = Set (e:n)

delete :: Ord a => a -> Set a -> Set a
delete e (Set n) = Set $ (filter (/= e) n)


