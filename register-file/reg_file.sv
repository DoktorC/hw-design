// Author: Lorenzo Casalino
// Website: doktorc.github.io
//
// Description of a register file with 2 read ports (A, B) and 1 write port (C)

`timescale 1ns/1ps

module reg_file #(parameter N = 1)
                 (input  logic read_en, write_en, clk,
                  input  logic [3:0] addrA, addrB, addrC,
                  input  logic [N - 1:0] portC,
                  output logic [N - 1:0] portA, portB);

  logic [N - 1:0] registers [15:0];

  always_ff @(posedge clk)
    begin
      case ({read_en, write_en})
        2'b01:
          registers[addrC] <= portC;
        2'b10:
          begin
            portA <= registers[addrA];
            portB <= registers[addrB];
          end
      endcase
   end
endmodule
