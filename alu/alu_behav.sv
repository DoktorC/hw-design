// Author: Lorenzo Casalino
// Website: doktorc.github.io
// Original source: Digital Design and Computer Architecture. ARM Edition. Harris S. and Harris D
// Exercise: 5.11 page 283

`timescale 1ns/1ps

module alu_behav #(parameter N = 1)
                  (input  logic [N - 1:0] A, B,
                   input  logic [1:0] CTRL,
                   output logic [N - 1:0] C);
  always_comb
    case(CTRL)
      2'b00: C = A - B;
      2'b01: C = A + B;
      2'b10: C = A & B;
      2'b11: C = A | B;
    endcase
endmodule
