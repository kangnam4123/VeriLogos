module mux_4ch #(parameter word_sz=8)
	(	output [word_sz-1:0] mux_out,
		input [word_sz-1:0] data_a, data_b, data_c, data_d,
		input [1:0]sel);
	assign mux_out = (sel == 0) ? data_a :
			 (sel == 1) ? data_b :
			 (sel == 3) ? data_c :
			 (sel == 4) ? data_d : 'bx;
endmodule