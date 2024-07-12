module tvm_vpi_mem_interface
  #(
    parameter READ_WIDTH = 8,
    parameter WRITE_WIDTH = 8,
    parameter ADDR_WIDTH = 32,
    parameter SIZE_WIDTH = 32
    )
   (
    input                   clk,
    input                   rst,
    input                   read_en, 
    output [READ_WIDTH-1:0] read_data_out, 
    output                  read_data_valid, 
    input                   write_en, 
    input [WRITE_WIDTH-1:0] write_data_in, 
    output                  write_data_ready, 
    input                   host_read_req,   
    input [ADDR_WIDTH-1:0]  host_read_addr,  
    input [SIZE_WIDTH-1:0]  host_read_size,  
    input                   host_write_req,  
    input [ADDR_WIDTH-1:0]  host_write_addr, 
    input [SIZE_WIDTH-1:0]  host_write_size  
    );
   reg [READ_WIDTH-1:0]    reg_read_data;
   reg                     reg_read_valid;
   reg                     reg_write_ready;
   assign read_data_out = reg_read_data;
   assign read_data_valid = reg_read_valid;
   assign write_data_ready = reg_write_ready;
endmodule