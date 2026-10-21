// Author: Lorenzo Casalino
// Website: doktorc.github.io

// Testbench for the xtime hardware module

module tb_xtime();

  logic [7:0] in_byte, out_byte, gold_out_byte;
  logic [15:0] vectors[256];

  xtime dut(in_byte, out_byte);
  
  initial
    begin
      $readmemb("tb_xtime.mem", vectors);
      for (int i = 0; i < 256; i++)
        begin
          {in_byte, gold_out_byte} = vectors[i];
          if (gold_out_byte != out_byte)
            $display("gold (%h) != out (%h)", gold_out_byte, out_byte);
        end
      $finish
    end
endmodule
