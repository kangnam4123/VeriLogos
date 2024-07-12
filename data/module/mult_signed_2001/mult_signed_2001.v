module mult_signed_2001 (
	input signed [2:0] a,
	input signed [2:0] b,
	output signed [5:0] prod  
	);
	assign prod = a*b;
endmodule