module divisiblebythree(in, out);
	input wire[3: 0] in;
	output wire out;
	assign out = (in == 4'b0000) || (in == 4'b0011) || (in == 4'b0110) || (in == 4'b1001) || (in == 4'b1100) || (in == 4'b1111);
endmodule