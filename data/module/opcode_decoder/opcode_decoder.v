module opcode_decoder(code_in, code_out);
	input [4:0] code_in;
	output [5:0] code_out;
	wire [5:0] code_out;
	and(code_out[0], ~code_in[0], ~code_in[1], ~code_in[2], ~code_in[3], ~code_in[4]); 
	and(code_out[1],  code_in[0], ~code_in[1], ~code_in[2], ~code_in[3], ~code_in[4]); 
	and(code_out[2], ~code_in[0],  code_in[1], ~code_in[2], ~code_in[3], ~code_in[4]); 
	and(code_out[3],  code_in[0],  code_in[1], ~code_in[2], ~code_in[3], ~code_in[4]); 
	and(code_out[4], ~code_in[0], ~code_in[1],  code_in[2], ~code_in[3], ~code_in[4]); 
	and(code_out[5],  code_in[0], ~code_in[1],  code_in[2], ~code_in[3], ~code_in[4]); 
endmodule