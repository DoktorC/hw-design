// Author: Lorenzo Casalino
// Website: doktorc.github.io
// Testbench for the MixCol hardware module

module tb_mixcol();

  logic [31:0] in_col, out_col, gold_out_col;
  logic [63:0] vectors[5];

  mix_col dut(in_col, out_col);
  
  initial
    begin
      $readmemh("tb_mixcol.mem", vectors);
      for (int i = 0; i < 5; i++)
        begin
          {in_col, gold_out_col} = vectors[i];
          #1;
          if (gold_out_col != out_col)
            $display("in (%d) => gold (%h) != out (%h)", i, gold_out_col, out_col);
        end
      $finish;
    end
endmodule
