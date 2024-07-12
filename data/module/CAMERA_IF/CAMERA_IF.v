module CAMERA_IF(	
					avs_s1_clk,
					avs_s1_address,
					avs_s1_readdata,
					avs_s1_read,
					avs_s1_writedata,
					avs_s1_write,
					avs_s1_reset,
					avs_s1_export_clk,
					avs_s1_export_address,
					avs_s1_export_readdata,
					avs_s1_export_read,
					avs_s1_export_writedata,
					avs_s1_export_write,
					avs_s1_export_reset
				 );
input				avs_s1_clk;
input	[1:0]		avs_s1_address;
output	[31:0]		avs_s1_readdata;
input				avs_s1_read;
input	[31:0]		avs_s1_writedata;
input				avs_s1_write;
input				avs_s1_reset;
output				avs_s1_export_clk;
output	[1:0]		avs_s1_export_address;
input	[31:0]		avs_s1_export_readdata;
output				avs_s1_export_read;
output	[31:0]		avs_s1_export_writedata;
output				avs_s1_export_write;
output				avs_s1_export_reset;
assign	avs_s1_export_clk = avs_s1_clk;
assign	avs_s1_export_address = avs_s1_address;
assign	avs_s1_readdata = avs_s1_export_readdata;
assign	avs_s1_export_read = avs_s1_read;
assign	avs_s1_export_writedata = avs_s1_writedata;
assign	avs_s1_export_write = avs_s1_write;
assign	avs_s1_export_reset = avs_s1_reset;
endmodule