// Author: Lorenzo Casalino
// Website: doktorc.github.io

// Testbench for the shiftrow hardware module

module tb_shiftrow();

  logic [31:0] in_row, out_row, gold_out_row[4];
  logic [1:0] amount;

  shift_row dut(in_row, amount, out_row);

  initial
    begin
      in_row = 32'hAABBCCDD;
      gold_out_row[0] = 32'hAABBCCDD;
      gold_out_row[1] = 32'hBBCCDDAA;
      gold_out_row[2] = 32'hCCDDAABB;
      gold_out_row[3] = 32'hDDAABBCC;
      for (int i = 0; i < 4; i++)
        begin
          amount = i;
          #1;
          if (out_row != gold_out_row[i])
            $display("golden (%h) != computed (%h)", gold_out_row[i], out_row);
      end
      $finish;
    end
endmodule
