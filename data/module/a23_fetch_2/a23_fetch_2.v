module a23_fetch_2
(
input                       i_clk,
input                       i_rst,
input       [31:0]          i_address,
input       [31:0]          i_address_nxt,      
input       [31:0]          i_write_data,
input                       i_write_enable,
output       [31:0]         o_read_data,
input       [3:0]           i_byte_enable,
input                       i_cache_enable,     
input                       i_cache_flush,      
input       [31:0]          i_cacheable_area,   
output   [31:0]             o_m_address, 
output   [31:0]             o_m_write,
output                      o_m_write_en,
output   [3:0]              o_m_byte_enable,
input    [31:0]             i_m_read
);
assign o_m_address     = i_address;
assign o_m_write       = i_write_data;
assign o_m_write_en    = i_write_enable;
assign o_m_byte_enable = i_byte_enable;
assign o_read_data     = i_m_read;
endmodule