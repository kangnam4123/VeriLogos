module block_ram_1 #(parameter DATA_WIDTH=4, ADDRESS_WIDTH=10)
   (input  wire                      write_enable, clk,
    input  wire  [DATA_WIDTH-1:0]    data_in,
    input  wire  [ADDRESS_WIDTH-1:0] address_in,
    output wire  [DATA_WIDTH-1:0]    data_out);
   localparam WORD  = (DATA_WIDTH-1);
   localparam DEPTH = (2**ADDRESS_WIDTH-1);
   reg [WORD:0] data_out_r;
   reg [WORD:0] memory [0:DEPTH];
   always @(posedge clk) begin
      if (write_enable)
        memory[address_in] <= data_in;
      data_out_r <= memory[address_in];
   end
   assign data_out = data_out_r;
endmodule