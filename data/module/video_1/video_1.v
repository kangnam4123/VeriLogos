module video_1(
	input clk_i,
	output hsync,
	output vsync,
	output de,
	output clk_o,
	output [7:0] r,
	output [7:0] g,
	output [7:0] b,
	output [15:0] A_o,
	input [7:0] D_i,
	input [15:0] video_offset_i
	);
	parameter offset_x = 80;
	parameter offset_y = 100;
	reg [10:0] hor = 0;
	reg [9:0] ver = 0;
	reg [10:0] pixel_x;
	reg [9:0] pixel_y;
	reg [15:0] video_offset;
	reg [15:0] video_offset_delay;
	reg [15:0] A = 0;
	reg [7:0] rs = 0;
	reg [7:0] gs = 0;
	reg [7:0] bs = 0;
	assign A_o = A;
	always @(negedge clk_i) video_offset_delay <= video_offset_i;
	always @(negedge clk_i)
	begin
		if( hor < 11'd1056 )
			hor <= hor + 1'b1;
		else begin
			hor <= 11'd0;
			if( ver < 628 )
			begin
				ver <= ver + 1'b1;
				bs <= bs - 1'b1;
			end else begin
				ver <= 0;
				bs <= 0;
				video_offset = video_offset_delay;
			end
		end
	end
	assign de = (hor >= 216) && (hor < 1016) && (ver >= 27) && (ver < 627);
	assign hsync = (hor < 128);	
	assign vsync = (ver < 4);		
	assign clk_o = clk_i;
	always @(posedge clk_i)
	begin
		pixel_x <= hor - 11'd208;	
		pixel_y <= ver - 10'd27 - offset_y;
	end
	wire [8:0] row = pixel_y[9:1];	
	wire [10:0] Ay = (row[7:3] * 80);
	wire [10:0] Axy = Ay + pixel_x[9:3];	
	wire [10:0] Atotal = Axy + video_offset[10:0];
	always @(negedge clk_i) A <= {video_offset[15:14], row[2:0], Atotal};
	reg [0:7] pixels;
	always @(negedge clk_i)
		if ( pixel_x[2:0] == 3'd0 )
			pixels <= 
				{
					D_i[7] | D_i[3], D_i[7] | D_i[3],
					D_i[6] | D_i[2], D_i[6] | D_i[2],
					D_i[5] | D_i[1], D_i[5] | D_i[1],
					D_i[4] | D_i[0], D_i[4] | D_i[0]
				};
		else
			pixels <= {pixels[1:7],1'b0};	
	wire en = de && (pixel_x < 10'd648) && (pixel_y < 10'd400);
	assign r = (en) ? ((pixels[0]) ? 8'hf8 : 8'h0) : 8'd0;
	assign g = (en) ? ((pixels[0]) ? 8'hf8 : 8'h0) : 8'd0;
	assign b = (en) ? ((pixels[0]) ? 8'h00 : 8'h7d) : 8'd0;
endmodule