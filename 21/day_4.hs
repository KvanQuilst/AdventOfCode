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
  let calls = words $ map (\c -> if c == ',' then ' ' else c) $ head input

  --print $ mark (boardify $ tail $ lines contents) "57"
  print $ mul $ bingo calls (boardify $ tail input)

mul :: ([[String]], String) -> Int
--mul p = sum (map sum (filter (/=(-1)) (map read b))) * x
mul p = (sum $ map sum $ map (filter (/=(-1))) [[read c | c <- s] | s <- b]) * (read x)
  where b = fst p
        x = snd p


bingo :: [String] -> [[[String]]] -> ([[String]], String)
bingo c b = if i then(head $ filter check m, (head c)) 
  else if j then (head $ filter check $ transpose m, (head c)) else bingo (tail c) m
  where m = mark b $ head c
        i = (any (==True) (map check m)) 
        j = (any (==True) (map check $ transpose m))


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
