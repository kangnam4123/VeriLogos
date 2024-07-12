module norflash32 #(
	parameter adr_width = 21 
) (
	input sys_clk,
	input sys_rst,
	input [31:0] wb_adr_i,
	output reg [31:0] wb_dat_o,
	input wb_stb_i,
	input wb_cyc_i,
	output reg wb_ack_o,
	output reg [adr_width-1:0] flash_adr,
	input [31:0] flash_d
);
always @(posedge sys_clk) begin
	if(wb_cyc_i & wb_stb_i) 
		flash_adr <= wb_adr_i[adr_width+1:2];
	wb_dat_o <= flash_d;
end
reg [3:0] counter;
always @(posedge sys_clk) begin
	if(sys_rst)
		counter <= 4'd1;
	else begin
		if(wb_cyc_i & wb_stb_i)
			counter <= counter + 4'd1;
		wb_ack_o <= &counter;
	end
end
endmodule