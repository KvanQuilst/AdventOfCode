----------------------
--
-- Advent of Code - Day 1
-- Binary Diagnostic
--
----------------------
import System.IO
import Data.List

main :: IO ()
main = do
  contents <- readFile "day4.in"

  let input = lines contents
  let calls = head input
  let boards = tail input

  --print $ mark''' (boardify $ tail $ lines contents) "57"
  print $ check $ [["-1", "-1", "2"],["2", "0", "1"],["-1","-1","-1"]]


-- Notes:
  -- Break up into individual boards --> transpose will be our friend  
  -- Print the first successfull board
  -- Pair number to bit whether checked?

boardify :: [String] -> [[[String]]]
boardify [] = []
boardify (s:xs)
  | s == "" = boardify' xs : boardify xs
  | otherwise = boardify xs

boardify' :: [String] -> [[String]]
boardify' [] = []
boardify' (s:xs)
  | s == "" = []
  | otherwise = words s : boardify' xs


mark :: [[[String]]] -> String -> [[[String]]]
mark s x = [[[if y == x then "-1" else y | y <- sss] | sss <- ss] | ss <- s]


check :: [[String]] -> Bool
check [] = False
check (s:xs) = if all (==("-1")) s then True else check xs
