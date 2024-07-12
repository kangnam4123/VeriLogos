module data_multiplexer(
	input [1:0] selector,
	input [7:0] Din1,
	input [7:0] Din2,
	output [7:0] Dout
);
	assign Dout = 	(selector == 2'd01) ? Din1 : 
						(selector == 2'd02) ? Din2 :
						8'b1;
endmodule