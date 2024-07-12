module prgm_cnt #(parameter word_sz=8) 
	(	output reg [word_sz-1:0] count,
		input [word_sz-1:0] data_in,
		input load_pc, inc_pc,
		input clk, rst);
	always @(posedge clk or negedge rst)
		if (~rst)
			count <= 0;
		else if (load_pc)
			count <= data_in;
		else if (inc_pc)
			count <= count + 1;
endmodule