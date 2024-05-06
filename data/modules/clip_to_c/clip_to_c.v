module clip_to_c (delta,c,out);
	input [8:0] delta;
	input [4:0] c;		
	output [5:0] out;	
	reg [5:0] out;
	wire [5:0] neg_c;	
	assign neg_c = {1'b1,~c} + 1;
	always @ (delta or c or neg_c)
		if (delta[8] == 1'b0)	
			out <= (delta[7:0] > {3'b0,c})? {1'b0,c}:delta[5:0];
		else					
			out <= (delta[7:0] < {2'b11,neg_c})? {1'b1,neg_c}:delta[5:0];
endmodule