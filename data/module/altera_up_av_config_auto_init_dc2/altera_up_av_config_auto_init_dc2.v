module altera_up_av_config_auto_init_dc2 (
	rom_address,
	rom_data
);
parameter DC_ROW_START			= 16'h000C;
parameter DC_COLUMN_START		= 16'h001E;
parameter DC_ROW_WIDTH			= 16'h0400;
parameter DC_COLUMN_WIDTH		= 16'h0500;
parameter DC_H_BLANK_B			= 16'h0088; 
parameter DC_V_BLANK_B			= 16'h0019; 
parameter DC_H_BLANK_A			= 16'h00C6;
parameter DC_V_BLANK_A			= 16'h0019;
parameter DC_SHUTTER_WIDTH		= 16'h0432;
parameter DC_ROW_SPEED			= 16'h0011;
parameter DC_EXTRA_DELAY		= 16'h0000;
parameter DC_SHUTTER_DELAY		= 16'h0000;
parameter DC_RESET				= 16'h0008;
parameter DC_FRAME_VALID		= 16'h0000;
parameter DC_READ_MODE_B		= 16'h0001;
parameter DC_READ_MODE_A		= 16'h040C;
parameter DC_DARK_COL_ROW		= 16'h0129;
parameter DC_FLASH				= 16'h0608;
parameter DC_GREEN_GAIN_1		= 16'h00B0;
parameter DC_BLUE_GAIN			= 16'h00CF;
parameter DC_RED_GAIN			= 16'h00CF;
parameter DC_GREEN_GAIN_2		= 16'h00B0;
parameter DC_CONTEXT_CTRL		= 16'h000B;
input			[ 4: 0]	rom_address;
output		[35: 0]	rom_data;
reg			[31: 0]	data;
assign rom_data = {data[31:24], 1'b0, 
						data[23:16], 1'b0, 
						data[15: 8], 1'b0, 
						data[ 7: 0], 1'b0};
always @(*)
begin
	case (rom_address)
	0		:	data	<=	{8'hBA, 8'h01, DC_ROW_START};
	1		:	data	<=	{8'hBA, 8'h02, DC_COLUMN_START};
	2		:	data	<=	{8'hBA, 8'h03, DC_ROW_WIDTH};
	3		:	data	<=	{8'hBA, 8'h04, DC_COLUMN_WIDTH};
	4		:	data	<=	{8'hBA, 8'h05, DC_H_BLANK_B};
	5		:	data	<=	{8'hBA, 8'h06, DC_V_BLANK_B};
	6		:	data	<=	{8'hBA, 8'h07, DC_H_BLANK_A};
	7		:	data	<=	{8'hBA, 8'h08, DC_V_BLANK_A};
	8		:	data	<=	{8'hBA, 8'h09, DC_SHUTTER_WIDTH};
	9		:	data	<=	{8'hBA, 8'h0A, DC_ROW_SPEED};
	10		:	data	<=	{8'hBA, 8'h0B, DC_EXTRA_DELAY};
	11		:	data	<=	{8'hBA, 8'h0C, DC_SHUTTER_DELAY};
	12		:	data	<=	{8'hBA, 8'h0D, DC_RESET};
	13		:	data	<=	{8'hBA, 8'h1F, DC_FRAME_VALID};
	14		:	data	<=	{8'hBA, 8'h20, DC_READ_MODE_B};
	15		:	data	<=	{8'hBA, 8'h21, DC_READ_MODE_A};
	16		:	data	<=	{8'hBA, 8'h22, DC_DARK_COL_ROW};
	17		:	data	<=	{8'hBA, 8'h23, DC_FLASH};
	18		:	data	<=	{8'hBA, 8'h2B, DC_GREEN_GAIN_1};
	19		:	data	<=	{8'hBA, 8'h2C, DC_BLUE_GAIN};
	20		:	data	<=	{8'hBA, 8'h2D, DC_RED_GAIN};
	21		:	data	<=	{8'hBA, 8'h2E, DC_GREEN_GAIN_2};
	22		:	data	<=	{8'hBA, 8'hC8, DC_CONTEXT_CTRL};
	default	:	data	<=	32'h00000000;
	endcase
end
endmodule