module ad_perfect_shuffle #(
  parameter NUM_GROUPS = 2,
  parameter WORDS_PER_GROUP = 2,
  parameter WORD_WIDTH = 8
) (
  input [NUM_GROUPS*WORDS_PER_GROUP*WORD_WIDTH-1:0] data_in,
  output [NUM_GROUPS*WORDS_PER_GROUP*WORD_WIDTH-1:0] data_out
);
  generate
    genvar i;
    genvar j;
    for (i = 0; i < NUM_GROUPS; i = i + 1) begin: shuffle_outer
      for (j = 0; j < WORDS_PER_GROUP; j = j + 1) begin: shuffle_inner
        localparam src_lsb = (j + i * WORDS_PER_GROUP) * WORD_WIDTH;
        localparam dst_lsb = (i + j * NUM_GROUPS) * WORD_WIDTH;
        assign data_out[dst_lsb+:WORD_WIDTH] = data_in[src_lsb+:WORD_WIDTH];
      end
    end
  endgenerate
endmodule