// Author: Lorenzo Casalino
// Website: doktorc.github.io

// Testbench for the `divide-by-three' module

module tb_div_by_three();
  logic clk, reset, y;

  // The `counter` signal counts the number of elapsed clock cycles.
  logic [31:0] counter;

  // Instantiate module under test
  div_by_three dut(clk, reset, y);

  // Clock generation
  // The `clk` signal is part of the sensitivity list of the `always` block.
  // A change `clk` trigger the re-evaluation of the `always` block, generating
  // the periodic signal.
  always
    begin
      clk = 1; #5; clk = 0; #5;
    end

  initial
    begin
      // Reset clock cycle counter
      counter = 0;
      // Reset module' state
      reset = 1; #8; reset = 0;
    end

  // Check output correctness on clock's falling edge.
  // Checking on the rising edge will trigger an error, as `y` is not updated
  // yet.
  always@(negedge clk)
    begin
        if (~reset)
        begin
          counter = counter + 1;
          if (y == 1)
              assert (counter % 3 == 0)
              else
                begin
                  $error("Error in the simulation (clk cycle #%b, y = %b)", counter, y);
                  $finish;
                end
          else
              assert (counter % 3)
              else
                begin
                  $error("Error in the simulation (clk cycle #%b, y = %b)", counter, y);
                  $finish;
                end
        end
    end

endmodule
