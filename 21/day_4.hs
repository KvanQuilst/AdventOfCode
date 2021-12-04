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

-- Notes:
  -- Break up into individual boards --> transpose will be our friend  
  -- Print the first successfull board
  -- Pair number to bit whether checked?
