module de3d_tc_fmt
	(
	input		de_clk,
	input	[5:0]	tsize,	
	output reg  	[2:0]   bpt,            
	output reg	[4:0]	tfmt,		
	 output                 pal_mode   
	);
parameter	ONE		=	3'h0,
		TWO		=	3'h1,
		FOUR		=	3'h2,
		EIGHT		=	3'h3,
		SIXTEEN		=	3'h4,
		THIRTY_TWO	=	3'h5,
		FMT_1555	=	5'd0,
		FMT_0565	=	5'd1,
		FMT_4444	=	5'd2,
		FMT_8888	=	5'd3,
		FMT_8332	=	5'd4,
		FMT_1232	=	5'd5,
		FMT_0332	=	5'd6,
 		ALPHA4		=	5'd7,
		ALPHA8		=	5'd8,
		LUM4		=	5'd9,
		LUM8		=	5'd10,
		LUM4_ALPHA4	=	5'd11,
		LUM6_ALPHA2	=	5'd12,
		LUM8_ALPHA8	=	5'd13,
		INT4		=	5'd14,
		INT8		=	5'd15,
		RGBA2		=	5'd16;
always @(posedge de_clk) begin
  casex (tsize) 
    6'b000000, 6'b000001, 6'b000010, 6'b000011, 
    6'b011000:					bpt = ONE;
    6'b000100, 6'b000101, 6'b000110, 6'b000111,
    6'b011001:					bpt = TWO;
    6'b100000, 6'b100100, 6'b101100, 6'b001000,
    6'b001001, 6'b001010, 6'b001011, 6'b011010:	bpt = FOUR;
    6'b100001, 6'b100101, 6'b101000, 6'b101001,
    6'b101101, 6'b110000, 6'b001100, 6'b001101,
    6'b001110, 6'b001111, 6'b011100, 6'b011101,
    6'b111110, 6'b111111, 6'b011110: 		bpt = EIGHT;
    6'b101010, 6'b010000, 6'b010001, 6'b010010,
    6'b010011:					bpt = SIXTEEN;
    default: bpt = THIRTY_TWO;
  endcase
end
always @(posedge de_clk) begin
  casex (tsize) 
    6'b000000, 6'b000100, 6'b001000, 6'b001110, 
    6'b010001: 					tfmt = FMT_1555;
    6'b000001, 6'b000101, 6'b001001, 6'b001111, 
    6'b010010:           			tfmt = FMT_0565;
    6'b000010, 6'b000110, 6'b001010, 6'b011100, 
    6'b010000: 			                tfmt = FMT_4444;
    6'b000011, 6'b000111, 6'b001011, 6'b011101, 
    6'b010100, 6'b111110, 6'b111111:   		tfmt = FMT_8888;
    6'b011110, 6'b010011, 6'b011000, 6'b011001, 
    6'b011010:					tfmt = FMT_8332;
    6'b001100:					tfmt = FMT_1232;
    6'b001101:					tfmt = FMT_0332;
    6'b100000:					tfmt = ALPHA4;
    6'b100001:					tfmt = ALPHA8;
    6'b100100:					tfmt = LUM4;
    6'b100101:					tfmt = LUM8;
    6'b101000:					tfmt = LUM4_ALPHA4;
    6'b101001:					tfmt = LUM6_ALPHA2;
    6'b101010:					tfmt = LUM8_ALPHA8;
    6'b101100:					tfmt = INT4;
    6'b101101:					tfmt = INT8;
    default:					tfmt = RGBA2;
  endcase
end
  assign pal_mode = (tsize == 6'h00) | |(tsize == 6'h01) || (tsize == 6'h02) || (tsize == 6'h03) ||
		    (tsize == 6'h04) | |(tsize == 6'h05) || (tsize == 6'h06) || (tsize == 6'h07) ||
		    (tsize == 6'h08) | |(tsize == 6'h09) || (tsize == 6'h0A) || (tsize == 6'h0B) ||
		    (tsize == 6'h18) | |(tsize == 6'h19) || (tsize == 6'h1A) || (tsize == 6'h0E) ||
		    (tsize == 6'h1A) | |(tsize == 6'h0F) || (tsize == 6'h1C) || (tsize == 6'h1D) ||		  
		    (tsize == 6'h3E) | |(tsize == 6'h3F) || (tsize == 6'h1E);
endmodule