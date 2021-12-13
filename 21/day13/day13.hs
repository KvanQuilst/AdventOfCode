----------------------
--
-- Advent of Code - Day 13
-- Transparent Origami
--
----------------------
import System.IO
import Data.List
import qualified Data.ByteString as B

main = do
  contents <- readFile "day13.in"
  let p = createPaper contents
      i = getInstr contents
  --print p
  --print i
  --print $ execInstr p [('x', 655)]
  printPaper $ execInstr p i


type Paper = [B.ByteString]
type Instructions = [(Char, Int)]


createPaper :: String -> Paper
createPaper s = 
  let split = takeWhile (/= "") $ lines s
      pairs = [map read $ words $ map (\c -> if c == ',' then ' ' else c) p | p <- split]
      maxX  = maximum $ map head pairs
      maxY  = maximum $ map (head . tail) pairs
  in [B.pack [if elem [x,y] pairs then 49 else 32 | x <- [0..maxX]] | y <- [0..maxY]]


getInstr :: String -> Instructions
getInstr s = 
  let split = map (drop 11) $ tail $ dropWhile (/= "") $ lines s
      pair = [words $ map (\c -> if c == '=' then ' ' else c) p | p <- split]
  in [if head i == "x" then ('x', read $ head $ tail i)
      else ('y', read $ head $ tail $ i) | i <- pair]


execInstr :: Paper -> Instructions -> Paper
--execInstr p [] = sum $ map (B.count 49) p
execInstr p [] = p
execInstr p (i:is)
  | fst i == 'x' && xOver > 0 = 
      execInstr ((take xOver xBottom) ++ ([bor (fst x) (snd x) | x <- zip xTop (drop xOver xBottom)])) is
  | fst i == 'x' && xOver < 0 =
      execInstr ((take xOver xTop) ++ ([bor (fst x) (snd x) | x <- zip (drop yOver xTop) xBottom])) is
  | fst i == 'x' = execInstr (B.transpose $ [bor (fst x) (snd x) | x <- zip xTop xBottom]) is
  | yOver > 0 && fst i == 'y' = 
      execInstr ((take yOver yBottom) ++ ([bor (fst x) (snd x) | x <- zip yTop (drop yOver yBottom)])) is
  | yOver < 0 && fst i == 'y' =
      execInstr ((take yOver yTop) ++ ([bor (fst x) (snd x) | x <- zip (drop yOver yTop) yBottom])) is
  | otherwise = execInstr ([bor (fst x) (snd x) | x <- zip yTop yBottom]) is
  where val = snd i
        xOver = (B.length $ head p) - (2*val) - 1
        xTop = take val $ B.transpose p
        xBottom = reverse $ drop (val+1) $ B.transpose p
        yOver = (length p) - (2*val) - 1
        yTop = take val p
        yBottom = reverse $ drop (val + 1) p


bor :: B.ByteString -> B.ByteString -> B.ByteString
bor a b 
 | a == B.empty || b == B.empty = B.empty
 | otherwise = if B.head a == 49 || B.head b == 49
               then B.cons 49 $ bor (B.tail a) (B.tail b) 
               else B.cons 32 $ bor (B.tail a) (B.tail b)


printPaper :: Paper -> IO ()
printPaper [] = do return ()
printPaper (p:ps) = do
  print $ p
  printPaper ps
  return ()
  
