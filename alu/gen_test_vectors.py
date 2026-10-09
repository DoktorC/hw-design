# Author: Lorenzo Casalino
# Website: doktorc.github.io
#
# Generate the test vectors for Exercise 5.11

from itertools import product

_sub = ("00", lambda x, y: x - y)
_sum = ("01", lambda x, y: x + y)
_and = ("10", lambda x, y: x & y)
_or  = ("11", lambda x, y: x | y)

ops = [_sub, _sum, _and, _or]

# The bitwidth of the handled inputs/output signals
W = 2
vals = range(0, 2**W)

# Formatting tip:
# https://stackoverflow.com/questions/1395356/how-can-i-make-bin30-return-00011110-instead-of-0b11110
def fmt(val: int, width: int) -> str:
  return bin(val)[2:].zfill(width)

def fmt_vector(op: str, A: int, B: int, fn, width: int) -> str:
  A = A & (2**width - 1)
  B = B & (2**width - 1)
  C = fn(A, B) & (2**width - 1)
  return f"{op}_{fmt(A, width)}_{fmt(B, width)}_{fmt(C, width)}\n"

header = """
// Author: Lorenzo Casalino
// Website: doktorc.github.io
//
// Test vector file for Exercise 5.11

// Format: CTRL_A_B_C
"""

with open("tb_alu.mem", "w") as f:
  f.write(header)
  _ = [ [f.write(fmt_vector(op, A, B, fn, W)) for A,B in product(vals, vals)] for op, fn in ops]
