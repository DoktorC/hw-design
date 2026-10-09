// Author: Lorenzo Casalino
// Website: doktorc.github.io
//
// Testbench for the ALU hardware module

module tb_alu();

  logic [1:0] A, B, C, C_gold;
  logic [1:0] CTRL;
  logic [7:0] vectors[5:0];
  logic [5:0] idx;
  logic clk;

  always
    begin
      clk = 1; #5; clk = 0; #5;
    end

  alu_behav #(2) dut(A, B, CTRL, C);

  initial
    begin
      $readmemb("tb_alu.mem", vectors);
      idx = 0;
    end
 
  always @(posedge clk)
      {CTRL, A, B, C_gold} = vectors[idx];

  always @(negedge clk)
    begin
      if (C != C_gold)
        begin
          $display("CTRL = %b, A = %b, B = %b", {CTRL, A, B});
          $display("Expected: %b", C_gold);
          $display("Got: %b"     , C);
        end
      idx = idx + 1;
    end
endmodule
