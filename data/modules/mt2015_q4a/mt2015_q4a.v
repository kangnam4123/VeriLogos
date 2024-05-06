module mt2015_q4a(
	input x,
	input y,
	output z);
 
	assign z = (x^y) & x;
	
endmodule