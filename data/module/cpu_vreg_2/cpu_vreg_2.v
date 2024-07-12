module cpu_vreg_2(
	input wire clk,
	input wire copy_in_progress,
	input wire close_to_vlank,
	input wire cpu_rd,
	input wire cpu_wr,
	input wire cpu_mreq,
	input wire [15:0] cpu_addr,
	inout wire [7:0] cpu_data,
	output reg back_vram_wr_low,
	output reg back_vram_rd_low,
	output reg [12:0] back_vram_addr,
	output reg [7:0] back_vram_data
	);
assign cpu_data = (cpu_wr == 1 && cpu_rd == 0 && cpu_mreq == 0 && cpu_addr == 16'h92c0) ? copy_in_progress || close_to_vlank : 8'bzzzzzzzz;
always @(posedge clk)
begin
	if(copy_in_progress == 0 && cpu_rd == 1 && cpu_wr == 0 && cpu_mreq == 0 && cpu_addr >= 16'h8000 && cpu_addr <= 16'h92bf) begin
		back_vram_addr = cpu_addr[12:0];
		back_vram_data = cpu_data;
		back_vram_wr_low = 0;
	end	
	else begin
		back_vram_wr_low = 1;
		back_vram_addr = 13'bzzzzzzzzzzzzz;
		back_vram_data = 8'bzzzzzzzz;
	end
end
endmodule