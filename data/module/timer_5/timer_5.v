module timer_5(
	input  wire clk_24mhz,
	input  wire clk_z80,
	input  wire [2:0] rate,     
	output reg  int_stb
);
	reg [ 2:0] ctr5;
	reg [16:0] ctr128k;
	reg ctrsel;
	reg int_sync1,int_sync2,int_sync3;
	always @(posedge clk_24mhz)
	begin
		if( !ctr5[2] )
			ctr5 <= ctr5 + 3'd1;
		else
			ctr5 <= 3'd0;
	end
	initial
		ctr128k = 'd0;
	always @(posedge clk_24mhz)
	begin
		if( ctr5[2] )
			ctr128k <= ctr128k + 17'd1;
	end
	always @*
	case( rate )
		3'b000: ctrsel = ctr128k[6];
		3'b001: ctrsel = ctr128k[7];
		3'b010: ctrsel = ctr128k[8];
		3'b011: ctrsel = ctr128k[9];
		3'b100: ctrsel = ctr128k[10];
		3'b101: ctrsel = ctr128k[12];
		3'b110: ctrsel = ctr128k[14];
		3'b111: ctrsel = ctr128k[16];
	endcase
	always @(posedge clk_z80)
	begin
		int_sync3 <= int_sync2;
		int_sync2 <= int_sync1;
		int_sync1 <= ctrsel;
	end
	always @(posedge clk_z80)
	if( !int_sync2 && int_sync3 )
		int_stb <= 1'b1;
	else
		int_stb <= 1'b0;
endmodule