// Author: Lorenzo Casalino
// Website: doktorc.github.io
// Original source: Digital Design and Computer Architecture. ARM Edition. Harris S. and Harris D, (HDL Example 4.30, page 210)A

// This is my solution to the Example 4.30.

`timescale 1ns / 1ps

module div_by_three(input logic clk,
                    output logic y);

  logic s0, s1;

  always_ff@(posedge clk)
  begin
    s1 <= ~s1 & ~s0;
    s0 <= s1 & ~s0;
  end

  always_comb
    y  <= ~s1 & s0;

endmodule
