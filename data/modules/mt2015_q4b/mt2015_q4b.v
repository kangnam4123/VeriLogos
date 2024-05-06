module mt2015_q4b(
	input x,
	input y,
	output z);
 
	assign z = ~(x^y);
	
endmodule