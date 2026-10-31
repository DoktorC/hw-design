// Author: Lorenzo Casalino
// Website: doktorc.github.io

// Testbench for the shiftrow hardware module

`timescale 1ns/1ps

module tb_shiftrows();
  logic [127:0] in_state, out_state, gold_out_state;
  logic [127:0] vectors[0:54];

  shift_rows dut(in_state, out_state);

  function automatic [127:0] get_in_state(input int round);
    return vectors[round * 5 + 2];
  endfunction

  function automatic [127:0] get_out_state(input int round);
    return vectors[round * 5 + 3];
  endfunction

  initial
    begin
      $readmemh("tb_aes.mem", vectors);
      for (int i = 1; i < 10; i++)
        begin
          in_state = get_in_state(i);
          gold_out_state = get_out_state(i);
          #1;
          if (gold_out_state != out_state)
            begin
              $display("Round #%d", i);
              $display("Input %h", in_state);
              $display("Expected %h", gold_out_state);
              $display("Got %h", out_state);
            end
        end
    end
endmodule
