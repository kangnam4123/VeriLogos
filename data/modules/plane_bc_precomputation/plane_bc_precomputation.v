module plane_bc_precomputation (HV_in,IsLuma,bc_out);
	input [14:0] HV_in;
	input IsLuma;
	output [11:0] bc_out;
	wire [16:0] multiply_4or16;
	wire [16:0] product;
	wire [5:0] addend;
	wire [16:0] sum;
	assign multiply_4or16 = (IsLuma)? {HV_in,2'b0}:{HV_in[12:0],4'b0};
	assign product = multiply_4or16 + {{2{HV_in[14]}},HV_in};
	assign addend = (IsLuma)? 6'b100000:6'b010000;	
	assign sum = product + addend;
	assign bc_out = (IsLuma)? {sum[16],sum[16:6]}:sum[16:5];  
endmodule