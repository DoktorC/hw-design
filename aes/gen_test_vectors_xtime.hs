-- Author: Lorenzo Casalino
-- Website: doktorc.github.io
--
-- Haskell module generating all the 256 test vectors for the xtime hardware module.

import Data.Bits (shiftL, xor, testBit)
import Data.Word
import Numeric (showHex)
import System.IO

showHex' :: (Integral a, Show a) => a -> String 
showHex' n | n < 16 = '0' : showHex n ""
           | otherwise = showHex n ""

showTuple :: (Word8, Word8, Word8, Word8) -> String
showTuple (a, b, c, d) = foldr (\ x z -> showHex' x ++ z) "" [a, b, c, d]


-- 'xtime' function as defined per FIPS-197 (cft. Section 4.2.1).
-- https://nvlpubs.nist.gov/nistpubs/fips/nist.fips.197.pdf
xtime :: Word8 -> Word8
xtime a =  if testBit a 7 then _a `xor` 0x1B else _a
        where _a = a `shiftL` 1

mixCol :: (Word8, Word8, Word8, Word8) -> (Word8, Word8, Word8, Word8)
mixCol (b0, b1, b2, b3) = (d0, d1, d2, d3)
                        where d0 = foldr (xor) 0 [xtime b0,          xtime b1 `xor` b1, b2,                b3]
                              d1 = foldr (xor) 0 [b0,                xtime b1,          xtime b2 `xor` b2, b3]
                              d2 = foldr (xor) 0 [b0,                b1,                xtime b2,          xtime b3 `xor` b3]
                              d3 = foldr (xor) 0 [xtime b0 `xor` b0, b1,                b2,                xtime b3]

-- Input vectors for the MixColumn operation
inputVectorsMixCol :: [(Word8, Word8, Word8, Word8)]
inputVectorsMixCol = [
                       (0x00, 0x00, 0x00, 0x00)
                     , (0x01, 0x00, 0x00, 0x00)
                     , (0x00, 0x01, 0x00, 0x00)
                     , (0x00, 0x00, 0x01, 0x00)
                     , (0x00, 0x00, 0x00, 0x01)
                     ]

-- Generate the set of test vectors as a unique string formatted as: input_output\n
genTestVectorsXTIME :: [Char]
genTestVectorsXTIME = foldr (++) "" $ map (\ x -> showHex' x ++ "_" ++ showHex' (xtime x) ++ "\n") [0..255]

-- Generate the set of test vectors as a unique string formatted as" input_output\n
genTestVectorsMixCol :: [Char]
genTestVectorsMixCol = foldr (++) "" $ map (\ x -> showTuple x ++ "_" ++ (showTuple.mixCol) x ++ "\n") inputVectorsMixCol

main = do
  handle <- openFile "tb_xtime.mem" WriteMode
  hPutStr handle genTestVectorsXTIME
  hClose handle
  handle <- openFile "tb_mixcol.mem" WriteMode
  hPutStr handle genTestVectorsMixCol
  hClose handle
