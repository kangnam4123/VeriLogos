module calculate_chi_sqr_8 #(parameter K = 5)(
	input wire [10:0] V0, V1, V2, V3, V4, V5,
	input wire en,
	output wire [32:0] chi_sqr
	);
reg [21:0] V_sqr [0:K];
assign chi_sqr =	  (V_sqr[0]<<11) + (V_sqr[0]<<9) + (V_sqr[0]<<7) + (V_sqr[0]<<6) + (V_sqr[0]<<5) + (V_sqr[0]<<4) + (V_sqr[0]<<3) + (V_sqr[0]<<2) 
						+ (V_sqr[1]<<12) + (V_sqr[1]<<10) + (V_sqr[1]<<8) + (V_sqr[1]<<7) + (V_sqr[1]<<3) + (V_sqr[1]<<1) + (V_sqr[1]<<0)
						+ (V_sqr[2]<<12) + (V_sqr[2]<<11) + (V_sqr[2]<<10) + (V_sqr[2]<<7) + (V_sqr[2]<<5) + (V_sqr[2]<<4)  + (V_sqr[2]<<1) 
						+ (V_sqr[3]<<13) + (V_sqr[3]<10) + (V_sqr[3]<<9) + (V_sqr[3]<<8) + (V_sqr[3]<<7) + (V_sqr[3]<<6) + (V_sqr[3]<<2) + (V_sqr[3]<<0)
						+ (V_sqr[4]<<13) + (V_sqr[4]<<12) + (V_sqr[4]<<11) + (V_sqr[4]<<7) + (V_sqr[4]<<6) + (V_sqr[4]<<3) + (V_sqr[4]<<1) 
						+ (V_sqr[5]<<12) + (V_sqr[5]<<11) + (V_sqr[5]<<10) + (V_sqr[5]<<7) + (V_sqr[5]<<4) + (V_sqr[5]<<3) + (V_sqr[5]<<0) ;
always @(*)
	if (en) begin
		V_sqr[0] <= V0 * V0;
		V_sqr[1] <= V1 * V1;
		V_sqr[2] <= V2 * V2;
		V_sqr[3] <= V3 * V3;
		V_sqr[4] <= V4 * V4;
		V_sqr[5] <= V5 * V5;
	end		
endmodule