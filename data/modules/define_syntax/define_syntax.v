module define_syntax (a,b,c);
	input a;
	input b;
	output c;
	wire c_wire;
	assign c = c_wire;
	`ifdef and_module
		assign c_wire = a & b;
	`elsif or_module
		assign c_wire = a | b;
	`else
		assign c_wire = a ^ b;
	`endif
endmodule