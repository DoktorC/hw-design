// Author: Lorenzo Casalino
// Website: doktorc.github.io
// Original source: Digital Design and Computer Architecture. ARM Edition. Harris S. and Harris D, (HDL Example 4.23, page 200)

`timescale 1ns / 1ps

module full_adder #(parameter W = 1)
    (
    input [W - 1:0] A,
    input [W - 1:0] B,
    input Cin,
    output Cout,
    output [W - 1:0] C
    );
    
    logic P, G;
    assign G = A & B;
    assign P = A ^ B;
    assign C = P ^ Cin;
    assign Cout = G | (P & Cin);
endmodule
