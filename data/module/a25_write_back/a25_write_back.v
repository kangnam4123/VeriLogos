module a25_write_back(
			i_clk,
			i_mem_stall,                
			i_mem_read_data,          
			i_mem_read_data_valid,    
			i_mem_load_rd,           
			o_wb_read_data,           
			o_wb_read_data_valid,     
			o_wb_load_rd,           
			i_daddress,
			);
input                       i_clk;
input                       i_mem_stall;                
input       [31:0]          i_mem_read_data;            
input                       i_mem_read_data_valid;      
input       [10:0]          i_mem_load_rd;              
output      [31:0]          o_wb_read_data;            
output                      o_wb_read_data_valid;    
output      [10:0]          o_wb_load_rd;              
input       [31:0]          i_daddress;
reg  [31:0]         mem_read_data_r = 32'd0;          
reg                 mem_read_data_valid_r = 1'd0;    
reg  [10:0]         mem_load_rd_r = 11'd0;            
assign o_wb_read_data       = mem_read_data_r;
assign o_wb_read_data_valid = mem_read_data_valid_r;
assign o_wb_load_rd         = mem_load_rd_r;
always @( posedge i_clk )
    if ( !i_mem_stall )
        begin                                                                                                             
        mem_read_data_r         <= i_mem_read_data;
        mem_read_data_valid_r   <= i_mem_read_data_valid;
        mem_load_rd_r           <= i_mem_load_rd;
        end
reg  [31:0]         daddress_r = 32'd0;               
always @( posedge i_clk )
    if ( !i_mem_stall )
        daddress_r              <= i_daddress;
endmodule