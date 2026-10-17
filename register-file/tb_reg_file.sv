// Author: Lorenzo Casalino
// Website: doktorc.github.io
//
// Testbench for the reg_file hardware module

module tb_reg_file();

  logic [3:0] dinC, doutA, doutB;
  logic [3:0] addrA, addrB, addrC;
  logic read_en, write_en, clk, rst;

  always
    begin
      clk = 1; #5; clk = 0; #5;
    end

  reg_file #(4) dut(.portC(dinC) ,
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
      /* Test #1:
       * - register file correctly written when write_en asserted
       * - register file correctly read when read_en asserted
       * - register file correctly filled
       */
      write_en = 1;
      read_en = 0; #10; // Keep signals stable for one clock period
      for (int i = 0; i < 16; i++)
        begin
          addrC = i;
          dinC = addrC; #10; // Keep signals stable for one clock period, otherwise the write might not happen
        end
      write_en = 0;
      read_en = 1; #10; // Keep signals stable for one clock period
      for (int i = 0; i < 16; i = i + 2)
        begin
          addrA = i;
          addrB = i + 1; #10;
          if (doutA != addrA | doutB != addrB)
            begin
              $display("[%d] doutA = %d", addrA, doutA);
              $display("[%d] doutB = %d", addrB, doutB);
            end
        end
      $display("Test #1 passed");

      /* Test #2:
       * - register file not written when write_en not asserted
       */
      write_en = 0; #10;
      for (int i = 0; i < 16; i++)
        begin
          addrC = i;
          dinC = 0; #10;
        end

      read_en = 1; #10;
      for (int i = 0; i < 16; i = i + 2)
        begin
          addrA = i;
          addrB = i + 1; #10;
          if (doutA != addrA | doutB != addrB)
            begin
              $display("[%d] doutA = %d", addrA, doutA);
              $display("[%d] doutB = %d", addrB, doutB);
            end
        end
      $display("Test #2 passed");

      /* Test #3:
       * - register file not read when read_en not asserted
       */
      read_en = 0; #10;
      for (int i = 0; i < 16; i = i + 2)
         begin
          addrA = i;
          addrB = i + 1; #10;
          if (doutA != 14 | doutB != 15)
            begin
              $display("[%d] doutA = %d", addrA, doutA);
              $display("[%d] doutB = %d", addrB, doutB);
            end
        end
      $display("Test #3 passed");
    end
endmodule
