module vgafb_fifo64to16(
	input sys_clk,
	input vga_rst,
	input stb,
	input [63:0] di,
	output do_valid,
	output reg [15:0] do,
	input next 
);
reg [63:0] storage[0:3];
reg [1:0] produce; 
reg [3:0] consume; 
reg [4:0] level;
wire [63:0] do64;
assign do64 = storage[consume[3:2]];
always @(*) begin
	case(consume[1:0])
		2'd0: do <= do64[63:48];
		2'd1: do <= do64[47:32];
		2'd2: do <= do64[31:16];
		2'd3: do <= do64[15:0];
	endcase
end
always @(posedge sys_clk) begin
	if(vga_rst) begin
		produce = 2'd0;
		consume = 4'd0;
		level = 5'd0;
	end else begin
		if(stb) begin
			storage[produce] = di;
			produce = produce + 2'd1;
			level = level + 5'd4;
		end
		if(next) begin 
			consume = consume + 4'd1;
			level = level - 5'd1;
		end
	end
end
assign do_valid = ~(level == 5'd0);
endmodule