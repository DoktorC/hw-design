// Author: Lorenzo Casalino
// Website: doktorc.github.io

// Fully combinatorial implementation of the AES-128 primitive.

module addKey(input  logic [7:0] in_byte,
              input  logic [7:0] in_key,
              output logic [7:0] out_byte);
  assign out_byte = in_byte ^ in_key;
endmodule

module aes(input  logic [127:0] plaintext,
           input  logic [127:0] round_keys [11],
           output logic [127:0] ciphertext [11]);

  logic [127:0] state [11];

  genvar i;
  generate
    for (i = 0; i < 16; i++)
      addKey addKey0(round_keys[0][8 * (i + 1) - 1:8 * i],
                     plaintext[8 * (i + 1) - 1:8 * i],
                     state[0][8 * (i + 1) - 1:8 * i]
                     );
  endgenerate

  generate
    for (i = 0; i < 11; i++)
      assign ciphertext[i] = state[i];
  endgenerate
endmodule
