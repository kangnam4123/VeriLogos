module support_io_if(
	input 			clk_i,
	input [7:0] 	A_i,
	input [7:0] 	D_i,
	output [7:0] 	D_o,
	input				nrd_i,
	input				nwr_i,
	input				niorq_i,
	output			clk_o,
	output [3:0]	A_o,
	output [15:0]	nrd_o,		
	output [15:0]	nwr_o,		
	output [7:0]	io_o,		
	input [8*16-1:0] io_i,	
	input  			ack_i,	
	output [15:0]	we_o,		
	output [15:0]	stb_o,		
	output [7:0]	adr_o,	
	output [7:0]	dat_o		
);
	wire io_nwr, io_nrd;
	wire [3:0] a_decode, b_decode;
	wire [15:0] four_to_sixteen;
	reg [15:0]		wb_we		= 0;
	reg [15:0]		wb_stb	= 0;
	reg [7:0]		wb_adr = 8'hff;
	reg [7:0]		wb_dat = 8'hff;
	assign clk_o = clk_i;	
	assign io_nwr = niorq_i | nwr_i;
	assign io_nrd = niorq_i | nrd_i;
	assign a_decode = A_i[7:4];
	assign b_decode = A_i[3:0];
	assign io_o = D_i;
	assign we_o = wb_we;
	assign stb_o = wb_stb;
	assign adr_o = wb_adr;
	assign dat_o = wb_dat;
	assign four_to_sixteen = {
				(a_decode != 4'd15),
				(a_decode != 4'd14),
				(a_decode != 4'd13),
				(a_decode != 4'd12),
				(a_decode != 4'd11),
				(a_decode != 4'd10),
				(a_decode != 4'd9),
				(a_decode != 4'd8),
				(a_decode != 4'd7),
				(a_decode != 4'd6),
				(a_decode != 4'd5),
				(a_decode != 4'd4),
				(a_decode != 4'd3),
				(a_decode != 4'd2),
				(a_decode != 4'd1),
				(a_decode != 4'd0)
			};
	assign nwr_o = (io_nwr) ? 16'hffff : four_to_sixteen;
	assign nrd_o = (io_nrd) ? 16'hffff : four_to_sixteen;
	assign A_o = b_decode;		
	assign D_o = (!four_to_sixteen[0]) ? io_i[16*8-1:15*8] :
					 (!four_to_sixteen[1]) ? io_i[15*8-1:14*8] :
					 (!four_to_sixteen[2]) ? io_i[14*8-1:13*8] :
					 (!four_to_sixteen[3]) ? io_i[13*8-1:12*8] :
					 (!four_to_sixteen[4]) ? io_i[12*8-1:11*8] :
					 (!four_to_sixteen[5]) ? io_i[11*8-1:10*8] :
					 (!four_to_sixteen[6]) ? io_i[10*8-1:9*8] :
					 (!four_to_sixteen[7]) ? io_i[9*8-1:8*8] :
					 (!four_to_sixteen[8]) ? io_i[8*8-1:7*8] :
					 (!four_to_sixteen[9]) ? io_i[7*8-1:6*8] :
					 (!four_to_sixteen[10]) ? io_i[6*8-1:5*8] :
					 (!four_to_sixteen[11]) ? io_i[5*8-1:4*8] :
					 (!four_to_sixteen[12]) ? io_i[4*8-1:3*8] :
					 (!four_to_sixteen[13]) ? io_i[3*8-1:2*8] :
					 (!four_to_sixteen[14]) ? io_i[2*8-1:1*8] :
					 (!four_to_sixteen[15]) ? io_i[1*8-1:0*8] :
					 8'hff;
	wire is_rd = !(nrd_o == 16'hffff);
	wire is_wr = !(nwr_o == 16'hffff);
	reg track_rd, track_wr;
	wire rd_rise = ({track_rd,is_rd} == 2'b01);
	wire wr_rise = ({track_wr,is_wr} == 2'b01);
	reg [1:0] track_ack_res = 0;
	always @(negedge clk_i) track_ack_res = {track_ack_res[0], !(is_rd | is_wr)};
	wire force_ack = (track_ack_res == 2'd0);
	always @(negedge clk_i)
	begin
		track_rd <= is_rd;
		track_wr <= is_wr;
	end
	always @(posedge clk_i)
	begin
		if( ack_i | force_ack )	
		begin
			wb_stb <= 16'b0;			
			wb_we <= 16'b0;
		end
		else begin
			if( rd_rise | wr_rise )
			begin
				wb_adr <= A_i;
				wb_dat <= D_i;
				wb_stb[a_decode] <= 1'b1;
				wb_we[a_decode] <= is_wr;
			end
		end
	end
endmodule