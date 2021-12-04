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

  print $ head $ boardify $ tail $ lines contents


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


