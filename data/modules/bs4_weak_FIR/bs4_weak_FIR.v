module bs4_weak_FIR (a,b,c,out);
	input [7:0] a,b,c;
	output [7:0] out;
	wire [8:0] a_x2;
	assign a_x2 = {a,1'b0};
	wire [8:0] sum_bc;
	assign sum_bc = b + c;
	wire [9:0] out_tmp;
	assign out_tmp = (a_x2 + sum_bc) + 2;
	assign out = out_tmp[9:2];
endmodule