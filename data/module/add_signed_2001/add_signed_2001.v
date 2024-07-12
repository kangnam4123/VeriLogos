module add_signed_2001 (
	input signed [2:0] A,
	input signed [2:0] B,
	output signed [3:0] Sum  
	);
	assign Sum = A + B;
endmodule