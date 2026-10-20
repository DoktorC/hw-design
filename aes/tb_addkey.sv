// Author: Lorenzo Casalino
// Website: doktorc.github.io

// Testbench for the addKey hardware module

module tb_addkey();

  logic [7:0] in_byte, in_key, out_byte, gold_out_byte;

  addKey dut(in_byte, in_key, out_byte);

  initial
    begin
      for (int i = 0; i < 256; i++)
        for (int j = 0; j < 256; j++)
          begin
            // Stimuli and golden output generation
            in_byte = i; in_key = j; gold_out_byte = in_byte ^ in_key;
            #1;
            if (out_byte != gold_out_byte)
              $display("golden (%h) != computed (%h)", gold_out_byte, out_byte);
          end
    end
endmodule
