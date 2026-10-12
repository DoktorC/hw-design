// Author: Lorenzo Casalino
// Website: doktorc.github.io
// Original source: Digital Design and Computer Architecture. ARM Edition. Harris S. and Harris D
// Exercise: 5.11 page 283 (structural specification)

`timescale 1ns/1ps

module mux2 #(parameter N = 1)
             (input  logic [N - 1:0] A, B,
              input  logic sel,
              output logic [N - 1:0] out);

  assign out = (sel)? B : A;
endmodule

module mux3 #(parameter N = 1)
             (input  logic [N - 1:0] A, B, C,
              input  logic [1:0] sel,
              output logic [N - 1:0] out);

  always_comb
    begin
      case (sel)
        2'b00 : out = A;
        2'b01 : out = A;
        2'b10 : out = B;
        2'b11 : out = C;
        default: out = 0;
      endcase
    end
endmodule


module alu_struct #(parameter N = 1)
                   (input  logic [N - 1:0] A, B,
                    input  logic [1:0] CTRL,
                    output logic [N - 1:0] C);
  logic [N - 1:0] _B, sum, and_out, or_out;

  mux2 #(N) muxB   ((~B + 1), B, CTRL[0], _B);
  mux3 #(N) muxRes (sum, and_out, or_out, CTRL, C);

  always_comb
    begin
      or_out  = A | B;
      and_out = A & B;
      sum = A + _B;
    end
endmodule
