module registerfile_io32 (
		input  wire        clk,             
		input  wire        slave_read,      
		input  wire        slave_write,     
		input  wire  [5:0]slave_address,    
		output wire [31:0] slave_readdata,  
		input  wire [31:0] slave_writedata, 
		input  wire        reset,           
		output       atb_read,
		output       atb_write,
		output  [5:0]atb_register,
		input  [31:0]atb_readdata,
		output [31:0]atb_writedata
	);
  assign atb_read  = slave_read;
  assign atb_write = slave_write;
  assign atb_register   = slave_address;
  assign atb_writedata  = slave_writedata;
	assign slave_readdata = atb_readdata;
endmodule