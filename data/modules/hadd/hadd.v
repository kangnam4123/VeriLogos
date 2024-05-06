module hadd (
	input a,
	input b,
	output sum,
	output cout
);
 
	assign {cout, sum} = a+b;
	
endmodule