----------------------
--
-- Advent of Code - Day 3
-- Binary Diagnostic
--
----------------------
import System.IO
import Data.List

main :: IO ()
main = do
  contents <- readFile "day3.in"
  putStr "Power consumption is "
  putStr $ power $ lines contents
  putStr "\n"

  putStr "Oxygen is "
  putStr $ oxygen $ lines contents
  putStr "\n"

  putStr "Carbon Dioxide is "
  putStr $ co2 $ lines contents


power :: [String] -> String
power s
  | null $ head s = []
  | otherwise = (most $ map head s) : (power $ map tail s)


oxygen :: [String] -> String
oxygen s = oxygen' 0 s

oxygen' :: Int -> [String] -> String
oxygen' _ [] = error "should never get here"
oxygen' _ [s] = s
oxygen' x s = oxygen' (x+1) $ filter (\n -> n !! x == (most $ map (!! x) s)) s


co2 :: [String] -> String
co2 s = co2' 0 s

co2' :: Int -> [String] -> String
co2' _ [] = error "should never get here"
co2' _ [s] = s
co2' x s = co2' (x+1) $ filter (\n -> n !! x /= (most $ map (!! x) s)) s


most :: [Char] -> Char
most [] = error "most: cannot call on an empty list!"
most s = most' s 0 0

most' :: [Char] -> Int -> Int -> Char
most' [] o z = if o >= z then '1' else '0'
most' (x:xs) o z
  | x == '1' = most' xs (o+1) z
  | otherwise = most' xs o (z+1)
