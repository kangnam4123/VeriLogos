module tvm_vpi_read_mmap
  #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8,
    parameter BASE_ADDR_WIDTH = 32
    )
   (
    input                       clk,
    input                       rst,
    input [ADDR_WIDTH-1:0]      addr, 
    output [DATA_WIDTH-1:0]     data_out, 
    input [BASE_ADDR_WIDTH-1:0] mmap_addr 
    );
   reg [DATA_WIDTH-1:0]         reg_data;
   assign data_out = reg_data;
endmodule