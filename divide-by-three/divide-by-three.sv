// Author: Lorenzo Casalino
// Website: doktorc.github.io
// Original source: Digital Design and Computer Architecture. ARM Edition. Harris S. and Harris D, (HDL Example 4.30, page 210)A

// This is my solution to the Example 4.30, which differs from the book solution
// as follows:
// * I explicitly defined the registers S0 and S1, instead of using a 2-bit signal
// * I designed the 'next state' logic through their equations, instead of using a 4:1 multiplexer
// * I fused 'next state' and 'state update logic, instead of defining them separately.
//
// According to the generated RTL from Vivado 2025.2, this solution uses:
// * 7 cells (instead of 9)
// * 3 I/O ports (as in the book solution)
// * 9 nets/wires (as in the book solution)

`timescale 1ns / 1ps

module div_by_three(input logic clk,
                    input logic reset,
                    output logic y);

  logic s0, s1;

  always_ff@(posedge clk, posedge reset)
  begin
    if (reset)
      begin
        s1 <= 0;
        s0 <= 0;
      end
    else
      begin
        s1 <= ~s1 & ~s0;
        s0 <= s1  & ~s0;
      end
  end

  always_comb
    y  <= ~s1 & s0;

endmodule
