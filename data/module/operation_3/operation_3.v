module operation_3	#(
					  parameter TAG_WIDTH = 2,
					  parameter INVALID_TAG = 2'd0,
					  parameter DATA_TAG0 = 2'd1,
					  parameter DATA_TAG1 = 2'd2,
					  parameter DATA_END_TAG = 2'd3,
					  parameter OPE_WIDTH = 3,
					  parameter DATA_WIDTH = 8 + TAG_WIDTH
					  )(
						input [DATA_WIDTH*OPE_WIDTH*OPE_WIDTH-1:0] data_bus,
						input									   clk,
						input									   rst,
						input									   refresh,
						output [DATA_WIDTH-1:0]					   out
						);
	wire [DATA_WIDTH-1:0]										   d[OPE_WIDTH-1:0][OPE_WIDTH-1:0];
	wire [TAG_WIDTH-1:0]										   tag_in;
	wire [8-1:0]												   i[OPE_WIDTH-1:0][OPE_WIDTH-1:0];
	reg [8-1:0]													   pixel_out;
	reg [TAG_WIDTH-1:0]											   tag_out;
	genvar														   x,y;
	generate	
		for(y = 0; y < OPE_WIDTH; y = y + 1) begin: ope_loop_y
			for(x = 0; x < OPE_WIDTH; x = x + 1) begin: ope_loop_x
				assign d[y][x] = data_bus[(((y*OPE_WIDTH)+x)*DATA_WIDTH)+:DATA_WIDTH];
				assign i[y][x] = d[y][x][0+:8];
			end
		end
	endgenerate
	assign tag_in = d[OPE_WIDTH/2][OPE_WIDTH/2][8+:TAG_WIDTH];
	assign out[8+:TAG_WIDTH] = tag_out;
	assign out[0+:8] = pixel_out;
	always @(posedge clk) begin
		if(rst|refresh) begin
			pixel_out <= 0;
			tag_out <= 0;
		end
		else begin
			pixel_out <= i[OPE_WIDTH/2][OPE_WIDTH/2];
			tag_out <= tag_in;
		end
	end
endmodule