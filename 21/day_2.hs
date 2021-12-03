----------------------
--
-- Advent of Code - Day 1
-- Dive!
--
----------------------
import System.IO
import Data.List

main :: IO ()
main = do
  contents <- readFile "day2.in"

  let word = words contents

  putStr "The depth is "
  print $ depth $ word
  putStr "\n"

  putStr "The horizontal position is "
  print $ forward $ word
  putStr "\n"
  
  putStr "The depth x horizontal position is "
  print $ movement $ word


movement :: [String] -> Int
movement [] = error "movement: [String] cannot be empty"
movement input = forward input * depth input

forward :: [String] -> Int
forward [] = 0
forward (s:x:xs) 
  | s == "forward" = (read x) + forward xs
  | otherwise = 0

depth :: [String] -> Int
depth [] = 0
depth (s:x:xs)
  | s == "up" = (- (read x)) + depth xs
  | s == "down" = (read x) + depth xs
  | otherwise = 0
