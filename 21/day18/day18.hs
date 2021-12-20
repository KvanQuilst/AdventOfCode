----------------------
--
-- Advent of Code - Day 18
-- Snailfish
--
----------------------
import System.IO
import Data.List
import qualified Data.ByteString as B

main = do
  contents <- readFile "day18_test.in"
  print $ getNums contents


data SnailNum = SN SnailNum SnailNum | Lit Int deriving (Eq, Show, Read)


--getNums :: String -> SnailNum
getNums :: String -> [[String]]
getNums sl = 
  let list = lines sl

parse :: String -> SnailNum
parse [] = error "incomplete list"
parse (s:ss)
  | s == '[' = 
