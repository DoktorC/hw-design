// Author: Lorenzo Casalino
// Website: doktorc.github.io
//
// Description of a register file with 2 read ports (A, B) and 1 write port (C)
// The register file receives two signals `read_en` and `write_en` to control,
// respectively, the read and write from and to the register file.
//
// By design, at each rising clock edge, the state of the register file can be
// read and written.

`timescale 1ns/1ps

module reg_file #(parameter N = 1)
                 (input  logic read_en, write_en, clk,
                  input  logic [3:0] addrA, addrB, addrC,
                  input  logic [N - 1:0] portC,
                  output logic [N - 1:0] portA, portB);

  logic [N - 1:0] registers [15:0];

// TODOL: add the logic to reset the register file state
  always_ff @(posedge clk)
    if (write_en)
      registers[addrC] <= portC;
  always_comb
    if (read_en)
      begin
        portA = registers[addrA];
        portB = registers[addrB];
      end

endmodule
