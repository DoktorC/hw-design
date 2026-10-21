-- Author: Lorenzo Casalino
-- Website: doktorc.github.io
--
-- Haskell module generating all the 256 test vectors for the xtime hardware module.

import Data.Bits (shiftL, xor, testBit)
import Data.Word
import Numeric (showHex)
import System.IO

-- 'xtime' function as defined per FIPS-197 (cft. Section 4.2.1).
-- https://nvlpubs.nist.gov/nistpubs/fips/nist.fips.197.pdf
xtime :: Word8 -> Word8
xtime a =  if testBit _a 7 then _a `xor` 0x1B else _a
        where _a = a `shiftL` 1

-- Generate the set of test vectors as a unique string formatted as: input_output\n
genTestVectorsXTIME :: [Char]
genTestVectorsXTIME = foldr (++) "" $ map (\ x -> showHex x "" ++ "_" ++ showHex (xtime x) "" ++ "\n") [0..255]

main = do
  handle <- openFile "tb_xtime.mem" WriteMode
  hPutStr handle genTestVectorsXTIME
  hClose handle
