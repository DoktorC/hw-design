// Author: Lorenzo Casalino
// Website: doktorc.github.io
// Original source: Digital Design and Computer Architecture. ARM Edition. Harris S. and Harris D
// Exercise: 5.11 page 283 (structural specification)
//           This module specifies a `gated` version of the the ALU module
//           described in `alu_struct.sv`
//
// A `gated` ALU is an ALU where only one functional unit operates on the
// inputs, whereas all the others operate on constant/random values.
// This type of ALU better suits particular masked software implementations
// (e.g., bit-sliced implementations), and potentially reduce the consumed power
// due to the reduced switching activity.
//
// More information can be found here:
// Gigerl, Barbara, et al. "Coco:{Co-Design} and {Co-Verification} of masked software implementations on {CPUs}." 30th USENIX security symposium (USENIX security 21). 2021.

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

// Semantically equivalent to a 2:1 multiplexer.
// And the `en` signal to each bits of `A` signal.
module and1_N #(parameter N = 1)
               (input logic            en,
                input logic  [N - 1:0] A,
                output logic [N - 1:0] C);
  always_comb
    for (int i = 0; i < N; i++)
      C[i] = A[i] & en;
endmodule

module alu_struct_gated #(parameter N = 2)
                   (input  logic [N - 1:0] A, B,
                    input  logic [1:0] CTRL,
                    output logic [N - 1:0] C);
  logic [N - 1:0] _B, sum, and_out, or_out;
  logic [N - 1:0] _A_or, _A_and, _A_sum;
  logic [N - 1:0] _B_or, _B_and, _B_sum;
  logic or_en, and_en, adder_en;

  mux2 #(N)    muxB   ((~B + 1), B, CTRL[0], _B);
  mux3 #(N)    muxRes (sum, and_out, or_out, CTRL, C);
  and1_N #(N)  _A_or_sel(or_en, A, _A_or);
  and1_N #(N)  _B_or_sel(or_en, B, _B_or);

  and1_N #(N)  _A_and_sel(and_en, A, _A_and);
  and1_N #(N)  _B_and_sel(and_en, B, _B_and);

  and1_N #(N)  _A_adder_sel(adder_en, A, _A_sum);
  and1_N #(N)  _B_adder_sel(adder_en, _B, _B_sum);

  always_comb
    begin
      or_en   = &CTRL[1:0];
      or_out  = _A_or | _B_or;

      and_en   = CTRL[1] & ~CTRL[0];
      and_out = _A_and & _B_and;

      adder_en = ~CTRL[1];
      sum = _A_sum + _B_sum;
    end
endmodule

