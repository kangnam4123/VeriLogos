module mt2015_q4(
	input x,
	input y,
	output z);
 
	assign z = x|~y;
	
endmodule