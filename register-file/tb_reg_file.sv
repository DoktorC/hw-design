// Author: Lorenzo Casalino
// Website: doktorc.github.io
//
// Testbench for the reg_file hardware module

module tb_reg_file();

  logic [1:0] dinC, doutA, doutB;
  logic [3:0] addrA, addrB, addrC;
  logic read_en, write_en, clk;
  logic [7:0] vectors[63:0];
  logic [5:0] idx;

  always
    begin
      clk = 1; #5; clk = 0; #5;
    end

  reg_file #(2) dut(.portC(dinC) ,
                    .portA(doutA),
                    .portB(doutB),
                    .addrA(addrA),
                    .addrB(addrB),
                    .addrC(addrC),
                    .read_en(read_en),
                    .write_en(write_en),
                    .clk(clk));

  initial
    begin
      $readmemb("tb_reg_file.mem", vectors);
      idx = 0;
    end

  // Test # : register file not written when write_en not asserted
  //          Consider read_en asserted and not asserted
  // Test # : register file written when write_en asserted
  //          Consider read_en not asserted
  // Test # : register file not read when read_en not asserted
  //          Consider write_en not asserted
  // Test # : register file read when read_en asserted
  //          Consider write_en not asserted
  // Test # : register file read from and written to when read_en and write_en
  //          asserted
  // Test #1: check correct filling of register file

endmodule
